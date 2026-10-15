Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185D380FD2
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041819; cv=pass; b=c0iC6b5NE+aSrGXDBFFbM2FMUL+HpkJ/IDNLt7WLmgtUSvnFHSSs0Bui2x/DKA/IDxRRrtDMPMC2PC3j6/9rqos7BtWqIp6PcsY2b7E+tj9t4NnIn4EJRbKR2jH0/+tdl7hHGM/cn4BpKxEBB2yJag7CcSo4YUUKhTo/JHbbWWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041819; c=relaxed/simple;
	bh=awMAfsFkqpRY7o2XV7Ve+03jVThwxCOQUyl8p+8mxik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEMy4BgACUiSJDuRkU5EjANghITANL6iWNWwEpLGDwelqAZZtaarwO7FvWFn8HdHDH5k0Gdq6IuLzqSLgwLRC3cfglbio6md65GgtZea8ZSR3BXEDe0tCo/937mQ9Ix0RMLhgRxR7kt8plOd0ycyP+VrYdL8OGHYWo/Cmp+i4Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXwaxwzq; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXwaxwzq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso957092a12.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 22:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792041816; cv=none;
        d=google.com; s=arc-20260327;
        b=OR/FhzmaympCUdkovCfwo8ZdX2Caqg9Jkjz/JDF2sjNb/P/RORApd2L0v6WSyyP5RD
         JzoMWKzrkgLYaB1kgY3SfB38PmoPYtMEHs4f01sxpJq71c80J1ATqwj0tSWGSZ5gZEqo
         mlq/DvtR/QNLpJEuxDwqv2R5Ee9hntt5A8MEHHGfPDWsNyh+PLb0E9bSjxvZxY+SRrn0
         c7GXX1hlUa7AsFz2RASoDtcbz90zOq24Frzrp6StzvXXRIlTxQYyuSTALpX0U0Xa1wlS
         HSeOAqNhnU+zDS/km5Qd4AmgzAyGmtCopEc1vzkABAZBxuS1F1Aw0iWQUTzCbiPlXQHN
         9ssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E6aeHeVxV+o0un92iC0kKz3jU43uWRLwVZTmwMJ4zy8=;
        fh=NjhOMWCc7cmLcAHvaIm0H/TGR8wbfeND7ru2a41h9UQ=;
        b=SwCGUHnbO5AyoLxFP4TQk7LLVNcsJZ1wLoTvXTu70NapSKQz5l6QmrnBidwbNSOc6y
         cMF0rt9hqvZjRUoSWjBE27C+eCfXAwUg/+F14QXG6i4vJQJX1awN+SXwxlvwquVrped6
         +ZwcP6tAvk4yQagUFx95Tc7hnjMrSwyW1VGSno+6o1fAs7Jo5gO1KXUOXsGOFPlSzhGI
         lZgIkvzO+iq2xaq4aACYZ6BH6lH2OO1nRLkN43PndI2vaccvnNkfhSQN2RJY3ZAhnPQe
         D8Gb49+ZmaKwOEk7t7h1imDpAUXWxA9P9A4LvSUvyxdO7rF27JLgzeFOEXfNoknU5VXy
         cFtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792041816; x=1792646616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E6aeHeVxV+o0un92iC0kKz3jU43uWRLwVZTmwMJ4zy8=;
        b=jXwaxwzq/ZBbOihlL8a1pxoKfB/cWOKriKm10wRUSvY2CCvFZ15sR4mpZC0LYYwJE9
         uCngImbAwKJpZ4T3lohXqBQpdsqfX7VY8AGNa2vc8Rc0PoNVQ/eIgpdcApCAFF+vkeUU
         l6A919V+dgwT0Kjo8+kLmC9qVznAUMnfntlZiXddF6Ff1ObUx8wWamWp3PQjL3gc0RR8
         EgGhkWs/4JTpFav9uiWwZjyyhFrPI/UVQxAoAV0Z2q7Q6QgaWbnwuPYpZlwlsLyH/So4
         B8//CbIDzB/lQGI5x9n8iPZWmyQfDS3J/EjhFTpHBPJbFgDNhEMEptkX6pXWZbhcCRkk
         W2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041816; x=1792646616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6aeHeVxV+o0un92iC0kKz3jU43uWRLwVZTmwMJ4zy8=;
        b=CFEyY41h4hHe8OF1OOw1eCMtPf88MjPClzdRA0ZQ85fh/ICPt+ffqX6zTTidfyQUJG
         UU22ByBdeKfRDDxHcU1lp9CF2rhKQjpyWVS6JueaSrJKXT7vaUUAbm/xbAOi0fcMrWRX
         QVyldZ3EzGZtJzBdz/j8b2vkVZDuILjvqV7Eq1pQOrCLVgBCYWgWGovXOZGpQHBc9TNX
         uTJ/2uXji5CUsotgDgMNM1QbvIA6TLQmz0lejujRKdBBFoeAohF/agDVKzxivMna027i
         ozrhZeGkO+sQs5kxQJvyuOCpsyA3LcYbBRmVm4IBYZjOWkuGzCIQSrq3bgTgb5qDL/1k
         MU4w==
