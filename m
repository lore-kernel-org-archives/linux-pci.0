Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E34369202;
	Mon, 23 Feb 2026 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872210; cv=fail; b=nmeUGx98uozztgv606aBGNgWQQWr7eYbhd5ksZ0FRo2dO9YocXHVEA5ozSZAWtFeynA4kno8Xp1ZwpXTOWEJuHuhuQXyIKDQJVJYPzBC95bZa8i0eCzqhx+90A3J8KULLI22V1+xF61u6j9MhPKYf8LZdLvZNXIYpeIHWSeQjzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872210; c=relaxed/simple;
	bh=cduNU+NgWWvquvOH+9RUC3nSXoM6ja1TzJo1MgH65Ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM35H+eHxP6pNJQxFaKPpIyvOmSHUZU0DTLRrYgFFsmEEEuBHkuHe1PZSBrIsw+xaKbFkiOhf/EMUPmKW0BHJ3i6L73uoHjHKahWOK9yPkUApkmUlKYg8vXh3VKEppNJEkUc9e6hYO7hIumqRBR1xeeLiKRr00MUtylGCKCYfsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1dFrEXv; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1dFrEXv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yusVMZ/A9JQiMO3dg763S7aAvRmdiobA7d38u5pXMtFPx1PwC613pDEFS6NMhR4OROeO9vUhl62EqeAt6Qh1ebXtmkBIDin/M/bJGfl8BMUncIxP9sy3gQIx1CF2ibL7waYKwBeiVQZX+8HEyUeCiWmbyUv/byNwVizHV7Q5qodffQMfiD89h/SGJ7yo41RsGCDtKb4xaYfQFCC7ISetAYpMRZeiLzWO6T4at9B/CexVBeLFz5rNjUYoZfP/s8IebBzVSA0ijkBDERSfHZpo6DWccTY4ERkQSRNvXuHvyqNgiTEqmca1tBe2CvdwoNI8OTAmO2Fep9o1FzBrr3KI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nWsmCSfbolRrRZWfKnHLNh2Ds1vVn2+92uLqQo9XTU=;
 b=AGCP/9pTaibqQkpgmtGqXw0JQGjxCLf5AEPDwK+l0hDcPSV5zqN7QYKyVgYosCa7UbEaiYqETRdAWSO3AqjmiUArEZWg4VY3fJlPyWCYx2TbNDksUzPTMRQuFLWkXKQxb/r725Cg23lNzYbwYolpsNMNr8WYuxZQT0XvtLMH/tWyK2/+O5ZC8mLyF0wf6/MpJhXjAKH68jGCMtL0hQfTY4yY7nDWG9dLLBPjEk7e0/hk9Kir8PmEvNUZyrPMio8YSa4zC1ZP/27UXewRm95KELHjLJIUX/iJD8bS4KckX8zYS48OtZ7fy2xRMQrulzv0XbdTIEUq7+sFFI+nGFJglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nWsmCSfbolRrRZWfKnHLNh2Ds1vVn2+92uLqQo9XTU=;
 b=K1dFrEXv5wulWa9pY+xvKFimtIGhCEMVWEEZRKHV7J6heTCNPLZ6lKe92LblcsOoXyB1mP20KKiO17XE5DJtgdQ8uucWnWPVJDcLWXs0Xb46+4Wc0lRQ7MaVVu2Qmh6CiqKJPaNlOf9iBhkolbYkeI9vyPjQWGtkNzxYyR23eC1ikSSMXGNNSpJ9GfGRRjln0ZezC2F0F+cTuTBYC2G9YbxCVJNd1OY9iJmT0xMHPDGdCEK+rjARURxfIjtM6o5R66+SZ5jtwqjvg6b3b+KbQ5xknY/8S4YorwVHUvsrYvUJugkvCbxVud8R7Ps079jSvLdAcYwkK+bVO28kafRezg==
