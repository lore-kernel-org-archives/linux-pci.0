Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB93CF940;
	Tue, 12 May 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603470; cv=fail; b=ZN87KnIg/kqJLqRavRRZfd2wm8VRcwo3Sl7CGYs+O3VztTw+RnahzP3G0nCVXRduR0gg+psWGrw09qAcZ/Nkw6ltNRd/z/Cqbf2dfxbWErtb7jNJ+/bxho5KuLtIx3X5UB2FtuEF3Pm4CuHwDUCxMIVXIH8MyCaTyzsJuqJxJMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603470; c=relaxed/simple;
	bh=JIysg0PlO+UdBGxFmX4V3Oiqgc6bsUaROuNcK0F5VIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tbpja6BpZr+VUAkgwyO/bRHej/Rl9Ov97b4urbnay8ZJUdanztOq2wUFirEH5I7tJMbosjFL0lYXRc9ZW9A8Q86abIX1kwEa7dkkPH8kopz+YDKLGqe/hVLDppQZLA3UVbQPcwKAf/JBjsGVDOjKZU60lKt2A8nUyEmTZO1gr0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bl+SYa1H; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bl+SYa1H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr5n8FS4ooTNqVfGwasHwM6y0SHjhrvI3HjupcaE7Ogs+NqovwBJFB9CFbRjF3saoRxBPeMv689dtCfzjgaACL4lwu8CiuzsTa23oewQvOB2cp7uqnuIZxrY8Q5YnBF9MSfWXxBl4XmiaEJTr2Uji73NnXYPKxeVzufKq9xDT+odIwDonqDEMvQEm9MvRylOxa56QL14pPEAo2Rnya+mnquKnlT3QqVsiaNJ0WguN28giJtdgPxO7cUni0Gemc356sj+nLsmA3yI2WA7HXg6XI4HzMBgzlNE+8o0ZGSGqqgZMMDbQxQwrDX43Dcw2H0x6gL8QUtquvsrJbKDeGZY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLu7dpHaRJU2pATb+/e+KsDmXm23I3snVN5laseNgcA=;
 b=YpwTaeSIsmYP4bHo5fXQ0TGBdKNj0rfkfv8vRsdvDjETOS1JlhCMT3lNzSjqaiL6Ybz9hR5zT+FR9Pr2ZcY9VQ+ZmGQYc43RLvgZJnUWIbpJSmDXGnJPERYGbbbqG4vdnarnrPuWqRe7ey6ySxp2xDpmLudtwapKuo7swqiMbBS/ayxejwb/geNe7UzBk2nmdScQHTl1ZngM+onds2qLYUmxD9FJ8Nsk3rqlqO5ubQdIiNzkUsxpt1MuMRDw1hw7UDCCYDFkh3z4RR6q+gQ9vzydrFFgJnRh3fBhu8hFdpLnRyP4Dje/qHCiv8nGMq9vSBCaEThPlg7UoJ0gCAgjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLu7dpHaRJU2pATb+/e+KsDmXm23I3snVN5laseNgcA=;
 b=Bl+SYa1H1Xm4XM7qEQsvLzNy4rAj7VLew0uPYi4+nnJENTiaTfFRhPvxfDCcJAjsdJjPP5NfnZvCJEhYD+w/OkHO3p6Qd8yJtbmhq47Vfcz75MA9SxTDIqoeOHenzHcAxn0bsI6e/K4HAIIglOqdpEu+3NTPn65Ll9bf2pqV9QqMGZy1bJXI2fuS4xEUexHbVKQXq7W74NGb9TXYzRq28yXIc2H9fFaQD4wQ8T8f+TOX7acDXuosqUvhRolEbFFqB3Efjd8cKD9wvBg6wv8Jg0Oc6SV6AU9w8Qy++J1oOVWiM4yW4mmPYLE+dtP8H9XU7BppVVb+49wO5ZllROLuoQ==
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:31:01 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::61) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 16:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 16:31:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 09:30:35 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 12 May 2026 09:30:32 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH] PCI: Save/restore Device 3 control and clear stale 14-bit Tag enables
Date: Tue, 12 May 2026 22:00:12 +0530
Message-ID: <20260512163012.2336191-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c76336-2468-4fb9-142a-08deb043daa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18092099006|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	IcTFfCFwxJ7y0kP4t0dVA2o37aDZa1QUom7nuieu/VVSdCqEPpSTlIVPM/zAyTjFSNVmFlFLRGwG2R6BHbsf61r4jDbVWVWCo14++VcyF4MjYKXYp1OSg5ztnAYGTr2rxEL7vcyBEvoEll+syAbt8Uz17vJB0wtpVRsVG4hXTlY2Oh2CCV6QmaE9vSRkn7HJSIDywQ2jPCdR10ITzHkWQqyX0QP0pO7FkbflMHin0jNYi34BHfhWu+bok023LVhbyem8Uq5WH5jWV+fCMKzUzxz2i0yMgDf0LpvDgkRwTqwqBLkgVBs1pRACjBaQbZLKoY0fRlk2ObhzLnZ8JmzOjtzrQY+0Y3NIU1e3FLe0hUGj1mfSc5VCZeEGKfUYwMFr7UIEO77PdbwJDCToDc1gdG2n0MVfdqnmMkiuC7ah8hv2zGqQCOJIQnt/lSA8pidrahbKFZIYf5FPR5zATby9bNdUwsGdMOtYfgKjtWTIc4ndausa7hc6BYKfdqrXS5EBlDeLFI3cEkBsrhIzdnyd699qMJSY49Kwi+dyX0xQWN4nsQLtW6lsOraOG0yuf8LAr/uLXYDvUO4sD2MJI3e5dvtLi/hLKssD5bsJN3U7XOI2c1iUw0VrKn2d4t+cymjjM5GfXZUeXmEleNH20pzBI73aa+qPJcoHRswz7tmcLLxomeg2jREneH86Q6etrBEkptw2rIyyAZQs8cNYgpBVX6z2rVMBqpLpJSzeeXd4mdA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18092099006)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3YUDhXC4Y3Vk5CGuOEBWkropcwuICZb7m87ZQwRNle594UZvg59Z/+V37I5iqwBUnERxTb9swcRoQ22mASwlQXAjP6p3SVr8u67DnHCcq77d5vuErXdtT3N671Aa4IYUC7GKUhKjGEsWClcRYPYjLBGKFAnt3HlufkCQLHa/rgaQ+ZSM2Lg44tOShaQXT1+QI+q4JIQdPz3UkLAEC3121GmeIhP/44rDh3LTHp2ZUWQrPK6se4vckx0/IMhLPdinICgjYJ1QxhfxydtwUm+hsKTQxSbut78XSCn3ptapwvjIgH276Z7dFSYLtJm8ztRppA78egRszoavY3VD3tGJWre9o1uZjifwIfuIb6pxMZ1sJkcWVaj9BTPA299DilF55AyhiE9q/VVD0nBl7kcjZYa8CxjWWpNKCeRqpWJierizV7NhCKPBBYYRjQfzQkhJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:31:00.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c76336-2468-4fb9-142a-08deb043daa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555

