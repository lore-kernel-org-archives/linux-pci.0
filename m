Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430F372EC5;
	Fri,  6 Mar 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784068; cv=fail; b=GseW9IYyv67auQ34fIN0i/x6OVSpEsnVM5XNKTiKgordtNgCpXbc3jtKZ4piGTb0Kw6ZPkMTCCyeuw8LEz7osV423Xtvvj5xr8SLhTxCQYNg511DKvR6U/JnvVCDWsDfKEQPfcbdEzFANwevZ62131i3XszAK0wQkZeajJuMHzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784068; c=relaxed/simple;
	bh=Wh9X7id2keKAouSLnLiMvW9fiRKiS/BHthQUApRgqQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owBwx0dglreMU2ul/psMbgOgVzw5Ay7K35AWwk38/RaSmk3H3MXlhq62mf3+S7nupdCkG1R3mMrdLKBY+pDoeQvR46bsqEA1Ke9ArzUmuLt3ueT3lGiyMCNFucixBeMQMBpJ6leo8ZYeH9geCS1WlMkDffJk4Q58Gio3++BEk68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D76iax4L; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D76iax4L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prMWsPv/XCac+wTSeRiezPCPOLJ7M5+qX2jTD0M3LwvqxKtzHoRS9SyT9rpjVj9yrO5xR6itnYtlv0Rpl7hngQDNc6hAKcb0kAsPFmcSZ+maR0r4x//DzDTlhkMtPPXl14T4R9Uc5XAACgaTr9zA/RVy4JSOvcx48TCeZBSU9ZJa5CGnx5KsVAYEcgVHnfelzkU6VtStBvYlnjy8eaUDZ+J3OPj2FGubkpxd+ukEG/eb1bcfNFN0mSIZphyMVczxeZHwIW3Isq10vA4x8FqlwGp206jhh8IvDAwTPQ3wdIniPcQBiAtkHX6OwwPEvfGumSANhztbA8zLc3j949vuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfZqF+Ob6H32CiW2O2/WDizNR6lNftbcKXAtWdbrSyQ=;
 b=JRcmyRfST6dAPZrUdlixqnCv3T6VLFTkM7NDznkeM7dGd+sJ+NGeg2ZuVHoBCOjwpVzMijVc2UBCVOdQdfUPz4ivNWz4hivmhHNK/WeW5NdYYQhwDngU/E6gWAHc0CIMwRy1T15OHiwXXKkExTRvn7mKOkmjMRGbuz+jZeUaD/PZS8rKM9jFnKGeAPdldC5IrHUegtItvepS9cxjM42Nx3mRa5buIR/0TbTz7uaZMqkwoSzqVkxHAvmtFHwv08z44iG9+2ktuOKD+6cfitKIQGwIoSQYKiHhQuV7y5v8v0PEP8VQLjfL0c2PVPhZyJaSP17sD+kbmNf6fJevK0pvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfZqF+Ob6H32CiW2O2/WDizNR6lNftbcKXAtWdbrSyQ=;
 b=D76iax4L4AdLTjUXhLxR5vGQkwN6gBxvQBGniDKLjJBcnKkzr4hvU30m+EePPPqlQ1m20tiKIW8sve1JuCoGXPws2/iS5JSMasZJhHw80vMtP2ZNuKr/VXAEpXY1SPJzATRC51wIRRmOU1hzvy4jJwptzwf1SeLZ8iH1B5w8v1xfFhxFmrUSy2UmBBZYzn7JYHoqC9jkqsnuX4dDjqSpWvr0Zcvea4a4uG40/KKg7airZCAsOSn6YuT7UoHftNoQ21BlXBGzm0pUh4kQlVTnrzUUIR/+bHk0Q/w5/Lu+PYfWOGf29GxhwaWGL5x7WraP6HM9JrMx4otQkjaTUaraBQ==
