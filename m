Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB093DB330;
	Fri, 14 Aug 2026 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738658; cv=fail; b=cKA9Ij0UYNRu46g6sNyQR6skP+zJHlF4kKrXn7zzxf56tAFEq07GnZEdK1dOC/kiIeVXIaHG+ixIdN3xqYLoG/C+Auj3JOXHzyrZm6RHebv4vKf3OJxt7DnIm0L7b0e7DXt+8XtgGaT6w3UuHJsak4prvx2KTBgliXjxHwoIB6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738658; c=relaxed/simple;
	bh=mGjdeunCiopVN+fIO/z8+U5SHyaJFfuytixY+cieap4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ox4Aomx++iSgm6+/B152UbD6kC0l1sydsp9xFMGa25adrEymYIG5rqhqZ5Jh/m9K0j0b2Njko3uagNTMVOs0eDdDWEj5/7CnlqcNl9HRBGrJc/XtFt+r5CBwzMV/zO6CzVRNgrHK7DzH/Gp8wfzb6o+r5rZEz9ij/d0wwGT3UpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgZ0wGIM; arc=fail smtp.client-ip=52.101.46.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgZ0wGIM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbiwCDZYpwQCdGpgQHCOb5cP00ZHYBldh+JbqgyCUuedB4v93JZq2Ge5ofciw65W+mxK53XfSWhOThBNsGR0IXNi7Ttzd2Z5QzOq6mm188ws9d1wdL6l0rg/n+a1vzAAdL4EvFzfJvPQcX20Hn8wSRIa5s/wkDY8367kQEprK8jE+/lL6K5LjSmmm+d2CVs8RfRQTAmYsj3nPDhcCqgzaRmunrpkvDhEDboyVQ/L6vXLDIrzPcaRBFKjBeVeTagpEtJI06jZT4QyNR2tF3jpy4Cn/YONZd/lnb2gbbiof/F8CyQ3qy2arB5r8cD+BCPxeoOjKXicGSO/IaPr3K+2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQHg3/ZDHNTI3U+0azY5p6C0q2rN2wVTnH/b4yBpzEo=;
 b=BIUNznJ7HGDr9NcPDvIe9XG2vEQHuHrVQdTC5n9yQYjC0T9DPev40EmeHJAR2aOBmC0HvLCOgGKKCrMxGkzWo+C2eTvn5TU2o9Ah+wpxUHduVsdz4dZcHVhaTn5tixrlFWfU9ZOu6GLemtB1qyh4DT+rsDZLbxG1jaaom7O+8RkmrTwejWy/NbaDPYHRH5zXM1+UBn6UMb1BFYMm95pTD78lPQ70KSPj7uLrRHfSByHOBscL+qZnPkMG3SEpdhfvTvf1hhau7MS3Jql3qJwxWg9wK2jC4DMCHl62Fr9OSNB7CFVDfjZCJPLQVjRT7TDrU73ohuHcGnGMiCbGe2rYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQHg3/ZDHNTI3U+0azY5p6C0q2rN2wVTnH/b4yBpzEo=;
 b=YgZ0wGIMMV4WGbtJcHFkwgSY6AXn4cugjfJG3bXiaYmsejICn3elXaHXJmfOq5H4Q6LtIoKk2VaVUEmldUyIa9naYnxck6o514Gq5I9+Rg//BQsotrLfGZ76rtKL8NBjH3fGG9PqZWmRjezpFGrGHr30BbJls/0lixK2a01Lk1oGfMIbVXmRY0p7CEDPC68Ov79u3yv5uvypU0R0auaGplpfqE7fDVc/0I4J1lHRslTT72kiO/XrWyUPbbXLLJBf7cp/MtrKVin/IeyRT38TX0bgU8yfMTaBVZWeViQRDnYX2jmPZJhSl8EI0xjc6m4aoxJeMSRSelX2yKo1IVDNgQ==
Received: from SA1P222CA0151.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::21)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 20:17:27 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::18) by SA1P222CA0151.outlook.office365.com
 (2603:10b6:806:3c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 20:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:17:06 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:17:03 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 4/5] PCI: Clear stale 14-Bit Tag Requester Enable when a link leaves Flit Mode
