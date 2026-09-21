Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45284A2A45
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000302; cv=none; b=tkTqJQ+i2WFWzm901Ehreinbhac7R+CGxvXCA754GV4jQiMd5eMdxdF1Ighd0F4UDTxduUp8HUxSnfsO9smPSFDugyV8ib4IaXEM78kT53xVBsI6iogM73ic6PEpoGVdzoib2L9h46n6ItYSYNFLiyU8gbYvQz/4BP9ct6mx0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000302; c=relaxed/simple;
	bh=nzeiYxIkmMeuPHzSEbSUWDczSsTherwb3h6rziRb+TE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl2Ok4sYkS9Ce5GYc/+I0ZlXvX0EuDbmCx0i+9BrJxwfar1XFxWTNJ1mUX+ooJoOzpAKtORyMARJAn7EJXrioUOTV0bTD7PS5Ks6tSyHsQcD891hZ5GIYq3RQok5sM4+rvnOCinWBGswQ1wgG1Xafnsaa2h0ml03aWBhzxUYpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsZKwWHx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsZKwWHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790000300; x=1821536300;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nzeiYxIkmMeuPHzSEbSUWDczSsTherwb3h6rziRb+TE=;
  b=lsZKwWHxSR6olhDVoGJ3m1Aw4Y0Y27mIbWNAsHi2NUpUqtGAoWq9dH3+
   Ir4qw6WQIc9d25Dta8Yj8Sacwphi61o354EYhZSQrjZF+JeyWjxgeBF0+
   S7EXbzk2UafS/lgnkeGZTmavXG8MnPCgkAOSI1epATpAm+b3sG5ckxISS
   42G1IUDpd6JdY2UxVyq8C+lDmfPfQ7j8K9zy9O4YCx3j1WZfWhbeJMj5o
   tzV0IYCKLpDAEsKKnUv7+5oQawVNnHGJj0mnayk1WkY3FtIAwOiOLdCCC
   fHgXd5J7kSQRn+UaM/Fe5Z/aGj/MrydfdS2mnJ/ARHCTBJ210fSa8QR82
   w==;
X-CSE-ConnectionGUID: RYFsqM0NTJmJvwAbupxipA==
X-CSE-MsgGUID: UPNDUiW/TUiM5iopub18nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101108386"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101108386"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:20 -0700
X-CSE-ConnectionGUID: +/cFxsN0QqiMkVdA32YQ2A==
X-CSE-MsgGUID: xsY3rj6NSQSRvOFMZy/i0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3654417"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:18:20 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v8 8/8] PCI: vmd: Workaround for hardwired BUS1 bus number
Date: Mon, 21 Sep 2026 16:43:14 +0000
Message-ID: <20260921164316.3860312-9-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMD BUS1 root bus number is fixed in hardware to 0x80. When the
PCI core sees a non-zero value (0x80) for the BUS1 primary bus number, it
treats the bridge configuration as invalid and attempts to reassign the
bus number.

This is especially problematic when a second root bus is present. In
the first pass of pci_scan_bridge(), the root bus number is temporarily
deconfigured so it can be reassigned to 0x00 in the second pass. As a
result, no subordinate bus behind the VMD BUS1 root bus is discovered.

To avoid that reconfiguration, the BUS1 bus number must match the BUS1
primary bus number. Keep the VMD BUS1 root bus number fixed instead of
reassigning it.

Log snippet without workaround:

  vmd 0000:00:0e.0: PCI host bridge to bus 10000:e1
  pci_bus 10000:e1: busn_res: can not insert [bus e1-ff] under domain [bus
   00-ff] (conflicts with (null) [bus e0-f0])
  pci_bus 10000:e1: root bus resource [bus f1-ff]
  pci_bus 10000:e1: root bus resource [mem 0x8c800000-0x8cffffff]
  pci_bus 10000:e1: root bus resource [mem 0x701b802000-0x701bffffff 64bit]
  pci_bus 10000:e1: scanning bus
  pci (null): Looking for ACPI companion (address 0x80e0ffff)
  pci 10000:e1:1c.0: [8086:7f38] type 01 class 0x060400 PCIe Root Port
  pci 10000:e1:1c.0: PCI bridge to [bus f1]
  pci 10000:e1:1c.0: scanning [bus f1-f1] behind bridge, pass 0
  pci 10000:e1:1c.0: primary 80, bus->number e1.
  pci 10000:e1:1c.0: bridge configuration invalid
   ([bus f1-f1]), reconfiguring
  pci 10000:e1:1c.0: scanning [bus 00-00] behind bridge, pass 1

