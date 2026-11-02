Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611399;
	b=gX0I+95xr0HXj1Fl72YvPogKBBvEpKYr/6mJFDYnavO3aYY9ZSk5kIhNr6/StjdpIT7W
	 gIdKgwTIni3eWFoAaEJGf2wNvWUXIm0zLKGbPNsSFD+MlaZ5iiXQ7vlJTQ4j5rJ6xNtdq
	 khn0IhV0woycwioDGCRIDA15c5ts/K8WsUvJWl93Q/PDO8BMS0vYV2CjnlqJPi8eSGhys
	 iHJILOiO7Nt3PJUphmADlAhPh9WV2sSppuoX1HE+k/sZF1bjKNATzrGuLRy0Z7p9Y6FBN
	 6UeSU94qYApu5XvJv4/afgooZXvI7Xv/8nZKPHLvlbPguIIpS7VQCn+Yo2CZioRGTng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YMUfu8TyAuwLWSuoarlEERmRUmEyPMwAdp1bymG3eO4=;
	b=2UvZY/EycBnNJBVxqlndPoxd22ASKijAwrZo7qC36o/RltA6yVs+oqP/urAB7IbdZb3/
	 J7iRs23eluS8xNw2AeESwJQDLSzfUFEuOrBo+AJNF3uXYFX+Qs5c/9Kc4SNM+aSTWzOr1
	 F5GnsIN032DEG8X1jIaKEafOLv58KWEzqaRsY/wBZS/UmnWdYKsrMR00Q1kOUAXuDhad+
	 ZGZA1Ok6URU+FT6pcWBoKzjv1jwFNhRPJxNbdRk3nWBVJ/RysUR3AhUgq1Bo/A+tLGWOP
	 4UYkjpd1px5Nujb7rRhQIozRUw9qqGvmcYx0lfYEUfDFMFxjq7EScBrBSvShRLtQ24A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V8A445lv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.33
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010033.outbound.protection.outlook.com [40.93.198.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2B606A324;
	Mon,  2 Nov 2026 09:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=V8A445lv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRcM7G+RMyBieNXF/rEpb1DWVGMbdC75V/A2MnrtJ1k/7b56bw2xkn6ufLO0fzKwsFM0TTYdPLdBCtbecCPxJsNnzScb6QH8OyRNKqOzxt6PcqG5TEpUPrkW3zzXluK0Z6s3mGAvMng5HTNVdeZzgY3zGiHc0/TCwy6GBb6iHZnO4TnQsKHmncHq+/b6SlwUa82SgimKrd24QdRs7IGmeYM4/kSKG7T2BiD/xbJAQgmucuOLqtlqscSF2kiNSla6iokimZ2IoI9mdn1cj1ekRksr8bGxT1894UmjCeqIiu9zOe8N3VXcRhjlkriRlRL14KlFtXVXpaZrdkcbh/buTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMUfu8TyAuwLWSuoarlEERmRUmEyPMwAdp1bymG3eO4=;
 b=wbet6EWt8v9Z/13DFwaJ0vqwphaYO1N09gyCVNzf8RrnN8zgD8nRlori2gL+tcdQJLGu/F4T2e/ga8RKy9cs2Zt54Alm8MhE9FkRvB8RuX1dP6Djz3snYTx00G6QYfnlym5iYXy2Dfs1lpnGnWPOP/qFIokGrgTxQtfB2QVa+Q8j2FNPnUrw4xSl+Na/QoG4hKA4y61pIZL3wkREWdXOMxy8hWE9rQGYtZ5pK+JWNAYgXh4c0fgXHbdPZmnWUGPouQJGHW3gohIJrIemfz8GwwPjKnN4v8VzdY9J/zycqyMsrsf4qL19L1jiWOVOIFkNl1fFbe2J9b2HsR/J+jWewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMUfu8TyAuwLWSuoarlEERmRUmEyPMwAdp1bymG3eO4=;
 b=V8A445lveMqcByYvGAI7au8BQFx0T1xvVdK071bVFpDZIgODKgCc7ClJAXqKG3jHLrndPOJMRPggcs23oo8Q2CCxpFx4uzzvPDh1xvCBuBj20y1G+rDcplTANCLKKvjYRVfmR45n6RcoGyZiEDVjJrXJtUsY5BmUT3ftgOre3mON5dtkQEYXBXbhPXF7Kq4/JTn68rFhG3D+jR4xNf2BHuLZnt1Lhs5n0exCJ/WngeHtgpH+irz9p821PezcdxFWfMw8FzWW1SpKEUcKTbwAciKtuyGVA83tHtsitm4yJvNXU94sZSIJZyArKAujnNBxzZfSqiVAb3goW7oubwKTuw==
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 09:23:14 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::41) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 09:23:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 09:23:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 01:22:57 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 01:22:53 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 0/2] PCI: dwc: Clean up RAS-DES and register field handling
Date: Mon, 2 Nov 2026 14:52:36 +0530
Message-ID: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 716ac547-a538-4234-280c-08df38c2ec09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|56012099006|11063799006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Up9elr4SS43IxqUi44Es8nCMGPn1ymUR5od+Ml4cbosKGGR/6SuQSUqE1NUbhw9ht9A2ASA5QaGYw793xuaR1VxyVgEVzcIxdMCZxv7WK7vAQdIVCEkJgvtzxfVPrrnwX09uI+nS6WWewfcULwZvYk1LzutkVz7lzbsZCwikkVuSaVDbKUOO5hKysqL6prYExcrcXfrV/pDIGEmrw0Jxx/O1WT9qNzrKz3geCyD95jjsbaxPfQPgHRcUKEgqXs15wNPGqxTRxX/MuJ1xUYW20nyPvg78nTqKmG0wk8ddPyt5qXMxcW6cTPsHBmupJBQAL8fSc6RaTD9XJkOrADueHGuUUP+S7k4DponP+7ETQJiqaldPn8+kIM9UiQEU3MycgFiDOCzRcgMteXA6CvlUbttz/pJNNoORAsoj97W/F9XtCUfQc/PhBks4rkJuDs1+5i4mON426fyK39iG5VSW0y2peLvowgrCO9yWDVYZm93EiV2VX7wbI/TgjBerH1wqN0PwWiTwtKNIuGMQqAEQTm+M4zjVmROu1g+2z/rXtYx9RgAVGRbFkLUH0kF9GGEA3Y/gdDNr8926w/9fSEIUD1UrbfYBvVLUBwMfESq7im1AnlG4rQWhvLtaiuYijzNoqUgO4uVrhVuuAkFWwWCfPJCzZCTIy3VvCRUoXgCm7tqXxi+IoDKj3lv8I3+1z5uPXUhPEk41g/u8y6nri8Fb1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cRqSeIuBonZ/C6iDuadgVjKC6plb8ne/YCPr0SXs6osy/dCMolQxmOEVtWWuuzC4VInS0QV3P7Z9OAiaLVCUpvVDygcrQROxEgRitUR7rfy+dWXsNpctlICOTCWdMTkGAjAlF7+z5NMDxqDhQ3sZJqeecTH8LNlXmcijlPcuzqffAm31p+S2m19/MGsY2Ql9OQjRlXloyU1cOIBxMFD/S+Yqr9dkoM7pcxGeBtRWn9esOy3DI0PmOiC9iGhh8Kp5d1+qDryrDkWJApnt/UhrlHPvK+2KGaAHf/4fyiTaWqUFkSqdgF8B5sPU0KXEF9xI20NN1TBLflq+SuydLSpz9lsqJnFUunpF7zLPoeI69DxjXyzUk7E8NC04dBI2FxoZwF0eM/Lykb158EU8BIH1FTxqRKwMzvA4xKrIUVQrCSWXJk6Bjq5ANdcINNSVD/iE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:23:14.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ac547-a538-4234-280c-08df38c2ec09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