X-Forwarded-Encrypted: i=1; AKwUvByHvqTO2EgSSyGzggDNUa8ghnOHiuqiHbuTTCjyKyoxUBhI0Q8/lAu4FnesEa2DMRonUyNgl5bFjzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO4yjE5kKYJUOagmC76Jr1f8Ctp1BKKYkUNrmxuIzRUH9iha8h
	f0o/PIfoQdx3bqj6zEEPmQskKptwU1NSLmRpAOoHzT7y22RD5kFC+PbQhuGDb5ju4R8erIiwESu
	G8TNiw3n25lEm82qKAXgnsFsdfdgWs3Q=
X-Gm-Gg: AYBFou1wJT3dtV2dFSvy/qbme5w4A6Q+TQ6QeIyeKCRNQsZQdYYG54uW/BkJsx/EGTo
	J/RSKdQ+p6JjU5p6MY93+8dLCwRhu3AC9tJ/kcakekfPzxWD5sfnqzuQ8V+5QcgA39ltyYkuf9N
	KSpEmpftRXPQwT3GKQFepyXDr8PVu0mIRvmvDgHXuX2mTsnfvO/HS+50BF5nlyNxhsmk5eurVTB
	N0iJC8KfsadPY/TGDYl0nFSq7vLszkHQ++7kv8rDtHo14AOUavj88q5tTHqZYwOmuhM1NE6STRB
	jJOfbenBpqZ6ZTmNcmBp+CGBIE3JFLIy2ZN41+jSJhTGVe4OHViQ+lJcpTJ+WiAVfC+KQKkV1tE
	cMx0jtlQADoo=
X-Received: by 2002:a05:6402:5cf:b0:6ac:afa3:6f72 with SMTP id
 4fb4d7f45d1cf-6b17c1ffa7cmr12778263a12.5.1792041815465; Wed, 14 Oct 2026
 22:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com> <as_r8n7p_wdbChuQ@google.com>
In-Reply-To: <as_r8n7p_wdbChuQ@google.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Oct 2026 15:23:08 +1000
X-Gm-Features: AclHuK9TlPmrIXCDTZxdpsBCyi7AYS4bwnhhJs76xIjIBGjWm4Rnm4ha0NayYvA
Message-ID: <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alice Ryhl <aliceryhl@google.com>
Cc: lukas@wunner.de, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, gary@garyguo.net, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Sep 28, 2026 at 11:11:01AM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
>
> So I looked a bit at this, and here are some comments. I will not repeat
> what Alexandre has already said.
>
> First, I'd like to say that it's good to see that all wire-format
> parsing in lib/rspdm/validator.rs is written in completely safe Rust.
> That's exactly what we want to see for parsing in Rust. We want the code
> to have basically no unsafe code whatsoever so that we really get to
> rely on the bullet-proof guarantees about bugs being caught at compile
> time, or at least at runtime.
>
> Unfortunately it looks like the same cannot be said for the state
> machine in lib/rspdm/state.rs, which has way too much unsafe code in its
> interaction with the rest of the kernel. There needs to be more
> intermediate Rust abstractions here. This file should not have *any*
> unsafe code, except maybe 1-2 blocks for using the C transport and
> validate function pointers.

