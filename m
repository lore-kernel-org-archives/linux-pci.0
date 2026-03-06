Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83818479;
	Fri,  6 Mar 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789058; cv=fail; b=JH3hMb37pWpHrFxnd/cqZDt1MVGXzf0Zhk6y/FeXKygy8fQrrXAFSnwVGW/nxTC4ob/ZAowTmHIz98cZIFYw7Nz2XQtDA/fzZPCMBtQQB41ZXM9ZX/KE3gpZUG9IIosdhUQVnjaEYGO/h9G1qo1c+Oimbi1RdNqrs8xnsgN3Hh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789058; c=relaxed/simple;
	bh=mJqWX/N7gUPp+s92Tg3e7Ov9OxF4AUULdJ7lieMneTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyKgePQyP42G1S9cQhvNij0MuvPdEDqO2Vzr74vYFXW8aGHv8YBQ0Dm56kfuba8fPp9hLciqoOD0FLQZ+jfZoTFcwmv5Eh/MBe6JsfpFNGF38rLgeSo26AFGJlVx+8dyfa9a1QISf+eVjcJUD8/1ye1EllP1hVY9sd286kWtqz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h951KtCh; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h951KtCh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5aqkYJxq148uTPCP7yjj4OG7to+qBYXd5B1pLL8U/PbE7pdqkkwNbgM1P6rUhuhii1mlug9r0sL3kbK+oYIeE81NV5Cc1TkGO+qfbY1sxA5eCtUyY6Ghfbzuq97jOW2qIZon4e95w5MeS2altwZeOmmPP3A0N2a1UvwFxX7RSGbBgXbjh9Jj1Mmq1/AvdHCunhgW8tXjXFm3okYtmvj0Stb5IMaVKvlIKvjghOVl5CBFDxFHUi5/7g91eZgUcuSGVxeshZHeNKwRaXFnb8USw1WeorKU9yEKZBO1KUJ17sqx7ceQ5G7Xyyz1AAunZI+U7HsKRbW0RlzLlrhNK/+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfIWAVwg/IybORJDIpuyYbyThiiQ/NFw4Fqe4THys2w=;
 b=bWtScF/mPEiAUNXBnMc67hDmOil43C2yKhrD6YdHLcO7lvrd6JUMjaw6oikeEBh3gUCwb6GEsJNY2brtBWqFqxW1g+hCFwQSpS9t2jOKdxabuyEokOYJMDjQV+uuooVw1N0ygTGHD2kJ6N/1y/SFiDgBQRAFT/hj3n7dnMFXBdHoRPXS9gIV6F2JoS21abvGvUPBDEK78/X/AFDrOFrBMrV2Apr71mSLukMRYUpJszLpXU1L5Om4uDaLxu7o0+ZokgI3YE0meYnd97TgTY5g0wuCcDDEup2H1uYTM3DTJJUhbqjcDA7RPdoklFaOxMlayJYyyqTmU2AvbmW0zVrtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfIWAVwg/IybORJDIpuyYbyThiiQ/NFw4Fqe4THys2w=;
 b=h951KtChjEUXNjd0AwhmonD/VF9F3BvXF3LdMmVdgaYtyxGcHOlTVd0W/oIfcSKKRMbUP9nRjvTe48oUcazz6O3s8grGXwR28XLbg4ihFZlXlnl7BD0rLehDJc/W22OO9u7cV1VcItpUDtdyMyUDFODS2pJmYrvmLBqbKv0t1cRvKDjL2SFZ3ZD0KgcrI5HCIBgXh5fjLSQTO0LDZxICX0UyPnyI/hUDnmsJVZMm09/bFgD2hbhz0j96qmDbL7eTj/9s24DqNrBzdXj9Ezj168nV+fe1a1lVpV0+1wzdgx2XyNpyoK26fnVZBeR781TSnPfkyMi+Ujrzcdbx5EEyzQ==
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 09:24:10 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::47) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:47 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:47 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:45 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 3/7] cxl: Add memory offlining and cache flush helpers
Date: Fri, 6 Mar 2026 09:23:18 +0000
Message-ID: <20260306092322.148765-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 772fe547-0038-4a2e-d53c-08de7b621f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	9/M5bBfzAdh8YFUSmP5aOoOceUbfmYmrjg3C9IN3IXPBlEbRCxbAoK4ACDqHblPoA1KLi3bvmKVcJWPQpbtMxbHJ0jSXg5HmoH/EoUsklL2axPrNlFiJSFqmEKNgwcjVd2cBZ/TdUmML9UlFZz39Ogq4acc32a7bId9gBdXTI1kOtcvJkleuwjvpY7VZRl52FVMCEmNiA9tHAatsHaaYmp8L3cvNQMgic2I5i0t/Y2Z0tQM/+OnUNfgHxC5zHhXDLCgjwMooh5sOh4lz/biBMUVvLo1UxrKYcDZifEl3rjWVrtsuWdba8EWXcl1xAAyNtwEAxlSNXkIqzXqFREuc8pi0Gh60OKlMxEa/amu049DIfQ150nB3ne52Q+oIxLeDGA7FaBVVM362iMrGS6toCTpNVyUErgMW/X9SInCQPCOJibdYpheIjcnGa0fZZRnJXC35CsyciQS2WCbbCvjP7ghz/5vZsFjAOGAfA8A61iexkaOluoR3X8ciA37PGNKZoBTqazt5w7U0KmzCwW69w9Qu0nYPpeJSbOXwyJoILgHYMFNlk2ihF3f+BpN/qJLvPXzgIo6y7dMG4HlExs0M3aDjNjF4sGr3ERzU6EXyYmMJxlG0hyGIKBk7AhH8RANdQNVRMao1RNRUi4hxadw40CUek/R78HQQYW53OCm6tVrJ/FeDF288sg1v++cW7G2R+WlQz8Ae2MgDXxZoJync1DRNIF/8avHEITk5Seis9OPltthGedmc5nwx907tI24ppAaM9h9erDvGGpxRMjUwSw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gokrnbSvLzBtVnNhaMEmfhoENtA0Uxz07GCJtPct07OeaDBd8YH/wJ7mN1fdeB5tWWf+hL/Rh7I+rlb7HAcaO3eAxTaVgNtfrsZxlw6GxejRist4aHmwRliQYoXQMLi7k+YqrIRuV6LZVMPLIUvcToAOX9wBv846bp/18uhqWG2GO8QdxlXokFMZnz6oAV0bbTbeTW62y61VQSoZn5wxWMBl7wP4ZJuAL1qGu3THNc/bp2erFQAicatdNiqLIS1IESt0m9LMPKPoiLK4bcEpYZRiCMuilaeCrgdvSxUVpA6Q10uzgErJacgjun3cuHqzpjBnR2agR9MDhoY5ypYARKsIz6QyHirjck1pFodIj0SATl6ssqIBEwe735jZU+vCepInwb66I2Nj8GnPYRYbfkq3kdlhGdy2QrwjKMY1gTQUqAS5URZmLc7TumB370KB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:09.4498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772fe547-0038-4a2e-d53c-08de7b621f73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add infrastructure for quiescing the CXL data path before reset:

