Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB333065D;
	Wed, 12 Aug 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564372; cv=none; b=PV/lF7wciUaH5TcpA2RKF2XAsXh70YZafVCzQIIHJc55tdDyKnWTtsiF6aguz5Nd4Rto1MFM1PSeiTcZs+bZcltsMtNmR+PdhmdE0D2Q0liUFwYaZcv7RV9jDi0CF+cQWCML2IqhQ5P25Qfo9OTTbizAkMDlTCFoxGm2cApP7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564372; c=relaxed/simple;
	bh=nR6TSx/d0itVYNJ02OsDsJtu7gv2QlTRkENcKcCmlXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kjb8kHz9gzmeoYGBx4OGW6y8d7U5NWM/E4m2xrv3inbunLV62OxD8e8qa160UK44DKlOERMHLY3Q7RtiG56nnNsqJTfmtKXp7/Nsa9E5VABuEc3yWYU7rdRCywthQcD5o8XwV/stXhM1eZ0X3DxE7DdKg8wm+wEeMeSyhOMlDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sGnElibv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kb+UCJyW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sGnElibv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kb+UCJyW"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hKzg42k9rz8trG;
	Wed, 12 Aug 2026 21:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NLhi4ZLjDXG/c04c+xT2qKYjmJN2aLYRZErpNT0+BbA=;
	b=sGnElibvb5KvuwPU8Q+rNSik2Cr2PNdqyLyRXDXy4HJgWM1ZAmIc0naVeaYbDSCT+gEzps
	ZM0ANrIdK6sDMqqNYR/kwmqMmiCvAL2mSVM39LeD7i5t2eDb5+o/X2rlrhIgzdNe2Tmg5i
	qCoBwfkyHbrE2l39/W+paYFvSlfcD3daKsYcOE1wTeklBnR745SKU9CV2AkS0M6W7X24Xv
	y9V83bcvZT+j51D6+Wlg3b65RlWli1VptfXq0cJYWKzeyjMA+NMma35v14WYhtjaAV/kzm
	H/mWVXr0iKxyhv1diPyIr7wwOlTwZ+V8d6cwzm5bNmMLPlLf2gQZviN6lE4xAA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kb+UCJyW;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NLhi4ZLjDXG/c04c+xT2qKYjmJN2aLYRZErpNT0+BbA=;
	b=kb+UCJyWl7YHA1htV8MGgZcDser2kx2iPdgBC/7scED7kLl/2GSOEsJFQFDCs3ZHseRTJE
	GrM+rl8GcExsK1ekaU89VQ5O44R+F6vaPrvKnrg7ORgVdM55PH86z9Kwrns5t2USjUyL+W
	8pu9bfTXjEFkNKUN5mm+1MXDDGIvQKfNP+kZxnCOsuZUJU2Fw+iWlKkXditf8NL0GgnmT3
	wlDwMzBkIybAttBUnIkdY6TuFjQrQcOizVgdxo0CINnwdXWiqehQaxfwK9/Gb8dI/fE5cs
	KYTCBEDn3Z2cr+jWkB/h6h4DIGHZYJtisApLo1gZNcOYBmcd2cNmOV7PyFPtuw==
Subject: [PATCH v3 0/5] rust: samples: add an EDU PCI driver sample (MMIO +
 IRQ + DMA)
Date: Wed, 12 Aug 2026 21:52:34 +0200
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPy2rDMBAF0F8xWneC3rJNKfmP0oUeo0QktlPJM
 Skh/17Z2bSL0uUV6My9d1IwJyykb+4k45JKmsYaxEtD/NGOB4QUaiacck01k+Ak5GuZ4eITYLh
 CyGnBDAIVDY6HYGkk9fMlY0y3DX7/qPmYyjzlr+3OwtbXf8mFAQUUkUvDnOqU3w82nd102035Q
 FZ04T8gTv+EeIV0DFq3MnLP5G/o8ayb8fNa58/PzmTAUuw2v29etwuGdUwJLdhOqU5IBgyCPeX
 9CfOI59V6W5c7WxD8NAxp7hsthTVeUO1aj4IbKYKMnQzBUOpb1bYOhUGta4vHN6OaAoiMAQAA
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
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=5126;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=nR6TSx/d0itVYNJ02OsDsJtu7gv2QlTRkENcKcCmlXs=;
 b=PYqX0rSRrfB0i29HyTewywP8ANjZYStn9kQfVhTrtLFS17nH+HPMf/wrmJzpQLmc/ruoYPMeE
 P6ATvjS6fq5D47oISwejkzOyQ/cZcpYM5AMCXWS4X3hRq7VxZhU4lkq
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: gpyw9xri61ok159gcy791n1ipc8zwwtq
X-MBO-RS-ID: 71779d7d472a2538fba
X-Rspamd-Queue-Id: 4hKzg42k9rz8trG

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
MSI vector and registers an IRQ handler, and performs a DMA round-trip
-- each stage waiting on a Completion that the IRQ handler signals.

As requested by Danilo in the v2 review, the sample replaces
rust_driver_pci, which it covers a superset of; the removal is the
first patch.

Prerequisites, that had to be implemented:

- pci: rework the device enabling API: replace enable_device_mem()
  with enable_device(), which returns a DeviceEnableGuard that
  disables the device again on drop, so the enable count stays
  balanced across unbind/rebind. This follows the design Danilo
  proposed in the review of the standalone patch [1], which this
  series absorbs.
- pci: make Vendor::from_raw() public, so a driver can match a device
  whose vendor ID has no symbolic name in pci_ids.h (QEMU's 0x1234),
  matching what C drivers already do.
- completion: add complete(), so a single Completion can be reused to
  wait for consecutive events (e.g. back-to-back DMA transfers).

The series is based on rust/rust-next and additionally depends on
Danilo's "rust: irq: make Registration compatible with lifetime-bound
drivers" [2], currently in linux-next.

Note: DeviceEnableGuard drops from a bound scope, so pci_disable_device()
can race the pci_dev bitfield word as discussed in [1]; that race
predates this series and is triggerable from sysfs today. The bitops
conversion is under way separately on linux-pci [3].

Tested with QEMU `-device edu`;

[1] https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org
[2] https://lore.kernel.org/r/20260719153631.559341-1-dakr@kernel.org
[3] https://lore.kernel.org/linux-pci/20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org/

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
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
Maurice Hieronymus (5):
      samples: rust: remove the rust_driver_pci sample
      rust: pci: rework device enabling API
      rust: pci: make Vendor::from_raw() public
      rust: completion: add complete()
      rust: samples: add EDU PCI driver sample

 MAINTAINERS                     |   2 +-
 drivers/gpu/nova-core/driver.rs |   5 +-
 rust/kernel/pci.rs              |  31 ++-
 rust/kernel/pci/id.rs           |   2 +-
 rust/kernel/sync/completion.rs  |  11 ++
 samples/rust/Kconfig            |   8 +-
 samples/rust/Makefile           |   2 +-
 samples/rust/rust_driver_edu.rs | 421 ++++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs | 194 ------------------
 9 files changed, 471 insertions(+), 205 deletions(-)
---
base-commit: 643a7c306b8ce32743d4f94dd700c8588be37e66
change-id: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f
prerequisite-message-id: <20260719153631.559341-1-dakr@kernel.org>
prerequisite-patch-id: 63224325d5ec73f06517bb35f8c366a086bbea19

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