Date: Sat, 15 Aug 2026 01:46:20 +0530
Message-ID: <20260814201621.2281245-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814201621.2281245-1-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: ca32cdf2-1212-4838-27ec-08defa410f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|22082099003|18002099003|18092099006|56012099006|6133799003|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	8ZtT5Xjrz5E5T7Nxrx0NPPh7Pjf4cvuKVwU1Ro15Z3pGOLL48imH+CT1mt6UeM4J2PsfSfFC8RLQeANCLnV9jIORaw92jFcOUHNbry4pWGaYRooU1O7WSfwTCjIF83EMA+xE8QX/PGS0+tgi6YO1Aq8bfyZKjDtFaF5SrNcoweRklE+Hw2sX7Cda0nFR5aRB4IQ8aPFqg4kcQAAQ8eJifjjabLNZB5eu1OQK33q4jDGgSyuzT7iWedlbEtroEwnWb6hbxIc1v5+4BwzsfyrnlTxl+DpkcKtuS6Nw44kTRAaCK+oveSxgVLh+ZvxLcuoiXHHo9jU5XmOdUxpM0UjCm3inY0Sv9MZZPhxfljZDCm8/Oh3HasHdnEs3BwT/OoGi0EaNYDfWXygE3jYgWW3VJYu08JQZ+w9iED5a8WcCUg2fhIA6sXcpn635tn4RgErjviMMcoHtMplSSEBtXJdM+IiuNQVioTM8vhHnhG8kQPmIyaF/gTJMXASYhjGsQ1zypnbG2S3UjSY/dEMPkw/APNGWzU8y5AG2uY+V/PiXgaQJvtkVZ9uxzFgEfvEQJjryO3CZsSKMpQ7eExPUH3+SiOJ22fLmzkSjinK3BV0xTUS1LQdSKtU0D+enKTNo/ltBKBZeHKr87z1eESQDrYZT8lP6Qhg6Y9vftvaHckmIHqcp4QCEBqjcF9Rrs4roc1W/5di/qLW35caydMmKLyjagQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(18092099006)(56012099006)(6133799003)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alvQlsx5d4p5J9f8HthJOvhMYpBOQgYi20FrE3G6ML8K7XFKI7HMH84F7OFURPcAs71NRjA6dQ0NfkGVu3UDdavvBtuBcDfKrMEoWDKrVxuqIKST7ItI0Q0qRmx9aY8kFEmc+4juiD2ZkCPZ0Znf+Otck2YwXIcQw5mDipRJPrht5O4IOxasTzbobzQxXQuC8GSaPRXP3w1fLNP/xWqmNS1Kth5Z9GhUI8RUBBHuRJDq/jbHYTFsz4Hpgp/vvnkRvKDAvTvhgwmo3I6jICkbsp7DUwoZ6lqdKt3LVRsjBZ/YYp5uIunOO2HRtjXG9Dn6bm0CNOiuWK3PZr5vFjWwraTTMiUdRB73oP6AmJvsSolV53bbUSYLreGOo2yjGl493wKzGD/IcpgmhVIUYe6yV698LYprncVckX9I3V16sxMo/VZ23MLNv5I1fZhYa91Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:27.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca32cdf2-1212-4838-27ec-08defa410f8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222

Sanitizing DEV3_CTL on restore covers the devices that go through
pci_dev_restore(), but those are not the only devices whose 14-Bit Tag
Requester Enable can go stale, and for the case that hurts most they are
not even the right device.

For a reset mediated by a bridge, i.e. a Secondary Bus Reset, a DPC
trigger and release, an AER bus reset, a slot reset or a bridge
D3cold->D0 resume, the bridge itself is neither reset nor saved and
restored.  The bridge is however the requester for the config read the
core issues to the device below as soon as the link is back up.  If the
link returns in Non-Flit Mode while the bridge still has 14-Bit Tag
Requester Enable set, that very first config read fails with a Completion
Timeout and an Unexpected Completion, because the device does answer but
with a completion the bridge can no longer match.  Devices below the
bridge that are reached only by paths which never call pci_dev_restore(),
such as a DPC release or a hotplug link status update, have the same
problem.

Add pci_bridge_refresh_14bit_tag().  It re-reads the bridge's own
LNKSTA2.Flit_Mode, clears 14-Bit Tag Requester Enable in the bridge's
DEV3_CTL if Flit Mode is gone, refreshes bus->flit_mode and then walks the
subordinate bus and does the same for every device that advertises 14-Bit
Tag Requester support.  Fixing up the bridge only requires access to the
bridge's own config space on the primary bus, so it works even while the
link below is still unusable.  Hardware is touched only when the enable is
set and Flit Mode is no longer active, so the helper is idempotent and
does nothing on the common path.

