Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC43D5640;
	Fri, 14 Aug 2026 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738654; cv=fail; b=Gd3JWjl5PSRCyU8NoV4L5D4U3y+FLEzIf0cGjwXUwLXKLIjZEVwyuwlT+85cJBwUIRp5jJmhD/UK4DCPc6hcLDM2mMQb+T/W4gmRGWsk1T4UIT6xtu30J3tsyg8OCqh91eTkUIBA50Joq8QwV/+W6lTCo/RLkXP4j4rr1bFP3s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738654; c=relaxed/simple;
	bh=DCyaVX19hGU7Gg5WcRhVuOt0zpyojM3BPgH/rUvRYlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc5ih4WTNSzrH0MKqxI+vk1uWR23ra2rAEDKcvTNUnEVQTC4lR4HQLgEj4q6sTtaJK3KZP4f3vJngdyVU2jXj02m//S19ef9X1QyvZnPnqkcabK0f7aCZG8GnuF5dwbpE2Euo92ZIknIzmTmOlPjkCeOaZWRJg8xazze6vVId0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cpMDqL9y; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cpMDqL9y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+leu9z9e4imEg4kQQ9xwbSfdDKqb2C0FsUWkWRdxFAwZeqEqxq6xddT+/LB2KvUi9jxs/kI4YhaHGclwC1tpNbWUFhVQNGyAib3O9iFwk8FxDAkKkGWaXhMwTap16ECLjHPWbWf3BsVkOiXEuBtNBc3cXGs/xZaLmGBnjNweJNYGh3OtigxLrEqE/xaILmDgfJ097hv3qhqtuHNS5vs3EjodvudZX5fS3rT7iJSsMGarlbuUThysb/SJJu4CQs8yqvuhkbr57Daya3u0chhMgTOvHx6GTMlWMaYnXW86wlbIbzPsTYUGc7sktxQVDwCH+nJWYsRHcdHDTbJlGsvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAFnVINPARAKNSGRfJxEPCo8+PQfpmRgZRiACg/8Wdw=;
 b=BVYwyspA88eiM1rfU7nMGg/0uatKdPXtANgDy4H+ml6JXJjsWF2M0f41CUs/IKczm6weLvnGEsav6TLaEZ5S/mjWmG3+JoD9h/pSlf1uKaeSeReUr90wXpXyhgiTdrb2dNzvPx1lfRNG7E3ML53bOOhep2QLcJTaWr4J9mijQxmCLaTRS8hrxUQI/A/0NJPktYMaGOt8f76RiKHbvuW672kNNMIRJQ25pmsZU1AoqgtXtWcDEBQuAyMrRlNk9YNCePGG3VHrEOR/WecbW613qSaUMV/LCSRH6ac0OCEMCS+cza9TrWmSNZGGbh4R0NWAnorSuOor36p/kS/kSxAMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAFnVINPARAKNSGRfJxEPCo8+PQfpmRgZRiACg/8Wdw=;
 b=cpMDqL9y8QS0yGOWYyG9AN4YGfNc8nfVYfCJXIUWAXVPF5Td1LW6VTniOxCih3rJux2WNUBIsRo9zmrq4ZsPwX2TNghkGyNrXreCS5IDKN9n8hMtATslvxPn2CGgAKTXfOhARll0jQOBCUguCI6om4OcUpQgIzcaX0gMVfbIs781M8hgfO7RhYPMXdoLOkWHCIHnARCPWqm8DZMRkp/TmuaYNAChsmig1tGn3hphP/2rUTuFpDWo4mqYi+GTOR/Sb3ufx3bpeuC9d0GmJeMCLPz9g0NpXlL/sPuiJswQAIZfevS6Un+G//akjHvCo1hvT689StaJiXhtnpcjPx1/hw==
Received: from DS7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::11) by
 DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Fri, 14 Aug 2026 20:17:24 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::19) by DS7P221CA0040.outlook.office365.com
 (2603:10b6:8:25e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 20:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 20:17:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 14 Aug
 2026 13:17:01 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 14 Aug 2026 13:16:57 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V3 3/5] PCI: Save and restore the Device 3 Control register
