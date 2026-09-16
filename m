Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208684DAFB5;
	Wed, 16 Sep 2026 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583833; cv=fail; b=rAVZgUne+FhwzYr1CRcUaKw+QKaHGyFm/LYGRCi9zg+vD9FI8KsM7WkcIbuUmc1P8J+eqkprOx9UMvOrc9+eX8oCspGyG3NbjpEG0yyGSKpiM0nzC7kJMrOPtgVnh+OrHc2B0fqpMPIOYlvAkLGt+1ZAgtpGglYxkqGf8kmGTUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583833; c=relaxed/simple;
	bh=IC6vn3X1VMMBI7YHpR788VNWxBalfoFl+2LwP05FyH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXmAHNkX/jSTDQ3KrUyr78pFEV/+RgKBbcdj42mW/0x5tdB2OAiyZeC4gLS2MbJQFwhaX88kRPd0IFs2LcM2n6RaXolpOeEFWa1eESicqO7nXi9zUOrsiZOci8aosxRzU6WpuLPwPeHA8cxW0/hlC096f9j8UlPNM8X7xwvnTgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CM/u/VZa; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CM/u/VZa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3TChDNxkE/lWur/ac2ZfLENvza9zWcJfFwOiqX1h0IoTJUAczg3C50IhwfoCApjHr0eJNlOf6m0bKuSRkRT15p+B9ESNReeNwrQKL00VINYfFD+Q4UyVFInXhc7OqHdpPJRM14bvqeej65FnMciori5kxdOxnzEyPc/BuUSG5MC9FT5yo8LUU82uD6kEaFE4moTwBnlQ4ZBeCVRqAKMvr2DMa/nfyb0M+KoIoUcXXt5KXFUU9sQAH18tz4CLhr6I+UBsDEHsXbcnxIvmWiFj4BJkywyTtz3+v3ucTGkDF3/vZwVwdiEPFNnH2Pxzb9jXyqc5CBgtUER4fJLfBaYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPDimQCpMRZ2zwHgUKQ+mZadhC+KU4LVD+dKbpAN+60=;
 b=kFgClq5m0hdZvuHhr4stvJdLo/GW1I5iKSZ3MyaR29E9WJ2dNA5JkP2FV+lSZSEGWZHQOd8aPeIpyEK7CCHvlH0TgClasQeNiQ0SzX9f7+Iur0kuh8fa1c5RzBq2Fdc7UhEuKF9/tZiahXVe7O2f0HMbNZ0UPWkJoVUQwneehhZ1e6jBzngsFz3BCWzpU9c7jGIA/hZwn6ivqHFP1Jl1fzOiXBNyOxedgRWOTXa+AOihV3W4I+aCjW/+/POVnTiRC4K87Y7ckSkw980KE78XgjrGVPbhYZp5Ee9RVSdisXl3oajRduF1/m3jJcHs9TdzT8MpkX/JaK2NXBmO3VWybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPDimQCpMRZ2zwHgUKQ+mZadhC+KU4LVD+dKbpAN+60=;
 b=CM/u/VZa0RLBO1AfZ2BKi56Sgi/pXs5zynJqRlw7BvrnfWavkv6VrOg+lpH8CbZbgAEhlgRe5PMPcTR9ZH4rmD2emfwO9Hfyf7vLYsWwHEe9guV0KYSIwZx9hvt+CliVFnwWgYn8ECOUL2IOa4r5ZhHpki6q/tURZ+jpeR8kzpPCy3vjqpgMa3lv0J1k1neUSMclKqBWPPME3aAtM+v/0F9fFOwuRwipEIfaqc14BqlOHJ24MinmVyNVazGe5yomI9wPJ+aDJSegAbl2iYDbMUrvKQcaoDvqZcj4ocKKJLR/dJiHUhsJLXYHViB6JKrJaWaohCaZCBrPFRDE7u257w==
Received: from BL1PR13CA0216.namprd13.prod.outlook.com (2603:10b6:208:2bf::11)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 18:36:49 +0000
Received: from LV8PEPF0000006B.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8b) by BL1PR13CA0216.outlook.office365.com
 (2603:10b6:208:2bf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 LV8PEPF0000006B.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:36:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:16 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:07 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 01/27] cxl/regs: Split the BAR block request and ioremap helpers
