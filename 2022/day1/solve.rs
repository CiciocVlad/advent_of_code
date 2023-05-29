use std::env;
use std::fs;

fn get_max(contents: String) -> i32 {
    let mut sum: i32 = 0;
    let mut mx: i32 = 0;
    for i in contents.split("\n") {
        if mx < sum {
            mx = sum;
        }
        if i != "" {
            sum += i.parse::<i32>().unwrap();
        }
        else {
            sum = 0;
        }
    }

    return mx;
}

struct Max {
    a: i32,
    b: i32,
    c: i32
}

fn get_min<'a>(a: &'a mut i32, b: &'a mut i32, c: &'a mut i32) -> &'a mut i32 {
    if a <= b {
        return if a <= c { a } else { c };
    }
    else if b <= a {
        return if b <= c { b } else { c };
    }
    else {
        return c;
    }
}

fn get_top_3(contents: String) -> Max {
    let mut sum: i32 = 0;
    let mut a: i32 = 0;
    let mut b: i32 = 0;
    let mut c: i32 = 0;

    for i in contents.split("\n") {
        if get_min(&mut a, &mut b, &mut c) < &mut sum {
            *get_min(&mut a, &mut b, &mut c) = sum;
        }
        if i != "" {
            sum += i.parse::<i32>().unwrap();
        }
        else {
            sum = 0;
        }
    }

    return Max { a, b, c };
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let file_name = &args[1];
    
    let contents = fs::read_to_string(file_name).expect("Should have been able to read the file");

    println!("part 1: {}", get_max(contents.clone()));

    let Max { a, b, c } = get_top_3(contents);
    println!("part 2: {}", a + b + c);
}
