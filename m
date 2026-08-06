Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46085364EB6
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045824; cv=none; b=mzQEAAYFlwl0p1orSvqvELz3fPNyBY5nthuxcw7EnJfvBpFq1Dh3pcJI16j7pKwsPCnT/o/ZwBwhTUcPvBIuZ+W2OlkmLPlc86Q8fQeqn9eWSiBXBLULYmB06m2UPypafab9ZlbQvI8VdMruHsx2tmkJ31KifcBkJn7G0D35mqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045824; c=relaxed/simple;
	bh=Y1nPPxwaZiUfVDcnGdGN63mAFUyg6w6m/xpxBfNtD+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrZp7H9QiOPtu5AWG/3lcGOU6GhzfWe/1lxNZ55mkaMLEAHl6ff+VAh++oH8bMfZp5lnVcDW+yfwzr/TAJLeIz1BHiCdgDubA+C8mwsOx+S4iaNCEilORYq1IjYEfRcM586zF1wfnrH7b6m6j9n4snJW6uEPdCquMxp9/KZDd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9SUtHyF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9SUtHyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045816; x=1817581816;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Y1nPPxwaZiUfVDcnGdGN63mAFUyg6w6m/xpxBfNtD+g=;
  b=h9SUtHyFu2kHkLuDLYZbsgzT1ql9jZwOidhJWMLmdvVY25sZT5TmQrQW
   wF12h3WJcdvUH90JuRsBTgBmVC5SqdtV7Q4BLjxEM9cKVDHzN8/qRg+D2
   JYHD/Zfg8tm9gIQI9w1/u8QdaPjAMDoPAUTs1CoU2TVvHY1lnXEGs201Y
   xBdd2OV5Mc29ESxFUopyGOmsHDuPI0l5dleT8LcUG4xM7YpZW3/I1LnZf
   yJVWS8yBZCr1I2pk+WjYGZeEgkDsgVRr5trmI7xFwDjllqXR6UXMwpHvM
   xrY9kEz2JVueWruRj6i9ktqA801Uvmtfx+QSV59ZQgagtrzG7tDOQGx1K
   Q==;
X-CSE-ConnectionGUID: mqCq728ARGe84tGiQ3SxdQ==
X-CSE-MsgGUID: CYBgOwnuSLqMaVRaFJn9dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622530"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622530"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:09 -0700
X-CSE-ConnectionGUID: HKmxsHO4R/ik724C3bJ9Qw==
X-CSE-MsgGUID: Ee/3B003Qh+xMnUEkxQ5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923402"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:07 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 3/8] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Thu,  6 Aug 2026 22:13:42 +0000
Message-ID: <20260806221351.38592-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
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
index 2c824660cabd..62bc9b91300b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -783,6 +783,69 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -834,9 +897,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -883,36 +943,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
 
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
-- 
2.43.0

