Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078747;
	b=oYXAeJe0emCuoFk+futbHVlyJ78RNHten2zsbyHOrewce87Hjv1LFBxD/cOsCZmS30Kk
	 DaJNqovpzk7SuPaAZOlt3h+i8Stv0hk9XQOjEjC2IcwnaGKno+J/C5JzaPFDT/fOKPwe0
	 rCnKWSolin29QzII0pGtEyCejz9nYPnn75hzTZhbk6OFVfhjcMSsjDUCDIdVxwzUn03Tl
	 ysMPjOdPAxAUq2ZxD1MZ6UgVwo2p30W8kt0p9CsxuGL3NjI8vVq5VG+0MkL6VBDg9g1Ef
	 Q5Q88p24mXjVAuEnIRnSnAn8okD3Yy7bMo8J0z8P4d8Xbj2BR1fWwThiTTkFATFVurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kHQppBuxk2+xzYf3QLOTBE1zqBXUyaj0qCJuhImI8OA=;
	b=z7ajmhwnB9xHySqErPHQBQnNfWtoR/gq+8g1AQ1iuD8PE2++eLM6Y+FqKD0mOBFvbkE1
	 FiDULZY6XTSYWOcCKLZ7VOZku2vCxGg8g3lThbsJzZebNyJo7dok5QZUcXBoxH20wO6t1
	 P8ahe5X3ERJprilDuKXhiBYTRblNYcPvq8Nl3tPPDbYHy2Cq0aitHE8qwTlBdj72T/e9G
	 HA7KjR02bPSs/bvPlVZ9hrhfOPEUvt+YuzPYEMQTliEFniS4suD1poRAWxnx9yWQuEjU8
	 FVyo5bptlm8PYujFx2m5Sl9RDWCjh4Kw2Qvhs0U+YgRmKQhbHxOyinZeVzbfFeU0Nog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="TL/ZMDss";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7B606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TL/ZMDss
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9eb579c0eso21094875ad.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078747; x=1793683547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHQppBuxk2+xzYf3QLOTBE1zqBXUyaj0qCJuhImI8OA=;
        b=TL/ZMDssXogw5ydIJYnfWZjriwgtecG2+uJ4HMuMiv2WDe4gfJFA1yj0Un2nLCJJv0
         wMw6B7Wdk8jrDHSse/vmrsC2SJyORZIwS45IdraShJqJ1+NE9ue6u3iEje70M6uQ2liF
         NuDQBHpbqTCR5ikqtdV4ZV/KGeu1fzeu86w+Qa8zeZIOfNDjMd4blhgBJXrw4i9oORyt
         +zXMHmFTgB/G+L4MuX1l2ijJHmzZyu7eR/CrPrlrYExpYdDKnEE7bV9F8CNqGIWXfya8
         EP7pFglnJMzkmXrz6UA/vlFxBkWix5BtMFL5A7y7ODruGrxHMJgwxtglYkL3V+kzukI0
         TPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078747; x=1793683547;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kHQppBuxk2+xzYf3QLOTBE1zqBXUyaj0qCJuhImI8OA=;
        b=mvevOiwZFAYyEyOztaL2khxra6drp0DZEuqS5m7rueDeLDpHznnXehlGRXsoh89LPP
         xpD4koEW3eIdC+67eGFxCdfCBOOK92DifxKmyUwVHv4gVJTpaR2ZuP5POM55rBfFVvnz
         QMd5NYQZSMLcMwPT0sq8JEE2Ydk1kTOoIHE5Pw01iSbAasqiG4FUO7qOsFp53/syU8DH
         x6QXPqdw+mLieWggJ1TDq1THh2fVBpuSkTr/fZGGZskGs8uceAetcIIj6xrRhuF2dHUo
         /xZc0237w1tXxFm7hhuWjXjRfRIb7xWQySxKNRzdE3b/+X9Gni1MuEtQtlvsloDMjqcN
         YViA==
X-Forwarded-Encrypted: i=1; AKwUvBx9JKMn8tFAJ63Y1z6GhOkLfusDGaOk0ARzWfnoyh5qWidMY9oVwJFjUzFstZov0/yC4srVOPv9hEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdrHCGOp8rAjYInpHo9NsGz8IshB9vwQTq/qakdBTM5M1yo8AZ
	2gqIZVgCuU5+QOVb/QQZVCLfOWohVIhOF+tK3zyBSvh02WEcPHyhLUbL
