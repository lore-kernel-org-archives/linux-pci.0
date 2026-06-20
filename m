Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067533F5A2;
	Sat, 20 Jun 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945198; cv=none; b=hUtLpB9sUE76pGNz+bsZdJnyAE7SRd0kZhi+xrfJFCxb6FvyKlyL+raMMlbBjV2ABwlsPIOHPTmrlziWBksKITMlUqdzdu93oN2RgTzczd/a0rMNwWyQDXf/ESecW4mDUwem71E/29K/UJQnKayrconAYkc+WjLwUf8RSaCLUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945198; c=relaxed/simple;
	bh=oeQgdyMfBLisACaRU0pc7lh8UGXmr9tHxUsrDjhFHnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D10wsSG/3kylNBeirmSp2vzjIULQ4CuouaC3OQTdftqr6E+b5ar+EmKXH7p14x/xw53STfc4kIyVfDS70PaizvQpZ3X8QF4EGFvREAP8kiA3Aj1ZfNxr+lrsfeTT/yYQUGDykYHUcYBSSEhA5WM/izFNKiLpcq2zgDX5xKJHdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FGYwv1QF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jqU8tZED; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FGYwv1QF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jqU8tZED"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gj7Nj022dz9tQn;
	Sat, 20 Jun 2026 10:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO9yXRoKA1rTUlOtdZV4NXq8mWRpqSlBgTvlomXumpc=;
	b=FGYwv1QFQ4h1h7awTTtoLLt8KS+ykvLGNMQj1qdDKrP9MHGcpH5b/TFppP9/Msmm23038Y
	Iv7TGpzD4caY2icq2zz8GCIfSh1ndxP9tC7JrbhGeaFjo0aY36UotGCSbPv5xCZtTYv4BM
	CSa49NkUJyRZB7/zOj6fN/3FuPKIFgAkn+s5aP5Y4gipH0AAgCJ8cN7cBYAYSHUnP5WdgE
	JAfVhzJip9xkBvt206cD8zhh+ak4VoezRVn7Bu5eiqFZ0W7nVEyxKIE7stO1AOQTdUIx0f
	BHbnom+FKGeAuDuB8Oey4WJ4I6xrrvkAmLqFeDc6P6SGse7ySKot+Li9UuWlHw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jqU8tZED;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781945187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO9yXRoKA1rTUlOtdZV4NXq8mWRpqSlBgTvlomXumpc=;
	b=jqU8tZEDdqdKbJAl+oqn3WO4+IpLNij9f67zQamqNhHQpsQhwVNWIcpmNJ4KkkaLsEUUnw
	djAJA6q5dLgfni8GCESWukZ2GxztA0UaG7DE1b2U8ZSFEqWxYABoPikQmOE17pb9RDjWK8
	3KUo7OqF42nWYo00nL55TOwImtPxen55XfDxZut1k75kzH1o972a32kr7FbDYXRIUfuVmW
	3wyhdybNpVkt9xoDKSDLrMRnwaMgO0CSnQu1kqE/ZMf5a59rCMyRmrlpb3RFdFPv8IqTwO
	Zunm8ibetPRFPr6tIA0TXPq5Jk0IL8PVM+7+XNgt2W4arAiZHIF2+kZdntBoFA==
Date: Sat, 20 Jun 2026 10:45:48 +0200
Subject: [PATCH v2 4/4] rust: samples: add EDU PCI driver sample
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-b4-rust-pci-edu-driver-v2-4-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
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
 Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781945156; l=13951;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=oeQgdyMfBLisACaRU0pc7lh8UGXmr9tHxUsrDjhFHnU=;
 b=9aqW4E68T8gujDF9xbRorcD+QVPAE2st0MuNuX0dNnbw0RPakU71R9A+Acoih2ixmpp1e+SOJ
 CLfGkoDN3+6DY2jZJ6o4pU8Ys6bHPuW6jwlLMvAvMju8W3wMcPF+T9Q
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: a6cdd7da8ce11025a9d
X-MBO-RS-META: 6dpbjqy4jfje6g9tjuw4cryy6yx93bjs
X-Rspamd-Queue-Id: 4gj7Nj022dz9tQn

