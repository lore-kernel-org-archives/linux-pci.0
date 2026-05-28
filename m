Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028730567E;
	Thu, 28 May 2026 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955221; cv=fail; b=YdpW58wv0DL/A0/Q9usEbzzHKTv7cy3fPSIBJ8yw1/2uEFSJK3u/RhL8UCjFztFBNg6JqxSoUC8we7DX44WYMkLtlsP6EFwkJPirRY6Id9m6Y+Y0tbuKWFvqxCYyHR1MzL3p86gAAdtYGGT0n51bWAoIhRGP17JDCTob9h1yosk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955221; c=relaxed/simple;
	bh=sxQpg3XlzpT9h1cf7Q1QpeefBVYlSyOmpYTvFd6oZB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1u/3zoaJ9aXTX3AVY4S/9CWukr8oXmFoXLOaKtY3FcQEDY8gNF2U670kgZnOymHs1mLO9+zDdRG458ysbR80McOH5eGByM5TunQChuvgQGft7t9xTWdAiWZFMklvebJB6IQnkd8yqqkOO5OCN1toGzospGkj47/g6BttLOnUeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIm8c8eO; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIm8c8eO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htlqE3ygUXyVC0tm9RCbmIQlvoJgqjeMn7DGOG+UZO5xvpiVLLi9dwl3DMm57VNtS7XIhNiNTIKBnju9U+9WUTlZek9oWYIGJY55pbBtWGDomdfAAj6y5BC6haERJHDRBBUKQgflHCfiJgGeOGzKilg2QaGuZNiX6/LPOImw0xsPIU41M9FGnqHm+z3gZNhBH5GIBMHwGAW4Bap5wC8lF0JvGvNAqXST0J+4gbglTXQ46eHEt0C2HArpiZKtwgxtdohxn0EmgB+YU9gDuX7D43MTX429aikQrr7Yv3iNTk7M1DpaaAUS3JCS6tpNLpITDeig/xdseRK6y7dyKAgKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLc80EXvOpfSk5ynYf0/E/lJMr817pk5nsRqSZQur/o=;
 b=MqT6mxnZ5PV+qQqB9qR/ijg87pcrd0qfm94PpMp+ePJVQhTlOEdYeMXfYF0g/g2/j/LP+72NIAe42QJ1TQ+os/9G/XcQdIR8wehiFB7bSxVWXCmHxaEOLM/0ladA7S5Xj+EODr2tWeLS4bPTKhOv8g8naxjsOgylPoKoCXSluXEUandEzdIgItHUdBEpxt2IGPE20NEn2yHxL1jOUWO7pzvXPoCHAw3SZJhI9shtgrvZG81/UEWCbpSUdL4l6CXycIBFIL1qVhkaD5GVaA19ZYEvzTvaDZYEBuw8i8Dj+u7Pm66mB5z3dMQO5havcbF52jBpK2B56ip7TLf91vwtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLc80EXvOpfSk5ynYf0/E/lJMr817pk5nsRqSZQur/o=;
 b=EIm8c8eOmXSy3GJ0ipRKjm+mIjj/qIkn4WsBsNYz60m+ytj7BitCH2sx7qRixYSVvOmO4EaK8TDFDooAlnda+0Ah8z7hF3cNOAajmN+9MvqHzUVm4jzHmLPgi88WBEUf6bWG/FuTYSdwTTxna0pNSf6lzL6p/7h6ZYaUoK/HOCoFDJSvllvp4fhUdUA5UA4VG2Ct8NsIV1WElOq0M74B3UmCmcub5+qtoBIAaSwBYARxSD3JfHx9z2VN06FvSWV4a/92hsH3ujeDWXqXbuoEc7RdXB8ALWYPjkV6x3IepA+/gtb4zt9rYdbmk3VIUGmGyUG02OPBaYG657LeppuZSg==
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:00:13 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::2a) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 08:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 08:00:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 01:00:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 00:59:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 28 May 2026 00:59:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: [PATCH v2 02/11] iommu/arm-smmu-v3: Factor out __queue_empty() and __queue_consumed()
Date: Thu, 28 May 2026 00:59:30 -0700
Message-ID: <e4e48ebe432c397ad5bd3f3292ceee24a233fbdd.1779944354.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd76fa3-5ca1-4211-8f44-08debc8f2582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	YUujhWbLfFDk+ScUbopk4C49Ezl37txnK7OSYbg9dI1VhX8D3eJd1nYcxUAjrPEpeRoSEV6l5hDSSGxbYm2lkmgn9Pnz40NMJr+AXfiQjAS2BXskVyi/NIxZXhmDQ25SM8ZaTPWCHyJ+4eXZnQCdxvtT/muYuMsiN2McD/VJR9ZwYJU9xap71s7vizqTzJY4DUTT/Lj/VsZpHusZnV552zpSqUIa17oSiognLZWKa1dWiUBQmd5S1v2sxLhKLVN4TYNfBI14umfaFuRNsEfDkEaCxfG/IabZ5y21eKLCGr1Ih27BtSxZWQ2esfPBWq2Og1MssEOw1THx1N6rUrWLrNhy+v36Rb93TSxxv6TGCO8eM7Y7CRvo+cm2urJE1sYvBhBVu1MMnExkAUgBh0x+tMQMN7b7t9hy8Z3oi86EgAd3v66aN10twSjsbA2QAskQzgN358GS8oHVI2B9rjYETzlfQu2uaLSXdOW4o/8mN1luGtf3M0Kl0W9tnMXgi92AVheZ7cYdl4kqOC7MShLPC1t7JXNF/FS2WWnYD6kat3tge0sxB33dwufHobMod3LbjjGpDgosv2M6v9jKKDPshhkUR9rIw3RgQcXzjrQvykYGes8t6/0NLZ+W+Gj9D9wFCnz4EN91r/CQTffOfmBLVVN/b7SHSaMIJr4pj23d0wg14F/UKwGqH0BQZzhZzc7//7hW9tQm4BtKEZEEm0DoaEezsnFCNXCNJZWsIVwduKY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	djafqXCvcJPVXmvdcRqF+EAVX9uU4ZAClxSHfbwHwrx+4LgOxgQjM8DZKJBvp1jmbbrG16dItiamhAs8cuLafZHZgvKUlHzfPV4/mjsEgVGLt2sYsh0Znkm8ybnucospO9UHWHMeYC0Byj4OsFnTatzgQx09kdyCIgOp1GD1m9TZ88mD22jUMWC4Ubz9q/WT0QAXT9QqOg1BFrw1HyCFfKJfYnH315ROPBOFpk7P8ZEDtFShkDTed00PvWGj1QpfvP6RBzcq0Fms+dA8sBXJpbcnmlWdC2dcPQ9rsJr83plEMA1lsrVcT+avWHTe0PYDMP1rtBAjDMi4dK6jHlMQICv8P/OB5Ln/jhdsGbHiPlCOsHqvp1EsawaU0RYfBqL8tkmyzo6bBgIqfd5gkWcdBu5dXuEvURtwLgbezpmAYCNFHiUfQmNX+Maz4IIHebkH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:00:12.6610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd76fa3-5ca1-4211-8f44-08debc8f2582
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

