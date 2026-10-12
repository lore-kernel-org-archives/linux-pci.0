Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C4239E60
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765547; cv=none; b=iA/2rfjwhRrltpEikN1gwfHxTmuL/68xS/oSV1PbBfD6QJIV1XlAgo7sFwZIUqlndYgPkKEX0qfVoBEYgR5LrwL4lgAhLDn7J4pLQ3IEUpSFZugN6dTMbIzZU9LT5DT7D2+CPIIBrUCqfSpQbk6d3FVuhNyuDFQMs+kEly6mYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765547; c=relaxed/simple;
	bh=wGH+NZ0GIZQPUckcNWXKQ7cx6lhqtWmsWCGnFM1X7Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrIwC3CDmjTrAamX3SQfd+McFlhWzewib644b1cvq8hdemGizt2MCL4lUFKI+Aaq1mR4rb5Rwj0TjCm9Pyoa8diyu1O0T6VxQ87MLXijcF7Z3kOYPY9WxmRr/pexnnNeBNN6Nd61pkaWmsxuwn4C4oPrWqeyTApfc68Us02c/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUgXuW2v; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUgXuW2v"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-359d729379fso631073eec.0
        for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791765544; x=1792370344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZ/4P5lLlF7Jtec+KVnTS8DnnrJNScsgTst4HFDBHfY=;
        b=SUgXuW2vXoqQc8tWSsYEhCjLfk8PN7EEDdBJcOeZVI87pxc4o7WfHLVn6N/Dh2G36u
         e6KmzB8E15KDmA/7dTsuB8KaKGuJf01PeDLoqRu0LTuxkRdFQxwAJbZyXZ3NEP4lGjB0
         gNgXwGc7m0PQXjh7yQfHw37eKhNQ0busOzh9PkZZQSdAi5T1SYTUrcGvXJFtBQoBozjo
         xXmmyzp7Z639uw0nyQCsQIXXC46j15eVkHoSN0whSUXIlgs3Br1ykQzMr8SBhqH8kTyU
         OSX46UMTdc25Kf+EUr5VDEcX/xGwYZAblVQ41gl8mwJb0fosY8gSpiiNy8KblhVDbNRQ
         A1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791765544; x=1792370344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZ/4P5lLlF7Jtec+KVnTS8DnnrJNScsgTst4HFDBHfY=;
        b=kPvRxejIEdw/OWTn9Hj1uWQJLrLaAMmu5kRK06T4M6Y4j7rMILtm2MCGPRoylHdAjo
         qDWZ0K/0DCcaZn0y1Spnb5SsbyBWV+ObsIWbOxebh2IceUnzlGY+NGrgZF1ZTqkJU3pE
         K9/+E2wtI07iy7PGjUKK+cEH17LVL5l4mciyz2c7eKGaHgsPv65ODT08uQripC0+Cuj8
         8SO86qwwpeUOC/Ra/MndsIZYMk9ABbx/d0i2Q2w09uzlDOyGiuPJXjWR60P2HOg8KJ4M
         maWJClkUTJnO74SiQVrKUErbq7E7feNGxEJIF8syUrdYwd12QghiG/aNfrYADaTUPDJA
         Gecw==
X-Forwarded-Encrypted: i=1; AKwUvBx6E8PXhdBPSGKCt68TbJtBvzmukZE2kRGa9CEE+gm1NuDSTDYfsiPH+W0PEdV5jAvRvGZ4ITvUTks=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr5ISgA6RoIe9Fg0iCTHE/72Am4Q5fkPhq3lRImM6c/pGqTYjf
	tYww4LIMKumZl1ts4Y+Si81JdNnCmWR+02UE/zGs257RQgA80J3JXjKp
