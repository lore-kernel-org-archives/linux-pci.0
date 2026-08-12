Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DB3793AC;
	Wed, 12 Aug 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564401; cv=none; b=BvG+Ytbj9Lnbv+N0TyuDs9gSgDnk651YtwqRy+5Kkaf3sbH0qcKGgYxQDPzWpw8jVxJJ+ZCEp27FRymam0ApdSNW1QT5o9VDZ+Z53QOJx3vTg8pI2Dc+nlsi8rJVe4owv/EC5VdLg8cmMG2K0pxOWbTEAFjVXzzlltLEuJA+hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564401; c=relaxed/simple;
	bh=jsMdOjd6Feo0yskvr73lK8H4nDlWqQEkm8dAuS4hQoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5ZaZrrZY9VR4iIx0XmILviPyXeHtoVTYsrLlwFUbExOCASD0ErROxlBLppUvLbNWKflnoREoUN3ca9lacDFYLHaZQ0WBpYPYsYI7T1Hieoo3KI8GUQykphQQo64iE81xYpWNzQvub+kFaE/HzjCYApGixzTRhU85CdPBoEE4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ceh4qsb+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pe5/VAdq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ceh4qsb+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pe5/VAdq"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hKzgd4v3Dz8tc4;
	Wed, 12 Aug 2026 21:53:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNQ8CmopTMw8BUQn4Y1TnuhBPIe3lpAQ4PrvTv888rs=;
	b=ceh4qsb+hry5jdLMnzlZdHWVNCgEd1IHjy14cNqnpN87HQ/JEFqOYiSqala8VJAYCOXQza
	RSCEyK+pOUvIyxJQufSdikuNv/bYkBwLPiiv+Zy27hKIvg9E06qGt62ybqAWjL1XRGvreS
	iDScW3PUYFVrn3ibazDv7m0vnbIM8YgPwg6FiYVwfq1kCdY6rhyFMsVXqpeAR/ikwqeflo
	deCHmGkuHJMVi3400XDW5d6z6x8OKS1BRttWkDMGs1yo4igyzKEgiyPcrs7itGrbfVWart
	3gjp6QC993Ay+wTk1+VaGqpQTiVIPtiU+/u8PK8ApdJqrpQV1k2fWCiU/0Vs8A==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786564396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNQ8CmopTMw8BUQn4Y1TnuhBPIe3lpAQ4PrvTv888rs=;
	b=pe5/VAdqwpqvVE3pipJSQ7TXpcvG1mkw/X8DTU9Uj5lt6RWDDvuujWrNsbthGrri4PkD4G
	ToAx5dKPCU4UYEsNkSfVkq71hAoK9PSF2LHvtt6jwAOUGap184jHPxWuGYyGKsG/Z76j56
	lwj0Qir4Vwd142KKdzQ9mNfz1YzrVn2AQhOrYzRaye5Xe+72snv0kDgMXHUThu9h/DtFnc
	zhpWHh6iArasJBt+h8lvTrcIFin1Ckyx0wvfgSsgI/y+Ayddn/B7hhEry4+q4wXtc4os1U
	jsanLgt/h5gntOuGcDM66OmRxsIw2319G/lAcRGVbVysZW5gx990A9CDhzj4gA==
Date: Wed, 12 Aug 2026 21:52:39 +0200
Subject: [PATCH v3 5/5] rust: samples: add EDU PCI driver sample
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-5-5d0b5594e52b@mailbox.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=14935;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=jsMdOjd6Feo0yskvr73lK8H4nDlWqQEkm8dAuS4hQoQ=;
 b=8ip8ypLSA65L7u+Tk7ETKqd4Kek3QqPJ4x39/56sxojnfJsSpHYlJUcLxRR8fMH+BykHE94kg
 a+wxsw9OXfMB8fTdmXypeWvFLQxs7sc7Snjw5UR5rZj7Qrx2oEcIA7n
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: wwtuxjik61xooc15ms49wf6nfz7qzfbs
X-MBO-RS-ID: 7c651f304e1330fa7a6

Add a Rust sample driver for the QEMU EDU device, wired up via a new
SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 MAINTAINERS                     |   1 +
 samples/rust/Kconfig            |  11 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 421 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 434 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92bc1f8c4f8a..f8a16d7b8260 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20915,6 +20915,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	rust/kernel/pci/
