Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D343BF69C;
	Tue, 24 Mar 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379401; cv=fail; b=HTw/MSCEgVJwLnagbmYgzopj41ScyY78IaWZ6pT2ZCskbLVxQna+ftxHLrfAQC9JBkNvruPBr++z7iTbc/UHma1tFsCr8Vvu6TZfhykFHTvkfLmFAs7DYQBaQ5LG0Z02GruQWiFVNsPXTKP7Iccy6xYmB6Y+uFfxtm6lMbwPkDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379401; c=relaxed/simple;
	bh=AY2ruoYVGY8NAm0QPBxwMKN+sF2ReOLL7p2AjH+diKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2LYcoxPR6g8eAe1HAH29zUgnkIqT/CaZuOdqFGY9oFT20wVNKOgs8VfdaU6ty25x+mZoBKPKHPbYbcCNz8U6mANIjS8YKqlxBdVXgmhWW9yqEYwcBy2wqcjntYI/LpfoiDt5DYAPqjvhwaicTRHI1NeHKp4iFdcZMQLyOuV0UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SS07fZWd; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SS07fZWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz4IjZMr9MzTY8hxS++RizvC+ENTRT70A8mm+h5DrTsJFGwvjq1NGmsP+0MEXXHPtIPpMts6CuYXKMVIxzNVcVaq7X4oaa/dpa6WE1zKlheGfEd3SIYfhbgbVxQ4zOj4rvgCHj6n7LBJm3UlMAxpMHZUBOs3Q2GpxR2ZmUV4l442vXEWTJYPRsx48EqLrfxggoe1pFsXp+BoD60ncTANSzDYIFiF8guqLY5hR0ZlDVgsmAo2fxs1KqzhUmqs/GUX+92rZ3wawGw/HSb5GyiFCDNw4CvM8N7tzETJEj1wcGtm7oSzR1QsAijlAdFaaZ3bv79zPAQjvSLR4rfm2sNq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozXgiU8Mn692nH4+wF6S87pJ7QS7mwwXtutJJ+B8Hcc=;
 b=fKHIP63y29DG3Z/1MIaf6xs5azeh95UHUr2sZLnybSRBuIifw3NnBX0hI4pM9E5FZT8/D16FsUrnn78jCT+4FNDENT1tby9bk3Up2ZYh4dxTPazf6AaaZt6HUUp5IWasKIMU5NIgZGeCGxdFYgXT8sfdj7Jus5OpQ4PbWyk1xrOdluYUwnAQEe0LJsbVALm2a/i0LzVFB/1yH9Nca9ii0TxiDppV3jQiTiD+2hxrKwFYfjMqLeavgVh6C0PKhIugR3PZM+YuecVhop/zEZPOYYWt7Q86Pad/uk0zVpC8eaxzpeBOp3WXM4v5K3N/mWstcISvIp1kej/1Jbk+1weTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozXgiU8Mn692nH4+wF6S87pJ7QS7mwwXtutJJ+B8Hcc=;
 b=SS07fZWd9R21yfEzWsjRAf2U9LauH1uFhN44x6MR9XViKeekKRFqUCAYHwgfL4PtsquemZyPkWGk1B1foTeeopgjUlzRG7kOHQGgmCH34QNnXMPfgwldjvn154bFvepP0F5RxcfXHVXnX/a353p+0F+riEG9CfHmLC10/Aua6J+XTtapzxSDV1E4pzhm1MZCi+DUvJ/GJAnYliPMFdTUI4Ru73bjclgOPPMFhGW+ujTw/eVLgXiw2PYtuX44fQe05lhB4hU3Vo4KMkQn8PEhwqlAqWU3zuX20cchoHIIEPFDz7fYc3MONGcggk81n5MHfLPVey2bmPjpXGSIYJFMog==
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Tue, 24 Mar
 2026 19:09:49 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:31 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:25 -0700
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
Subject: [PATCH v8 12/14] PCI: dwc: Apply ECRC workaround to DesignWare 5.00a as well
Date: Wed, 25 Mar 2026 00:37:53 +0530
Message-ID: <20260324190755.1094879-13-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca712df-329a-489f-e019-08de89d8eb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JFFl9oprFPoapkidc2Cua7v7DxQmEQf+A+3Y5MVDFz6AqEsdyEj3mHK7+SXft8tS+B34RZB2XZFp6RZZXNf3E0IF1/A0GnD9A65bd+fJVuFYBL+vDqy1xHhukfZxx23oTZfbP/lsHgcr04y/8wenCPTA2yOMQwxZBdujWACoh+uGuL5U0Gbfdrgyc8hAWmLShCR/j3MitvGLavsfcJeqKHaDBfa+4WjKzQ7kruHlppaGoM9t7n+cTppETATRY08X1LgChjyWHGMDc+WvubRIfi28gDTJuNz2+EW2I2BdwZXJg2bUMN9tykLt5KSQIlJDjft6GZiG8KjBBqz42czjM612c2LAWbic0TU+kvdeLqEfDMq3xVnvD+YOV4ZuRop6P2w/mmC/78LZBK5FMcVjwpYXvW5CZMG/uJXzWXiU7Q/rOtVx9qysPKwMW7PSNRRda1vIZkzJT69+a5hWiPI2MIUHAGCUMnRzNjffBnuZmPRZpGCIXWUApI+eXqNrjh+RnUTY4+d8oAUssyp3fCXCU47a5vZTaYnpEGvLRJg5Uy96qEmcjxlpyjBwZT1a1hk5HMkZ47301d9XXmT/p/US30F05rgRqQg2BAw11C16ON6HTxgOqE45WECtrV0ZZjczp+jWQ/CyMZ5QV4xU+VRiuIHGzJyjubXvpUBDMBHflXAF7SazNDDuwOkTfY1R8NR6huCde8rsN8dIM+Qp7Aq+zOkrgHbgQcn4Qywx25LB1KZVaIh9vcn5SCApYohESNSFoPmMT5Tq1RtEDdsulyysA7c+2NanFx0/cGyFvPP5EC7GsNdivOOpJTbXwWc1awZZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bnxF2ufqK0bUGiSBZO/Yh2cmRu8sakzuq+m5ovJPxOVVvK+8KPIj9p8tN8K9Wmiwt9jgM0Jj2XZCNEQPB9fLp+Sa+UkG+hLQ4dXDoK89yMBAYeb7pTTQb/Xay050J5pZ4dYp4dWpreHpKAkMcg+EGv2Jif87X+vcllstGnxN9a1q+vaONcIknbhN4oWn+BJhSCIZiWaGB3kRhb0Ps/fCb/3d2Xd+k7TWR3VvdcTbfmI/f/URTziMqZewnZgLPrvl6h2hr9qbRZGTRimVFh5MoPI9DLZUhmZij/fCJ3G+d/UrCWZE7z7swm/xpsZc1enXxOQpnl73k+i5cWgk4j0RMJcVK8hz9MPGBl+6w+BDZN36wKhGlcbwazK9Nzbp3UBh8X/2wga4oqBHDuGVKBvTv8G40YajXm8CJvIb3oNTg09K1DbpkxuyohLrI2wFXpve
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:49.1005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca712df-329a-489f-e019-08de89d8eb90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

The ECRC (TLP digest) workaround was originally added for DesignWare
version 4.90a. Tegra234 SoC has 5.00a DWC HW version, which has
the same ATU TD override behaviour, so apply the workaround for 5.00a
too.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Split into two patches
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 345365ea97c7..c4dc2d88649e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -486,7 +486,7 @@ static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 index, u32 reg
 static inline u32 dw_pcie_enable_ecrc(u32 val)
 {
 	/*
-	 * DesignWare core version 4.90A has a design issue where the 'TD'
+	 * DWC versions 0x3530302a and 0x3536322a has a design issue where the 'TD'
 	 * bit in the Control register-1 of the ATU outbound region acts
 	 * like an override for the ECRC setting, i.e., the presence of TLP
 	 * Digest (ECRC) in the outgoing TLPs is solely determined by this
@@ -559,7 +559,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	if (upper_32_bits(limit_addr) > upper_32_bits(parent_bus_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (dw_pcie_ver_is(pci, 490A))
+	if (dw_pcie_ver_is(pci, 490A) || dw_pcie_ver_is(pci, 500A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-- 
2.34.1