queue_empty() and queue_consumed() each compare a ring-position pair where
one operand is fixed to a cached llq field (q->prod, q->cons).

A subsequent change will need the same ring-position comparisons against a
CONS value read live from MMIO into a local, which does not live in q->llq.

Factor the ring-position checks in queue_empty() and queue_consumed() into
__queue_empty() and __queue_consumed() primitives that accept both operands
explicitly. queue_empty() and queue_consumed() become pass-through wrappers
that pass the cached fields.

No functional change intended; it's a prerequisite to apply bug fix calling
iopf_queue_flush_dev().

Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
Cc: stable@vger.kernel.org # v6.16
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 620c67811df48..cf41b3cf5985f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -146,18 +146,28 @@ static bool queue_full(struct arm_smmu_ll_queue *q)
 	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
 }
 
+static bool __queue_empty(struct arm_smmu_ll_queue *q, u32 cons, u32 prod)
+{
+	return Q_IDX(q, prod) == Q_IDX(q, cons) &&
+	       Q_WRP(q, prod) == Q_WRP(q, cons);
+}
+
 static bool queue_empty(struct arm_smmu_ll_queue *q)
 {
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
+	return __queue_empty(q, q->cons, q->prod);
+}
+
+static bool __queue_consumed(struct arm_smmu_ll_queue *q, u32 cons, u32 prod)
+{
+	return ((Q_WRP(q, cons) == Q_WRP(q, prod)) &&
+		(Q_IDX(q, cons) > Q_IDX(q, prod))) ||
+	       ((Q_WRP(q, cons) != Q_WRP(q, prod)) &&
+		(Q_IDX(q, cons) <= Q_IDX(q, prod)));
 }
 
 static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 prod)
 {
-	return ((Q_WRP(q, q->cons) == Q_WRP(q, prod)) &&
-		(Q_IDX(q, q->cons) > Q_IDX(q, prod))) ||
-	       ((Q_WRP(q, q->cons) != Q_WRP(q, prod)) &&
-		(Q_IDX(q, q->cons) <= Q_IDX(q, prod)));
+	return __queue_consumed(q, q->cons, prod);
 }
 
 static void queue_sync_cons_out(struct arm_smmu_queue *q)
-- 
2.43.0

