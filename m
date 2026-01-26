Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D1311956;
	Mon, 26 Jan 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413621; cv=fail; b=cw/GGPdxc3Cykx8LHVrUHxBnZXq5SD+pJ3lv1pivNj00n7hm0XrNXBtWa8fMmY8EeUuwN77WwRXrCc9Oo7KakSuGmxJg+fepMnO3SFnxof0knF1GPHZXzEsXzFuABGnN9hNyrz7rWobYY67g6IpUA0NpPgeWPXdTXU7DpsesVoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413621; c=relaxed/simple;
	bh=4Z1tctr74KUkPO0/YrviH4UZOJP3NM8N2n6anAoV5zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3t49u9txUz3oVkBKjbCFytw1i5rgVDLz2MGousDAFaWy0ID63YM5wppjYz9yAFRozWjaCQqi35pYPF17w5Wkd3ubc24WNqAy2SomI6pMbjEi0dHxmr+M+O7dbDIRRfTb4G8WSfCzp/Uu+myHHNs88MLjafVNs66taW7vsPXehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RKECMrNl; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RKECMrNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFtd2rkTYjn+mun+d/sJOlkT0wui6Ryx4d+GRUipdv4Hd7ppMmiDLNHMKJnoi+MLHOf+ToACsND4EeD+7qmBJ6zoT43Yqbvvya+v9LucH3XEhUXznSrEQhB+9pLxlMWH/Jg7X/ioZ6l6ZmXAqnqMiGhAM3f4Y1rATuk6SnahMytdc9Z8DwBh35Kqk1KKnwGjEGr/pgcgMLhiPWlwIcD64XbkdVKrfZ/kiZ0/H7PRgf1Rt7yVwd7nVp4iyjUOfH+FQ6OjxPNzk54QDBF4jeZo/GIMqYGhtFwBn4Myprg244NS8bpLxwkIQ/t0YO/4htzTJIblSsqAFEVpZ1db8Lvv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqiQB+58w0Yd8wgSX87KeUdJSiW0Kffs5Q9WNYgs6Xc=;
 b=Z7Gv7syqMuXdwxpr1yeKQ7liGG6ojRlJx1mHNOQmc8Y9/UlgAiF+ByhDu1x7i2ZynnLXUftI/64P24wyJd6HgL+tpO9LVrxdeYxvJillwbs4i9v6jLJ2BUo7A5zAe722VOxlOlD415Mic1snHW6pG8E72y0CYja+ZbBRlmw/289FiQPN6cHKhCZgCU4zuEYgxRcJ0ok3iYT9vAVfGgTaClRAiBEQYYX9o0VbW9wUwpPK7RDPGxsyZmhlHpivcLnRCJjtjLU+YXJ3PxEUtnuaivkuMXlxKzsVtZnK9QIk/k7GAnUOYb/P/qw6XClTuOkbczQ9PXQi3dPWTnaf0QmY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqiQB+58w0Yd8wgSX87KeUdJSiW0Kffs5Q9WNYgs6Xc=;
 b=RKECMrNls8G/EROG1oAAie2kUc40VysLm5GDO/6xF7FYD5cq+jnRYJeyXvxR7xvoHh+6asd84jHmttIw/VX4tv0vyMO9Z8JVWeks/H0BkFSucAzPvJ3nJfZ9s+zB2REO7V/THSOXoG/rX16zKvdlyerE/9HC3IG30AODuuP3vwG2Nu/fTBxc2gxA8s2xp4dH4vMg4t6B5fmQUx9nHEeqigoN/2UZ013H8nFiSwzLjziNQfqJEHy5J99RqegHwif+7pFC19LWc/xTD6r4Yee6BveEbxHPVfGDFMlEmIL4t9wKe3QmrSP7pIrUtkCj2JpNF1nzaNxJi2cBUD5Uxoh4LQ==
Received: from SJ0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:a03:39f::35)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:55 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::38) by SJ0PR03CA0240.outlook.office365.com
 (2603:10b6:a03:39f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 07:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:43 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:37 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 09/22] PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
