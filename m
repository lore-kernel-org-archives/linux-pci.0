Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8944A8FF5
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363279; cv=none; b=lsTH4/O38JQkbkTRJz89HiAWy0YzLh92KUru/Wu9C8Ga/kn018xh8eWvJmR+wERyVvb9vGVuLHfYEVM3r7mBFvIgsdh8ADPLeS/LaIVOVsJQSCkk6JihNZQPrPGb9UwlThkhV7Rtz5Rp3P/viNTROLuF8at5qq+zU637SLJJUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363279; c=relaxed/simple;
	bh=ioFSQLuHXnoqonY/mNTRe2D7gsjT6CZyV92GMFjQ8ys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXmCrk5Yt/pyldFvRYFYUrckniXIH508PbTKvk59VeacF/wcF/6Qp39umOMDwtWZXO2+WmpwDxI7V2BoHqw3AM9zn/x8Gk+zMZI/JmYvo3W/AoEsI5Lry5vwO3huXX2yUlYV8vmnXdWSyX7ZcEz9yyGH5KxX0zZyx0lrNXdOqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFbe8eiw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFbe8eiw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788363274; x=1819899274;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ioFSQLuHXnoqonY/mNTRe2D7gsjT6CZyV92GMFjQ8ys=;
  b=MFbe8eiwPvil/W/I8v8v9D7OdmOm9wUONXaQ+Gp39vDyzcb0mfHQZpCw
   4L036NKYq/ddcTEyo8MtCkgR+vNUYHcSsEo6kCr+K3kMBYLMaFUB50Ubh
   YkuCc3RDsjSwiTh9qP37Q9z2PBsV0nn0iDaSp06Qp+x+dDpuBP8JnSjb7
   hiH18RDhVjl/SIsUK5uuN1sB2JnpgjvrEilzny5cbPHLqLY4zUz5pMg6G
   PJO4crwk/bu9YzWyXyPWFJznX6400MJtxEST00wmVTYE38OIcnXO0bK9W
   sOtINMqf3ZQBLiu4TwVdkCsXMuCGHwRm0InVJ1PEr1X1njP3ZBEhcdp5m
   Q==;
X-CSE-ConnectionGUID: /78ne3tmQ365trROWfCb3g==
X-CSE-MsgGUID: wj9LjQuhSYmF2CG6nZw/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92646699"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92646699"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:33 -0700
X-CSE-ConnectionGUID: rGXoxqq5RO+TpuZLpB+0Dw==
X-CSE-MsgGUID: wYY/nW2dSBmO17yuSXxhAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="271406892"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 08:34:31 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v7 8/8] PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value
Date: Wed,  2 Sep 2026 17:58:44 +0000
Message-ID: <20260902175846.3497854-9-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
References: <20260902175846.3497854-1-szymon.durawa@linux.intel.com>
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
 drivers/pci/controller/vmd.c | 66 ++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 7e76ef3d7ec8..f4c6a16e8473 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -467,10 +467,23 @@ static unsigned int vmd_bus_to_ecam(struct vmd_dev *vmd, unsigned int busnr)
 static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
+	unsigned char bus_number;
 	unsigned int busnr_ecam;
 	u32 offset;
 
-	busnr_ecam = vmd_bus_to_ecam(vmd, bus->number);
+	/*
+	 * Remap ONLY the virtual BUS1 root bus number (0x80) to its physical
+	 * CFGBAR start aperture (0xE1). Downstream subordinate buses behind
+	 * the root port are assigned physical numbers (0xF1..0xFF per
+	 * VMD_BUSRANGE1) and must NOT be remapped, otherwise child endpoint
+	 * accesses would target the root port rather than their own ECAM space.
+	 */
+	if (vmd->bus1_rootbus && bus->number == VMD_PRIMARY_BUS1)
+		bus_number = vmd->busn_start[VMD_BUS_1];
+	else
+		bus_number = bus->number;
+
+	busnr_ecam = vmd_bus_to_ecam(vmd, bus_number);
 	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
 
 	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
@@ -550,18 +563,39 @@ static struct pci_ops vmd_ops = {
 static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_dev)
 {
 	struct pci_host_bridge *bridge;
-	u32 busnr, addr;
+	struct vmd_dev *vmd;
+	u32 addr;
+	int busnr;
+	u8 pci_bus_number;
+	u8 bridge_bus_number;
 
 	if (pci_dev->bus->ops != &vmd_ops)
 		return NULL;
 
+	vmd = vmd_from_bus(pci_dev->bus);
 	bridge = pci_find_host_bridge(pci_dev->bus);
-	busnr = pci_dev->bus->number - bridge->bus->number;
+	pci_bus_number = pci_dev->bus->number;
+	bridge_bus_number = bridge->bus->number;
+
+	/*
+	 * BUS1 is registered with logical root number 0x80. For ACPI companion
+	 * matching, map only the logical root bus (0x80) to the physical
+	 * BUS1 start base (0xE1). Downstream child buses (0xF1..0xFF) already
+	 * reflect their physical bus numbers and must remain untranslated to
+	 * produce the correct relative depth against bridge_bus_number.
+	 */
+	if (vmd->bus1_rootbus && bridge->bus == vmd->bus[VMD_BUS_1]) {
+		bridge_bus_number = vmd->busn_start[VMD_BUS_1];
+		if (pci_bus_number == VMD_PRIMARY_BUS1)
+			pci_bus_number = vmd->busn_start[VMD_BUS_1];
+	}
+
+	busnr = pci_bus_number - bridge_bus_number;
 	/*
 	 * The address computation below is only applicable to relative bus
 	 * numbers below 32.
 	 */
-	if (busnr > 31)
+	if (busnr < 0 || busnr > 31)
 		return NULL;
 
 	addr = (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
@@ -1186,6 +1220,7 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
 			  struct pci_sysdata *sd, resource_size_t *offset,
 			  u8 primary)
 {
+	u8 root_busnr;
 	u8 cfgbar = bus_number * 3;
 	u8 membar1 = cfgbar + 1;
 	u8 membar2 = cfgbar + 2;
@@ -1198,8 +1233,27 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
 	pci_add_resource_offset(&resources, &vmd->resources[membar2],
 				offset[1]);
 
-	vmd_bus = pci_create_root_bus(&vmd->dev->dev,
-				      vmd->busn_start[bus_number], &vmd_ops, sd,
+	/*
+	 * Register BUS1 with its logical root number (0x80) up front so PCI core
+	 * bridge scanning does not see a post-registration bus-number mutation.
+	 *
+	 * This is a workaround for pci_scan_bridge_extend() code.
+	 * It marks bridge invalid configuration when detecting a
+	 * non-zero (0x80) the VMD BUS1 root bus number. Thus Primary Bus Number
+	 * of Root Ports on BUS1 is deconfigured in the first pass of
+	 * pci_scan_bridge() to be re-assigned to 0x0 in the second pass.
+	 * As a result no subordinate bus number behind VMD BUS1 is found.
+	 * Workaround: VMD_BUS_1 bus number shall be set to VMD_PRIMARY_BUS1 so it has
+	 * the same value as vmd->bus[VMD_BUS_1]->primary, it will bypass bus number
+	 * reconfiguration.
+	 */
+
+	if (bus_number == VMD_BUS_1 && vmd->bus1_rootbus)
+		root_busnr = VMD_PRIMARY_BUS1;
+	else
+		root_busnr = vmd->busn_start[bus_number];
+
+	vmd_bus = pci_create_root_bus(&vmd->dev->dev, root_busnr, &vmd_ops, sd,
 				      &resources);
 
 	if (!vmd_bus) {
-- 
2.43.0

