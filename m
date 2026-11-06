Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981771;
	b=YnC93smVqrePIJfTIgNokG4dTLtwovcVXDnkGIds5YT+auZSCRg5LdBvAqKHl8UuxjOm
	 SoOnXyD2aC1zDvMcNYWz/RUI1IC3MCxisKpoJeT5ak7+tuz2uW1TzGQ5TJHPSYN1nw+OQ
	 MbsweVev0aT93hzRxBLV8tEaHf+cdB100dg02lFAZeQ/w9afVCITTvCUwQgVKGcwATNFQ
	 dpvTISIi5CaLZ+SN1q85XZ6wynk0w3cLvJPIre1fhLcXnZaRq67uFqevUiNkOgtwOx6hX
	 l+nyTq4B9ZQ6MUGtCG5cFnpal+/VES9EvJDk1eo6JocPgjiXmP9mGCLcPFUtI5OGYdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hsbm3tsueFIyVxUi3SObjGF6OuwbZ8xJv0kioml9SrQ=;
	b=gRTffd4tjht8AnknnMBOl2+BpQHPFQuvNNxD1JtLy4c+yoZF/jYD4kPrWqHlP8FPc1vd
	 HPjY1aBEB8sNpxk5kFt+1X2PI03SpfrWIAVb2CRM7VpdbGpXuCx+NCdDk0s4akhBLou1b
	 fmeXhLgkQ8HuTpVeo2+zmfPSlg4BLWR0VaJXbY0W3qZ0pJaNtOPFcNOwSmNjsdSzHfeos
	 HSHJZOrbtGVsGThwNmh6OrQGB38aNRXyIheyOk8Wvk1dBcNrEuVYnmQRUYYlMjWsHAk2K
	 9BHaVpC0grwcE+P738WBFN6HTeirr8HkyIktmfHGndR+i0o/gI2c/BqbMxstg1MHzSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m3KXepFT;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9F606A334;
	Fri,  6 Nov 2026 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCA9F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m3KXepFT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793981770; x=1825517770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U1fsFgN8eHHU3b1NcDtMZ9pggZEZY8H+BAmiRQwy6fs=;
  b=m3KXepFT0UrABckiFneJapUoEuwQCah78M4TOAuNFcOHEVf79V0ndr33
   9Y9cp5qMQgICJ0XO8bcaalf7Pui35s7bZewZPbbqsTooRm36Kzszb96Jy
   uGzDVB3QXLMZ28+jvESePMfc7r+4vTrfiAqzigNXgi10e9WFgFUEK30P4
   eHruxD466lVUOqzDpBdJ0NX5Zqyu8RjyuEEFVmSj/KDAKTjD2AxGNdcSB
   GYtCelg0n2yhf42oWnB7sz5BHhihML5zxzmraB2vx/UT9/fp+xLJxTNcm
   rfUEYE85XuhHlscSYbpdU3h2HWuBwQfPzkMoP3PW3iC8hEIB+0sjXPz4E
   Q==;
X-CSE-ConnectionGUID: OPJRzaqPSrCYIMMJ3HCqyA==
X-CSE-MsgGUID: BqCJr7RPTMOMiYtv8WJZvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2889307"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2889307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:07 -0800
X-CSE-ConnectionGUID: guIz/Q7ESSGJhIv67Bi04w==
X-CSE-MsgGUID: aqQ0QnluSU+FWqL9jZ6PNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7341893"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:16:05 -0800
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
Subject: [PATCH v10 3/7] PCI: vmd: Add vmd_configure_membar() and vmd_configure_membar1_membar2()
Date: Fri,  6 Nov 2026 18:42:51 +0000
Message-ID: <20261106184256.4130-4-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
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
index 4992682a69b1..f50286ae242e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -970,6 +970,69 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
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
@@ -1021,9 +1084,6 @@ static void vmd_bus_enumeration(struct pci_bus *bus, unsigned long features)
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
-	struct resource *res;
-	u32 upper_bits;
-	unsigned long flags;
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
@@ -1049,36 +1109,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
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