Yeah, it's the crypto functions. There are currently no bindings, so
it's just directly calling the C functions.

Without the crypto functions it's just a single unsafe call to
`transport_function()` in `state.rs` and a few in `lib.rs` to handl
the C <-> FFI boundy.

I was trying to avoid adding crypto and X.509 bindings in this series,
as that's a few more subsystems this ends up touching. We need to add
PQC as well, so crypto bindings are next on the todo list once this is
merged.

Is this going to stall on adding crypto bindings?

>
> I've also asked my LLM to take a look, please see below. I looked over
> the LLM report myself, and while it's more strongly worded than I would
> have said myself, its feedback seems more or less valid to me.

Ha, it is pretty strongly worded. I think I addressed everything below

>
> Alice
>
>
>
>
> #### 1. Bugs & Memory Safety / Soundness Issues
>
> - **UB in `shash_desc` allocation and deallocation in `SpdmState::update_=
response_algs` and `SpdmState::free_desc` (Patch 17)**:
>   - `update_response_algs` allocates a `KVec<u8>` via `KVec::from_elem(0u=
8, desc_len, GFP_KERNEL)`, calls `into_raw_parts()`, discards `_capacity`, =
and stores `desc_buf as *mut bindings::shash_desc`.
>   - In `free_desc`, it reconstructs `KVec::<u8>::from_raw_parts(self.desc=
 as *mut u8, desc_len, desc_len)`, passing `desc_len` as the capacity even =
though `KVec::from_elem` does not guarantee `capacity =3D=3D len`.
>   - Casting a `*mut u8` from `KVec<u8>` to `*mut bindings::shash_desc` on=
ly relies on `kmalloc` minimum alignment by accident, rather than properly =
allocating a dynamically-sized type or wrapping `crypto_shash` in a safe ke=
rnel abstraction.

Good point, fixed

>
> - **Mismatched `ForeignOwnable` types in `lib/rspdm/lib.rs` (Patch 10)**:
>   - `spdm_create` creates a `Pin<KBox<Mutex<SpdmState<'_>>>>` via `KBox::=
pin_init` and calls `.into_foreign()`.
>   - `spdm_authenticate` borrows it as `<Pin<KBox<Mutex<SpdmState<'_>>>> a=
s ForeignOwnable>::borrow(...)`.
>   - `spdm_destroy`, however, calls `KBox::<Mutex<SpdmState<'_>>>::from_fo=
reign(...)` (without `Pin`). It should use `Pin::<KBox<Mutex<SpdmState<'_>>=
>>::from_foreign(...)` to match `into_foreign()`.

Shasiko caught this one

>
> - **Unchecked transport return length in `spdm_exchange` and callers**:
>   - In `spdm_exchange`, `Untrusted::new(&response_buf[..]).validate(&*sel=
f)` validates the entire pre-allocated `response_buf` instead of `&response=
_buf[..length as usize]`.
>   - Only `get_version` checks `if rc > response_vec.len()` before `respon=
se_vec.truncate(rc)`. None of `get_capabilities`, `negotiate_algs`, `get_di=
gests`, `get_cert_exchange`, or `challenge` check if `rc > response_vec.len=
()`; if a transport returns a size larger than the buffer, `truncate(rc)` i=
s a no-op. Better yet, `spdm_exchange` itself should enforce `(length as us=
ize) <=3D response_buf.len()` and return `usize`.

