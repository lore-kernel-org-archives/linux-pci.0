Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126A31194C;
	Mon, 27 Apr 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291962; cv=fail; b=TCDY7/E5yh9RFevci22IaUQaR2Hg1X09GVT17cYrAbXi0lfL054rw1zAs5F1LCRqvInl82X8UGkwS9cJokUptcMYG5DeNNLcHgEuNOs76fkS5+FWJ/9WwRCd7nFGs/R6F5gMbr8GLnCq2YjdvJj2HJ5hONz6fQHsDNUFEH9GpX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291962; c=relaxed/simple;
	bh=EMV1m0RfFhVmZlesnsKDCm0xEzz4tyy4OaeU6G1U1o4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mstAMgbyf7pbWzi6mfxpi89kzHDEX8sq7IZYMtfWGIn9ozXLk2XKfmtfzXDDg1IZLp46IrPG3suCkXq+SJ8vquzhwnzoT085ZTuGpyT60cBx+/205YMpQtuUy/WMVUX+xIbwYCXjZPx/wzNoYrTYuw2SWNfm5eDrqF8hLQF0dHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mwTW3nl6; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mwTW3nl6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI9VKQzIz3ea0HWN8PjHPxYJMt9CzGmN9759ElDB72+YPgArLGr+0pc6dwUgUBHx6ko5gLV3lLtsQsZyV8FTs31Vbbz7Rx0cSiWHuBb45A4L1gp39qq2IPEzchbf6LS3ro+Ljs6aG5cQRGwqWqHHa9MWkOto3sv7DkkoL6oLIGNUbhBJ+XUKGy40c8/wc1vDpZKLBEJW3O7ikYFmbr27dw/hqHExFXQlGM2NV1ZstTeNmBVHQ9h8RIGsbDvuSkl6lUDJ0k+ePdrUVNByqoyTGGqNMTp9l8LEWszlzNEsg3Ugyq48/Ukwqy7tMYvJwWZc7xVxG2HuG1QMv3XVIjrmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfT5GnntMlbVsm/CVT6cl/CYFDxewxXHG2Wppo+kiok=;
 b=pFtyvrGf7MbdMsnbxpT+tBS2JeX6uJJWeIJ0xK6WjsU8GKScnmCVHe7sypDR3qb5EOVtrbNIOuIM8MRg7iC6lT9Q1+ifsR3Tg/zHB3x4GuB12FX72hl4LtF7ip/eOAiLIXQKFwe2m55oSG4dZfy7pO37lvLTF1rgZk5D2upFdYaOBHgUsdtBaJKRLwjqPlElFd8WqW5KjiwxEmzGGSn2pEeUtUvGkkuHncLKn4zylaWl+JNXUOoqQM7eVUtXuDP91rQzLrplV1Pp7ZpCYB2cB0rNcZsaaPktExl/VZnyqmY/+nDqqS6njCbdaR9+/1k7W6Fjz99py71sSGsyr+PJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfT5GnntMlbVsm/CVT6cl/CYFDxewxXHG2Wppo+kiok=;
 b=mwTW3nl6h7t8St4PIxiYjL9WAYYA9U8UD+iZlRjNYm3QrtabG/C+/nj32U4zW+IBEYD4HBTnoxLYIdo7PUf02Q6Widmjcf9CYabR/2V/ewiPiT7QR9VxFPKNmwMTRr/7M9U/Mkfa18Yf59uvT/qja88B/XMsTHzNzGgomGVK8Kk=
