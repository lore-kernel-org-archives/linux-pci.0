Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E53D47CF;
	Tue, 24 Mar 2026 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339810; cv=fail; b=lJCFBI/+y/zKadA2sSwifBSZFPtehGQI316OW1pZwQQyFKr9el4pbMcmK6+A8F00YMAU2Y4Cebfzt2GC7IpZWRJ6C9nGJlP9qOj7XEzRwN9xPZ7jbnBHIkYcmAGtJezf9PyxXjuGv0cVi9HcBqRetdAZs273esCp8oMOEmjBP7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339810; c=relaxed/simple;
	bh=KZWfY062ciAcAB6BXSjWIdHcCucOqoKPREX64dewupM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBcKxCPAZGhAiA9IMGPC5psBn+g5TXsKSypjcB/pEHEg1Kx+QlxbczuWKuBaP4KrUQQK0udXBiCQwpuoRzzcnBwJ0h0l6GsA+JYF8Mff6mZSqDezTOhw8u2aspkZjeYLTlF7ySFoU/TqvAmf9a9NuR/Odw6AAw1TTL4cJ+c9aLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UvjiEFPt; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UvjiEFPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQsB8SkPDofFw1lG0YPeXxS2G7k0FWEGqBUQoo+sc4E0CzWCEO1SAJUIwgJFsmtmocOKGFJ6vc3as+WWt6QMnTPoQfg4X81qLqYSk1fLhivgleq2ZAdRW2d9FILEeMKCxVF+EVPkcf2QJ9A7v8qblGN3oRFaNgVTmhTGVNrqgXUQKsUxfpI2u7eGNWN3nTghm5V7qSsqUCc1k0GSGwU6DBcW91P+t1zJkB6tgmuNJ0dv+/q81Y/GbtLdWQA8rtpUcHLlpFY4XeDwFoO7K+V7hPo1RQn44BTrNZUh2KtyJV4unSxwCfA1UMe2Qud50Jt949QZr6sJKPYjiNKLnZh0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opnd0U6q3ouOU9Qt/dwla+FXdZ/y8iwzTKEBwrMxv1U=;
 b=lbadQlgNPRapzyRsEaRTUey9l17ikRRtQZBm/Qjf98rI9uMFlMXwxZCPLozvR/G/ycCe+SNJmvttUKgBihprx/BvE1pZQxz/DO5tqvv8WkbI23HOpPsLx01cA9vOB6R83nx7zwL1rdNYG+uM+EeIakF9y3MIZcyZ1gm7uI2ZVKQs3JvljOHthjFgKt984FpOELNcz9h12d5qI9svNRy0/U9c5KPauJ/2IGsJqfZrKXlW8aJBh38KE37T/FUWRPQpK8RENatXEBnKHnShLcb5qsmeAfq4j2eiOMYG7J/DMCLBnXJiZajACDNtGJH1AQRTckQzUZGQPOzCzefs7ftkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Opnd0U6q3ouOU9Qt/dwla+FXdZ/y8iwzTKEBwrMxv1U=;
 b=UvjiEFPtN81al8FTcPjD62xIbzoah5hr7JmPgBaGAGQ2T+7/K3iQ/PhnFTklSW/5xlOwwjvukXrSTISDMW76OwI1nY3Ahi4lgUTMe6yNecLvI7xbFvEaZuxmnqF69K/zUtEM/JVwnfsnN1UBObcdidP7ApL9oP6uQIqNeNHDckbl7uPqePUS7pq6aXHt83Oa8/KZcKGE+qiymOyOJPTuQKx3BWq4Ywo4VI4mJ9GCb7QnlQbQZUERSEUNKGxmKPI8Dn6pHs0FfRtyhS86sRMXdEgdJnq1pmM7Eh3KAeh1+m5YptgeEfPLaySpdMkHoV0x4vPjGel87Jo/24nNjLvrxQ==
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:09:56 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::88) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 08:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 08:09:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 01:09:40 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 01:09:33 -0700
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
Subject: [PATCH v3 3/4] PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as 64-bit BAR_RESERVED
Date: Tue, 24 Mar 2026 13:38:56 +0530
Message-ID: <20260324080857.916263-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324080857.916263-1-mmaddireddy@nvidia.com>
References: <20260324080857.916263-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1315ee1f-e48c-40dd-9168-08de897cbc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A+PQeHGGHMkC7BW6c2AP+5gaaLJSCZXOCPY+B68nZOgfFCJjGrIdzxooxv1UOTHtIOxRM6L0860LbjlJWHNNB9mLG0MUWID4wTJD6TnxPdL/lRKBwe/XRvfTKzrPtbWTRMXxI9d7/jY0Os5NELaMYFuHnPQaJ+4zQFP8f+ON1scWReVt1y0QnXkO1daoMo34FhduuGjL2uxeiukLMsYDgl3dCqrvkxp16NrhOTnXZ+qwMybAHl2+5Y3EEW/RPNhXBMzNPfPAjd92P9eHibnbIpOue7OBJMF/qgMj8rpRmfdnTvgd7b8a9HVRe8iSdspVcfh/M42Q12EiruIercaI2/DPuM1uR39Sar/t/2cVC9Z+3ysKjBwrE9qtfdoHaFpN2vl5Y3A43G8uV7hb0jwpF3EDbEUObwIFYHX5UgGMNY406H+RebHN8AIzCimRiYbrcjH7rmnXWT/ImFTbdpo3pbDZiw7McbfKlRx3EtP/qAbaK7Z4a8kp9LTFNNsQONKnEdkrWrWcPlkMgax/rn9i1hvlUW39eXA6hsk/5kLeGlFrzZFR+/ugeWLqMJxpo4lbLcgMw1xWM1+mCs4g5KzOohBLzI9EbDbQjTFg1WPjbugJpACPjQc755FZxM3Yx3boyorw/oyRfQzi7LOw8ztth+tPnNmMvMGflx310VwY6vCewoon5ddoAeB8G25WkoLPy2IYNJDoTFZguzjhox10e53Ssc2dGiGmjQXpjv3Dn0dox0jdPlN0A+HVxrDDOdbgBJV9MiEnQhJNtIvJOQCJhe1AnVa5XMeLC93RQURLV52ZvJUDISqyNcee0BiWEPo6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1m3WGlWsBXsy90KN+ERRo0TVD7Vgj+IE9AdUvaTlZ5ttSAPMh/7aNRUhUL7Xpo0X300xiZeXIlQukwmh2WPj59m1x95h+02Eia9i2RG1q9OSM6NxE/OfxLyYDtg6MLpr3Q34fhtqy6ovKEST8gvW7fmsLaRnX5bh7cpYmar/w6VzYL4W6sdsoxrk+GnO4dTjPMAHbnobtcyh1dkYhhxQA9iZyBea32nyP044xkPoax/DBOK24e40ipqIRDPPXI2OlyvLz9qSCej+M6/vFe1xzGmVN2ctN0idH/cqnyuBYHQUTHWTnrolSRFPYiKIPTuGgAcE0+r9JIjbIacUSqkpeMeuQwDX7QnKnGIShVoLwxwG+IEyMSvvoFNcG726Toww1DIhpbRZ8bYLnWBUlm5YieEYU1B5JEDS73BUWhz0FUILBUn+SlUfRcPDxe9UrnYJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:09:55.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1315ee1f-e48c-40dd-9168-08de897cbc4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

