Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730875;
	b=C9ePNcMChTUQ8fr/zYu38T0LdDVFrsJ3jcKrJ6ryAYAsblMk1pdfXy9pvcw/LvdSHPdE
	 CEOrvv/vWefVtwVrkUKiLYotxvYWM6pTIuMqd3oAO1bkl7M8x9w2PaZhiMzLTLAdYR1co
	 UG8sLY/y2cQqKIR92LfXrEsjNe9uWf8akj5Zcc6XLUbww3Hx04EXSsspSCA1wulqfBKRw
	 XRSXabWUjfMwE28I00f4LblkvnaywFJE+s0pKCllh1IuTvw5Lp5CWvwnVdy/G/XuIPayQ
	 uBK8fscttlKVsD5LLtEivPplaoV+kUD/MGfcKnrAHKsXOl2uaZKrLXnldTTBx9hCd8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730875;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iwYAhfXS/HP2aFDklWQfXsbMXz7RjTKydewO9qBBDaE=;
	b=lAs5ThEMqWi7S2JPOXh+S9Gx6OyQ4glvYnGFCPiWnJYvdIH7Njv0oG3SLhCPc79UAx64
	 JqfMHif3dOPUrsvID9akSydxdp7Yq/d3PH6T39FWM14R4vk6Zh95ngqq/RgJ7scZkq6AC
	 bQcl1xK6Gt6Ed6tmFNxzJsO+hLI6QYILPXz/Gve6hBi5no/bLyE6YuX2Zqt3q0IRdsmnm
	 4qSv7G/sKSutC2+kEFunqY873/Mpb37SqHW8Aky1U6v2zmOnimD7WNIodNRSl8CeWaY/v
	 dfsnelBLmK4U18risB8LJYtOb1eembPY4QVC+Kfv/5j2omtaK6hGbO/Fug87xqcHN3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fyT6En9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB2606A334;
	Tue,  3 Nov 2026 18:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24BB2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fyT6En9A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZXpW6qCbEhA1Yjvnt8Oo7dOfksVv4qVDlvAGNyAC64LfUDhEwC3pgSA3yv9GooBE4hoa8I8dt4YI08kM6ln7XcuT15QpB7Z7hkczjB0WGIUIg1g5bKoWnyJfZA8hqJOix6QcGXKeMICX6Qyjh95wQ9i4oTjVbg4Qmq7mWaANxiVI6UUoM4rGxulPoz18VdnNWPgUXuPyisV0SfFW1tb3jufFWkRu0AiAu5nViYPeBbM9h0xS7gvgOW+Jm1AVVGU5Cj05CRb3w1/MAqmpJkAAyDs2sexQazajijltX55RHPBkwcVksdG6ExyyxucXqET/Sb3XH0E9LFiVDIFoaM3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwYAhfXS/HP2aFDklWQfXsbMXz7RjTKydewO9qBBDaE=;
 b=nXG6N0BH8VPRjaX4XLgkB7WqYj2Z17xFBiLwUzItcwCOfmoUntX+g+uRUxYtOrvBlZGxeOm5SrRNvm2eliAHmr/ICdZG/pZtC/O+J7qbNKf5Iu0vlisGR72dzzqkD5Sy/RawT5i4W0lGJJLNLOVhR8axPNZcYrvE6mfTAyu1R+62XtEswFaxIL8b1h/HZFlisM2MdGuk4DumBNshAQ5inB0LTHZKPpLHlqbh8INDaMsl+hWhP3N/Q13HOKA3WsQkGusN4sAmdqCL8vovuPEduKjPVs+aow0pCARsnnECsAAKZ8Y/9MqCc8NEgHZr/6gpJXerjh3tkj0zZQkzjfWOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwYAhfXS/HP2aFDklWQfXsbMXz7RjTKydewO9qBBDaE=;
 b=fyT6En9AAjbXGINAYKQhYF/rIIuZMgyyTpwSvgtlc6Lc+X8SdG/lVHaZzuMLekAlPkWOC5bGL+9y+97EAh5ujdONyx6PITNGJjCBT+fBWeERn0C5s7h+i1CyRBy3JVTk9Z2JGDeOh2ABwiJRBWoyI1gxjSkRjoHRbww/4/jeKxNxRUEyk/P5T8DOKETidDFsDgAmDx+7fZGUdDJ206XR0tyd/R6FhCuawJE92RgjDVNAjNnSF3p6sqImOn3GLcnjiwEEfNQ+ri/0xPs8f99yjnZtNOn1pefHPiMa0Sa7tlgdmOxJ/+I1C+omKeCkcpsd5YDy60n0ghv0Rx2XlmXNVQ==
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:34:14 +0000
Received: from CY8PEPF00000054.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::77) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000054.mail.protection.outlook.com (10.167.247.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:51 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Joerg Roedel
	<joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <djbw@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 1/5] PCI: Don't suspend IOMMU when probing reset capability