Received: from BL1PR13CA0301.namprd13.prod.outlook.com (2603:10b6:208:2c1::6)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 18:43:23 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::35) by BL1PR13CA0301.outlook.office365.com
 (2603:10b6:208:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 18:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 18:43:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 10:42:51 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Feb 2026 10:42:44 -0800
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
Subject: [PATCH v6 05/13] PCI: tegra194: Use devm_gpiod_get_optional() to parse "nvidia,refclk-select"
Date: Tue, 24 Feb 2026 00:11:43 +0530
Message-ID: <20260223184151.3083221-6-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5a94b1-01b4-4369-a16f-08de730b6c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r5jq1MBM8wLf06x2JAugOOMuh2I8b8Fbe82OlXOvSB4rwRTaXBS649agAlI0?=
 =?us-ascii?Q?xdyCgwv0bNDAoVv6VBZTf9zerAvesc0ziyJZGac9dFuPlXCQc6d8rqrhdTmT?=
 =?us-ascii?Q?MAet493febMM6fzWMayfR7nZSbfqmrgnf/K0l18RC0ttL2vvobLhZ6EfZWI5?=
 =?us-ascii?Q?RQUjGjC2xddrvGnt6D3VCyS3tk+m9F0eAEQFrM83kH4Fixsob2SHB0qBhXJF?=
 =?us-ascii?Q?y4BbDfSHiYo7sCvmo6bidHt0ZHSa1Mytca4dyU3eph098EKyZKxqGwnA3ZRc?=
 =?us-ascii?Q?A7FwgTMFoVfwoBe3xt5RCGDP/TPykQ+Cq5zeulAsVNiTYy6lRtSZFRDvfx0E?=
 =?us-ascii?Q?JFnQ4ve1GoTGCEra3MdDFnSp2n1n9/ybTM7J2ErmyDk6dk1Ue0T5pQHuGgpH?=
 =?us-ascii?Q?OBvNUVVnFPsFky364YO7QVOA75gpEl3DaZLStCknnDEixUV3JVSLah8a8FLz?=
 =?us-ascii?Q?l4LeMROtUJZ83SVPlH8MZF51/HxVauvVnJXi4xueiCvvKpgir/MAdLGUtzoM?=
 =?us-ascii?Q?JLjkJkL6cdDkLnmck4XbswYKwrcnoPufFSErT3pUUG7geG/p1iwFfuUNAw9B?=
 =?us-ascii?Q?sP3adkvQWVdMNwF6HQUIoKPGFCcssJscCcWIEzo/i3hfDCJy7asRJyUd0Qx4?=
 =?us-ascii?Q?3qJfKXsLqWBJLwuoHFt8Go6ypFWAOu5AZ/V9jz+YnELBAlXRGeqECp77vjss?=
 =?us-ascii?Q?16htTuUGmBW/dkICalCNiH4aGS0EEbC75+QiBGT84F8Lw/xg99VvrdsBVAxc?=
 =?us-ascii?Q?DcrYfzCHB/q/tRhXcPiaus33k7IaqHfUtBjbcOMu70IIj1X8W/sqVvA18hoW?=
 =?us-ascii?Q?w/DA9dzyk8xS4iRnYO/VhwWaeqe4X0h5O6hE+IK0pFl8ejbwwxv43K3QCwpc?=
 =?us-ascii?Q?n+5fviby+BduM75BU+EwOat2DoImCyu9tPOf7CMZkhZQrQOWv+VtRAis1iaQ?=
 =?us-ascii?Q?gjOW9ezgmcdITRVrXX8dONlOv72T9qQGT5OXI6XiV28iEGZjLUHA8iiEfjDH?=
 =?us-ascii?Q?TjZxBWBNirMb9DbwFdAD1tXfp9mf6oA6HEgqDBm8lMkxIvnPIJe/touSA/G/?=
 =?us-ascii?Q?jmCXl3AKoVzqRHFS3ekdyTTmmjRcKdyBXNk4VtjvhqeBFgTZTHlNEYh61wvs?=
 =?us-ascii?Q?Fy8ERaOS67I/uND2Bz7l6oNkEJT++AhWLlWBIMjuYopv3zt1bYEdBQfuA4Sa?=
 =?us-ascii?Q?KaHiCAH53KvI563S8Aw9JEEqpi9FBhVZokecetOit9EOUTumHaZRbdPKERV7?=
 =?us-ascii?Q?7UL93iY6vuyskFfI63euhbl1Pv8l00oyzh+M97bgjCdocC1O/wtb2XGT3EbS?=
 =?us-ascii?Q?N1YKYaZROC+oVrxtzbqeBrcVlcGX8ZQ2qiT+PPBYPuK4nBPCAgOLF/hERggH?=
 =?us-ascii?Q?JFSZa5X5ZXFy8CL/rjcgqxDP56LXJBL4kcyEd+dWxfOg9u/WiXfiaxjfLd0X?=
 =?us-ascii?Q?IepCyL5uM53K57u1kUoiJR9/219/A9wiIRbE0T4N8zv1qcVN8K1kuQIMyHMq?=
 =?us-ascii?Q?HFKjWw/dndzMGIbElE9qy7YvktPQDKdOmLAPA0rGY6E7oy0l8aqWYH9n4che?=
 =?us-ascii?Q?8shgbCiwWicZNEYRa+/1lRi7DgLH5AsH/sFC27icVsI0QwosZP+wuIelFYrf?=
 =?us-ascii?Q?rwDzC/LxcTXZ5SOG6uOm6dRrVbxk2Lg8NGZ2oBbIvAOaYT4Ie03miHMoQcsv?=
 =?us-ascii?Q?Pov6ZCVeNDyzCZ9ManlGTntY2ik=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eWeVGgmejOJjzw/toUh4ndz496ek9uwoILv2HB8Z4RiYbs/4/IFvURremCrzJIp9jbMSAljik+D4EczcSfIB4ihcFTvDfgjMKuDrMRMlV3XzAiMRCNSN6Te3lrjA6Iyiiy+nmkC44Yi24pjho+wSfkOcnzio1iiNxkCfsXOXPBcnLf7aVe8tj72xIY12a/qydHdk6z1O0QjcuoaY7uSY06XyOAZmdRkBlkNQstKsLSSikGfTdkZnpIQOkmsl/FupKaZ5wOeXhoXXtg76YxLfk9KYCXwUjaN0rg+Ic2CgwjgpvkPSUDlQ505vbGc97NkUmlX5SUSTaXj4j6FB/bwbTqTZL/dY3OL0WI/I+0aBFfKM/mnFpL7G8s0rTwzOtZ9sl7mz0pxm13VfD/1nuS3TqS1X4+PUke4VEudPQMMnkxDPjF9NTGUpti2SmcKu7rxI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 18:43:23.1259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5a94b1-01b4-4369-a16f-08de730b6c60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894

From: Vidya Sagar <vidyas@nvidia.com>

The GPIO DT property "nvidia,refclk-select" to select the PCIe reference
clock is optional. Use devm_gpiod_get_optional() to get it.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V6: None
Changes V4 -> V5: Added Fixes tag
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9455456028bc..8f69c5c5a099 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1170,9 +1170,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
-						    "nvidia,refclk-select",
-						    GPIOD_OUT_HIGH);
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
+							     "nvidia,refclk-select",
+							     GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
 		int err = PTR_ERR(pcie->pex_refclk_sel_gpiod);
 		const char *level = KERN_ERR;
-- 
2.34.1