This series addresses review feedback around register field handling in the
DWC PCIe code and the Tegra194 PCIe driver.

The first patch converts Tegra194 register programming to FIELD_PREP(),
FIELD_MODIFY() and FIELD_GET(). The second patch consolidates the RAS-DES
event counter register offsets, field masks and per-event enable values in
the DWC header and makes the common debugfs code use those definitions.

There should be no functional change intended beyond making the
bitfield programming explicit and keeping the shared RAS-DES definitions in
one place.

Changes in v3:
- Rebase onto PCI main at 17bb0e2f6c80.
- Reduce the series from five patches to two. Commit fd3186c0bbb1
  ("PCI: dwc: Describe DWC PCIe fields with full masks and FIELD_PREP()")
  already supplies the full RAS-DES masks and removes the unused shift
  macros. Drop the separate mask-addition, shift-removal and selector-mask
  conversion patches, and use the standard selector mask directly in the
  retained Tegra194 conversion patch.
- Update the common debugfs consolidation to use the upstream masks
  without the temporary selector-mask alias.
- Move EVENT_COUNTER_LANE_SELECT and EVENT_COUNTER_STATUS to the shared
  header as well. Move PER_EVENT_ON and PER_EVENT_OFF there and rename them
  to EVENT_COUNTER_ENABLE_PER_EVENT and EVENT_COUNTER_DISABLE_PER_EVENT.
- Preserve the original debugfs line wrapping and alignment to avoid
  unrelated formatting changes.

Manikanta Maddireddy (2):
  PCI: tegra194: Use FIELD_*() for register fields
  PCI: dwc: Consolidate RAS-DES event counter fields

 .../controller/dwc/pcie-designware-debugfs.c  |  40 ++---
 drivers/pci/controller/dwc/pcie-designware.h  |   4 +
 drivers/pci/controller/dwc/pcie-tegra194.c    | 137 +++++++++---------
 3 files changed, 86 insertions(+), 95 deletions(-)


base-commit: 17bb0e2f6c8043f70a693a5f3797471cbed354c8
-- 
2.34.1

