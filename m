Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833557;
	b=zZyBsw6g4imZr6f8xCM/Ci5q+WQbYGN/f1s2PR9Dw16LKo+RZIMruq4fmALb2t8wLZAZ
	 JIWpRaIDnlA+WOY+eyFDNWldi2K8tPKjMeknBuXP1H7aH1bagyxUCRyv7zfncWmJ/hXt6
	 Ab/rTGBhHHIaOMWRt3x1v/6lcnKHPOgiUndGN+g/CJ83sTdBBIu82wz3HKlUKVJAtU8ua
	 Q6PmdKH/5LHqJgGlV8uPyIscWIRM11ilYqRcwxHUhgeQC9FoRoFbQIfaj0va85Hq1yKms
	 YddnwPv74mRclSX7NQLbLTGWHduKQsgxntaTJnOtgY2Wu2joNf73X36NlRjw7qhByog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833557;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=Gd1/pUAu36LdicaWhV8upkAdq9gaSWy/tET5nixqMfg=;
	b=0gzmP8ieyloR81InO4BC2+FYcYUnNgBfOothOyvgL3UNwUe6jWt/wN85ia2aSn4NonNa
	 35JsWRHKekQpKrYFIob3Qrwxmjur5mZYZ4ZwgggQJJPxEx5ChL2SxtPEar/mqFBv7LoC/
	 6HUyEueaBoo5lyS0Cm7q2x7sdNvvPLar9qbx+EiKN3xcO9ykL4xMl2MEltb/+Y1M2ctwl
	 JtDK1svPtjH3eSVgpaXlUyVHQ4aq8NnC+baaRPT7sAVgxPHo0TyoMvnU+mf5UUiwDluvQ
	 YHhcsHJqspLdI7OuaHWHWjwQOom4SN539dMVHpbERvc89P6qPjshHsvCqJFVLWR1sbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Og7an7mn;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E10606D808;
	Wed,  4 Nov 2026 23:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E10606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Og7an7mn
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKgz41mRnzKnCG;
	Thu, 05 Nov 2026 00:05:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793833552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd1/pUAu36LdicaWhV8upkAdq9gaSWy/tET5nixqMfg=;
	b=Og7an7mniSiK0QDp6XVlci67Cnyy+brKjUzbJaRI9ico6iSD3VMv4TkQZfcMSTvudK1IIZ
	NKNC8NyfGyvRkiU1EhcNVBvRLRS78C6a6UL406gTiDrvWfieMF+shEyp0uksTJsupyhq3Y
	Ynw6QwzFec9emwM3xqBz2EaxJK8uoEX6eF4GPZUEk/iYTh3hV6tSKI0EgUYPKZAykTOeTy
	/w/OJIM9lJaoyLpXZkh/8tuVALbGkiN3Qxb4YMAaDeVCfxsyGJkx0Z+ypTE9jO60ruFA8B
	hrXWcc7WuMH+NAQdeSnt0I9rjGaZx0Iv5Ja0ANAP6V/JwW2Nl+Y0GCi8+oD+2Q==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:38 +0100
Subject: [PATCH v4 7/7] samples: rust: add EDU PCI driver sample
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
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-7-20ef027bb707@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=16533;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=KgivqCul6CZFYOA322ZJRvoAe+O2U40VpojsmgPqyps=;
 b=LxKqPyb3n5RO7xCwK/2zpAT0DG7iiw8FglhuRUur+bQHbN72WfnaxTp4BjJevxHbdHdkSn86b
 ET9FuSwsW2MBLVdKOvJ8r0CLcHkD/G2Y7fD4+YeqVzO7gzEyZH2n9//
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 9ca6d5169f8f07a39b4
X-MBO-RS-META: okrsexww4ajg1rkethyb74o6hzdeq5ow

Add a driver for QEMU's EDU device to demonstrate and exercise Rust PCI
driver abstractions without physical hardware. Its probe-time selftest
reads PCI config space, checks BAR MMIO and factorial computation, tests
MSI delivery through an IRQ handler, and performs a coherent DMA roundtrip.

The sample uses `pci::Driver`, `DeviceEnableGuard`, typed I/O registers,
PCI IRQ vectors, `irq::Registration`, `dma::Coherent` and `Completion` to
manage resources and wait for interrupts.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 MAINTAINERS                     |   1 +
 samples/rust/Kconfig            |  15 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 475 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 492 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f7f1e14b31e..ec4d2cb59662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21595,6 +21595,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