X-Gm-Gg: AYBFou3j1xJCBFztSrGh58NzWqv35tTJu5xDCXDVgpO0Azcntt9oPA2RDvra3h0w4i8
	Rp0aHCyePguKwd6PytEFyL2lYO0tRwLxqKfv8g0A9I3O6ihPkxBwhlB3ggAzZNk2ru0/7oowhFm
	+5lMW6LgsbA6IFky0A6jeZlrkL3t0fjfcZf1f0Dm1qRj1Aud8iOoNv7b2aotN9yalVoEiOeKabZ
	RRjiU5tth110awAVyJBQJ9d3Voa2M101XUd2C5x+kAEHxvLkB70Vjosqe8+Xjx2tV5UDl75NXJW
	lR0JyILui3ccv+IK9GffUAt68RQiG9t/V4Oz9U0ROIcnAATV9L81GEkysdL6pxVHpqctY/XzWTC
	e+OEAsdOV3cuqhZorV2sIEL8+N3yNe0OkuEe9iuyVRP52SZ6mltfmRO97EjWl19Gd/txmgr4Kft
	6SKhCJCBj18jR6gbXdCw+x11Lh0uFp5t1I6CObNsjlx/sXRQntHAnnaj35JaY1EgJxYPZpaRoKK
	2XOAOYJjiqPc/KGHwHZ7dDHf8AFMwK+Rj/YrLkNZXb5GhvHnyIbaxkmaKF9w0aXWVZlVo1eFkqD
	UlhUNT057wzop4js4bbuHzv2al0DRrFe51Gtsmd+b40mkuY=
X-Received: by 2002:a17:903:fa8:b0:2e9:5eee:e078 with SMTP id d9443c01a7336-2ea9c0f39c7mr63239465ad.3.1793078746410;
        Mon, 26 Oct 2026 22:25:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:25:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 00/23] lib: Rust implementation of SPDM
Date: Tue, 27 Oct 2026 15:25:13 +1000
Message-ID: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Security Protocols and Data Models (SPDM) [1] is used for authentication,
attestation and key exchange. SPDM is generally used over a range of
transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.

From the kernels perspective SPDM is used to authenticate and attest devices.
In this threat model a device is considered untrusted until it can be verified
by the kernel and userspace using SPDM. As such SPDM data is untrusted data
that can be mallicious.

The SPDM specification is also complex, with the 1.2.1 spec being almost 200
pages and the 1.3.0 spec being almost 250 pages long.

As such we have the kernel parsing untrusted responses from a complex
specification, which sounds like a possible exploit vector. This is the type
of place where Rust excels!

This series implements a SPDM requester in Rust.

This is done using the `Validate` and `Untrusted` traits. The `validate()`
function has been updated updated to allow `context` which we use as
part of the validation.

The validation has also swapped from a C style pointer cast to using a valid
Rust struct and copying the data from the original buffer to the new struct.
This obvious has some overhead, but as SPDM packets are relativly small, and
not used as part of a constant hot path this seems fine. The big advantage is
that we can validate everyting at once, convert the endianess when creating
the struct and we get left with valid (not repr[c, packed]) Rust structs.

This makes the code a lot cleaner and more robust. It also removes a large
number of `unsafe`s and using `get()` for the arrays removes a large number
of possible `panic`s. Thanks for everyone at Kangrejos for the help with this!

I have kept Jonathon's reviews of the SPDM code, as the changes since the
last vesion are mostly just mechanical, convertting the repr[c, packed] structs
to copy structs.

This is based on Lukas' C implementation [2], but has been refacted during the
first few RFCs. I have included some of the relevent patchesfrom Lukas' C
SPDM implementation in this series where they are required.

This is a standalone series and doesn't depend on Lukas' implementation.

The goal of this series is to get the smallest possible SPDM implementation
upstream. That will provide building blocks for us to continue working on.

As such we don't yet provide evidence or certificates to userspace, allow
userspace to provide a nonce, support PQC or more advanced SPDM features.
This is enough to communicate with a device and return "authenticated" to
userspace.

Note that RFC v3 did provide evidence and certificates to userspace and
allowed a custom nonce. Showing that it's possible. I also have patches
that build apon [4] to do this via a TSM driver, again showing it's
possible with the current approach.
We just don't support it yet and for TSM I need [4] upstream first.

This series is different to Lukas' original approach and the approach taken
in the previous RFCs and instead adds the PCI-CMA support as a TSM driver.
This was described by Dan in [3] and [5]. The advantage here is that for PCIe
we can leverage the TSM work for a lot of the features and provide userspace
a consistient interface between PCI TSM and CMA.

This series also doesn't check the certificate chain against the kernel
keyring and will instead leave that to userspace once [4] is merged.

Other transport mode (such as ATA, SCSI, NVMe and MCTP) will
therefore need slightly different approaches, as TSM doesn't apply.
The library can support this though, it will just need some netlink
and sysfs wrappers added as applicable. This way each transport can support
SPDM in the way it sees fit.

The entire tree can be seen here:
https://github.com/alistair23/linux/tree/alistair/spdm-rust-tsm

I'm testing this by running the following

```shell
cargo run -- --qemu-server response

qemu-system-x86_64 \
  -nic none \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-rng-pci,rng=rng0 \
  -drive file=deploy/images/qemux86-64/core-image-pcie-qemux86-64.rootfs.ext4,if=virtio,format=raw \
  -usb -device usb-tablet -usb -device usb-kbd \
  -cpu Skylake-Client \
  -machine q35,i8042=off \
  -smp 4 -m 2G \
  -drive file=blknvme,if=none,id=mynvme,format=raw \
  -device pcie-root-port,chassis=1,id=pci.1 \
  -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe,bus=pci.1 \
  -snapshot \
  -serial mon:stdio -serial null -nographic \
  -kernel deploy/images/qemux86-64/bzImage \
  -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '

echo tsm0 > /sys/bus/pci/devices/0000:01:00.0/tsm/connect
```

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
4: https://lore.kernel.org/all/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch/
5: https://lore.kernel.org/lkml/69e19c80b892b_fe0831000@djbw-dev.notmuch/

