Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227572B9BA;
	Sun, 22 Feb 2026 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771788961; cv=fail; b=H4j/kMt1O3IWu7omPNcxHgdPFdZhdSzKrhIdsjbqMyzdp/pPVnsVOC5/HsGSsE+QXrJTHZAvD4ZWdImCH+oY5I3LZ0ZZHkg+I+vYewlpLeH9MWyVEpYOjxVlvM4M0e/HOxdXVSrecoYIGWxJ/f/tbpvaJABTtKL6x8IdZVEU8ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771788961; c=relaxed/simple;
	bh=yeQ0iLuXDRoKpjKLOuRk5txuB9LLLeEoodDnZOnkYAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7ttJmqEV9D1s2QShZnI/J0C7RMqMv3wLtvO0ZFws1Qb2Bgyiqt1LRP1nQs+ZwLiEOoDr9YJtStzYJ8KlJtKHX/jzYbnfItQ8QsnV8Ck9cDfB6iHRHUFSNR551x5EtS8e6kSV3Fa5dgzae+f/dBvKw2ZrJ0rxtjdO/qiQ+cO1pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YELuFfD4; arc=fail smtp.client-ip=52.101.53.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YELuFfD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0mjW3I0ENRfCINBONPgN2Z834YaEzD1YMtS/vqNMl0QWsTFLuuBdMDKtYsB40xa4b57jAo+3vwpeVYPfAV6NFsfm8AjmwnepujUwN8PAiaOvAvtddFsqCMvxPspZhi5kVF13byUgKGa+UvcwSn+YP1fHr6wGTig1bEnd/smcU3wYtBnuWATAjaV8NnJT1TeYSXKRzqZVOFmf+N7enimHs/zd/i+rRCqsM6yj6ax2nqhs4aI9rKDLhqxpyf7X02+ttFKVHr50KHwpYkE225+VMnW/RB1AhxQsUFJb22ddCcZP3bDaH1jmveyQo9yGCckKBgaGYLpotYzzvdS/Z462w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVXNia+HixdPH7ZEZkmpqCtdL3ySyeZjGodGRnxyq38=;
 b=V/4DR+wvOkYmVzYuQzoSPs+3JkR5StLGaAfzksSA7MXveXIs9bgASf58fB/uPBK17EyzTMhCUi0RmdsR7/9hKOcEDfbke+acfjowXpBVxLYgdasDlBhFH596zGkkIUHZRHheIjJo6PJvaYcg0diPXd3s2pb3Ymor1X6487Suc9mIVD4UIXsC/5bYY9t0xAEpFtUsvoYmHUstkRda1xPdGdx9Goyl4MBpHrt5w4dTca6wLkTFXf3Xc4z+gbM+kjW/xAnoAb7/WL6nsyzXoIk7sBNFeTpP7pEwEj3auUcdDGtf0QaEivgFeBW1H9yab/d99fwsdGLJVXWaY5BB56uLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVXNia+HixdPH7ZEZkmpqCtdL3ySyeZjGodGRnxyq38=;
 b=YELuFfD459VkMaUwe9TAKZzQ5pvcH/PFBTRgKsjqBp7TaQmDyk9ZS059P7v4ZbVMNO1pmEd/IsnxszAmQdNLKJDqGsPyZOvsftOBvlaiYsevbEaGIG9nRu455mHdhJ9at6tVHLndGMk0RyGxAnCVjIQQt9frSPn6PWZI2Kv9IMnDPtm76JFQnkQMG1U5XrkWjR2jiurlxpS+G49QdqD6OglY1NZBDtwrOKvCJGUP79uWY1OhUerfHTPTxvu4rjgiTfTdlJeRe0IcOoxQn4cx6HONY5g0kCHczDryZ0ZwnVRnV9MjfqKbKgcLq0QagDLmTwDPytBJslIkhceCqFU8fw==
Received: from CH0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:610:cc::20)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 19:35:54 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::2b) by CH0PR03CA0075.outlook.office365.com
 (2603:10b6:610:cc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Sun,
 22 Feb 2026 19:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 19:35:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 11:35:45 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 22 Feb 2026 11:35:38 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 3/4] PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
