use std::env;

fn draw_envelope(w: usize, h: usize) {
    if w < 2 || h < 2 {
        panic!("W and H must be >= 2");
    }

    for r in 0..h {
        let left = if h == 1 {
            0usize
        } else {
            let left_f = (r as f64) * ((w - 1) as f64) / ((h - 1) as f64);
            left_f.round() as usize
        };
        let right = (w - 1) - left;

        let mut line = String::with_capacity(w);
        for c in 0..w {
            let ch = if r == 0 || r == h - 1 {
                '*'
            } else if c == 0 || c == w - 1 {
                '*'
            } else if c == left || c == right {
                '*'
            } else {
                ' '
            };
            line.push(ch);
        }
        println!("{}", line);
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: cargo run -- <W> <H>");
        return;
    }
    let w: usize = args[1].parse().expect("W must be integer");
    let h: usize = args[2].parse().expect("H must be integer");
    draw_envelope(w, h);
}