v5:
 - Split out crypto into Rust kernel wrappers
 - Use ZeroCopy for SpdmHeader
 - Add the Transport trait and CTransport type
 - Bind the device driver
 - Address bugs and issues from reviews
v4:
 - Based on discussions at Kangrejos the following changes were made
     - Add context to the validate functions
     - Convert the validate() functions to be complete Rust structs and copy the
       data, instead of C style pointer casts
     - Use ForeignOwnable trait for SpdmState
     - Use get() for array accesses
 - Address review comments
v3:
 - Rebase on 7.3-rc1
v2:
 - Tidy up the PCI/TSM function naming and is_pci_tsm_host()
 - A large number of changes (mostly to the Rust code) based on Sashiko reviews
     - This includes a few local runs of Sashiko
     - This has fixed a few undefined behviour bugs in the Rust code
 - Rebase on v4 of Benno's validate patches (patch 1, 2, 3)
v1:
 - Add CMA as a TSM driver
 - Initial support for SPDM 1.4
 - Cleanup a range of comments and concerns from RFC
 - Remove kernel keyring checks
RFC v3:
 - Use netlink to send information to userspace
 - Don't autogenerate Rust helpers
RFC v2:
 - Drop support for Rust and C implementations
 - Include patches from Lukas to reduce series deps
 - Large code cleanups based on more testing
 - Support for authentication

Alistair Francis (17):
  virt: coco: change tsm_register() to use a const struct
  rust: add bindings for hash.h
  rust: device: Expose Device from_raw() publically
  lib: rspdm: Initial commit of Rust SPDM
  PCI/TSM: Rename pf0 to host
  PCI/TSM: Support connecting to PCIe CMA devices
  PCI/CMA: Add a PCI TSM CMA driver using SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  rust: kernel: Add crypto hash bindings
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  rust: public_key: Add crypto public key bindings
  rust: x509: Add X509 certificate bindings
  lib: rspdm: Support SPDM certificate validation
  lib: rspdm: Support SPDM challenge

Benno Lossin (2):
  rust: create basic untrusted data API
  rust: validate: add `Validate` trait

Lukas Wunner (4):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  PCI/CMA: Validate Subject Alternative Name in certificates

 MAINTAINERS                               |   13 +
 crypto/asymmetric_keys/x509_cert_parser.c |    9 +
 crypto/asymmetric_keys/x509_loader.c      |   38 +-
 crypto/asymmetric_keys/x509_parser.h      |   42 +-
 drivers/crypto/ccp/sev-dev-tio.h          |    4 +-
 drivers/crypto/ccp/sev-dev-tsm.c          |   14 +-
 drivers/pci/Kconfig                       |   14 +
 drivers/pci/Makefile                      |    5 +
 drivers/pci/cma.asn1                      |   41 +
 drivers/pci/cma.c                         |  271 +++++
 drivers/pci/doe.c                         |    6 +-
 drivers/pci/tsm.c                         |  122 ++-
 drivers/virt/coco/tsm-core.c              |    4 +-
 include/keys/asymmetric-type.h            |    2 +
 include/keys/x509-parser.h                |   57 ++
 include/linux/oid_registry.h              |    3 +
 include/linux/pci-doe.h                   |    4 +
 include/linux/pci-tsm.h                   |   48 +-
 include/linux/pci.h                       |    1 +
 include/linux/spdm.h                      |   66 ++
 include/linux/tsm.h                       |    2 +-
 lib/Kconfig                               |   17 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  113 +++
 lib/rspdm/lib.rs                          |  329 ++++++
 lib/rspdm/state.rs                        |  784 ++++++++++++++
 lib/rspdm/validator.rs                    | 1129 +++++++++++++++++++++
 rust/bindings/bindings_helper.h           |    5 +
 rust/helpers/hash.c                       |   22 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/device.rs                     |    2 +-
 rust/kernel/hash.rs                       |  145 +++
 rust/kernel/lib.rs                        |    7 +
 rust/kernel/public_key.rs                 |   69 ++
 rust/kernel/validate.rs                   |  275 +++++
 rust/kernel/x509.rs                       |  118 +++
 37 files changed, 3669 insertions(+), 125 deletions(-)
 create mode 100644 drivers/pci/cma.asn1
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/keys/x509-parser.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs
 create mode 100644 rust/helpers/hash.c
 create mode 100644 rust/kernel/hash.rs
 create mode 100644 rust/kernel/public_key.rs
 create mode 100644 rust/kernel/validate.rs
 create mode 100644 rust/kernel/x509.rs

-- 
2.56.0

