Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD836C588;
	Thu, 28 May 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955246; cv=fail; b=udTlf/6WVqef2527Apd3hdT4mLrr5G5v7DARyxOZ+MAasffI9h+4/uGdUdhK2XX/fVgv4mVHs28DdAEjfNRRUQnS7kbrI6j+SPnn+gBBK7T6M106vebjrW8IuxpeE1B0K3rn1+JExDHBcfiwgSRwF/2iQCZE7Yh3hTrm9q6VIS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955246; c=relaxed/simple;
	bh=yWOdF/ri49gmg7i8l7GHsJaOCYPSKwCIs3M5m1jpBSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxf4liRxzgaMD7jLtr1Ri1+nJrNjDcduXvQJqj7XXBXVTIv7RHa6/7sDUJKBCeIcKHanKt6SdcvnB+OrOLq3LESOhzHYacieqlFE3pEoZFz3vymxbF3JoxiB5Oa8njvma/buyFpx8cozPKdzV4zJzjU1gjJdbQqHixd1XTrFVbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tki1M/yf; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tki1M/yf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY7VUiRvbc/1IzbcrU4MoZAzsUSCQqTS3NftGnvKar4wIBk+GrH2iIUwpeModdYgvaa28/qecPekuiXSOwHfxzomTq05rFnCYVJiKcCdW5PFqzra4rOnSe/XxE9XOylw0R6x+ref2xapr74U0lxX9XwqLmeSSvRCvzvjeveJa1cZspwNUNMbQBMkBKqNL01qmi3XTQl8XRfBD+SNP4CWwuwIR0Q1GP0OR3nD2AePFDAx4IEN2ASbNG2cNQeqlvZS9nCcVnkgH6IwSkfgejvpB4v4/noxzGDXuVCawS0SjauF4nHqkZsT4jN9lay065QLT7icp/ankYSWu1cK0tGpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYvkmqKjyobI/juhf+nZB1062OMV4mxMf1QWblQUgAY=;
 b=QCxDDirYj0DTIfUSTGY9TjNghncLxWqOk3nGkfZsS3Gs5VYh6Hpx78MpJNQHTl9mjSBx7dIrufVo+T20zIeaNGyqn01eLO0Naj7D53hD5PDv2GoUibkQBi1d5zU4tE3W2NlpsqRuHglJnPYjG1GZY4W36fpU1OxTlb/DUWb7DUrbrXuudHpVKNm/YnT2WdJph0dcKAO6OzEhW47Uq9R54QFiKWVjNY2s55F407+t0cYwakKwfVUoPspIdgIf3XKDL35GWT/zY0jZ0ln4JnZB2lYgrv8ExyEXpE0Wz/OzkHXMJeT1Gi2d3yJnv+kjeoNccNrn+x7eLV8RuiktCSYUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYvkmqKjyobI/juhf+nZB1062OMV4mxMf1QWblQUgAY=;
 b=Tki1M/yfCfEPieW7M3BgFIHBr5QwCWEgmkAPviybRo6eIPRV4zV5V2SCNVeJ9Mg9x1iUkxT/nKaWCau/STK+o6ldXPR31KzZ1AdIL3AjdQy8FfoPpWNztkYNXXgXZsu/Oeqr3lpgTxocKIB8rjQ47lJGmWZpU/3+Cov4JIAD+66+HrWzH3HhRH3OuIRnJDaSFTdNN0qXcICtb/rAdkl7utc4niBFNFQHyEbQ9DmFRAttsuwN7lYA6O2u6kqABVPlCckaJ/6jaGRVp6aHHgI3BDJGmHyX9DB6dIXy8P4Zbv1r904DnIblMHNCzz76QxSNORmJMAxGxxqm3lGu7Evmqw==
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 08:00:41 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::29) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 08:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 01:00:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 10/11] PCI/ATS: Export pci_enable_pri() and pci_reset_pri()
Date: Thu, 28 May 2026 00:59:38 -0700
Message-ID: <793f084c38b679a976438eb497418306e99af3f3.1779944354.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779944354.git.nicolinc@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: e45f0fe1-d9d2-4ba4-8fb6-08debc8f3603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|13003099007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	e5bql5oWv6+HTEjIsV/IP4NJesn0+v31DpxMQJJ5TYXuIeYAO8GBY016fVg5NWVFcFdGEuafVFzz4egH4pw2o2JPGGUxGSWCiGMObApmf3Aipnkdzk2xo/rtfob9xYSmnv0S4R1VOuvfBTo2+RzzQmnf73clmG6FpvuSoQvhSnjJRC7c+Es+Cfba/x8gjyugsSSUJhV5B2QsMRDk4aM3B4Y9k+PblNn9kC5Sex1SwaTAsKuNGmfWw7dshhJKkOLM3Olok8w1Z6wux0av7JiiXNz9YPMrk8momHAFXDRuGdeheUdl8GpkoCGBN52XxMPGrAVkhZg2YzK7xDb6ijg5yfYM1gTrcKIhhC9Jl07fEUQMb9jIpjQpp1rKZYuwrjx9g+Evs1qwvodadp6rLB1rFchRNjl9+9Dohgxe6MkbFsWkagrvjPTVB+8l1rwbE0mk8k0sPwJDu91dggGmWf+H7sU2M8NcpEc9h6VLhc5ksMoCjCUc8oteGTTyPO2g+A9rdpjmGKLvsNfFwDFsnXxR+F+N6kb9Rojz/i1l+sB087mrHUeh5qBHoq2y+oiAUNOYrtg0dcsBjyXGbRXJUrzSoyMoKNPA1GeVNfBB/5Ox3iajYprUCsYeQeqr3cL4gcLn7F1B88nmgiUHtmAVkDkjvFPFqBoEFmqft2njH38ZKQ3sVEf/2KgxJGuNvr7QXlbii/heH213oJqsTyS4NTgFV6s/f+DJwGjeg1BBviGfT3M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mGoZvbTpD/zeurODyhsyImqqwEOULseOn0+92hVCf901TenJOwVNZAw+CmYElKx59pxPUAlw07hvDmjxC0buy8W6tDdWeAlNu2RtcSlZxFgp6orCeK7im2d1t+lKdmpmgabhHmJnGUmRhP6Vj5ltPCXkH83thcqcvGHnGTQvPdKt9rN5oljh/X8Vos3h8WF5uEapNT4WWJIn2Mh46LoSYZ6b2+p9f9ucVtjwqwBCRHf+951SBl7678MuTxABUktmR3E24Ke4kgPTGWAyTaKTEWQKV74AoQWLR4M0gAdlLjDb5U9//ak1mZwQDaC9XDq8b11WvWkBb7ob+Xc8JAfXeXF5ICPjHTN19UqT7/Nc5HG0iNfhJ93NPZlq5SuskkfS7hYFmwDybWhoSnK7GRUsLjq+UlJmQm1e7zDb75hFrUCjSKe8HOeyMKjkYYUXW2QO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:40.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45f0fe1-d9d2-4ba4-8fb6-08debc8f3603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The SMMUv3 driver, which is tristate, calls pci_enable_pri() and
pci_reset_pri() from its probe path. Export them so the driver can be
built as a module.

Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philippe@linaro.org/
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[nicolinc: drop stale or already-exported APIs]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/pci/ats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9c..c844c0cee3cb7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -266,6 +266,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -345,6 +346,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
-- 
2.43.0

