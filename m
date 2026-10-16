Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D194FD781;
	Fri, 16 Oct 2026 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167625; cv=fail; b=BEmG8JkFCvg01Cg/GzN8eYvPxUuApgV/ihcKmoM3orSn+/b8wUruCmLP2B945dLqjcZ5/QWQYLqVSD9orwPqPZBDEK86Rt0qh5bNsnXSOkIcUy5nmzPh11MmQt7NamFRwiLIngCqHoYnqoWnJVg5RUcRXFptCNtP7tzuRiAYjlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167625; c=relaxed/simple;
	bh=OuPnnyn71UIv452rke/D0eYxxJIueFbFSj8bdV8QGqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkNVnWqOcLd1IIst3SP2DY8rqqVDda5aKmBs/6D7H9TrN5tRAhwVZQ3MlaObfHMWxTSRLY/wmpAI2JQ1RG/Koi4a00NG9AOgS6kiO6Gj1mrGiSNql6HPOxuJ0a9inz2EH9+LcdKEhh1P4YDRkg3e/7eRmBuemDDzAHSYgGXnhOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNmoHx6f; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNmoHx6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAL5ybZb4Yo8OcM4eU2JatBnKbiDOgZ51I6D/1HbplFemgOzwc1PAW28ZMsnwKhubErxJNzrVFcVyYptFSHMP3ZegOLOlNbYfz1t+/Uo3FS/r01dzj2+jefWWrcYAiXUipzyO4tljDRrfaXPRiJoyZz8i8ltB0o6QYpT/NTZGZfQqAtP3hYs43uCaRHAJpDnCyfEq4fgW210rHadrqY9XfClWwDk9RQyuTx3NsgPXVxAh7bK+vtrCpNLlaU46xe1Rk4dhDZVuUNMcSSCHUsHO5qeNdzTXVeqWRcR2MkRCpwXZuX9TN1To2YNnvMDBeGY9hb3IisMiykwMB/bqciawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWt0IXCxnS1gaF27mgb2swzk+1YnvZLjKelVHShHeX8=;
 b=G6V9bbqHxNTaWyaG8opXbyeD4z9pHuecBKJq+tebJPg7KgnKM6qRnWoGCBxhU4pn/ySbPhCkJI/7OV0gwXS6X5ZFnsXZAQRCgtMUmIC51et68LRGZX/nZr4SzGvZZJ887EoM4qG+8Zgq7DzqCDnh1bVXyWYo7BV8zbuOl3/ukekqIWX+xubdNIa/Y+y8zId/L3jz+oJ2w7PY5deGG5/PywpoYWZmf4gvr5OztYMagPxd9GGgZu9TgIlaoYkQrrY8KrI15CZ4MVGEiuNne31fndHUdZ2cu+djji4DX9XTU+8/G3IfBL+i1fO1F50GzLlm+s3KlJx0vSImRF904iw3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWt0IXCxnS1gaF27mgb2swzk+1YnvZLjKelVHShHeX8=;
 b=lNmoHx6fHGWEEjxTM9BsOYO4cBRA0wcgBnHsxk3JMt2CWPdvppdo1bqMLH+xA1M/2xoL42U6p4Q0I5Gu2Sy0Y1n8r0X2DmoDl+N/rZoVNwJt+kt2CFk3HGMkAt/vBapMV2l/+giY/p9nnXvL6I0ZdrCR/EXDBmokrrmTUTfx7gUT9SsKlblGHueu/4YxbW8Xbyu3b/6R2RnpupZz1dJNih9nMaHVJ9uhdJLiPkVt0y/Ez+9Ka5GVNVPTZhJhpVcZhFK/x3Kigu9180XYmWQy5JjPk/1du3GuC4mvCGrjvXKFTVSZH0k6PSsJELtj0IzGcFdVCi2CGcyL5/lb0cfLbw==
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:19:43 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::10) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:19:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:19:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:22 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:13 -0700
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
Subject: [PATCH v6 02/31] cxl/regs: Let a BAR-owning driver own the component register block
Date: Fri, 16 Oct 2026 21:48:09 +0530
Message-ID: <20261016161839.2765592-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: b182d77e-9164-46ef-a44f-08df2ba149b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|7416014|82310400026|921020|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5tw8V7B6d2vWFFy5ebfoeJCHxmYtxm2IYXqbPGRLNT7UmKWEM80K1zqCx7q9mXqmw4PPHne77qmNwoyp4MdhD+dGWAPUrYHBuk19PilUfzUTd+2kr09llMxyW0vqLE3z8GAxfAALWRByEwewhFAlGd9ZK4DodJdgFaNpF/fFe3/YWXUH47vR3bkWFNffnB+yl3kqQruuHsfNMyeInQzW060cewazb0446lRxcDE6aIh1Phj5Vi9YJfXANtxjZ8kDAgGhuDNnTZGruloXvM3Avq8G3u/qboTQGgWZgJ9Ptdpp606SmBrbty60kgDy71E7Ho1+WeVHAxZeLz9Do7LbOnCVlJCT2K1Kg2ZslCeLIfjkn9xlXsl4B8TabG1G6v/uIVz+zTpeMnDD6dmSYPo3abvIo2lUhMUuHp9zPzTKezzvbEuD8lMBskX78AVYH2YI6P6v86oOt6bj+X+HLQMoFbcTSobclqXqUjnYtV8D8mCvMKiywNxxW3YcnjJHQ2v7qVYayjW98kHhGmaMenibuzTrqjhJwum0myQRTBB1PCvpCTuH2DgBYCsSYeMFRxt2l/T5DMkw41GDFeACEoJv41JIsT5KN0HTYpY7vgpPoylcstYJe3xc2Aa/aRrzNmYTeQXOwD/2MW/c/pLnQkdXJCO303HlPk4Y3kh9SoIPTM54qISD3twB0qe+Q4V3FTwsqmKZ2TP5IWMbHWEnMiq5P69BCDRQeYKxKiXprNsaY/+5kSwl2Co1iD/DTF9HuM8D
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(7416014)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G7iVXF+L+sW677vTeDOr+qifE7XqOXxM3pb5GtC1nXMv0nh9/K6IGvZQsIRNvOcyNWVt5To3wcPlmKsqMAu8MtDrgJL3CixRDrCcBbeFME0+6/4AMtct/avyG5rWVu8E/eJXIeFZ4PW/rM5f23vyJBK4lfUQIedMZUNWLtILFrAJ0uTJx9f+9HNzy6ryuS9cRmtHS6phlDRMrXquZHxaiBVfcuWd/dJ3/+nWPeHUA1euMhPWdtLICNPmIw5VB+fCWG2CAJ/AWN33ng/bbHlfPCYH3DMl3jmrfZ3VOdNaRSGKKOHWXVyM5P+5ys0gFx9LlCMuCoMpBV1AcWW9PWv4Yn9pCkAgOqkEUlTUSnbh1Xd/ff40dnUUl9aPv1JgBlNAztzxcGhg/4Alv0HCWyWzRR3tcK98+b5/mXo9orORS7e8Kockw4Ilpw6CgByzPy9s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:19:43.4933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b182d77e-9164-46ef-a44f-08df2ba149b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

