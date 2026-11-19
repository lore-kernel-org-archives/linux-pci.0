Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120201;
	b=ebeaZCQzSU2yTCw9NjC5caLKS/ce+v3Q6DNrrzli+OqX8a5KHaAv+55Bokl+AGTPOjBH
	 U4WAgZaJAZHo7RgBHCEJX3+qVui0QKFbcNxOqBq6qzXc3hjNPHlTCUNCemq6Ey5sItPZU
	 JMgtXI555Wa+d3/QMd+2siSxp29U2zegwD9wckLkCHzfSPcdtHLVHy/TdnCVOfMMd2ddJ
	 wiBqLaIYX4rgpLofqgmnQ++6CsaV3e/bq1pcl5ATalVgEaAA02EHzXxoEC0OsPzE1oMIL
	 Nq3CRZObv6H5i3bdpsr5NdyT3zqKtBS/tEuKjM7jPKR7LGLaRRpBhoNrJ0GfPwz6Xfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120201;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=S1APifwzJ+I0NYZ7SwPxTo+nw1nVmfQyRClwj6VQJ/s=;
	b=kuKItRVh7ddonAInUgTzWqQoTY8vg5a4ljO0D7iG4WNMsUugkHRb07tHh+JWJgJ4aBj7
	 MKw5oDdO68hWBWDmHBHs9u123ObHxiUnbccXdHuHokA9fI6otjxcdjLTYBuyrUuA0yAIB
	 d6G6U0grUc9XA8Fq79ZMWIKDWsrqqLim+HtMqHa2NABy6zoHO9YhY+fQqXHxDVv+tiK94
	 BSthKy4qg7ErBUWtbxUc9ImgnslYdOYylQlUrj8It2pzFa4y0wNttEi+i13Sai76moRSU
	 18sLtpBntN1kC1fiIXtLbo3iaSjS4VlvnI9vKMMkadWeSQqa9Hs+jgotk0N+DZDzibQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=anvuvoGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B2606A331;
	Thu, 19 Nov 2026 20:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3B2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=anvuvoGR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UagCFxkee6A2+QZetRpVFGRl7WV3Ws62jfEMaPvf0xrnC+Lp654TXksIKbB9c8m2IX3XZzTbdi++3y9OkweU3Czg7bidbq1lbVWsmRC7qQLf/X47V3cZydfogqYOU5e4V8s6xvy6MJRuvyC4zJQqpTH1ozWe1Jj78UMwr+qVTDOXfUL5KLABztnzHZMuh+WEP6JOhw5TEf/O4UJ01J/4ZQuI42kH/1WPYrWEqlMl/+YRYU0r6aYpcsBFnOT/boLg7myZkeE1U5/xaokzTaZNSzVQALCFUrS4AvJv/XhWrmvdVMtk3LI5kAqvirKBtkNNsRHqMhAGRspxwS0dRdBYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1APifwzJ+I0NYZ7SwPxTo+nw1nVmfQyRClwj6VQJ/s=;
 b=RKb1B2M6b3mDz5M7A52HQit6GwjPZEdDSc1+51Y4IaiQ9TmDbVRPr9CmzEdx65zYsFLwTd5P7fp0UuDSjdlfg9AkEX0/aNK/IS3ngdVj97ZtDV4fZi3KS2jnwC/rtvOIGyqpQhekR2GHpVPH2s40ryshuwvMz+ZbptbxC3tMchnfv9Y0+ROMh6hFzzk+A5HGWtb6W7zTDXjx7SoAKybe4q+RT+C5y2LOJ5ADyN8GAMtyV4RpjhtbyG12YdyviCJJejDfDAATHXUegpDEtyFg+jwQxy4tMTvzjHJT2wq0Uy4LFOwt4gidHdWt+fol7r5wBS+jLU5BHb8UIVCeMGZOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1APifwzJ+I0NYZ7SwPxTo+nw1nVmfQyRClwj6VQJ/s=;
 b=anvuvoGRV/a05LfqNP6mLzsWYWT13sXS97iFIpzICkKMaix39Wd3+CT4cSPrVfSwPIUWFFXRah6V6mv76uDLlN8kA3qo/3ucDysOl8zR1ZPG7EhRUo2upP0Cqqlx+7v0HxUNhLXMn4joVMgf9upyoKMDvXFbjZ9TFBBO/Tv/j18=
