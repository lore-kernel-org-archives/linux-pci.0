Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0C3EEAE9
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011255; cv=none; b=r6141aXdHgTakJcugc+aBnR9hAxCqQgiS9HQFWzHQkf8GjCNZuq1UEyFDoEj02GiYNl2T7ttfy01qpZ4x38iXM1nmOqaXBFzWh/t84/JT7oiTrQBEfLCXFKU/7R37i1oqo7Q3/fX54qXlpeOwbXNXTUrzFx/zcvsK3lJLeoXE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011255; c=relaxed/simple;
	bh=yj9VE2QbV89pju6ft3rkRVb0tNrV64stzW6sDtyBTjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KHF8sdmeiRtZmkJZfdPiwWsGySrrYs0fxFkuk0zcjMHMzlxOBf/DzVIrsl3CnCAcZDHvAiEHmHdme0XeryVr/LVeGdukSwGJHIBBSCNJTTxatsZUE2z6DQBoAWFIHaJNGOcttKZFG3DeJSUJ8CLYLEGR/XCwZABILfHwBKF+5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8yP8xiY; arc=none smtp.client-ip=209.85.218.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8yP8xiY"
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c3d9daffbc3so72773466b.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792011252; x=1792616052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t3whNLyFpVLSIhjuz+5EYC1WGtQm+qcJgPTNTCrDIWQ=;
        b=X8yP8xiYAkR40vd8wX26+Hxr66AJyL8MhS1lST+kFIWLC11HCXuZXqUgBD54M48HGH
         AjvCZpL8W7O1Ba3ROSKQkN8FBOAw0cAezYDL2DOYhZ7K17nEq21j1JDzJwWnJUMo6rhN
         3kIYlw6AB2S7KsBTxIzhv/8GyKfGbve1hlCwifYaqv07dZi20/OLAKXsrlzp9k4MOQzt
         AkjIKGcHo3fEDOo9NcOzQil5SPTEA94EkbFg41sIc16EpVbA1ltPaulSZbfLTiSkAJ3/
         TZ8yZoIBg2Mw3qjxMHUrTUz4+rAAnoV6ME0vnc8ujCIxucfkPJIImDKc51CrFEgotGVM
         3hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792011252; x=1792616052;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3whNLyFpVLSIhjuz+5EYC1WGtQm+qcJgPTNTCrDIWQ=;
        b=uIIyPI44fGIFHJIEbqPLLWzLSFns8nKYCp8OXAJG18ZZwap21RDpAuexWOvS3M1515
         OpZSY3i/QWGq5Nq27ZZkv1wCVE2SdaSLGRZ342hhjArCmyJzaAupb3caKS+fcBCvWFhk
         ee5tbNrZngE8kinG/+BL/TeNrv7oHe1oGHKf3IEQdfBQQS1LuEGFAXCBSLIcgyuAqX9L
         i2lC4X2ni8b5mVbHu9lX6NzrgwkjYp9k1UATAQ2DEmXiJTUeACXq6ss3rOI/l9gVsngO
         hN0UCPgtabf4ewEgO6JVh6Qgeqz1A93/9WMKgRcrRs6+Plc3QgEKU+YME7Dw0bvt2GM0
         9tEA==
X-Forwarded-Encrypted: i=1; AKwUvBw2wufUJ8yTtVrQ/JEcjNopppirvYA2P0m6C/1DJteZdLVTGC4OpidpZi2sjSy+YB6ziGs4MJrmIOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYrkXylRj7la9GFmS5sv389W9GSyAZChK/8SMy9+Bv51SOna6K
	4DaVMktGO51TI0FbZaEhxvpXyw5dpL7tW0ox1MssA+d384HMXn7FgB5jxri7VGDhnNtC/8zsrrp
	WfgjixFJBB0raoVV2BA==
