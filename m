Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A164CEE71;
	Wed, 16 Sep 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583844; cv=fail; b=OA8dgl/TwlvNim9hBLPta+QttiHvjWG7YpAGzZVJoybVtbYYSPrbZLLvB3Ye9Eds9wmlF3eLkvBrc8OgHNYerydXhHsXA8HUKK1sXt+z4T9jE4gm6eAp2T7Ag3U4a/5X1rYGnzN2dxK2CDzfAdFSqoPeG8uXTuQP/+x5RyjYUaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583844; c=relaxed/simple;
	bh=M/rBR3GXqAR4hgTzZxOfirWMPGvT9zGSdNlx5Asn1Z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGERotBrfq0ARNaArb5ZgLvSWRWcTTgIBrqcDQqOvESYaXADi1lpmw1Ew30urYivDmt7OhhpbHfIRxQxjgQiR4f2eIyhGOtQDL6UcX5E7Rltoa+lGgJ+eyAbZyP1bRffarVRuXYDAJfKV6xneO895Cv8HtGROAivnRTH1bVC+ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OmZghv0L; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OmZghv0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utrrb56J4EHqIbzhqkDgv4tVB0n/0KejxchOJoWKDznxKB+EB6MqcrRtPbAB5hdrbyvwjmh0OHhcZcO/gceoM3Knd2Zkva8pp4qsqg/xxyW/VEaesdqNfi8yGBlcWpaKAJrv0TstoxwrxfO8tP3oFxGBrKtDcYk/1JKocg9LmdyNPtkcxlfpgkeOUqdNoAUCpPNghhssDq6HYT2wrX/H0/5EKS4ctQr435NIMGv138XUAu09+j3Yd4wP94klENJiFlkt7IvgGBCZZbVzQlPG7zEc75AqJbJE0O0AcuxceLADnw93D2chapBorRLgTokU/bhGYHlbYh/F1+UeFBXZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCZPwERede9MCMU2R+4IpWKA1HMN//WS8Nl+kjX1j6k=;
 b=gNrYlBgyoyNuass6xedC/uLzk5o2Upy00cmYQ6HSp1YyQqMplltEoSjJBzsn5IkpaXq8DfZJIKOOoy1oyx1Icn/YO/sObwcrxUVKifX/Mh/xH1s0CkfBPv+Gn9Es6gbCEuZv/8edqbkmlK/G90D8DMixGD8awet/g8PMedKaJkITZQTAnYZc7jzNJj4sX1uE0ZNefPVLNVm24FPpWd0Y3vMLRMh7JDhM5Xsyn0SysnqRms60FnRNhgpTKczq+KeiODY43Fg6MHzITFE9DVyowZFiJAX3uTt9Spujh6L9LocuXf2nxJLrAnsW/wDlz4nn8wGUd7VXlT74VR+Pf3lKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCZPwERede9MCMU2R+4IpWKA1HMN//WS8Nl+kjX1j6k=;
 b=OmZghv0LN20l8y6h2B9WJBhLTlvKqPn4eTJj3hzn89rZCnyBBVjpQFCME1KrjfGTJHa93rxufIBn9/APcWgBusLMjWilAQi5SSktlr3iQuPkn7dYTHVX4+nN9TSYlLXx8YhM/GJOLQ0+D6x4vLTmZYo75rphRJogev74ZH6d2HOA78pGVzXKc4BE82ukvdl7TftqM7D42PO02oKJ6FvL1sogLVnsidCqLMFqusDxm/HByIthmPEGpJCE2i/kQbK7WDzzZOj6cM/DIQVaUMvH1Qs4hPc3cJP/uX0EtXwdoqK7+/PB8SSz3g+kq8sjngXgDmDLDo0NncXBRy/3LmTCTw==
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by DSVPR12MB382825.namprd12.prod.outlook.com (2603:10b6:8:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:36:54 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::7d) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:36:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:25 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:36:16 -0700
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
Subject: [PATCH v5 02/27] cxl/regs: Let a BAR-owning driver own the component register block
Date: Thu, 17 Sep 2026 00:05:15 +0530
Message-ID: <20260916183540.3813685-3-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|DSVPR12MB382825:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a43844-deab-430a-005a-08df14217af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|10067099003|56012099006|11063799006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZmvP1UJ9rKLJFJqVQ2OOmEB1qR9uhPkHwfYGfrB0LtQx4KnMi9n/ehj4//00ERcLiHEmUgMWF92nT+M5B9gpnNTebwSktcHAS90SZaT6X9WReiyw/7P4e4GfBlznyX9tn/Z1gtJcuJuPrS1dd6pARPFzhdpzUoSAOjyRcPN5cTc7yF6sGzNySDveoR2Xig262NSWT9IM6RPg/QVCeGC+MPVWjgpHg5fK5ucPfDTWBZW5Is8o7Ngt/adn1f0DnfBQBmyZLTKm8pof2l8oSP8Smf79DDyHXjvHZfG/zInAEA2F/YEtHKoJ7yXpQrxZkz3XJ3pI7oVdHaClmzBghlamC1ddeNUDxylo0XfkiZMKHp49Tdy57ShCYhNJ0K/M9AF+YWW4RdAgBU5tGtvAESd1mLWtL5ONjJf2aj+1YQP5Pw7t4W9MqPSyStYItvwuIPi6C2m5lctHPwQnt/6lLfgigxfCLcIdDt8m0c1lbRbblUqA8rlNClPEawvrHSnifiHpY0aksXfJvw1RskMkI99hzwgePmZLsTw75mQSfjSS94YPwKGYzvxjvax1YrDZvwJcVnNN14mL8fgjjaXhbT6InjKY9Ra80gQ10YNjLU2R0nHFAFHNSLHvR/rqVit5cwbt5VwR2vGNeDfKhdShhJbYUJWoksNQ7VpfTaZTfdJwuA5+WisEz/2IhCI3Kzk85d5oGdxZWJF3UbxFt1L335cAKths114fcsYfk3tTLv+zHKUnH271b+EpSp+cunOMO5zW
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8fGOr+mGdwiSdRf6F/gMFvj9dNhuQXpJN+G2TWmrf5U+k9g5WKBrWZWMcTCpH/1lQjAVkrdB/dYiqdH6czxX66Q8YH+VYdIJ7JUDxtgY+JOcZB6KB4UIShgmHD9ofo+Iw41taccqiblc8kaj4ONRetqLJZ81+NKdWZ5s9sI735R4fTtpWIv5qqyHkqu01/kgGr3QrhJioeoyMaKkZhw3ksv+ZfS1nsoic9xeC0SKPcCV1BXi7gCPxkkdygPWbn+vAI0Y5vuJFJPHDdjKmsnGbAtFh2ZTF3koTdUQHvAtdfIlYbH9fgy0nQq8LMJUk1GbXn7B5QOV4BSYVzPsMAeitf9iVhwMzi2Cm9Xv1XyplWZbUmV5epcLLWfEoK4AROFdxJvo822OXAcTM4GeUzQZVkZNH4pzCHL46ypjIwozl3idmHu4Q2YaSjqTEGA2HMO0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:36:53.7176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a43844-deab-430a-005a-08df14217af0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB382825

