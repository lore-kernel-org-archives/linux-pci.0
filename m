Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969653FF886;
	Tue, 11 Aug 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466873; cv=fail; b=A0eRbyme6ycxW2X+FClg1RhxjhwmerHsE2ZIwnmhhHzwjswKgX1X3YnEsNfW3UGZOpvgM/RV5v5gw6FzkA6MwNZfiEq9AZMG0AOh9LCepn4y8fweIi4TPHtmMQpkGl72Jox87Y6zCKhO7ZBqRcUFI9YY5yAqiWaDC9bMjPceOBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466873; c=relaxed/simple;
	bh=iXlf9lgff9e/T64/d88HCqsv6eTIzI+9pS1jZDkVBo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKz99B8ZZ8nFVbhEmiI+T+Dli2LUc+2CCkJvVAXLwoDanNpfIWqhz3LYWLr1vqoyP3r14gb6t/bJM+d+NNW+d0yYMVk9EnkMST7gxam/0IY7OkfR0cOqBHvQLrOkClh6m5owmMTHdlRGA6s9foIqz4OeUwVYn6T8Qs1khQMPJZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUosRh4e; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUosRh4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDIni3PrJCEjsOGYHbtEv39YWjCJLRF9b5IkADwWZBMIb15PBQkLTiaAnekJg8VJL4v8q5QlZzzx3pIuyoywhXudsJ7OtgP4AlnePKgvhhW6FTPcKpEjUWcJBq38PhAVKQP25Ojm0Ylk6Ipj/gFKwhYQxTCikfUS+QrIT1jqv8/x95tSGZVnmSMoic1S3cotwgkwIQyUEE8ZtCRoouPwm2zdeIyTKSVPxWepBnHkDwS/ZrPs688DUopIez7ktv3mMjJV+SuYv2FblEWN4eRgFtvlZHD+CsTiMweCQ1xpNuGct0mXbkHtdUARj2bYZmHVA8yxQjAb+ANzGSrPLkwVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tKyGIshVqK0IVkW7hJr/PdFepM80RKvciuVDLWvZ/Y=;
 b=w1HRz+aAO4Wy3KKtjJ/Dw/wMLze+c/Pryj3AntxvZx4ZnyyaY5Kun7iAsvYpt5A4OhjYzfBXJCV1xGOC6GTBwj+P1bvyMIOgYDzcpMPMCY2/1oy/qV8OZWaOX+huzxxlltSzi6w/twP0hBF2xYWLD3L4TL7lm/1GTHI6PeH7o9UWRg3NxXHWkeqn+46u4/XBu74RrF4KGe7SEGO97/p1Lwy1G6+N4G7eLwKes+3gsfj0Dw/V21AFeqC03If1m8O2MlPHQsbMtfOkkV6E8KT2kDDdGt3dxynU4EqGjYCzw5t8cZD75dv7ZBMZEIAIxBt6D0mAdTaHh3RNvQV3RhB5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tKyGIshVqK0IVkW7hJr/PdFepM80RKvciuVDLWvZ/Y=;
 b=QUosRh4etkddu9EJyLXCaz8ISHwgfM/eO5hb4jcGhzzV9SfG2RbX/vB3+q+rlcBTcci3h5UipK6Q4RAR8+y+T4IfgYd9GE08K8adK2JTghlpIUC8sBg63EF5QP0JZ3fWkwSUjZok5qYGgZxKNBZ38AdvQYv965bE9UAh0Rtvu/hMrDyaSucAHw2Ao5reQrVvoxIo+MEEzNUGpA2mhk9A3stPj6HkcT2U2KUZYnBVbizOc2v54V9LqJLr+N8kUwFpaw9pdXVVZAegsGaSYD4noYGTu+eJJV0jgFFtFoc6vDf7jJgNAMzFpCCrDjAeGu67DODndv0wn9UEct17RiQwyA==