The Device 3 Extended Capability (DEV3_CTL) lets software enable a
device's 14-Bit Tag Requester and 14-Bit Tag Completer behavior.
Those enable bits, however, are only meaningful while the link
operates in flit mode; in non-flit mode the upper 4 tag bits are not
transmitted on the wire, so a requester that still has them enabled
emits TLPs whose completions the requester can no longer match. The
visible symptom on the first downstream TLP after such a reset is
Completion Timeout plus Unexpected Completion on the root/switch
port.

The PCI core currently does not save/restore DEV3_CTL, and nothing
re-evaluates the 14-Bit Tag enable bits when the link mode changes.
Across a Secondary Bus Reset, DPC trigger/release, slot reset, AER
bus reset, FLR, or D3cold->D0 bridge resume the link can come back
in non-flit mode while DEV3_CTL still advertises 14-bit tagging,
which breaks the very first config read the kernel issues to the
endpoint.

Address this with two complementary pieces of work in one patch:

1. Save and restore DEV3_CTL across pci_save_state() /
   pci_restore_state().  Allocate the save buffer in pci_dev3_init()
   for every PCIe device that exposes the Device 3 Extended
   Capability, save DEV3_CTL only (DEV3_STA is RW1C and not
   restored), and on restore sanitize the saved value: if the device
   advertises 14-Bit Tag support but flit mode is no longer active
   (checked via the live LNKSTA2.Flit_Mode and DEV3_STA.Segment
   Captured), drop PCI_DEV3_CTL_14BIT_TAG_REQ_EN and
   PCI_DEV3_CTL_14BIT_TAG_COMP_EN before writing DEV3_CTL back.

   This covers every path that goes through pci_dev_restore(),
   including the endpoint side of SBR/slot reset/D3cold resume.