+F:	samples/rust/rust_driver_edu.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7fbd49df30ce..8226a21fc5e4 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -107,6 +107,21 @@ config SAMPLE_RUST_I2C_CLIENT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_EDU
+	tristate "EDU Driver"
+	depends on PCI && 64BIT
+	help
+	  This option builds the Rust PCI driver sample for QEMU's EDU device.
+	  Start QEMU with -device edu to use this sample.
+	  The sample requires 64BIT because it accesses the device's DMA
+	  registers using 64-bit MMIO operations, which the Rust I/O
+	  abstractions only support on 64-bit kernels.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_edu.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PLATFORM
 	tristate "Platform Driver"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 20b55e0bdbb7..9b0b3d7f8cc2 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SAMPLE_RUST_DEBUGFS_SCOPED)	+= rust_debugfs_scoped.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_EDU)		+= rust_driver_edu.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_edu.rs
new file mode 100644
index 000000000000..a83095d2a988
--- /dev/null
+++ b/samples/rust/rust_driver_edu.rs
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust EDU driver sample (based on QEMU's `edu`).
+//!
+//! To make this driver probe, QEMU must be run with `-device edu`.
+
+use kernel::{
+    bitfield,
+    device::Bound,
+    dma::{
+        Coherent,
+        Device,
+        DmaMask, //
+    },
+    io::{
+        io_project,
+        io_write,
+        poll::read_poll_timeout,
+        register,
+        register::Array,
+        Io, //
+    },
+    irq::{
+        self,
+        Flags, //
+    },
+    num::casts::IntoSafeCast,
+    pci,
+    prelude::*,
+    sync::Completion,
+    time::Delta, //
+};
+
+const QEMU_EDU_DEVICE_ID: u32 = 0x11e8;
+
+const IRQ_MAGIC_VALUE: u8 = 42;
+
+mod regs {
+    use kernel::io::Region;
+
+    use super::*;
+
+    register! {
+        base: Region<{ END }>;
+
+        pub(super) IDENTIFICATION(u32) @ 0x0 {
+            31:24 major;
+            23:16 minor;
+            7:0 magic;
+        }
+
+        pub(super) LIVENESS_CHECK(u32) @ 0x04 {}
+
+        pub(super) FACTORIAL(u32) @ 0x08 {}
+
+        pub(super) STATUS(u32) @ 0x20 {
+            0:0 computing;
+            7:7 raise_interrupt;
+        }
+
+        pub(super) IRQ_STATUS(u32) @ 0x24 {
+            8:8 dma;
+            7:0 test;
+        }
+
+        pub(super) IRQ_RAISE(u32) @ 0x60 {
+            7:0 test;
+        }
+
+        pub(super) IRQ_ACK(u32) @ 0x64 {
+            8:8 dma;
+            7:0 test;
+        }
+
+        pub(super) DMA: Dma @ 0x80;
+    }
+
+    impl core::ops::Not for LIVENESS_CHECK {
+        type Output = Self;
+
+        fn not(self) -> Self::Output {
+            Self::from_raw(!self.into_raw())
+        }
+    }
+
+    bitfield! {
+        #[derive(FromBytes, IntoBytes)]
+        pub(super) struct DmaCommand(u64) {
+            0:0 start_transfer;
+            1:1 direction;
+            2:2 raise_irq;
+        }
+    }
+
+    /// DMA register block. Its 64-bit registers need more alignment than `Region` guarantees, so
+    /// project it with `io_project!(bar, try: DMA)`, which checks the alignment at runtime.
+    #[repr(C)]
+    #[derive(FromBytes, IntoBytes)]
+    pub(super) struct Dma {
+        pub(super) src: u64,
+        pub(super) dst: u64,
+        pub(super) count: u64,
+        pub(super) command: DmaCommand,
+    }
+
+    pub(super) const END: usize = 0xA0;
+}
+
+type Bar0<'a> = pci::Bar<'a, { regs::END }>;
+
+struct EduDriver;
+
+#[pin_data(PinnedDrop)]
+struct EduDriverData<'bound> {
+    pdev: &'bound pci::Device<Bound>,
+    #[pin]
+    irq_handler: irq::Registration<'vectors, IrqHandler<'vectors>>,
+    vectors: pci::IrqVectorRegistration<'bound>,
+    // Declared last so the device stays enabled until the IRQ handler is freed.
+    _enable: pci::DeviceEnableGuard<'bound>,
+}
+
+#[pin_data]
+struct IrqHandler<'a> {
+    pdev: &'a pci::Device,
+    bar: Bar0<'a>,
+    #[pin]
+    irq_test_completion: Completion,
+    #[pin]
+    irq_dma_completion: Completion,
+    dma: Coherent<'a, u64>,
+}
+
+impl EduDriverData<'_> {
+    fn selftest(&self) -> Result {
+        self.config_space();
+        self.magic()?;
+        self.liveness_check()?;
+        self.factorial()?;
+        self.test_irq()?;
+        self.test_dma()?;
+        Ok(())
+    }
+
+    fn config_space(&self) {
+        let pdev = self.pdev;
+        let config = pdev.config_space();
+
+        // Some PCI configuration space registers.
+        register! {
+            base: pci::Normal;
+
+            VENDOR_ID(u16) @ 0x0 {
+                15:0 vendor_id;
+            }
+
+            REVISION_ID(u8) @ 0x8 {
+                7:0 revision_id;
+            }
+
+            BAR(u32)[6] @ 0x10 {
+                31:0 value;
+            }
+        }
+
+        dev_info!(
+            pdev,
+            "config space read8 rev ID: {:x}\n",
+            config.read(REVISION_ID).revision_id()
+        );
+
+        dev_info!(
+            pdev,
+            "config space read16 vendor ID: {:x}\n",
+            config.read(VENDOR_ID).vendor_id()
+        );
+
+        dev_info!(
+            pdev,
+            "config space read32 BAR 0: {:x}\n",
+            config.read(BAR::at(0)).value()
+        );
+    }
+
+    fn magic(&self) -> Result {
+        const EXPECTED: regs::IDENTIFICATION =
+            regs::IDENTIFICATION::from_raw(0).with_const_magic::<0xed>();
+
+        let pdev = self.pdev;
+        let bar = &self.irq_handler().handler().bar;
+
+        let identification = bar.read(regs::IDENTIFICATION);
+
+        if identification.magic() != EXPECTED.magic() {
+            dev_err!(
+                pdev,
+                "magic mismatch: expected {:#x} got {:#x}\n",
+                EXPECTED.magic(),
+                identification.magic()
+            );
+            return Err(ENODEV);
+        }
+
+        dev_info!(
+            pdev,
+            "major: {:#x} minor: {:#x}\n",
+            identification.major(),
+            identification.minor()
+        );
+        Ok(())
+    }
+
+    fn liveness_check(&self) -> Result {
+        let pdev = self.pdev;
+        let bar = &self.irq_handler().handler().bar;
+
+        let pattern = regs::LIVENESS_CHECK::from_raw(0xdead_beef);
+        bar.write_reg(pattern);
+
+        let inversed = bar.read(regs::LIVENESS_CHECK);
+        if inversed != !pattern {
+            dev_err!(
+                pdev,
+                "inverse mismatch: expected {:#x} got {:#x}\n",
+                !pattern.into_raw(),
+                inversed.into_raw()
+            );
+            return Err(ENODEV);
+        }
+
+        dev_info!(pdev, "inverse test successful\n");
+        Ok(())
+    }
+
+    fn factorial(&self) -> Result {
+        let pdev = self.pdev;
+        let bar = &self.irq_handler().handler().bar;
+
+        self.wait_until_compute_has_finished()?;
+
+        bar.write(regs::FACTORIAL, 4.into());
+
+        self.wait_until_compute_has_finished()?;
+
+        let result: u32 = bar.read(regs::FACTORIAL).into();
+
+        let expected = 24;
+
+        if result != expected {
+            dev_err!(
+                pdev,
+                "factorial result wrong: expected {} got {}\n",
+                expected,
+                result
+            );
+            return Err(ENODEV);
+        }
+
+        dev_info!(pdev, "factorial test successful\n");
+        Ok(())
+    }
+
+    fn test_irq(&self) -> Result {
+        let pdev = self.pdev;
+        let handler = self.irq_handler().handler();
+
+        dev_dbg!(pdev, "raising irq\n");
+
+        handler.bar.write(
+            regs::IRQ_RAISE,
+            regs::IRQ_RAISE::zeroed().with_test(IRQ_MAGIC_VALUE),
+        );
+
+        handler.irq_test_completion.wait_for_completion();
+
+        dev_info!(pdev, "irq test successful\n");
+        Ok(())
+    }
+
+    fn test_dma(&self) -> Result {
+        let pdev = self.pdev;
+        let handler = self.irq_handler().handler();
+
+        const QEMU_DMA_BASE: u64 = 0x40000;
+
+        dev_dbg!(pdev, "testing dma\n");
+
+        let dma = &handler.dma;
+
+        const DMA_VALUE: u64 = 42;
+
+        dma.write_val(DMA_VALUE);
+
+        let dma_regs = io_project!(handler.bar, try: regs::DMA);
+
+        io_write!(dma_regs, .src, dma.dma_address());
+        io_write!(dma_regs, .dst, QEMU_DMA_BASE);
+        io_write!(dma_regs, .count, dma.size().into_safe_cast());
+        io_write!(
+            dma_regs,
+            .command,
+            regs::DmaCommand::zeroed()
+                .with_start_transfer(true)
+                .with_direction(false)
+                .with_raise_irq(true)
+        );
+
+        handler.irq_dma_completion.wait_for_completion();
+
+        // Destroy previous value to test roundtrip
+        dma.write_val(0);
+
+        io_write!(dma_regs, .src, QEMU_DMA_BASE);
+        io_write!(dma_regs, .dst, dma.dma_address());
+        io_write!(dma_regs, .count, dma.size().into_safe_cast());
+        io_write!(
+            dma_regs,
+            .command,
+            regs::DmaCommand::zeroed()
+                .with_start_transfer(true)
+                .with_direction(true)
+                .with_raise_irq(true)
+        );
+
+        handler.irq_dma_completion.wait_for_completion();
+
+        let result = dma.read_val();
+
+        if result != DMA_VALUE {
+            dev_err!(
+                pdev,
+                "dma result wrong: expected {} got {}\n",
+                DMA_VALUE,
+                result
+            );
+            return Err(ENODEV);
+        }
+
+        dev_info!(pdev, "dma test successful\n");
+        Ok(())
+    }
+
+    fn wait_until_compute_has_finished(&self) -> Result {
+        let pdev = self.pdev;
+        let bar = &self.irq_handler().handler().bar;
+
+        read_poll_timeout(
+            || Ok(bar.read(regs::STATUS)),
+            |status| status.computing() == 0,
+            Delta::from_millis(10),
+            Delta::from_millis(100),
+        )
+        .inspect_err(|_| dev_err!(pdev, "computation bit did not clear before timeout\n"))
+        .map(|_| ())
+    }
+}
+
+impl pci::Driver for EduDriver {
+    type IdInfo = ();
+    type Data<'bound> = EduDriverData<'bound>;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<kernel::device::Core<'_>>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(EduDriverData {
+            _: {
+                dev_dbg!(
+                    pdev,
+                    "Probe Rust EDU driver sample (PCI ID: {}, 0x{:x}).\n",
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+            },
+
+            _enable: {
+                let enable = pdev.enable_device()?;
+                pdev.set_master(&enable)?;
+                enable
+            },
+
+            _: {
+                // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
+                unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<28>())? };
+            },
+
+            vectors: pdev
+                .alloc_irq_vectors(1, 1, pci::IrqType::Msi.into())
+                .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors failed: {:?}\n", e))?,
+
+            // SAFETY: `irq_handler` is owned by `EduDriverData`, which the driver core drops on
+            // unbind, so the Registration is not leaked.
+            irq_handler <- unsafe {
+                irq::Registration::new(
+                    vectors.index(0)?.into(),
+                    Flags::TRIGGER_NONE,
+                    c"rust_edu_irq",
+                    try_pin_init!(IrqHandler {
+                        bar: pdev.iomap_region_sized(0, c"rust_driver_edu")?,
+                        // Ack interrupts left pending by a previous binding.
+                        _: {
+                            let status = bar.read(regs::IRQ_STATUS);
+                            bar.write(regs::IRQ_ACK, regs::IRQ_ACK::from_raw(status.into_raw()));
+                        },
+                        irq_test_completion <- Completion::new(),
+                        irq_dma_completion <- Completion::new(),
+                        dma: Coherent::zeroed(pdev.as_ref(), GFP_KERNEL)?,
+                        pdev,
+                    }? Error),
+                )
+            },
+
+            pdev,
+        })
+        .pin_chain(|this| {
+            this.selftest()?;
+            dev_info!(this.pdev, "rust_driver_edu successfully initialized\n");
+            Ok(())
+        })
+    }
+}
+
+impl irq::Handler for IrqHandler<'_> {
+    fn handle(&self) -> irq::IrqReturn {
+        dev_dbg!(self.pdev, "irq handler called\n");
+        let status = self.bar.read(regs::IRQ_STATUS);
+        let mut ret = irq::IrqReturn::None;
+
+        if status.dma() != 0 {
+            dev_dbg!(self.pdev, "handling dma completion in irq\n");
+            self.bar
+                .write(regs::IRQ_ACK, regs::IRQ_ACK::zeroed().with_dma(true));
+            self.irq_dma_completion.complete();
+            ret = irq::IrqReturn::Handled;
+        }
+
+        if u8::from(status.test()) == IRQ_MAGIC_VALUE {
+            dev_dbg!(self.pdev, "handling test completion in irq\n");
+            self.bar.write(
+                regs::IRQ_ACK,
+                regs::IRQ_ACK::zeroed().with_test(IRQ_MAGIC_VALUE),
+            );
+            self.irq_test_completion.complete();
+            ret = irq::IrqReturn::Handled;
+        }
+
+        ret
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for EduDriverData<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        dev_dbg!(self.pdev, "Remove Rust EDU driver sample.\n");
+    }
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    <EduDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(pci::Vendor::QEMU, QEMU_EDU_DEVICE_ID),
+        ()
+    )]
+);
+
+kernel::module_pci_driver! {
+    type: EduDriver,
+    name: "rust_driver_edu",
+    authors: ["Maurice Hieronymus"],
+    description: "Rust EDU driver",
+    license: "GPL v2",
+}

-- 
2.54.0

