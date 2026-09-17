Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B54A4406;
	Thu, 17 Sep 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641820; cv=fail; b=je7ABy8xLmNpdOLNuPxhneekh8vHhwfFvQ15NkTltfGocFlBG8AyvTM2CNpSwvCN+CgxewhGKWP0qkJqwlOJozGPKVvyERbhOWmFQiajkosFYayUBh1zu8IHgby6pwwYFCJSFgf9KpBEFYm+HaVDyXg+KNETtJ0oNnO+4HVVB/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641820; c=relaxed/simple;
	bh=eoq89Wc4NK/9VmKCa2fEzw6zAcTPhyDuUrHDFBN1d/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbTRLVoNuHmtFa8df0hMcYAdgN9/5ObIbfU8OMSMlEH4oNMtCkiKEEfeZD4qKp0TBis+C3DhY9ii8/9I7ThoI8HduuA56wPk9AJNU48kwjeT1WZuKIx3zrDgHE9e2UQ124d52gZGRwvzZDBmDJ4fAdkfuHRTIsIBFqgm68G7qbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z7HtqDGr; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z7HtqDGr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFOQPrzhhs3wl6G6Aig/8EoA5mEgjREYOCzn3s3/vk4xI8qmB1uXlD20DwsFzdZMk3Z2UJ9+e9/xyVQ6VDWbU3q9zHeCG+G5VhQ0Hk9MiL7naHPq+U8LbKLz1Eax7VFpqZ08afer0xsN0/o8ECqSfw2+LGNTCJ4E3UPkKqcGtYEnneY/4HGtaxStImN4bvulICOwLtihwPbJwNTCwLOO71vuuk2xKBclnn9kaioIst/FiSGXPjChuKY/XlnRyWYHo5rkyRJvP+c1jDp1TUnSmkVIsIL3N8vClfHwx1MpbYriJH1uf0MCCkaBpOnG3d0IGBpCuU7IfGZ9SJhWUzv4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpjJyKdyEZwPDzmkROQLCoPxL9ZRFtOM1EjfET7iTbM=;
 b=zDNTIbAVz9FJIgK2btBHozhd32g2gYXpDw+LntxAVxj44tL1xgQM0XMfkS685ca0goGjqc35BIwUE8uK869KZqnVNX+ZR5zNEFt4PbdLfQGOzxqPXR5ZfUXHhH8IhT++BSj/36J0SqiDtDMnuAB21m4sscW+dGYwgQzDzNqMdPOuN+3q1zHPiX3V91/d1Dfnv6LyNWT+7DdxxhSLXLM/sIRMpJnVtaj5HI9mM6udumrlNp8T/+0ZzfydMZMrBvK3gilcH/IyH/lEzXWOFnkMneMYlY388+ElbAW3JhI0eS28dgKWQn1uaNuGztTnzYvxHBRZwnxJ2LOZqy9mcwpGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpjJyKdyEZwPDzmkROQLCoPxL9ZRFtOM1EjfET7iTbM=;
 b=Z7HtqDGraLmp4GmjA23VglvJ9gbQ85C7KiGOzJfJWIJavbw7MB7Th7rd0XWNgLAbvn/pbKi32S9cHyJA3Hd3nBQ47T3r3wIPfxmOMiyhf8LdhXjBusc1mTjeu8UfcDWZGoaavvjHuChJRQxZ2YVbG5xe4yNxPSiDxH3pSbsMPTWuXWQG4lDhCNZECzbNdKSavese+BO7DA3q7z0gOM+sTfwUx+VqddR0EnpfOS2P9grmUnizLlgPUNUWJ3kWsZqvHHxrFDNZWEG91AqFjyQYvcdCK2H1QPmJj2Seh4LGIiTzdOvwURHEoc//KkYIw9/hH3WbTpR4CcG5RvR3kqCB+A==
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 10:43:27 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::47) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 10:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:43:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:43:01 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 03:43:01 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <bhelgaas@google.com>
CC: <ilpo.jarvinen@linux.intel.com>, <jc_chen@diodes.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nirmoy Das
	<nirmoyd@nvidia.com>