Tegra Endpoint exposes three 64-bit BARs at indices 0, 2, and 4:
- BAR0+BAR1: EPF test/data (programmable 64-bit BAR)
- BAR2+BAR3: MSI-X table (hardware-backed)
- BAR4+BAR5: DMA registers (hardware-backed)

Update tegra_pcie_epc_features so that BAR2 is BAR_RESERVED with
PCI_EPC_BAR_RSVD_MSIX_TBL_RAM (64 KB) & PCI_EPC_BAR_RSVD_MSIX_PBA_RAM (64 KB)
and BAR4 is BAR_RESERVED with PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO (4KB).
This keeps CONSECUTIVE_BAR_TEST working while allowing the host to use
64-bit BAR2 (MSI-X) and BAR4 (DMA).

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
v3: Rebased on pci/endpoint
v2: Split MSI-X table and PBA reserved region

 drivers/pci/controller/dwc/pcie-tegra194.c | 42 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c5381ffdf1eb..ea7a6256450c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1978,16 +1978,48 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
-/* Tegra EP: BAR0 = 64-bit programmable BAR */
+static const struct pci_epc_bar_rsvd_region tegra194_bar2_rsvd[] = {
+	{
+		/* MSI-X table structure */
+		.type = PCI_EPC_BAR_RSVD_MSIX_TBL_RAM,
+		.offset = 0x0,
+		.size = SZ_64K,
+	},
+	{
+		/* MSI-X PBA structure */
+		.type = PCI_EPC_BAR_RSVD_MSIX_PBA_RAM,
+		.offset = 0x10000,
+		.size = SZ_64K,
+	},
+};
+
+static const struct pci_epc_bar_rsvd_region tegra194_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = SZ_4K,
+	},
+};
+
+/* Tegra EP: BAR0 = 64-bit programmable BAR,  BAR2 = 64-bit MSI-X table, BAR4 = 64-bit DMA regs. */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.bar[BAR_0] = { .only_64bit = true, },
-	.bar[BAR_2] = { .type = BAR_DISABLED, },
-	.bar[BAR_3] = { .type = BAR_DISABLED, },
-	.bar[BAR_4] = { .type = BAR_DISABLED, },
-	.bar[BAR_5] = { .type = BAR_DISABLED, },
+	.bar[BAR_2] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar2_rsvd),
+		.rsvd_regions = tegra194_bar2_rsvd,
+	},
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.only_64bit = true,
+		.nr_rsvd_regions = ARRAY_SIZE(tegra194_bar4_rsvd),
+		.rsvd_regions = tegra194_bar4_rsvd,
+	},
 	.align = SZ_64K,
 };
 
-- 
2.34.1