Received: from DS1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:8:44f::6) by
 PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 16:47:42 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:44f:cafe::78) by DS1PR04CA0006.outlook.office365.com
 (2603:10b6:8:44f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 16:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 16:47:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 09:47:21 -0700
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 11 Aug 2026 09:47:17 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <vsethi@nvidia.com>, <sdonthineni@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <kumarahul@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>
Subject: [PATCH V2 3/4] PCI: Save and restore the Device 3 Control register
Date: Tue, 11 Aug 2026 22:16:39 +0530
Message-ID: <20260811164640.587078-4-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: f266c674-48e3-4b38-ff26-08def7c842d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|5023799004|6133799003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	6r3cp/qHDKE3Y8jaD5q+6bQ54jUytBxXOh3HyS2UrJcYfUmuvPq65YPVQkpXCy5EZs414HEVSk3MofA9fpsbVo8ybAnxHGaow8YzzWK2eV1lk0hYRQme2suDq0CFjwfSfyz4eqxCwpdHo/Y1T8A1k58Kf2ptkZQ6fSYDMcZ0UjvVzvIeE1n2PRaWSWMyThj6Z8qjnzkORcEdk3LnkOktWKXEt0oOX0ZuWcL/1+phD/dDxj4D5GnkxTdvd0GAlhCm7aHWCaY26LvwkElE5OFgRbD5pzsVY+9iEDSK8v8U4QTNlMD9Ob9SUUreE47GAKI2n56g9MOn7iNA9dqZVWGlONEWjkfnmP6ViAXMiEpoCL9fhV+gPb8szJqbNJx9iqii6AKVKOAy7VdXXnNEfIgxveTf+jT9oNvfSHg3WWCDHHsAILK2ykV3/f0rYesCIbBlADkDpq9OKaTMyDgwOKhkF0a24bKhaiobzuwdGDBcRxLTZBIi/YvGtrLN/3FqQdRNMT2fZ2jZeE75tbm0IVXQW7wBWrhn18K1jwZo2OKnai9IhCDT4lL2WqXbS71TkVZTeir/KQkFtq8DP6KWrWlJPhtrY4VYCMcqxpX9W+AkHcKySYcVFt2G9srTTpMbpMVrEEgS90qvYpEoY0qtj3ZHDbY8YSq00G1xfOhJUx4vZVPmN7CWSjQuLP449aSiY3bnA8sZzGsvqMs3fAd9d2mgfQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(5023799004)(6133799003)(11063799006)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rak/B8S4/4iYwR/ZNXXwx+wwCaWmnlvLtTtIiXrceCAYLodolzkFs4r4G6MQSBN57oEOBHpmfne0AYs5sigF7/P4i6cwAwL99fRMdtXGGWnjmet9iYgu8rOgqZZ6n7pigtRj2X5wiCHvkvLGt/AJQr2yy0N+rXVQgp02EptzgHKo5PrDhssRxrvAn3u5MBjSl+l6y9sMG7bSyKFQ8j2kijraCVQrAIykhwNgpolsLnlVR9SOpMHvWdWsgp3CnEcF6SfImzSp8Xc7G3d/sxDMxcVqPKSs3Du4BlKRnxjWm0Ot5HFhcA0ik1cK16Xf6rzXvOv0WFHB6lISv6QqW+PUEZGQ1zhTWNqvpcSh84yA7tibNDtv5Q6/nJ64HEhl2sT3y7A0t0r7Uf8rzpQ19tNtNwObtihC7auakTr7tI91ZkIVluyUev+LOrywfnux3720
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 16:47:41.8739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f266c674-48e3-4b38-ff26-08def7c842d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302

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
V2:
* New patch as a result of splitting the V1 monolithic patch

 drivers/pci/pci.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c | 12 +++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff6d5d059b21..3bbeed1ba20c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1703,6 +1703,82 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
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
+			cap[0] = val;
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
@@ -1759,6 +1835,10 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	i = pci_save_dev3_state(dev);
+	if (i != 0)
+		return i;
+
 	i = pci_save_pcix_state(dev);
 	if (i != 0)
 		return i;
@@ -1826,6 +1906,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
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

