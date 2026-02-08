Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E252F1FED;
	Sun,  8 Feb 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574136; cv=fail; b=tXjvlnry0ANZUO7DWZ/2Ul1aC7QcV2mbRk80TGhdoGO+gUolzLKDXnhz7K0r7Fwdy50ImyhqqVY4YEdgVDpTRNOb9m5S9WjyxyGvfo2wrfbRsfFm3FOiBvemesame+H5jRp7ay3KVTA/uUHuXZx1AUx3Y9hjD34xGvjPkL16cz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574136; c=relaxed/simple;
	bh=eN1XbNalv+3PtuQ2fgYcww40NIY3Sq4lSPqnJhAKQYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqzP5LlP53B9pPfTVhAwTQJqFeLIBvXCbIgJbPisSXoGdg2ZTentaM6Jou+pEVoIthBmj3m9sJD4j0xYE89kbTB5B0tZirxqxDGQkOuffcF5M4SRPf4lqlHc8YGCPJfGv5g4uotsf7fOc+qxXQqT/IBKiXYfzDpNYd/SW9Drrw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iUSW8Uwb; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iUSW8Uwb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODBlZoy7wDLEAIvLz7zASWMB4hJYZLnhMOFM68U5sdXg77azkrnLGG13Tn5wdmw8cVZBWORYiCT7JlMLLpaif29HE3nOZXbmBt/RSLqgLhSiJp+srHS3r1wavcz5/vhdxbRMZBxbrH3jLTMkANUsnY+JGXYF3HMTRJY6do3wUA9RpU9MZmBZOc1glrJbTV/miO+PuKSUoqlZx/MGKf202ZXNus+zTdrXCKeNTX9th13Q8lB/rFO9mgEn1MKkSoIB9HgfqthvWe3K1kmU3vA4YjhDGbLKWfpE06duJlmLnpEgjha/mq+ACvHBiCG2sWlqKlFN2ve66YLgCjBAmu6N7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1B7nf2EuWA/Rg2zVaqlyfn7AepXv3Oef8j1A0tmQWU=;
 b=kEpnEIKulqgmxKhTCnjp19kVULk5eWLlZQo9943euVZQ5eSr3hQAU4u/okptxRryyJ94ybgOZ58CgY8MZZKx3v4Een+9mPEv14/NUgb9WtKjRpSsUot3XnS3yFGQiziVNp8HuHMPp+Kv8pHP1SkntMGk2k17jJOsDkxnLr1uHNFVVdGQPSXhfJVEqI2gKqJnui+8yc3I4FJJImR01kBwlUtz4Nt5dSydhOwwcqMRzEtL8ZBbd1wQHrs/adGST+zy1jpjUR9js4XCG79bjqT1ByiFq/ukuBViB5IG5O6Yn9kIx1OG8YK0r3Cl7zTykRc7CNPAS9j7JuYHa2h8YRtpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1B7nf2EuWA/Rg2zVaqlyfn7AepXv3Oef8j1A0tmQWU=;
 b=iUSW8Uwb6dDAX3F0E4P+lz2ILvaG95RTZ8KxRKayZQlHb9uAwlgKnPUhnq3Djto8BX53vjtqZYIObo+Lmo6Rm/dO6HfEtE1Nm/Lq4mSTmiMbfbjx5RCO9wK7LTWCZziAO5l9AeHOvXGLj8Ff/QMJoCPzLi8uCRZ4iBwg1ykfTYnJcPLk5ZhGzg7XZhwg3j75XBiRzrv/E37jgnqpkyViA2yZTRkTzyLqEqdOlKPFZRZQCF1P6PITwFy2tzYyDj+uFT3+TG9laytEFZL/iBRWccFG8iW6Vm99iKlMA/Yr/IcGRymTwiJny9KWBUb2U+xHWtV7z2b9BUps5HZVYyHs/g==
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Sun, 8 Feb
 2026 18:08:51 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::aa) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:08:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:37 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:32 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,05/13] PCI: tegra194: Use HW version number
