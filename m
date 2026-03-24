Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AA3A3826;
	Tue, 24 Mar 2026 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379356; cv=fail; b=N42+L/r+q3eXZRyXmKDw8VzVxKJk3zeJ+0uJJVN8d0jxlCblLLdMOC9P21dCH/X385FgWMzzcDvj4O3lHMpg5jPctmyQiOEUqwth2nCJYJXv6TYzCdF2EdvHOjWNTP2FMezzblA4tft+GwwaN8+h7p0t8KskdtE+ajjwnULOluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379356; c=relaxed/simple;
	bh=oaj8UjIA+KKxGgAxcth84WQJ2ZYAlKD40ZnRlT6LpOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+9RK72dFb38yfnXWVPft4FztTsk02eyOxx9zQOUeuslOFn8ZvqgngIshSNqshJsqUrZXeIjVM5vzoPdDj0dyTMPPoMuiUxk+2E3bs8tYFMwoPR3J/DcbUOEGawo6afGUagLyICML9hQXTw0wQxYAZzymGcT4qflsYOhb7JT9M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFzL/W8z; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFzL/W8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3we9hz1qqcKVpK8yPd0kKB4cjyfcF1AxS3uc5tqKvTMmhjdX8mS1niOYed4YVIOoBUl9bwWlPGRMD/Xkk0H33pvUkzRevhmU7DjvNp+lhdP4ZQkvJR9sW11XpqwG1vjZ56BnWmZ9WM7KKjPcDu+EN7FV6L4jc1lNCLePW50yYoej/hUiB91fyt1xifARfuaxKtMvZtAVwdyArHkPsibplRZ8a1HwT5/fWiun7Kc1m8SQ6eston6am++xrDWHGQkMjHdlGooX000H69e3KDBkXjceeL6K3VCEFFaZa7lbomRw4bEoexj3ZNhvqDNHSkq9ZeJ/AOHApchOlKKRaWg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg3fOEmUpC+yhGEhfAZO1SBvVth4otgJyBXqd5Kw0mc=;
 b=VTNkA2R3hEMw2JdrqWrN4RCFkZLIhK83YeoCnEEe2TyrzPSD52vufn2aHBDqX7QyK/zEbECmYp7e6WJGk/TzFWF4db8NooZUKjtyd9QUnNfkmsBJMXy3c5QnMha2PFMDOiNpDhUUWPKA2hc2s2rgvFhy0TxYbbQOHLROXATXrUnDN0vqR1J5Vt/D/tWGehs6AhbkgyM5OKuc1LR+p7k8WKjspWLqbs7h9Jz/GB5QURnPFc3IBmjmtgMyMX86G8AvWHX0BfU5QbDtxxNj9QIYs6ZQeeF3O8MA3ONQY4ql7VItWTeQMHhrNrK+NWolCt64/8V+ce81Cq22tb6+0ynW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg3fOEmUpC+yhGEhfAZO1SBvVth4otgJyBXqd5Kw0mc=;
 b=hFzL/W8zdq+5w4KEmTSQm37TsmzHzJ24753xGvGFHdfDxocAau1dXe8DRHTF3H9j376GEqQCnxstw0FUoS5pxX3GUbeUjs+Cgh1+497A8OJbY2XhBPmnyJrEVRBiDDfpPUreVg9PBeCdT4cFz6mWjGGDVIU5VJ57ynjLvg6axc+fZDV7exHIBZUjzSbT7TxXHPZ+58ZuOQxVrXjFeAa6U1UDkfsqWrwqzv0zqHHkQGQq4Bsjt14QnFNMYpeF+OYdgKcFt5r0qVjZQzVbjO6wxVL/AvGEm0v5CuoxiPxMhncPeDF8Snydhw6l/vrSJmBcfbKXBpPHH0db9NjSjzSEZA==
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:06 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::20) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:46 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:40 -0700
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
Subject: [PATCH v8 05/14] PCI: tegra194: Disable PERST IRQ only in Endpoint mode
Date: Wed, 25 Mar 2026 00:37:46 +0530
Message-ID: <20260324190755.1094879-6-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: bc776114-1393-4743-1073-08de89d8d18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bibbATyt6e4WN2hvwWh/xtjRovVXh6Wy/YuovaCGYp1gYA8pzv86v6qBGpdWAD+LTs/SKHUrvLqna0U0FzIzeef7EocEmR7YQpIRWvLYbuG+6NYW99I16HWPtOSh1AoDn8rVaGVq2Tu58+qiin79ichXITFPKcjASwsuy23bbd7RIndQCuz1mQ/xGLyLKwcL1EjloK9cBfkr3+CJngNq47YTEf8RGsaWmUdP/GBoruex8R+uAPqacrmawiDdL/g36VnIhqhiaHlxhIi02lRzp2iNP3y1WPXPXO44clpyLEj1+JVj1QE4UG1MH6I0SXaGlwjVwaoFlMAGblIGIQC7UikPid+LFjUfTKfxrcl+U9MWg2Vkz/xhS8w45VinQByKQ2Hs/4qVP4Y/maN703hd19j/zROKY/MMS/EJ7nWMOu5oXk00Q2eOSvG+EWF6t/5mTYBk+ChgyCNj2DdVBGaWkJ0rsjyZcE+ygfrHNoo5VgxpV6BL3KHOnb5MRewWHEDBIcibPIxa4skkvb2hH1SqTxvKD4ODMs9amW94/ovEkzPEBw+Ak1iSfAfvts9ba9w7077ZZbTlTTGl8LhKIM0ev4GQdMs4NQ6T9CuoQjzQRRAiM1mdSIk7ZbuSYA4bKhWZ0bRgn98zR6HWKPa1Q/OCjHILH0x/or9byrQVyYhi31ZYHBttCjUzL2p6R3CZDEcaAkb3g7/XLhvcrTU1kb2fvAa3avzyPDNlcSt+NYy9Y1DTTePEyN5cM2nKsmSf7bSI/ug30XV72zEOKRu//u1KRlM5F5fW5uKRPRFlxOYFWIHA7ZTUu4Fb2SP2mfBDPQ/U
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8TB8bmGYTeWDntZu5w+y0xsWb1Orx7vtYW19k2rxjZiUwu5x2XN1L+A2cO/AYq115YHQAnCi+ohaz57dtbHGr2Efa3meUKD9j4V+HYurNcF0LTGJdzPR7KR1c8L7wIDQq3kwrTq5+jbDCiV5tKUPMBexhmkHp7ERLH2cJ7WlG/XFsdda9NUlwpr+beZNMx/GNe1eZ+bHUJX7eJP7PRotva7NMv5tzZBfzDxefDgCaC3rrAVKZJ84j3ziLc4WfFbEhpJbjRG7oUls1dGdNNJ3RPFW6AB+g02y018JVplH1+tu9OwIZ2yn3Kcaa3pz27+7rf5u/7Pqt8wFDxNkcm5TbxExKmn6oHu4s5/nGM+iHwLCOngkYmES9wpfOA6wzxdkOhPROaNYvT8QV85I+9V53axTGYq1MHTPCLWlv6TDCRYVj/5muoiDg/lVJH4XrJtL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:05.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc776114-1393-4743-1073-08de89d8d18a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

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

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe Endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V8: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7e15597df6c1..f3428fd3345c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1025,7 +1025,8 @@ static void tegra_pcie_dw_stop_link(struct dw_pcie *pci)
 {
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 
-	disable_irq(pcie->pex_rst_irq);
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		disable_irq(pcie->pex_rst_irq);
 }
 
 static const struct dw_pcie_ops tegra_dw_pcie_ops = {
-- 
2.34.1