2. Add pci_bridge_refresh_14bit_tag() and call it from the two
   universal choke points where the link mode can change but
   pci_dev_restore() does not necessarily run on the bridge itself:

     - pci_bridge_wait_for_secondary_bus() runs after every family
       of bridge-mediated reset (SBR via pci_bridge_secondary_bus_
       reset(), DPC release via dpc_reset_link(), AER bus reset via
       pci_bus_error_reset(), slot reset via pciehp_reset_slot(),
       and D3cold->D0 resume via pci_pm_bridge_power_up_actions()).
       The helper is called there immediately after the link is
       known active but before pci_dev_wait() issues the first
       downstream config read, so the requester is fixed up before
       any TLP is sent.

     - __pcie_update_link_speed() is where bus->flit_mode is
       authoritatively updated whenever the kernel observes a link
       change: initial enumeration, manual pcie_retrain_link()
       (ASPM common-clock, target-speed change), bwctrl IRQ from
       autonomous HW speed changes, and the pciehp link-status
       poll.  Calling the helper there covers retrain paths that
       never go through pci_bridge_wait_for_secondary_bus().

   The helper re-reads the bridge's own LNKSTA2.Flit_Mode, fixes the
   bridge's DEV3_CTL first (because the bridge is the requester for
   outbound config/MMIO TLPs and is what produces the post-reset
   error storm), refreshes bus->flit_mode, then walks the
   subordinate bus to fix every device that advertises 14-Bit Tag
   support.  All bridge accesses are to the bridge's own config
   space on the primary bus, so the fix runs safely before any
   potentially-broken downstream TLP.  Operation is idempotent:
   hardware is touched only when the enable bits are set and flit
   is no longer active.

   To call the helper from __pcie_update_link_speed(), move that
   function's body from a static inline in drivers/pci/pci.h to an
   ordinary out-of-line definition in drivers/pci/probe.c (pure
   refactor, no functional change for existing callers).

Also add the missing DEV3 14-Bit Tag bit names to
include/uapi/linux/pci_regs.h:
PCI_DEV3_CAP_14BIT_TAG_{COMP,REQ} and
PCI_DEV3_CTL_14BIT_TAG_{COMP,REQ}_EN.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c             | 213 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  17 +--
 drivers/pci/probe.c           |  32 +++++
 include/uapi/linux/pci_regs.h |   4 +
 4 files changed, 254 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0be4e263bca0..ad1a282a4e63 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1682,6 +1682,199 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
 }
 