The next version handles this better, but I don't think this is an
actual issue. If `transport_function` returns a wrong length we will
just check the entire `response_buf`. It's not a soundness or safety
issue, just a logic bug in `transport_function`. That's just up to
`transport_function` to tell us how much data we received.

>
> #### 2. Design & Abstraction Issues
>
> - **`Untrusted<T>` / `Validate` Usage Defeats Its Own Purpose (Patches 3=
=E2=80=934, 10, 15=E2=80=9322)**:
>   - The motivation for `Untrusted<T>` is that I/O boundaries (such as `sp=
dm_exchange`) accept or return `Untrusted` data so the caller cannot touch =
the bytes without going through `Validate`.
>   - Instead, `spdm_exchange` takes a plain `response_buf: &mut [u8]`, and=
 every caller manually wraps the slice and validates it in a single express=
ion:
>     ```rust
>     let response: GetVersionRsp =3D Untrusted::new(response_vec.as_slice(=
)).validate(&*self)?;
>     ```
>     Wrapping a plain `&[u8]` in `Untrusted::new(...)` only to immediately=
 call `.validate(...)` on the same line provides no type-level guarantee th=
at untrusted buffers aren't read elsewhere (and in fact, `response_vec` is =
indexed directly right after `validate()` to extend `self.transcript`).
>   - Furthermore, adding `type Context` with a lifetime parameter `'c` to =
`Validate<'c, Input>` makes the general `Validate` trait much heavier when =
a normal parsing method `FromBytes` / `try_from_bytes(buf: &[u8], state: &S=
pdmState)` would be simpler and more idiomatic.

Yeah, I caught this already

>
> - **Abuse of `CString` and `CString::into_vec` (Patches 21 & 22)**:
>   - Patch 21 adds `CString::into_vec` solely so `verify_signature` in Pat=
ch 22 can format the 64-byte ASCII `spdm_prefix` using `CString::try_from_f=
mt(...)`.
>   - Because `CString`'s internal `KVec<u8>` includes the trailing NUL ter=
minator (`\0`), `prefix.into_vec()` actually returns **65 bytes** (64 ASCII=
 bytes + 1 NUL byte), which then forces line 1013 to compensate for the ext=
ra NUL byte by subtracting `1` from `zero_pad_len`:
>     ```rust
>     let zero_pad_len =3D SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_=
CONTEXT.len() - 1;
>     ```
>   - Not only is `CString::into_vec` a footgun, `verify_signature` doesn't=
 need `CString` or heap allocation at all: `m` is already allocated right a=
bove on line 981, or it can format directly into a fixed-size stack buffer =
`[0u8; SPDM_COMBINED_PREFIX_SZ]`.

Fixed

>
> - **Direct `unsafe` C FFI Calls in Driver/Library Code (`lib/rspdm/state.=
rs`)**:
>   - `lib/rspdm/state.rs` directly manipulates raw C pointers (`*mut bindi=
ngs::device`, `*mut bindings::crypto_shash`, `*mut bindings::shash_desc`, `=
*mut bindings::x509_certificate`, `*mut bindings::public_key`) and makes ra=
w `unsafe` calls to `crypto_alloc_shash`, `crypto_shash_digest`, `x509_cert=
_parse`, `public_key_verify_signature`, and `get_random_bytes`.
>   - Per Rust-for-Linux conventions, C subsystem bindings (`crypto_shash`,=
 `x509_certificate`, `public_key`, `get_random_bytes`) should be wrapped in=
 safe abstractions under `rust/kernel/`, and `dev` should use `device::Devi=
ce` rather than a raw `*mut bindings::device` with no lifetime or reference=
-count guarantee.
>   - Note also in `validate_cert_chain`: `let cert =3D unsafe { *cert_ptr =
};` copies the entire C `struct x509_certificate` by value onto the stack j=
ust to read fields (`cert.unsupported_sig`, `cert.blacklisted`, `cert.sig`)=
.

Fixed the device::Device part, crypto still doesn't have bindings (see abov=
e)