From: Manish Honap <mhonap@nvidia.com>

cxl_map_component_regs() claims each mapped sub-block with
devm_request_mem_region(). A driver that already requested the whole
component register BAR, such as vfio-cxl, would then collide with that
claim and fail to map the HDM decoder and RAS blocks.

Add cxl_reg_map_add_owned_resource() so such a driver records the
resource it already owns on the register map, and skip the sub-block
request when the block falls within an owned resource.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 17 +++++++++++++++--
 include/cxl/cxl.h       |  2 ++
 include/cxl/pci.h       |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index d79550dbb484..58a7c5cafb45 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,6 +216,13 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
+void cxl_reg_map_add_owned_resource(struct cxl_register_map *map,
+				    struct resource *res)
+{
+	map->owned = res;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reg_map_add_owned_resource, "CXL");
+
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
@@ -234,6 +241,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 		struct mapinfo *mi = &mapinfo[i];
 		resource_size_t addr;
 		resource_size_t length;
+		struct resource res;
 
 		if (!mi->rmap->valid)
 			continue;
@@ -241,8 +249,13 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			continue;
 		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
-		if (!*(mi->addr))
+		res = DEFINE_RES_MEM(addr, length);
+
+		if (map->owned && resource_contains(map->owned, &res))
+			*mi->addr = devm_cxl_ioremap_block(host, addr, length);
+		else
+			*mi->addr = devm_cxl_iomap_block(host, addr, length);
+		if (!*mi->addr)
 			return -ENOMEM;
 	}
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a02792969e0a..92314f67b702 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -217,6 +217,7 @@ struct cxl_pmu_reg_map {
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
  * @reg_type: see enum cxl_regloc_type
+ * @owned: driver-owned resource whose sub-blocks are mapped without re-requesting
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
@@ -227,6 +228,7 @@ struct cxl_register_map {
 	resource_size_t resource;
 	resource_size_t max_size;
 	u8 reg_type;
+	struct resource *owned;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3e0000015871..8e0b3bd0b3c1 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -16,7 +16,10 @@ enum cxl_regloc_type {
 
 struct cxl_register_map;
 struct pci_dev;
+struct resource;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+void cxl_reg_map_add_owned_resource(struct cxl_register_map *map,
+				    struct resource *res);
 #endif
-- 
2.25.1