Add a Rust sample driver for the QEMU EDU device, wired up via a new
SAMPLE_RUST_DRIVER_EDU Kconfig option and the samples Makefile.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 samples/rust/Kconfig            |  11 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 378 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c49ab9106345..742c42262e9b 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -118,6 +118,17 @@ config SAMPLE_RUST_DRIVER_PCI
 
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
index 6c0aaa58cccc..c24a328243b1 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_EDU)		+= rust_driver_edu.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_edu.rs
new file mode 100644
index 000000000000..5f4efd514032
--- /dev/null
+++ b/samples/rust/rust_driver_edu.rs
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust EDU driver sample (based on QEMU's `edu`).
+//!
+//! To make this driver probe, QEMU must be run with `-device edu`.
+
+use kernel::{
+    device::Bound,
+    devres::Devres,
+    dma::{Coherent, Device, DmaMask},
+    io::{
+        poll::read_poll_timeout,
+        register,
+        Io, //
+    },
+    irq::{self, Flags},
+    pci::{self, IrqTypes},
+    prelude::*,
+    sync::{aref::ARef, Arc, Completion},
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
+type Bar0 = pci::Bar<'static, { regs::END }>;
+
+#[pin_data(PinnedDrop)]
+struct EduDriver {
+    pdev: ARef<pci::Device>,
+    data: Arc<EduDriverData>,
+    #[pin]
+    irq_handler: irq::Registration<Arc<EduDriverData>>,
+}
+
+#[pin_data]
+struct EduDriverData {
+    #[pin]
+    bar: Devres<Bar0>,
+    #[pin]
+    irq_test_completion: Completion,
+    #[pin]
+    irq_dma_completion: Completion,
+    dma: Coherent<u64>,
+}
+
+impl EduDriver {
+    fn init(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverData) -> Result {
+        Self::magic(pdev, bar)?;
+        Self::liveness_check(pdev, bar)?;
+        Self::factorial(pdev, bar)?;
+        Self::test_irq(pdev, bar, data)?;
+        Self::test_dma(pdev, bar, data)?;
+        Ok(())
+    }
+
+    fn magic(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
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
+    fn liveness_check(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
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
+    fn factorial(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
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
+    fn test_irq(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverData) -> Result {
+        dev_dbg!(pdev, "raising irq\n");
+
+        bar.write(regs::IRQ_RAISE, IRQ_MAGIC_VALUE.into());
+
+        data.irq_test_completion.wait_for_completion();
+        Ok(())
+    }
+
+    fn test_dma(pdev: &pci::Device<Bound>, bar: &Bar0, data: &EduDriverData) -> Result {
+        dev_dbg!(pdev, "testing dma\n");
+
+        let dma = &data.dma;
+
+        const DMA_VALUE: u64 = 42;
+
+        kernel::dma_write!(dma, , DMA_VALUE);
+
+        bar.write(regs::DMA_SRC, dma.dma_handle().into());
+        bar.write(regs::DMA_DST, QEMU_DMA_BASE.into());
+        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
+        bar.write(
+            regs::DMA_COMMAND,
+            regs::DMA_COMMAND::zeroed()
+                .with_start_transfer(true)
+                .with_direction(false)
+                .with_raise_irq(true),
+        );
+
+        data.irq_dma_completion.wait_for_completion();
+
+        // Destroy previous value to test roundtrip
+        kernel::dma_write!(dma, , 0);
+
+        bar.write(regs::DMA_SRC, QEMU_DMA_BASE.into());
+        bar.write(regs::DMA_DST, dma.dma_handle().into());
+        bar.write(regs::DMA_COUNT, (dma.size() as u64).into());
+        bar.write(
+            regs::DMA_COMMAND,
+            regs::DMA_COMMAND::zeroed()
+                .with_start_transfer(true)
+                .with_direction(true)
+                .with_raise_irq(true),
+        );
+
+        data.irq_dma_completion.wait_for_completion();
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
+    fn wait_until_compute_has_finished(pdev: &pci::Device<Bound>, bar: &Bar0) -> Result {
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
+    type Data<'bound> = Self;
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
+            pdev.enable_device()?;
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
+            // State shared with the IRQ handler (the BAR and the completion the
+            // handler signals) lives in an `Arc<EduDriverData>`. `EduDriverData`
+            // itself implements `irq::Handler`, and the registration takes an
+            // `Arc<T>` via the `impl Handler for Arc<T>` blanket impl. This keeps
+            // the handler's state out of `EduDriver` and avoids a self-reference.
+            let data = Arc::pin_init(
+                try_pin_init!(EduDriverData {
+                    bar <- pdev
+                        .iomap_region_sized(0, c"rust_driver_edu")
+                        .and_then(|bar| bar.into_devres()),
+                    irq_test_completion <- Completion::new(),
+                    irq_dma_completion <- Completion::new(),
+                    dma: ca,
+                }),
+                GFP_KERNEL,
+            )?;
+
+            let req = irq::Registration::new(
+                (*irq.start()).try_into()?,
+                Flags::TRIGGER_NONE,
+                c"rust_edu_irq",
+                Ok(data.clone()),
+            );
+
+            // Ordering matters: the handler is registered (`irq_handler <- req`)
+            // *before* the `_:` block runs the self-tests, one of which raises an
+            // interrupt and waits for the handler. Raising before the handler is
+            // registered would hang (the completion is never signalled).
+            Ok(try_pin_init!(Self {
+                irq_handler <- req,
+                // Side-effect block: run the staged self-tests against the mapped
+                // BAR now that the handler is live. A failure here aborts probe.
+                _: {
+                    let bar = data.bar.access(pdev.as_ref())?;
+                    EduDriver::init(pdev, bar, &data)?;
+                    dev_info!(
+                        pdev,
+                        "rust_driver_edu successfully initialized\n",
+                    );
+                },
+                data,
+                pdev: pdev.into()
+            }))
+        })
+    }
+}
+
+impl irq::Handler for EduDriverData {
+    fn handle(&self, pdev: &kernel::device::Device<Bound>) -> irq::IrqReturn {
+        dev_dbg!(pdev, "irq handler called\n");
+        // `access()` only fails on device mismatch, so this branch is
+        // structurally unreachable here, but it must be handled.
+        let Ok(bar) = self.bar.access(pdev.as_ref()) else {
+            dev_err!(pdev, "cannot access bar register inside irq handler\n");
+            return irq::IrqReturn::None;
+        };
+        let status: u32 = bar.read(regs::IRQ_STATUS).into();
+
+        // DMA_IRQ
+        if status & DMA_IRQ != 0 {
+            dev_dbg!(pdev, "handling dma completion in irq\n");
+            bar.write(regs::IRQ_ACK, DMA_IRQ.into());
+            self.irq_dma_completion.complete();
+        }
+
+        // TEST_IRQ
+        let magic = status & !DMA_IRQ;
+        if magic == IRQ_MAGIC_VALUE {
+            dev_dbg!(pdev, "handling test completion in irq\n");
+            bar.write(regs::IRQ_ACK, magic.into());
+            self.irq_test_completion.complete();
+        }
+
+        irq::IrqReturn::Handled
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for EduDriver {
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
2.51.2

