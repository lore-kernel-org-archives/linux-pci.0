Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDB36E48B;
	Wed, 12 Aug 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564379; cv=none; b=kEC/lDSk/3KYxLyDKObaU+zynC64egehugkjqcbMg7LGJmK/5Ix+bGbpdr4mQJ7yCbPeLRmP1abo3d7I4Jb3wGtg283NyetzQv/RsSHfMC0H76TNbYSlzgSQKYVqw7TNaN9svuKs6GsXK/+yRcBz9RpJaKJ0drjtHRGnkyYhT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564379; c=relaxed/simple;
	bh=ryMndI5dMt7MnECYtwtGRCAXvGKaWyr5nbwIhc9P6LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGlyKMD2mmcuYok5eEGyM6od4BkvoZnmcA3Z4Vq62qGHLmLV9R1SU+CmUADCXYoJFXdbIw9nOuuzkiAfYtUd6DiMF45lM6vfZmXiMH5YzNaqJEUszEIRwgnEx84R2Xf/EFvwAP4rf9EK5PT1lkvRQjCJ6Ww1kc3XCT7mhH3luE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Gb2XwkvI; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lHZD+u9k; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Gb2XwkvI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lHZD+u9k"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKzgB5QyLzKsCB;
	Wed, 12 Aug 2026 21:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeV/0Qwp/fe3MBvHcKkC8DCA/72k4r0efJC25hKgDBU=;
	b=Gb2XwkvIXlQWo+QWc7Iie6lW76r6M8bmmbO9LNJwr6B0tEyF4s57JTwWc+du4vbbzQnrRs
	+R7cXIstXeRWVjHy3Fb0F38D/SHPAODh+8tw/6HK4X0P+WIdHQ60YtrBBdl99nKRp/6loF
	nX48z2xZLITa/UVIZ4cjlB8/nJR56j3/LKfVsgNgKvoIu01qXvGUZqMPxaKXnzcQoVe9oA
	OAJmzxg9socsvpklv8tmuxG/WvnPixuTvSFLeyDbqgS23TjQDCgwwC0OtH1nIxbKxdK0IG
	bO6CvgM6cH39JYN6+6yHqNC172tfMuOXAuby2pDIsZELpPC4dYJ1zz/g8BjsrA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lHZD+u9k;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeV/0Qwp/fe3MBvHcKkC8DCA/72k4r0efJC25hKgDBU=;
	b=lHZD+u9kGEirhg4gfsz17ievR96n/GVe0zjSLpU4k9x5UoxR7urhlDRkaU9C3cRJSHiJpj
	iZflrh+V2nO7F1SWFDJUEUYmsfxyarmuTDhVgN8dhLkJCxyLs0ZDjPfcal89y7AP96oQxO
	Af5eNE3TaCG/owpxguy1+Bg1B5OZQArbQun2JulWtkBs1EDf+37U4b/rmFl3QmCGcuI6+H
	UeU5Pv3xszlyeOBBfX9r/fAcrosIBIlABwFSdRJpMvd3w9wF6mtLwMRip5kCerCZry0Yzd
	eSN4KJg0vEEjptF51UwnVLx9rwjeKO8N7UK1DiwhkDBnJ9/8CkU5hsjZ4l5lSQ==
Date: Wed, 12 Aug 2026 21:52:35 +0200
Subject: [PATCH v3 1/5] samples: rust: remove the rust_driver_pci sample
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-1-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=7471;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=ryMndI5dMt7MnECYtwtGRCAXvGKaWyr5nbwIhc9P6LM=;
 b=7XmYItZ+LpeRsxkVh/CV2/PIn31FnPLHJHq/hRfBK+D4LxwGQdS+x650YCnOEBq/gne39uvlZ
 Ph+RR/Bxu7bDs4tSOcmx8ps684CzJeFoiehb0/1d+AiF2DTSBteM/Kl
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: q46pu4riuj5f5dxhiqayxbuyn3c8rd5k
X-MBO-RS-ID: 96d048f2579eb44aff9
X-Rspamd-Queue-Id: 4hKzgB5QyLzKsCB

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
 samples/rust/rust_driver_pci.rs | 194 ----------------------------------------
 4 files changed, 207 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95f6791c41bc..92bc1f8c4f8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20915,7 +20915,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
-F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c49ab9106345..0cae695acd84 100644
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
index 6c0aaa58cccc..70495fed886f 100644
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
index 1aa8197d8698..000000000000
--- a/samples/rust/rust_driver_pci.rs
+++ /dev/null
@@ -1,194 +0,0 @@
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
-    MODULE_PCI_TABLE,
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
-        info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let vendor = pdev.vendor_id();
-        dev_dbg!(
-            pdev,
-            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
-            vendor,
-            pdev.device_id()
-        );
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