Date: Mon, 23 Feb 2026 01:04:55 +0530
Message-ID: <20260222193456.2460963-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f81da1-5bd4-42a5-5dcb-08de7249981b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZeKiNLYgNexd4ZKgQuk2u21blbKgnUPFSSwNyZ60C/cFnjVNbgSdqfTNio10?=
 =?us-ascii?Q?zwtZntq0DIFl27CNIzIh4Chf1T2S9uhCXnjblDSvi1pPHpOqnGZbPHQPvNRY?=
 =?us-ascii?Q?PWTYRlI8I1cOcxmZXsna4kdSS8jNMItmcELgxmJl0c8vsBpm4EoLslP7tjcR?=
 =?us-ascii?Q?MJxiN1Pp9n7IOjUD61oSNo9kBYmc0Ht6A8hLPkN5mQehzP/gw8jhMZ4oqi/t?=
 =?us-ascii?Q?vMKTAVd3YyM9rlru2Wl39gGwpGz90zyzBUgqJ4N+rYXquj6E4bCQ+M5JyGPZ?=
 =?us-ascii?Q?6n9DObJ8EwcHZJrkMDuSwqb63ea+qe+kNVdHkoeMIKEMD/ARp94s2IfeGlV4?=
 =?us-ascii?Q?dh7aiaR72RSboiuwDdu5ru48rlTYUyBv9EZafIU0KyydPwk4dyGmzy1mxG+Y?=
 =?us-ascii?Q?3sgysfsU8GDYDZsn3V4M4jdv0j677GVpG8LjPX5FdU+DqFQk6Yc2LMPC4KIx?=
 =?us-ascii?Q?LaoRQDUlzlBdx2jgexz4Pf9eYVYQB5ECgFNUTX3IIBJzBJ/V7zK8jR/hbh6P?=
 =?us-ascii?Q?TOUXycECTfM6zQsW0hCWhUdiGMbrQH6Dodcilr+GXyOXyKCHyfRPiYAxr2/i?=
 =?us-ascii?Q?miiEht3uucLuXMdJ5+ZMw7eSGyDjhPBV94QXlpN514exRjwleP21423oLlqQ?=
 =?us-ascii?Q?NkttSWfVPswHLiqYPBObvdmur53+Sve9yCi3EmRwehTIg0KUHC+p6k2KvaAw?=
 =?us-ascii?Q?OjjkkvCZ0UOo9txynR+xPUXLuFDBN6qAU4DWwreYCWhJAwy9zItV9fVRAv/V?=
 =?us-ascii?Q?lJfwj2QzaT7w8U4qXiCs9TShkYNWunIXfb7+xVqt90W7fDyfNncyZP70yfWu?=
 =?us-ascii?Q?A/AvOAQLLdnYB9VgXQ+mNdRdwQ/jPlDzENvipRzghX1do/otLztFkcTiGNfq?=
 =?us-ascii?Q?a/tMi+gC8nSMpIsRCkllXwP3w59ecwb3g8qyjvAslHvCk7bO+nLRnIBF+7Ch?=
 =?us-ascii?Q?BiDIk8TVZQZ1rODh3ZzNBD4LcAtRQ58VFfDYTOqUAPHoQpqmn/pfhoiluMRr?=
 =?us-ascii?Q?eH7bhPD+1AKYxMMtOpI++kS5mKtmzZAIL6guWIBKD43rA2G6Pv82ZEX/fktK?=
 =?us-ascii?Q?9LuTtwQa7VFQ9UxU3m2cOYxgtnAc2ez3cxfMIG3wMOjp9bLTqdLFvGf44t5v?=
 =?us-ascii?Q?+Hg1hPOzC4cINB3IuFItYEkHTSiVfuxyrwIWZH5MxU7/y2YKOOT4W/SR9ljQ?=
 =?us-ascii?Q?vAc2TkFg7hwgaLWDAd2BdpIFswieyvkA2WSMEKrsfW44hEgCdeN8oJjrdqo8?=
 =?us-ascii?Q?WEk5JcVZZqnFlxS5/ffm9vfctg6lkh6Ign6NQHlxdc0vzm43ZmlEtoGMMnbR?=
 =?us-ascii?Q?Z8HVt6vK23x/R6+kMMDDN/X+iA1N4yy43OeCEr6o5oGcBBqE/vd6JavtQAaq?=
 =?us-ascii?Q?Tu4yuLsyX54cVdN0JpwO3oLGz8ecAF56nmXNHSKvGPVYXPbEz4nFzZjAfXbN?=
 =?us-ascii?Q?Sr/qM6Pff/5auo8Hk508KJYFAcM9p6lbp1jsnhV4aEfIbymqoc2AXs+GPKoY?=
 =?us-ascii?Q?+4tv6WzHR2fJHttUpyMPhP+CJIYKE3cLYZdiu59+/dHPClq+nEHAITLlD5AT?=
 =?us-ascii?Q?LSPZFEeJXwyRXzLIkYuRtTT7sDAlBhEeX7i9xiKKDiEfUElCotEumKJ8j9gU?=
 =?us-ascii?Q?r9TPuFMt4Z6ArdW5c2CQMgHEZwq9yCDuhWV6zc+6bYhXCOEjQKUxhtcNaDch?=
 =?us-ascii?Q?DR6ThEF3HIAE3YcT64hMndDYyl8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZpUgYl9Bhe3DXYSYnJ85LenFcIO0HjYvqvBAMAjPpGO1xKsi/nM8+o6iopwjyDzFsw7r2RIG2N5dA2M+st4JpiGDzyHlaHm59rTVik//h5Ddl6vtxeOwi4zYDxHX/1jCDNo96Hxsfkn+VNk9kiaeiLxr4STpcuHJYlZ9TPc5yVMvw0+f2W5G1qb/ENRAr1kZFQt+AjJIyk3hDF8RQKmTwvq7G+/y33o8hwpuR+HZz46ETeuZzbSDg1x7NFQScuh5Uoj6SnZpVr42Ab3/Vl5b3/au7NfsbHRs/ZPBaemP07qGjTXHhzbxcznNNQZ9vFSedeb257rnNh9soLP+n9CL1KiSUqOE0QJMWYDirThBt27kz6q1TaXYPtjs7EkFhhMhvw7MbTXV2WsOciKKgASbFtU3DOp7MUZX8D/zeH6iUsGSvrCJwIW1I3GuVzevWPCM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 19:35:54.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f81da1-5bd4-42a5-5dcb-08de7249981b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

