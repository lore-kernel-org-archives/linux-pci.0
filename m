Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497836826D;
	Mon, 23 Feb 2026 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872172; cv=fail; b=kazGV1E1Yr06/wsyuFtqxQKCQ8/p6WxG0mrstltb4arEgt0bvMLXjp4XIt8yso9ntrwM/C05CA0h9E0lC9XIp9ilWYXtNhpere+K2ATnkbfEQCKeiUHHqoJSy5cK2XMfQDI9irxhpF2vb5K4mEVLH9r8Fxszc68/CJuD42RVxlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872172; c=relaxed/simple;
	bh=zI3gtG1RT2KsQQZG9XAm/yknL2kkOm5TYVDg7bFYSYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urtJemfQQoGB4z9XY4L6lcOSMGoWw2ghWNYBZOi/JGQyTvWEpdbism66Ke3NEo4luAQNBlSCgFUzvjSmhgd3sWzbZPou9JLVm3yKXT+n8cZY6bS3ohny6UJ8a8LknlWhFlvVD+JHXGHXPosmyu2/CzUDEhZq/beaQTw/OUiEeqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TosYNOUy; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TosYNOUy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfU6zLXyApKklhYo3n9OnrmVLgpirwCZezFyvVcdM7brQBsFVRf7Kvh8Nn4WsJ2VHd6HzlCwXwysGBZO12gZX1Girk7WWxnCtV9Ue18AiBtZkh4rgjYtps6oKuWcHxRyWdeTg0ogE5TWUFAJC7sN3cgkIEucwVlIaeBDHPurr35PFcRJ+8Pp3yUTMkAkssPKFXoXUdmnSIYP9pDVlk1BxxK2vXFbkZdrIuGbCE9l/Kq7KazCPvg+bICW0HSF2EuDph5gi10+Fza2auqITvBVLCn7qZak15reGEfWBw8VWgQx/I+ZGwNxp4RYq9GnBWwGJlq/Myk9A7H/7bXygZyFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCS65FRQoKw3HZ6dhhNhFp6wXIeHn4mGh8R3v0nI+fw=;
 b=sI+/Jxi96sH5UNMZglO18g/CxZHd6uqQx6Wjcx+81rRgMImFRHBKP4+S/Sn93i4Gg7EEyfkVklmXG7OtI9kwU4n1Z9WwG0pk4PGd6ak+4hb7pDelReMXRd8JoU38YI+XsZWvyXb3y4WCF/jOZd9QYZQGS1Z5qM9Vqqrk9o9LaMmSLPX+0ZAQ4QFfXLajQwHFYFQbEZITJoVlwv+m5feXZzeeQvPnlQtMiImAXOHqsynouvyz2Q8WAhrf0FneiElY83xbT/WH0RdwtXnUpVpIWFQiXjxm8d6h0ZfgrPboUPIkyt0Sq66EkvUlh6dL4J/kKje95YspDNUUIbkecPJRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCS65FRQoKw3HZ6dhhNhFp6wXIeHn4mGh8R3v0nI+fw=;
 b=TosYNOUyVAl2QrJSTbB87xE3ul79S0+O6Avq88DMI9zaMst2K3Ro6MrIUY8KZWlTLz1BI/xDEpX4I7k2D7CspRd69WFW/6/lp1Gz4OlxaEN5lwmUuf9wzDvwXlx+NNIJegBufv8XZA5ZHlxrYWqoIAmhEdWPrvBm0T2qLw1gF4AdCcfpPtsZIN6Dmc/Kjx5G0nrsZCcMGtOuqkLwmUTS+V1EHuw06NONE/Qc2WLgJZ67L7sLC1iDeg7FEPoG6jfSjZ0xL8s3XXMb/4b75IkYVaqfgW0k7rM4GEuXzCycHjx/kSLKSlftzOAIoNU2XCqtxy9lD8dqO4TC50iDFznFFw==
