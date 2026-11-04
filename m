Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833545;
	b=tOe8ieTTtOtR0SkemHw15oyjDAc2G0vkX+feoTcNSighUGr/lURGxm8FEqQ6A00F6Zg8
	 wNgoZ+qIoTIkAlJ5Cr8sb7Q7qcCJjU0ybrcJg/C7ly3L1Ufj8Q0y+IophC2uGj+pxVkYY
	 r2gWfXG1dOo1m6Uoo/qw8bSMBOPyTiYLbOsdWj/GwMM/vT12Yh7+2mX2WoMPL3wT1NeQd
	 5w6lNmpWKoD+YdnqPw/4bzKoK8xToaxw6C/sDjZ0xwfogWzu7dRFlU0XpvldudzmjxU1Q
	 HFi9gb4UPt4dDs94PznT3kAOhmYSOg2/qyZ3aJrqpIj/t25Wk1xT/9Ut1Coeb9SneNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833545;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=MR2cYY4Q14cb1mTzW3PW6d96tfmpHwQ/1UzDZFdsFbU=;
	b=0KSQBuOY5qBm6lb9y4hhLwBVEhfzFpJp0mNFj/AiGBX6qbDyKkkTKTAvX8NnwrmCpnBh
	 wJbGglGKpJMnJU1AwynWLSspE+bhphbNVlWPHQDu49oHBhGE8Nx9KBGqRzLIAwAIdHwfc
	 754tZtpW92FEg48LyKrQI5sFFyKGKPdzYiY0143EGCNHFgnd/7IIBEKK9gL5ta1qew+Z2
	 fmJlOPoJKXVc5dhyDo0RJjCuD4GYoH0lnXUBysVNYioKQSQq8/IOcogqElUqPk9JmKg+h
	 Id4iamE88bVmtKm7NGEdxCy01L3Va+wtDH0RhVIBjiHU3A3XLYJpqPQctq3DYPkkOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oFr14maV;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E8606D80F;
	Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB0E8606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oFr14maV
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKgyq5ZYHzMlMf;
	Thu, 05 Nov 2026 00:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MR2cYY4Q14cb1mTzW3PW6d96tfmpHwQ/1UzDZFdsFbU=;
	b=oFr14maV/xph0azj+VRd+Nhmtar/Ej08MYiElqrREJDJg8Z+9X7ULd3usML13RV9A13d7c
	ZoQw/16gQdiWVEfH0iSlKdGVLZ6uBkrnSF8rujd2NSqx3mvRQ1tAi+TlFdNGcWBMD46sL8
	3xBEQgAZOjQjM70HfvUrTXmflauHbVmMANeYZrGMSvb2LXIHKXrnhxCZNag0CaOvEk6rqW
	xNtg5zoZTTxEFiYmo9qdeK+52uxWvmusFMWwZmQec1YcdCGgboYUdSVWXMDuL9MyT8QnQp
	/RWpupGuvf96jQppfZHi0euoIrVqiQiC8uER3qAuvVHe8YDd+bwhKSuRj15+6A==
From: Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH v4 0/7] samples: rust: add an EDU PCI driver sample (MMIO +
 IRQ + DMA)
Date: Thu, 05 Nov 2026 00:05:31 +0100
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwW7CMAwG4FdBOc9T4iYZcNp7IA5N44CljXZOG
 zGhvvsCQ2ITQhx/S/6s3yeVSZiyWi9OSqhw5v5Qg31ZqG7fHnYEHGtWqNFrbywECzLlEYaOgeI
 EUbiQQENOx4AxtjqpujwIJT5e4M225j3nsZfvy51iztOnZDGggZqE9s0Et3Ld+2fLH6E/vvayU
 2e04B8I9UMIK+RT9H5pE3bG3kPNDVoafAg1FXJRB+dWlhyG/9D821voa6p/HK/l5/kHj0tqU2U
 BAAA=
