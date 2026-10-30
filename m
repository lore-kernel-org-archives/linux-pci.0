Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384152;
	b=whr8cOk/j1RTUf2/aCgKmpdd89qd8Wc/jDoOeG1uVEd/PfGhtHtMqUgHT4mkJIyZz21d
	 OZdFnyODys6tqo1sw92P4+rUcETksscLADo1BKh9aQXXQdeLUsWeWnI9hh8BQAi/HB47t
	 Eg6srrgtcKURXVpnVOtNVE8csWMejPj+ta87KVeCuQfby/OlygxFZb7V/iyMtu/9rpDmY
	 R5KIXE8+bnaGi1rJOYKSHmtBuRDViTPD0Y/gnsCd3diYu000sIJGXZOFc3TG9iP5XQlyS
	 6k+G4aPhqnCS13JJFNbM4V/wmMQZOMU6PcGVf6V513sLMAgS9Er+a5lulNtaBF004DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JT98i7tTE8+7Wnceh3gOSujC6CU3HNUaQsZFPRUss18=;
	b=YyuNHIfZyY7us75sU2hEtkr1rVoTprK3iLLoEviohm/eaE0pQKDCYQEnpDXY0dj4P5QM
	 ZLocZQ42MxwEPhmwh0AYYOElgr1BchQ73ndPf2BVblftuJXTlVx6ybJdqXOpej+Y3EQLS
	 Aje/+0cmpMWDGJqllOlElg2BWE+W52D19R+ByWm8QRlb9fGakfGpufF/a9/XO6mb9/mEs
	 97iFuL4W7EwIdwyDOIuXXTFRV/T/AS796eg8qA5W7unw/548hRgMyhCbq/qyRss4XgHic
	 ujDJ+6FEEWZgl7OPwi4wvUPBkm8W2ZjD0t/k9unPUqUBaMVWRsYr2cecmmIJ+COSKag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZPH/T5pR";
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1D60A2613
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 18:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88B1D60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPH/T5pR
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7ccb2ffe333so668916137.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793384150; x=1793988950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JT98i7tTE8+7Wnceh3gOSujC6CU3HNUaQsZFPRUss18=;
        b=ZPH/T5pRfv2+n+jrlvc1xzTgmkP9ezwXLCPxSoTv85g9I71iFVopojwBNDCMbkYClz
         jPAUCw3GQ2Drj8Va2jKGS9KdendiE92pyS+Z0uKnp9AjJLz7nAqkxwwrp13TWA2uXrLW
         cPp+oVbnIaz4uXhMDM0wrEm7I3nVic/4wcMQupvwL6GNjAYRk2VnTVeGn8++twir0gj9
         qWTSXNNL0Shj/HnI1qByT/ggqvYgqyayWXIt3F8e6GZIdzQlxAXB5Iy5I1lPcIOmDVz+
         C+sdi6PJbu5PwqMod7t2iXYzoO4e2ORDuJ0IcCePtlIr0AZ7MaG4UIcbN/tq4os+/52A
         d9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384150; x=1793988950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JT98i7tTE8+7Wnceh3gOSujC6CU3HNUaQsZFPRUss18=;
        b=HI/nWr2NQ76yCZwNJJ+rXe+M0nN2d/Y6HKFu+PgQs0+FKBxDgPj0p0q6IoPVjwVzjK
         dZ3fo6XdVb51MJsqYGb/zk9HAO5KLff7MojUQA0HhyPgCLtSX47zBtrKYJ2YeAjHmNHE
         IwxI1ABLbKAvRVB4hNdfMhDmXsTuTm/qVWhLDuHgTe+MLe29H3dHWamqf9eIihIuuTv2
         4WKUFqnHk9qw0sZImFywhX7iGJhUXcbMOQQ/3yxCp49pyploS/5a3J5p4P904hg3utBn
         d3QA2jjIW0ejo4qLRDkxAVw4Q7HhK5KSeUShFN9JJkZWaLR8j9vYQzFCxTlrKvWNnTbM
         A9dw==
X-Forwarded-Encrypted: i=1; AKwUvBxmj8ZPdrFS95DD/6MNnfJUlFZCQ4RCOOU1tEF3LtuJCGQVPx+ItjrQZYEOkZS8qE2RW3CJl4oHzx0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbfdL5zyPrVEE5hgJfDk8g6Ly57pNumE/zWNHG1Rj3HgRtS2dF
	LoJmC5O0ltcJxC3x0xImhUKsEJzZny8bTojUeSi7EWBPdd/ITVq0zfC4
