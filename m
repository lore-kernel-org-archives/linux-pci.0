Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDFD32D0DE;
	Tue,  3 Mar 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521014; cv=fail; b=PSfRAx2psa2TYHLf0GtwqSw7LUmT4wdLHy5QMjA+EnRdKpEfKdXk6Q3aAUknqXosAHVHm2Gon+DzsI5/OePixTjRkWDzjyAF0IRcq2KppuPE5DH/uu3ppysggwtnJ3gVKpNVQ5Dytj61WqyXSZ2krVk82d/KpsS+UU3TR51pUaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521014; c=relaxed/simple;
	bh=6w8pQ0aaxgTRBkysZ47o+/hfLTFyK2fv8l4b6BD5VKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfNoNl9yuJuqDUrDqSSscFdxz24TRPi6xkjSzz23xyowESgSW4zc9xMfRzJ/+ZQoOzpF+aF0V8m0nBkVW8Jqq7fSWAjLlyTYatbzMN/Sm23eKvhTG/VW2BK+jH+leJf10zmMuMx9yU8F1UK0z26GBjCeUIVQqw+5eqM3fDqScCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8gLw3zk; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8gLw3zk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxgegaYjNvymoszcCj030nKzimDew5bEopYZpjFv4wAgtuZdb88byX9rp3984Qw5TGd3gjMRDQhEQKYwQblaIDmFWsTB5MRC/IcU5ZPtRnGPl1Y3gcKfRQWWaPhrgTLSnkCVmgqKHPa4n50AF2miv+4S579x0bxlHogt3ABzsu0JItouL8DXkHxJySOeuSQNKnsNRSxg98M3oGhZg633wC8441fGe765FmbdzUFUblOkQMYYWhFjruoYVLsovzMIIDrBL8M2YZdnw8xYLFPGXTj6nmq3h0Ud86b5FBVtI8maWxWmMHzh0jli24LpqpZr+4m5ifFsmc9bgi1HwzD8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey3sIHcsYWGZTQEte0ZFjgncU3sKNgkiBB31h8W89PE=;
 b=mk4fBAvlOslOy4NqKai2I5dzmI+2BlXbmZxhIQhYO3jKwrF9kZAc7IIeb8lealqrhTRE0C60t45B6zzD9FYTA1ALenXSAlrNZYBiXRtTVKOIQwtphUbjkPFMX6NwQrQkqKvkCuCvP9ISfFECeuPNVyyAfVrFpJ+DOkDH3cjDYaK7vOE50ZrKaAYxQM0TbBGgsGy2ecCEohY2Md+edQFN5U9QB5SudtMqU9ICOzz0ifH3F52ZBHSynULIsIfaUMPOAVoa+TmJklVuQSVW7hrTx2deHE2SUob5KPevp0KBjsq/vX1FtkN5+EQIGAa38gkj/VB01HatG+2xd/s0jo9WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey3sIHcsYWGZTQEte0ZFjgncU3sKNgkiBB31h8W89PE=;
 b=X8gLw3zkkev0oiEpLnQ6+VEPvIru34XxgY+/mk7LNWX2mxmKQkFb9y3rMHsnkVvofvw1VOj/bZ1TxSlc9w7aEx28i9/QmqPNYVaKuUqW7XM7sgRRVTEdlJqKFBEcvWI+HbO6glbTPKXz2Ee5PdOsyAXn0qB3lM17HuT4YNqc6gZRktmDg+hZY0XSMPcq2u4my2mAf0T4r0hf2y82v3LfTvRncCQPNugz2E9RbRC2M1Dyf1xyRGkKfsGINlSEo4U7OKTwVwq2QtdJU1CMuxv0ZRM9z0w4GRGulmHd/VlbA4O1RkgJgpPjZ10zIn7wd3dJK2dV9n/GGaMUUP0JkAoHxg==
