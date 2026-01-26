Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956103126A8;
	Mon, 26 Jan 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413699; cv=fail; b=ow4S6jvNk48//WZeDRjUN4AfA+xqaRRsj97Rubs7twtxroFZxMQ2UyxMFtrGwHZ2uzAWT/CeJIwCAEy/5eps4R78l8HjZ9vgsJkw9TSbGI+AuSh8M41Ipb+cAbZ94qBQ+hlA86BUDtAT5QEOHNq6APY6qPOMcoB6K2JD0VLJf0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413699; c=relaxed/simple;
	bh=9KoqNnr06wlRM3ABzBPos6MXqJnKJz1gBqO49ZkBfL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP7MfRZfWsc5JccTkjSmeXVTcdNyVL10hq1uVfCEvLrOVtFZqCRMqYC2irNTFiXO27sIAnqy+mrSwUOQyMzhllEGfOn/tvduxfA0zYZwzCLRRvJgnM3ay2l7UF9oEtXh4Cu334ef4yt7TCVEX7k5KDKmtBG06syzizTpGWqiTMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPpeSFuj; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPpeSFuj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvJqwn31qbtX6F05nKpKYssQVZsaFSGqZs4kEBPu+F7CcdrSArvPmDV6sT2xCZI2wx4x8dh3jwfmp/RnWab7qNwEhfDvCfXRPh7hOSLI9XKwfPz7B9ufUWi9tTRQqCNs3Fn55RAa9cAT0dj2Do+Rtu/yevenploX1ak5BPP3jcJDbi52hMdZb6fQoCSycROzxlQZseb0tOyRUR+hJ/j/11oUHeoflNRnD23ADCndCjWUobHba2a0X6Yu9YXGdCr7mQiNAhcXgwuMFFkK0vVSC30XisGfgxD9zW0wpHElyzdGmIo7MjRvsTNtkBk2rXeenFSsiRYZ3ozjisC8e9EKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMuy9Y3EXO7kUtU/j7zUI8x7LPuKFObQew0mEKDHGDk=;
 b=huL8EhSKVQGr0CxJLTeA6viEr7mbT0Ht2NNu47npacxUk1Q6MWf3eS6iSbZS7or0YZh+j9oLPAtwAcb2HHlSLjZS5LCp8vx/Tgx03BdmrkcZ0rvFNKqYlvq+5U2YMgE260arQqUE4Kext8U6zGIJv09uVon3SYDZJmDMYqzrlw17pkzLPmSwWo/w7C6KJcxP51rutVsBQeE99o2/vAZiOxmpzQUsrOl0i7wbd6NDaxHPmzpCmdJKVEmc3obUmdW8aEFrVjrZ4FkqFLA6X87t+Ec8cHAjo6ZCzKv9rZ+gTjOOHJ86tf/4eOjkIEfwbrLjLs2sNlDeRZMDQ4UYvcSwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMuy9Y3EXO7kUtU/j7zUI8x7LPuKFObQew0mEKDHGDk=;
 b=pPpeSFujaDkhuHSXpQGxCF6nAleLS1pyWxckmt99VVtSVfNBDv/Fcebx7LyglXg4SJLcDj9yQg7yJDfnISJzaWr6MFpKMe189SiqNV4p6JrzFHXCxnporHQ8PufCA0UyPFg5F0XrIycD2Ry3hPvCj6rqUNDangMTKTRq7fMHS6Y0yZa1BPdcpg+ZG59rR8+iBo7gcFEfzOu30sAvn8ntwt4tfXsNFse7Bqzzl3XqABDyXy23QA9bVGLO3oXW4iCiu6QODZ3aLcNX2Aiz2Uq/CfJOYg1pjrqF7rAj9BBk6r+vnYPsmK3YK4IKWBIdnlM0u7qET8dhS3yJ9Uizx6YbpA==
Received: from SJ0PR13CA0072.namprd13.prod.outlook.com (2603:10b6:a03:2c4::17)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:48:15 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d) by SJ0PR13CA0072.outlook.office365.com
 (2603:10b6:a03:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 07:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:48:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:48:00 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:54 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 22/22] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