+static int pci_save_dev3_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DEV3);
+	if (!pos)
+		return 0;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DEV3);
+	if (!save_state)
+		return -ENOMEM;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	pci_read_config_dword(dev, pos + PCI_DEV3_CTL, &cap[0]);
+
+	return 0;
+}
+
+static void pci_restore_dev3_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap, val, dev3_cap, dev3_sta;
+	u16 lnksta2 = 0;
+	bool flit_now;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DEV3);
+	if (!pos)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DEV3);
+	if (!save_state)
+		return;
+
+	cap = (u32 *)&save_state->cap.data[0];
+	val = cap[0];
+
+	/*
+	 * The 14-Bit Tag enable bits in DEV3_CTL are only valid in flit
+	 * mode.  On devices that advertise 14-Bit Tag support, sanitize
+	 * the saved value before writing it back, so that callers that
+	 * issue further TLPs through this device after restore see a
+	 * coherent enable state.  On other devices (and for any other
+	 * DEV3_CTL bits, including future architected or vendor-specific
+	 * ones), the saved value is written back unchanged.
+	 *
+	 * Note: bridge-side and link-event paths are handled separately by
+	 * pci_bridge_refresh_14bit_tag(), which runs from
+	 * pci_bridge_wait_for_secondary_bus() and __pcie_update_link_speed()
+	 * and clears the bits directly in hardware as soon as the link is
+	 * observed to leave flit mode.  This function's responsibility is
+	 * narrowed to the save-buffer-restore path.
+	 */
+	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
+	if (dev3_cap & (PCI_DEV3_CAP_14BIT_TAG_REQ |
+			PCI_DEV3_CAP_14BIT_TAG_COMP)) {
+		/*
+		 * Re-check link state here too: pci_restore_state() may run
+		 * on paths where the link has changed mode but
+		 * pci_bridge_refresh_14bit_tag() has not yet been called for
+		 * this device.  Check both LNKSTA2.Flit_Mode (link-level)
+		 * and DEV3_STA.Segment Captured (end-to-end); both must be
+		 * active for 14-bit tags.  Refresh bus->flit_mode and
+		 * dev->fm_enabled in lock-step.
+		 */
+		pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
+		dev->fm_enabled = !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
+
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA2, &lnksta2);
+		flit_now = !!(lnksta2 & PCI_EXP_LNKSTA2_FLIT);
+		if (dev->bus)
+			dev->bus->flit_mode = flit_now;
+
+		if ((!dev->fm_enabled || !flit_now) &&
+		    (val & (PCI_DEV3_CTL_14BIT_TAG_REQ_EN |
+			    PCI_DEV3_CTL_14BIT_TAG_COMP_EN))) {
+			val &= ~(PCI_DEV3_CTL_14BIT_TAG_REQ_EN |
+				 PCI_DEV3_CTL_14BIT_TAG_COMP_EN);
+			cap[0] = val;
+			pci_info(dev, "clearing 14-bit tag enable: flit mode no longer active (LNKSTA2=%#06x, DEV3_STA=%#010x)\n",
+				 lnksta2, dev3_sta);
+		}
+	}
+
+	pci_write_config_dword(dev, pos + PCI_DEV3_CTL, val);
+}
+
+/*
+ * Clear DEV3_CTL.14-Bit Tag {Req,Comp} Enable on @dev if flit mode is
+ * no longer active.  Touches only @dev's own config space, so it is safe
+ * to call on a bridge before the first downstream TLP is issued after a
+ * reset.
+ *
+ * 14-Bit Tag enables are only meaningful in flit mode.  If the link came
+ * back as non-flit (e.g. after SBR, DPC, slot reset, or D3cold resume),
+ * a requester that still has these bits set will emit TLPs the completer
+ * cannot match, producing Completion Timeout plus Unexpected Completion
+ * on the first transaction.
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
+	if (!(dev3_cap & (PCI_DEV3_CAP_14BIT_TAG_REQ |
+			  PCI_DEV3_CAP_14BIT_TAG_COMP)))
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
+	dev->fm_enabled = !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
+
+	if (flit_now && dev->fm_enabled)
+		return;
+
+	pci_read_config_dword(dev, pos + PCI_DEV3_CTL, &dev3_ctl);
+	if (!(dev3_ctl & (PCI_DEV3_CTL_14BIT_TAG_REQ_EN |
+			  PCI_DEV3_CTL_14BIT_TAG_COMP_EN)))
+		return;
+
+	dev3_ctl &= ~(PCI_DEV3_CTL_14BIT_TAG_REQ_EN |
+		      PCI_DEV3_CTL_14BIT_TAG_COMP_EN);
+	pci_write_config_dword(dev, pos + PCI_DEV3_CTL, dev3_ctl);
+	pci_info(dev, "cleared 14-bit Tag enable: flit mode no longer active (DEV3_STA=%#010x)\n",
+		 dev3_sta);
+}
+
+/**
+ * pci_bridge_refresh_14bit_tag - Drop stale 14-Bit Tag enables across a link
+ * @bridge: PCIe bridge whose link may have changed mode
+ *
+ * Re-evaluate the bridge's own DEV3_CTL 14-Bit Tag enables against the
+ * live LNKSTA2.Flit_Mode, then walk the bridge's subordinate bus and do
+ * the same for every device that advertises 14-Bit Tag support.  Also
+ * refresh bus->flit_mode so the rest of the PCI core sees a consistent
+ * view of the link.
+ *
+ * Called from every kernel-visible link state change site:
+ *   - pci_bridge_wait_for_secondary_bus() (covers SBR, DPC release, slot
+ *     reset, AER bus reset, bridge D3cold->D0 resume).
+ *   - __pcie_update_link_speed() (covers manual retrain, bwctrl IRQ,
+ *     hotplug link status check, initial enumeration).
+ *
+ * Safe to call repeatedly; only writes hardware when the enable bits are
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
+	 * outbound config/MMIO TLPs, so stale 14-bit Tag enables here are
+	 * what produce the post-reset Completion Timeout / Unexpected
+	 * Completion failure.
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
@@ -1738,6 +1931,10 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	i = pci_save_dev3_state(dev);
+	if (i != 0)
+		return i;
+
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
 		return i;
@@ -1815,6 +2012,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 void pci_restore_state(struct pci_dev *dev)
 {
 	pci_restore_pcie_state(dev);
+	pci_restore_dev3_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
 	pci_restore_ats_state(dev);
@@ -4745,6 +4943,14 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
 
+		/*
+		 * The link has had a chance to come back; refresh the
+		 * bridge's (and subtree's) DEV3_CTL 14-Bit Tag enables
+		 * against the live LNKSTA2.Flit_Mode before we issue the
+		 * first config TLP to the child.
+		 */
+		pci_bridge_refresh_14bit_tag(dev);
+
 		if (!pci_dev_wait(child, reset_type, PCI_RESET_WAIT - delay))
 			return 0;
 