X-Gm-Gg: AYBFou2cyIMyLNANchSgHx6LSGa0GSJMDogJe24AQe5heKq+JRemFrFOG+3zm08zreI
	1fvCpsxfKDO0HTscZLONUtqsgmlyuWYLxD0iLkYb2ucqv4o4KT2pTpwLd0OPI6kTR76k8vR9Xzh
	8EvDOSA6ID9zUW4CUVlZ/dLdipZdDMlWYy/cF0opwYcb3jDOJ809yu1D9Hbj0+qIDMweIZ+W5is
	SIgk2R5ZoQi0y1SR15YgNYq2vBo+a9bqT+HW/TX3MrLe1bSUEZpsNV13JTsLLoMOIlX42/9Idt3
	+ZYgydtHlok/mK/v9gn6Bc0PQ4BmsN1r+qG3Yt8a+zVEdiajKaSYtNSiZCnjV0S1//zG3+WnT1+
	mTWLboGwz36H+08AdavCo1FqvpP/tb+3CM0iMhSTsHGV8YYj+oIFj/S6bQYGw8kQCrTrO+ZrJaD
	ZyGOCYpEcmyVishDh6ezWzQO+PMXED6Mrht4/jEM1ueX8BBbraw72fNVtgagUItmpHC/LfKAWCg
	vHwLkVJyL/O+YZpJU1bzTkMN9cI52W4ldFiSGez5ybWxSRx3Dag0Z6mxuJQiWd/j7JZgemj9fU6
	N5HxC25hjwWsa+8D2Iftzn16/wJjkA5HWKxUYEoMmqdaMw==
X-Received: by 2002:a05:7300:22de:b0:351:68e8:4646 with SMTP id 5a478bee46e88-3537e0ce0fcmr12801388eec.37.1791765544273;
        Sun, 11 Oct 2026 17:39:04 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:bbff:b31a:c9d8:9231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm29305676eec.27.2026.10.11.17.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 17:39:03 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: Lucas Costa <2000.costalucas@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] samples: rust: add QEMU EDU sample driver
Date: Sun, 11 Oct 2026 21:38:43 -0300
Message-ID: <20261012003849.82315-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sample PCI driver, written in Rust, for QEMU's educational
("edu") device. The edu device is a simple emulated PCI device meant
for teaching device-driver concepts; this sample serves as a worked
example that exercises the Rust PCI, IRQ and DMA abstractions in a
single, self-contained driver.

