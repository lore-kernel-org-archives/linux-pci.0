Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D733F5A7;
	Tue, 19 May 2026 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162013; cv=fail; b=k3AldFEzFOUsmK/TpKuWHvg5l1nkAcBjykOClLqpYpYzUAgdnm0UUsWzl81VvSsJbvabCDXcwlLvHAiwBPyaOar8KhgAZihFXLN2CBrkfooKNyOjHTEnVKd6LSlR6SHMLzW3yal1fuU5Zh3o0EBm8KqfEZ8I7fyF1AdXI/TKDog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162013; c=relaxed/simple;
	bh=c+kUwi+1+sRghcES6cGHBNIq+3HPH7MTlnyh3yOVeH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEIx0vnQ5xkvJZ8oR2fDyOcsa4kNEFDyLfjtXfeXaYtc/O5XlCJ+VFwS69CBPlghEKzXiGzMm932uKLkDYv/AIKVTEXt2F6ild2bsl2+cWTM3mjcqutnONfLE6cDvNJW3MG1/TSDKL5FGjj3/Kkh3WfzaXOGCcF4+2MmJLyXn8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rx3K5UK+; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rx3K5UK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=genJlgPsbi2SH8UQJ26GcxEP4Ma547z/xXzOgNVDebjIskTiPv3ig4Xv5YxEfDbOkwUUe3e1/khTeDYGRNTsSAZyWqep3Z+DYWA8uKHc8xymmDqj8wgACWJIICZketUjg1OoqowManXiVhAPVuFnA2aYbHZ506YMsSs+1GY8nV6w81ixdVYB9OjBPtE7yyMyk6SDw6BfxwRtRZl/XGbuRYCh5F6r5YgYKb0dacIN3vDVgKU+il9K35eQ8XJlr/q1UM60H+J6uy/D9M/rGKd+fNZzVPyZTGGQ7a/k2z1ydqNA1YaSbTGYVpUnywMHWcVLGr6esBiqVk3Ek4uO7jr1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOaeA6CWTcUjj73i6ZiNoPFenzMXO59WLh4V+4tbu70=;
 b=dKwtsiEDC09mQhq5lMavwWSHF0s5VvtjzX9XhG5AFa5g5VUNM7A1qM1A+NF/8L+5PT5En/fnKU6yfUnJehsRU4axPX2JeTWqOntuxWkTv+G57JuScj1fdGE4vrP110cXrfobP134dmJ+mzBfRktCFIiMkKjd23O+JUAPtWpuBTGZu1WzjhvogMVZUwszw/Y5TBpeV8DluilMQvZ8S5iffnDz+Ldb+ycNKsa4EeuylkS3pmHCduFoFThUBC1dTWX6XzhPTZ+dVjRsGGv/aAwBWj0TcczvlDSHMiCcBS/9LYMWJqS+x3P2bwqoIdfxdRvoIYuLwi/cprk8oRRjUW0Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOaeA6CWTcUjj73i6ZiNoPFenzMXO59WLh4V+4tbu70=;
 b=rx3K5UK+lHvfmzwjQ+UHI0nbR1Ew9zIP+xiEQ7F84woY0/Wp3hlDssbvfwr1SI0zLel60lzycS7BM9/O831ib1OCaUm/f7a5gy56GxdO+rfFvgsiPpMcJ/Frs5fRRogZY//M1is08ihFE69DW7IKjyudQwpDNCt1SmwuWjI/op7KX8Uj3bR1G+iyupnIPb3WisM08Fm6bJKaPGrjqLhrR6Vm4m8/xF4mN74nFQvJOtAh3F2y+pGjtjP+oCs3kT3PbJArGqMlWvTdoCGv7Q9sNiUUj8tOpr+sv0/YJMK8I18LDYzTBq0Wu/8NqGTWbttGougRgeSsRCJ2WES2FT+YxA==
Received: from CY5P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::36) by
 SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 03:40:07 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:930:b:cafe::a) by CY5P221CA0030.outlook.office365.com
 (2603:10b6:930:b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v4 21/24] iommu/arm-smmu-v3: Move arm_smmu_invs_for_each_entry to header
