Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039352;
	b=d6iJssQcDl2Ex4NevCjNWkWPRPifSy8GMVFtJgLT6xFMXuU1MYa3npFe/tKKIBTPaU+u
	 5sbnkzMSyq9Y5kDSP1CborXATYEYlFnVimGOUnZrBahQGrK0ucJSuP3RDzPkGb6h2SNY1
	 avqywzfmorATAfXM2HV5sc7y+0bFjoQDWMKA2P/xBozLrus8iIBIx5rS5WUO2++vvZHvQ
	 bGIiND8JQ+Dldu2DtMW2gtLzgUuesU35ioFnVpik6Zs4R+g20jTf8pbSxwmzslAKXdvWP
	 1vn1hXDx++ZRZLYUY4mzkogpNaTNKu80q7u5tOewwPowI9DkBzzcToSLH9cpx2+ozLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039352;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xDF23dahX51haMxAq3quKVra0ILWOrtg3h/bCysqn+g=;
	b=KYKrKIQXWJ4QN8gbQF7bx8ryqtkD2XhfujWAdM3MpsueYUX8KN2a6vKtZhug04+bVk3G
	 Pu2qGVLsCAam+yCASkOtbUasNP+wIS263CwiMjkAnHsYPLB8vCK2Nd0jXI8bcpd39pQid
	 8lWMAsNLY7073d+kb+FCQE4d8xUWRQVs6vuMLJF2Pk2XE1eexpfXIA1Zi4QRwSq9MJLp2
	 mSKO0m3vYtPpVyQuUe0pUDDI/804l0pmDjhi7pTDB+DrJSSIcKHmT8FF70vbSMeykYtw+
	 hErMr9Rm7qe9vHZd9u3X1WmA4oDYFOAvln0RLH4azP/SkysrQoAmybzfvofvxA8XPNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gr9BZZF7;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FB606A327;
	Mon, 26 Oct 2026 18:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23FB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gr9BZZF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039352; x=1824575352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIuS2i48SBYyhxRyVGiKc8FBJfFo6xAzJR/XNcA5OZ8=;
  b=gr9BZZF74AnBgvE3h2MmLNaZKE8WBRUeeM9FlNWGaC0kLHJFPHb1D2s6
   DEzXSnvMDbZ1lsY6z31VgRQRfC8C7IEWz/aMKFo8ctmq7gFRiTyTBzAOJ
   VtdtlOR2WsYqODkzd6FxIbxT/zFX1AfOFmXmmBqEf1El7/sManxE8ysAv
   ahAYC14IuNusRupVFA/7TfEbik1XxTKOUXNFSxRDp3AgPk8y5yJ2CU8D/
   7WnzUAVrCrzEnn9fvLCD4OGsX5Fp9KCHYqMAzTbG+LI9+A7VqUJ+i8jEx
   B9IijsLiFwp3MQbx2JzMbO2Wv7CyY3LkYOFtRxppPdB5Xan1aAC3RCDnM
   A==;
X-CSE-ConnectionGUID: nRxtQKDLTMeFiWGVpEOEgg==
X-CSE-MsgGUID: L9KoPftJSweD6gSDn4EAQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1601011"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1601011"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:12 -0700
X-CSE-ConnectionGUID: 7MnmWUSOTqime5zzZQ8iHg==
X-CSE-MsgGUID: JL/NShr/TdGaIBPvm05VLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4720090"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:29:10 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	asutosh.pathak@linux.intel.com,
	szymon.durawa@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Mon, 26 Oct 2026 20:54:56 +0000
Message-ID: <20261026205502.3502574-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
References: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the MEMBAR1 and MEMBAR2 registry initialization code to new helpers
vmd_configure_membar() and vmd_configure_membar1_membar2().
The refactor preserves MEMBAR address/offset/flags programming, but
resource name construction is now generated in the helper ("VMD MEMBAR%d")
instead of using two separate string literals.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
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

