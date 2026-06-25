Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91033BD225
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367689; cv=none; b=Rxr2Zvh2BiV2pPYSn9PqZbxVmHqIBu23keiAv55fLnWFz2QdyeosK1kldTPZrOh0htp3OmNRoYeljn34+Qh3PBCErsW8E49yTZ1Q4iVqowNcTBsuH+/9IiIej7n6z5KdpqPQTxgOHibbV/hwsQS/UlbK+NEpfyqj8w28w6fjZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367689; c=relaxed/simple;
	bh=1VOoiLR0j1YBE4wf/JYLuCrkUZ4+LDG6UkhY6WL8TSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJs6PvZmaiS3M/GeUBcW4G34cwx9vBRS1czuZy/5MwKs5g8oJdwj3zUBZAjf6LfIDwWcCa+3zekcf0LgUmstUzuefSB9FOj/H1NiwATgjVeCBD1oCt73MfptyaOc4oIqLzUKG8nswM5DiWe8xc6LUt6j/09GUJ0pSlNBPudbZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU8TkQMQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU8TkQMQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367686; x=1813903686;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1VOoiLR0j1YBE4wf/JYLuCrkUZ4+LDG6UkhY6WL8TSQ=;
  b=mU8TkQMQSouNwI+dR0LH9AziRoF15Z45jjgtdXo4kHdWBG8+ThET+dFK
   ZUNdwUXlSpc3n+QbiBQ8P6Qud8foLIAQyO5JbvM0+muxxKgimgIuvoQwS
   QhMnCwsVWqjxogPrEUafuN8qWwZS29N/o9g4SulhUdfIfRDnaSyMCLTIm
   bB+dcnv0MDWqmXzrg4i6vInLsbYifYs/OQZlstPX8xF/xYoK0tYKBkjOQ
   P6+ltGtP1z1EZRMHlq97G4MPnHakpA6ti2ziCAz9LbWui+9wLFotkMIms
   QwcvvrO4246ljh/TTmN8EnpshARe3iB6hcJhbxqc2pU1cHC4gLM+s9ku5
   A==;
X-CSE-ConnectionGUID: tt1TMMs4TLe1ybOPNpE6JA==
X-CSE-MsgGUID: HUOjxo+jR7qvzoSS+8P6+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83021851"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83021851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:06 -0700
X-CSE-ConnectionGUID: I821HI8HS8uUdXMANdT4+A==
X-CSE-MsgGUID: zCjqLIkYRH+fGAP0ouBtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250725566"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:08:04 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v5 8/8] PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value
Date: Thu, 25 Jun 2026 08:29:37 +0000
Message-ID: <20260625082940.1290740-9-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMD BUS1 root bus number is fixed in hardware to 0x80. It marks bridge
invalid configuration when detecting a non-zero (0x80) the VMD BUS1 root
bus number.
Thus root bus number is deconfigured in the first pass of pci_scan_bridge()
to be re-assigned to 0x0 in the second pass. As a result no subordinate bus
number behind VMD BUS1 is found.

To avoid bus number reconfiguration, BUS1 number has to be the same
as BUS1 primary number.

Log snippet without workaround:

[    3.752507] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e1
[    3.752510] pci_bus 10000:e1: busn_res: can not insert [bus e1-ff] under domain [bus 00-ff] (conflicts with (null) [bus e0-f0])
[    3.752515] pci_bus 10000:e1: root bus resource [bus f1-ff]
[    3.752517] pci_bus 10000:e1: root bus resource [mem 0x8c800000-0x8cffffff]
[    3.752519] pci_bus 10000:e1: root bus resource [mem 0x701b802000-0x701bffffff 64bit]
[    3.752523] pci_bus 10000:e1: scanning bus
[    3.752732] pci (null): Looking for ACPI companion (address 0x80e0ffff)
[    3.752745] pci 10000:e1:1c.0: [8086:7f38] type 01 class 0x060400 PCIe Root Port
[    3.752779] pci 10000:e1:1c.0: PCI bridge to [bus f1]
[    3.752861] pci 10000:e1:1c.0: PME# supported from D0 D3hot D3cold
[    3.752864] pci 10000:e1:1c.0: PME# disabled
[    3.752909] pci 10000:e1:1c.0: PTM enabled (root), 4ns granularity
[    3.752981] pci 10000:e1:1c.0: vgaarb: pci_notify
[    3.752987] pci_bus 10000:e1: fixups for bus
[    3.752992] pci 10000:e1:1c.0: scanning [bus f1-f1] behind bridge, pass 0
[    3.752993] pci 10000:e1:1c.0: primary 80, bus->number e1.
[    3.752994] pci 10000:e1:1c.0: bridge configuration invalid ([bus f1-f1]), reconfiguring
[    3.753003] pci 10000:e1:1c.0: scanning [bus 00-00] behind bridge, pass 1
[    3.753004] pci 10000:e1:1c.0: primary 00, bus->number e1.

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index c68ea7837620..d0527be78ebd 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -440,8 +440,23 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
-	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
-	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
+	unsigned char bus_number;
+	unsigned int busnr_ecam;
+	u32 offset;
+
+	/*
+	 * VMD workaround: for VMD BUS1, bus->number is set to VMD_PRIMARY_BUS1
+	 * (see comment in vmd_enable_domain() under vmd_create_bus() for BUS1)
+	 * but original value is 0xE1 which is stored in
+	 * vmd->busn_start[VMD_BUS_1].
+	 */
+	if (vmd->bus1_rootbus && bus->number == VMD_PRIMARY_BUS1)
+		bus_number = vmd->busn_start[VMD_BUS_1];
+	else
+		bus_number = bus->number;
+
+	busnr_ecam = bus_number - vmd->busn_start[VMD_BUS_0];
+	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
 		return NULL;
@@ -1177,6 +1192,19 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		 */
 		vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_BUS1;
 
+		/*
+		 * This is a workaround for pci_scan_bridge_extend() code.
+		 * It marks bridge invalid configuration when detecting a
+		 * non-zero (0x80) the VMD BUS1 root bus number. Thus Primary Bus Number
+		 * of Root Ports on BUS1 is deconfigured in the first pass of
+		 * pci_scan_bridge() to be re-assigned to 0x0 in the second pass.
+		 * As a result no subordinate bus number behind VMD BUS1 is found.
+		 * Workaround: update vmd->bus[VMD_BUS_1]->number and
+		 * vmd->bus[VMD_BUS_1]->primary to the same value, which
+		 * bypasses bus number reconfiguration.
+		 */
+		vmd->bus[VMD_BUS_1]->number = VMD_PRIMARY_BUS1;
+
 		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
 				       &vmd->bus[VMD_BUS_1]->dev.kobj,
 				       "domain1"),
-- 
2.43.0