- Memory offlining: check if CXL-backed memory is online and offline
  it via offline_and_remove_memory() before reset, per CXL
  spec requirement to quiesce all CXL.mem transactions before issuing
  CXL Reset.
- CPU cache flush: invalidate cache lines before reset
  as a safety measure after memory offline.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 110 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f96ce884a213..9e6f0c4b3cb6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,6 +4,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/memory_hotplug.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
@@ -869,3 +871,111 @@ int cxl_port_get_possible_dports(struct cxl_port *port)

 	return ctx.count;
 }
+
+/*
+ * CXL Reset support - core-provided reset logic for CXL devices.
+ *
+ * These functions implement the CXL reset sequence.
+ */
+
+/*
+ * If CXL memory backed by this decoder is online as System RAM, offline
+ * and remove it per CXL spec requirements before issuing CXL Reset.
+ * Returns 0 if memory was not online or was successfully offlined.
+ */
+static int __maybe_unused cxl_offline_memory(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	struct cxl_region_params *p;
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxlr = cxled->cxld.region;
+	if (!cxlr)
+		return 0;
+
+	p = &cxlr->params;
+	if (!p->res)
+		return 0;
+
+	if (walk_iomem_res_desc(IORES_DESC_NONE,
+				IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				p->res->start, p->res->end, NULL, NULL) <= 0)
+		return 0;
+
+	dev_info(dev, "Offlining CXL memory [%pr] for reset\n", p->res);
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+	rc = offline_and_remove_memory(p->res->start, resource_size(p->res));
+	if (rc) {
+		dev_err(dev,
+			"Failed to offline CXL memory [%pr]: %d\n",
+			p->res, rc);
+		return rc;
+	}
+#else
+	dev_err(dev, "Memory hotremove not supported, cannot offline CXL memory\n");
+	rc = -EOPNOTSUPP;
+	return rc;
+#endif
+
+	return 0;
+}
+
+static int __maybe_unused cxl_reset_prepare_memdev(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	struct device *dev;
+
+	if (!cxlmd || !cxlmd->cxlds)
+		return -ENODEV;
+
+	dev = cxlmd->cxlds->dev;
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		return 0;
+
+	return device_for_each_child(&endpoint->dev, NULL,
+				      cxl_offline_memory);
+}
+
+static int __maybe_unused cxl_decoder_flush_cache(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	struct resource *res;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxlr = cxled->cxld.region;
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	res = cxlr->params.res;
+	cpu_cache_invalidate_memregion(res->start, resource_size(res));
+	return 0;
+}
+
+static int __maybe_unused cxl_reset_flush_cpu_caches(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+
+	if (!cxlmd)
+		return 0;
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint || IS_ERR(endpoint))
+		return 0;
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return 0;
+
+	device_for_each_child(&endpoint->dev, NULL, cxl_decoder_flush_cache);
+	return 0;
+}
--
2.43.0

