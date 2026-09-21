Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37963499F27
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000293; cv=none; b=iVu6OLsc4E7g+PD8ymEIggvQACxku2wD8vGOiRjdr5AMsTUbMBm9IuRb/NajACySjncvcxWSi7kaUuO/5VRdG+rt/qju57fmvX52DnR1mRT/urYzSSna4VJGHSbqzwUdanRJKLjCgrtCoArOyj73Je/wQ19dNMGRArpjs0GJyr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000293; c=relaxed/simple;
	bh=SX7zat08emQ/gBcyNyz65ukJ3L1PSIWRtVQCE68xO3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPFKNPy/PyODjsqgqf9ijtLvxjeexemlTb/HGyvZVaJku+moGdEEogj0cG3mv9F15pp8c4f6XrmHDO9ehIybLkWRuAcznQjyIvOEg903kC0jnnhRNs593iL5cJG+Z3neYvxxa0gVQ80fUl8LljwLv5+gmmeCt8IuGgcvwTu0eEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETIO6ZKm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETIO6ZKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000292; x=1821536292;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SX7zat08emQ/gBcyNyz65ukJ3L1PSIWRtVQCE68xO3Q=;
  b=ETIO6ZKmmT0pKkI6bnlgkJGKJku1IsKqaeHijuhVTrc0hTlwB+aV+bje
   Xv5yNbcNEIty2jmlLVPC3n8X9k2d8gW4K1a+OQ00AieGTnghUvmW7csn0
   tjC7+OiQDFLfm0iQqThfTrRfLvNlq4FBpJwpbLFo0TwMw/USOrrNq1pBy
   0B2AzNxOC4rJ69izGAFjsIfwTpAyoBKo+ClGTG0J9nH2TFqkzgCp+Zw0q
   u8EfDG0JKf0C3r7VzgnvwYI1zS0ei6Q8i+HjS9HOX4BA0dgdTyRWJdDYV
   /yBR0HohOXmhSXSd9c3YAszv7UhU087hZKTONHR24MxEF5UbFSu3aHHDO
   w==;
X-CSE-ConnectionGUID: ctRpIPU0SR22aDHCMYmI3w==
X-CSE-MsgGUID: KSIiISNcTlGT1YkbBEJXbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108355"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108355"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:12 -0700
X-CSE-ConnectionGUID: WKuAIlWaTeOIMzu/3EB8/g==
X-CSE-MsgGUID: f3XXseO1SSWc/UywcNGNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654383"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:11 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 3/8] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Mon, 21 Sep 2026 16:43:09 +0000
Message-ID: <20260921164316.3860312-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
vmd_configure_membar() and vmd_configure_membar1_membar2().
The refactor preserves MEMBAR address/offset/flags programming, but
resource name construction is now generated in the helper ("VMD MEMBAR%d")
instead of using two separate string literals.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 98 +++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2a8c10604c82..ed6d03656885 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -921,6 +921,69 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
 	};
 }
 
+/*
+ * vmd_configure_membar - Configure VMD MemBAR register, which points
+ * to MMIO address assigned by the OS or BIOS.
+ * @vmd: the VMD device
+ * @resource_number: resource buffer number to be filled in
+ * @membar_number: number of the MemBAR
+ * @start_offset: 4K aligned offset applied to start of VMD’s MEMBAR MMIO space
+ * @end_offset: 4K aligned offset applied to end of VMD’s MEMBAR MMIO space
+ *
+ * Function fills resource buffer inside the VMD structure.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+static int vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
+				u8 membar_number, resource_size_t start_offset,
+				resource_size_t end_offset)
+{
+	char *name;
+	u32 upper_bits;
+	unsigned long flags;
+
+	struct resource *res = &vmd->dev->resource[membar_number];
+
+	upper_bits = upper_32_bits(res->end);
+	flags = res->flags & ~IORESOURCE_SIZEALIGN;
+	if (!upper_bits)
+		flags &= ~IORESOURCE_MEM_64;
+
+	name = devm_kasprintf(&vmd->dev->dev, GFP_KERNEL, "VMD MEMBAR%d",
+			      resource_number);
+	if (!name)
+		return -ENOMEM;
+
+	vmd->resources[resource_number] = (struct resource){
+		.name = name,
+		.start = res->start + start_offset,
+		.end = res->end - end_offset,
+		.flags = flags,
+		.parent = res,
+	};
+
+	return 0;
+}
+
+static int vmd_configure_membar1_membar2(struct vmd_dev *vmd,
+					 resource_size_t mbar2_ofs)
+{
+	int ret;
+
+	ret = vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
+	if (ret)
+		return ret;
+
+	ret = vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
+	if (ret) {
+		devm_kfree(&vmd->dev->dev, (void *)vmd->resources[1].name);
+		memset(&vmd->resources[1], 0, sizeof(vmd->resources[1]));
+		return ret;
+	}
+
+	return 0;
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -972,9 +1035,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -1000,36 +1060,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 *
 	 * The only way we could use a 64-bit non-prefetchable MEMBAR is
 	 * if its address is <4GB so that we can convert it to a 32-bit
-	 * resource.  To be visible to the host OS, all VMD endpoints must
+	 * resource. To be visible to the host OS, all VMD endpoints must
 	 * be initially configured by platform BIOS, which includes setting
-	 * up these resources.  We can assume the device is configured
+	 * up these resources. We can assume the device is configured
 	 * according to the platform needs.
 	 */
-	res = &vmd->dev->resource[VMD_MEMBAR1];
-	upper_bits = upper_32_bits(res->end);
-	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
-		flags &= ~IORESOURCE_MEM_64;
-	vmd->resources[1] = (struct resource) {
-		.name  = "VMD MEMBAR1",
-		.start = res->start,
-		.end   = res->end,
-		.flags = flags,
-		.parent = res,
-	};
-
-	res = &vmd->dev->resource[VMD_MEMBAR2];
-	upper_bits = upper_32_bits(res->end);
-	flags = res->flags & ~IORESOURCE_SIZEALIGN;
-	if (!upper_bits)
-		flags &= ~IORESOURCE_MEM_64;
-	vmd->resources[2] = (struct resource) {
-		.name  = "VMD MEMBAR2",
-		.start = res->start + membar2_offset,
-		.end   = res->end,
-		.flags = flags,
-		.parent = res,
-	};
+	ret = vmd_configure_membar1_membar2(vmd, membar2_offset);
+	if (ret)
+		return ret;
 
 	/* Non-zero offset means guest/direct assign view. */
 	vmd_in_guest = offset[0] || offset[1];
-- 
2.43.0

