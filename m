Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730959;
	b=wvS7Wm1qlAMFV5sT5D+jWZeSH3P2LYcoBTUY+KdNWlfx4Y+KKAz4ISI8K0mNTIpWA81L
	 eb3MBb6xz15lnAJFymhnC9pgt8C/MjDG2JIpTyDSE02zah+SpJ5vK++Jm+/7rNFeMv5gS
	 JTKL6R4Grk+n5dFhOZ0vMbh3M3IshG9Tv83tf7FuCfjg68/2GHk1He+BritWiN95G1P7I
	 ZyFP1YnGbGPmKX7iJmSajtiYhMtKkaJAoxkviZa+nZ8RSzFTFu9ryOTIq0+ke80jwKjRT
	 vj7THR+g5sM5U0Hc5kn01aznxh1dRwE+cRfIcaXT0nSWOCgXBn5PWoJp6dBnqDE6tZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730959;
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
	bh=y2jTilj2ofAjm8ZffwaxWUxlgSHpWHzNS6ZFel7boI0=;
	b=E3ovKAMYYdKFfPJwcd6DEWX/3Wd8RCtoMtpz1sa/O+PZSVR8xfCHI2QDIWGJdGztwHlJ
	 vUVimBbGGzbpcVFRHDUxQqcck2Cluh55O3KkqGlw6cnETvsvLz9X8vhn0fhnL1JoDlChU
	 +8wAWdy05yrzdai3C6uSAWgaajVRTMCzbsKL02EdBghqoUKxC+5xTlFh0PuI5oo5TZ9Ga
	 zfA0F507rL0AFvFJLvV/2wyYuP7bA8CUYUCV0kV0yf2cY4J4I2wCDeOIOUL4pvm6Qo+7u
	 l4Bo8D+rOV6/uZPVVCR/EEHfmKp+5tDxuctjXA3cY20xKmMCIQOqGh00acUiosL8iiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KbEzbGwD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.54
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B1606A32C;
	Tue,  3 Nov 2026 18:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094B1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KbEzbGwD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSHgia8PHpV6B5f3h5LRIsZq5ybqYrzCi4eyoE8vafFjVBLMlPdGfo7+ru8HLnnNVbyk2DnSGQjo7BHKjEt8SN1M9BgQNjzpzta+TN8boi0BJ6PZMH9cFHNj3Jv530VJpJcj+BAxszk5vaNbWPemWm37BBj3j/kHJMRX0oxxhQLZkkMc1zAZXFuG/VbDV6Nr2njzlPhWz0hNiOW0718LVJw+UGMQ0gJrDtoTlZg+48lt7kEgdFIlxpuqTl2ZuoTrjUlCvChJqPaC8SdISK0wLUgRrg6XSCi6qrhNQDb9cBK8Eqt13AE8jhn2mCON8g28RL52P9ZCp4QorQo98V/QVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2jTilj2ofAjm8ZffwaxWUxlgSHpWHzNS6ZFel7boI0=;
 b=kRtGuUktLx02opBdm8GdPszXeDq9Uwww2oQBusZ4Y2aZP3MGDJwaZffEEnJF16bUjOUYEku8sY0gqTorpRdDvZb5Xsc9mDBsiBr5vKc8wvwE30j5p0H8iqN2k9pWaYXC4xMc5bv5UOkzfa1mge6rypfY4NEcSxjnS2DAOc/pHM1bDE1J9Lz9q8HPtfX8Lfm8Bhqp8DR+ir6bPpy99hHWJGUuWYkL9m5tDjXw84igxspZ+05pFQLJ5l4akszz7za5YmDMtjtfLsINm3yZa+46DNJG+rqF1mpJhzyqFykxfuFvyyixBcKmhHxsPFgehE/J/rd2yJiz/1iosAtLM1mtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2jTilj2ofAjm8ZffwaxWUxlgSHpWHzNS6ZFel7boI0=;
 b=KbEzbGwDc9BS6ZiVYyP5bErvl+QuZP3KeivcgFv4VagfW2M03jWFZtLJHwx4bXzlfWTegm6cvGonjKsVgjiws3ycfcsBSt/jt3fFTl0a8s/sRqZ78CIEER2UiaA2mgHdLgQTzb3Oa0ilxL7E7HpWb35D1wiYa+MmUXkgbfmHffHSPVlWRxRKd8FyfmcG6snH3WtvdrWSXe5hPhJAY1+kg1iM4U01DOcKqXW5Gb0Bp4QxcyeGksonEpl6u0CmxfprDclfZpij6sRDdz9Ohl9eBe2NzpPeymSjnJX50OLzP/Xb2+X8dwHzWtr58152DkCWEfFSr3U71jV+WW4vyvumcw==