X-Change-ID: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=7850;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=tjN14DZJEDbWu88sp9xGlCDPZD/MWKiGBNaWMN5FgVw=;
 b=4cNaSjA3o64G3TwvLCa72Zdi/5/QEue8+2W1+1jH4sveFv8pO9yiVVuBiAR9ALcYaSmy6xX2d
 5w97Q2d7wYzCTj3dpZ2flVtCCguzbwOQG/UYJVDgX6x76bAFH+jCgmD
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: r85b5xyrfd8ayp4369pqbao5z6m41phr
X-MBO-RS-ID: 3e67244dc2d316f77ed

The Rust sample drivers currently exercise PCI facilities in isolation:
rust_driver_pci covers MMIO and rust_dma covers DMA, but there is no
single in-tree example that combines memory-mapped I/O, interrupts and
DMA in one driver.

This series adds one. It targets QEMU's `edu` device -- a small,
well-documented educational PCI device that supports exactly these three
facilities and ships with any recent QEMU (`-device edu`), so the sample
runs without special hardware.

The sample maps BAR0, reads the PCI configuration space, and runs a set
of MMIO self-tests (identification, liveness, factorial), allocates an
MSI vector and registers an IRQ handler, and performs a DMA round-trip.
The IRQ and DMA tests wait on a `Completion` signalled by the IRQ
handler; the factorial test polls for completion.

As requested by Danilo in the v2 review, the sample replaces
rust_driver_pci, which it covers a superset of; the removal is the
first patch.

Prerequisites that had to be implemented:

- pci: rework the device enabling API: replace enable_device_mem()
  with enable_device(), which returns a DeviceEnableGuard that
  disables the device again on drop, so the enable count stays
  balanced across unbind/rebind. This follows the design Danilo
  proposed in the review of the standalone patch [1], which this
  series absorbs.
- pci: keep `set_master()` on `Device<Core>` and require a borrowed
  `DeviceEnableGuard` for the same device, preserving callback
  synchronization while ensuring the device is enabled.
- pci: add PCI_VENDOR_ID_QEMU (0x1234) to pci_ids.h and expose it as
  Vendor::QEMU, so the sample can match the device.
- completion: add complete(), so a single Completion can be reused to
  wait for consecutive events (e.g. back-to-back DMA transfers).

The series is based on rust/rust-next.

Note: DeviceEnableGuard drops from a bound scope, so pci_disable_device()
can race the pci_dev bitfield word as discussed in [1]; that race
predates this series and is triggerable from sysfs today. The bitops
conversion is under way separately on linux-pci [3].

Tested with QEMU `-device edu`.

Not taken from the v3 review (Sashiko):

- The IRQ and DMA completion waits remain unbounded; missing
  interrupts can block probe.
- enable_device() uses pci_enable_device(), not
  pci_enable_device_mem(): it is the single enable API Danilo proposed,
  and enabling I/O decoding is harmless for memory-only devices.

[1] https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org
[2] https://lore.kernel.org/r/20260719153631.559341-1-dakr@kernel.org
[3] https://lore.kernel.org/linux-pci/20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org/

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v4:
- Drop "rust: pci: make Vendor::from_raw() public" (and its R-b tags);
  instead add PCI_VENDOR_ID_QEMU to pci_ids.h and expose it as
  Vendor::QEMU (new patches 4-5) (Alice, John).
- New patch: pci: require a borrowed enable guard for the same device
  in `set_master()`, retaining `Device<Core>` callback synchronization;
  convert nova-core. This enforces enabling before bus-mastering
  (Danilo) while addressing the concurrency concern (Sashiko).
- pci: mark DeviceEnableGuard #[must_use] and enable_device() #[inline]
  (Sashiko, Fiona).
- completion: reference complete() from wait_for_completion()'s docs
  (Gary).
- samples/edu: turn init() and the test helpers into methods on
  EduDriverData; rename init() to selftest() (Danilo).
- samples/edu: initialize EduDriverData in a single try_pin_init!(),
  holding the IRQ vectors and registering the handler with
  irq::Registration::new() instead of pci::Device::request_irq(); run
  selftest() via pin_chain() (Danilo).