Call it from the two choke points that together cover every
kernel-visible link mode change:

  - pci_bridge_wait_for_secondary_bus(), right after the link is known to
    be up and before pci_dev_wait() issues the first config read
    downstream.  This covers SBR via pci_bridge_secondary_bus_reset(),
    DPC release via dpc_reset_link(), AER bus reset via
    pci_bus_error_reset(), slot reset via pciehp_reset_slot() and
    D3cold->D0 resume via pci_pm_bridge_power_up_actions().

  - __pcie_update_link_speed(), where bus->flit_mode is authoritatively
    updated whenever the kernel observes a link change: initial
    enumeration, pcie_retrain_link() for an ASPM common clock
    configuration or a target speed change, the bwctrl IRQ for autonomous
    hardware speed changes and the pciehp link status check.  None of
    these go through pci_bridge_wait_for_secondary_bus().

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* No change

V2:
* New patch as a result of splitting the V1 monolithic patch

 drivers/pci/pci.c   | 131 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h   |   2 +
 drivers/pci/probe.c |  11 ++++
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c59329365ad6..09265173cf07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1754,12 +1754,22 @@ static void pci_restore_dev3_state(struct pci_dev *dev)
 	 * Only the value written to hardware is adjusted.  The save buffer
 	 * keeps what was saved, so the decision is taken afresh on every
 	 * restore and the originally programmed value is not lost.
+	 *
+	 * Note: bridge-side and link-event paths are handled separately by
+	 * pci_bridge_refresh_14bit_tag(), which runs from
+	 * pci_bridge_wait_for_secondary_bus() and __pcie_update_link_speed()
+	 * and clears the bit directly in hardware as soon as the link is
+	 * observed to leave flit mode.  This function's responsibility is
+	 * narrowed to the save-buffer-restore path.
 	 */
 	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
 	if (dev3_cap & PCI_DEV3_CAP_14BIT_TAG_REQ) {
 		/*
-		 * Check both LNKSTA2.Flit_Mode (link-level) and
-		 * DEV3_STA.Segment Captured (end-to-end); both must be
+		 * Re-check link state here too: pci_restore_state() may run
+		 * on paths where the link has changed mode but
+		 * pci_bridge_refresh_14bit_tag() has not yet been called for
+		 * this device.  Check both LNKSTA2.Flit_Mode (link-level)
+		 * and DEV3_STA.Segment Captured (end-to-end); both must be
 		 * active for 14-bit tags.  Refresh bus->flit_mode and
 		 * dev->fm_enabled in lock-step.
 		 */
@@ -1782,6 +1792,107 @@ static void pci_restore_dev3_state(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_DEV3_CTL, val);
 }
 