Received: from CY8PR12CA0030.namprd12.prod.outlook.com (2603:10b6:930:49::8)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 18:35:14 +0000
Received: from CY8PEPF00000050.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::a6) by CY8PR12CA0030.outlook.office365.com
 (2603:10b6:930:49::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 18:34:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000050.mail.protection.outlook.com (10.167.247.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 18:34:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 10:33:55 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 10:33:54 -0800
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
Subject: [PATCH v1 4/5] iommu: Pass in gdev's blocked state to iommu_deinit_device()
Date: Tue, 3 Nov 2026 10:33:45 -0800
Message-ID: <2e6bc70edf141ea3a067079951736d086740ca01.1793729707.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000050:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 86152855-d00a-485b-e93b-08df39d911ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|22082099003|261102123227099003|18002099003|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|11063799006|261028144727099003|261026140227099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	tTkiIJxXNo524+0VYk0HeUg9AWlXscNBlXjUZD+NSwGwdf5NKBxC78KmPLMzYYfKcq5bKPgWGOZw7n1DZVgW0reU3xN7OTtZoDaVHc8XStxuQOLO57joRedcGYwnScvXRW5JEOmwoFrVgqSCOzSXT08xF0vP7qzvH/X+vZq1iZiBNMNC67WMWic8iTGBWTFq/AySSNls9Q66nMpWkkkqYC0JMslH+qbcHlBh2qkFjqe/N9CKCYmgtrkS+DNYxoukdSha6Eh8mYkuaS8WsOl+M9UwbOO8wsUHQaNhhbdoEOjc/uV05ErbLphbOpqlr3P0fdj0dDJ+74ejq5q3zn9aQhvXlseez5dykWwLXNACZbxQ04C70QkhEscY+m0eY6cwH0ToB7/uloWA1wcjxA0c3FK8gCzx3cYY5NpSn+YwKdJnaojxM8BPEGCUvEQ6OXQYuAS3C6PbgP/bLBWakfTwYl+dd11QNc0VcXmaKTebF17sArxUHyoTw3CJzhi7ed9Rqs7+EBZomQr51I84aQyFS/l9my2FNlJa9Ewrky+S+aUfySmKYZmGEvvdBmdNZrrqjFn+DWQws6HDd+Oj9rHC5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(11063799006)(261028144727099003)(261026140227099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EJmq7Ht+AiImYIhAF0iLM+aEVcAWvACL68ASxzPzggvI3FyBPxwtPi3XxG1ZS4weyhovAftU3jXVCi5TXUoc0GvOHU+CUdbcwjoFW9Ewg47ApkpGhDL4ZJILKSC7tLNbEIFBGucATI7dqx27i/aF1/OJlGqKzo/dfbUS6QOqXD1IOLKM1msrOCYA7dWyAPduBt68lRHXVg27qRZqmUT3n5wv8UHtD0ZyC8htrl3pd5IDYIRoa40CmrJYoiVG0Yh6U+hom/og2cBUqVxB6HLJf2v11Bt7O7vKfPe5GGzznTsdQZJYXDiiq/Nlx2or7oDvR8bNrxOeIYwrnYkUZCGWBqWK1/SjU3g7v3OG30H4miCXVa1d4YmD4jEqlAD0QtNbTaysbbPGu8t6wE0pfEtlwWx7aAhHYM9vSzvM+QlX3LoyUCLA3uPbGP33nIjX0mju
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 18:34:17.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86152855-d00a-485b-e93b-08df39d911ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000050.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

iommu_deinit_device() parks the device on the driver's release_domain and
passes group->domain to its attach_dev() callback as the old domain. That
is only correct while the device is still attached to group->domain.

A subsequent change keeps a device blocked on group->blocking_domain after
a failed reset, so the old domain has to follow the device's blocked state.
The group_device holding that state is freed by __iommu_group_free_device()
before iommu_deinit_device() runs, so read it at the call site and pass it
in.

No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ee026f5f14349..0d40eb4f15cc1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -550,7 +550,7 @@ static int iommu_init_device(struct device *dev)
 	return ret;
 }
 
-static void iommu_deinit_device(struct device *dev)
+static void iommu_deinit_device(struct device *dev, bool blocked)
 {
 	struct iommu_group *group = dev->iommu_group;
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -703,7 +703,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	list_del(&gdev->list);
 	__iommu_group_free_device(group, gdev);
 err_put_group:
-	iommu_deinit_device(dev);
+	iommu_deinit_device(dev, false);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
@@ -759,13 +759,15 @@ static void __iommu_group_remove_device(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
+		bool blocked = device->blocked;
+
 		if (device->dev != dev)
 			continue;
 
 		list_del(&device->list);
 		__iommu_group_free_device(group, device);
 		if (dev_has_iommu(dev))
-			iommu_deinit_device(dev);
+			iommu_deinit_device(dev, blocked);
 		else
 			dev->iommu_group = NULL;
 		break;
-- 
2.43.0