>
> - **Useless lifetime `'a` on `SpdmState<'a>` (`state.rs:136`)**:
>   - `SpdmState<'a>` has a lifetime parameter `'a` only used for `base_asy=
m_enc: &'a CStr` and `base_hash_alg_name: &'a CStr`, which only ever point =
to `'static` string literals (`c_str!("pkcs1")`, `c_str!("sha256")`, etc.).=
 Using `&'static CStr` (and `c"..."` instead of `CStr::from_bytes_with_nul(=
b"...\0")?`, which also eliminates the need for Patch 9!) removes the `'a` =
lifetime parameter from `SpdmState` entirely.

Outdated with Device lifetimes, although good point about patch 9

>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
>
>
> While `lib/rspdm/validator.rs` is a step up from earlier versions in that=
 it contains **zero `unsafe` blocks** and uses `.get(...)` instead of `[]` =
indexing, the implementation is very unidiomatic, does a lot of wasted heap=
 allocations, and still has bugs (including a kernel panic / underflow vect=
or).
>
> Here is a breakdown of the issues in `validator.rs`:
>
> ---
>
> ### 1. Kernel Panic / Integer Underflow & Range Bug in `SpdmCertChain::va=
lidate`
> Even without `unsafe`, safe Rust in the kernel must not panic on untruste=
d input when `CONFIG_RUST_OVERFLOW_CHECKS` is enabled. Look at lines 849=E2=
=80=93872:
>
> ```rust
> let length =3D u16::from_le_bytes(
>     unvalidated
>         .get(0..2)
>         .ok_or(EIO)?
>         .try_into()
>         .map_err(|_| EINVAL)?,
> );
>
> let root_hash_end =3D SPDM_CERT_CHAIN_HDR_SZ + context.hash_len;
> ...
> let cert_chain_end =3D length as usize - root_hash_end;
> let mut certificates =3D KVec::new();
> certificates.extend_from_slice(
>     unvalidated.get(root_hash_end..cert_chain_end).ok_or(EIO)?,
>     GFP_KERNEL,
> )?;
> ```
> - **Arithmetic underflow**: `length` comes directly from the first 2 byte=
s of the untrusted certificate chain before `state.rs` compares it to `tota=
l_cert_len`. If a responder sends `length < 4 + hash_len`, `length as usize=
 - root_hash_end` underflows (panicking with overflow checks enabled, or wr=
apping to `usize::MAX - ...`).
> - **Wrong slice end**: `length` in the SPDM Certificate Chain format (SPD=
M 1.0 Table 15) is the *total* length of the chain including `root_hash_end=
` (`4 + H`). Subtracting `root_hash_end` gives the *number of certificate b=
ytes*, not the end index. Using it as the end index of `root_hash_end..cert=
_chain_end` slices `[4+H .. length-(4+H)]`, dropping the last `4 + H` bytes=
 of the certificate chain (or returning `Err(EIO)` if the certificates are =
smaller than `4 + H` bytes).

Shasiko caught this too

>
> ---
>
> ### 2. Allocating and Copying into `KVec`s Only to Immediately Drop Them =
(`#[expect(dead_code)]` Everywhere)
> Almost every response struct in `validator.rs` (`GetVersionRsp`, `RespAlg=
Struct`, `SupportedAlgorithms`, `GetCapabilitiesRsp`, `NegotiateAlgsRsp`, `=
GetDigestsRsp`, `SpdmCertChain`, `ChallengeRsp`) is annotated with `#[expec=
t(dead_code)]`.
>
> Why? Because `validate()` heap-allocates `KVec`s and copies payload data =
out of the response buffer into fields that **are never read anywhere in th=
e crate**:
> - **`GetDigestsRsp::validate`**: Allocates up to 8 `KVec<u8>`s (`digests:=
 [KVec<u8>; SPDM_SLOTS]`) and copies every digest into the heap. Then `Spdm=
State::get_digests` only reads `response.header.param1` and `response.heade=
r.param2` and immediately drops `response` (freeing all 8 `KVec`s without e=
ver looking at the digests).
> - **`SupportedAlgorithms::from_bytes`**: Allocates `ext_asym: KVec<u32>`,=
 `ext_hash: KVec<u32>`, and `alg_struct: KVec<RespAlgStruct>` (each contain=
ing 2 more `KVec`s). `SpdmState::get_capabilities` never accesses `response=
.supported_algorithms` at all.
> - **`NegotiateAlgsRsp::validate`**: Loops over `ext_asym_sel_count`, `ext=
_hash_sel_count`, and `header.param1` (`RespAlgStruct`), allocating `KVec`s=
 for all of them. Then, as soon as `validate()` returns to `SpdmState::nego=
tiate_algs`, `state.rs` checks:
>   ```rust
>   || response.ext_asym_sel_count !=3D 0
>   || response.ext_hash_sel_count !=3D 0
>   || response.header.param1 > request.header.param1 // request.header.par=
am1 is always 0!
>   ```
>   So any non-empty `ext_asym`, `ext_hash`, or `resp_alg_struct` is **alwa=
ys rejected** in `state.rs`=E2=80=94yet `validator.rs` has 45 lines of code=
 to heap-allocate and populate those vectors from untrusted counts *before*=
 `state.rs` rejects them!
