Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082983;
	b=psEH7ApdnlPMwYFoQBhat6QlcqQ/RIG0M65W4QnxAzoeQ09iBStoOOiDFwxsePb1afH2
	 C1p7rijx3ntTcw4BVtm/NSX9jIGcfjfLhMyRO7PQ07ml8gFQ8IPWprzEADxYGdSMVCdZ/
	 EbAMUOzsuZCrBmBh4YoAtD1cEu5FHmLwLWD2xZsn66p0Dh8jj5aPn9ALnVUOWOHcNC5Ym
	 L4n9R7jwrf23udsRxKNValMydNeVauaGINog//e/mjvCwKYY5CohsaPWxnz9qhXk4ZXR3
	 i4I7JPTYCmks7Su7zKR+AaeXhZ6ZTNbbxCQ7LvsicQ4iTFtoPLebJquahTtAaNzSTdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082983;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gjFddNFKHs/m6Uq8d/PwRnVIGaAMaDamaS9NVxSIcio=;
	b=GZmeR9WHAdwjrsYZhDy0K9olRQE16Vb9M4eyHMBhj2HjKt+/9uvCr45AQEz91mAYmpA1
	 fRRXA5+Erjsx6yVNDkQn8c+bRkZm4b0hrXnEl6gYXqBNx5haMqxMNPiWHQBzC/FYCozs7
	 kol5gfIcmt7WXrj1lsJu9KTGTn8KpdsmwC/Dw90/K1RBcLXejPsqPy9rn5Ir4+of9+PmH
	 urN7lCZmL6fNIFthLJRpiw/AM01emO/300ubdRpGjdJtAg7zTyOlCaeuJqQBbHQFj/FYo
	 j/3mQs/E3G/YIdVJ1BYYrmysKeRi+jd+65bQuy9Mm8TN5ntZLTveCQ4RfrZSdh6ZeBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W2ZXNfDA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.8
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4F606A320;
	Thu, 19 Nov 2026 10:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68E4F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W2ZXNfDA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwY4+WFyyv+kFQ9D5GvkyVGj14HLBmbfvIOONA7RLU4wcQ+l4WH+MARhTmu/tS8a35PIzQ6B/4LRKl50+bg5x/8JOv6szTrgXyEslQKDYJCQtCxLuf9FRnnZ3n20XjKCkm4fCv6kZrikP0TLeRv0rv8TNifKiPAPFQBY0f9zO51b7olSN3InpP4/Gav5CcFl/fEUdd67fZOWFAzhDq++2KGsUGmTPRvfJrQJm6RKHhakrHD4PrtqltIhHj+/Kwgawg65OxAvI4R1TxES2/vMW6g+/g5Exz5lXCK7167bA4Kcujs6YG/QNHOBAsg8ZhTAfRXVo8RyzzClaEOenCHxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjFddNFKHs/m6Uq8d/PwRnVIGaAMaDamaS9NVxSIcio=;
 b=OlrbWiRqN0WoFPNwA0qM7hZFgjnGezTXeFHuHdgPCFVqG0/B8z5Fdu6nw+Pq3NQcL4sTUL2eSv9Z8IHf/Uu9PNYNTG5KqVVjEQH5gEyQExQZjFjYTkx45GGhpEX/8KFznw9xPNk7nYp0LBfY94aQNRZfv8Qor/pWkdzk2mqP1c6XaaY2AHs89T3tHSW18GLOWb4VsJr/OiZC/amjkWcGA8877XLQpLNQuCj651ESZeIKyEdtE3eJIll1aGegyoGkaM12ilM9y6Ea+oK2A8NzxcSyzoHuu7AUM0aUu5OrecrZhlzpIwmncJYQ5VdLv/vNgFCrndqhKH7HpQP/hSBjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjFddNFKHs/m6Uq8d/PwRnVIGaAMaDamaS9NVxSIcio=;
 b=W2ZXNfDA0IIwaKdHls+bulV+MW4KeVcofAy9mZcIBrOAoXxmu1ko6V2Wz8tjWpfmaWIAcNVsWdmoskyoTilA1JXFCo18Ht7M8duDFDQ9v/2K13TXi5WF0SYodavAANQMrlbJnhFrfZI30YFJfSrn4KZ1tCYUTk2Yjfy0oI4VxOMrgIcX3oCjYL/o0+WnaijPK7WBMgF2CH6N5grNsPuRHlZ3NdAH4My57sEW6baI1LQoowqpVEaeAyEj0tRMffbIc0ubbWQXnK6M/+r7by4eWHXta4X7UC0x5fxUzvom5HZQdG3hX2+bElbp5QAupcca1T0KnzTLLiaY3xfkLVKKkQ==
Received: from DS1P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::9) by
 PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:07:31 +0000