Date: Mon, 26 Jan 2026 13:15:19 +0530
Message-ID: <20260126074519.3426742-23-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b225c0-85db-46f5-cf23-08de5caf432a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g069VGBv+28uYYmxc3E0vjR5iMJ6kZtt3nRdrTSxIoxKIXfYEKC6Lleu0SEK?=
 =?us-ascii?Q?5pWmilvIf9hVXX+rt7kxAZr3Ru4lHE1VSZiMPyXFyL6wL9KN4BqYxxXm0XsO?=
 =?us-ascii?Q?q+HC7m97A53ARPi6Qfb7+7kVFHRe6Owk95d4QSgZlqPsApm1QtU+4Dyhuxg2?=
 =?us-ascii?Q?g+Jfwrw3gG2MbZpa7MD2iSVqWDxn6Mm/KldOFYimPTd3Ar02wabuSFjoJJpq?=
 =?us-ascii?Q?WLd3yXHl6OYrjQKvF7aJUubSKBidGa1MAsKDE+4nIZJeIyVzI3pC5f9X3DC4?=
 =?us-ascii?Q?cX8rJOV9icpJIVX2IW+fy8EaS0IBbCpwxXEhPSJ5r0AGGM5UIFx5wmUpqAGF?=
 =?us-ascii?Q?JRnlzwbDaGFQokV65XgIp8C6QfyV4q1+Ash/ZSDRg+99/mpfrMoZ4WC4PHbT?=
 =?us-ascii?Q?GsNuUkV68LiYlE+hU/eFZR8f1u0lz2Eif0lMTaeQJSbnDOomOtRe1btR3JUM?=
 =?us-ascii?Q?dtMTXm7QlrgU9u0MZ7biPMgymZ5uF7S37FMdiuDHNWv9VpjsmFbVEnPT2SRt?=
 =?us-ascii?Q?BPszlNgoAQQ2BKDP3h3GsNg31G/vtb9aBHp40QJl21j3MjxURK2ZL4Tj9yff?=
 =?us-ascii?Q?3GFlpF5jJ2euAHYDfKC8sLcr/s1HEAvpYtvcAlX4G7QJZfI1KEG1TYtQe90d?=
 =?us-ascii?Q?oGQ/5096nWq+Nm2rtjjs1CEC+f1elZ/oibqhHrkjEDd/+RYhq4o8YmMer/+c?=
 =?us-ascii?Q?x7vg+W/5PCLGAKRBXuYp1+Wri2RNmI3fS06F9lub9Bkyv1fxZR9MJgJnEWU5?=
 =?us-ascii?Q?1mKSK0MorTjpHdU28D4wRz4RIPTEbe5oggesYx88/Q/vvpz38n0gBY4Mmsmg?=
 =?us-ascii?Q?6Jke+V9b3w4xF1RXLDPDphTnDfyjgTmU33vMnaqtq/beC07yettn72+OXClP?=
 =?us-ascii?Q?oV0SFMs37sMWSsE2eN9Pu1iqu9OU+0YG5QVzI3z1vC9lBWM8GuipdPMNkg4t?=
 =?us-ascii?Q?/pQiKJZKtdLwTsM6rCAn4UiiMhRr4g25tdR5wCtcP5f14P6d2HbebVesp1nm?=
 =?us-ascii?Q?+2cdNmqbaSELWeTnvCEeYI1/gqlhm3hcp4nZmJWONj0gIpOYakJ5BRFZaY81?=
 =?us-ascii?Q?Bc2AEdpA2fW3D493q8BKw4vcFbYsvAM9ixng5AgqtbZTPCZDJdOpIVB5Di26?=
 =?us-ascii?Q?dBTqOPmnEbzF+nV4ODUrh5ZbhQMigjbCOkoX9o40GgIIaznXGVbQGwzVovej?=
 =?us-ascii?Q?/6Yg/3T8QcOyjKeE66LKgA6qbvevzIxw1R0o3Kd2MUlUO37sskWvnVKhJRn1?=
 =?us-ascii?Q?a2z2KdRjEfuFNj/Sr5NFO06/tnHgiK5aE5U8RmWYmA8uEOgbWy222bLq9X9f?=
 =?us-ascii?Q?KBOv14/DNLx1YRJFhTiqWkl3zYYuF0jJgeyLdNLYMERiXBJb0cCydzkJKxxr?=
 =?us-ascii?Q?iGAERs5V4pVztai5FlF82C7hsvqreOQRN98axn5fwLppNOYStb24FtCaLAvs?=
 =?us-ascii?Q?Ow35emijsip74C3Dk8PP7xBCv7yQHiL7THQPjmnAgF16cRKLxxtEXUKg97RQ?=
 =?us-ascii?Q?cAZkoYcCnlznLiRjuEVBzWBr2/45i0AvDAhjnNW5hSu6ROIWN/VVdcEdRzII?=
 =?us-ascii?Q?2KVSEQseZFQNOys6aLvOIRrVT2lD9w7l6jfyN+b8so73/U8mAAMTrmG7JiUa?=
 =?us-ascii?Q?ZqMwLWOCeDaYsXqNkSZXf6opXEYRQaAnt+FpvHxs+POqqYgKPmzDS1wgruUu?=
 =?us-ascii?Q?e5QnZMhoAd9Am7pJnJlwny+kw5M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:48:14.7753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b225c0-85db-46f5-cf23-08de5caf432a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8

The PERST (PERST#) GPIO interrupt is only registered when the controller
is operating in Endpoint mode. In Root Port mode, the PERST GPIO is
configured as an output to control downstream devices, and no interrupt
is registered for it.

Currently, tegra_pcie_dw_stop_link() unconditionally calls disable_irq()
on pex_rst_irq, which causes issues in Root Port mode where this IRQ is
not registered.

Fix this by only disabling the PERST IRQ when operating in Endpoint mode,
where the interrupt is actually registered and used to detect PERST
assertion/deassertion from the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b0964f57e8f2..553028a161aa 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1060,7 +1060,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.34.1

