Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF235DA7F
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496065; cv=none; b=I7Xm1XjOqhrv/UeHmYSBJlfQNkfQXW1wYMhgIaaEeINLY2i4afoyS3A56XOnOITAHgQnzGaSPzHFrNHZkY0xqrOaetMy9V4WZUCpugPdyJh82i9oiZnw8wntEdSq2scAhaqPNyM4iW/UuYQeoOg2AqKKI3LSdLOkilL+rZo8nIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496065; c=relaxed/simple;
	bh=WekoBMxUp1EZBCCGXnYnYPFH/HQxRFBuQlQOfUaX3ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nplRtXmaYZ7L0bTvX1bLd9ylJvDrmPFKGCGH1ukxS22w6LLg9wwjaP6SgEJEDpkWp6YJ63T3ZjyZuc3bbNYIeu2iDvZGhYhQRloS6Ji7kIOjU2ylJUGgiqgtDwp8+xXEh8LCem5jPUCcn9pLng4r0HJ3e6CB7tgP/u6CysleyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aizL1FSP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aizL1FSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496065; x=1804032065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WekoBMxUp1EZBCCGXnYnYPFH/HQxRFBuQlQOfUaX3ek=;
  b=aizL1FSPyECjn17fkzwDa6nMcy+Y45PjuKnz5cz/btiz3SzMOUFSiVjP
   5XrYc5tEgF0YYd19bWx3QAB5irIl8in63n5/5blyR4yYdbWhihY0Xurvt
   ARzZU0ygtastQPhCqWeQiErubI7WB1mYexCYvaXVV/SKzewpzn8N84LZ1
   DOxJSDI+PI4EYmMxWicQc5U5a7c4p5Cl+iDcYf3B4b/7x7tB4+qfLi5I7
   KU78/Bq7B4iLEeoIlo0SFdgLwo/EBG43J9f2RFMwksUC/qiGZKrLc1ljH
   gbmt+k3d7IdLfGawccMOMlsgpTrNBfshgJvKA14+24stVJ6TrRF3L62Fb
   g==;
X-CSE-ConnectionGUID: hEYDqRo8SpSDBmadD8K2Lg==
X-CSE-MsgGUID: mxuB5AcDSDmTxOZ2JwRnLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482979"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:59 -0800
X-CSE-ConnectionGUID: i0nsa+tEQOOWvIKjjxhEfQ==
X-CSE-MsgGUID: tUo9w3ZVSpqHLIJVHPYCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967115"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:58 -0800
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 12/19] x86, ioremap, resource: Support IORES_DESC_ENCRYPTED for encrypted PCI MMIO
Date: Mon,  2 Mar 2026 16:02:00 -0800
Message-ID: <20260303000207.1836586-13-dan.j.williams@intel.com>
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

PCIe Trusted Execution Environment Device Interface Security Protocol
(TDISP) arranges for a PCI device to support encrypted MMIO. In support of
that capability, ioremap() needs a mechanism to detect when a PCI device
has been dynamically transitioned into this secure state and enforce
encrypted MMIO mappings.

Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
resource, "PCI MMIO Encrypted", with this description type is injected by
the PCI/TSM core for each PCI device BAR that is to be protected.

Unlike the existing encryption determination which is "implied with a
silent fallback to an unencrypted mapping", this indication is "explicit
with an expectation that the request fails instead of fallback".
IORES_MUST_ENCRYPT is added to manage this expectation.

Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
IORESOURCE_BUSY flag will only be set on a descendant/child of that
resource. That means it cannot share the same walk as the check for "System
RAM". Add walk_iomem_res_desc() to check if any IORES_DESC_ENCRYPTED
intersects the ioremap() range and set IORES_MUST_ENCRYPT accordingly. When
IORES_MUST_ENCRYPT is set, the entire ioremap() range must be covered by
IORES_DESC_ENCRYPTED.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/ioport.h |  1 +
 arch/x86/mm/ioremap.c  | 49 +++++++++++++++++++++++++++++++-----------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 1c106608c514..3efd07443c47 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -152,6 +152,7 @@ enum {
 enum {
 	IORES_MAP_SYSTEM_RAM		= BIT(0),
 	IORES_MAP_ENCRYPTED		= BIT(1),
+	IORES_MUST_ENCRYPT		= BIT(2), /* disable transparent fallback */
 };
 
 /* helpers to define resources */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..0f300e226a9f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -36,6 +36,7 @@
  */
 struct ioremap_desc {
 	unsigned int flags;
+	u64 encrypt_size;
 };
 
 /*
@@ -88,23 +89,35 @@ static unsigned int __ioremap_check_ram(struct resource *res)
 }
 
 /*
- * In a SEV guest, NONE and RESERVED should not be mapped encrypted because
- * there the whole memory is already encrypted.
+ * In a encrypted guest, NONE and RESERVED should not be mapped encrypted
+ * because there the whole memory is already encrypted.
+ *
+ * For the encrypted case the entire range must agree with being mapped
+ * encrypted.
  */
-static unsigned int __ioremap_check_encrypted(struct resource *res)
+static unsigned int __ioremap_check_encrypted(struct ioremap_desc *desc,
+					      struct resource *res)
 {
+	u32 flags = 0;
+
+	if (res->desc == IORES_DESC_ENCRYPTED)
+		flags |= IORES_MUST_ENCRYPT;
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return 0;
+		return flags;
 
 	switch (res->desc) {
 	case IORES_DESC_NONE:
 	case IORES_DESC_RESERVED:
 		break;
+	case IORES_DESC_ENCRYPTED:
+		desc->encrypt_size += resource_size(res);
+		fallthrough;
 	default:
-		return IORES_MAP_ENCRYPTED;
+		flags |= IORES_MAP_ENCRYPTED;
 	}
 
-	return 0;
+	return flags;
 }
 
 /*
@@ -134,14 +147,10 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
 	struct ioremap_desc *desc = arg;
 
-	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
-		desc->flags |= __ioremap_check_ram(res);
-
-	if (!(desc->flags & IORES_MAP_ENCRYPTED))
-		desc->flags |= __ioremap_check_encrypted(res);
+	desc->flags |= __ioremap_check_ram(res);
+	desc->flags |= __ioremap_check_encrypted(desc, res);
 
-	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
-			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
+	return 0;
 }
 
 /*
@@ -162,6 +171,13 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	memset(desc, 0, sizeof(struct ioremap_desc));
 
 	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
+	/*
+	 * Encrypted MMIO may parent a driver's requested region, so it needs a
+	 * separate search
+	 */
+	desc->encrypt_size = 0;
+	walk_iomem_res_desc(IORES_DESC_ENCRYPTED, IORESOURCE_MEM, start, end,
+			    desc, __ioremap_collect_map_flags);
 
 	__ioremap_check_other(addr, desc);
 }
@@ -209,6 +225,13 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 
 	__ioremap_check_mem(phys_addr, size, &io_desc);
 
+	if ((io_desc.flags & IORES_MUST_ENCRYPT) &&
+	    io_desc.encrypt_size < size) {
+		pr_err("ioremap: encrypted mapping unavailable for %pa - %pa\n",
+		       &phys_addr, &last_addr);
+		return NULL;
+	}
+
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-- 
2.52.0

