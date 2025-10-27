fn draw_envelope(w: usize, h: usize) {
    for r in 0..h {
        let mut line = String::new();
        for c in 0..w {
            if r == 0 || r == h - 1 || c == 0 || c == w - 1 || c == r || c == w - 1 - r {
                line.push('*');
            } else {
                line.push(' ');
            }
        }
        println!("{}", line);
    }
}

fn main() {
    draw_envelope(20, 20);
}