+F:	samples/rust/rust_driver_edu.rs
 
 PCIE BANDWIDTH CONTROLLER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 0cae695acd84..115f71ed6328 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -107,6 +107,17 @@ config SAMPLE_RUST_I2C_CLIENT
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_EDU
+	tristate "EDU Driver"
+	depends on PCI
+	help
+	  This option builds the Rust EDU driver sample.
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
index 70495fed886f..a005d578b7c2 100644
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
index 000000000000..52f6c4cf3b08
--- /dev/null
+++ b/samples/rust/rust_driver_edu.rs
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust EDU driver sample (based on QEMU's `edu`).
+//!
+//! To make this driver probe, QEMU must be run with `-device edu`.
+
+use kernel::{
+    device::Bound,
+    dma::{
+        Coherent,
+        Device,
+        DmaMask, //
+    },
+    io::{
+        poll::read_poll_timeout,
+        register,
+        register::Array,
+        Io, //
+    },
+    irq::{
+        self,
+        Flags, //
+    },
+    pci::{
+        self,
+        IrqTypes, //
+    },
+    prelude::*,
+    sync::Completion,
+    time::Delta, //
+};
+
+const QEMU_VENDOR_ID: u16 = 0x1234;
+const QEMU_EDU_DEVICE_ID: u32 = 0x11e8;
+const QEMU_EDU_DEVICE_MAGIC: u8 = 0xed;
+const QEMU_DMA_BASE: u64 = 0x40000;
+
+const IRQ_MAGIC_VALUE: u32 = 42;
+
+/// Bit set in `IRQ_STATUS` when a DMA transfer has completed.
+const DMA_IRQ: u32 = 0x100;
+
+mod regs {
+    use super::*;
+
+    register! {
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
+        pub(super) IRQ_STATUS(u32) @ 0x24 {}
+        pub(super) IRQ_RAISE(u32) @ 0x60 {}
+        pub(super) IRQ_ACK(u32) @ 0x64 {}
+
+        pub(super) DMA_SRC(u64) @ 0x80 {}
+        pub(super) DMA_DST(u64) @ 0x88 {}
+        pub(super) DMA_COUNT(u64) @ 0x90 {}
+        pub(super) DMA_COMMAND(u64) @ 0x98 {
+            0:0 start_transfer;
+            1:1 direction;
+            2:2 raise_irq;
+        }
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
+    pdev: &'bound pci::Device,
+    #[pin]
+    irq_handler: irq::Registration<'bound, IrqHandler<'bound>>,
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
+    dma: Coherent<u64>,
+}
+
+impl EduDriver {
+    fn init(pdev: &pci::Device<Bound>, bar: &Bar0<'_>, handler: &IrqHandler<'_>) -> Result {
+        Self::config_space(pdev);
+        Self::magic(pdev, bar)?;
+        Self::liveness_check(pdev, bar)?;
+        Self::factorial(pdev, bar)?;
+        Self::test_irq(pdev, handler)?;
+        Self::test_dma(pdev, handler)?;
+        Ok(())
+    }
+
+    fn config_space(pdev: &pci::Device<Bound>) {
+        let config = pdev.config_space();
+
+        // Some PCI configuration space registers.
+        register! {
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
+    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
+        let identification = bar.read(regs::IDENTIFICATION);
+
+        let magic: u8 = identification.magic().into();
+
+        if magic != QEMU_EDU_DEVICE_MAGIC {
+            dev_err!(
+                pdev,
+                "magic mismatch: expected {:#x} got {:#x}\n",
+                QEMU_EDU_DEVICE_MAGIC,
+                magic
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
+    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
+        let test_value = 0xabcd;
+
+        bar.write(regs::LIVENESS_CHECK, test_value.into());
+
+        let inverse_value = bar.read(regs::LIVENESS_CHECK).into_raw();
+
+        if inverse_value != !test_value {
+            dev_err!(
+                pdev,
+                "inverse mismatch: expected {:#x} got {:#x}\n",
+                !test_value,
+                inverse_value
+            );
+            return Err(ENODEV);
+        }
+
+        dev_info!(pdev, "inverse test successful\n");
+        Ok(())
+    }
+
+    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
+        Self::wait_until_compute_has_finished(pdev, bar)?;
+
+        bar.write(regs::FACTORIAL, 4.into());
+
+        Self::wait_until_compute_has_finished(pdev, bar)?;
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
+    fn test_irq(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> Result {
+        dev_dbg!(pdev, "raising irq\n");
+
+        handler.bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
+
+        handler.irq_test_completion.wait_for_completion();
+
+        dev_info!(pdev, "irq test successful\n");
+        Ok(())
+    }
+
+    fn test_dma(pdev: &pci::Device<Bound>, handler: &IrqHandler<'_>) -> Result {
+        dev_dbg!(pdev, "testing dma\n");
+
+        let dma = &handler.dma;
+
+        const DMA_VALUE: u64 = 42;
+
+        kernel::dma_write!(dma, , DMA_VALUE);
+
+        handler.bar.write(regs::DMA_SRC, dma.dma_handle().into());
+        handler.bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
+        handler
+            .bar
+            .write(regs::DMA_COUNT, (dma.size() as u64).into());
+        handler.bar.write(
+            regs::DMA_COMMAND,
+            regs::DMA_COMMAND::zeroed()
+                .with_start_transfer(true)
+                .with_direction(false)
+                .with_raise_irq(true),
+        );
+
+        handler.irq_dma_completion.wait_for_completion();
+
+        // Destroy previous value to test roundtrip
+        kernel::dma_write!(dma, , 0);
+
+        handler.bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
+        handler.bar.write(regs::DMA_DST, dma.dma_handle().into());
+        handler
+            .bar
+            .write(regs::DMA_COUNT, (dma.size() as u64).into());
+        handler.bar.write(
+            regs::DMA_COMMAND,
+            regs::DMA_COMMAND::zeroed()
+                .with_start_transfer(true)
+                .with_direction(true)
+                .with_raise_irq(true),
+        );
+
+        handler.irq_dma_completion.wait_for_completion();
+
+        let result = kernel::dma_read!(dma,);
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
+    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
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
+        _id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        pin_init::pin_init_scope(move || {
+            let vendor = pdev.vendor_id();
+            dev_dbg!(
+                pdev,
+                "Probe Rust EDU driver sample (PCI ID: {}, 0x{:x}).\n",
+                vendor,
+                pdev.device_id()
+            );
+
+            let enable = pdev.enable_device()?;
+            pdev.set_master();
+
+            let mask = DmaMask::new::<28>();
+
+            // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
+            unsafe { pdev.dma_set_mask_and_coherent(mask)? };
+
+            let ca: Coherent<u64> = Coherent::zeroed(pdev.as_ref(), GFP_KERNEL)?;
+
+            let irq = pdev
+                .alloc_irq_vectors(1, 1, IrqTypes::default().with(pci::IrqType::Msi))
+                .inspect_err(|e| dev_err!(pdev, "alloc_irq_vectors failed: {:?}\n", e))?;
+
+            let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_edu")?;
+
+            // SAFETY: The Registration is not leaked.
+            let req = unsafe {
+                pdev.request_irq(
+                    *irq.start(),
+                    Flags::TRIGGER_NONE,
+                    c"rust_edu_irq",
+                    try_pin_init!(IrqHandler {
+                        pdev,
+                        bar,
+                        irq_test_completion <- Completion::new(),
+                        irq_dma_completion <- Completion::new(),
+                        dma: ca,
+                    }? Error),
+                )
+            };
+
+            Ok(try_pin_init!(EduDriverData {
+                irq_handler <- req,
+                // Ordering matters: the handler is registered (`irq_handler <- req`)
+                // *before* the `_:` block runs the self-tests, one of which raises an
+                // interrupt and waits for the handler. Raising before the handler is
+                // registered would hang (the completion is never signalled).
+                _: {
+                    let handler = irq_handler.handler();
+                    EduDriver::init(pdev, &handler.bar, handler)?;
+                    dev_info!(
+                        pdev,
+                        "rust_driver_edu successfully initialized\n",
+                    );
+                },
+                pdev,
+                _enable: enable,
+            }))
+        })
+    }
+}
+
+impl irq::Handler for IrqHandler<'_> {
+    fn handle(&self) -> irq::IrqReturn {
+        dev_dbg!(self.pdev, "irq handler called\n");
+        let status: u32 = self.bar.read(regs::IRQ_STATUS).into();
+
+        // DMA_IRQ
+        if status & DMA_IRQ != 0 {
+            dev_dbg!(self.pdev, "handling dma completion in irq\n");
+            self.bar.write(regs::IRQ_ACK, DMA_IRQ.into());
+            self.irq_dma_completion.complete();
+        }
+
+        // TEST_IRQ
+        let magic = status & !DMA_IRQ;
+        if magic == IRQ_MAGIC_VALUE {
+            dev_dbg!(self.pdev, "handling test completion in irq\n");
+            self.bar.write(regs::IRQ_ACK, magic.into());
+            self.irq_test_completion.complete();
+        }
+
+        irq::IrqReturn::Handled
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
+    MODULE_PCI_TABLE,
+    <EduDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(pci::Vendor::from_raw(QEMU_VENDOR_ID), QEMU_EDU_DEVICE_ID),
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