Received: from BLAPR03CA0077.namprd03.prod.outlook.com (2603:10b6:208:329::22)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 12:12:35 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::6) by BLAPR03CA0077.outlook.office365.com
 (2603:10b6:208:329::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 12:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 12:12:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 07:12:35 -0500
Received: from xhdsamusham50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 27 Apr 2026 07:12:31 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH RESEND] PCI: amd-mdb: Assert PERST# on shutdown
Date: Mon, 27 Apr 2026 17:42:27 +0530
Message-ID: <20260427121227.290604-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f1322cec-1bfc-4208-5d3f-08dea4564485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	e6cVKN3xjAa41o/CIPUZKizK/a05noV+MzMWjkL4iQKHExqzsVbnFrAMz0vZ/Pf3I1wYN/lj7Fj/QEFMi6h/cQo8ODEto7an60HyQRL4jOje6b+F6PQS+awKMzi+MQC7ZQZ3/5knQBO1fPV40bxdvTTdP25Q8jEyMUQ42s2zItbMzAXVPop38amoxvCW33XdvOQdx0LyyC+HDYZvdqCPMb0IeAVQuuAyGSmisYVLfkhk31gPXuRYQryKw8uJ/9y4zBnXTLOx8zjkx/enIybKIjgN9WJb+tIETy2ZrrbbpQvIEj6PPnWsrYmVK1flxsqdJsZFA1oxCqgmB18Tprv8NH4Mg0oHa6aDH8Lk0xhSSQ3Qbhb3ZdQXFtOVautEb0mEPW44+Pm2o4DQQ190yDFmLaGmC2mQO5xwFAUBvJpUJp5D+beG/UbmCZOGLDwGMGK6XeTDO45VB0FTdhG6w7RTOWMBnTXhUFXcWXXZEtw8ro0IUkVxRAoBOqfHSKnoEypk5baaPIvcaoIeQMRdbvCRXHPGeeNV+QXO8zkN7xh/Gh3awuvVOJ2UNAIuGKaqbbzu2a04WxIrZR6M2sXI0eSs4C8RIup5BrabtypdW3VtTfvsmBF/QVZ6/LXefq0vzKasEcfrbZA6CNgLsPPgv9mLr6lHxOMuO2LB39QUxIP2w74EMHzM3qgDyP8dHPQRmAWNM6JsyPpcr1ChKQI6aXYw0BCikkyVCjQ8l21Xv8pwzBbm222AF/ztnY5txct0UpsTuXPamQQg9viXEmplvY+X0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VrXZvjffSSojUNmBJ9ivXtSrzZP9D5JdHdfNwVIJc8+34KsGkCBW2J2U474IBxF/m3GdX8AGOqm+E6ssWKT3MnIlNvevJL/Rl8P0Bk5WPZCdOGErttaf0AeDPU+r91yFARAnrT7tlinEAPYQ8OPS/Wzi6B2ecPXeTMEj5uBlsphpPGSPrUlo9F0wBV1iBTr7rX4PWxhyrxJ5pBM6ET3vQwoFAEpXwoakw7k77m9hmtifnmmlZ+X0n3sVoDR/ycaImU7sKnGoO+KcMQOdDE5JhBjudSgzm35OIfajd518y/3SB6TbuGHJPGvhTCfjnuel2EOO3mz8T1fkQUHte2DWZjSuZV1LnCXzMXSXX1wPF+QrJsaUWeUr7QRZ6mgf9hX7WGTfXEjFc5MKzp/vtjnvTVdjIoE5/HTZuqUJ277YFuBdm5TPmBf8Z54gab8+iQ30
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:12:35.6559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1322cec-1bfc-4208-5d3f-08dea4564485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

Add a shutdown handler for the AMD MDB PCIe host controller that
asserts the PERST# signal via GPIO before the system powers off or
reboots. This ensures the connected PCIe endpoint is held in reset
during shutdown.

Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
---
 drivers/pci/controller/dwc/pcie-amd-mdb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 7e50e11fbffd..69d21b4727e4 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -507,6 +507,14 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
 	return amd_mdb_add_pcie_port(pcie, pdev);
 }
 
+static void amd_mdb_pcie_shutdown(struct platform_device *pdev)
+{
+	struct amd_mdb_pcie *pcie = platform_get_drvdata(pdev);
+
+	if (pcie->perst_gpio)
+		gpiod_set_value_cansleep(pcie->perst_gpio, 1);
+}
+
 static const struct of_device_id amd_mdb_pcie_of_match[] = {
 	{
 		.compatible = "amd,versal2-mdb-host",
@@ -521,6 +529,7 @@ static struct platform_driver amd_mdb_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = amd_mdb_pcie_probe,
+	.shutdown = amd_mdb_pcie_shutdown,
 };
 
 builtin_platform_driver(amd_mdb_pcie_driver);
-- 
2.43.0

