Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9C2F361A;
	Sun,  8 Feb 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574108; cv=fail; b=Rp5X6atGR6ZKr41gNwHCDSyp4s4F10VBkKU+hisC36lz0vkTF4GxMnHYASMgeYLB7R+Sb3C7/dHK3NUKv/a3Nye6+u2eh03bd5u2VAoExf8WqfKgv6bL6CQGq+s5u+wALlBv/15m2mB2hQ8HYYY7hKrtGdWqJ9UXnSLaUKjYUtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574108; c=relaxed/simple;
	bh=VU5Y/o+5J3vT19aEKRNWdaOfJOZaPeISIr+0aOa2gGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAyEtJ/vt23zwU6ORrjtUHbqE7/eOnUCm00BeeIqF+ENdu80fuoFQTG7LCCVobTDBUVLW/udJUC1uQTjn+JYUc8pXwgSth1cdZRwemr1tkJz4VNkUl2b0ODiOr5FXFNDwVO07U54MZzrwq4498GE0HWSVfXsibfjqx3aJqbYB34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=twdA1Ue7; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="twdA1Ue7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0E4iwjFP+SuzVysrb+OJ6tuOOxjEAlpABvT4Y54oLdwZWU31D8PQqRqOf+qrwTkUWrzg+oCUii2T8JQDZDT9kbAtdOhf/Bn153O/02Dh7d84hjAu1YWnkkuapKQZ1ZR6n1NTxBe6Qa489t5hui7jdYlfSQwUSS17Qv2HnTdUkpsNgoh4MT9dA30g9cNM1Mh6X/9EI//iymX1BW1p1NX3l/13sw3zQAWq9bKLgRDjxqpXsXJTqXpmQXv5HC7HQMuyOQoPaDcuAr1WdcrW2hOqxqyq5pGbYmOGJHvgkWkmGY9UPiM7G2yIfz+9D4TP68zpj1pZdFdYlLXyBRkKUuLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyF7FvjcIXiC7mDzr7ciJdhRhPBzf/ZapVCLUiSFnaE=;
 b=FenQ0xWWapXg/Gjl2PTGfUC5HvNnjAwjBJUsGk97uXLot+fYdDJAUllfWCfdIHQNYeTinT3G4L74oWeHfcIH8VAi0uuRGOzssCibkFLgcbnsgSlJ+rCIimYNtqa7IKLCBLgiyAdbNQ5twPrlQY1RnIpSK+BNujYy9p8imt1UMMioMpEahl9RinxbVqHOlMu8xgQMFQl7wOyYe5AeTPQjOVc0k/RUpm041Horin9qkcd18GwSmzwTKjBRXHp0HWT30dNYbnW3YfjnbjuNQbBu84rr/ul0aRRo1p1dhTW62kGJutdwoxqFoSVQpV5/xIddN066h5kdIFIDqma71L2R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyF7FvjcIXiC7mDzr7ciJdhRhPBzf/ZapVCLUiSFnaE=;
 b=twdA1Ue79r0csNweOPHikiwOnB+G5NAqAhI4bE9yAz9GIgZx0FXGmVPpGsWm1qAbIhqs3V1lzHqtB97cmjyJgaM11cCymfrHCFrsrRDcN14W4oWILaiC2E/qIMtgj3kQMl/S6Xc8wNel/8Gc42880Qw11UrUYiWHZ3cfbC0PNigabfNcYM5TInUoMzcuHOOoEn/G9Cs9ts/d3bVDCIrqNG1BsZVv5L2wfQutFvT5+5q/pvBiKfZiL2mk0yg4AXSjvRw1qd8YFVvwXYZDV3U5hAwRUwVJUc0nHx31Tzbt/fnpRr9W2IZ0nv1vSCh8qEdJKHHSseopuNCbwSjGvjxCYA==
Received: from BYAPR02CA0067.namprd02.prod.outlook.com (2603:10b6:a03:54::44)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Sun, 8 Feb
 2026 18:08:23 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::eb) by BYAPR02CA0067.outlook.office365.com
 (2603:10b6:a03:54::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 18:08:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:14 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:08 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,01/13] PCI: tegra194: Fix polling delay for L2 state
