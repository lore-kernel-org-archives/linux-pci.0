Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11807448BB6;
	Tue, 11 Aug 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466887; cv=fail; b=g1k/7ICj6FKAdDYPM3BJ6WSSjho5LavW83wH8JeTFc/uVRRk+6lbfRKBwG45ZDHg5jHPRc8qrfb1ciQFaKp7vZ+c4lmVYfxD3T0ODKaGrCqAm6KxXWJZzz7fKc6jOaUpzyJ8S42ROLeMKUvgdcanM4qRRCS4DBBFjjIJfZpoor0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466887; c=relaxed/simple;
	bh=v27xTJ8imASkGUdRdUdRZAnC29n1jLA6mfYblCt6NF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md+IkiLrXUuMIsMvZ06tAqmS94V+5Mb+iM0WlpMncnbmn5y06iEp9xyJbHDZe5INyUzKQG+4JruAUesKFMPK6x5+q7CFixA56nDKXGYO0DdS/4VKlgNp7iHHRetI6CIg+Lg94SRKbXOAxGMoiUDnRBn1+fr6+Ibvd6Zjjv9cykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxwoI5SL; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxwoI5SL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoR1ll0zkDtAvUOm+H/WdtVoDXA49Y63s1RksTa3DALCKWsX57Q/MvNZjDccTDZg+ObAjnCQA8vHHF03Yc9KAYv5We68hhjaXWvzLbtSqU/Ze/YrUfWFb36Hoh/xFYEjQkn75SvJhQndO8E8lsi7lwmd4zPhcgXJeBv+UKucGMR0G1we5Wvvqp7rIo3mD6KVCPAqeTlGMyb3jCvzuQyZzbxjIEn1eYxhl/JnZoZA/GJX6B4yTEcn2Y0pl5amOonoMMsets8wFJvTENqqR3AM3LDC+dGWq5ygpRMU5UaHbda0lEdu1w96j3OcCamvz4Fdfk9YjQGnYRZnlZXVq1RTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e7r8eYatRAnQUFxFpBYvtbVTGgNacjWVhyvC8UlDWI=;
 b=UzdDEE+swQruXSdKZCtS+eEOLyGcd1D/6wH1WU28I1A/D0i24sIJ9E7icZ7HTzr5hT25f+fq8fwImSEVFPUcE8W6gGtmZNqDf+IW/UKAs/elNPcEikFe1SWbmjJJrxUipwy8gf8KnndJ00OTdq2ogPTWIW8fGqbMIYH2RTxnVDydTPVN4BS055Rc8nHT9OAwDZ6+ieXrRMkGMr3ieOY4whAnE3w1ikq5zjLh7yDX0FLId3v8RWswKgMZ7JZkYk5WRB5+CKK/ny8VVtJgg9Q7Fh7NWe1VGmLn7D8vzApSxxG6Kmpj4Foo0Zu2/E8VL1Ab/c0uYfF4oLFZwNaT9elloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e7r8eYatRAnQUFxFpBYvtbVTGgNacjWVhyvC8UlDWI=;
 b=kxwoI5SLDfilhIrLRYWMz20NQH/6LB9swASgZTNwTBaTiPYkf9s1RA1SfZeSTdEqih/PUB9Ep/Bo7hNPd44ZVsOAN6DJ8QMGX+fLc1IBDoM90PmsLLsC0WYBtr7mAQpE3iPUfROAYg8RNyimDyguOqfREqmvK4zJwf5Hn0w08gmnmngT8Ocjv2dI8JEOl2wOZ/6oMeCArly1D6aIJ2CkjmU4mxkMn6hpGMqn2ZXOAaRQ9VuBQWdx87tyOtoX/d26Zt+DTX0vo9VW66sKnQeclozjANXmrYMQelzV5WFeF7cu9VBnIOn+T25gksgXfJpbd6zl2UO1yXEdyFp579f20w==
Received: from CH2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:610:53::11)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 16:47:59 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::54) by CH2PR17CA0001.outlook.office365.com
 (2603:10b6:610:53::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 16:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 16:47:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Aug
 2026 09:47:28 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Aug 2026 09:47:24 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2 4/4] PCI: Clear stale 14-Bit Tag Requester Enable when a link leaves Flit Mode