@@ -4772,6 +4978,13 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return -ENOTTY;
 	}
 
+	/*
+	 * Link is up.  Refresh the bridge's (and subtree's) DEV3_CTL
+	 * 14-Bit Tag enables against the live LNKSTA2.Flit_Mode before
+	 * we issue the first config TLP to the child below.
+	 */
+	pci_bridge_refresh_14bit_tag(dev);
+
 	return pci_dev_wait(child, reset_type,
 			    PCIE_RESET_READY_POLL_MS - delay);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 19660d068fb7..a47a0f3ad2e2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -633,21 +633,14 @@ enum pcie_link_change_reason {
 	PCIE_HOTPLUG,
 };
 
-static inline void __pcie_update_link_speed(struct pci_bus *bus,
-					    enum pcie_link_change_reason reason,
-					    u16 linksta, u16 linksta2)
-{
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
-	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
-
-	trace_pcie_link_event(bus,
-			     reason,
-			     FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
-			     linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
-}
+void __pcie_update_link_speed(struct pci_bus *bus,
+			      enum pcie_link_change_reason reason,
+			      u16 linksta, u16 linksta2);
 
 void pcie_update_link_speed(struct pci_bus *bus, enum pcie_link_change_reason reason);
 
+void pci_bridge_refresh_14bit_tag(struct pci_dev *bridge);
+
 /* Single Root I/O Virtualization */
 struct pci_sriov {
 	int		pos;		/* Capability position */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 748c7a198262..27eb97b22c36 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -826,6 +826,30 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
+void __pcie_update_link_speed(struct pci_bus *bus,
+			      enum pcie_link_change_reason reason,
+			      u16 linksta, u16 linksta2)
+{
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
+
+	trace_pcie_link_event(bus,
+			      reason,
+			      FIELD_GET(PCI_EXP_LNKSTA_NLW, linksta),
+			      linksta & PCI_EXP_LNKSTA_LINK_STATUS_MASK);
+
+	/*
+	 * Re-evaluate DEV3_CTL 14-Bit Tag enables on this bridge and its
+	 * subordinate bus.  Any time bus->flit_mode is updated, the link
+	 * has just changed state; if flit mode is no longer active, the
+	 * bridge and downstream devices must drop their 14-Bit Tag enables
+	 * before further TLPs are issued, or the requester (the bridge)
+	 * will tag config/MMIO requests with 14-bit tags that the
+	 * completer can no longer echo back in non-flit mode.
+	 */
+	pci_bridge_refresh_14bit_tag(bus->self);
+}
+
 void pcie_update_link_speed(struct pci_bus *bus,
 			    enum pcie_link_change_reason reason)
 {
@@ -2320,11 +2344,19 @@ static void pci_dev3_init(struct pci_dev *pdev)
 {
 	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
 	u32 val = 0;
+	int err;
 
 	if (!cap)
 		return;
 	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
 	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
+
+	/* Save buffer for DEV3_CTL only; DEV3_STA is RW1C and is not restored. */
+	err = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DEV3,
+					  sizeof(u32));
+	if (err)
+		pci_warn(pdev,
+			 "unable to preallocate Device 3 save buffer\n");
 }
 
 /**
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..6e00dbdf04eb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1254,7 +1254,11 @@
 
 /* Device 3 Extended Capability */
 #define PCI_DEV3_CAP		0x04	/* Device 3 Capabilities Register */
+#define  PCI_DEV3_CAP_14BIT_TAG_COMP	0x00000004 /* 14-Bit Tag Completer Supported */
+#define  PCI_DEV3_CAP_14BIT_TAG_REQ	0x00000008 /* 14-Bit Tag Requester Supported */
 #define PCI_DEV3_CTL		0x08	/* Device 3 Control Register */
+#define  PCI_DEV3_CTL_14BIT_TAG_COMP_EN	0x00000002 /* 14-Bit Tag Completer Enable */
+#define  PCI_DEV3_CTL_14BIT_TAG_REQ_EN	0x00000004 /* 14-Bit Tag Requester Enable */
 #define PCI_DEV3_STA		0x0c	/* Device 3 Status Register */
 #define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-mode detected) */
 
-- 
2.25.1