From: Manish Honap <mhonap@nvidia.com>

cxl_map_component_regs() claims each mapped sub-block with
devm_request_mem_region(). A driver that requests the whole component
register BAR itself, such as vfio-cxl, would then collide with that
claim and fail to map the HDM decoder and RAS blocks.

Add cxl_reg_map_set_owned_resource() so such a driver records the
resource it already owns, the whole component register BAR, on the
register map.

Skip the sub-block request for a block inside that resource, and fail with
-ENXIO for a block outside it.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/regs.c | 46 +++++++++++++++++++++++++++++++++++++++--
 include/cxl/cxl.h       |  2 ++
 include/cxl/pci.h       |  3 +++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 9235520b2f4e..c3df99de92c3 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,6 +216,39 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
+/**
+ * cxl_reg_map_set_owned_resource() - record the BAR a driver owns
+ * @map: register map of the component register block
+ * @res: resource of the whole component register BAR, which the caller
+ *	requests itself, before or after this call
+ *
+ * A driver that requests the whole component register BAR itself, such as
+ * vfio-cxl, records that BAR here. cxl_map_component_regs() then maps the
+ * blocks inside @res without requesting them again and refuses any block
+ * outside it. A register map has at most one owned resource.
+ *
+ * Call this after cxl_pci_setup_regs() has filled @map: enumeration rewrites
+ * the whole map and drops a previously recorded owned resource.
+ *
+ * Return: 0 on success, -EBUSY if an owned resource is already set, or
+ * -EINVAL if @map has not been set up or its block lies outside @res.
+ */
+int cxl_reg_map_set_owned_resource(struct cxl_register_map *map,
+				   struct resource *res)
+{
+	struct resource block = DEFINE_RES_MEM(map->resource, map->max_size);
+
+	if (WARN_ON_ONCE(map->owned))
+		return -EBUSY;
+	if (WARN_ON_ONCE(map->resource == CXL_RESOURCE_NONE ||
+			 !resource_contains(res, &block)))
+		return -EINVAL;
+
+	map->owned = res;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reg_map_set_owned_resource, "CXL");
+
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask)
@@ -234,6 +267,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 		struct mapinfo *mi = &mapinfo[i];
 		resource_size_t addr;
 		resource_size_t length;
+		struct resource res;
 
 		if (!mi->rmap->valid)
 			continue;
@@ -241,8 +275,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			continue;
 		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(host, addr, length);
-		if (!*(mi->addr))
+		res = DEFINE_RES_MEM(addr, length);
+
+		if (map->owned) {
+			if (!resource_contains(map->owned, &res))
+				return -ENXIO;
+			*mi->addr = devm_cxl_ioremap_block(host, addr, length);
+		} else {
+			*mi->addr = devm_cxl_iomap_block(host, addr, length);
+		}
+		if (!*mi->addr)
 			return -ENOMEM;
 	}
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3e70f74685b6..4bd0fec4951f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,7 @@ struct cxl_pmu_reg_map {
  * @bar: PCI BAR containing the register block
  * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
+ * @owned: driver-owned resource whose sub-blocks are mapped without re-requesting
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
@@ -165,6 +166,7 @@ struct cxl_register_map {
 	int bar;
 	resource_size_t bar_offset;
 	u8 reg_type;
+	struct resource *owned;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index b15d7e415e27..0b74819fea6d 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -18,9 +18,12 @@ enum cxl_regloc_type {
 
 struct cxl_register_map;
 struct pci_dev;
+struct resource;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+int cxl_reg_map_set_owned_resource(struct cxl_register_map *map,
+				   struct resource *res);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
-- 
2.53.0

