Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAB13BE65F
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367679; cv=none; b=dSrNVaCMtsFPZ6ls++kKtjV8P4Q6IeYCYKGLzQzkiD/EkQi1+0iFP9M6JUutbsIVZOYEw4X9w0Rhs4fyvMzjO0Z/KlwWStXQ4s3yJ0cSBuL000XPCGgVwuJoISgtLN/YJJQG5WN6Qo2UReihQcYybADbtxUtg9rTscu9Fr+WRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367679; c=relaxed/simple;
	bh=UFTUQ3CEzAWAix8OarSm+7VManle3VlIFDwPD0u1J4I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3VXfZ9hvwrtBWGP5/j1Cho7PdcWglvob6MCeYpdI63uu05iGiRB/dtgWMjsUjDPbLF60JAzVJEQ6igwgu5lBWySaSBC5WjEAiQOpi3YinJ8Mip9ShfmpPfAMW0YBGSMbaABYFPor4+kPIN/EWCO4wU4/Z9g+Uwck2lgyIjK55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PulPDtOt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PulPDtOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367677; x=1813903677;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UFTUQ3CEzAWAix8OarSm+7VManle3VlIFDwPD0u1J4I=;
  b=PulPDtOtBebgt9ZlhckogqeLFVndYKiN4yxa0AHn5+i6B+ItNRw3wSq9
   KPRbfmw+knqqjJkIWtlTVIh3KaS03LiAYPQ9VAOgobRDCcEIGu8Llf6xX
   nm9jGMSriZxBvEw2u/irCgColfXLHSohSgYu89L4C67nT12v5EAJA2fQV
   6UgrmLRzjCAF7OiFAeOT1LmeLVquuHynP/q+HpQXdWjr+RvcKsIhKp35B
   4dYQma2zrTop7M3ATd+kdbmkZPAJWV9YFuFA1hJGKfp0XV2YA68zf8x2X
   60BA8SZ1bZd9Wev5HyrYfIya0zVXMSal1BLVBJL0aMoUs/GZteei3yLxd
   w==;
X-CSE-ConnectionGUID: WQ1Seur+QXOdWR4ZyGFB0w==
X-CSE-MsgGUID: HBCJSyNJStGnSTFqEbr9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021827"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021827"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:57 -0700
X-CSE-ConnectionGUID: 4wwIeSoFRXuHRTUUwYK6Ag==
X-CSE-MsgGUID: i+IeejMiSl2zRZQvVPwjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725439"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:07:55 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 3/8] PCI: vmd: Add vmd_configure_membar() and  vmd_configure_membar1_membar2()
Date: Thu, 25 Jun 2026 08:29:32 +0000
Message-ID: <20260625082940.1290740-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
vmd_configure_membar() and vmd_configure_membar1_membar2(). No functional
changes.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 80 ++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 2c824660cabd..443a0cefb7f7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -783,6 +783,48 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
+ */
+static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
+				 u8 membar_number, resource_size_t start_offset,
+				 resource_size_t end_offset)
+{
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
+	vmd->resources[resource_number] = (struct resource){
+		.name = kasprintf(GFP_KERNEL, "VMD MEMBAR%d",
+				  membar_number / 2),
+		.start = res->start + start_offset,
+		.end = res->end - end_offset,
+		.flags = flags,
+		.parent = res,
+	};
+}
+
+static void vmd_configure_membar1_membar2(struct vmd_dev *vmd,
+					  resource_size_t mbar2_ofs)
+{
+	vmd_configure_membar(vmd, 1, VMD_MEMBAR1, 0, 0);
+	vmd_configure_membar(vmd, 2, VMD_MEMBAR2, mbar2_ofs, 0);
+}
+
 static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 {
 	struct pci_bus *child;
@@ -834,9 +876,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -883,36 +922,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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
+	vmd_configure_membar1_membar2(vmd, membar2_offset);
 
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
@@ -1074,6 +1089,11 @@ static void vmd_remove(struct pci_dev *dev)
 	pci_stop_root_bus(vmd->bus);
 	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus);
+
+	/* CFGBAR is static, does not require releasing memory */
+	kfree(vmd->resources[1].name);
+	kfree(vmd->resources[2].name);
+
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
 	vmd_remove_irq_domain(vmd);
-- 
2.43.0