Date: Mon, 26 Jan 2026 13:15:06 +0530
Message-ID: <20260126074519.3426742-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce1d196-e8af-42b8-c397-08de5caf13cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?leGFZel1aKLnsftNpwhkFQbgGc7WUs3BaCSnxOv+phf/chdhB/nslTYJJN5C?=
 =?us-ascii?Q?BuRcpQ2rn3wmrvM6M3Bb+4R/gnlV9rV26bING9Gc7SP1jokEsZ2WpRnurTxz?=
 =?us-ascii?Q?Y1yUBGhSZw2HM/7c6i9hnEhILaPzzrYZLS2UlJ3W+11I6vpor3eN5HImyJN7?=
 =?us-ascii?Q?5MWSLFUaQVPGZOlkcDXTzEWGEpgkQ3oFiK7IjvbhRz68ntvb8gwCkD0fdpPW?=
 =?us-ascii?Q?LyR4C7RGqQSHDjPzuLZSK3wv1eP4b9F5Ul5oE7Fi6cdFg3ddYEBUTViOPUvo?=
 =?us-ascii?Q?KlYpgoyKvSs5aMiFYAkwOqQQHPhzUmZM/eHz4FEnmnoA8/LwB9mOrJ8DFUEo?=
 =?us-ascii?Q?8dTqc0Xl+D4OIioyoMdVLypyl9x7GACbgFZtEWaK/QvW35swRs+ABiI0oDNR?=
 =?us-ascii?Q?XzKOBUmTq4wGWOawBvAUdJA+kFvKBa2DdUHXgcn42mlE3Mg3WGcLXdeA21RH?=
 =?us-ascii?Q?zusAgpycnnZaKQSofJqE6BkqDifOiowz57PsMm7OU39IQNrv0btO0j7fSiWu?=
 =?us-ascii?Q?yaQohTUq3hGgCRiHjmyy1aPZ0+UvRsbOjtkevndt3g5xcYvWs6BQ2v/oSS/D?=
 =?us-ascii?Q?miEipCC0VxyancYZxeTR4RpIy8XpdpSWaJxtAo8/3cDflo/Vm6jpc7Ooa7LN?=
 =?us-ascii?Q?6cCwjIiuF4wQap4kUr/97yvbuZlpfa1h5fyMZDDqmtH9c/trni5FBTFWVA+7?=
 =?us-ascii?Q?PVn1jLx3GdkiGAXtjsoZvTS0zMehT9jNzgBQxO/1SXMDLjMHnbN/nnzKcvg1?=
 =?us-ascii?Q?C6AfqHTOIvr6eC7s4X0rlgddbkNW2nu6gZkCfAQysTGRrYoQvi1TFkUjQ8bD?=
 =?us-ascii?Q?h6ypMa+KTHzAocR9ZUg5CTSKgU4kT/S0tbLN3d0Qz53STBZEKh/40EyIqm52?=
 =?us-ascii?Q?6cFGKHt5Kri+ccZm/0L91CVK/QvpPbqeWVIx3r1x/kDqepBzdfwgStPpB+Nq?=
 =?us-ascii?Q?5WgH+XTujAmdBx5Ws5IxPneDQbbpczaYyMwJAsvXB0kWa3sYl1dbjXWs2uXk?=
 =?us-ascii?Q?x60X8TDzHHY83pkBMgQgJ5kY3czg2gf2i4tn3jJU9FyzgmXk4ODdrjkQlRlB?=
 =?us-ascii?Q?rIhsBAsqTTPPihfUmBiOcA/KEae8aak5432Yt2nU7/+UOrHHeiQ2zvqGkfwj?=
 =?us-ascii?Q?XvkHDLg9IaDdvXC9BvvAnPbjoz5V0uNt14Y7eVpN/WQ585Q53Vq2sbRP0NwV?=
 =?us-ascii?Q?m7IiNnQK3aq11G+trNHxBAyi+d4PPMIzSvd37riB1YIKORQGfD0AspO1sh02?=
 =?us-ascii?Q?YbulcIxej0q9pS6kLqPOwmOY/n/naZi7cLVZ+c5Jz/Pp8Y1snhL75zFuOToH?=
 =?us-ascii?Q?Wi3wIfHwIIgEB7hTspgZx9xYjUs7goVLr5mwJJbKmPS40P2u/9ylN/ykN2gk?=
 =?us-ascii?Q?p+jYVtEfxZJcTCZWUeQYUuZhdpjuqCOtpA1wvBWXoqDOZkgRRpOJTu5BcJqK?=
 =?us-ascii?Q?6iur+QaxNjYJq+TyZL5+JLFZ/7XNe3CEB/oUtOPFoXC1mq5hhx8d9X4Xn0ro?=
 =?us-ascii?Q?bQJ/HDLO5tAJyMtzNHo4zyP+oG12QQYmZecfAyre151VgcjHKavfZJc2snzx?=
 =?us-ascii?Q?U5sR2tG99sBV60IvZXDuhPfxQMTbmhFiZ8Gy8iRt3TJexMpYVSTE+xuvy3hv?=
 =?us-ascii?Q?S8gBj2HcIShSuORiLyNClgjHSWZ6v2h2+0v0QN69tBrEHYaelo+tC6zmqVyt?=
 =?us-ascii?Q?XO9J+JnXElb5dvBhMaxTJeMe/9s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:55.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce1d196-e8af-42b8-c397-08de5caf13cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

From: Vidya Sagar <vidyas@nvidia.com>

The Tegra PCIe Endpoint controller has a single interrupt line that is
shared between multiple interrupt sources:
1. PCIe link state events (link up, hot reset done)
2. Configuration space events (Bus Master Enable changes)
3. DMA completion events

Currently, the interrupt is registered with IRQF_ONESHOT, which keeps the
interrupt line masked until the threaded handler completes. This prevents
the DMA driver from sharing the same interrupt line, as the DMA completion
interrupts would be blocked while the threaded handler processes link state
events.

Removing IRQF_ONESHOT is safe for the following reasons:

1. The hard IRQ handler (tegra_pcie_ep_hard_irq) properly acknowledges and
   clears all interrupt status bits in hardware before returning. This
   prevents interrupt storms and ensures the interrupt controller can
   re-enable the interrupt line immediately.

2. The hard IRQ handler explicitly checks for DMA interrupts
   (APPL_INTR_STATUS_L1_8_0_EDMA_INT_MASK) and marks them as handled,
   allowing the DMA driver's handler to process them separately.

3. The threaded handler (tegra_pcie_ep_irq_thread) only processes link-up
   notifications and LTR message sending. These operations don't conflict
   with DMA interrupt processing and don't require the interrupt line to
   remain masked.

This change enables the DMA driver to share the interrupt line with the
PCIe endpoint driver, allowing both drivers to process their respective
events without blocking each other.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* Add more context to commit message.

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 40f9e1ab03c1..58f33e7bd5a8 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2277,7 +2277,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = devm_request_threaded_irq(dev, pp->irq,
 						tegra_pcie_ep_hard_irq,
 						tegra_pcie_ep_irq_thread,
-						IRQF_SHARED | IRQF_ONESHOT,
+						IRQF_SHARED,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-- 
2.34.1

