Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5E418351
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045836; cv=none; b=NQ75wJ5/9VFFjHpIJ4ttcG/pnIGM1snI0SMjwb/Rhe+n+SPbidF3LdpG83fGj3Yozw6rsWsIBc3RPgdIE73h+V+afB8t8vm7vi+g560TOdBJdcuairwTjSJb7x5FSSTZM27fFQXlMOsUvzz1dAsQ1QGjBKH+Le/X1fw0r6ogMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045836; c=relaxed/simple;
	bh=Tz1IzC8ZDuemhQq0WjqyFn9EZLRHWYbRacNPVnzkEOk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/c2YfjCMPNtVjzCTlyn3e7H1UDjp4KgIC44yNkH3Q4ykYRM5idhub4naEfSlfLW5gz+C5w9KP4cChAHfuvZa4Qrfqa6RXYE9tKOh07JBtWOb/SSltAi33YLUfblDbs60wLD9VTZBVOkeqQoVmrhGcJL3ulPn2EUSybvdw2eV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQno6cHJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQno6cHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045831; x=1817581831;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Tz1IzC8ZDuemhQq0WjqyFn9EZLRHWYbRacNPVnzkEOk=;
  b=LQno6cHJUR6YkBV/6+tVYoicBHy+PSJ/XWd/Frg0Y94DVX3PdbuGtcZz
   tnu2T6FPvuwpynMfkwF9gHhMf7D//54pxAl9bkTOwA8054E9NfR+6+c5H
   1WFnMr8g/vJpFju55E0E3yBKcRuPQ0D5dvaa3ZRv84Hj+3DyU+o5L8Owx
   meTe8XinHXBqbPrgrsC9mLtkHLmjXWWIpiw6VNgfcztRcpbsTqddFY2il
   oGe5U22xXVwZeNGR0RfJUvB+6T7NDdVpWEOWCxkhLG3YRBneYohY9GUBB
   WpFBHBHJSosdpitPFRgzrsjfstCBtf5njFxa9hEHw8c+20UQkmUlz3jaS
   A==;
X-CSE-ConnectionGUID: Tk/Q1Ny+QbOVwRXDAlFWRA==
X-CSE-MsgGUID: 6/qppbakSy2H4d1DBOEe1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85622547"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="85622547"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:21 -0700
X-CSE-ConnectionGUID: gOS/Bm3ySGCVDeOnUl29Xg==
X-CSE-MsgGUID: V2pVxdv6R3WGe2V1QhuGwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="260923432"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:50:20 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: helgaas@kernel.org,
	nirmal.patel@linux.intel.com,
	szymon.durawa@linux.intel.com,
	djbw@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de
Subject: [PATCH v6 8/8] PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value
Date: Thu,  6 Aug 2026 22:13:47 +0000
Message-ID: <20260806221351.38592-9-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
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
 drivers/pci/controller/vmd.c | 67 ++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 7c4379d565ea..8da2e6727282 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -440,8 +440,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
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
+	 * BUS1 is registered with logical bus number 0x80 to avoid bridge
+	 * reconfiguration, but cfg accesses must target the original BUS1
+	 * restricted range start.
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
@@ -520,18 +534,37 @@ static struct pci_ops vmd_ops = {
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
+	 * matching, compute the relative bus number against the original BUS1
+	 * restricted range base.
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
@@ -1045,6 +1078,7 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
 			  struct pci_sysdata *sd, resource_size_t *offset,
 			  u8 primary)
 {
+	u8 root_busnr;
 	u8 cfgbar = bus_number * 3;
 	u8 membar1 = cfgbar + 1;
 	u8 membar2 = cfgbar + 2;
@@ -1057,8 +1091,27 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_number,
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