Date: Thu, 17 Sep 2026 00:05:14 +0530
Message-ID: <20260916183540.3813685-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006B:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: b7341e51-9c2c-4f89-0d65-08df142177e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700016|23010399003|376014|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BoVyYIxbKOGhCMaZTDKJ9bQhRyfziOjzXPfFQq082WX2Sa7a7nS1zQ+O+lG9M4AGoQ4SuD03nU+U74bmlYHpgbmuOe6o5wWVa56XQBo+vy/BvuZ68DxKDdV44f1wKevEvG2XMEdTvcflshKXEz8r8eKnCSsd5xMtr5B3WA/fTzZ93/75gG3dLbWteRP9PctH1XnqksRnIJSQf9W4SHp2kLMUZQTGdJSwqJzcdWxgR9imqICnRuhTdX2F8s7xfswkffmnsF5iPLkFKPEktB+sjo/Ij4jzT9JaVds4e85mcro/zVycQ2XrTK/LNUs0AhoQlSEdHwXFOM1XBCrnZdIlRNaA2Vor1Zfc+NWgyzodpYuvDslxfHKj6IKYvR2+yIAjSJHmX3aPfd38EIZRV0e0guGay5P0OAnNqQu722Nq9KPtn4q707zfV0x5CKImjOVKrjH1TnFEC0X6MQN6Uw3VgZx57GrgApbPbBFuKAaDW9VWTlNOvz21diJSJOfUmahbJXXwwT30HWVZ0I4zuCg4EuKdtmdkkJz447EU0k4MJkVtAfkNXmGQX8owJTE00xbpG4Ny/ksg30BAo+eehVScnkdq4EH1P9+L10ej0EFUqRPvpvoqpNO1WrP/wMl8bChQWPcNOcrXC0xtgoK6zLTIYaKKS9PGEMknj6deiOwMSzt0+uvj1+xSouQAVOFJxINb0xJ6sTIg8oodFig18hjC9sAOCDPvVLLEYs8j+Qlj1I5IgUxQ/jRPw3Bwj34W0v1F
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700016)(23010399003)(376014)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+z6Lrj9Msi/vLkU8DyAVcHeSotCKSqotQK7peVn7yXq/B3hn0/buuBepQcxHcuKAI7KipWufu9zIPPFF/p6Xqd+CbBY2BIbAnSn64mQHzhrY2WsGEnbwJnaPxLbb0kicWUPtUbNoOZaDBdCe3HjoJCVDbIW3Fi4kC9YADPkYKKIcJtyT8ms7/JV4n0TqSV4WlGXXfZRKSN/flsD/XKGRXGxzgNTZop1U0ymeZBt9ks0E080v48RO5DNZhlWTotTIV9NX9HhrlrMrqzrZYEf/ngHiC1hYYmRUTLQCYfWDN7EMArcjrXuSAPCtUxvKxrIz1E1UA1xbJvvQelS7VYstlo8sm3PJ4k/ZbF4VKWgEdWzI2MVefv24Eky9lPeza1C/3uYnG3Q+i08Rui4pUBjMFG5HzeqA5/aDGMUG6WzyCMP8vy1DezduW7L0YVuias0j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:36:48.5972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7341e51-9c2c-4f89-0d65-08df142177e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

From: Manish Honap <mhonap@nvidia.com>

devm_cxl_iomap_block() claims a register block with
devm_request_mem_region() and then maps it with devm_ioremap().

A driver that already owns the parent BAR needs to skip the sub-block
request while still mapping it, so the request and the map must be
callable independently.

Split them into devm_cxl_request_block() and devm_cxl_ioremap_block().
devm_cxl_iomap_block() keeps calling both in turn, so there is no
functional change.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 989e79383b99..d79550dbb484 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -177,6 +177,20 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, "CXL");
 
+static struct resource *devm_cxl_request_block(struct device *dev,
+					       resource_size_t addr,
+					       resource_size_t length)
+{
+	return devm_request_mem_region(dev, addr, length, dev_name(dev));
+}
+
+static void __iomem *devm_cxl_ioremap_block(struct device *dev,
+					    resource_size_t addr,
+					    resource_size_t length)
+{
+	return devm_ioremap(dev, addr, length);
+}
+
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length)
 {
@@ -186,7 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
 		return NULL;
 
-	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
+	res = devm_cxl_request_block(dev, addr, length);
 	if (!res) {
 		resource_size_t end = addr + length - 1;
 
@@ -194,7 +208,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 		return NULL;
 	}
 
-	ret_val = devm_ioremap(dev, addr, length);
+	ret_val = devm_cxl_ioremap_block(dev, addr, length);
 	if (!ret_val)
 		dev_err(dev, "Failed to map region %pr\n", res);
 
-- 
2.25.1