Received: from CY7PEPF000000F2.namprd05.prod.outlook.com
 (2603:10b6:8:451:cafe::93) by DS1P221CA0005.outlook.office365.com
 (2603:10b6:8:451::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 19
 Nov 2026 10:07:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F2.mail.protection.outlook.com (10.167.247.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:07:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:07:14 -0800
Received: from vidyas-server.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 02:07:09 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Joerg Roedel <joerg.roedel@amd.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, "Nicolin Chen" <nicolinc@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
CC: <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
	<kumarahul@nvidia.com>, <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH V1 2/4] PCI: Don't run IOMMU reset hooks when only probing reset methods
Date: Thu, 19 Nov 2026 15:36:26 +0530
Message-ID: <20261119100628.1948990-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119100628.1948990-1-vidyas@nvidia.com>
References: <20261119100628.1948990-1-vidyas@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F2:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: be9e8cf2-aadd-4e34-2ee2-08df4624ec8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|18002099003|22082099003|11063799006|5023799004|10067099003|56012099006|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	r9iEsTyiQDL/nx+Lg5TYgTRJerLXkntQu7Qp7M/ea8bvlntdvDyzlvO7c18f4rXrkjkskbWMuspSWRJdFkFDUQAIdRbkBC2wie24hX/sDGfkFrrGOs7xGkKG4QIZRA5NYx6hmLQZevn0F5VP7OF5K47XJ/JpCyFkWAwdIUb3Xevm8Ljqq5uPuE8GN5l98uq003tfgJMszKWjsbP12mQNXdlF/shrPNOEAV0onqAmqNkaDWnFn8xviHFSO08ldyJ/6cy8JCDRBGIEahbrAdxFrY9DB7jFHdR4fM9ck9SE2Prygngw4auucA25NWLHRybqMyr+aHKeUGAxFicXfMOjYYtGgX8Os9YTSiI+FhSqrh/Vr93HkWGEGGCNtv0OA9bcqpykMDdbHezDD81XoKLeB90Hf9NmqYYropCJvQSMCis0Ewt7pP0TfmkIMi29flJv/jmvpc6C9yOCxDFWcggGZ6pvF6HFiyuZNZyWnibRbfnzpOD6kS/bGCLFN/0YhmGcLAUpfo6+W9lCwyB83ovqNpVhOhzT/mtnKw4YDKRKbuq0+R4M8aACQrGKZTT8jYXpt03eGBYy9NyJ6u+dZdZGDHfJ6M0hEsUEvtu0F7faixAZANE9HyN+djP5xYOzQDFJpXwMoHLi897usYZj5RDRzSwkKEOvLRINaM2LxCIaEWHAj8TDsUpT/HjYqG009cjbxCSk7yVtN77bwHyRMy8U7w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iYGqHYv1y6GX8YMCncrm7uHcGYP33VaTwdnc8gevdTD4iBDcg/XlE5hHP6Fly6Dxz3BSGPWMDM0bb4H7Fq24A2sjEyV7gcSw1HaMJiZ06yZ/gKhnss9gm5GbYK3GXIuNI45ZWgYxdMvd7cjr5t0UCj2tsasID9JhUQEc5JNDV8AZaOkZp7ffAw0XgwI7Nnj4XzK/qcCg0gefIgUs2+PqftBq4YFyDcm14x4jYxAySGozI5DsjW0OwzcLmtjq+TqyErVTUMhchVj1lbJh/46dAl2q/mla+aKDnlSY3BjOljQ4oROibkhdO/ECZc4+mtmxikSzIvNBA6QjlIBLOMvHzHs9rId8kVOAZdQSjfO/l9hlvIbu8zrTWrcFvqzgApsBNoko0zCboxUmKfXH3xm6tgHNlP9kVaJ8O8NChYjLECXMoTYv42shjtPNk3BtVrDP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:07:31.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9e8cf2-aadd-4e34-2ee2-08df4624ec8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834

pci_reset_bus_function() and __pci_dev_specific_reset() call
pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done() even when
"probe" is set and no reset follows.  The other reset methods that use
these hooks, pcie_flr(), pci_af_flr(), pci_pm_reset() and
pci_dev_acpi_reset(), only call them when actually resetting.

Reset methods are probed at enumeration, before the IOMMU is set up, but
also whenever "reset_method" is written in sysfs.  For an ATS-capable
device behind an IOMMU, each such probe of "bus" or of a device-specific
reset attaches the blocking domain and then re-attaches the device's
domains.  That blocks any DMA in the window and, on arm-smmu-v3, sends
ATC invalidations, even while a driver is bound and using the device.

Return before the IOMMU hooks when probing, as the other reset methods
do.

Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a device")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c    | 3 +++
 drivers/pci/quirks.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 921d076c4c1d..918a4d95f914 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5057,6 +5057,9 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge))
 		return -ENOTTY;
 
+	if (probe)
+		return __pci_reset_bus_function(dev, probe);
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..79c326b0e80f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4406,6 +4406,9 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
 {
 	int ret;
 
+	if (probe)
+		return i->reset(dev, probe);
+
 	ret = pci_dev_reset_iommu_prepare(dev);
 	if (ret) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
-- 
2.43.0

