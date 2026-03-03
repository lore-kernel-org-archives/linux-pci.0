Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99ED35BDC9
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496065; cv=none; b=qcZVyIdKLQVgv8bSt9hfOYPKtd1rJElsn4HOzdwPGUlFKkN6oxwDohM52V1e5goO6kQab9v2APyXxlMwQd/cBt7fW3vkZX+gHU0Mrv75+bLMpdatac2rgX9KouBIF6QvOuNeG73Bqh7/j0jW8zey85/Pd1KUHw9Y//HnbqOywGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496065; c=relaxed/simple;
	bh=g4F4QzDJ7y4CVPFfkparBIa6osJjoPCeEtBUy2R5LkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVa1Q79fIjyc8jXQv7qKifhxqmOJcoRG3BF74ZQUxPfjJOmWs6l3WvGUtYK2Whx+U2hcNO30gYrh33a7KV9nEhCw7SeGpNy5uMUWFIN2gCmlGJGSE0XXIAjnkFyrTojMzU5E9m4KAzyZgVOx3N0AFLByxrUt2Fqgha+Vkeor8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJ0mp0jo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJ0mp0jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496063; x=1804032063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4F4QzDJ7y4CVPFfkparBIa6osJjoPCeEtBUy2R5LkM=;
  b=iJ0mp0joPKRTggsSyFqhmvyiyoR80U3rPKh6CsP7EOgDvyXnct21L0jn
   xrzVh3bB/OzhdA6aa7WPPrZ6uGGNfNNC4Hh8+SNkN+7M+kTtr1gtxkpCV
   b8ytSScUnkIbPKD5aMFUxxqJ1PHWTfIhlLB8kvIFmDUjuWDOWeov4m5NC
   Km9oEad3R+ViZn+tSIGFoRB9fKCWo0aKQTTujOb1BcVqP6x0Wp+5oQJvd
   aftY15V2xB0xRKByNJHEIFoed3LX1ebmWwTCv8YGjHNJK7GSuYdJXLoMs
   QJPjP22YpGEjn8dci8VDYGNW4J23Mmnu/Q6cXK1GLZAUKdn30nyZ9Fqrr
   Q==;
X-CSE-ConnectionGUID: umMLjZzzRb6PjQgNN8ijmg==
X-CSE-MsgGUID: kKfOI6EdQc6BeMjGbHDUEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482940"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482940"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:58 -0800
X-CSE-ConnectionGUID: rfkNQQW2QOyIUXq4MavL+w==
X-CSE-MsgGUID: nN2ODUWRT4mtQtmWTjZhvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967109"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 10/19] x86, swiotlb: Teach swiotlb to skip "accepted" devices
Date: Mon,  2 Mar 2026 16:01:58 -0800
Message-ID: <20260303000207.1836586-11-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two mechanisms to force SWIOTLB operation, the kernel command
line option and the internal SWIOTLB_FORCE flag. With the arrival of
"accepted" devices, devices that have been enabled to DMA to private
encrypted memory, the SWIOTLB_FORCE flag is an awkward fit. It may be the
case that SWIOTLB operation wants to be forced regardless of the device
acceptance state.

Introduce a new SWIOTLB_UNACCPTED flag that allows for both augmenting the
result of is_swiotlb_force_bounce() dynamically and allowing for an "always
SWIOTLB" override.

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/swiotlb.h   | 15 ++++++++++++---
 arch/x86/kernel/pci-dma.c |  2 +-
 kernel/dma/swiotlb.c      |  1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..0efb9b8e5dd0 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -17,6 +17,7 @@ struct scatterlist;
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
 #define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
 #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_UNACCEPTED (1 << 3) /* swiotlb for unaccepted devices */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
@@ -91,6 +92,7 @@ struct io_tlb_pool {
  * @nslabs:	Total number of IO TLB slabs in all pools.
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
+ * @bounce_unaccepted: %true if unaccepted devices must bounce
  * @for_alloc:  %true if the pool is used for memory allocation
  * @can_grow:	%true if more pools can be allocated dynamically.
  * @phys_limit:	Maximum allowed physical address.
@@ -109,8 +111,9 @@ struct io_tlb_mem {
 	struct io_tlb_pool defpool;
 	unsigned long nslabs;
 	struct dentry *debugfs;
-	bool force_bounce;
-	bool for_alloc;
+	u8 force_bounce:1;
+	u8 bounce_unaccepted:1;
+	u8 for_alloc:1;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	bool can_grow;
 	u64 phys_limit;
@@ -173,7 +176,13 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 
-	return mem && mem->force_bounce;
+	if (!mem)
+		return false;
+	if (mem->force_bounce)
+		return true;
+	if (mem->bounce_unaccepted && !device_cc_accepted(dev))
+		return true;
+	return false;
 }
 
 void swiotlb_init(bool addressing_limited, unsigned int flags);
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 6267363e0189..8a737f501ae5 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -61,7 +61,7 @@ static void __init pci_swiotlb_detect(void)
 	 */
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		x86_swiotlb_enable = true;
-		x86_swiotlb_flags |= SWIOTLB_FORCE;
+		x86_swiotlb_flags |= SWIOTLB_UNACCEPTED;
 	}
 }
 #else
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a547c7693135..57e9647939fe 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -365,6 +365,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	io_tlb_default_mem.force_bounce =
 		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.bounce_unaccepted = flags & SWIOTLB_UNACCEPTED;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
-- 
2.52.0

