Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797623AE62
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210245; cv=none; b=DFh5BEAH/rguqoKB7EHbWYWN8SQ+6j6dJScJAFERld5XoGPzQqovHDjnllnp2f4A+lY+hYtbh/ZIbAQH+0QJVgotx700vRCDOte5VfhX5naQXSwi+BO2aGC+LocsRteFfjo5SzYPfsTm9u3PJCoBbENCHGR88lNAFIFQ4t5Zi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210245; c=relaxed/simple;
	bh=olWEdOC0npplVm/+buubaUjCS1b7j/tqkVFbPLXQiHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TU5hRnR8ulP+3MTQNiEacg9kMd1fgtaYXI3NSz6yU2aG8M7I5UUil6wtDmN2q3pSy8RVVn6sbCxEN4KBiAHGT56EozxwK/s87P53HWLCM+ZMo280jWP2GUK4Fp4AtHT0fBZlmnnKOnvG5ELDmDRYXQg//AftJBgQqGzcl7z+Ewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiSk8ZWy; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSk8ZWy"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7980c060cfso660692a12.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210242; x=1778815042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bis4g28b9JZNcXJXn6/4Wkgj50FVt3cnNrHRU3VMTEw=;
        b=IiSk8ZWymzWQazaVn/OelvOm0vt83ny7x4TNvh2Usgwwz+SR809iwWZNAknwc33WP8
         mOdQ1QEAUvZ8+BZvIyL74MVEkmHQ1ELC7q0G/h+wF6sbsDXqDV+Cvp6ecPMBgIwp+4kJ
         6PTHbpc28u875YFUnyE0KSNe5xWViCj2SZ5V5E3twsXqOjWvc25tdXjpOuBQRZjN+w2Q
         YZ8auPcQ4uq7hNxZ8G0eGLIT7Xu0+iIz1MHZJPkQ8XRsAOhE+9hQcnmMxqmqnpZ+PneZ
         wdJ9tL5P48GZfXY5PCJhKROf+sFdI22UXt/u0iK+gr/5CTcdQzI4n8U93FlGtQtR8haS
         PjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210242; x=1778815042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bis4g28b9JZNcXJXn6/4Wkgj50FVt3cnNrHRU3VMTEw=;
        b=ePH03d8tPzzjSgzZlIgbSqyF/97HmGA2Fibbu+iRXuz1fSn3iOmj2MzruT8VG/GQ3G
         l1mDUaug3PxwXc2CLSrHrwKmJOgT7xhumaNluavXu68jzWeda1F7yzgB/vtN0pwwNdGx
         XvGdtKpzuaq4Mbnhz9ntFCkJGxuEJrAriIifMAEX1nbUJhBHdZp2RIacYEOEtH28t8vW
         U8NQB5jddetprDJI5aH972AiLD1qnP2GSVtjgPWvj6P/fTwjuEUGk5dYN1l7MhbSrT08
         akfRARBTyqYga6ycripJAfutv9HkqOAQ0nDGX9QZxGCY3bCefRf3zix84SIRubu6WqVe
         pm7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8vI+/DH0O0Fsf+ESZ8n3qpBDGxqc7RS2Lk/eMVyIjpv2F2XL1teWBazEQy/SlAhIsqIAGB/2vFkaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztINMahrdtOsuQKwatdDeXwDVNom2gMRrXC1zlovw8ANLEDaZ1
	LQnM2pubY9mzdOeTVvJf5a/rWEEIZfbeQJNbLFgt548cgj/RE0jdjS6J
X-Gm-Gg: Acq92OG+TZOm4EP1I3/Ob0wN/h3pbX4dnjPW30uB6SPMSBoASQeewKTgz2u4WdV1H9x
	9nMpvvo9JMOsMI6aV34Trscfk3xiIH6HVTyq5C2vB6JibJOwk2Q2lkpRrRycRLBKr067++2b4lp
	rQYghynHD0PPHzdYwFxAWrSYOIVI057nIpLPNKyPXygydFAT77VnReCdk0zy4zpClKaMIxGG+Ro
	0lKlOeY4R5W0HzH5r2mbTdFo9ABW/vrgCNK1pkthDDGuqEDfxlf3g4rDhLfDlO5D9z0gW9cJpPa
	KS2Ys3U+f/tNAi1nTBmSzD6G2GOSb2MQo0sG8GwQMhG1w7TRV9dEq6lrKxLXSSWSVswrFXfjDNU
	gqlJPGo5YF5StjNbuEZQ5JUFiiDlTsQF2IVhExOk6P8HMzwZ/4Uws4PorR5OtNFM8dUn7MjLeai
	K0LeRY71Q1sPY6IcuCB/xWkIJKNDJmWIzuSkp+vgtx45xe84N9usB+KNC4HJbI3w==
X-Received: by 2002:a17:903:186:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2baf0cf4251mr10476125ad.1.1778210242377;
        Thu, 07 May 2026 20:17:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:17:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 00/18] lib: Rust implementation of SPDM
Date: Fri,  8 May 2026 13:16:52 +1000
Message-ID: <20260508031710.514574-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
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

Alistair Francis (13):
  rust: add bindings for hash.h
  rust: error: impl From<FromBytesWithNulError> for Kernel Error
  lib: rspdm: Initial commit of Rust SPDM
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

Benno Lossin (1):
  rust: add untrusted data abstraction

Lukas Wunner (4):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  PCI/CMA: Validate Subject Alternative Name in certificates

 MAINTAINERS                               |   13 +
 crypto/asymmetric_keys/x509_cert_parser.c |    9 +
 crypto/asymmetric_keys/x509_loader.c      |   38 +-
 crypto/asymmetric_keys/x509_parser.h      |   42 +-
 drivers/pci/Kconfig                       |   14 +
 drivers/pci/Makefile                      |    4 +
 drivers/pci/cma.asn1                      |   41 +
 drivers/pci/cma.c                         |  262 +++++
 drivers/pci/doe.c                         |    3 -
 include/keys/asymmetric-type.h            |    2 +
 include/keys/x509-parser.h                |   57 ++
 include/linux/oid_registry.h              |    3 +
 include/linux/pci-doe.h                   |    4 +
 include/linux/pci-tsm.h                   |   11 +-
 include/linux/spdm.h                      |   39 +
 lib/Kconfig                               |   17 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  155 +++
 lib/rspdm/lib.rs                          |  180 ++++
 lib/rspdm/state.rs                        | 1070 +++++++++++++++++++++
 lib/rspdm/validator.rs                    |  524 ++++++++++
 rust/bindings/bindings_helper.h           |    7 +
 rust/helpers/hash.c                       |   18 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/error.rs                      |   10 +
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/str.rs                        |   13 +-
 rust/kernel/validate.rs                   |  605 ++++++++++++
 29 files changed, 3091 insertions(+), 64 deletions(-)
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
2.52.0

