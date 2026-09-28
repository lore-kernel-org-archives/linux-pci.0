Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992A1C84A0
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557897; cv=none; b=IGgsIhW7+JpUq5b+w4EMQMks0cyRAjb2bwK4pgWBdt7XenhcJ0hLJzILNU2DOMKaIAr7mIJr9zvumzu3Ije3gqxuI04TK3fAKBtILaJNr10rcpytQqvIR+ujwF51V4ud/xIxlWxWSGSOHyVtbDnf4V7p07gsFjcIpfMwnM8kFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557897; c=relaxed/simple;
	bh=EPdeW1aBgFHDFZpGpsIJz4GmqdiCJzGIjKmzSX3COM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LILR9/O/PT5SNldGsaI2nfdZ7Z364z24VWDmBwj0vtoVGKZWHKVK/J8jboSQ61Vn8dk+gj1tTmQIfrlDNj/7YSxunDTQX0mZ8Cj0bIO2KL0GCOcVI2pfdIRtFv/vWREldWzRsHgJuK00PK6WFF3zk1GvqQy2Y5B5J4vxnnN1i5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGVQFhi8; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGVQFhi8"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so841286a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557894; x=1791162694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALSDRNmeEGjWasC/X3d6yy51t9PzoB79Z3+YEI0TCbU=;
        b=hGVQFhi8SuKS82iU0wheiwlEry1bxrt5/k2CGh89gHKGdfBWWPYR/3qe3Q+iImDS4f
         r6wcWdGwKQI5974woAO8ETcwYgR6gx9+nTjGJFKOe3FyH4bizXfR/Q8GAITT5dx6o9zZ
         T8G9YgTJ7FxMsJwcfTkxe0035ise/gKWWjh5NtPhq/cTiUUfZUFLOtAvgS7srMbL4no7
         FQMBEuE9NnCbY7GNNxrLJtOpD7DdyY5rwc/I83nPisPzuPH47OfMuC8eJhwxGrlldyvf
         Y8jC7SKQMt526aFhgJQ21gBOc7Y3WAbceB8KTiE5wssqoZ4bA6S9/+3V0TG1jLRbCth7
         YieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557894; x=1791162694;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ALSDRNmeEGjWasC/X3d6yy51t9PzoB79Z3+YEI0TCbU=;
        b=N7iJL/ycEwg/ym0Xyq3Bo5zN8OsbnttyoU6LdZYRNxRpHItue1JKd3cT2wAt3YcBjf
         EmfNwEdX5APuwctvDzUTcofoiiokme3YDfAbdmWLVyxXR+2OFviyb5JB8Bn2zDQQq6AZ
         LBT6P7ygN4u4HJqRdTigy/iR0BE+Xig5+d43tgEe/+vj/LiI2jLcVYjyIw2bo1+tUMy8
         pCWiURhXNAFKMTt9M1B9nTkpFsY5nZzYvOiJUT3sKZ4q9/bg3p7xLCAmONMuQ9u86ChP
         kzTRaeEKjPQM4G18CzVRUHCiTNz5YEwI+qvkwIITM6FDubkdsXOS/i6xnzVJ3URbqDv8
         NJaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5j3otIg9nlatEwFuizIL6o+iN9OYdkEMFgHcZfUljN6jEQ0IS5IemKFXFBXY+JFAKpPMi6l5lr/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZqE6cWLArDKljUTlB4j+ixN0GRuXYCAzbHEBA92wbUDCnSMlT
	E3Uou29ezxO9XD8Oc0Nj0jOqqyXo4McbR6j2mVQdZALW2k6pyI6CTHxG
X-Gm-Gg: AYBFou1V2U0bviEjWLe8STUnLpxlqFR3fuBeF9bw3hXsA0XJq+YL//PPTUlMgHifSna
	S2cHzUS1nuwxDN8wQyme7SzUsMhktJERQ+5Cwbg93rO7aFKJdejx2TX1hAZdN5CXB1pmH6E3yta
	mj4MyYs4raPB4fyCOcuW8MnFNdKHFaJJTFYwdO+Jamfc28/eRojdH8pHsy27F13wHn8LxPrOufA
	eGptWCYs2LWpR8OUo2MLj7Woxnw2VTA8Dw2wHcL7c2Ex1Tx8Ni+IC/F6frf/UDIUg3b52E1/9e9
	BzUWodNJMVf0Tf4G5sdXuJOxbTsngZWfa29hoir2w2lSaBJFlasRHzSa6VayBtVdclMI+GehOJj
	evA/NQNMdt3hGRr3Zv+/duv9HHtl7AncvzG3dPoubT3M7MP4cXxchcpFf8+6KEp6edyjJ2IhL9e
	hcB7owSfLN69u+U8nlf/egAVrBezcC0Blcg5qY3CLtH0oAFilSCYJXUNEajkFj/87oPIYxwY5r1
	SpdPPM1Y/h+Lbu5IbaeJAwnXJSM
X-Received: by 2002:a17:90b:2e8c:b0:3a2:b09e:784d with SMTP id 98e67ed59e1d1-3a2b09e7a74mr1078732a91.45.1790557893540;
        Sun, 27 Sep 2026 18:11:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:11:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 00/22] lib: Rust implementation of SPDM
Date: Mon, 28 Sep 2026 11:11:01 +1000
Message-ID: <20260928011123.450800-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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

Alistair Francis (15):
  virt: coco: change tsm_register() to use a const struct
  rust: add bindings for hash.h
  rust: error: impl From<FromBytesWithNulError> for Kernel Error
  lib: rspdm: Initial commit of Rust SPDM
  PCI/TSM: Rename pf0 to host
  PCI/TSM: Support connecting to PCIe CMA devices
  PCI/CMA: Add a PCI TSM CMA driver using SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  lib: rspdm: Support SPDM certificate validation
  rust: allow extracting the buffer from a CString
  lib: rspdm: Support SPDM challenge

Benno Lossin (3):
  rust: transmute: add `cast_slice[_mut]` functions
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
 include/linux/spdm.h                      |   37 +
 include/linux/tsm.h                       |    2 +-
 lib/Kconfig                               |   17 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  186 ++++
 lib/rspdm/lib.rs                          |  160 +++
 lib/rspdm/state.rs                        | 1121 +++++++++++++++++++++
 lib/rspdm/validator.rs                    | 1091 ++++++++++++++++++++
 rust/bindings/bindings_helper.h           |    5 +
 rust/helpers/hash.c                       |   18 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/error.rs                      |   18 +-
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/str.rs                        |   13 +-
 rust/kernel/transmute.rs                  |   71 +-
 rust/kernel/validate.rs                   |  229 +++++
 36 files changed, 3545 insertions(+), 135 deletions(-)
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
 create mode 100644 rust/kernel/validate.rs

-- 
2.55.0