Date: Mon, 18 May 2026 20:39:04 -0700
Message-ID: <4d68f61ffabc1fca799543e77e4c0b845889e24e.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 9024e538-8b12-4b6c-9494-08deb55851ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|11063799003|32116099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3NCpUtofLUQUkWNnkEEa6TXpzUlgXvN4hXmR33c0GL0TuDCc3XhtXaO2TevZX2CkBI/39pa3zuolY6bRZ4F8Fwxa2MCqNLTeWSbAlhZp+zrtvlYecjXVaDWxGgJjDMiqX1LxwOAd0ArEjzwI/3YhSMNx7NuPzglbQMztxWswF1+oMawcUfa4404cAXJZM8MkR2R/p2j3AzoXAXWboUTRh1xpqblYpWQVnRYUcog5eYr/JkGfVbMwyDeox8vOywdCAbFQe0KR94XoTGEYmKxczTJHuqoldwNsawT8UR4MVfkrRCJgWlejcYcp9NX66qiAKVLmAPU358CzCK4cPDp9Uq0+m7MESO5W/5MSm4mbU4XH7ai4ulGPwlOCPJ8vKkMzkdEon3Du5OvALWUTMQ8N3J65sSgjV721QuXznLzNPctPpvCn0welq61MN8jRmThURqZsVgsQ4OSXPJ5xC8f3s48YcPfpL33GNxe/JKWx0Q1MNPV9TEzI1kpGNPgjtF/KqOfcLq9xWt68bl5+14JAtQsRlGUFh9ycg7Cgzth305AaAUVLAHArcXB36DfVJvHeaKi1C83UJDsg6w2VjgiimieY0UaBpGwkAgl58v/IrP9Sot933PAbwvMBdtAVwNrVjl/fqoAIg1mT62c+w3dTNBgchVXQ1txb41OSMu7uWzthZqH4bNIRs9tftWC3HkHGHabWRp4qXEB1f7jHfm/MBzzqViuJ7J5smg13Fsqkprg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(11063799003)(32116099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5G9u2hxSDfat6Ztj7ypwOddR07Y9bK7KEvErQFsYCsGdkbSDZ6cMsOXCuclv5cBQeL0BhSkC+uVPFzprsxV09cXF01VhTfquatVMtMLqWhGBtvjcPNwX2TfFVyJg/jONRU5Itsv9yUjfuOqeXJok7ZQbX+3cxqvbkfn6KrW90v4SYJoyAcU3QF3OAWEgO1vkr942vkFO/xjxou/11TRgh6Hs3DGQUKRtOOg2K52li3A3jzaAOjh/E/OP7CFsUyxnbN5cKn+xzDP4FmqDNPljHmQZOa+NYVl885wV3hDae9lgl6GI3UflgLlxEJNpJPHo47CUmno+Ed11bVNYoXRLu8Z4GNnjXWmhrplIggCAh8f4Af407URPAZJSIy0GjAMQmyoxTqSS4TOJbkqoUtZBUafrHQXLOlZCpTGSXvQpYOKmBoL2+gMUlhAB3gdWXusu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:06.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9024e538-8b12-4b6c-9494-08deb55851ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

A subsequent change will use this helper in a lockless context. Since this
this is a macro, move it to the header file so other functions can use it.

Also, add READ_ONCE to invs->num_invs for lockless use.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 28 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 ---------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2074814534fef..b5ace01c05a5d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -803,6 +803,34 @@ struct arm_smmu_invs {
 	struct arm_smmu_inv inv[] __counted_by(max_invs);
 };
 
+/* Invalidation array manipulation functions */
+static inline struct arm_smmu_inv *
+arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
+{
+	while (true) {
+		if (next >= READ_ONCE(invs->num_invs)) {
+			*idx = next;
+			return NULL;
+		}
+		if (!READ_ONCE(invs->inv[next].users)) {
+			next++;
+			continue;
+		}
+		*idx = next;
+		return &invs->inv[next];
+	}
+}
+
+/**
+ * arm_smmu_invs_for_each_entry - Iterate over all non-trash entries in invs
+ * @invs: the base invalidation array
+ * @idx: a stack variable of 'size_t', to store the array index
+ * @cur: a stack variable of 'struct arm_smmu_inv *'
+ */
+#define arm_smmu_invs_for_each_entry(invs, idx, cur)                           \
+	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur;              \
+	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
+
 static inline struct arm_smmu_invs *arm_smmu_invs_alloc(size_t num_invs)
 {
 	struct arm_smmu_invs *new_invs;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4f2b23b1e8163..c95297acf2cfe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -979,34 +979,6 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 */
 }
 
-/* Invalidation array manipulation functions */
-static inline struct arm_smmu_inv *
-arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
-{
-	while (true) {
-		if (next >= invs->num_invs) {
-			*idx = next;
-			return NULL;
-		}
-		if (!READ_ONCE(invs->inv[next].users)) {
-			next++;
-			continue;
-		}
-		*idx = next;
-		return &invs->inv[next];
-	}
-}
-
-/**
- * arm_smmu_invs_for_each_entry - Iterate over all non-trash entries in invs
- * @invs: the base invalidation array
- * @idx: a stack variable of 'size_t', to store the array index
- * @cur: a stack variable of 'struct arm_smmu_inv *'
- */
-#define arm_smmu_invs_for_each_entry(invs, idx, cur)                           \
-	for (cur = arm_smmu_invs_iter_next(invs, 0, &(idx)); cur;              \
-	     cur = arm_smmu_invs_iter_next(invs, idx + 1, &(idx)))
-
 static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
 			    const struct arm_smmu_inv *inv_r)
 {
-- 
2.43.0