Subject: [RFC PATCH v2] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum
Date: Thu, 17 Sep 2026 03:38:14 -0700
Message-ID: <20260917103814.1985144-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723161010.2638956-1-nirmoyd@nvidia.com>
References: <20260723161010.2638956-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 383c2534-d7ff-4078-a03c-08df14a881c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eNFa3NmjoCJMhleq77e12XwZtfLQT9jXAPEiFzgZtVWBjKL/nMEgsnu4CDYNNj7DB8vHSe1egylvTWpZrvAsx2ZpKjGctWGz6DMLEAJKmOpZIFDex2NI+XVPgowuBAsiDd7fvEgTD1uq7us9eE9gdPXSCmxLdbHEAdvedt6J/cBBfdjgtsZhAvizg2GCgXOtv0fCeCvTOhPZZwVknKPO/xA/fWbnuliroMPupx71DOmgJTwE2E/RF+ma/rshWkyT7mNvVfk48RF1ZZAD2BtcbtcwiXYq8iD2JIqRQ/MRNYoM7f3ttHdsJ7qnsi9EkdraOjKig1WTprSoJa9IOL6uDXxgnK+f+HDqME/TMpE3SIE9HX9E5vL9vK8LsagNerOUEWndLjFsO63j8jKLvYwbyLVdnZDPogR2oTsA2690+NxmrAPfTY/zD0A/85QE33RiKIuqThovuf1puT+ndPFhxUq/CGQDe67tyK3JOKtYVd4VBcgt9zqYm3hfyPrzL3TCLy7Vwl4xkcauZyGI13fQNYmHbNE7LhWlfh/AK8IeEFDLqm++r/Rw5ZBba2sPr3Oq3A6wbwJZyhr0LmxAZxbvE/0QNHtARLUS3K1TrgAoHMDDtDyZ3Z+CqFAVA/SsVBSrxT1HkVm1MQL8U7G5rvvKtEdRICNiibsR7pIxHdhvK8QsmKRqxdjRKqPSa9ENqZ2XRW+gOvh8vHyYS0Fjlw3Ebg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aI66PIl19QbG0CZzoOHcdCFi4LEzNRWlF6nfvzYh5YSfIRwXJyREWXYbTVROUlhbmedtrF5Upbwt9PCP1MNmqK2LKDOq/vn/x2VbctrZvM9FPHGDzWWifpytM8Gh+saPiiLRTHmxreRG4a0ThMyqJdZFO/pqiVsOB0erdHS5HbybCmWubN+kvG9Y1RxQM/bCnz/9GbRsP2AyOahsBFo72TnaW8YACs8gnrXtiaCdrph0nTaiUTHSFAjlVUn9glJ+tNZ4OkP0TbHb4ITi2LtbCHlCuWYr8NXCZ15LWVVTw9mSSP9xko1tskoIat5b2bvpskfPNZY90kAEemmJQLW1WsGia7+zrX6Y/PSnn0JNvui+IGid55+XI+1uCZR/bIpX0+iJPHFpHErZ1lQLD3hJPWork9Wowjs/3yVQOi3CksoGoQCew7ZsD6JMOXASUAie
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:43:27.2002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383c2534-d7ff-4078-a03c-08df14a881c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

When the Cross-Domain End-Point (CDEP) function is disabled on the
Pericom PI7C9X3G606GPC, Port 4 exposes neither a BAR resource nor an
MSI-X capability. It still checks memory requests against
BAR 0 + 0x7f000 and BAR 0 + 0x7f080, the MSI-X Table and PBA addresses.
With the internal BAR value at zero, reads reaching Port 4 at these
addresses receive Unsupported Request (UR) Completions.

The affected system has this topology:

  0002:a1:00.0  PI7C9X3G606GPC upstream port [12d8:c008]
    +-0002:a2:04.0  PI7C9X3G606GPC Port 4 [12d8:c008]
        +-0002:a3:00.0  Micron 7450 PRO NVMe SSD [1344:51c3]

Diodes' workaround is to copy the upstream port's BAR 0 into Port 4.
This places the Table and PBA addresses within MMIO space already
allocated to the switch. Port 4 accepts the write but still returns
zero on config-space reads, so readback cannot verify the mirror.

Firmware can apply the workaround during boot, but Linux BAR sizing
reads zero from Port 4 and writes that zero back after probing.
Resource assignment can also move the upstream BAR 0, leaving the
firmware mirror stale.