Date: Tue, 11 Aug 2026 22:16:40 +0530
Message-ID: <20260811164640.587078-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512163012.2336191-1-vidyas@nvidia.com>
References: <20260512163012.2336191-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e763bf9-576e-4b84-4b99-08def7c84c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003|18092099006;
X-Microsoft-Antispam-Message-Info:
	4Q5/xjOEBPUyuy+HFxr0qm6g9ohZRFx8kYjUQhDlBQ46EVaEU/Xvw0nQ85b71z3HOD4PizNmufDq4DxNDL5FE4C1e9sQg2lwTrT/EIJqzgKiSw1o1kJ3i9JRQx1utaqj9b6E5sRrr498brj1LXOTZWPWgJl2GxAg8vsH08O6HsJqIZd83VL9Q4sCpw9FOzBF1t3HX63Rb5HTvc6Xysw/S6mWlQZeEARdnYZy5vhj561xG74LhMAXa2vbhORk7D2ra4AeS7Qxh5MbcgvXrtZ6FFfkRO76m73duwmwQCbDJQs3igWvq9HQfb774ojq0/rbkCht49keOtHr+GStGi94RP3K24VY7Pi4jQJuwSr1e0DBGOmWiXEmXRj7h3M2dygDGVEsfM98YyK0mbZi093ZSO0atEGjJn5WdKTXKYcvhFhNyYjuYWtsSGC5fFBQNRjwaYmtnzemNe1HO8lYu9VrvMmAoI1kC7+Q001oUtR1OIDkWqr7igeQrnuUnHG0I+CGwNIJ1n09kttf/vcR7Uoo3yv3NtpD70izNYQzdrEpf3JKtFbz3mjVFww/BQrtu+PHDlrGe3M4qIdqBjp+TvfHWJWQ6A0MaCu4avvLjzysdaFA/vNjsNKZ5vXiWAmvwrE2hQsIFC01Opx4XgkT46JXyf/9jdveyNmjgqGF3qXkAnlz6DEOtzDOyYgl/by4NStITbHudObuF2+Al2lXD7PrxA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003)(18092099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	49V3vVe66EHdQktoADRPzRbupuQTVcpAhuPzQLLm+9mUGR7SoCuKl6cD/IU0EMk9zmmenGINevKKQFEPCuZ+8C4QzXrEmJVPlntcFcnEpWoAtRBG0oandwNA/hXSv7uMLvn6hf41ewT3QE/yWnqQY0ZyjaZGzAasbYnt7fr+IXTY/lDI+roLqRLBiqVB4C4/0SXTL+G+CvLZq6EiyCIWNmcVaS7uWbaR2ujTsuqDfCtOz/URhYvGV7wnD5ZymGq2N1j57iy4hg1qCGa2rTP/bhZufxnClAxLyl6p0MjINmMN7H4qO2DNTFJzvcufZ/PJ/I/SLlqQic3ReZ+gezuKfcRWzxGTVXo9SyqZkU8VlaPbax0uO5ECJZpa50eVHWUY5daDyz4j2LLFGJxsGgt/2/a3dHORz2vDraZGzDCeSSja90OYk51d1dCvzvHMS522
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:47:57.6147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e763bf9-576e-4b84-4b99-08def7c84c3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667

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
V2:
* New patch as a result of splitting the V1 monolithic patch

 drivers/pci/pci.c   | 131 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h   |   2 +
 drivers/pci/probe.c |  11 ++++
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3bbeed1ba20c..b53ca5f47f07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1750,12 +1750,22 @@ static void pci_restore_dev3_state(struct pci_dev *dev)
 	 * coherent enable state.  Every other bit of DEV3_CTL (DMWr
 	 * Requester Enable, DMWr Egress Blocking, L0p Enable, Target Link
 	 * Width and any future addition) is written back unchanged.
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
@@ -1779,6 +1789,107 @@ static void pci_restore_dev3_state(struct pci_dev *dev)
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
@@ -4871,6 +4982,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
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
 
@@ -4898,6 +5017,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
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