- samples/edu: make the magic and DMA base constants local to their
  users; check the magic via an IDENTIFICATION constant (Danilo).
- samples/edu: describe the DMA and test IRQ bits as fields of
  IRQ_STATUS/IRQ_RAISE/IRQ_ACK instead of a DMA_IRQ constant (Danilo).
- samples/edu: model the DMA registers as a struct accessed through
  io_project!()/io_write!().
- samples/edu: compare the liveness pattern via a Not impl on
  LIVENESS_CHECK (Danilo).
- samples/edu: replace `as` casts with safe casts (Danilo).
- samples/edu: return IrqReturn::None for interrupts that are not ours
  (Sashiko).
- samples/edu: depend on 64BIT for the 64-bit MMIO accesses (Sashiko).
- samples/edu: expand the commit message and Kconfig help to describe
  the sample's coverage, QEMU usage and the 64BIT requirement; mention
  the MAINTAINERS entry in the commit message (Sashiko).
- samples/edu: ack stale interrupts before registering the handler
  (Sashiko).
- samples/edu: spell out why the IRQ Registration is not leaked (Ewan).
- Drop the dependency on Danilo's irq Registration rework [2], now in
  mainline.
- Rebase on rust-next; adapt to register!() `base:`, Option<&IdInfo>
  in probe() and the Coherent read_val()/write_val() API.
- Link to v3: https://lore.kernel.org/r/20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org

Changes in v3:
- Absorb the device enabling rework [1] into this series, redesigned
  around DeviceEnableGuard as proposed by Danilo; convert nova-core.
- Remove rust_driver_pci, replaced by this sample (Danilo).
- Add access to PCI configuration space (Danilo).
- Rebase on rust/rust-next on top of Danilo's irq Registration rework
  [2]; register the handler via pci::Device::request_irq().
- Use vertical import style.
- Link to v2: https://lore.kernel.org/r/20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org

Changes in v2:
- pci: Vendor::from_raw(): collected Reviewed-by from Gary Guo;
  wrapped code identifiers in the commit message in backticks (Gary).
- pci: enable_device(): collected Reviewed-by from Fiona Behrens;
  made enable_device_mem() #[inline] and added a cross-reference to
  enable_device() in its docs (Fiona).
- completion: complete(): tightened the doc comment per Gary's review
  (emphasise "single", drop the internal-counter detail, drop the
  complete_all comparison).
- samples/edu: take &EduDriverData instead of &Arc<EduDriverData> in
  init()/test_irq()/test_dma() (Ewan Chorynski).
- samples/edu: simplify wait_until_compute_has_finished() to forward
  read_poll_timeout()'s error via inspect_err() instead of returning a
  hard-coded ETIMEDOUT (Ewan Chorynski / Miguel Ojeda).
- samples/edu: Rebased on rust/rust-next and adapt to the updated
  pci::Bar / device::Core lifetimes and pci::Driver::Data<'bound>, and
  obtain the BAR via into_devres().
- Link to v1: https://lore.kernel.org/r/20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org

---
Maurice Hieronymus (7):
      samples: rust: remove the rust_driver_pci sample
      rust: pci: rework device enabling API
      rust: pci: require an enable guard for `set_master()`
      PCI: Add QEMU vendor ID
      rust: pci: add Vendor::QEMU
      rust: completion: add complete()
      samples: rust: add EDU PCI driver sample

 MAINTAINERS                     |   2 +-
 drivers/gpu/nova-core/driver.rs |   9 +-
 include/linux/pci_ids.h         |   2 +
 rust/kernel/pci.rs              |  45 +++-
 rust/kernel/pci/id.rs           |   1 +
 rust/kernel/sync/completion.rs  |  13 +-
 samples/rust/Kconfig            |  14 +-
 samples/rust/Makefile           |   2 +-
 samples/rust/rust_driver_edu.rs | 475 ++++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs | 198 -----------------
 10 files changed, 547 insertions(+), 214 deletions(-)
---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

