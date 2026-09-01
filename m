Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D22389115
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224643; cv=none; b=Zwy1fxKpJNfjcyU006NfQjOBbEqD3xn66RpkHcCv6UtkoKpsAPhJKN6t3pWIKe4i+FkXiSsuWS5w9g4DmUf5PtYn292781OX+ouQPgpfmyW0yJzARpcr7x9VfJRMv7p4OeRVJEsnmtKMZ5jt+L1NLvPVrfpT65qA4U2/on3PaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224643; c=relaxed/simple;
	bh=0N7PZFteYPmAdCXOV/1Ri00KQjA0+w/H1rYBhz7BBzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQT8cE326vQdU1Geo5JLzFnv4f2LBDIYKT33feZuxdVLB8biS5CmAmTeiRFM8Z7ltvY5C0RXB0SsX0z+kiFe16B5MVf4iFRbYIdj1uV8MC8PJSq5qe9wV7q9YTLisULqL0ojNiamYUmNuLLZyqeBjnQiSvgKNe/K1aVGDasrQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZsNlE05; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZsNlE05"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cace91f112so34148535ad.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224641; x=1788829441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWR/AgMdqB4Pk8bTidltEk6Rcw76/YkJaVkIRSZ9AmY=;
        b=dZsNlE05r7kiAEuSerS7zkQaeQ6ZI66/+jNaO05wgRJS5cIB61LkTcD91nYT6KQeGy
         IfooLJj1APQtKdyQntzmCwdI31zmzPBu2ki+H/3izpmmJ/aBGL7Jied2G/mBITgCdSpE
         2t85yQWtB+ImUErSQyi0VQp6gORooPEOpW2dDxz99PLHHRveDamOTSdKYjJCaktESoC3
         PPTaHHD0OLUamnJPX3qDpmD3hUeRHTX08VSgv4R0l7cCWNDl5yXZvIVOMdNyT9lQsbjn
         AJkxGtK+oSyDsQcs7NV0UuMtJ4j3SauujtB+U9AsIlQKBRaBOwb+md9NhovwPtHpKOnM
         HQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224641; x=1788829441;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jWR/AgMdqB4Pk8bTidltEk6Rcw76/YkJaVkIRSZ9AmY=;
        b=VkKc+4aGuNHmgmrLGFAFytOMgeSEn5BE8kNiznqzmgx1ynbnE8/5ak+g7f75has45K
         737xmpMZdpCzm/LLDEnSwwpRDebbV8Dap9AePfOF0ZeAsNvti0nedRGEpxIF1qYN+MZv
         lUsoLSrPQ2AlZpkLbKzp3h4vmK5qvKX4vCkB+6a8AKm0CUxUZ/VeJ/xx+GXnrqEFR3aC
         c7OuTceHNSbsGQffjEAcl9GbC8UelRhTn9358snayG+E2znUmfqV/G2yopbbPvYm4D8L
         Iz0KqjIw4SkwniHRndnX+PQBRB3KqWOf308rdKDzd8M134xZu+rGuH1Z42UhZHkCgegI
         PAoA==
X-Gm-Message-State: AFuF++nmHDlgyKTWPrPd3A7C7wJhTHrlaZTARk+so4RAt8Eq5CYUkhlF
	lKZot0i/tzCjtY31AaWtOTxomgZIwlFWs2/nluGnTWyYZ4fJprP23nq6fcg0fA==
X-Gm-Gg: AYBFou3+l0ApOFcewF7tCdsZy5MGlnTi5Xt4F97tR0YStzX1oWc2Xo+QUzx5akFxAfH
	G+EZTV/Tm9GTxD8yiYPPstDc2XjPkQQOzxM7r5NIeVwXaQJw7zZRWHO1OGStdEMSmdIez1t1nUc
	/lGkoHbgO40CT0znGIE7fmqpo+NvgkDIDYQQlQj+a7mXI68USM89Z5JDouTdp6lf3ngVzAZzjN0
	KSDWpP2aLXjdon+xG75MdAFXIA6+1saCSnCC6/+hOsoRIIR7vbvBYytpqK38jqIsH0paWn3Cv6I
	oppah2VocC9YodkD8a4mrCgsRe7TLvp4cXags1LwPKjYT3EeOIRFN859jwXjkoJRGDA3qDoslB6
	rK1AVwtRnXibrJ0n+XtnD8uT/Rqmp6kn3JPmubTFDJoItAPhnb9s+y56HTk8VGPlFNgTqK57sfw
	7NEXd3us/ae6bA5T7YDnNZu0cIhZlc/vPcMfxm4stFA/PnP/3+mqoIRkNrMKKQgsOrrWRF6hN0f
	FL/zw==
X-Received: by 2002:a17:90b:2783:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-3989beb6352mr31989254a91.20.1788224640516;
        Mon, 31 Aug 2026 18:04:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:03:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 00/21] lib: Rust implementation of SPDM
Date: Tue,  1 Sep 2026 11:03:26 +1000
Message-ID: <20260901010347.2614656-1-alistair.francis@wdc.com>
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
  -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe \
  -snapshot \
  -serial mon:stdio -serial null -nographic \
  -kernel deploy/images/qemux86-64/bzImage \
  -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '

ls /sys/devices/pci0000:00/0000:00:03.0/
ls /sys/devices/pci0000:00/0000:00:03.0/tsm/
cat  /sys/devices/pci0000:00/0000:00:03.0/authenticated
echo tsm0 > /sys/devices/pci0000:00/0000:00:03.0/tsm/connect
cat  /sys/devices/pci0000:00/0000:00:03.0/authenticated
```

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
4: https://lore.kernel.org/all/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch/
5: https://lore.kernel.org/lkml/69e19c80b892b_fe0831000@djbw-dev.notmuch/

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

Alistair Francis (14):
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
 drivers/crypto/ccp/sev-dev-tsm.c          |   12 +-
 drivers/pci/Kconfig                       |   14 +
 drivers/pci/Makefile                      |    5 +
 drivers/pci/cma.asn1                      |   41 +
 drivers/pci/cma.c                         |  275 +++++
 drivers/pci/doe.c                         |    6 +-
 drivers/pci/tsm.c                         |  115 +-
 include/keys/asymmetric-type.h            |    2 +
 include/keys/x509-parser.h                |   57 +
 include/linux/oid_registry.h              |    3 +
 include/linux/pci-doe.h                   |    4 +
 include/linux/pci-tsm.h                   |   30 +-
 include/linux/pci.h                       |    1 +
 include/linux/spdm.h                      |   37 +
 lib/Kconfig                               |   15 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  184 +++
 lib/rspdm/lib.rs                          |  167 +++
 lib/rspdm/state.rs                        | 1230 +++++++++++++++++++++
 lib/rspdm/validator.rs                    |  554 ++++++++++
 rust/bindings/bindings_helper.h           |    5 +
 rust/helpers/hash.c                       |   18 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/error.rs                      |   18 +-
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/str.rs                        |   13 +-
 rust/kernel/transmute.rs                  |   59 +
 rust/kernel/validate.rs                   |  216 ++++
 34 files changed, 3071 insertions(+), 130 deletions(-)
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