X-Received: from ejbdv4.prod.google.com ([2002:a17:906:b804:b0:c3b:687a:419b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c89:b0:c2d:c2d5:f1c9 with SMTP id a640c23a62f3a-c31aa091a92mr1565639466b.35.1792011251504;
 Wed, 14 Oct 2026 13:54:11 -0700 (PDT)
Date: Wed, 14 Oct 2026 20:54:10 +0000
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
Message-ID: <as_r8n7p_wdbChuQ@google.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
From: Alice Ryhl <aliceryhl@google.com>
To: alistair23@gmail.com
Cc: lukas@wunner.de, linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, gary@garyguo.net, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:11:01AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Security Protocols and Data Models (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
>=20
> From the kernels perspective SPDM is used to authenticate and attest devi=
ces.
> In this threat model a device is considered untrusted until it can be ver=
ified
> by the kernel and userspace using SPDM. As such SPDM data is untrusted da=
ta
> that can be mallicious.
>=20
> The SPDM specification is also complex, with the 1.2.1 spec being almost =
200
> pages and the 1.3.0 spec being almost 250 pages long.
>=20
> As such we have the kernel parsing untrusted responses from a complex
> specification, which sounds like a possible exploit vector. This is the t=
ype
> of place where Rust excels!
>=20
> This series implements a SPDM requester in Rust.

So I looked a bit at this, and here are some comments. I will not repeat
what Alexandre has already said.

First, I'd like to say that it's good to see that all wire-format
parsing in lib/rspdm/validator.rs is written in completely safe Rust.
That's exactly what we want to see for parsing in Rust. We want the code
to have basically no unsafe code whatsoever so that we really get to
rely on the bullet-proof guarantees about bugs being caught at compile
time, or at least at runtime.

Unfortunately it looks like the same cannot be said for the state
machine in lib/rspdm/state.rs, which has way too much unsafe code in its
interaction with the rest of the kernel. There needs to be more
intermediate Rust abstractions here. This file should not have *any*
unsafe code, except maybe 1-2 blocks for using the C transport and
validate function pointers.

I've also asked my LLM to take a look, please see below. I looked over
the LLM report myself, and while it's more strongly worded than I would
have said myself, its feedback seems more or less valid to me.

Alice




#### 1. Bugs & Memory Safety / Soundness Issues

- **UB in `shash_desc` allocation and deallocation in `SpdmState::update_re=
sponse_algs` and `SpdmState::free_desc` (Patch 17)**:
  - `update_response_algs` allocates a `KVec<u8>` via `KVec::from_elem(0u8,=
 desc_len, GFP_KERNEL)`, calls `into_raw_parts()`, discards `_capacity`, an=
d stores `desc_buf as *mut bindings::shash_desc`.
  - In `free_desc`, it reconstructs `KVec::<u8>::from_raw_parts(self.desc a=
s *mut u8, desc_len, desc_len)`, passing `desc_len` as the capacity even th=
ough `KVec::from_elem` does not guarantee `capacity =3D=3D len`.
  - Casting a `*mut u8` from `KVec<u8>` to `*mut bindings::shash_desc` only=
 relies on `kmalloc` minimum alignment by accident, rather than properly al=
locating a dynamically-sized type or wrapping `crypto_shash` in a safe kern=
el abstraction.

- **Mismatched `ForeignOwnable` types in `lib/rspdm/lib.rs` (Patch 10)**:
  - `spdm_create` creates a `Pin<KBox<Mutex<SpdmState<'_>>>>` via `KBox::pi=
n_init` and calls `.into_foreign()`.
  - `spdm_authenticate` borrows it as `<Pin<KBox<Mutex<SpdmState<'_>>>> as =
ForeignOwnable>::borrow(...)`.
  - `spdm_destroy`, however, calls `KBox::<Mutex<SpdmState<'_>>>::from_fore=
ign(...)` (without `Pin`). It should use `Pin::<KBox<Mutex<SpdmState<'_>>>>=
::from_foreign(...)` to match `into_foreign()`.

- **Unchecked transport return length in `spdm_exchange` and callers**:
  - In `spdm_exchange`, `Untrusted::new(&response_buf[..]).validate(&*self)=
` validates the entire pre-allocated `response_buf` instead of `&response_b=
uf[..length as usize]`.
  - Only `get_version` checks `if rc > response_vec.len()` before `response=
_vec.truncate(rc)`. None of `get_capabilities`, `negotiate_algs`, `get_dige=
sts`, `get_cert_exchange`, or `challenge` check if `rc > response_vec.len()=
`; if a transport returns a size larger than the buffer, `truncate(rc)` is =
a no-op. Better yet, `spdm_exchange` itself should enforce `(length as usiz=
e) <=3D response_buf.len()` and return `usize`.

#### 2. Design & Abstraction Issues

- **`Untrusted<T>` / `Validate` Usage Defeats Its Own Purpose (Patches 3=E2=
=80=934, 10, 15=E2=80=9322)**:
  - The motivation for `Untrusted<T>` is that I/O boundaries (such as `spdm=
_exchange`) accept or return `Untrusted` data so the caller cannot touch th=
e bytes without going through `Validate`.
  - Instead, `spdm_exchange` takes a plain `response_buf: &mut [u8]`, and e=
very caller manually wraps the slice and validates it in a single expressio=
n:
    ```rust
    let response: GetVersionRsp =3D Untrusted::new(response_vec.as_slice())=
.validate(&*self)?;
    ```
    Wrapping a plain `&[u8]` in `Untrusted::new(...)` only to immediately c=
all `.validate(...)` on the same line provides no type-level guarantee that=
 untrusted buffers aren't read elsewhere (and in fact, `response_vec` is in=
dexed directly right after `validate()` to extend `self.transcript`).
  - Furthermore, adding `type Context` with a lifetime parameter `'c` to `V=
alidate<'c, Input>` makes the general `Validate` trait much heavier when a =
normal parsing method `FromBytes` / `try_from_bytes(buf: &[u8], state: &Spd=
mState)` would be simpler and more idiomatic.

- **Abuse of `CString` and `CString::into_vec` (Patches 21 & 22)**:
  - Patch 21 adds `CString::into_vec` solely so `verify_signature` in Patch=
 22 can format the 64-byte ASCII `spdm_prefix` using `CString::try_from_fmt=
(...)`.
  - Because `CString`'s internal `KVec<u8>` includes the trailing NUL termi=
nator (`\0`), `prefix.into_vec()` actually returns **65 bytes** (64 ASCII b=
ytes + 1 NUL byte), which then forces line 1013 to compensate for the extra=
 NUL byte by subtracting `1` from `zero_pad_len`:
    ```rust
    let zero_pad_len =3D SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CO=
NTEXT.len() - 1;
    ```
  - Not only is `CString::into_vec` a footgun, `verify_signature` doesn't n=
eed `CString` or heap allocation at all: `m` is already allocated right abo=
ve on line 981, or it can format directly into a fixed-size stack buffer `[=
0u8; SPDM_COMBINED_PREFIX_SZ]`.

- **Direct `unsafe` C FFI Calls in Driver/Library Code (`lib/rspdm/state.rs=
`)**:
  - `lib/rspdm/state.rs` directly manipulates raw C pointers (`*mut binding=
s::device`, `*mut bindings::crypto_shash`, `*mut bindings::shash_desc`, `*m=
ut bindings::x509_certificate`, `*mut bindings::public_key`) and makes raw =
`unsafe` calls to `crypto_alloc_shash`, `crypto_shash_digest`, `x509_cert_p=
arse`, `public_key_verify_signature`, and `get_random_bytes`.
  - Per Rust-for-Linux conventions, C subsystem bindings (`crypto_shash`, `=
x509_certificate`, `public_key`, `get_random_bytes`) should be wrapped in s=
afe abstractions under `rust/kernel/`, and `dev` should use `device::Device=
` rather than a raw `*mut bindings::device` with no lifetime or reference-c=
ount guarantee.
  - Note also in `validate_cert_chain`: `let cert =3D unsafe { *cert_ptr };=
` copies the entire C `struct x509_certificate` by value onto the stack jus=
t to read fields (`cert.unsupported_sig`, `cert.blacklisted`, `cert.sig`).

- **Useless lifetime `'a` on `SpdmState<'a>` (`state.rs:136`)**:
  - `SpdmState<'a>` has a lifetime parameter `'a` only used for `base_asym_=
enc: &'a CStr` and `base_hash_alg_name: &'a CStr`, which only ever point to=
 `'static` string literals (`c_str!("pkcs1")`, `c_str!("sha256")`, etc.). U=
sing `&'static CStr` (and `c"..."` instead of `CStr::from_bytes_with_nul(b"=
...\0")?`, which also eliminates the need for Patch 9!) removes the `'a` li=
fetime parameter from `SpdmState` entirely.



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D




While `lib/rspdm/validator.rs` is a step up from earlier versions in that i=
t contains **zero `unsafe` blocks** and uses `.get(...)` instead of `[]` in=
dexing, the implementation is very unidiomatic, does a lot of wasted heap a=
llocations, and still has bugs (including a kernel panic / underflow vector=
).

Here is a breakdown of the issues in `validator.rs`:

---

### 1. Kernel Panic / Integer Underflow & Range Bug in `SpdmCertChain::vali=
date`
Even without `unsafe`, safe Rust in the kernel must not panic on untrusted =
input when `CONFIG_RUST_OVERFLOW_CHECKS` is enabled. Look at lines 849=E2=
=80=93872:

```rust
let length =3D u16::from_le_bytes(
    unvalidated
        .get(0..2)
        .ok_or(EIO)?
        .try_into()
        .map_err(|_| EINVAL)?,
);

let root_hash_end =3D SPDM_CERT_CHAIN_HDR_SZ + context.hash_len;
...
let cert_chain_end =3D length as usize - root_hash_end;
let mut certificates =3D KVec::new();
certificates.extend_from_slice(
    unvalidated.get(root_hash_end..cert_chain_end).ok_or(EIO)?,
    GFP_KERNEL,
)?;
```
- **Arithmetic underflow**: `length` comes directly from the first 2 bytes =
of the untrusted certificate chain before `state.rs` compares it to `total_=
cert_len`. If a responder sends `length < 4 + hash_len`, `length as usize -=
 root_hash_end` underflows (panicking with overflow checks enabled, or wrap=
ping to `usize::MAX - ...`).
- **Wrong slice end**: `length` in the SPDM Certificate Chain format (SPDM =
1.0 Table 15) is the *total* length of the chain including `root_hash_end` =
(`4 + H`). Subtracting `root_hash_end` gives the *number of certificate byt=
es*, not the end index. Using it as the end index of `root_hash_end..cert_c=
hain_end` slices `[4+H .. length-(4+H)]`, dropping the last `4 + H` bytes o=
f the certificate chain (or returning `Err(EIO)` if the certificates are sm=
aller than `4 + H` bytes).

---

### 2. Allocating and Copying into `KVec`s Only to Immediately Drop Them (`=
#[expect(dead_code)]` Everywhere)
Almost every response struct in `validator.rs` (`GetVersionRsp`, `RespAlgSt=
ruct`, `SupportedAlgorithms`, `GetCapabilitiesRsp`, `NegotiateAlgsRsp`, `Ge=
tDigestsRsp`, `SpdmCertChain`, `ChallengeRsp`) is annotated with `#[expect(=
dead_code)]`.

Why? Because `validate()` heap-allocates `KVec`s and copies payload data ou=
t of the response buffer into fields that **are never read anywhere in the =
crate**:
- **`GetDigestsRsp::validate`**: Allocates up to 8 `KVec<u8>`s (`digests: [=
KVec<u8>; SPDM_SLOTS]`) and copies every digest into the heap. Then `SpdmSt=
ate::get_digests` only reads `response.header.param1` and `response.header.=
param2` and immediately drops `response` (freeing all 8 `KVec`s without eve=
r looking at the digests).
- **`SupportedAlgorithms::from_bytes`**: Allocates `ext_asym: KVec<u32>`, `=
ext_hash: KVec<u32>`, and `alg_struct: KVec<RespAlgStruct>` (each containin=
g 2 more `KVec`s). `SpdmState::get_capabilities` never accesses `response.s=
upported_algorithms` at all.
- **`NegotiateAlgsRsp::validate`**: Loops over `ext_asym_sel_count`, `ext_h=
ash_sel_count`, and `header.param1` (`RespAlgStruct`), allocating `KVec`s f=
or all of them. Then, as soon as `validate()` returns to `SpdmState::negoti=
ate_algs`, `state.rs` checks:
  ```rust
  || response.ext_asym_sel_count !=3D 0
  || response.ext_hash_sel_count !=3D 0
  || response.header.param1 > request.header.param1 // request.header.param=
1 is always 0!
  ```
  So any non-empty `ext_asym`, `ext_hash`, or `resp_alg_struct` is **always=
 rejected** in `state.rs`=E2=80=94yet `validator.rs` has 45 lines of code t=
o heap-allocate and populate those vectors from untrusted counts *before* `=
state.rs` rejects them!
- **`SpdmCertChain::validate`**: Heap-allocates `root_hash: KVec<u8>` and `=
certificates: KVec<u8>`. `SpdmState::get_certificate` only checks `certs.le=
ngth`, drops `certs`, and stores the original unsplit `certs_buf` in `self.=
certs[slot]`.
- **`ChallengeRsp::validate`**: Heap-allocates `cert_chain_hash: KVec<u8>` =
and `opaque_data: KVec<u8>`, neither of which is ever read or verified.
- **Even fixed-size requests heap-allocate**: `SpdmHeader::to_bytes()` (4 b=
ytes), `GetVersionReq::to_bytes()` (4 bytes), `GetDigestsReq::to_bytes()` (=
4 bytes), `GetCertificateReq::to_bytes()` (8 bytes), `NegotiateAlgsReq::to_=
bytes()` (32 bytes), and `ChallengeReq::to_bytes()` (36 or 44 bytes) all al=
locate a `KVec<u8>` (without `with_capacity`, causing multiple reallocation=
s as `.push()` / `.extend_from_slice()` are called) instead of returning a =
fixed-size byte array `[u8; N]` or implementing `AsBytes`.

Why copy slices out of `unvalidated: &'a [u8]` into newly allocated `KVec<u=
8>`s at all, when the parsed response struct can either borrow `&'a [u8]` s=
ub-slices directly from the response buffer or validate in-place?

---

### 3. Magic Byte Offsets Instead of a Cursor/Reader or `FromBytes`
Because the author moved away from `#[repr(C, packed)]` structs in v4, they=
 replaced struct definitions with hardcoded byte offsets. Look at `Supporte=
dAlgorithms::from_bytes` and `NegotiateAlgsRsp::validate`:

```rust
let alg_struct_count =3D *buf.get(0).ok_or(EIO)?;
let length =3D read_le16(2)?;
let measurement_specification =3D *buf.get(4).ok_or(EIO)?;
let other_params_support =3D *buf.get(5).ok_or(EIO)?;
let base_asym_algo =3D read_le32(6)?;
let base_hash_algo =3D read_le32(10)?;
let ext_asym_count =3D *buf.get(26).ok_or(EIO)?;
let ext_hash_count =3D *buf.get(27).ok_or(EIO)?;
let mel_specification =3D *buf.get(29).ok_or(EIO)?;

let mut offset =3D 30;
```
- **Hard to audit against the spec**: Jumping from offset `10` to `26` (ski=
pping 12 reserved bytes) or `27` to `29` with magic numbers makes it very e=
asy to miscount offsets, and `read_le16` / `read_le32` closures are copy-pa=
sted across multiple functions.
- **What would be much cleaner**:
  1. For fixed-size layouts, use `FromBytes::from_bytes_copy_prefix` (or `z=
erocopy`) on `#[repr(C)]` structs with explicit reserved fields (`_reserved=
: [u8; 12]`) and little-endian integer wrappers, **or**
  2. Use a small sequential reader struct wrapping `&'a [u8]` (e.g., `r.rea=
d_u8()?`, `r.read_le16()?`, `r.read_le32()?`, `r.skip(12)?`, `r.read_slice(=
len)?`). That eliminates manual offset arithmetic, cannot underflow/overflo=
w `offset`, and reads top-to-bottom like the spec table.

---

### 4. Inconsistent Split of Responsibilities Between `validator.rs` and `s=
tate.rs`
The boundary between what is validated in `Validate::validate` (`validator.=
rs`) vs. what is checked in `SpdmState` (`state.rs`) is arbitrary:
- **Duplicated checks**: `GetCapabilitiesRsp::validate` checks `if data_tra=
nsfer_size < SPDM_MIN_DATA_TRANSFER_SIZE` (`validator.rs:456`), and then `S=
pdmState::get_capabilities` checks `if response.data_transfer_size < 42` (`=
state.rs:508`) again.
- **Misplaced checks**: `GetDigestsRsp::validate` checks `header.param2 =3D=
=3D 0` inside `validator.rs`, whereas `NegotiateAlgsRsp` and `GetCertificat=
eRsp` leave basic structural checks (`ext_asym_sel_count !=3D 0`, `response=
.header.param1 & 0xF !=3D slot`, `total_cert_len !=3D cert_chain_length`) t=
o `state.rs`.
- **Inconsistent error codes**: Within `validator.rs`, out-of-bounds buffer=
 slices return `EIO`, wrong response codes return `EINVAL`, and wrong versi=
ons or lengths return `EPROTO`. In `spdm_exchange`, if a truncated packet i=
s `< 4` bytes (header size), `spdm_exchange` returns `Ok(length)` and lets =
the caller's `validate()` fail with `EIO`.

---

### Summary
The move to safe code in `validator.rs` achieved the goal of removing `unsa=
fe` pointer casts, but it was done in the most mechanical way possible: rep=
lacing struct field accesses with hardcoded `.get(offset..offset + N)` call=
s and copying every variable-length region into throwaway `KVec`s.

Replacing the manual offset indexing with either `FromBytes` / `zerocopy` (=
for fixed headers) + a tiny slice cursor (borrowing `&'a [u8]` slices inste=
ad of allocating `KVec`s) would probably cut `validator.rs` in half, remove=
 ~15 unnecessary heap allocations per authentication, and fix the `SpdmCert=
Chain` underflow/range bug.