Tegra endpoint exposes three 64-bit BARs at indices 0, 2, and 4:
- BAR0+BAR1: EPF test/data (programmable 64-bit BAR)
- BAR2+BAR3: MSI-X table (hardware-backed)
- BAR4+BAR5: DMA registers (hardware-backed)

Update tegra_pcie_epc_features so BAR2 is BAR_RESERVED with
PCI_EPC_BAR_RSVD_MSIX_CTRL_MMIO (128KB), BAR3 is BAR_64BIT_UPPER,
BAR4 is BAR_RESERVED with PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO (4KB), and
BAR5 is BAR_64BIT_UPPER. This keeps CONSECUTIVE_BAR_TEST working
while allowing the host to use 64-bit BAR2 (MSI-X) and BAR4 (DMA).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 38 +++++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3c84a230dc79..b5397a63461f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2000,16 +2000,44 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-/* Tegra EP: BAR0 = 64-bit programmable BAR */
+static const struct pci_epc_bar_rsvd_region tegra194_bar2_rsvd[] = {
+	{
+		/* MSI-X structure */
+		.type = PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM,
+		.offset = 0x0,
+		.size = SZ_128K,
+	},
+};
+
+static const struct pci_epc_bar_rsvd_region tegra194_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = SZ_4K,
+	},
+};
+
+/* Tegra EP: BAR0 = 64-bit programmable BAR,  BAR2 = 64-bit MSI-X table, BAR4 = 64-bit DMA regs. */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
-	.bar[BAR_2] = { .type = BAR_DISABLED, },
-	.bar[BAR_3] = { .type = BAR_DISABLED, },
-	.bar[BAR_4] = { .type = BAR_DISABLED, },
-	.bar[BAR_5] = { .type = BAR_DISABLED, },
+	.bar[BAR_2] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar2_rsvd),
+		.rsvd_regions = tegra194_bar2_rsvd,
+	},
+	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar4_rsvd),
+		.rsvd_regions = tegra194_bar4_rsvd,
+	},
+	.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
 	.align = SZ_64K,
 };
 
-- 
2.34.1