Date: Tue, 3 Nov 2026 10:33:42 -0800
Message-ID: <c66d5221a8e4356316d4f614c8584a80dc9d71b6.1793729707.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000054:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: a7360186-7afe-4589-b501-08df39d90f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|23010399003|22082099003|18002099003|56012099006|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261021135927099003|261009223027099003|11063799006|10067099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	kTGlM8IPkVNtqM9Y2DrKMK5HO+h0du5nEUXlG+WDja3iGFJrXfHt4aKZYKKK43/xt52F6Tw8JPYV3o3TIm+FhQ6wgkqp5vhruQnbA+dcGbHg5KWrSc/oSXjec9zbgunbFrTQFePBJr4oX3NEfT6DBIGYmVmHB8yNM6Bku2q8lRw1xeyw/EqMf5KH+XdEQ/iCznWD6Y00Iu+slKirBER5EMouQqIUTt8kvKhL42kpW92XlV870yNc1LlMN7Ws6RLYuzx6AhO0KAiTLAsCsnQWCXuCa0KccHxqCvSpEhI2Vgnfi7KsbEkaeK552DBQ0NMwVCnJFxWBpTzTUODnUKy7R6/Hq00RcHZPezSLG4jDPgonpEN++yY15breSWKNIGhSOgSiElvlfWR/bLEWsnAWmQnyzDdLmJRxiSZYckjRA3RzjaA9IFaNl+lZt41zgpDcDTNJVGTqxmv2lNJ7TITXAzsEABqup3y7drFALtzBfGd8qacVPHlqYP1+lRFvxDQJBG8rliAOeTvoIvTJx04bDVojTXHpYNm7RZaCaeZ8HjO6OozGTRN7Ho4ZYKp9s7oDXbmJxkiIpczGka6RcC6bLI0H1Fh3ai+EOzY0S6xHFK6+pEeK0cDhPrhmS9prwYgXXOung3ARK98fcq/+NiwHCri+kXhN/G+5Z5AqIUL9Gc25foYtcu3wdZUxnGTSkzIP6EKrKznkfu0yBO8U3XrrkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261021135927099003)(261009223027099003)(11063799006)(10067099003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xMFgO4A1DT0xaOdPh/U+m3G4Jtfegx1rmi4LynkdctvIP/fNbYK2/Dh809CGnw1i+6Sk8KPtLkrOwwUcevHTtvx6uABrqiFNPTiU+U1OuzUshDnf5W1hkO9KiLvQtTRV0ZtAiwJJw/JCEaJM2E4zoPT+8R538hTNn/CMXajulkx+awaZNBQTCIOSymS0ND55x7e3BUijjVgx+t13iLvPqI1DkLLqQ5msE2bnK6N2s55nVfEtasFqMQvNvmhQ9uGJxeO8WGWaryHspai1SPdbXBaonqea4BSrI2TgCqmMPptNRtgJmgl0lP0PCKJnESSY5G0SZ5BtImMQ1e4Kyapq5QMt+SFMPKWn9BVgG80lmfIWEjz2/JGdVBXSYLp3iR2cj3sechPkKXX4mhtMxPlbidoaNuHhZdLUroCT24YC1iocFvcKF0XAjsznwlwDtOJd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:14.0934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7360186-7afe-4589-b501-08df39d90f96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000054.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
device_lock, since the probe path is expected to query the device's reset
capability without changing device state.

However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
that contract after pci_dev_reset_iommu_prepare/done() were added, which
moves the device into a blocking domain and abruptly aborts any in-flight
DMA. Doing this for a probe -- a state-query call that does not even hold
device_lock -- can cause driver timeouts and data loss on a DMAing device.

The peer reset helpers all handle this correctly: they short-circuit on a
probe input before touching the IOMMU.

Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
inner reset routines already implement their own probe semantics, and they
perform the capability checks and return without changing device state.

Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c    | 13 ++++++++-----
 drivers/pci/quirks.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba81443..38b680e7c3d60 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5042,10 +5042,12 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
 		return -ENOTTY;
 
-	rc = pci_dev_reset_iommu_prepare(dev);
-	if (rc) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
-		return rc;
+	if (!probe) {
+		rc = pci_dev_reset_iommu_prepare(dev);
+		if (rc) {
+			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
+			return rc;
+		}
 	}
 
 	rc = pci_dev_reset_slot_function(dev, probe);
@@ -5054,7 +5056,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	if (!probe)
+		pci_dev_reset_iommu_done(dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee41..3d3e95cb9f7dc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4406,14 +4406,17 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 {
 	int ret;
 
-	ret = pci_dev_reset_iommu_prepare(dev);
-	if (ret) {
-		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
-		return ret;
+	if (!probe) {
+		ret = pci_dev_reset_iommu_prepare(dev);
+		if (ret) {
+			pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = i->reset(dev, probe);
-	pci_dev_reset_iommu_done(dev);
+	if (!probe)
+		pci_dev_reset_iommu_done(dev);
 	return ret;
 }
 
-- 
2.43.0