> - **`SpdmCertChain::validate`**: Heap-allocates `root_hash: KVec<u8>` and=
 `certificates: KVec<u8>`. `SpdmState::get_certificate` only checks `certs.=
length`, drops `certs`, and stores the original unsplit `certs_buf` in `sel=
f.certs[slot]`.
> - **`ChallengeRsp::validate`**: Heap-allocates `cert_chain_hash: KVec<u8>=
` and `opaque_data: KVec<u8>`, neither of which is ever read or verified.
> - **Even fixed-size requests heap-allocate**: `SpdmHeader::to_bytes()` (4=
 bytes), `GetVersionReq::to_bytes()` (4 bytes), `GetDigestsReq::to_bytes()`=
 (4 bytes), `GetCertificateReq::to_bytes()` (8 bytes), `NegotiateAlgsReq::t=
o_bytes()` (32 bytes), and `ChallengeReq::to_bytes()` (36 or 44 bytes) all =
allocate a `KVec<u8>` (without `with_capacity`, causing multiple reallocati=
ons as `.push()` / `.extend_from_slice()` are called) instead of returning =
a fixed-size byte array `[u8; N]` or implementing `AsBytes`.
>
> Why copy slices out of `unvalidated: &'a [u8]` into newly allocated `KVec=
<u8>`s at all, when the parsed response struct can either borrow `&'a [u8]`=
 sub-slices directly from the response buffer or validate in-place?

I replied to Alexandre about this as well.

The SPDM responses are a bit complex. For example NegotiateAlgsRsp has
multiple dynamically sized arrays, and the fields change based on the
version.

The current approach has the obvious downside of copying the data, but
the buffers are small in the scheme of things. Copying it allows us to
use nice Rust structs (not packed), ensure the data is in the correct
endianes and check and validate the entire message. It also means that
the Rsp structs contain all of the information. As your LLM points
out, it currently isn't all read, but this is a basic starting point.

In terms of the allocations, it is only a few bytes, so I don't think
it matters that much.

In terms of unused elements, there are only a few unused, most of the
elements aren't dead code

Maybe in the future zerocopy could be a performance improvement, but I
think right now it's a large complexity overhead in this case.

