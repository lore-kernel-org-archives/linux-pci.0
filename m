Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA518BC3B;
	Fri, 17 Apr 2026 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393554; cv=fail; b=nHs+dGLxrK4BBXgrSR91tIvUb3ElFaNRLgQfKv8+VD7YEiyqiZ/KHnclH1uoN13TxYO8Somf9Og4+d6UGoZ8iFmZpMf8TuWjHob/zIWIRTP9EnUw7I4cRcXrUGVPdQG9X+LGWPcERFoKx6If59U7IpFy693kjtSsKu37imEqchM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393554; c=relaxed/simple;
	bh=EMV1m0RfFhVmZlesnsKDCm0xEzz4tyy4OaeU6G1U1o4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jxv0cCq5PtwmuPd9T4bbITU6x8id/COcpMHFvootiOqv1OGm3sLGyTSbZUvCCFM4nO63ocV9Knjt5UaaCmZFcBtB6g5KUITPf3ZWlcSv8vIfXGoFI2dKyFUJFftMfIn5ppKmuBOesvVlGM7mAS75JJhWmZERPgyWN9zt+1jDtwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HMOplAgM; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HMOplAgM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJHMc5asQFu2UYVC9V0t4w8LThwNcn/DgGxZ1wzd3ctfdY2yeil2caUQSq/qyw6OmFODW+2gDNATSeVkimkoA1ZgJWyglhDDRRyRFuAbW/zqFaARI5AiSXj1sVaRb5ITWkplUIG1Cqz56QH4NrEqBzPnKwhGH9W9IIJBEjQXnHzIgxC6D1NkQXYvDZlHFAmHGDCulOmxGsBx683U9UcP8+BiYVAnF8cnFMt1oAs/o3qY+emTq4Zf4w+tWvzU/HBCsH0JEV2ML8EnEIO6OCvhxO/qKYnrkLZ9JAt8WBnfa2myJ1yWNmKY9SkTJro/vgSSarWY9JVatrTZR+VwAfBj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfT5GnntMlbVsm/CVT6cl/CYFDxewxXHG2Wppo+kiok=;
 b=b3Imka1moWo8sVrLVRBaP4ji1/549SLI2Y7wO7mg68af9a1pdr89ix01+yuuCrRTRR1t9XxEj1s+pekWStu2fVos0zkJFy2SMhlwQuAa+BdpK6McqsYrbOi17nRBK7C5JiDA0vwtiVogTACNNxGNB5wAy6cjC6c34ygt7X1bNVvvn1kig83gDiqiZFjOl5XFyYslOt7MnTK0ETfAwszHnR4KI4BRBgQ9t5NWINTju+lhdAuxwo79CP20qysSnJjhuBylSj6zuM/B1b78f7DO5bQQt3sTpi3E6+iPDXhfrHDv3iHzXKpX/7eNjPKbsJ4OS2TRxRgvBEqmzqlYztN/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfT5GnntMlbVsm/CVT6cl/CYFDxewxXHG2Wppo+kiok=;
 b=HMOplAgMbVsJtuj6f+hCk5/LhZ8L1QO81NRx1mnDnCsJo7jN0lfLydVZVwNr+L0/vLHWvUEPT10Jgw0gJucQ4pFCqeL/HLUHcSFy6jSsu82a0Avh7vHeasVLZVLYTF5g5vFi+2u/vaJiHvs4A5aS1SDqcFo9CnZoe2pLAQmJ6s8=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 02:39:03 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::ec) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 02:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 02:39:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 16 Apr
 2026 21:39:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Apr
 2026 21:39:02 -0500
Received: from xhdlc200245.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 16 Apr 2026 21:38:59 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH] PCI: amd-mdb: Assert PERST# on shutdown
Date: Fri, 17 Apr 2026 08:08:56 +0530
Message-ID: <20260417023856.3210628-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: cf986d2c-e8b1-4237-48e8-08de9c2a7d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	StYGM7XhB9rAAvO8M3mSDDUX63zlbeQOmfOQRZQ6UdrhsRsNhHobXCFKCpOCAXTce7aClQErix8CJpgoZzdKv0g6DGwKG7h6/vkiQIBxKzBW10/XIkmOAdo6oVSVJcrfyYgOQp6ZEJJO6CLE4GGwqIURMCEirRDQK2xIS2XFYn01XBLZQpVt1dDcNEzTaIlZ9BrXodnBcTmguEFcJwvwN6NKJ7bHajg8hpXoJ7eKLxXwOnqPZFwJ8PwAlpEZqyJryVA6RkloIx8NtTSp2IwLJrxDWXnt3BZ6z6d4Lq3gCbpcqsluuqJtNFvjdSU0s/Z412PnE3p21dnwunJcDoNSVLDgKE3iRQvPrQDPfnm0GXJrNZp1fBvVzZ0y2UkHBXicvEKscaj2uom2AGQoLCb3AkW6FiLKVPyDh3sDLUP3m2JXRyc46XGUZG0bl8R5W/yl7fiiG1uMeVdXl88MX91JHCCnozjRSguHsowBElzZKY+WUk1Gpu92cUoLT5ZHTWpB8wkODZQzYn9tChtsBwlJHef8dZ/5aIcPP5FVhHDSh4yi5sahJ6qFp73QM4F+tcWSCDuMdHHZjWN7bUAFZu3fPhMfgsv9yaglJIxt8zcdTh5owTdGBKaTSHK3AVptTqeK0iz5195Tjdv9SMidbig3e+KBemAsLdOVOUvE5YaQfNLPY/fg+fGDqlXNucG44Cjb7pYA77MSe4Q8080/KJS7Vt1TEpFbaGGUt082RNhRAgrNu7uSRRP7H076jmZs9CIfw5HAe34AsRG30N+52Pm2fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rWglPJPuV/xU8RW7Qyf4q/Wi/SwYTngL5m/zpb/jhs5OnO2KdqDmJhJ7zsVoIQ5IlSwImGBVlcceuPQqhSnqS4AE/prs0sMrbera0NUFeB0t2UwTrpdnonzyI2P2XW5TyeBiFUQbbyHa67RbsTE6qMiYHtsDZQa9EQMoKJBsdifykH+HllST8806JXm9k7/hleJxBXgRviZE6ZKuuc5jprSBlTe/6wVp1M+4Pwd7rCSV2yj3Her9UzD8o3DD34mQxlHPM2ObLRhZp/Xj5GGsKdvhiHoqSZYwbgZgWi7oyROB5+Cih3msVPZMZKNbLaazpSnLdCpHrP4zygyBl0+y6Kv3QSPLwcP1iMRm3I0IhHKdYHC9ViuKaiGEyBfhd1nKnHK0QYQnjB4FJi8Tb2goveNFuQ67x2DW6/HZq+Rpaa9Y18gO6sYeoeUsJ4PDLSTN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:39:03.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf986d2c-e8b1-4237-48e8-08de9c2a7d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

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