Date: Sun, 8 Feb 2026 23:37:38 +0530
Message-ID: <20260208180746.2024338-6-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dff5b5e-a319-48b7-deaf-08de673d1d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/f9i/2EDVJUYaBB6GtE6HF6BjZ9msEnTOQhuov9kvKtldWeIBlxrJZXoHHlp?=
 =?us-ascii?Q?IclgtzfnO/E6s7apB2Y4knRUnbktpBYnkUuH7nTUGGb9tvpJpTS8jArwJb/U?=
 =?us-ascii?Q?u9TVBdlrBCpEZEr3LhKTxRpq1bJxZygi6VPIkQgAaGbrK4mAgILrwd16wjjd?=
 =?us-ascii?Q?B07IK+/5TMDSiQsyNbyhn/PyvbyqWdWePVPe3JqvQNI+dgiXGztV/Y45rkLB?=
 =?us-ascii?Q?tiwbdDCiPat769b3MzH7U6oXDqtDy5le92lXgwoRJ4I+FUxsVKzv8SM13Iry?=
 =?us-ascii?Q?y5kcNaup3GH62sHr6b9Ekso7p/Wm8LRwpecMqWX6v7K75WWfCEfUdj8/6jYk?=
 =?us-ascii?Q?rW7CxKh3c4hbLvnFJiLmb74tAB/AlBtoDPBYCkgxbGbQxghjsWlOj6Pq4bY1?=
 =?us-ascii?Q?rMzGnwtzzDLASRG2Lbmp1M88IFdOD139yVRjYmgAAcVIwvE5ImEXxN4ubaOq?=
 =?us-ascii?Q?kAy/BmdHBaFj40u/vbtB8nQvDxDmgx10S6HPseDoN5mUeTvikZIOa6o0QR0V?=
 =?us-ascii?Q?9T4az+iLzCR8m87ouHG7jo8N3XM6SdCIVjOaHv0t+40TCqvDZ6u8GS8ZfWfY?=
 =?us-ascii?Q?FB7gKJtv0EsyrR4AefDCTLbE31DlQ91jKcID3j6IzAkWxlWGgU+ddwO026NT?=
 =?us-ascii?Q?wIjz53Kcmm7USl6HgRVDBnSUg8Ny9kHu/fp7P/j5LYZE5ocvycb8NpwULF20?=
 =?us-ascii?Q?ivsKnhgfItXde+/MUP7IGQzFSKqQAkbrNUW7THkh9OUaUkvcNins8PTk8LYs?=
 =?us-ascii?Q?QDNiKZVkyJNxH89e3kXr+ss6tOKojXKTK/YLa6QoCrz+yLF2vrlp4G77ai1A?=
 =?us-ascii?Q?x1MyRRixJu10HOWUeYndb+Do+2Tp06YV8MeTF35eQNGoyiDuP0Eiomtbt4Sx?=
 =?us-ascii?Q?y+D8aRj85qYn08zekiryUiTtQAlZUz6aDzt9S3Hw3KA/ciy11COXPYwbSba7?=
 =?us-ascii?Q?F5f7vxVYSfE4V+dV9dh4WrREQXVPtawYyftb716aeMK+z6/5xx5eOTI0B3aP?=
 =?us-ascii?Q?Ji/EeIn988nXFH35ClDHEi/6vDt1Xsb1E9r1t+mml1Wt/VdDvv5KLdBLXfFh?=
 =?us-ascii?Q?ytZIIhHKYRjVEWj+iK7F5k7SU4T+AZbE09V7fMTPgJV9M6RqOVyPnK5Gs78W?=
 =?us-ascii?Q?192+/U1oCcyKzA2gECavoJUqKdY8KyjY9QD68Ja4rRTs9XrkNPJKqV074p1O?=
 =?us-ascii?Q?L6+OqvR8x6dL4PKOvIzSwPKNuhpuGGIGOghIYoTbdkuU6Xrr3MVZV8DdGN/i?=
 =?us-ascii?Q?WL1mwCmq2J9fbFtiEIwOcL316b+AgkqLf6AkYsz5JvzDROi1TcQphO1Ux3WP?=
 =?us-ascii?Q?7CUi7s2tCEEh/HvEGErY+KznfOUJNKrvsu2zsdNr0inwD3HF7wQoz6QXYFle?=
 =?us-ascii?Q?+DE8beKbUzN+lNUziCJM2iXJ+nZ1ulLE+uljLhI7YXM353vOkxRup/u44B7O?=
 =?us-ascii?Q?hNQqA4YKdp5IORnwV+ilSXR3/87fkx4M6RQB5P+lwtq1SDO2y/ElvvZm3eqV?=
 =?us-ascii?Q?vtdTagrsSpT6KkQyhcQRC9GT0jBXtj5pUXrWd7w59Q5/SkYX4ekzzLMseBJ8?=
 =?us-ascii?Q?M2Drgchb1d3ygsxH8uaoTUSJ7bxmYd1PdWLt+iuScwUaxmTbSPHZhbs4MK9z?=
 =?us-ascii?Q?rkkf81I4/fwT66lOi5Usad8CzN0xLAQxgqps4VeBfFsvzKOPWNI00q+tt2k/?=
 =?us-ascii?Q?QevhCL3zjkFRWWwK1LXxOMNs8x4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iRnMc7b7+KudYvQtivEN0CUdQsnwiTmAUMFlQNlCv+3scWbwyQQKDqO8SxgXs5iqeM5Li3X2GFQPP8ooCYXN89Uw9rz14exLAKjf3OtpJcPTNZkFnQJHJMbjEQ3yBwIHce5nsNDtuFMaoZx9uAaB/S2YkeaFHBd1oqv2ANTVIMyI3m00+Z3KH7VBBf1O4/X38UTsc18XQJcUqG1I5VaemvFNqBdFxmg7M4Hpsk7hQRzoIz7JfRJ/PHdKaYKSgIiwF598O4ahFrytSurQkmA/CrSsvwFk04phbB53dtPxLiKVSelxe2R7yr62d+6+HbIHmaFnlXCU2VFNHo/d3jFfXJGOFbL5SXNOKM+9fliszSLSputQ7P+CkMBvYaKo3TiPs4zUFJRL7cMdNQRrUP1SYwvnrUID37zTFDZ/C+baSS5Awdh+Ze3Syy3FaE2uePoU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:51.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dff5b5e-a319-48b7-deaf-08de673d1d14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Tegra194 PCIe driver uses custom version number to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results
in mismatch warnings.

Use HW version numbers in Tegra194 driver to avoid this kernel warnings.

Fixed version check to enable ecrc for Tegra194.
Existing 490A check is left intact in case any HW relying on existing check.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..0dac5d2f5a83 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A))
+	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f4cf1602cc99..5bceadbd2c9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -34,8 +34,10 @@
 #define DW_PCIE_VER_470A		0x3437302a
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
+#define DW_PCIE_VER_500A		0x3530302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
+#define DW_PCIE_VER_562A		0x3536322a
 
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1dba3a2d8eae..3924ac123183 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -35,8 +35,8 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
-#define TEGRA194_DWC_IP_VER			0x490A
-#define TEGRA234_DWC_IP_VER			0x562A
+#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
+#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
 
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
-- 
2.34.1