>
> ---
>
> ### 3. Magic Byte Offsets Instead of a Cursor/Reader or `FromBytes`
> Because the author moved away from `#[repr(C, packed)]` structs in v4, th=
ey replaced struct definitions with hardcoded byte offsets. Look at `Suppor=
tedAlgorithms::from_bytes` and `NegotiateAlgsRsp::validate`:
>
> ```rust
> let alg_struct_count =3D *buf.get(0).ok_or(EIO)?;
> let length =3D read_le16(2)?;
> let measurement_specification =3D *buf.get(4).ok_or(EIO)?;
> let other_params_support =3D *buf.get(5).ok_or(EIO)?;
> let base_asym_algo =3D read_le32(6)?;
> let base_hash_algo =3D read_le32(10)?;
> let ext_asym_count =3D *buf.get(26).ok_or(EIO)?;
> let ext_hash_count =3D *buf.get(27).ok_or(EIO)?;
> let mel_specification =3D *buf.get(29).ok_or(EIO)?;
>
> let mut offset =3D 30;
> ```
> - **Hard to audit against the spec**: Jumping from offset `10` to `26` (s=
kipping 12 reserved bytes) or `27` to `29` with magic numbers makes it very=
 easy to miscount offsets, and `read_le16` / `read_le32` closures are copy-=
pasted across multiple functions.
> - **What would be much cleaner**:
>   1. For fixed-size layouts, use `FromBytes::from_bytes_copy_prefix` (or =
`zerocopy`) on `#[repr(C)]` structs with explicit reserved fields (`_reserv=
ed: [u8; 12]`) and little-endian integer wrappers, **or**

I don't think this would be cleaner, it actually sounds much less
clean. Also, there aren't that many fixed size structs

>   2. Use a small sequential reader struct wrapping `&'a [u8]` (e.g., `r.r=
ead_u8()?`, `r.read_le16()?`, `r.read_le32()?`, `r.skip(12)?`, `r.read_slic=
e(len)?`). That eliminates manual offset arithmetic, cannot underflow/overf=
low `offset`, and reads top-to-bottom like the spec table.
>
> ---
>
> ### 4. Inconsistent Split of Responsibilities Between `validator.rs` and =
`state.rs`
> The boundary between what is validated in `Validate::validate` (`validato=
r.rs`) vs. what is checked in `SpdmState` (`state.rs`) is arbitrary:
> - **Duplicated checks**: `GetCapabilitiesRsp::validate` checks `if data_t=
ransfer_size < SPDM_MIN_DATA_TRANSFER_SIZE` (`validator.rs:456`), and then =
`SpdmState::get_capabilities` checks `if response.data_transfer_size < 42` =
(`state.rs:508`) again.
> - **Misplaced checks**: `GetDigestsRsp::validate` checks `header.param2 =
=3D=3D 0` inside `validator.rs`, whereas `NegotiateAlgsRsp` and `GetCertifi=
cateRsp` leave basic structural checks (`ext_asym_sel_count !=3D 0`, `respo=
nse.header.param1 & 0xF !=3D slot`, `total_cert_len !=3D cert_chain_length`=
) to `state.rs`.
> - **Inconsistent error codes**: Within `validator.rs`, out-of-bounds buff=
er slices return `EIO`, wrong response codes return `EINVAL`, and wrong ver=
sions or lengths return `EPROTO`. In `spdm_exchange`, if a truncated packet=
 is `< 4` bytes (header size), `spdm_exchange` returns `Ok(length)` and let=
s the caller's `validate()` fail with `EIO`.
>
> ---
>
> ### Summary
> The move to safe code in `validator.rs` achieved the goal of removing `un=
safe` pointer casts, but it was done in the most mechanical way possible: r=
eplacing struct field accesses with hardcoded `.get(offset..offset + N)` ca=
lls and copying every variable-length region into throwaway `KVec`s.
>
> Replacing the manual offset indexing with either `FromBytes` / `zerocopy`=
 (for fixed headers) + a tiny slice cursor (borrowing `&'a [u8]` slices ins=
tead of allocating `KVec`s) would probably cut `validator.rs` in half, remo=
ve ~15 unnecessary heap allocations per authentication, and fix the `SpdmCe=
rtChain` underflow/range bug.

That won't handle endian conversion though. A slice cursor is an
interesting idea though, I might add that as a followup

Alistair
