Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF13B71CF
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787391; cv=fail; b=RkUmDTTxXTGmQhcitcvje1YJAGDvRNIMu0Vh+KbqW9XGL3WPDSikylZ3yNRqNDRIkb859U/N1Bt01dat7YaMwVfjWVHJSILWc0PVimQZcyCePzphK0pyHdklP4Z5uI1BrPCvhU92+ZQPZYZhvPoB599FWxwvubERLnKUo0QDq98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787391; c=relaxed/simple;
	bh=Q3WqbHOgHEOHXoPZzotKQOWdt+05buDKU5o215aFyI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drGY7a+yNKg3DCM4UPfXXWOBnFJclNdsbqyJ7ClKGu5urlrl+ymv9LDog2vOXlwGgckZS0zpSMvywvXcwKNEhC591e/eLLpSD/c6WBx9gMgsYrafX8OKoaUvt7IHw4yMYO86nJzghPVPWtmK0c9TqS614/6wY1pqh/w37n/xdWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zB6qNBwH; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zB6qNBwH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJAv9oGcpvdWVMOsQN6RaBW62fQK6EoWxZQlSyaKYG68YHqLsqKEzrqOYh41+NLMVnqU4CAeXoWG528eML0VECQUs7AWAcUVt7j05xm/G68+gUbffTq9EkC7SsfMT05lwTUXA0Lf+pPDdotRJAfxciGYfXIfCDXdwrzyaXTX2cvJCA1MK61FS8WhcSb654S95onaC3FGytxO7f4jjA28Z8RS57wFvEs2tIs5bWNR6Xs/LNNcwGY+OJJ7xbSyQpM4yQKsrlN5YxLbwaBhH/pYbvc6E1vjp3eoBCnBZgpFz7S+p1opRyzu4yQdwkF9vszdfxPOKyjILtG5JiFY7dQ8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfmOG9Vs6vAePgGsjVl5UzabZXMgaWwV6czRZ9FRlFk=;
 b=RJbShZPMTJ5CIFfo1sKCyBSRtGNlgO4JsiRl/7KD6JGJSoOfaI6r97lG3IULEfUaf+TZKYxsnImKk6pSe0/YXXIYXos95wiLHpTiLXlFOk9R+mVng5enb8ufoxkB9498FCfwUNR2DZ4GTA0rxfb7zwCTq1+AXUKlizHm4Nslfdm0rOmZ6OlTo9qSeEOINFhD4WL3bUtCPR+ksh9XcIF1Af2fsCoLnvSmKqCpkY0BnlVkU2r6t8eGJ1mqa75dCRRclipoE7clP8rYl7nvS1Ffzv7du/1c7/Op9wgtH5TWygPHl24xVC9eyEQkvQ191Kf6lbdMXXcTE824GcV57qpz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfmOG9Vs6vAePgGsjVl5UzabZXMgaWwV6czRZ9FRlFk=;
 b=zB6qNBwHiSeU7tzfz4WL8rvUOWGGOdEO6kScK7nC/FQbCOtZ/x4ijM7BEeNXVItVuowmHbDm9S71+91CuavSKWyCiEqhjkxwKYv8/XmpKnjiFuDpDluc33s+qXq5QdlDgD3QQpBiirtlSNGN2mtz1U3OWsmsbfCC0+lQ+JfNLOU=
Received: from BN9PR03CA0610.namprd03.prod.outlook.com (2603:10b6:408:106::15)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:16:25 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::9e) by BN9PR03CA0610.outlook.office365.com
 (2603:10b6:408:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 06:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 06:16:24 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 01:16:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-pci@vger.kernel.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <bhelgaas@google.com>,
	<alexander.deucher@amd.com>, <mario.limonciello@amd.com>, <jgg@ziepe.ca>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/2] PCI: Mark Radeon Pro WX 4100 ATS as broken
Date: Thu, 23 Jul 2026 06:15:47 +0000
Message-ID: <20260723061548.10187-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723061548.10187-1-vasant.hegde@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b67e988-69d6-45b9-b00e-08dee881ec73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BVAiHhc9v9NA/mdfxMT1ZODCIiAqAmRa+3nHE+1bc1VMFFCxrYgaaeKwkNcPkpPbVGDZKJvj3fUTToRydaPZnYTJ6A4Z2MooRQaKzO20j2jFsW8WIo9rD1GjwsJd3Rhwutf8PlLU9EZMYXEyI0QcIGe+BNSoUYU0rJalsBrYmHtKUJ/GfZrFcpk3Thf+sVaM/dQ9lRcZ2VkEgsP8xbt/yPTXCrM4rTTEyhQRHgrlnyYe3SzV3zIBbV+NGI02d7cRsGw1Dhprv+MRvPwxiYHI5leJQjtgKKqDivzAgfMXkJGCWn5JIB5b/ENJwBulmkUPYX2N1aocJbnmDR0yAdPDdv9OcDVOAA9MBARBFA9GQ5E0CMCNo4lbtWtOzbVmBdBUmeePEFYiIL8sz3E5wZ25Wyj3rqXSnQRwlysNxH04+hOAx1Bxxua7vynlZ+BDCgDYegZTnMsSXv+c2xepP50S94dQPFRIRX15vSPILFKTemXXQcwWir7s71P+iLdRg2+DduuJehXWoMduLwel5DCh/J7c2mX2X5crOj9jKg9IVuPW34u9CQEY8qkc5UA2nWJ0lyraF6QwPFRdJ6QmywIkVslcbbyDH7AYt4eUILjtxaYjUR7ofvhv6bl71f8QzikGGK96y2HfuHI7uETHbR9OuDInsGoctNtxBK7nyUSRkNFD4ZzSWZUR9ADrTyAc7STw3etTZSrmNI+7E9sSujRuAQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Rd+0xmbrWVHnwyhislL9fdjxpYEEye+1V3cJj8CnHV/B9pFWupp+eKI1yXYySXavayOHQa3s5d1hRyDxSeN0K2UNMwfS5aryxDY33th/u5XizFylLPDghPUIA5gFcYqXoqrwjBIlG4EEK/tSQ2CinZuHg0lWmNfSqIaN/ux/PZyRDBLVLuQK57arYpeltRNs0xGFNuMXc/dwcCJKtlAybBqrQrWYu31+yQkul4BPtjplmsJblCIfZ4iplfxS+G9xE9IY/elL1g2S6lWbmlkaFnHhEprSvgNMNb1AcIW4l5JpjEdl/UiVaRmi3QTFrdOnGp4kkSodLP4J72eZ66zcAXiYDlmsBwb3mcW1b4bCDdrXPBS3rN8Dla8EjfOhkkGn/HBz72CU4kFK8eN81aX/5uqpVKQMsq1vRR/JgDSj+Z4KYfo17CoUShOykjGm6enx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:16:24.8090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b67e988-69d6-45b9-b00e-08dee881ec73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

If ATS is enabled then IOMMU logs below error and GPU fails to
initialize.

[  103.687137] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=0000:c4:00.0 address=0x1080006060]

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..d55657347d88 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5686,6 +5686,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
+/* Radeon Pro WX 4100 */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x67e3, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 
-- 
2.31.1