Log snippet with workaround implemented:

  vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  pci_bus 10000:e0: root bus resource [bus e2-f0]
  pci_bus 10000:e0: root bus resource [mem 0x8c000000-0x8c7fffff]
  pci_bus 10000:e0: root bus resource [mem 0x701b002000-0x701b801fff 64bit]
  vmd 0000:00:0e.0: PCI host bridge to bus 10000:80
  pci_bus 10000:80: busn_res: can not insert [bus 80-ff] under domain [bus
   00-ff] (conflicts with (null) [bus e0-f0])
  pci_bus 10000:80: root bus resource [bus f1-ff]
  pci_bus 10000:80: root bus resource [mem 0x8c800000-0x8cffffff]
  pci_bus 10000:80: root bus resource [mem 0x701b802000-0x701bffffff 64bit]
  pci 10000:e2:00.0: [144d:a80a] type 00 class 0x010802 PCIe Endpoint
  pci 10000:e2:00.0: BAR 0 [mem 0x8c000000-0x8c003fff 64bit]
  pci 10000:e0:01.0: PCI bridge to [bus e2]
  pci 10000:e0:01.0: Primary bus is hard wired to 0
  pci 10000:80:1d.0: [8086:09ab] type 00 class 0x088000
   conventional PCI endpoint
  pci 10000:80:1d.4: [8086:7f34] type 01 class 0x060400 PCIe Root Port
  pci 10000:80:1d.4: PCI bridge to [bus f1]
  pci 10000:80:1d.4: PME# supported from D0 D3hot D3cold
  pci 10000:f1:00.0: [144d:a810] type 00 class 0x010802 PCIe Endpoint
  pci 10000:f1:00.0: BAR 0 [mem 0x8c900000-0x8c903fff 64bit]
  pci 10000:80:1d.4: PCI bridge to [bus f1]
  vmd 0000:00:0e.0: Bound to PCI domain 10000

Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 69 ++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 51b8c2d9b7f0..91c5b02bf91d 100644
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
@@ -550,18 +563,40 @@ static struct pci_ops vmd_ops = {
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
+
 	/*
 	 * The address computation below is only applicable to relative bus
 	 * numbers below 32.
 	 */
-	if (busnr > 31)
+	if (busnr < 0 || busnr > 31)
 		return NULL;
 
 	addr = (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
@@ -1188,6 +1223,7 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
 			  struct pci_sysdata *sd, resource_size_t *offset,
 			  bool vmd_in_guest, u8 primary)
 {
+	u8 root_busnr;
 	u8 cfgbar = bus_number * 3;
 	u8 membar1 = cfgbar + 1;
 	u8 membar2 = cfgbar + 2;
@@ -1200,8 +1236,29 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
 	pci_add_resource_offset(&resources, &vmd->resources[membar2],
 				offset[1]);
 
-	vmd_bus = pci_create_root_bus(&vmd->dev->dev,
-				      vmd->busn_start[bus_number], &vmd_ops, sd,
+	/*
+	 * Register BUS1 with its logical root number (0x80) up front so PCI core
+	 * bridge scanning does not see a post-registration bus-number mutation.
+	 *
+	 * This is a workaround for pci_scan_bridge_extend(). That code marks a
+	 * bridge as misconfigured when it detects a non-zero root bus number for
+	 * VMD BUS1, even though the hardware hardwires that value to 0x80.
+	 *
+	 * In the first pass of pci_scan_bridge(), the Primary Bus Number of Root
+	 * Ports on BUS1 is therefore deconfigured and then reassigned to 0x0 in
+	 * the second pass. As a result, no subordinate bus number behind
+	 * VMD BUS1 is found.
+	 *
+	 * Workaround: set VMD_BUS_1's bus number to VMD_PRIMARY_BUS1 so it
+	 * matches vmd->bus[VMD_BUS_1]->primary and bypasses bus number
+	 * reconfiguration.
+	 */
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