Reapply the mirror after resource assignment and again after PCI
configuration state is restored during early resume. If the upstream
BAR is 64-bit, also copy BAR 1 and disable memory decoding while
updating both halves, unless mmio_always_on is set.

Assisted-by: Codex:GPT-5
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
Changes in v2:
- Explain the CDEP-disabled address check and how BAR sizing can undo
  the firmware workaround.
- Clarify that Port 4 accepts BAR writes but still reads back as zero.
- Include the affected PCI topology in the commit message.

The unpatched boot log shows Linux moving the upstream BAR 0:

  [    6.440107] pci 0002:a1:00.0: BAR 0 [mem 0x10300000-0x1037ffff]
  [    6.445353] pci 0002:a1:00.0: BAR 0 [mem 0x10c00000-0x10c7ffff]: assigned

v1: https://lore.kernel.org/r/20260723161010.2638956-1-nirmoyd@nvidia.com

 drivers/pci/quirks.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21fd1b..88ad85ecd7eb004 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6272,6 +6272,95 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
 			 pci_fixup_pericom_acs_store_forward);
 
+#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC	0xc008
+
+/*
+ * With CDEP disabled, Port 4 exposes no BAR or MSI-X capability, but its
+ * internal MSI-X Table/PBA address check remains active. Mirror the
+ * upstream BAR 0 to keep these addresses in MMIO space assigned to the
+ * switch.
+ *
+ * Port 4 is device 4, function 0 below the upstream port. Its BAR 0
+ * accepts writes but reads as zero, so BAR sizing clears the mirror.
+ * Reapply it after resource assignment and during early resume, after
+ * PCI state restoration.
+ */
+static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct pci_dev *pdev)
+{
+	struct pci_dev *upstream;
+	bool bar0_64, disable_mem;
+	u16 cmd = 0;
+	u32 bar = 0, bar1 = 0, upstream_bar = 0, upstream_bar1 = 0;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+		return;
+
+	if (PCI_SLOT(pdev->devfn) != 4 || PCI_FUNC(pdev->devfn))
+		return;
+
+	upstream = pci_upstream_bridge(pdev);
+	if (!upstream || upstream->vendor != PCI_VENDOR_ID_PERICOM ||
+	    upstream->device != PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
+	    pci_pcie_type(upstream) != PCI_EXP_TYPE_UPSTREAM)
+		return;
+
+	pci_read_config_dword(upstream, PCI_BASE_ADDRESS_0, &upstream_bar);
+	if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
+		return;
+
+	bar0_64 = (upstream_bar & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
+		  PCI_BASE_ADDRESS_MEM_TYPE_64;
+	if (bar0_64)
+		pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
+				      &upstream_bar1);
+
+	if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MASK) &&
+	    (!bar0_64 || !upstream_bar1)) {
+		pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround because upstream BAR 0 is unassigned\n");
+		return;
+	}
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar);
+	if (bar0_64) {
+		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
+		if (bar == upstream_bar && bar1 == upstream_bar1)
+			return;
+	} else {
+		if (bar == upstream_bar)
+			return;
+	}
+
+	/*
+	 * Disable memory decoding while updating a 64-bit BAR, unless
+	 * mmio_always_on is set, as pci_std_update_resource() does.
+	 */
+	disable_mem = bar0_64 && !pdev->mmio_always_on;
+	if (disable_mem) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      cmd & ~PCI_COMMAND_MEMORY);
+	}
+
+	pci_write_config_dword(pdev, PCI_BASE_ADDRESS_0, upstream_bar);
+	if (bar0_64)
+		pci_write_config_dword(pdev, PCI_BASE_ADDRESS_1, upstream_bar1);
+	if (disable_mem)
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (bar0_64)
+		pci_info(pdev, "wrote upstream BAR 0/1 %#x/%#x to Port 4 BAR 0/1 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar, upstream_bar1);
+	else
+		pci_info(pdev, "wrote upstream BAR 0 %#x to Port 4 BAR 0 for PI7C9X3G606GPC BAR 0 mirror workaround\n",
+			 upstream_bar);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM,
+			PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_PERICOM,
+			       PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC,
+			       pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror);
+
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0