On probe(), the driver walks through the edu device's feature set:

  - identification and liveness checks over MMIO (reading the ID
    register, and verifying the device's bitwise-NOT mirror register);

  - the interrupt status/raise/ack registers at the MMIO level;

  - an MSI interrupt: arm "raise IRQ on completion", start a factorial
    computation, wait on a Completion signalled by the IRQ handler,
    then verify the result;

  - a full DMA round-trip (RAM -> device buffer -> RAM) using the
    coherent DMA API with a 28-bit DMA mask;

  - a few PCI configuration-space reads.

To make the driver probe, QEMU must be run with `-device edu`.

Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
 rust/kernel/pci/id.rs           |   8 +-
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 382 ++++++++++++++++++++++++++++++++
 4 files changed, 400 insertions(+), 2 deletions(-)
 create mode 100644 samples/rust/rust_driver_edu.rs

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..2747d92be91b 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -154,9 +154,13 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 
 /// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
 impl Vendor {
-    /// Create a Vendor from a raw 16-bit vendor ID.
+    /// Create a [`Vendor`] from a raw 16-bit vendor ID.
+    ///
+    /// Prefer one of the named [`Vendor`] constants where one exists. This is intended for
+    /// vendor IDs that have no dedicated constant, e.g. test or emulated devices whose IDs
+    /// are not shared between multiple drivers and thus do not belong in `pci_ids.h`.
     #[inline]
-    pub(super) fn from_raw(vendor_id: u16) -> Self {
+    pub const fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
     }
 
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..b654751041fa 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -190,4 +190,15 @@ config SAMPLE_RUST_HOSTPROGS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_EDU
+	tristate "QEMU EDU Driver"
+	depends on PCI
+	help
+	  This option builds the Rust QEMU EDU PCI driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_edu.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..57d944baa781 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_SERDEV)		+= rust_driver_serdev.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_EDU) += rust_driver_edu.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_driver_edu.rs b/samples/rust/rust_driver_edu.rs
new file mode 100644
index 000000000000..e9e5593bb89a
--- /dev/null
+++ b/samples/rust/rust_driver_edu.rs
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust QEMU EDU driver sample (based on QEMU's edu device).
+//!
+//! To make this driver probe, QEMU must be run with `-device edu`.
+
+use kernel::{
+    device::{
+        Bound,
+        Core, //
+    },
+    dma::{
+        Coherent,
+        CoherentBox,
+        Device as _,
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
+        Flags,
+        Registration, //
+    },
+    pci,
+    prelude::*,
+    sync::Completion,
+    time::Delta, //
+};
+
+mod regs {
+    use super::*;
+
+    register! {
+        pub(super) IDENTIFICATION(u32) @ 0x0 {
+            31:0 version;
+        }
+
+        pub(super) LIVENESS(u32) @ 0x4 {
+            31:0 value;
+        }
+
+        pub(super) FACTORIAL(u32) @ 0x8 {
+            31:0 value;
+        }
+
+        pub(super) STATUS(u32) @ 0x20 {
+            7:7 irq_on_done;     // 0x80: raise an IRQ when the factorial is done
+            0:0 computing;       // 0x01: set while a factorial is being computed
+        }
+
+        pub(super) INTERRUPT_STATUS(u32) @ 0x24 {
+            31:0 status;
+        }
+
+        pub(super) INTERRUPT_RAISE(u32) @ 0x60 {
+            31:0 raise;
+        }
+
+        pub(super) INTERRUPT_ACK(u32) @ 0x64 {
+            31:0 ack;
+        }
+
+        // The EDU DMA registers are documented as 64-bit, but QEMU's edu device
+        // accepts 4-byte accesses to these registers and zero-extends the
+        // written value, and this driver only uses addresses/counts that fit in
+        // 32 bits (a 28-bit DMA mask), so a single `u32` access per register is
+        // correct and sufficient here.
+        pub(super) DMA_SRC_ADDR(u32) @ 0x80 {
+            31:0 src;
+        }
+
+        pub(super) DMA_DST_ADDR(u32) @ 0x88 {
+            31:0 dst;
+        }
+
+        pub(super) DMA_CNT(u32) @ 0x90 {
+            31:0 size;
+        }
+
+        pub(super) DMA_CMD(u32) @ 0x98 {
+            31:0 cmd;
+        }
+    }
+
+    pub(super) const END: usize = 0x9C;
+}
+
+type Bar0<'bound> = pci::Bar<'bound, { regs::END }>;
+
+struct SampleDriverData<'bound> {
+    pdev: &'bound pci::Device,
+    // Held for the lifetime of the bound device so the BAR mapping stays alive;
+    // all register access happens during probe, so the field is never read again.
+    #[expect(dead_code)]
+    bar: Bar0<'bound>,
+}
+
+struct SampleDriver;
+
+// The QEMU EDU device's PCI IDs. These are specific to this emulated device and are not
+// shared with any other driver, so they are kept local here rather than in `pci_ids.h`.
+// `0x1234` is QEMU's conventional vendor ID, which has no dedicated `pci::Vendor` constant.
+const VENDOR_ID_QEMU: u16 = 0x1234;
+const DEVICE_ID_EDU: u32 = 0x11e8;
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    <SampleDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id(pci::Vendor::from_raw(VENDOR_ID_QEMU), DEVICE_ID_EDU),
+        ()
+    )]
+);
+
+impl SampleDriverData<'_> {
+    /// The value the EDU device reports from its `IDENTIFICATION` register.
+    const EDU_ID: u32 = 0x010000ed;
+
+    /// Confirm we are really talking to an EDU device by reading its ID register.
+    fn identification(bar: &Bar0<'_>) -> Result {
+        if bar.read(regs::IDENTIFICATION).version().get() != Self::EDU_ID {
+            return Err(ENODEV);
+        }
+
+        Ok(())
+    }
+
+    /// Liveness check: the EDU device inverts (bitwise NOT) whatever we write to the
+    /// `LIVENESS` register, so writing `x` and reading back `!x` proves MMIO works.
+    fn liveness(bar: &Bar0<'_>) -> Result {
+        let pattern: u32 = 0xdead_beef;
+
+        bar.write_reg(regs::LIVENESS::zeroed().with_value(pattern));
+
+        let readback = bar.read(regs::LIVENESS).value().get();
+
+        if readback != !pattern {
+            return Err(EIO);
+        }
+
+        Ok(())
+    }
+
+    /// Exercise the interrupt registers at the MMIO level.
+    ///
+    /// Writing a bitmask to `INTERRUPT_RAISE` asserts those bits in
+    /// `INTERRUPT_STATUS` (and, if an IRQ is enabled, makes the device raise an
+    /// interrupt); writing the same bitmask to `INTERRUPT_ACK` clears them
+    /// again. Here we raise a test bit, confirm the status register reflects it,
+    /// then acknowledge it and confirm it clears -- all without registering a
+    /// handler. Wiring up MSI and an actual IRQ handler is a later step.
+    fn interrupt_status(bar: &Bar0<'_>) -> Result {
+        let pattern: u32 = 0x0000_0001;
+
+        bar.write_reg(regs::INTERRUPT_RAISE::zeroed().with_raise(pattern));
+
+        if bar.read(regs::INTERRUPT_STATUS).status().get() != pattern {
+            return Err(EIO);
+        }
+
+        bar.write_reg(regs::INTERRUPT_ACK::zeroed().with_ack(pattern));
+
+        if bar.read(regs::INTERRUPT_STATUS).status().get() != 0 {
+            return Err(EIO);
+        }
+
+        Ok(())
+    }
+
+    /// Make the edu device compute a factorial and inform the cpu
+    /// of completion via an IRQ
+    fn factorial_irq(pdev: &pci::Device<Bound>, bar: &Bar0<'_>) -> Result {
+        let operand: u32 = 6;
+
+        let msi = pci::IrqTypes::default().with(pci::IrqType::Msi);
+        let vectors = pdev.alloc_irq_vectors(1, 1, msi)?;
+
+        let registration = KBox::pin_init(
+            unsafe {
+                Registration::new(
+                    vectors.index(0)?.into(),
+                    Flags::SHARED,
+                    c"rust_driver_edu",
+                    try_pin_init!(EduIrq {
+                        done <- Completion::new(),
+                    }? Error),
+                )
+            },
+            GFP_KERNEL,
+        )?;
+
+        // Arm the "raise an IRQ when done" bit, then start the computation.
+        bar.write_reg(regs::STATUS::zeroed().with_irq_on_done(true));
+        bar.write_reg(regs::FACTORIAL::zeroed().with_value(operand));
+
+        // Sleep until the handler calls `complete_all()` from IRQ context.
+        registration.handler().done.wait_for_completion();
+
+        // Acknowledge whatever the device raised so it lowers the interrupt.
+        let pending = bar.read(regs::INTERRUPT_STATUS).status().get();
+        bar.write_reg(regs::INTERRUPT_ACK::zeroed().with_ack(pending));
+
+        let result = bar.read(regs::FACTORIAL).value().get();
+
+        if result != factorial_helper(operand) {
+            return Err(EIO);
+        }
+
+        Ok(())
+    }
+
+    /// Tests a full DMA round-trip, writing from RAM -> device buffer,
+    /// and then from device buffer -> RAM
+    fn dma_test(pdev: &pci::Device<Core<'_>>, bar: &Bar0<'_>) -> Result {
+        const DEV_BUF: u32 = 0x40_000;
+        const LEN: usize = 512;
+        const CMD_START: u32 = 1 << 0;
+        const CMD_TO_RAM: u32 = 1 << 1;
+
+        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<28>())? };
+
+        let mut src: CoherentBox<[u8]> = CoherentBox::zeroed_slice(pdev.as_ref(), LEN, GFP_KERNEL)?;
+        src.fill(0xa5);
+
+        let src: Coherent<[u8]> = src.into();
+
+        let dst: Coherent<[u8]> =
+            CoherentBox::<[u8]>::zeroed_slice(pdev.as_ref(), LEN, GFP_KERNEL)?.into();
+
+        let src_dma = src.dma_address() as u32;
+        let dst_dma = dst.dma_address() as u32;
+
+        let wait_dma = || {
+            read_poll_timeout(
+                || Ok(bar.read(regs::DMA_CMD).cmd().get()),
+                |cmd| *cmd & CMD_START == 0,
+                Delta::from_millis(10),
+                Delta::from_secs(1),
+            )
+        };
+
+        // 1) RAM -> device internal buffer. CMD is written last: it triggers the transfer.
+        bar.write_reg(regs::DMA_SRC_ADDR::zeroed().with_src(src_dma));
+        bar.write_reg(regs::DMA_DST_ADDR::zeroed().with_dst(DEV_BUF));
+        bar.write_reg(regs::DMA_CNT::zeroed().with_size(LEN as u32));
+        bar.write_reg(regs::DMA_CMD::zeroed().with_cmd(CMD_START));
+        wait_dma()?;
+
+        // 2) device internal buffer -> RAM, landing in `dst`.
+        bar.write_reg(regs::DMA_SRC_ADDR::zeroed().with_src(DEV_BUF));
+        bar.write_reg(regs::DMA_DST_ADDR::zeroed().with_dst(dst_dma));
+        bar.write_reg(regs::DMA_CNT::zeroed().with_size(LEN as u32));
+        bar.write_reg(regs::DMA_CMD::zeroed().with_cmd(CMD_START | CMD_TO_RAM));
+        wait_dma()?;
+
+        // Transfer completed, check dst is the expected value
+        let out = unsafe { dst.as_ref() };
+        if out.iter().any(|&b| b != 0xa5) {
+            return Err(EIO);
+        }
+
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
+            "edu config space read8 rev ID: {:x}\n",
+            config.read(REVISION_ID).revision_id()
+        );
+
+        dev_info!(
+            pdev,
+            "edu config space read16 vendor ID: {:x}\n",
+            config.read(VENDOR_ID).vendor_id()
+        );
+
+        dev_info!(
+            pdev,
+            "edu config space read32 BAR 0: {:x}\n",
+            config.read(BAR::at(0)).value()
+        );
+    }
+}
+
+impl pci::Driver for SampleDriver {
+    type IdInfo = ();
+    type Data<'bound> = SampleDriverData<'bound>;
+
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        dev_dbg!(
+            pdev,
+            "Probe Rust QEMU EDU driver sample (PCI ID: {}, 0x{:x}).\n",
+            pdev.vendor_id(),
+            pdev.device_id()
+        );
+
+        pdev.enable_device_mem()?;
+        pdev.set_master();
+
+        let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_edu")?;
+
+        SampleDriverData::identification(&bar)?;
+        SampleDriverData::liveness(&bar)?;
+        SampleDriverData::interrupt_status(&bar)?;
+        SampleDriverData::factorial_irq(pdev, &bar)?;
+        SampleDriverData::dma_test(pdev, &bar)?;
+        SampleDriverData::config_space(pdev);
+
+        dev_info!(pdev, "EDU device probed: all checks passed.\n");
+
+        Ok(SampleDriverData { pdev, bar })
+    }
+}
+
+impl Drop for SampleDriverData<'_> {
+    fn drop(&mut self) {
+        dev_dbg!(self.pdev, "Remove Rust QEMU EDU driver sample.\n");
+    }
+}
+
+/// Per-interrupt state shared between process context and IRQ context.
+///
+/// The factorial computation signals `done` from the IRQ handler; the process
+/// context that started it waits on the same [`Completion`].
+#[pin_data]
+struct EduIrq {
+    #[pin]
+    done: Completion,
+}
+
+impl irq::Handler for EduIrq {
+    // Runs in IRQ context when the EDU device raises its interrupt.
+    fn handle(&self) -> irq::IrqReturn {
+        self.done.complete_all();
+        irq::IrqReturn::Handled
+    }
+}
+
+// Helper functions
+fn factorial_helper(n: u32) -> u32 {
+    if n <= 1 {
+        return 1;
+    }
+
+    n * factorial_helper(n - 1)
+}
+
+kernel::module_pci_driver! {
+    type: SampleDriver,
+    name: "rust_driver_edu",
+    authors: ["Lucas Costa"],
+    description: "Rust QEMU EDU driver",
+    license: "GPL v2",
+}
-- 
2.43.0