X-Gm-Gg: AYBFou2I731Z6pMz4ehpu227WZc0rNS3QCI9NLHpmNQnA+7W7rFv3Pj7mWuSyYJOJGx
	2KBfoJmGUNzVyMVy6j+pPt68r/OhGXjzGaakASdjBvEGuqL4akWj9w2R+194qpATHiSN/2OfH7m
	yd+BApPYw6QEvm4wqqPFOa4/67Zi/nsDDPYh2aYdlpem852PK7jSsDx8SrMAeTcSxkUIVJ3V5Tt
	6bKPZE1ZYuhgSOM7XdL8QTB32xpm13fzUVuJrSwMBJ+iEXeyaUve4sHDwT0HEbbPG64PYYiWEmL
	zSNmvQxibZ1OXuyZdwgVjrBaEssyXoHjlqFFlq6+uis+bW7u4LqGLeBTeHruY+EnHxDSQZ/W9I3
	Jdmh6bqGKV8LnvIajxOWc8HSOd0SicXSIiSj+Zo2jJnxggFftgOnhX1DlcLZ1GJe8l8ftQCSoqb
	xxLZEH/94ZdCm5DT61weB+v/rqNOEW+ishaaKXlVXBKIjCaXYl4IwZeDnh8E1vwFHUKh8UMkwie
	6v/eMnOWikr5s3b8IJYDzxGoceyqPYDkCK8liVEXlI+P9zT5J8xxDKDXC/NRAH0Z0tc0BQ46WRn
	P34x+z43AG+2v7Az63udntq8ARKuy7w75cAy66lo8ieYggDOtYL21D27imf0Vgfz1U5hzUUkwVw
	vs+OIsJvMseO2KjfsiynHZW3v9NKEZp85ZJ9rtwPRRCUaQzkGeokveXcV0TdoOcSeX5fTQpzv2M
	9JRIw=
X-Received: by 2002:a05:6102:441a:b0:7c3:881f:b775 with SMTP id ada2fe7eead31-7d072cac30amr1845875137.24.1793384150011;
        Fri, 30 Oct 2026 11:15:50 -0700 (PDT)
Received: from ututo.. ([2803:9810:87dd:de10:2772:b6de:3686:bd70])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d077393404sm3017737137.2.2026.10.30.11.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:15:49 -0700 (PDT)
From: Lucas Costa <2000.costalucas@gmail.com>
To: dakr@kernel.org,
	ojeda@kernel.org
Cc: bhelgaas@google.com,
	kwilczynski@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] samples: rust: add QEMU EDU sample driver
Date: Fri, 30 Oct 2026 15:15:39 -0300
Message-ID: <20261030181540.102665-1-2000.costalucas@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust PCI driver sample for QEMU's educational ("edu") device.
It exercises the Rust PCI, IRQ, and DMA abstractions: MMIO
identification/liveness checks, interrupt status handling, an
MSI-backed factorial computation with a bounded wait, a coherent-DMA
round trip, and PCI config-space reads.

Also add the PCI teardown helpers and Completion timeout support used
by the sample.

Run QEMU with `-device edu` to probe it.

Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
---
 rust/kernel/pci.rs              |  14 ++
 rust/kernel/pci/id.rs           |   8 +-
 rust/kernel/sync/completion.rs  |  20 +-
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_edu.rs | 423 ++++++++++++++++++++++++++++++++
 6 files changed, 474 insertions(+), 3 deletions(-)
 create mode 100644 samples/rust/rust_driver_edu.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 3ec897709e89..810703d7a2fb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -445,6 +445,20 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Disable bus-mastering for this device.
