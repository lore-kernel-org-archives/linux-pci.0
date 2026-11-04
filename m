Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833546;
	b=KR1qVxuuFiUplzIKxLiPV5uIHcukCWkYJFpezSSVlK1NNPksEMeuUgmkerQlcjP5BPNy
	 gG4vms6kBAawlSMsJ5HJqHVnqrMx/5uiCJvVnlCaiLljFxZsbwvr2D98PGuPBlU08aHkR
	 bmh2lYw4S7NXBoXAWN7lETwlZPRUVPD1NtYxIFodquvhIghkKdHdrO8yMtw3fFB2yrXOi
	 P9j1AC+qXDNX5R6OAdZeKSSrNVB4Jj2OwziVcCtt/7h7JiJgYkuTML0fkxZ+N+VvrrRFa
	 OoUavbWUxtorHmhQS2OBVf+TMxTgNnNuvBZO/X2hNOOw1j07QX21v+35eiAdRAmzIDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833546;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=AaRO3QDvvLpHjYw6CqEO2va4UH0c/RWfxJ9Mylj/Qrc=;
	b=wxH9tUE7v5YpycGs0GvI31nK8UeLxYlLKOVyZ/9/VhbAvPKrrYLkp1oqVmxj2ZPtuaEM
	 qcP1PAHJNpo3CLNyW+EHzYoJAFEJjaKiBkh+sn4oMIWnPsBs5Q9DUqFXvCskMqLqy/8W2
	 g2kP24WqfxjkRWqzoePcc8mRFjxaKIKzTd/dxYh5Nph0V9Ye9EbpiyYvtXsfWpSjTJtan
	 01w3U/1WpsxQ3/D+WaGXDuOq14B8cIq/0HtaICv2vub9lpE9I1R9qLEjugJbSObx8xeFi
	 Kjx7x9NrDRLzNEG8Dh2vib3WHt68KZhvXxvJ2IUhz3Qt7qMnZ9rc6fhzwMFeNGXqGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=CrQnbmTi;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66C606A33B;
	Wed,  4 Nov 2026 23:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE66C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=CrQnbmTi
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKgys4lsZzMlTy;
	Thu, 05 Nov 2026 00:05:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaRO3QDvvLpHjYw6CqEO2va4UH0c/RWfxJ9Mylj/Qrc=;
	b=CrQnbmTi2PcqCseFfkQnNgUU7OOO/JNAv3LutsV5QuIUQ/A/4IsS58OXhSfLHANmJxoHBF
	mjw7foUvylvySZKLNzDdYh8LzqyrAPitEDj5ODc/gqE5T3t/cShxgWiMXdABb4/gDNp4z2
	838ZWoEBuSSGcptoXMAnLbUGRykgoB2GYeZsWZ44ZY4fDkTYx/jXMXpO+AQJtE255Kcm4G
	OVlL5gJlARtd6YJ9dSCAFVkW13nwseFA5S4NtrmBjg1qqp1xLlyOWdXbYLV8e9JwfOElSV
	YjgmGQiAjznEvYpI9R0GJzEO0T/MnvHHNFqBGp1OSRabFN+v5e1BWQ6TA8PBDg==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:32 +0100
Subject: [PATCH v4 1/7] samples: rust: remove the rust_driver_pci sample
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
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-1-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=7577;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=JTGu5T/+T8r8ZW53Eqt0wl0+3nov7Lv/AUTxxgHOdaA=;
 b=zVR1APw9lTVBDrIpDM8mV/TsI5hl9DkTbfYoDz8nQi7TJPUJriqUw/5XNJKKmdGqgl+1k3xts
 5IndRQrCw3kDHWPm/Re4TcqHvoFiHW0Nk/eEufDCrX1Im2a2q04ARHY
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: g8iy4igo86myawm7nzxcht3uxnehug8k
X-MBO-RS-ID: dff117811a08da109d0

The EDU sample added later in this series covers everything
rust_driver_pci demonstrates (device matching, BAR mapping, MMIO) and
exercises interrupts and DMA on top, against a device every QEMU ships.
Remove the old sample in favor of it, as requested by Danilo during
review of the EDU series.

Link: https://lore.kernel.org/rust-for-linux/DJEQ64V8HE19.2DMBHY4XRPMG6@kernel.org
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 MAINTAINERS                     |   1 -
 samples/rust/Kconfig            |  11 ---
 samples/rust/Makefile           |   1 -
 samples/rust/rust_driver_pci.rs | 198 ----------------------------------------
 4 files changed, 211 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a162e9bcab1..8f7f1e14b31e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21595,7 +21595,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
-F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..7fbd49df30ce 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -107,17 +107,6 @@ config SAMPLE_RUST_I2C_CLIENT
 
 	  If unsure, say N.
 
-config SAMPLE_RUST_DRIVER_PCI
-	tristate "PCI Driver"
-	depends on PCI
-	help
-	  This option builds the Rust PCI driver sample.
-
-	  To compile this as a module, choose M here:
-	  the module will be called rust_driver_pci.
-
-	  If unsure, say N.
-
 config SAMPLE_RUST_DRIVER_PLATFORM
 	tristate "Platform Driver"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..20b55e0bdbb7 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_SAMPLE_RUST_DEBUGFS_SCOPED)	+= rust_debugfs_scoped.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
-obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
deleted file mode 100644
index 13b035a95756..000000000000
--- a/samples/rust/rust_driver_pci.rs
+++ /dev/null
@@ -1,198 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Rust PCI driver sample (based on QEMU's `pci-testdev`).
-//!
-//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
-
-use kernel::{
-    device::{
-        Bound,
-        Core, //
-    },
-    io::{
-        register,
-        register::Array,
-        Io, //
-    },
-    num::Bounded,
-    pci,
-    prelude::*, //
-};
-
-mod regs {
-    use super::*;
-
-    register! {
-        base: kernel::io::Region<END>;
-
-        pub(super) TEST(u8) @ 0x0 {
-            7:0 index => TestIndex;
-        }
-
-        pub(super) OFFSET(u32) @ 0x4 {
-            31:0 offset;
-        }
-
-        pub(super) DATA(u8) @ 0x8 {
-            7:0 data;
-        }
-
-        pub(super) COUNT(u32) @ 0xC {
-            31:0 count;
-        }
-    }
-
-    pub(super) const END: usize = 0x10;
-}
-
-type Bar0<'bound> = pci::Bar<'bound, { regs::END }>;
-
-#[derive(Copy, Clone, Debug)]
-struct TestIndex(u8);
-
-impl From<Bounded<u8, 8>> for TestIndex {
-    fn from(value: Bounded<u8, 8>) -> Self {
-        Self(value.into())
-    }
-}
-
-impl From<TestIndex> for Bounded<u8, 8> {
-    fn from(value: TestIndex) -> Self {
-        value.0.into()
-    }
-}
-
-impl TestIndex {
-    const NO_EVENTFD: Self = Self(0);
-}
-
-struct SampleDriverData<'bound> {
-    pdev: &'bound pci::Device,
-    bar: Bar0<'bound>,
-    index: TestIndex,
-}
-
-struct SampleDriver;
-
-kernel::pci_device_table!(
-    PCI_TABLE,
-    <SampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
-        TestIndex::NO_EVENTFD
-    )]
-);
-
-impl SampleDriverData<'_> {
-    fn testdev(index: &TestIndex, bar: &Bar0<'_>) -> Result<u32> {
-        // Select the test.
-        bar.write_reg(regs::TEST::zeroed().with_index(*index));
-
-        let offset = bar.read(regs::OFFSET).into_raw() as usize;
-        let data = bar.read(regs::DATA).into();
-
-        // Write `data` to `offset` to increase `count` by one.
-        //
-        // Note that we need `try_write8`, since `offset` can't be checked at compile-time.
-        bar.try_write8(data, offset)?;
-
-        Ok(bar.read(regs::COUNT).into())
-    }
-
-    fn config_space(pdev: &pci::Device<Bound>) {
-        let config = pdev.config_space();
-
-        // Some PCI configuration space registers.
-        register! {
-            base: pci::Normal;
-
-            VENDOR_ID(u16) @ 0x0 {
-                15:0 vendor_id;
-            }
-
-            REVISION_ID(u8) @ 0x8 {
-                7:0 revision_id;
-            }
-
-            BAR(u32)[6] @ 0x10 {
-                31:0 value;
-            }
-        }
-
-        dev_info!(
-            pdev,
-            "pci-testdev config space read8 rev ID: {:x}\n",
-            config.read(REVISION_ID).revision_id()
-        );
-
-        dev_info!(
-            pdev,
-            "pci-testdev config space read16 vendor ID: {:x}\n",
-            config.read(VENDOR_ID).vendor_id()
-        );
-
-        dev_info!(
-            pdev,
-            "pci-testdev config space read32 BAR 0: {:x}\n",
-            config.read(BAR::at(0)).value()
-        );
-    }
-}
-
-impl pci::Driver for SampleDriver {
-    type IdInfo = TestIndex;
-    type Data<'bound> = SampleDriverData<'bound>;
-
-    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
-
-    fn probe<'bound>(
-        pdev: &'bound pci::Device<Core<'_>>,
-        info: Option<&'bound Self::IdInfo>,
-    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let vendor = pdev.vendor_id();
-        dev_dbg!(
-            pdev,
-            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
-            vendor,
-            pdev.device_id()
-        );
-        let info = info.ok_or(ENODEV)?;
-
-        pdev.enable_device_mem()?;
-        pdev.set_master();
-
-        let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?;
-
-        dev_info!(
-            pdev,
-            "pci-testdev data-match count: {}\n",
-            SampleDriverData::testdev(info, &bar)?
-        );
-        SampleDriverData::config_space(pdev);
-
-        Ok(SampleDriverData {
-            pdev,
-            bar,
-            index: *info,
-        })
-    }
-
-    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        this.bar
-            .write_reg(regs::TEST::zeroed().with_index(this.index));
-    }
-}
-
-impl Drop for SampleDriverData<'_> {
-    fn drop(&mut self) {
-        dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
-    }
-}
-
-kernel::module_pci_driver! {
-    type: SampleDriver,
-    name: "rust_driver_pci",
-    authors: ["Danilo Krummrich"],
-    description: "Rust PCI driver",
-    license: "GPL v2",
-}

-- 
2.54.0