Date: Sun, 8 Feb 2026 23:37:34 +0530
Message-ID: <20260208180746.2024338-2-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 746ba36e-50a3-483a-7ee3-08de673d0c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fjuYY6oMHNf+wgxVs3kFidZadMNiOvqHtJBnG9WGYNGrUELnolIVPfvClVq?=
 =?us-ascii?Q?FEp5iW8qJPj1QkCK4c71U26hMe79w/AzsjUuq/Mct6VXxuQ/wlmfEyZGoWj+?=
 =?us-ascii?Q?oovCW54UcBEqTU31LAHoPk9D553dvKk2Ixc7iTAKTk3keBZK8MdC4QbuejcK?=
 =?us-ascii?Q?AKqwhYhrjC0ULDjYPb6Kb+Qtt2fzdOLXE7QGcxuOI571T3LThDfLhw5G1Fxi?=
 =?us-ascii?Q?SFJCvgBOkE5bUhKRWH6JqdBrfLhhim0wuNPD585ep5oweQWgp5M5BFjJV/l5?=
 =?us-ascii?Q?CZB8TXgMNNACzviQYy2QcUKTtZRlNBwSyv9JkWVKRXXYDVoUmD3Mm20KDQ7V?=
 =?us-ascii?Q?w4TzFi1xjtFfWnvuSVqOHSD6muab8OwNw9JfOolAT1aFnfGw8LrpDkcDqqmK?=
 =?us-ascii?Q?iaDne24IcKje40bHu1YycMxNzNXg3FWMS7RjllqJYndNPSGI+aNjkjDMmxMG?=
 =?us-ascii?Q?nPWOnhMtPFnCpmKx/aUEkV9qa15Nvut/AnnOwm7g322HZtjVruwDEvDFkSQY?=
 =?us-ascii?Q?g5H2hgGIje16oIcoVpztfilkYSbOLz+2ee/hX1tGHx1DDS5KQh02ONJkWg8B?=
 =?us-ascii?Q?nTFaFUUwO/6ziDCVQlCuq5qmEJ16vpe9nG1XCzySxerTufvUF+sG5bwYhTDK?=
 =?us-ascii?Q?9Q8oYVoE3HORCQ4IN7yGyr/9IXFO7gH0BngxaZNZNzl0UDoZutczMpVwyjnL?=
 =?us-ascii?Q?+FzJlyxPZi47douFcWOsVhNOoDV9zGQfvER/wXe19QAbgzKJxJ1nsWVsSl8R?=
 =?us-ascii?Q?Tk/6SJNV9eCB+a+E/3ORwnVoPVNhkio1pvZQRKGF/mGqaYQLfKP0OKa+9WJo?=
 =?us-ascii?Q?GdzLYcNW0kUNOIjVux+t7nHpf5Ufw9mQNNSqHXRmTc4CwGm4W0VXqy3LUDI4?=
 =?us-ascii?Q?Y3RNNNj08vvbWeQK1trkjDlnSVWyco4MGzHR0ubZG+K/Q0Z+yUUOLv3rOnIF?=
 =?us-ascii?Q?H+Jv8m6sBWt0CdlWoEMJGubBcQTc+2bLWt7zp9UcKmIvWkk7OuwvILR15W4J?=
 =?us-ascii?Q?AUg7GqMw6nhBk7m3dmhRUqXyWpsPZNUzYMpKmRWUDniybkMLlak9G/SbtSyk?=
 =?us-ascii?Q?mcNeMWwez5iKnwMIKHMvYMnakvAXXRQ3kL9+c7B35I7DEaBwu6B6T13dg9t5?=
 =?us-ascii?Q?nNuYU+R1XY1GYL9NiiighrJnT+srNm/F6ao0N3+COu7S9YJJMrSEKEQnKMq/?=
 =?us-ascii?Q?Q+BtS6CRMboH6ZwFYLCtWQS+2n7CclYFOlCY7zXOWhqQH3EAvIeRmPlHQeuj?=
 =?us-ascii?Q?IVPalGsf4sjpfl7qqp7hVv6m+rZdEUHXzN3t7iU9Idg2FWUPme6EuEldLF2e?=
 =?us-ascii?Q?kNJrUrNIAcfCKi0ZlUWT3CKn/JiCrJpG2823uRvbISA1vZ0U/9wCS/tHidfx?=
 =?us-ascii?Q?b9/l3EWC3uEshx+rDFSG4mmKWq7gSFPdhRjeAp94XEJkXxd11gtgszaoIREy?=
 =?us-ascii?Q?FR/PTYLJwV1JzL9YW9/k2ZTcxkZxbFDb39shp7Fnh0B5d5+LYZbncqAliHMg?=
 =?us-ascii?Q?VKDYa9YHJWDQZaVZdyuU7NSlNsJCuFxb9Rl+iDrHzheV+h+vTq3KVk5qQmea?=
 =?us-ascii?Q?Cg3tcPC8jU3oPtwu1VMv4oVtz+hex1chhytZDB45DxkCP9WWRv7CaouS0WkN?=
 =?us-ascii?Q?/fNkOFdJyVCyBPI0glWs45UX/D2LYbC0ndOpjRwUCKxTRgsjos4pqB/u8Oag?=
 =?us-ascii?Q?c4AXZHJuXsMrZTCoorrSfM3h9+I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b06rhFMiPQ7CrcblZFaoItdxBqlXZ1+KwEXlxDS/f8HidgT6MoQMuyQ98+C1byg1O5zQGy/wt3ZV739x+ePWAQz+GxCxEOueqjeZaj7medhk9HkF5nLRxy176tfldVKItXM/6ZuxdCI4axk33NQnZENz0tJy228+P0UWmrn0iw9ZH31/gqnZiepZt+UT08AziS96mP9qImwZqzvtZjBGJhIn+v4V6NqGIfjEGhFJXzZ6LKhBnL1WC1U2bNglRqX68lWIx7PcNymIXY4PTb7TsjAKd8wEYUvaFmgC38NfDpkABUpfSZlun9OwoG7yTJSlBhTrmS6wkdPcgagqYqZqerFUnGk2OyxbZ9jMff/W9//U92YO+AdkOSXSJ5s8aT0tBhshYxB7Ng9M9KoPGifUZm+d4hi0IgEDVObqwYEEAhfIeOv002spq/AgH6gihtXu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:23.1284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746ba36e-50a3-483a-7ee3-08de673d0c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

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
V5:
* None

V4:
* None

V3:
* None

V2:
* None

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