Received: from MN2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:23a::27)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 18:42:45 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::d8) by MN2PR03CA0022.outlook.office365.com
 (2603:10b6:208:23a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:42:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:25 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:18 -0800
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
Subject: [PATCH v6 01/13] PCI: tegra194: Fix polling delay for L2 state
Date: Tue, 24 Feb 2026 00:11:39 +0530
Message-ID: <20260223184151.3083221-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
References: <20260223184151.3083221-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaae2dd-c9bd-48ec-ab5f-08de730b55be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Ktvi6ctbklIdqjkjzql0viD9RJrTvX3ekkMRKTpnj0bCZSf/h8Qx9meOVvH?=
 =?us-ascii?Q?NqJc+NsvuDuOoJ39ISXOdJxpqAspdkNIxPa0iDhP1rigH7iNzpU7cnAaZM2n?=
 =?us-ascii?Q?X2qg9qmvW8MdCmZ54PW0iXR9XE16u9thQOeaQhrmHTb+1irqS1VUJYfqw6i0?=
 =?us-ascii?Q?uHHPA3gqklqSjbwoBpYyqVzvw5HyMlZA/GdD/0sckK/Pwl//nM+cO/RmDUt4?=
 =?us-ascii?Q?pt8EMZqGloAuydkY7r0ouFU7iyyteuMX+6OvQ0ORKyPtmkL5sHzQNzbxc3Yd?=
 =?us-ascii?Q?aDO7FOhu/OATjau4v1vyODUWfJ2hINLzxlIyRRd/HmXSOrEI/Fi1LIK48yAi?=
 =?us-ascii?Q?dOZLFiVEIOuZ8esuhZVTYsnDlbwbY80Jyy1/MEXh5n9VigwGTcsG1gvYwBaN?=
 =?us-ascii?Q?mArigt5zOLERXy7PM/WBKSnm0rITCdcO6aGk/qgaNRC1AplE8vLlaPAXJg2Z?=
 =?us-ascii?Q?ubR/8mpIbDMo128GpOHYi+vDPiffKr2VkQh0RMjAdUG4sgiMZT5dyImEl+aU?=
 =?us-ascii?Q?bSoezmN6rE0mJnhdzWowafQaeESfoDFRHth2lS1bkr8Wq/2oul8EopbRnP+O?=
 =?us-ascii?Q?WMiHcQu4ryHT186zlO7GL3dtssHzLxWVv/A0ddckm311SfJZNPk8O94VUlvd?=
 =?us-ascii?Q?iCJFkLW8lg11umiMnnvhsXYvCOTkcsGmBthtTCON8jBWKfbA5uzgImMby1Jc?=
 =?us-ascii?Q?DuRCcLVEhvgjYYDXSSMt33yhvvBG4OeooOpvII4JN7Bh9OQF6gRqmRj6bs6X?=
 =?us-ascii?Q?cvAnnAfWqT8cGSkgMaAWCSdexB173I4EzdiZFLPmV19FQB+jAkB++6dq64mC?=
 =?us-ascii?Q?+WnHJIWa2GxrPCJC05tRewiAnXxxSrJpAjvOdrq30c73vcS2cnhR19q1iI0r?=
 =?us-ascii?Q?DPlciA/EdIhIcSb1d5tbosx9i4sBVGBXphBPPxhxOoZrJR0EFzxN904+mL6J?=
 =?us-ascii?Q?hhJcTlRSXCqTW4vNTWQxumd6ZQl+IfJTSKnSz8zFIFoxq6UYl2VQkjP5G31B?=
 =?us-ascii?Q?LSCtnyyr05JCIfNvxVJimFSIFDrc57OEuLIn9fEH2FM7quZIpDRI5x/raB27?=
 =?us-ascii?Q?uIJL8FG7o7QYcvdpdEomJpleITFUGDSo9JTkLDQMWRpATert1wVdC7Zw2pfl?=
 =?us-ascii?Q?3h5VpQEY6/Gdgu2EZq2reYiZ88AQaSKKfzJy29PEbXWUa+1V9MOowggO+yu+?=
 =?us-ascii?Q?c2crVTHI9lLZO9dHHmH9boQctE5n+AMHDJWNSImHtH4CC2g2D2xXbLjJuf5R?=
 =?us-ascii?Q?G+CI09xN6IYhuxMLRMxDYbe9/zCH530Co9s5nJ8Rs+S02BeGEPmLnkRMvaGo?=
 =?us-ascii?Q?PwnzmgVBvf1rCkERMCiKCiQ9Q5Sb2J9tDP/eR8B6i2tbFvuk3peNnlsPMn0s?=
 =?us-ascii?Q?o1ULKxWe4SY+hH+SzIbmhTowcqP0HsV8+RorQ4p7AQCFuilRxQ9GbL3MrMoi?=
 =?us-ascii?Q?oP8eAk52iTpFgAy6sNalBsods2lhOOiq945hPAV/vozhyvXlM5AClrwUH9qO?=
 =?us-ascii?Q?uyAgH7VzbbB/ytn1aOM50lr5+0Bor14Yu3qh29C/zNwAmIkCB5JtKDLu+dyb?=
 =?us-ascii?Q?SJXblY+2+/qqSnRnF+koEKpuxPi079QnMCMWO7OFOuVtExWWFXpSglMQrPTW?=
 =?us-ascii?Q?ALNkdIZsEW0Jm61HM2CHkkXsMnKA8pVPI8hKrIrtjev0e9sEKEcswrA1JyfV?=
 =?us-ascii?Q?zuR5k9kfsLPGp12QPJRitVxzAZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R3wjMHoj0swqq9a6YuJszACHSa0EWNPIJ+jMgu1wi21A8GSaIHroDb50VRv8YmF9itrcrAc+ptu11Iv2vNLcbZPDixnFVS11XhVVrxjtIyWT+QB8lZW9NE1KnQ8X4P22VLEf3UUKPUhOXGg5g1xUAmGkj9XiRxv8yCNwpfsihlDDNUpymKw21f1VRck40T+bZiywYtn/bfWG99GUwdqE9gTY+Eb+VrvQOK4T1h9//OfIWLFG25K1Tpw5Z8jWuVhg21xXWiv5JVHOOpuo6SFBJtDAgMO1hBJPy/Ta6RRfcy7VPMI4k01Kxu+NyOT6r70RApKS4Pnf3oYt6bex4N07iRv9IUKrVy41D7Zf9gbtBidmeGwbMB30wv6XJcbc5+NQC24vWuSPkeuRLHiLD6lIPaNEw1+fv5i4SWkYkuw5VyQ7mp4i1WQPaIw5lY2uhPY4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:42:45.1645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaae2dd-c9bd-48ec-ab5f-08de730b55be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe spec r6.0, sec 5.3.3.2.1, after sending PME_Turn_Off message,
Root port should wait for 1~10 msec for PME_TO_Ack message. Currently,
driver is polling for 10 msec with 1 usec delay which is aggressive.
Change it to 10 msec polling with 100 usec delay. Since this function
is used in non-atomic context only, use non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ddeef70726d..96d38571a7e7 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -198,7 +198,8 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define PME_ACK_TIMEOUT 10000
+#define PME_ACK_DELAY		100   /* 100 us */
+#define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
 #define LTSSM_TIMEOUT 50000	/* 50ms */
 
@@ -1553,9 +1554,9 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 	val |= APPL_PM_XMT_TURNOFF_STATE;
 	appl_writel(pcie, val, APPL_RADM_STATUS);
 
-	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
-				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
-				 1, PME_ACK_TIMEOUT);
+	return readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				  val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
+				  PME_ACK_DELAY, PME_ACK_TIMEOUT);
 }
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
-- 
2.34.1