Received: from BYAPR08CA0067.namprd08.prod.outlook.com (2603:10b6:a03:117::44)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 08:00:57 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::e3) by BYAPR08CA0067.outlook.office365.com
 (2603:10b6:a03:117::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 6 Mar 2026 08:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:00:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:43 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:43 -0800
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
Subject: [PATCH 2/5] cxl: Move HDM decoder and register map definitions to include/cxl/pci.h
Date: Fri, 6 Mar 2026 08:00:16 +0000
Message-ID: <20260306080026.116789-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7d6b08-cfbe-4caf-14d3-08de7b567fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	ZfZ6US379Q1KZJwnXcKkz2+3Z3KiA9lrw2LDPnDv5SSS5wYqPqpi58iBHFWAGwN2NMM3f4PZ/Dvab7ssBNHoFw2Pt2qokAVuK6jCgqbxhN/eh2oou4i1tCmtS2w+JDfpJXauglKQKXUghZNOpCF9VpKU0KAOXsKg8YXNkUJ2B75sLvYXxUVbYzhFDadzdiN0YHffjvdG/DN8w15hhxptDlpGCeu/IsOGHJWObIyrqg4SiIip0Scytzof4phjDnxmK/HDdmuwVFhhCcYgtVBN4UVpa/THaYHVTKtRaXjj1ghdqOSmU5YMWiPNlUBbzwgaTus02GtgZ2EiVPEyzYh1GjOajRwjK2vzgNVtPWNx/7wIJkwKQHQ8kKlKo1P18BQG1pGnXFxUUNd6cV2BIlgqYm9vAkI4+/iRWdGBYD6IB+aflC8W5gV8tgsdwSFMi2fOZGBSzMV6vPA/j0WUPPLtUNdC4BKqho1R2K+I2BXc9c2yowB25wnSgrqGNE/VF0L7fedpuSm56HvoWWcVsVT6oFJVArqeQXlHJ9IVx4zdoGLCmzbycoYCfCZ8ak/eoM4kb/CHGwb5T3Y6LcdIDwj+bt5v7wwZmZbPOBwdIt/LdCpG+FT9AwzIufgAUCC8+JDyhRCWpauzaoMMirCOUPfkVEYl5BtbiWuKY1npxQB1JLIXCQ0LlfxQAKDAfenTI0X1tHsS81SS4hI5rpwtqU9qx6cM47OC3ufIFdkmJeKJVsG9YHN03v9IgCB2k8ryn+k0VsmIXGZ13PM6X/bJo6uT4A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UGMk6BAIsehxeKK9NuRraLGjEH7UCfvtrgnVRPh5wCSqLuIfTSm0tEs8PtqjD3lV4h6ByymkqjiUSZOVn/MpNfz+mvia4Jqs/+49CuvJVRlX8EAHuHuEuVoil9SRP8+BGQ30tAlwy2wDF5kaby+CpELtGHoZlT/dcs6f+v7O3iNVjS3XxwdlQnj4B+ywmylTBP+hxdKSo/1f5dfbfNK3b7YHSj8xFtJYsDSfDghFytNuczIiWmXLXtKtFZF1Q4vQwnhsL/zBeqAVNE3eVJk4awM+mIPetpvrgeISP//H/9EDSRBXtCxMbO9arY3QEC/JRXcfXxTARz05a3j0Kjf3PhVnYe39B4UNynmuq4FXTssSGiztoubkLqyg5tQQ/8UnJeqzzO0+iEdU7ybBvOUQP7GGq0IK4DB5YUZZzhR+SrNymBOsF8OEMt+OneqB3Wja
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:00:57.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7d6b08-cfbe-4caf-14d3-08de7b567fc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

From: Srirangan Madhavan <smadhavan@nvidia.com>

Move CXL HDM decoder register defines, register map structs
(cxl_reg_map, cxl_component_reg_map, cxl_device_reg_map,
cxl_pmu_reg_map, cxl_register_map), cxl_hdm_decoder_count(),
enum cxl_regloc_type, and cxl_find_regblock()/cxl_setup_regs()
declarations from internal CXL headers to include/cxl/pci.h.

This makes them accessible to code outside the CXL subsystem, in
particular the PCI core CXL state save/restore support added in a
subsequent patch.

No functional change.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/cxl.h    | 107 +----------------------------------
 drivers/cxl/cxlpci.h |  10 ----
 include/cxl/pci.h    | 129 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 116 deletions(-)
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04c673e7cdb0..0c84695449d8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -12,6 +12,7 @@
 #include <linux/node.h>
 #include <linux/io.h>
 #include <linux/range.h>
+#include <cxl/pci.h>

 extern const struct nvdimm_security_ops *cxl_security_ops;

@@ -23,63 +24,6 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */

-/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
-#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
-
-/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
-#define CXL_CM_OFFSET 0x1000
-#define CXL_CM_CAP_HDR_OFFSET 0x0
-#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
-#define     CM_CAP_HDR_CAP_ID 1
-#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
-#define     CM_CAP_HDR_CAP_VERSION 1
-#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
-#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
-#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
-#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
-
-#define   CXL_CM_CAP_CAP_ID_RAS 0x2
-#define   CXL_CM_CAP_CAP_ID_HDM 0x5
-#define   CXL_CM_CAP_CAP_HDM_VERSION 1
-
-/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
-#define CXL_HDM_DECODER_CAP_OFFSET 0x0
-#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
-#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
-#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
-#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
-#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
-#define   CXL_HDM_DECODER_ENABLE BIT(1)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
-#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
-#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
-#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
-#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
-#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
-#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
-#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
-#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
-#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
-#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
-#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
-
-/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
-#define CXL_DECODER_MIN_GRANULARITY 256
-#define CXL_DECODER_MAX_ENCODED_IG 6
-
-static inline int cxl_hdm_decoder_count(u32 cap_hdr)
-{
-	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
-
-	return val ? val * 2 : 1;
-}
-
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
 {
@@ -246,51 +190,6 @@ struct cxl_regs {
 	);
 };

-struct cxl_reg_map {
-	bool valid;
-	int id;
-	unsigned long offset;
-	unsigned long size;
-};
-
-struct cxl_component_reg_map {
-	struct cxl_reg_map hdm_decoder;
-	struct cxl_reg_map ras;
-};
-
-struct cxl_device_reg_map {
-	struct cxl_reg_map status;
-	struct cxl_reg_map mbox;
-	struct cxl_reg_map memdev;
-};
-
-struct cxl_pmu_reg_map {
-	struct cxl_reg_map pmu;
-};
-
-/**
- * struct cxl_register_map - DVSEC harvested register block mapping parameters
- * @host: device for devm operations and logging
- * @base: virtual base of the register-block-BAR + @block_offset
- * @resource: physical resource base of the register block
- * @max_size: maximum mapping size to perform register search
- * @reg_type: see enum cxl_regloc_type
- * @component_map: cxl_reg_map for component registers
- * @device_map: cxl_reg_maps for device registers
- * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
- */
-struct cxl_register_map {
-	struct device *host;
-	void __iomem *base;
-	resource_size_t resource;
-	resource_size_t max_size;
-	u8 reg_type;
-	union {
-		struct cxl_component_reg_map component_map;
-		struct cxl_device_reg_map device_map;
-		struct cxl_pmu_reg_map pmu_map;
-	};
-};

 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
@@ -304,13 +203,9 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 int cxl_map_pmu_regs(struct cxl_register_map *map, struct cxl_pmu_regs *regs);

 #define CXL_INSTANCES_COUNT -1
-enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0cf64218aa16..9e825c039dd9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,16 +13,6 @@
  */
 #define CXL_PCI_DEFAULT_MAX_VECTORS 16

-/* Register Block Identifier (RBI) */
-enum cxl_regloc_type {
-	CXL_REGLOC_RBI_EMPTY = 0,
-	CXL_REGLOC_RBI_COMPONENT,
-	CXL_REGLOC_RBI_VIRT,
-	CXL_REGLOC_RBI_MEMDEV,
-	CXL_REGLOC_RBI_PMU,
-	CXL_REGLOC_RBI_TYPES
-};
-
 /*
  * Table Access DOE, CDAT Read Entry Response
  *
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..763a048262c7
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __CXL_CXL_PCI_H__
+#define __CXL_CXL_PCI_H__
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
+/* Register Block Identifier (RBI) */
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_PMU,
+	CXL_REGLOC_RBI_TYPES
+};
+
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
+
+/* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers */
+#define CXL_CM_OFFSET 0x1000
+#define CXL_CM_CAP_HDR_OFFSET 0x0
+#define   CXL_CM_CAP_HDR_ID_MASK GENMASK(15, 0)
+#define     CM_CAP_HDR_CAP_ID 1
+#define   CXL_CM_CAP_HDR_VERSION_MASK GENMASK(19, 16)
+#define     CM_CAP_HDR_CAP_VERSION 1
+#define   CXL_CM_CAP_HDR_CACHE_MEM_VERSION_MASK GENMASK(23, 20)
+#define     CM_CAP_HDR_CACHE_MEM_VERSION 1
+#define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
+#define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
+
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_HDM_VERSION 1
+
+/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+#define CXL_HDM_DECODER_CAP_OFFSET 0x0
+#define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE BIT(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
+#define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
+
+/* HDM decoder control register constants CXL 3.0 8.2.5.19.7 */
+#define CXL_DECODER_MIN_GRANULARITY 256
+#define CXL_DECODER_MAX_ENCODED_IG 6
+
+static inline int cxl_hdm_decoder_count(u32 cap_hdr)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
+
+	return val ? val * 2 : 1;
+}
+
+struct cxl_reg_map {
+	bool valid;
+	int id;
+	unsigned long offset;
+	unsigned long size;
+};
+
+struct cxl_component_reg_map {
+	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
+};
+
+struct cxl_device_reg_map {
+	struct cxl_reg_map status;
+	struct cxl_reg_map mbox;
+	struct cxl_reg_map memdev;
+};
+
+struct cxl_pmu_reg_map {
+	struct cxl_reg_map pmu;
+};
+
+/**
+ * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @host: device for devm operations and logging
+ * @base: virtual base of the register-block-BAR + @block_offset
+ * @resource: physical resource base of the register block
+ * @max_size: maximum mapping size to perform register search
+ * @reg_type: see enum cxl_regloc_type
+ * @component_map: cxl_reg_map for component registers
+ * @device_map: cxl_reg_maps for device registers
+ * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
+ */
+struct cxl_register_map {
+	struct device *host;
+	void __iomem *base;
+	resource_size_t resource;
+	resource_size_t max_size;
+	u8 reg_type;
+	union {
+		struct cxl_component_reg_map component_map;
+		struct cxl_device_reg_map device_map;
+		struct cxl_pmu_reg_map pmu_map;
+	};
+};
+
+struct pci_dev;
+
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
+
+#endif /* __CXL_CXL_PCI_H__ */
--
2.43.0