Received: from CYXPR03CA0036.namprd03.prod.outlook.com (2603:10b6:930:d2::20)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 20:29:56 +0000
Received: from CY5PEPF00000E86.namprd05.prod.outlook.com
 (2603:10b6:930:d2:cafe::a8) by CYXPR03CA0036.outlook.office365.com
 (2603:10b6:930:d2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:29:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E86.mail.protection.outlook.com (10.167.247.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:56 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:29:55 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 31/44] dmaengine: sdxi: amd: prevalidate QoS operations
Date: Thu, 19 Nov 2026 14:23:07 -0600
Message-ID: <20261119202321.1734355-32-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E86:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: ab34d851-106b-4133-7fda-08df467be006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261022075727099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gpNvXSKUSequ8bxrWM1sjomQjZ21GBgop9NmEVdwFWzo1G+cqYBwecVkT20TjDwoaDPfT0b6kBp5coUdoKgzXl5HwiUC8LLmWRrE6R9/TEdUZZN3jxql9vUKqXXrynEI2aLNSBc6cXtNR4PsbK8RBom8aaum8F5+nog0GQ0KsvOiaz1NxTs1Eupp7YJiDunZ0gSosmqRx3BrdAk2bK0b6aSTVszghJj+GPBiK0u+qvPK+i9NURsN8PMbMyWR8PxVwaws8KAbnz/vLVwfbrqyXeB+O6hpwDDtzpWxDYepFpqYKAmt10GwrlXZv3ESjIIX31jHyQ1yTjJy5laGV+uwy10Qjpi0nA+657zv/t6yrHqsAV5v4QvpT1qrAqT5eSm14PoFlRqBaKxyokLLpaVok3G7KtZJHvQrsmxp31yJqgMA5XC2ISjvnm52XZqb9wZpfMoSn/BLY6MnxedqC4YMWZXqocaA8lc7OiOuL5LEgVFqshjSK5EYTJjVFLyAQpbzk0fDO7ye7kLGSa3mS1e7MtiDWL8kTYt4cjAPaPI8mA6GlxnF8GmzEc9EYXWa9OOMqIB7Fl23Fp2jSM0/aPzKt/ao3ouYAsimgRBZ1PsMkplhVDk/rWuof7cyhZCm7uUPljnxH+sJFBDfBOxqeHDYGz75X315sPJTjvJ81N0CsLe8iHh6WazWTJh2Nz7hEnWoE0UfcLtS7gJHIbMOCqoLEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CWta43xNihIWeMh0HuSj9l7HEmpd89cm+Frz+mCjROJ/mM+WY5aANroG5Wx5kaz02uBgAzYqUMKlkB2jAoFY2UuoebkX6sjUBi/u9sKRYK52097yFm/7IUgJT5n3Ea9BkNFg4LMrCtAlK2cXOC63xU8rj+VgTU+B4G0fZWKB+4vLfoumMMl45ZvXQEILWWGGObvQBHyWfxG5Wj/4Pat64zKaRGzQbx2LCJsJKd3KPNnKcFSDvSzrgs/kIj2In36C2LXWk7nlsicwO+YGd15pNlixvbcly6Df4VA1KWoMlBYdoWpZjxlHfc19YE8pJ4qWe8gJ9VwCm0YoQYgIYn2eUkht4ljhupAY579jlSMB0+D5qgsuuZDh0iyRTcQHaMoQ12/qln0kCR32X1XO7XBDy+QOQcT6kSas53wJ65UaV5U8VG/U7c16Kr9RyueNXNFJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:56.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab34d851-106b-4133-7fda-08df467be006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E86.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

Add software prevalidation for QoS pool updates, function assignments
and telemetry requests so predictable admin faults are rejected early.
These helpers will be used by code introduced later.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/amd/qos.c | 174 +++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/drivers/dma/sdxi/amd/qos.c b/drivers/dma/sdxi/amd/qos.c
index 1899f89bcb90..746e4c8b11e7 100644
--- a/drivers/dma/sdxi/amd/qos.c
+++ b/drivers/dma/sdxi/amd/qos.c
@@ -590,3 +590,177 @@ static int sdxi_amd_qos_get_assigned_functions(struct sdxi_dev *sdxi,
 			  buf, dma);
 	return err;
 }
