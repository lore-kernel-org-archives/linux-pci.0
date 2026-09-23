Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10FC58039E;
	Wed, 23 Sep 2026 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194368; cv=fail; b=KpeWOqU3OxPIz9Ti0Z/RkRKMW01sj76VAL5t//cd7oR3hwVEf7RCizVRQzgh6nVhLreFh4E9LucNlVtDfbAOvMgXN8famSKm9/lGYGMlqEID9kC49bpMMPW/gJHaStQ46/MZJ15Dm3u646zfcbxiZWjQouHr3otC2f8v85O8aZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194368; c=relaxed/simple;
	bh=mxnuKjp+QxLXE9UGlPEMSNQ1pUwt+cmtDFarvgP1XIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gV/1m4lv0EDhRTawiLP+3EJrhLRb0PQFIpHrVJF+7KUUc+XdOwA9j78PosiguIFBrN+zzeljXCwpOMs3dyzWMRpPfsgAVUqUXzrL6AQ3QpzA9vMqi53rEh4x7WBn8w/nI5c0GHnKACg+BWsOyF1fDzRyfbbeTeh1N5XFu9gqLss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lG2iaSPb; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lG2iaSPb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsZk8VW4RAC8PalJp0vlUtGWv24Y0Kf8W212nx+UrMo3HdVvcDTtZd0CX6oDNkqLTiblfHh6ljvX3/nv1wt672JRtO3noZ7gVxiTSi4O0bt7oe/BFTqJqMgPHJeC+/fUpttytsmvHGHsBbgVSSpw1xeV1UeSRH4s/IYN795mEiqTQImJYgsWSsrtwo8skHEQclSRGIAeD/d5v2m1XAMaucGDpm8r9qZHyxKS0O3lg3KN/7JiwfSKxtHPppo+iY4WIWMrNPjfBXc3lCLGJ9TMaSEJUe7NLdB5gJLVWPgnrYFMxg3+ssvIX3O/VB8IfiFd1myxvUTHLAykpvpggHFu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGeY5jxBK8p24UxyxnT6U0idhJwU/M3YjA3+pOxuojI=;
 b=Il74BUxUFaLOETjQI+3Hn/BOPl+voKlZ75V3AYnH/eavshmR37QctG1PjpdNYHP+qWHLWD+QMvnDCLxj1uRoU2B6hm/lGJWnFYLq6qiyyIvNnAOY3uClxTCAd/O5B2Y7p0BJ9PvhDBi2rwx5jFgCtdXeEdoDbDlghAhgDS2auSQrfYtVqMreU6EEehuaf+ZCEYCde72NkMAu/OIQGVsvM4VOwSeaVZ9iXxsLgKHteavZOdaZbp6UJsutHobQs9QDf8i4+yb4iNEF08Am2xINVzQM1QQihcK4LN48wyfA/xJppFUh8E8kKVRy/vMkGTTQEsMIRhCh4iNg1SMKf/U9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGeY5jxBK8p24UxyxnT6U0idhJwU/M3YjA3+pOxuojI=;
 b=lG2iaSPbNKiglL0qqtvzfaNQUvLl74nqJsaIw9nviuY1I++MpukIBGz4DQ2mfaRIq1PTO/DuAphLYWLWaA84jLZMza9rRYdoecpDec9gQnph6hCFquTylbaIsol9RGfdkwKu8YlPLynGk2PAJEY+UPpu+C/xyeZVTmu8PjsxkA3+lNmRTX617wfyH0nNE5MSm8jSrcrfL9tMtCcpdcTjsDxrAr4ygn8B/OZ7pU+n+qCb2gA329nRd5lwY05mboDZEgQN7Yv3knvscC1cTp2yM2Vqax756/JwSsNY/RStLSIh0rc0XLvxn39muqzABQfVVquARQm+REWv7w47pESkgw==
Received: from BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::10)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:12:17 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::82) by BN9P220CA0005.outlook.office365.com
 (2603:10b6:408:13e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 20:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:11:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:11:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 01/17] PCI: Don't suspend IOMMU when probing reset capability
Date: Wed, 23 Sep 2026 13:11:20 -0700
Message-ID: <7c2bec39656a79255ad330bb7525565eddb758d9.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ac223d-b8b9-441e-a710-08df19aef78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|7416014|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XmGHSLBetURmq8VAkjG6PgnZxWEGuOzqsUBZ6phMnhzRcCUYV3qaBd7btlNlHw0uJDIWLXMWC05rjS27IzgT3gKAypxzbabZKoopP53RDZb9mMSCv3gPdFgilTX0Kj9F9zmPEGnudogNIyVZlv06oNzNz6bOYlgUCIzGcVbSi9ArI97K7AKGJTGG5iNaKz3w/YgDuOTRoE+sPIC/aY4uhzl584IPhb4Dzf39CbF+JL4BDttSIcQLMsiv0aTe27jGpmPSiWGBLOJVgLiUyo2HnZZJjMvycCQDj0VGO52G/EwZl5d8U9vJ3SZ992oLmlodMSBdvKzQ978Q9Pvehh6MsMzyOnzN6Rrj2JXmS/9wOFOXUTgIF5t8vN9seLkHYRJzoLBrznssNCfENuAtAGcSHoL6D8aEvJYZiIDGcyJI2DjXcim3xWZG0hvmN7FZJTv2aSuRXpBR9BU/7zQNTBLBXHjIBTUMg5rkRPDTKSN26QmELaMnXnnJP4EJnR3YqEI+hQSXNYPIhoEt+mjgzxeW0Mf1FWbzTInySSZ7kIayeTVpeBIhnOzRbq2K4VGxGecvH8jnnuMyLFY0B4dGgVjBbNnOraYqJ46rZPRFpLgHcflHA9uX44PPnpvlI9Ffh5tBV1yugy+mmjw45R6iPY/NvIzr24V+/P40dbev+6x1u6FS48jMsHdFsHicJVbvibJm4n+Pl7i515dJccAa9lgfWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(7416014)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XYGS5xaLTZrKxevMtWAHimOV0MdST0TQz231cay3pp4mSygU76bm+uOeXI0MeSTK1yh18Wyx95fYDiPlZ+5VWyhZHru4bVjMt7b3lSBCRriLkN2uHAxALKAYoGKQv4A31rsJDWLRgWH9r26q2y6FYQWxgf56sVLYk070rJDxhnLfXsYxInsAeir7ynTjm4UyacLbenEbbb7aaYN13fW86j+wyH497MJUOhxlsXqbFgzV3gHx54ixYKbfZPiuYsaK+kxWpg49PgbXX90k5EBTQHjwARCGPEyX5+RaXRB2KL2jLqe8sKWoFbthalek82e8DclOyUQfV9mIlWty1pivThJD+nmKgeU2SQk6P2P+4PgpHpzbHFfdimsOLkBx4eMmuIy1ElqXTfT+KcOX8+Q5OB38reDHaFAWF2BBRN85vMCKZY73+YAgHDjKrPYQxUHW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:17.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac223d-b8b9-441e-a710-08df19aef78b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

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
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/pci.c    | 13 ++++++++-----
 drivers/pci/quirks.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f80..1eba412b7e0de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4996,10 +4996,12 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
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
@@ -5008,7 +5010,8 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
-	pci_dev_reset_iommu_done(dev);
+	if (!probe)
+		pci_dev_reset_iommu_done(dev);
 	return rc;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21fd..7858a063929d9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4253,14 +4253,17 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
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

