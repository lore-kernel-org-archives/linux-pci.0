Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696751C077;
	Thu, 15 Oct 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068035; cv=pass; b=PLAy/yShNe/IWkswOvu+b4EQSD/qm1gbkywdZYjdBCZ2QomgIUpWcr7hFEvyqKGivI6N7raGwLyOqtjwcdTWU0ZPVU8PQONnvI1TMmaXcB732e95H+GBqEHN/K8JQficZvHyX6s9NVQoAsn2N+c93GiArrv1/9M5mmwlFb6b8EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068035; c=relaxed/simple;
	bh=al3CME/inp0DukWbj0924UKJ7/mOzuRSXXvkNW61d4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FdyfHYA1e3ANMhlOz8pC2IX5CUS2arAa3A8vh9H3T7ijqJTMphVH9Ap4gscF/Nc6GNAesyXczpu5c+Idp9T93S1eYqW91/IZ2rtf5kHH+ybWDJI6NOeSJfj9KA9WRVU2Q0pEI9NHbZ6Wk31CI2ma4Hq1RJ35svJVK6ZR3ZMQoUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Te0ofT7W; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Te0ofT7W"
ARC-Seal: i=1; a=rsa-sha256; t=1792067998; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CLYVnIv0YslQQGivCi2x1vd2eoWUHm23qh1dix3svOFnThoMWjSVujyHRNnIlCWE54brbiEAu0U1UZOafyoNd8SqbmnXL/776a8efwh0gQ4EejRqJvGHWjQzifgqpoEW3CO2+cZe2niZmfoyJ3lzTzWI07rzxi/1pqzUNdjNnNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792067998; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q85EzV/zGA0BWz9e+hHW+D6/t0h0lhxXVushOZlu8W4=; 
	b=k7LcEcXdeV4bH2xnLGRYyCfaCxiVQzBupS5tvTCFvS6mcTtHusg2XmLNq33B2BDGsxMLVfUJFm61YwmXKtqdoDPGFS+ZyXYSb1qIMNagF6xv5NgTVRJm1RGjCusMcJt+q0zod6nc/uIogHE3f20aeDpvUHxCHp+DGAueSUh2Ets=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792067998;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=q85EzV/zGA0BWz9e+hHW+D6/t0h0lhxXVushOZlu8W4=;
	b=Te0ofT7WSIzSF7wO9e84VzOKiJYYdRjVdcC4htHGNrc1JcaaQAyaNUVyKHJfDmb8
	ij1oKIedutEOtWBgPOkIewlmImSe0BbxzBYGPnGOt/6pagrCGHlHwGMdhmEpURbqFQS
	tx+JZrFSsCOzoPZ/Ox6WZ4pL4Ot79mROmlUEV1rg=
Received: by smtp.zohomail.com with SMTPS id 1792067995759443.73080526438025;
	Thu, 15 Oct 2026 05:39:55 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 15 Oct 2026 09:39:11 -0300
Subject: [PATCH 7/7] drm/tyr: mark read-only and write-only registers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-io-access-modes-v1-7-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The documentation in regs.rs describes some registers as read-only or
write-only, but nothing enforces it, and most registers do not document
a mode at all.

Declare every read-only and write-only register with the `#[ro]` and
`#[wo]` attributes of `register!`, so that writing a read-only register,
or reading a write-only one, does not compile. The modes follow the
documentation in regs.rs where there is one, and otherwise the register
permissions in Arm's kbase driver for v10 GPUs. Both halves of a 64-bit
register get the same mode, and so do the aliases of `GPU_COMMAND`.