+
+static int sdxi_amd_qos_prevalidate_poolupd(struct sdxi_dev *sdxi,
+					    struct sdxi_cxt *adm,
+					    u16 opcode_type,
+					    unsigned int timeout_ms,
+					    const struct sdxi_amd_qos_cap_info *cap,
+					    const struct sdxi_amd_qos_poolupd_req *req)
+{
+	struct sdxi_amd_qos_dev_info dev_info;
+	struct sdxi_amd_qos_pool_info pool_info;
+	u32 new_minbw;
+	u32 total_minbw;
+	size_t bytes;
+	u8 *bitmap;
+	bool pool_known;
+	int err;
+
+	err = sdxi_amd_qos_validate_poolupd_req(req, cap->max_pools,
+						cap->granularity_bw);
+	if (err)
+		return err;
+
+	err = sdxi_amd_qos_get_dev_info(sdxi, adm, opcode_type, timeout_ms,
+					&dev_info);
+	if (err)
+		return err;
+
+	bytes = (size_t)(cap->max_pools + 7U) / 8U;
+	bitmap = kcalloc(bytes, sizeof(*bitmap), GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	err = sdxi_amd_qos_get_active_pools(sdxi, adm, opcode_type,
+					    timeout_ms, cap->max_pools,
+					    bitmap);
+	if (err) {
+		kfree(bitmap);
+		return err;
+	}
+
+	pool_known = !req->pool_num ||
+		     sdxi_amd_qos_pool_active(bitmap, req->pool_num);
+
+	switch (req->pool_operation) {
+	case SDXI_AMD_QOS_POOL_OP_CREATE:
+		if (sdxi_amd_qos_pool_active(bitmap, req->pool_num))
+			err = -EEXIST;
+		kfree(bitmap);
+		if (err)
+			return err;
+
+		new_minbw = sdxi_amd_qos_align_bw(req->pool_minbw,
+						  cap->granularity_bw);
+		if (dev_info.total_allocated_bw > dev_info.device_maxbw)
+			return -EIO;
+		if (new_minbw > dev_info.device_maxbw - dev_info.total_allocated_bw)
+			return -EINVAL;
+		return 0;
+	case SDXI_AMD_QOS_POOL_OP_UPDATE:
+		kfree(bitmap);
+		if (!pool_known)
+			return -ENOENT;
+		err = sdxi_amd_qos_get_pool_info(sdxi, adm, opcode_type,
+						 req->pool_num, timeout_ms,
+						 &pool_info);
+		if (err)
+			return err;
+
+		if (pool_info.pool_minbw > dev_info.total_allocated_bw)
+			return -EIO;
+		if (dev_info.total_allocated_bw > dev_info.device_maxbw)
+			return -EIO;
+
+		new_minbw = sdxi_amd_qos_align_bw(req->pool_minbw,
+						  cap->granularity_bw);
+		total_minbw = dev_info.total_allocated_bw - pool_info.pool_minbw;
+		if (new_minbw > dev_info.device_maxbw - total_minbw)
+			return -EINVAL;
+		return 0;
+	case SDXI_AMD_QOS_POOL_OP_DESTROY:
+		kfree(bitmap);
+		if (!pool_known)
+			return -ENOENT;
+		err = sdxi_amd_qos_get_pool_info(sdxi, adm, opcode_type,
+						 req->pool_num, timeout_ms,
+						 &pool_info);
+		if (err)
+			return err;
+
+		return 0;
+	default:
+		kfree(bitmap);
+		return -EINVAL;
+	}
+}
+
+static int sdxi_amd_qos_prevalidate_fnupd(struct sdxi_dev *sdxi,
+					  struct sdxi_cxt *adm,
+					  u16 opcode_type,
+					  unsigned int timeout_ms,
+					  const struct sdxi_amd_qos_cap_info *cap,
+					  const struct sdxi_amd_qos_fnupd_req *req)
+{
+	size_t bytes;
+	u8 *bitmap;
+	int err;
+
+	err = sdxi_amd_qos_validate_fnupd_req(req, cap->max_pools,
+					      sdxi_amd_qos_max_vfs(sdxi),
+					      sdxi->max_cxts,
+					      cap->feature_flags);
+	if (err)
+		return err;
+
+	if (!req->pool_num)
+		return 0;
+
+	bytes = (size_t)(cap->max_pools + 7U) / 8U;
+	bitmap = kcalloc(bytes, sizeof(*bitmap), GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	err = sdxi_amd_qos_get_active_pools(sdxi, adm, opcode_type, timeout_ms,
+					    cap->max_pools, bitmap);
+	if (!err && !sdxi_amd_qos_pool_active(bitmap, req->pool_num))
+		err = -ENOENT;
+	kfree(bitmap);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int sdxi_amd_qos_prevalidate_tel(struct sdxi_dev *sdxi,
+					struct sdxi_cxt *adm,
+					u16 opcode_type,
+					unsigned int timeout_ms,
+					const struct sdxi_amd_qos_cap_info *cap,
+					const struct sdxi_amd_qos_tel_req *req)
+{
+	size_t bytes;
+	u8 *bitmap;
+	int err;
+
+	err = sdxi_amd_qos_validate_tel_req(req, cap->max_pools,
+					    sdxi_amd_qos_max_vfs(sdxi),
+					    sdxi->max_cxts,
+					    cap->feature_flags);
+	if (err)
+		return err;
+
+	switch (req->query_type) {
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG:
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_REPORT:
+	case SDXI_AMD_QOS_TEL_QTYPE_POOL_VARIANCE:
+		if (!req->pool_num)
+			return 0;
+
+		bytes = (size_t)(cap->max_pools + 7U) / 8U;
+		bitmap = kcalloc(bytes, sizeof(*bitmap), GFP_KERNEL);
+		if (!bitmap)
+			return -ENOMEM;
+
+		err = sdxi_amd_qos_get_active_pools(sdxi, adm, opcode_type,
+						    timeout_ms, cap->max_pools,
+						    bitmap);
+		if (!err && !sdxi_amd_qos_pool_active(bitmap, req->pool_num))
+			err = -ENOENT;
+		kfree(bitmap);
+		return err;
+	default:
+		return 0;
+	}
+}
-- 
2.56.1