+/*
+ * Clear DEV3_CTL.14-Bit Tag Requester Enable on @dev if flit mode is no
+ * longer active.  Touches only @dev's own config space, so it is safe to
+ * call on a bridge before the first downstream TLP is issued after a
+ * reset.
+ *
+ * 14-Bit Tag Requester Enable is only meaningful in flit mode.  If the
+ * link came back as non-flit (e.g. after SBR, DPC, slot reset, or D3cold
+ * resume), a requester that still has it set will emit TLPs whose
+ * completions it cannot match, producing Completion Timeout plus
+ * Unexpected Completion on the first transaction.
+ */
+static void __pci_dev_clear_stale_14bit_tag(struct pci_dev *dev, bool flit_now)
+{
+	u32 dev3_cap, dev3_ctl, dev3_sta;
+	int pos;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DEV3);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
+	if (!(dev3_cap & PCI_DEV3_CAP_14BIT_TAG_REQ))
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
+	dev->fm_enabled = !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
+
+	if (flit_now && dev->fm_enabled)
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_DEV3_CTL, &dev3_ctl);
+	if (!(dev3_ctl & PCI_DEV3_CTL_14BIT_TAG_REQ_EN))
+		return;
+
+	dev3_ctl &= ~PCI_DEV3_CTL_14BIT_TAG_REQ_EN;
+	pci_write_config_dword(dev, pos + PCI_DEV3_CTL, dev3_ctl);
+	pci_info(dev, "cleared 14-Bit Tag Requester Enable: flit mode no longer active (DEV3_STA=%#010x)\n",
+		 dev3_sta);
+}
+
+/**
+ * pci_bridge_refresh_14bit_tag - Drop a stale 14-Bit Tag enable across a link
+ * @bridge: PCIe bridge whose link may have changed mode
+ *
+ * Re-evaluate the bridge's own DEV3_CTL.14-Bit Tag Requester Enable
+ * against the live LNKSTA2.Flit_Mode, then walk the bridge's subordinate
+ * bus and do the same for every device that advertises 14-Bit Tag
+ * Requester support.  Also refresh bus->flit_mode so the rest of the PCI
+ * core sees a consistent view of the link.
+ *
+ * Called from every kernel-visible link state change site:
+ *   - pci_bridge_wait_for_secondary_bus() (covers SBR, DPC release, slot
+ *     reset, AER bus reset, bridge D3cold->D0 resume).
+ *   - __pcie_update_link_speed() (covers manual retrain, bwctrl IRQ,
+ *     hotplug link status check, initial enumeration).
+ *
+ * Safe to call repeatedly; only writes hardware when the enable bit is
+ * set and flit mode is no longer active.
+ */
+void pci_bridge_refresh_14bit_tag(struct pci_dev *bridge)
+{
+	struct pci_bus *bus;
+	struct pci_dev *child;
+	u16 lnksta2 = 0;
+	bool flit_now;
+
+	if (!bridge || !pci_is_pcie(bridge))
+		return;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &lnksta2);
+	flit_now = !!(lnksta2 & PCI_EXP_LNKSTA2_FLIT);
+
+	/*
+	 * Fix the bridge itself first.  The bridge is the requester for
+	 * outbound config/MMIO TLPs, so a stale 14-Bit Tag Requester Enable
+	 * here is what produces the post-reset Completion Timeout /
+	 * Unexpected Completion failure.
+	 */
+	__pci_dev_clear_stale_14bit_tag(bridge, flit_now);
+
+	bus = bridge->subordinate;
+	if (!bus)
+		return;
+
+	bus->flit_mode = flit_now;
+
+	/*
+	 * Walk the secondary bus.  pci_restore_dev3_state() only fires on
+	 * paths that go through pci_dev_restore(); DPC release, hotplug
+	 * link status updates, and similar paths do not.  Fix those too.
+	 */
+	down_read(&pci_bus_sem);
+	list_for_each_entry(child, &bus->devices, bus_list)
+		__pci_dev_clear_stale_14bit_tag(child, flit_now);
+	up_read(&pci_bus_sem);
+}
+
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -4874,6 +4985,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 
+		/*
+		 * The link has had a chance to come back; refresh the
+		 * bridge's (and subtree's) DEV3_CTL.14-Bit Tag Requester
+		 * Enable against the live LNKSTA2.Flit_Mode before we issue
+		 * the first config TLP to the child.
+		 */
+		pci_bridge_refresh_14bit_tag(dev);
+
 		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
 			return 0;
 
@@ -4901,6 +5020,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return -ENOTTY;
 	}
 
+	/*
+	 * Link is up.  Refresh the bridge's (and subtree's)
+	 * DEV3_CTL.14-Bit Tag Requester Enable against the live
+	 * LNKSTA2.Flit_Mode before we issue the first config TLP to the
+	 * child below.
+	 */
+	pci_bridge_refresh_14bit_tag(dev);
+
 	return pci_dev_wait(child, reset_type,
 			    PCIE_RESET_READY_POLL_MS - delay);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9f55868adac8..0298e250e254 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -682,6 +682,8 @@ void __pcie_update_link_speed(struct pci_bus *bus,
 
 void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_reason reason);
 
+void pci_bridge_refresh_14bit_tag(struct pci_dev *bridge);
+
 /* Single Root I/O Virtualization */
 struct pci_sriov {
 	int		pos;		/* Capability position */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 810114029ee0..d13094baf487 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -838,6 +838,17 @@ void __pcie_update_link_speed(struct pci_bus *bus,
 			      reason,
 			      FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
 			      linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
+
+	/*
+	 * Re-evaluate DEV3_CTL.14-Bit Tag Requester Enable on this bridge
+	 * and its subordinate bus.  Any time bus->flit_mode is updated, the
+	 * link has just changed state; if flit mode is no longer active, the
+	 * bridge and downstream devices must drop that enable before
+	 * further TLPs are issued, or the requester (the bridge) will tag
+	 * config/MMIO requests with 14-bit tags that the completer can no
+	 * longer echo back in non-flit mode.
+	 */
+	pci_bridge_refresh_14bit_tag(bus->self);
 }
 
 void pcie_update_link_speed(struct pci_bus *bus,
-- 
2.43.0

