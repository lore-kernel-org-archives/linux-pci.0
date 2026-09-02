Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D73264F7
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363257; cv=none; b=ZCEQjvrk4JMEZlkVrWNVkf63qsxZJE5jA5e3wwmf4kCoMOKb+Bk3DUUoPQYan9brFyldB15yJe83pKauc3xAWQLR/vcq6nuXv3YAUD+kBALG1gUYlwDxy7AtOBX++dN6V9tOKMuXY6jSO911iZkEeN2oGbxUxGvAwUhzDCgP27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363257; c=relaxed/simple;
	bh=VgX4Ihn7goLHg+dndc1AJIY9y7Jnnal3gmEmzdo8xTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm7Hc5mxDaVADU3+GEAOaeG4QtDBLVsE48mjVJF6hdzioDu37qsJ8xQ20X19gbsZrZA3l23OACW71gj2oqpzQeAs9lElX/pJB/0nB4np6ryJAb/VJ3iIP6QqT/nz6pNgDdL4xw6K/2oz/iR1enGoSPTTNbZCpf/j+V8lwy/TZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV9Fx6my; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV9Fx6my"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363255; x=1819899255;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VgX4Ihn7goLHg+dndc1AJIY9y7Jnnal3gmEmzdo8xTU=;
  b=TV9Fx6myfFogXCyHgjoYIOddU+1x9BrwM6n+/3PXHZj9skKkl2+MYfsQ
   smekxFRPYtOZ8OLH2F6sdIUdRRjHMGqNOuHaIWZcaa0M0uO/qm51eljYN
   i3LOcVN+Mv7Shq19RmvSEPFH7upr3trx59ecfB3rtVTpyyIR90zhPKRT6
   4D7HwiNBW/tAtH7pcyDEdVRsKuQeBOtg4oj/NWKvTo1So+FVbT7g9STcr
   OrxivP5FOHheipGpJ/r/dtH3oqPp2ExGSVhm4LXVPGyH3VpPv+t2Auuz8
   retCVTez7/yzhhBqb0Y2BS77N80k/JNOYYhkmfaDk25pimf4fRFz5U3yG
   A==;
X-CSE-ConnectionGUID: 8iYFj8EeTXGT93syTLXKEQ==
X-CSE-MsgGUID: zZVZUSw8SQyeMx9uPRBwGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646668"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:14 -0700
X-CSE-ConnectionGUID: pZjeWZZ6SYeBzVNMCPO3Zw==
X-CSE-MsgGUID: Sw+Mad/6S9CiAvbhtPa4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406773"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:13 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 3/8] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Wed,  2 Sep 2026 17:58:39 +0000
Message-ID: <20260902175846.3497854-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
References: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
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
index 08636e2ba010..213aba6fc9bb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -918,6 +918,69 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -969,9 +1032,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -996,36 +1056,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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