Received: from BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 06:56:47 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::62) by BL1P223CA0028.outlook.office365.com
 (2603:10b6:208:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 3 Mar 2026 06:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:32 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:25 -0800
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
Subject: [PATCH v7 11/13] PCI: tegra194: Use HW version number
Date: Tue, 3 Mar 2026 12:24:46 +0530
Message-ID: <20260303065448.2361488-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: fec3c2f4-09ef-466a-0e92-08de78f20978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	UZyU8dRuOvf8ezQTzwmQZpjJ++gDVSY0dFKPxpHr4a2mY1e/kKpHco5S8rrq112KNEsgpjJxJgmKFndTVxiXTdRmJMznfFt7Qj4xaX6NbHAN/WsXC0Jw6uSsmkpwa5E2qOjPrlEMTtTeFcorS8kOtKwDo06lTj1swlLm+gltxLi8UUb87jMreb2C+xrKL7/e3a5mOM7cRrOnW+AKlgeMCWzxuzGpzCeGXdz4OPXm6NrxTfXOAOuJ/Qonl6vgA0PseWrcBsH75FMvMn5QKtjgcC7Hef6Lu6RT4NvCAUdxk/f5+tXAW5G747FCxZ7rt4KFK3tGqjODyo9OOYDanoOi8AYhqtZTeSZxWgQ+JL/gtZ/Fi/ZgAXeGs36euQ7wYKDNGPN+Q7j8z7Uwse3LmA6917jtBTUaSS0BhKr/2awAyITLpJ+QD4hr689kr3NgO7nhuKnvTdrsIKbKJgHml+Ra5WSjt69KLS+8zPobolgwsE4ewE40TXRIglWACHv+t/2PZRqbU0gL9jaasgwE6KhGvrXuInoYNYmROgepX0rz0toIQJLYiv8kdzl89iA21eUAyJiIaYqHSszQk+DQngfLTUtGL/I4rmLYtkAYgg5RZvgjppnelIXiddkx2W6P80LXAzOmP9N4COJuytKM0eFIHR/oNnEGa38erXgFx8tVPFaqbUJs/q3sLprv4Fwv0fIGEY8kdtDBg+tTcJXO+BPChYbjnzTwzcjwSYdIVXpleGgMkiSwCceuOP2SoBmOGeeAdzGLWIcMhAHuGi7r31qtknC9Jb2RrkT7D/OMSZ7MIPbJEsISK5ZaTSzeouA/x2x6AgCCQtQadYexT6ty3LHBkW7sISblO7gn4EsLlw+Xs2s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KB03tdzl2Z6rbJLO8NwQWHOdDzoi+CXesYFmfCSlLHlGbp2EWX/nbw/L3E0ccuyTR0F9PzGEJVa3Ztk/BNsTmgvg/6iidzN0ALeodEqcqaKQ4l1vpilkizEJ6FblKbzunwn8iNCmBgjKWxbTh050xP85BTWZGAV1DuujnbZFN/TA59aSsoSdVWT7bExvyJ/tKolsbMDu5mz/OSSTATYk+Lbhx9ZpN7D3/LfxyamsJThokLptLFVuwIWvoUI4eR0058aVHQpoc/uvxAJDdoO4nocIWfuxVcqQxocrM8+fTutp7uuliy27Sd+B+NYKGG9TkhuZx063Pb7FL18iPHdtr9hTcf21WoswZY67LDTFn6TzLE0naplQ1dGH0v/2IDHJo2Xby/nKYNboyHp+mxJW9736YOUk27UIy17nHtxmXxXkVAJHvtebDPsA6cLqB7fo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:46.7434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec3c2f4-09ef-466a-0e92-08de78f20978
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

Tegra194 PCIe driver uses custom version number to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results
in mismatch warnings.

Use HW version numbers in Tegra194 driver to avoid this kernel warnings.

Fixed version check to enable ecrc for Tegra194.
Existing 490A check is left intact in case any HW relying on existing check.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

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
index 1963165967b9..1c6543341fb9 100644
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