Date: Sat, 15 Aug 2026 01:46:19 +0530
Message-ID: <20260814201621.2281245-4-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9301e7-efc7-41e0-533b-08defa410d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|18002099003|11063799006|5023799004|22082099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Rj7xOPiJhxOuAvX84UY80EF0C4uCDWP4w5AWoQNu3Iwb1P6POY3b2AoXpzX+bExd3LrjluNBMiYkzFKlSkbdSiPaI1p0L4OQm3Zq6oFs5N5ovu5SvqUsalvwH6xvgizZcPSNmKvsJQdGBzN/3gZuz1+W9eo0w/NggUQfkWg9f+qiMg/2jHcq0G7scr2BKdyfWNOeGSAlHZcr17Ecu9y2p9p94SmqzC8pSnBm+b6+MDAGvrqVSSEVbVkoCcS84XeK+SmVKBSzkdJyOf9SrjYKHf3w1GlX+GG/DuyCA41VBEdr3VH3/s+vn1FNpHQqc3TLgeheE4JBi5HxCz8xE/DcbIXzuVzbVaztwy485K309FxdOZsD2xF+DO2LXlRG2C4dsYr0h44xC7NBV/ZpbzYp4Mw5htj9LQALavpBJ58Lkak+CoQy3HWg8679LSzZs5cH+MLjUSziCgR5wO+kDNXBImBL/3dozRlCIRoIIBe4xXtLvzmNG3+SeZ/Kf+zH7lq65faAr870CNWPH0+TTqN/ejBDsLIyLJYa/0YarCiZqGJnUI76K8dW1aBn1SsEJPhvHm2RBV22HabAVRrGB+xjjnnwO0Wp2N2ytiesoq6nNrtbwTOo+UqmeJjO7WXneBJ4dAdau9SJ6tI/A0wzHJkyg64hZFnxBAcnkRMN4ijYBrGaeupc1bBBGOGFrh3LrFVM6JDUNP25y729r291/bv4dg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(11063799006)(5023799004)(22082099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XldN1D00aAP3Z3DduueuqFTB16zvfB7GK33+2JvRGCRSi2o7NbvzWOrCgKoCqLfVsx+H1PtUYSt7qH3tg/miIwHecewe8ukd5zVj0IWI95ddVBAPnT8nOnZtpe3iOGUP1XPm8x0KjtNmGAM4C+AEVcahsRaXoBxfC5ykPIkDdxUIWkq59ydNOIM12yVBCpmw4M1LLew81am5gZZWv1ob/wo++Ujm5BurfkePLdtwZoX9NlMlmi7TEfYaYgHG2dMzvYji/5GDPXV46fkT9nTl4V1YitwR+M/bBhYwzxdWSWJ0+qWwnJaV5xzFdly0fpw+USV4ZY5a+ZRGXcLvQWcN1mvXfjIuBKUeP1T5clc+PB2XiqGhHWThagRYyjHLiDNgsapS838NJSdhlKXGOw+ax5dIQweRdJlT7oX+aRIW3MyUSPIhvkAmEU+oNBy4ZKO7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:17:23.9511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9301e7-efc7-41e0-533b-08defa410d9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

The Device 3 Extended Capability carries the 14-Bit Tag Requester Enable
bit, which platform firmware may have programmed before the PCI core takes
over.  The core neither saves nor restores DEV3_CTL, so its contents are
lost on every path that goes through pci_save_state() and
pci_restore_state(), e.g. a Secondary Bus Reset, a slot reset or a D3cold
resume.

Restoring the saved value verbatim is not correct either.  14-Bit Tag
Requester Enable is only meaningful while the link operates in Flit Mode;
in Non-Flit Mode the upper tag bits are not transmitted on the wire, so a
requester that still has it set emits TLPs whose completions it can no
longer match.  That shows up as a Completion Timeout together with an
Unexpected Completion on the very first transaction after the reset.  A
link that comes back in Non-Flit Mode must therefore come back with
14-Bit Tag Requester Enable cleared.  The completer side needs no such
handling: a completer reflects the Tag field of the request it answers, so
the spec defines no completer enable to fix up.

Allocate a save buffer in pci_dev3_init() for every device that exposes
the Device 3 Extended Capability and save DEV3_CTL from pci_save_state().
DEV3_STA needs no save buffer of its own because all of its fields
(Initial Link Width, Segment Captured and Remote L0p Supported) are
read-only status reported by hardware.

On restore, sanitize the saved value first: if the device advertises
14-Bit Tag Requester support but Flit Mode is no longer active, as
determined from the live LNKSTA2.Flit_Mode and DEV3_STA.Segment Captured,
drop PCI_DEV3_CTL_14BIT_TAG_REQ_EN before writing DEV3_CTL back and
refresh dev->fm_enabled and bus->flit_mode to match what the hardware now
reports.  Devices without 14-Bit Tag Requester support, and every other
DEV3_CTL bit, are restored unchanged.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Modified to preserve the original DEV3_CTL value

V2:
* New patch as a result of splitting the V1 monolithic patch

 drivers/pci/pci.c   | 84 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c | 12 +++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff6d5d059b21..c59329365ad6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1703,6 +1703,85 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
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
+	 * DEV3_CTL.14-Bit Tag Requester Enable is only meaningful in flit
+	 * mode.  On devices that advertise 14-Bit Tag Requester support,
+	 * sanitize the saved value before writing it back, so that callers
+	 * that issue further TLPs through this device after restore see a
+	 * coherent enable state.  Every other bit of DEV3_CTL (DMWr
+	 * Requester Enable, DMWr Egress Blocking, L0p Enable, Target Link
+	 * Width and any future addition) is written back unchanged.
+	 *
+	 * Only the value written to hardware is adjusted.  The save buffer
+	 * keeps what was saved, so the decision is taken afresh on every
+	 * restore and the originally programmed value is not lost.
+	 */
+	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
+	if (dev3_cap & PCI_DEV3_CAP_14BIT_TAG_REQ) {
+		/*
+		 * Check both LNKSTA2.Flit_Mode (link-level) and
+		 * DEV3_STA.Segment Captured (end-to-end); both must be
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
+		    (val & PCI_DEV3_CTL_14BIT_TAG_REQ_EN)) {
+			val &= ~PCI_DEV3_CTL_14BIT_TAG_REQ_EN;
+			pci_info(dev, "clearing 14-Bit Tag Requester Enable: flit mode no longer active (LNKSTA2=%#06x, DEV3_STA=%#010x)\n",
+				 lnksta2, dev3_sta);
+		}
+	}
+
+	pci_write_config_dword(dev, pos + PCI_DEV3_CTL, val);
+}
+
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -1759,6 +1838,10 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	i = pci_save_dev3_state(dev);
+	if (i != 0)
+		return i;
+
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
 		return i;
@@ -1826,6 +1909,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 void pci_restore_state(struct pci_dev *dev)
 {
 	pci_restore_pcie_state(dev);
+	pci_restore_dev3_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
 	pci_restore_ats_state(dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 60dd1efe9abb..810114029ee0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2334,11 +2334,23 @@ static void pci_dev3_init(struct pci_dev *pdev)
 {
 	u16 cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
 	u32 val = 0;
+	int err;
 
 	if (!cap)
 		return;
 	pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
 	pdev->fm_enabled = !!(val & PCI_DEV3_STA_SEGMENT);
+
+	/*
+	 * Save buffer for DEV3_CTL only.  Every field in DEV3_STA is
+	 * read-only status reported by hardware, so there is nothing there
+	 * to restore.
+	 */
+	err = pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DEV3,
+					  sizeof(u32));
+	if (err)
+		pci_warn(pdev,
+			 "unable to preallocate Device 3 save buffer\n");
 }
 
 /**
-- 
2.43.0