+    #[inline]
+    pub fn clear_master(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_clear_master(self.as_raw()) };
+    }
+
+    /// Disable the device.
+    #[inline]
+    pub fn disable_device(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_disable_device(self.as_raw()) };
+    }
 }
 
 impl<'a> Device<device::Core<'a>> {
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
 
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index 35ff049ff078..83a22d25b61d 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -6,7 +6,12 @@
 //!
 //! C header: [`include/linux/completion.h`](srctree/include/linux/completion.h)
 
-use crate::{bindings, prelude::*, types::Opaque};
+use crate::{
+    bindings,
+    prelude::*,
+    time::Delta,
+    types::Opaque, //
+};
 
 /// Synchronization primitive to signal when a certain task has been completed.
 ///
@@ -111,4 +116,17 @@ pub fn wait_for_completion(&self) {
         // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
         unsafe { bindings::wait_for_completion(self.as_raw()) };
     }
+
+    /// Wait for completion of a task, with a timeout.
+    ///
+    /// Returns `true` if the task completed before `timeout` elapsed, and `false` otherwise.
+    pub fn wait_for_completion_timeout(&self, timeout: Delta) -> bool {
+        let timeout = timeout.as_millis().clamp(0, u32::MAX as i64) as u32;
+        let jiffies = crate::time::msecs_to_jiffies(timeout);
+
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        let remaining = unsafe { bindings::wait_for_completion_timeout(self.as_raw(), jiffies) };
+
+        remaining != 0
+    }
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
index 000000000000..f21619e7bdc7
--- /dev/null
+++ b/samples/rust/rust_driver_edu.rs
@@ -0,0 +1,423 @@
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
+    time::Delta,
+    types::ScopeGuard, //
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
+                    Flags::TRIGGER_NONE,
+                    c"rust_driver_edu",
+                    try_pin_init!(EduIrq {
+                        done <- Completion::new(),
+                        bar,
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
+        if !registration
+            .handler()
+            .done
+            .wait_for_completion_timeout(Delta::from_secs(1))
+        {
+            bar.write_reg(regs::STATUS::zeroed());
+
+            let pending = bar.read(regs::INTERRUPT_STATUS).status().get();
+            bar.write_reg(regs::INTERRUPT_ACK::zeroed().with_ack(pending));
+
+            registration.synchronize();
+
+            return Err(ETIMEDOUT);
+        }
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
+        if wait_dma().is_err() {
+            // The EDU device cannot abort an in-flight DMA. Keep the buffer
+            // alive so the device cannot write to freed memory.
+            core::mem::forget(src);
+            return Err(ETIMEDOUT);
+        }
+
+        // 2) device internal buffer -> RAM, landing in `dst`.
+        bar.write_reg(regs::DMA_SRC_ADDR::zeroed().with_src(DEV_BUF));
+        bar.write_reg(regs::DMA_DST_ADDR::zeroed().with_dst(dst_dma));
+        bar.write_reg(regs::DMA_CNT::zeroed().with_size(LEN as u32));
+        bar.write_reg(regs::DMA_CMD::zeroed().with_cmd(CMD_START | CMD_TO_RAM));
+        if wait_dma().is_err() {
+            // The EDU device cannot abort an in-flight DMA. Keep the buffer
+            // alive so the device cannot write to freed memory.
+            core::mem::forget(dst);
+            return Err(ETIMEDOUT);
+        }
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
+        let cleanup = ScopeGuard::new(|| {
+            pdev.clear_master();
+            pdev.disable_device();
+        });
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
+        cleanup.dismiss();
+
+        Ok(SampleDriverData { pdev, bar })
+    }
+}
+
+impl Drop for SampleDriverData<'_> {
+    fn drop(&mut self) {
+        dev_dbg!(self.pdev, "Remove Rust QEMU EDU driver sample.\n");
+
+        self.pdev.clear_master();
+        self.pdev.disable_device();
+    }
+}
+
+/// Per-interrupt state shared between process context and IRQ context.
+///
+/// The factorial computation signals `done` from the IRQ handler; the process
+/// context that started it waits on the same [`Completion`].
+#[pin_data]
+struct EduIrq<'bar, 'bound> {
+    #[pin]
+    done: Completion,
+    bar: &'bar Bar0<'bound>,
+}
+
+impl irq::Handler for EduIrq<'_, '_> {
+    // Runs in IRQ context when the EDU device raises its interrupt.
+    fn handle(&self) -> irq::IrqReturn {
+        let pending = self.bar.read(regs::INTERRUPT_STATUS).status().get();
+
+        if pending == 0 {
+            return irq::IrqReturn::None;
+        }
+
+        self.bar
+            .write_reg(regs::INTERRUPT_ACK::zeroed().with_ack(pending));
+        self.done.complete_all();
+
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