No existing access goes against these modes, so the driver code does not
change.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 69c901afb28f..6695a292c786 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -63,6 +63,7 @@ pub(crate) mod gpu_control {
         base: TyrRegisters;
 
         /// GPU identification register.
+        #[ro]
         pub(crate) GPU_ID(u32) @ 0x0 {
             /// Status of the GPU release.
             3:0     ver_status;
@@ -81,6 +82,7 @@ pub(crate) mod gpu_control {
         }
 
         /// Level 2 cache features register.
+        #[ro]
         pub(crate) L2_FEATURES(u32) @ 0x4 {
             /// Cache line size.
             7:0     line_size;
@@ -93,12 +95,14 @@ pub(crate) mod gpu_control {
         }
 
         /// Shader core features.
+        #[ro]
         pub(crate) CORE_FEATURES(u32) @ 0x8 {
             /// Shader core variant.
             7:0     core_variant;
         }
 
         /// Tiler features.
+        #[ro]
         pub(crate) TILER_FEATURES(u32) @ 0xc {
             /// Log of the tiler's bin size.
             5:0     bin_size;
@@ -107,6 +111,7 @@ pub(crate) mod gpu_control {
         }
 
         /// Memory system features.
+        #[ro]
         pub(crate) MEM_FEATURES(u32) @ 0x10 {
             0:0     coherent_core_group => bool;
             1:1     coherent_super_group => bool;
@@ -114,6 +119,7 @@ pub(crate) mod gpu_control {
         }
 
         /// Memory management unit features.
+        #[ro]
         pub(crate) MMU_FEATURES(u32) @ 0x14 {
             /// Number of bits supported in virtual addresses.
             7:0     va_bits;
@@ -122,11 +128,13 @@ pub(crate) mod gpu_control {
         }
 
         /// Address spaces present.
+        #[ro]
         pub(crate) AS_PRESENT(u32) @ 0x18 {
             31:0    present;
         }
 
         /// CSF version information.
+        #[ro]
         pub(crate) CSF_ID(u32) @ 0x1c {
             /// MCU revision ID.
             3:0     mcu_rev;
@@ -164,6 +172,7 @@ pub(crate) mod gpu_control {
         }
 
         /// IRQ sources to clear. Write only.
+        #[wo]
         pub(crate) GPU_IRQ_CLEAR(u32) @ 0x24 {
             /// Clear the GPU_FAULT interrupt, a 1-bit boolean flag.
             0:0     gpu_fault => bool;
@@ -202,6 +211,7 @@ pub(crate) mod gpu_control {
         }
 
         /// IRQ status for enabled sources. Read only.
+        #[ro]
         pub(crate) GPU_IRQ_STATUS(u32) @ 0x2c {
             /// GPU_FAULT interrupt status, a 1-bit boolean flag.
             0:0     gpu_fault => bool;
@@ -328,11 +338,13 @@ fn from(mode: FlushMode) -> Self {
         /// - [`GPU_COMMAND::reset()`]
         /// - [`GPU_COMMAND::flush_caches()`]
         /// - [`GPU_COMMAND::clear_fault()`]
+        #[wo]
         pub(crate) GPU_COMMAND (u32) @ 0x30 {
             7:0     command ?=> GpuCommand;
         }
         /// Internal alias for GPU_COMMAND in reset mode.
         /// Use [`GPU_COMMAND::reset()`] instead.
+        #[wo]
         GPU_COMMAND_RESET (u32) => GPU_COMMAND {
             7:0     command ?=> GpuCommand;
             11:8    reset_mode ?=> ResetMode;
@@ -340,6 +352,7 @@ fn from(mode: FlushMode) -> Self {
 
         /// Internal alias for GPU_COMMAND in cache flush mode.
         /// Use [`GPU_COMMAND::flush_caches()`] instead.
+        #[wo]
         GPU_COMMAND_FLUSH (u32) => GPU_COMMAND {
             7:0     command ?=> GpuCommand;
             /// L2 cache flush mode.
@@ -389,6 +402,7 @@ pub(crate) fn clear_fault() -> Self {
         base: TyrRegisters;
 
         /// GPU status register. Read only.
+        #[ro]
         pub(crate) GPU_STATUS(u32) @ 0x34 {
             /// GPU active, a 1-bit boolean flag.
             0:0     gpu_active => bool;
@@ -474,6 +488,7 @@ fn from(access: AccessType) -> Self {
         base: TyrRegisters;
 
         /// GPU fault status register. Read only.
+        #[ro]
         pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
             /// Exception type.
             7:0     exception_type ?=> ExceptionType;
@@ -493,10 +508,12 @@ fn from(access: AccessType) -> Self {
         /// Once a fault is reported, it must be manually cleared by issuing a
         /// [`GPU_COMMAND::clear_fault()`] command to the [`GPU_COMMAND`] register. No further GPU
         /// faults will be reported until the previous fault has been cleared.
+        #[ro]
         pub(crate) GPU_FAULTADDRESS_LO(u32) @ 0x40 {
             31:0    pointer;
         }
 
+        #[ro]
         pub(crate) GPU_FAULTADDRESS_HI(u32) @ 0x44 {
             31:0    pointer;
         }
@@ -519,39 +536,47 @@ fn from(access: AccessType) -> Self {
         }
 
         /// GPU cycle counter. Read only.
+        #[ro]
         pub(crate) CYCLE_COUNT_LO(u32) @ 0x90 {
             31:0    count;
         }
 
+        #[ro]
         pub(crate) CYCLE_COUNT_HI(u32) @ 0x94 {
             31:0    count;
         }
 
         /// Global time stamp. Read only.
+        #[ro]
         pub(crate) TIMESTAMP_LO(u32) @ 0x98 {
             31:0    timestamp;
         }
 
+        #[ro]
         pub(crate) TIMESTAMP_HI(u32) @ 0x9c {
             31:0    timestamp;
         }
 
         /// Maximum number of threads per core. Read only constant.
+        #[ro]
         pub(crate) THREAD_MAX_THREADS(u32) @ 0xa0 {
             31:0    threads;
         }
 
         /// Maximum number of threads per workgroup. Read only constant.
+        #[ro]
         pub(crate) THREAD_MAX_WORKGROUP_SIZE(u32) @ 0xa4 {
             31:0    threads;
         }
 
         /// Maximum number of threads per barrier. Read only constant.
+        #[ro]
         pub(crate) THREAD_MAX_BARRIER_SIZE(u32) @ 0xa8 {
             31:0    threads;
         }
 
         /// Thread features. Read only constant.
+        #[ro]
         pub(crate) THREAD_FEATURES(u32) @ 0xac {
             /// Total number of registers per core.
             21:0    max_registers;
@@ -565,173 +590,211 @@ fn from(access: AccessType) -> Self {
         ///
         /// A bitmap where each bit indicates support for a specific compressed texture format.
         /// The bit position maps to an opaque format ID (`texture_features_key_t` in spec).
+        #[ro]
         pub(crate) TEXTURE_FEATURES(u32)[4] @ 0xb0 {
             31:0    supported_formats;
         }
 
         /// Shader core present bitmap. Read only constant.
+        #[ro]
         pub(crate) SHADER_PRESENT_LO(u32) @ 0x100 {
             31:0    value;
         }
 
+        #[ro]
         pub(crate) SHADER_PRESENT_HI(u32) @ 0x104 {
             31:0    value;
         }
 
         /// Tiler present bitmap. Read only constant.
+        #[ro]
         pub(crate) TILER_PRESENT_LO(u32) @ 0x110 {
             31:0    present;
         }
 
+        #[ro]
         pub(crate) TILER_PRESENT_HI(u32) @ 0x114 {
             31:0    present;
         }
 
         /// L2 cache present bitmap. Read only constant.
+        #[ro]
         pub(crate) L2_PRESENT_LO(u32) @ 0x120 {
             31:0    present;
         }
 
+        #[ro]
         pub(crate) L2_PRESENT_HI(u32) @ 0x124 {
             31:0    present;
         }
 
         /// Shader core ready bitmap. Read only.
+        #[ro]
         pub(crate) SHADER_READY_LO(u32) @ 0x140 {
             31:0    ready;
         }
 
+        #[ro]
         pub(crate) SHADER_READY_HI(u32) @ 0x144 {
             31:0    ready;
         }
 
         /// Tiler ready bitmap. Read only.
+        #[ro]
         pub(crate) TILER_READY_LO(u32) @ 0x150 {
             31:0    ready;
         }
 
+        #[ro]
         pub(crate) TILER_READY_HI(u32) @ 0x154 {
             31:0    ready;
         }
 
         /// L2 ready bitmap. Read only.
+        #[ro]
         pub(crate) L2_READY_LO(u32) @ 0x160 {
             31:0    ready;
         }
 
+        #[ro]
         pub(crate) L2_READY_HI(u32) @ 0x164 {
             31:0    ready;
         }
 
         /// Shader core power up bitmap.
+        #[wo]
         pub(crate) SHADER_PWRON_LO(u32) @ 0x180 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) SHADER_PWRON_HI(u32) @ 0x184 {
             31:0    request;
         }
 
         /// Tiler power up bitmap.
+        #[wo]
         pub(crate) TILER_PWRON_LO(u32) @ 0x190 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) TILER_PWRON_HI(u32) @ 0x194 {
             31:0    request;
         }
 
         /// L2 power up bitmap.
+        #[wo]
         pub(crate) L2_PWRON_LO(u32) @ 0x1a0 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) L2_PWRON_HI(u32) @ 0x1a4 {
             31:0    request;
         }
 
         /// Shader core power down bitmap.
+        #[wo]
         pub(crate) SHADER_PWROFF_LO(u32) @ 0x1c0 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) SHADER_PWROFF_HI(u32) @ 0x1c4 {
             31:0    request;
         }
 
         /// Tiler power down bitmap.
+        #[wo]
         pub(crate) TILER_PWROFF_LO(u32) @ 0x1d0 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) TILER_PWROFF_HI(u32) @ 0x1d4 {
             31:0    request;
         }
 
         /// L2 power down bitmap.
+        #[wo]
         pub(crate) L2_PWROFF_LO(u32) @ 0x1e0 {
             31:0    request;
         }
 
+        #[wo]
         pub(crate) L2_PWROFF_HI(u32) @ 0x1e4 {
             31:0    request;
         }
 
         /// Shader core power transition bitmap. Read-only.
+        #[ro]
         pub(crate) SHADER_PWRTRANS_LO(u32) @ 0x200 {
             31:0    changing;
         }
 
+        #[ro]
         pub(crate) SHADER_PWRTRANS_HI(u32) @ 0x204 {
             31:0    changing;
         }
 
         /// Tiler power transition bitmap. Read-only.
+        #[ro]
         pub(crate) TILER_PWRTRANS_LO(u32) @ 0x210 {
             31:0    changing;
         }
 
+        #[ro]
         pub(crate) TILER_PWRTRANS_HI(u32) @ 0x214 {
             31:0    changing;
         }
 
         /// L2 power transition bitmap. Read-only.
+        #[ro]
         pub(crate) L2_PWRTRANS_LO(u32) @ 0x220 {
             31:0    changing;
         }
 
+        #[ro]
         pub(crate) L2_PWRTRANS_HI(u32) @ 0x224 {
             31:0    changing;
         }
 
         /// Shader core active bitmap. Read-only.
+        #[ro]
         pub(crate) SHADER_PWRACTIVE_LO(u32) @ 0x240 {
             31:0    active;
         }
 
+        #[ro]
         pub(crate) SHADER_PWRACTIVE_HI(u32) @ 0x244 {
             31:0    active;
         }
 
         /// Tiler active bitmap. Read-only.
+        #[ro]
         pub(crate) TILER_PWRACTIVE_LO(u32) @ 0x250 {
             31:0    active;
         }
 
+        #[ro]
         pub(crate) TILER_PWRACTIVE_HI(u32) @ 0x254 {
             31:0    active;
         }
 
         /// L2 active bitmap.  Read-only.
+        #[ro]
         pub(crate) L2_PWRACTIVE_LO(u32) @ 0x260 {
             31:0    active;
         }
 
+        #[ro]
         pub(crate) L2_PWRACTIVE_HI(u32) @ 0x264 {
             31:0    active;
         }
 
         /// Revision ID. Read only constant.
+        #[ro]
         pub(crate) REVIDR(u32) @ 0x280 {
             31:0    revision;
         }
@@ -739,6 +802,7 @@ fn from(access: AccessType) -> Self {
         /// Coherency features present. Read only constant.
         /// Supported protocols on the interconnect between the GPU and the
         /// system into which it is integrated.
+        #[ro]
         pub(crate) COHERENCY_FEATURES(u32) @ 0x300 {
             /// ACE-Lite protocol supported, a 1-bit boolean flag.
             0:0     ace_lite => bool;
@@ -866,6 +930,7 @@ fn from(status: McuStatus) -> Self {
         base: TyrRegisters;
 
         /// MCU status. Read only.
+        #[ro]
         pub(crate) MCU_STATUS(u32) @ 0x704 {
             /// Read current state of MCU.
             1:0 value => McuStatus;
@@ -897,6 +962,7 @@ pub(crate) mod job_control {
         /// Clear job interrupts. Write only.
         ///
         /// Write a 1 to a bit to clear the corresponding bit in [`JOB_IRQ_RAWSTAT`].
+        #[wo]
         pub(crate) JOB_IRQ_CLEAR(u32) @ 0x1004 {
             /// Clear CSG request interrupts.
             30:0    csg;
@@ -918,6 +984,7 @@ pub(crate) mod job_control {
         ///
         /// This register contains the result of ANDing together [`JOB_IRQ_RAWSTAT`] and
         /// [`JOB_IRQ_MASK`].
+        #[ro]
         pub(crate) JOB_IRQ_STATUS(u32) @ 0x100c {
             /// CSG request interrupt status.
             30:0    csg;
@@ -953,6 +1020,7 @@ pub(crate) mod mmu_control {
 
         /// IRQ sources to clear.
         /// Write a 1 to a bit to clear the corresponding bit in [`IRQ_RAWSTAT`].
+        #[wo]
         pub(crate) IRQ_CLEAR(u32) @ 0x2004 {
             /// Clear the PAGE_FAULT interrupt.
             15:0    page_fault;
@@ -973,6 +1041,7 @@ pub(crate) mod mmu_control {
         /// IRQ status for enabled sources. Read only.
         ///
         /// This register contains the result of ANDing together [`IRQ_RAWSTAT`] and [`IRQ_MASK`].
+        #[ro]
         pub(crate) IRQ_STATUS(u32) @ 0x200c {
             /// PAGE_FAULT interrupt status.
             15:0    page_fault;
@@ -1388,6 +1457,7 @@ fn from(cmd: MmuCommand) -> Self {
             base: TyrRegisters;
 
             /// MMU command register for each address space. Write only.
+            #[wo]
             pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
                 7:0     command ?=> MmuCommand;
             }
@@ -1517,6 +1587,7 @@ fn from(access: MmuAccessType) -> Self {
             base: TyrRegisters;
 
             /// Fault status register for each address space. Read only.
+            #[ro]
             pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {
                 /// Exception type.
                 7:0     exception_type ?=> MmuExceptionType;
@@ -1527,15 +1598,18 @@ fn from(access: MmuAccessType) -> Self {
             }
 
             /// Fault address for each address space. Read only.
+            #[ro]
             pub(crate) FAULTADDRESS_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2420 {
                 31:0    pointer;
             }
 
+            #[ro]
             pub(crate) FAULTADDRESS_HI(u32)[MAX_AS, stride = STRIDE] @ 0x2424 {
                 31:0    pointer;
             }
 
             /// MMU status register for each address space. Read only.
+            #[ro]
             pub(crate) STATUS(u32)[MAX_AS, stride = STRIDE] @ 0x2428 {
                 /// External address space command is active, a 1-bit boolean flag.
                 0:0     active_ext => bool;
@@ -1783,10 +1857,12 @@ fn from(sh: PtwShareability) -> Self {
             }
 
             /// Extra fault information for each address space. Read only.
+            #[ro]
             pub(crate) FAULTEXTRA_LO(u32)[MAX_AS, stride = STRIDE] @ 0x2438 {
                 31:0    value;
             }
 
+            #[ro]
             pub(crate) FAULTEXTRA_HI(u32)[MAX_AS, stride = STRIDE] @ 0x243c {
                 31:0    value;
             }
@@ -1816,6 +1892,7 @@ pub(crate) mod doorbell_block {
         base: TyrRegisters;
 
         /// Doorbell request register. Write-only.
+        #[wo]
         pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride = STRIDE] @ 0x80000 {
             /// Doorbell set. Writing 1 triggers the doorbell.
             0:0    ring => bool;

-- 
2.56.0

