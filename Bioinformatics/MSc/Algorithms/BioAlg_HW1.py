import sys
import numpy as np
import random
import math
import matplotlib.pyplot as plt
from Bio import SeqIO
from io import StringIO


def read_sequence(file_path):
    with open(file_path, 'r') as file:
        content = file.read().strip()
    
    if content.startswith(">"):
        fasta_io = StringIO(content)
        try:
            record = next(SeqIO.parse(fasta_io, "fasta"))
        except StopIteration:
            raise Exception(f"No sequence records found in {file_path}")
        return str(record.seq).upper()
    else:
        return content.replace("\n", "").upper()


def get_random_piece(sequence, avg_length=300):
    # Sample from exp distribution
    piece_length = max(1, int(np.random.exponential(avg_length)))
    max_start = len(sequence) - piece_length
    if max_start < 0:
        return None
    for _ in range(50):
        start = random.randint(0, max_start)
        piece = sequence[start: start+piece_length]
        if all(letter in "ATGC" for letter in piece):
            return piece
    return None


def build_chimeric_sequence(target_length=50000, avg_length=300):
    chimeric_seq = ""
    true_states = ""
    while len(chimeric_seq) < target_length:
        state = random.choice(['1', '2'])
        if state == '1':
            piece = get_random_piece(seq1, avg_length)
        else:
            piece = get_random_piece(seq2, avg_length)
        if piece is None:
            continue
        chimeric_seq += piece
        true_states += state * len(piece)
    chimeric_seq = chimeric_seq[:target_length]
    true_states = true_states[:target_length]
    return chimeric_seq, true_states


def compute_emission_probs(sequence):
    total = len(sequence)
    count_A = sequence.count("A")
    count_T = sequence.count("T")
    count_G = sequence.count("G")
    count_C = sequence.count("C")
    at_freq = (count_A + count_T) / total
    gc_freq = (count_G + count_C) / total
    probs = {
        "A": at_freq / 2,
        "T": at_freq / 2,
        "G": gc_freq / 2,
        "C": gc_freq / 2,
    }
    return probs


def viterbi(obs_seq, states, start_p, trans_p, emis_p_1, emis_p_2):
    n = len(obs_seq)
    V = {}  # V[state][pos] = log probability of path ending with [state] at [pos]
    path = {}

    for state in states:
        emis = emis_p_1 if state == '1' else emis_p_2
        V[state] = [math.log(start_p[state]) + math.log(emis[obs_seq[0]])]
        path[state] = [state]

    for t in range(1, n):
        new_V = {}
        new_path = {}
        symbol = obs_seq[t]
        for curr_state in states:
            emis = emis_p_1 if curr_state == '1' else emis_p_2
            (prob, prev_state) = max(
                (V[prev_state][t-1] + math.log(trans_p[prev_state][curr_state]) + math.log(emis[symbol]), prev_state)
                for prev_state in states
            )
            new_V[curr_state] = V[curr_state] + [prob] if curr_state in V else [prob]
            new_path[curr_state] = path[prev_state] + [curr_state]
        for s in states:
            V[s].append(new_V[s][-1])
            path[s] = new_path[s]

    final_state = max(states, key=lambda s: V[s][-1])
    return "".join(path[final_state])


def viterbi_decoding(obs_seq, states, start_p, trans_p, emis_p_1, emis_p_2):
    n = len(obs_seq)
    viterbi_mat = {s: [float('-inf')] * n for s in states}
    backpointer = {s: [None] * n for s in states}

    for s in states:
        emis = emis_p_1 if s == '1' else emis_p_2
        viterbi_mat[s][0] = math.log(start_p[s]) + math.log(emis[obs_seq[0]])

    for t in range(1, n):
        symbol = obs_seq[t]
        for s in states:
            emis = emis_p_1 if s == '1' else emis_p_2
            max_tr_prob = float('-inf')
            prev_state_selected = None
            for s_prev in states:
                tr_prob = viterbi_mat[s_prev][t-1] + math.log(trans_p[s_prev][s])
                if tr_prob > max_tr_prob:
                    max_tr_prob = tr_prob
                    prev_state_selected = s_prev
            viterbi_mat[s][t] = max_tr_prob + math.log(emis[symbol])
            backpointer[s][t] = prev_state_selected

    final_state = None
    max_prob = float('-inf')
    for s in states:
        if viterbi_mat[s][-1] > max_prob:
            max_prob = viterbi_mat[s][-1]
            final_state = s

    best_path = [final_state]
    for t in range(n-1, 0, -1):
        best_path.insert(0, backpointer[best_path[0]][t])
    return "".join(best_path)


def decode_sequence(observed_seq):
    return viterbi_decoding(observed_seq, states, start_probs, transition_probs,
                              emission_probs_1, emission_probs_2)


def calculate_error_rate(true_states, predicted_states):
    errors = sum(1 for t, p in zip(true_states, predicted_states) if t != p)
    return (errors / len(true_states)) * 100


def get_clean_segment(sequence, seg_length=50000):
    for i in range(0, len(sequence) - seg_length, seg_length//10):
        seg = sequence[i:i+seg_length]
        if all(letter in "ATGC" for letter in seg):
            return seg
    return None

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python code.py file1.fasta file2.fasta")
        sys.exit(1)
    
    file1_path = sys.argv[1]
    file2_path = sys.argv[2]
    
    seq1 = read_sequence(file1_path)
    seq2 = read_sequence(file2_path)
    
    print(f"Genome 1 length: {len(seq1)}")
    print(f"Genome 2 length: {len(seq2)}")

    chimeric_sequence, chimeric_true_states = build_chimeric_sequence(target_length=50000, avg_length=300)
    print(f"Chimeric sequence length: {len(chimeric_sequence)}")

    # Emission probabilities
    emission_probs_1 = compute_emission_probs(seq1)
    emission_probs_2 = compute_emission_probs(seq2)

    print("Emission 1:", emission_probs_1)
    print("Emission 2:", emission_probs_2)

    p_stay = 299 / 300
    p_switch = 1 / 300

    states = ['1', '2']
    transition_probs = {
        '1': {'1': p_stay, '2': p_switch},
        '2': {'1': p_switch, '2': p_stay},
    }

    start_probs = {
        '1': 0.5,
        '2': 0.5,
    }

    predicted_states_chimeric = decode_sequence(chimeric_sequence)
    error_chimeric = calculate_error_rate(chimeric_true_states, predicted_states_chimeric)
    print(f"Chimeric error rate: {error_chimeric:.2f}%")

    with open("predicted_states_chimeric.txt", "w") as f:
        f.write(predicted_states_chimeric)

    seg1 = get_clean_segment(seq1, 50000)
    seg2 = get_clean_segment(seq2, 50000)

    if seg1 is None or seg2 is None:
        raise Exception("Could not find a sufficiently long clean segment in one of the genomes.")

    predicted_seg1 = decode_sequence(seg1)
    predicted_seg2 = decode_sequence(seg2)

    true_seg1 = "1" * len(seg1)
    true_seg2 = "2" * len(seg2)

    error_seg1 = calculate_error_rate(true_seg1, predicted_seg1)
    error_seg2 = calculate_error_rate(true_seg2, predicted_seg2)

    print(f"Genome 1 error rate: {error_seg1:.2f}%")
    print(f"Genome 2 error rate: {error_seg2:.2f}%")
