Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120316;
	b=HqhLsJJvfTRKIcgQ8D5ijc8fvfZDMzzkGObwC9e5YPlQez+EbuY2dt4NJb73Xjdp6ysx
	 yMXgBZEP8RjDT4iKx0DFxNzDZtLTjzUVui8K7DW0R2Wg+WLoEZa3SNGeJiRkxNfURDQZD
	 t+4UWkDDW7KQMtVrc2q20LwKa/cbV6PafwZbFVXy31SnrAWBukV8mt3Wrgo9h9iNSWIAz
	 L91+lT80NE4MEnyZcr6oIWPYSv7yysuInbn+WdX0NPEnhFJhKOga+5cn4ABY8rE/jCDoU
	 UKyeXDmN8MRKBknGjs9QxNdzssNDIx71LFwoJ7jV27ndbo6QRkfuHRsu7twZ9R1IH0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120316;
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
	bh=D/RVO0ASQWuTETiheM2QZBsPDpIslbHv9dK7Pb5Rk3k=;
	b=XOx8SE3XV1sQxJZ98xjhZIVtCQSmM4zMx9Vk4w/oiphGCS3vriiU5Xs+59DSRHZSjj/K
	 FLRr5YRS34w/PxP5tArKULgxmAFWkeg77bVm95w96YGT/JbkPfNcXBZAi30BKX1xOiPvd
	 XIYlNUdH0mcXFS4hoSgDvelLm4kyKlW2rRNEzvhmwGfmxRkz1p6GmyqYLFLUZ3uq992tc
	 wAGV4nvW65/GWblKgp/Vg+IhmouXm25vs36w7sDHFS3DnMwofhto4NE6RsOxpP7a+ut6p
	 7qz/FjZUwdd/J5KamJ/3osoMsnrjbbYgeLp2FGkF+XB7/j+QjGB59lCbASy8iaWG+bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iQGnkYxD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819BC60A260B;
	Thu, 19 Nov 2026 20:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819BC60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iQGnkYxD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLg43hGIhUfYoz0UQo23Nwki5KkIwbHIddcncNu1XIGWlRqWCkOQejLWnGdRgcaHbFLTMdzhC2zc3VqduLDxrlj16aWxqowa8oOqm6afiUGw27D+t7BVk1nO6R3+bmIYixW1/MIVLSVc+nLlnvoDS/SlI6ewYJCXTtFD1kSfyIx/+IMAqMs038/DCn0IaikEkAOlvINP6IOtzLgyFC7QF4KTB0Y+bKUx3XKSIEfw0GhE5tJU0LhFca2muP5FNs2xWQtg0M6bp/Y9T5wyO5TteVPsI6YB8gNB19pfbtNT+3ckHx0o1kzQS/WLDRxP84WwW7hfK+7nstbWFFsRS8Qflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/RVO0ASQWuTETiheM2QZBsPDpIslbHv9dK7Pb5Rk3k=;
 b=vquFA3WuCTC1fcriH+nfa2BK3rDU1p5rbfnbssjiV9Pd3aoar6+dsOl95MeGDnY4W0ZlV8C/jPqi9ROCt0qQcQa3AGB5mebZDj0jxUgSu0Bjg2Fx0FvRdSIKmsz1s8qRgJ/mwuFvechgwLlLAtIgT0WtXZyOHv7nNNYeVJk4F4eKvo1aaXzb1Fefdg8udRBVHLLuk2OrGvaCY/gxgeFwvbmvlHwwmDFJbn9BwZTeIPk/NJ/lqT03EJTsEjVdnep4YPAjKP6sTJ1/5AXjxp3drWRH4EvYl6MppBfcE86K9JkyizY58KvYbTKsZ8Yvm3nK2fiVK328b0+OMtk57d90Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/RVO0ASQWuTETiheM2QZBsPDpIslbHv9dK7Pb5Rk3k=;
 b=iQGnkYxDbfcU7xVtMniibGxEXpN2YRPZCbOvwe1q47Z1p+oKXI/rA1r8pWPpfy49Vf5898twIaP2t4seoEsmCqVgbjVP0g6LFVnceLzUQzJ8WoJpj4sFuLQDDYULXgFt6Q2y9tPd+4+zt8YiYTAK87Tr41JMV7F+oyQorLcZhw0=
Received: from CY5PR15CA0079.namprd15.prod.outlook.com (2603:10b6:930:18::15)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:29:46 +0000
Received: from CY5PEPF00000E87.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::89) by CY5PR15CA0079.outlook.office365.com
 (2603:10b6:930:18::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:29:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E87.mail.protection.outlook.com (10.167.247.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:29:44 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:29:43 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 30/44] dmaengine: sdxi: amd: build QoS admin descriptors
Date: Thu, 19 Nov 2026 14:23:06 -0600
Message-ID: <20261119202321.1734355-31-wei.huang2@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E87:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: d76dc2f6-8154-4512-5b38-08df467bd946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|261026130827099003|11063799006|261022105027099003|261022115727099003|261021130227099003|261009223027099003|261021135927099003|261021123027099003|261021133027099003|261021121427099003|261102130727099003|261022113327099003|261026135527099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YhwHuUCT70cXdQfNgqPu775OTSDdMh9J2oSMwxZ6Ln+BkV0jtZBnfdjo1ZoYufYNW9seGC9lPQFfYL1F5/F+G2vTikdYdQOIy+SREcSd46Z+7CWCLbD0cm6dSJOSDDJWYnflNEq50iuEBAZCzRGjMymhomkhz8mRyfAUSaJnCNqL2cXP2eigCFClo/AObv6tkRlUMgMAHj3ZzYFNcxrR8et/OqQP9V2WwVomGDXT5J8/TiaAomC+8ksJxHNpYZx9vX7SSSKlwi647ie1liAJelWEYCRfNI66fzgZby+/xw8DF3qKjnG204z7kXSrEH+tfDcg6EA2DLuUY7rOlDdnUAJLyvXrQrx7vhOJsHXu3zdvMtPT7rUxefucFl2zK+hpkCRNxvJ9393lEpeilOg5ZjIytsElCMMA08LufWDVV6WjqJ8xowGixzXLWThVpbKn7TM/F5uwHtGShGrEGSsyXPZLrnfHDFxrSJNPHKjAh092k6geg1Q9iwolr6q2XP2eVOiMnqcB+w3xGPPtCUxz4mclf5p2TTiAq59vaZAHy//zSLp4mQt+A5zol9ieH+gzQPPwGE64uPP+51PFmaalhqSrkbGF0DADugBN4Gb3tYhJiRZr2OWBaW6KJw/4ovBHG1Rkx9f9aQpNYzPElQX2KxMZtOkwlu2fieSQ27yVVSSIdsnLGM83uvCfPSvhforxcQXEXWQM0iK9ABQ1eYf+Vg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(261026130827099003)(11063799006)(261022105027099003)(261022115727099003)(261021130227099003)(261009223027099003)(261021135927099003)(261021123027099003)(261021133027099003)(261021121427099003)(261102130727099003)(261022113327099003)(261026135527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NlU+bCS76fM+YZJm8/bt3RTbo4xHJte7xFOUC8VlLsgNNMwj75w5VEann3l8fvVh+6oQiFhbLPk+488FJt4TmTpO2YbcS60y2JKwDNSEtXyuBir+pZebYIIWK77WPpGOQ3L3CgAkWF2nnxsdzZr/YpSuc51Uqi+2oxYTa08zj+TGxu9PRJYkqDrEjlX6Mj0Zi7KJndpJMXUrlpJYty8Emcuy9a4h5T1FUWgwl1RpKqFWqSgejFHAolkn9leM1OMk3JXb9SzZYGzuOU1+6uj3XsOipnTHYyJSfG2nnhn7uvCZBV1q5knn8XIXSSve0qDAd1jkLG8oUsay/7773E+f5S5AP8XGzKvmAcmswIugwi5Hi0G4Tbwd5KMubZt0ioPX1UeuDx2R3ppoFJACFAVHSkyxyAJdwMO2akUBTxTiNIzI6PTrKAAWcEYDDCtUGdBq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:29:44.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76dc2f6-8154-4512-5b38-08df467bd946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E87.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

Add AMD QoS descriptor setup, capability reads, telemetry reads and
helper queries that will be used by execution code paths introduced
later.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/amd/qos.c | 326 +++++++++++++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/drivers/dma/sdxi/amd/qos.c b/drivers/dma/sdxi/amd/qos.c
index b18ed727aee9..1899f89bcb90 100644
--- a/drivers/dma/sdxi/amd/qos.c
+++ b/drivers/dma/sdxi/amd/qos.c
@@ -264,3 +264,329 @@ int sdxi_amd_qos_validate_tel_req(const struct sdxi_amd_qos_tel_req *req,
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(sdxi_amd_qos_validate_tel_req);
+
+static void sdxi_amd_qos_desc_init(struct sdxi_desc *desc, u16 opcode_type,
+				   u8 subtype)
+{
+	memset(desc, 0, sizeof(*desc));
+	desc->opcode = cpu_to_le32(FIELD_PREP(SDXI_DSC_SUBTYPE, subtype) |
+				   FIELD_PREP(SDXI_DSC_TYPE, opcode_type));
+	desc->csb_ptr = cpu_to_le64(FIELD_PREP(SDXI_DSC_NP, 1));
+}
+
+static int sdxi_amd_qos_target_scope(u16 pool_num, u16 flags, u16 vf_num,
+				     u32 *target_scope)
+{
+	u32 value;
+
+	if (pool_num > 0x0fff)
+		return -EINVAL;
+	if (flags & ~(SDXI_AMD_QOS_TARGET_F_CXT | SDXI_AMD_QOS_TARGET_F_VF))
+		return -EINVAL;
+	if (!(flags & SDXI_AMD_QOS_TARGET_F_VF) && vf_num)
+		return -EINVAL;
+
+	value = pool_num;
+	if (flags & SDXI_AMD_QOS_TARGET_F_CXT)
+		value |= BIT(12);
+	if (flags & SDXI_AMD_QOS_TARGET_F_VF)
+		value |= BIT(15);
+	value |= (u32)vf_num << 16;
+
+	*target_scope = value;
+	return 0;
+}
+
+static u16 sdxi_amd_qos_max_vfs(struct sdxi_dev *sdxi)
+{
+	struct pci_dev *pdev;
+	unsigned int totalvfs;
+
+	if (!sdxi || sdxi_fn_reports_vf(sdxi))
+		return 0;
+
+	pdev = to_pci_dev(sdxi_to_dev(sdxi));
+	totalvfs = pci_sriov_get_totalvfs(pdev);
+	if (totalvfs > U16_MAX)
+		return U16_MAX;
+
+	return (u16)totalvfs;
+}
+
+static bool sdxi_amd_qos_pool_active(const u8 *bitmap, u16 pool_num)
+{
+	if (!bitmap)
+		return false;
+
+	return bitmap[pool_num / 8] & BIT(pool_num % 8);
+}
+
+static int sdxi_amd_qos_get_cap_info(struct sdxi_dev *sdxi,
+				     struct sdxi_cxt *adm,
+				     u16 opcode_type,
+				     unsigned int timeout_ms,
+				     struct sdxi_amd_qos_cap_info *cap)
+{
+	struct sdxi_desc desc = {};
+	dma_addr_t dma;
+	u8 *buf;
+	int err;
+
+	if (!cap)
+		return -EINVAL;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_CAP_BYTES, &dma,
+				 GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SDXI_AMD_QOS_CAP_BYTES);
+
+	if (!IS_ALIGNED(dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free;
+	}
+
+	sdxi_amd_qos_desc_init(&desc, opcode_type,
+			       SDXI_AMD_QOS_DSC_SUBTYPE_CAP);
+
+	/* capability_ptr is descriptor bits[127:64], starting at byte offset 8. */
+	put_unaligned_le64(dma, &desc.generic.operation[4]);
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, NULL);
+	if (err)
+		goto out_free;
+
+	dma_rmb();
+	cap->feature_flags = get_unaligned_le16(buf + 2);
+	cap->device_maxbw_cap = get_unaligned_le32(buf + 4);
+	cap->max_pools = (u16)(get_unaligned_le32(buf + 8) & 0x0fff);
+	cap->granularity_bw = get_unaligned_le32(buf + 12);
+	if (!cap->max_pools)
+		err = -EIO;
+
+out_free:
+	dma_free_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_CAP_BYTES, buf, dma);
+	return err;
+}
+
+static int sdxi_amd_qos_get_dev_info(struct sdxi_dev *sdxi,
+				     struct sdxi_cxt *adm,
+				     u16 opcode_type,
+				     unsigned int timeout_ms,
+				     struct sdxi_amd_qos_dev_info *info)
+{
+	struct sdxi_desc desc = {};
+	dma_addr_t dma;
+	u8 *buf;
+	int err;
+
+	if (!info)
+		return -EINVAL;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+				 &dma, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SDXI_AMD_QOS_TEL_FIXED_BYTES);
+
+	if (!IS_ALIGNED(dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free_dev;
+	}
+
+	sdxi_amd_qos_desc_init(&desc, opcode_type,
+			       SDXI_AMD_QOS_DSC_SUBTYPE_TEL);
+	put_unaligned_le64(sdxi_amd_qos_query_selector(0,
+						       SDXI_AMD_QOS_TEL_QTYPE_DEVICE),
+			   &desc.generic.operation[4]);
+	put_unaligned_le64(dma, &desc.generic.operation[12]);
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, NULL);
+	if (err)
+		goto out_free_dev;
+
+	dma_rmb();
+	info->device_maxbw = get_unaligned_le32(buf + 4);
+	info->total_allocated_bw = get_unaligned_le32(buf + 12);
+
+out_free_dev:
+	dma_free_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+			  buf, dma);
+	return err;
+}
+
+static int sdxi_amd_qos_get_pool_info(struct sdxi_dev *sdxi,
+				      struct sdxi_cxt *adm,
+				      u16 opcode_type, u16 pool_num,
+				      unsigned int timeout_ms,
+				      struct sdxi_amd_qos_pool_info *info)
+{
+	struct sdxi_desc desc = {};
+	dma_addr_t dma;
+	u8 *buf;
+	u32 target_scope;
+	int err;
+
+	if (!info)
+		return -EINVAL;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+				 &dma, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SDXI_AMD_QOS_TEL_FIXED_BYTES);
+
+	if (!IS_ALIGNED(dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free_pool;
+	}
+
+	sdxi_amd_qos_desc_init(&desc, opcode_type,
+			       SDXI_AMD_QOS_DSC_SUBTYPE_TEL);
+	target_scope = FIELD_PREP(GENMASK(11, 0), pool_num);
+	put_unaligned_le32(target_scope, &desc.generic.operation[0]);
+	put_unaligned_le64(sdxi_amd_qos_query_selector(0,
+						       SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG),
+			   &desc.generic.operation[4]);
+	put_unaligned_le64(dma, &desc.generic.operation[12]);
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, NULL);
+	if (err)
+		goto out_free_pool;
+
+	dma_rmb();
+	info->pool_minbw = get_unaligned_le32(buf + 8);
+	info->pool_maxbw = get_unaligned_le32(buf + 12);
+	info->assigned_functions = get_unaligned_le16(buf + 16);
+	info->assigned_contexts = get_unaligned_le16(buf + 18);
+
+out_free_pool:
+	dma_free_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+			  buf, dma);
+	return err;
+}
+
+static int sdxi_amd_qos_get_active_pools(struct sdxi_dev *sdxi,
+					 struct sdxi_cxt *adm,
+					 u16 opcode_type,
+					 unsigned int timeout_ms,
+					 u16 max_pools, u8 *bitmap)
+{
+	struct sdxi_desc desc = {};
+	dma_addr_t dma;
+	u8 *buf;
+	size_t bytes;
+	int err;
+
+	if (!bitmap || !max_pools)
+		return -EINVAL;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	bytes = (size_t)(max_pools + 7U) / 8U;
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_HDR_BYTES + bytes,
+				 &dma, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SDXI_AMD_QOS_TEL_HDR_BYTES + bytes);
+
+	if (!IS_ALIGNED(dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free_active;
+	}
+
+	sdxi_amd_qos_desc_init(&desc, opcode_type,
+			       SDXI_AMD_QOS_DSC_SUBTYPE_TEL);
+	put_unaligned_le64(sdxi_amd_qos_query_selector(0,
+						       SDXI_AMD_QOS_TEL_QTYPE_ACTIVE_POOLS),
+			   &desc.generic.operation[4]);
+	put_unaligned_le64(dma, &desc.generic.operation[12]);
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, NULL);
+	if (err)
+		goto out_free_active;
+
+	dma_rmb();
+	memcpy(bitmap, buf + SDXI_AMD_QOS_TEL_HDR_BYTES, bytes);
+
+out_free_active:
+	dma_free_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_HDR_BYTES + bytes,
+			  buf, dma);
+	return err;
+}
+
+static int sdxi_amd_qos_get_assigned_functions(struct sdxi_dev *sdxi,
+					       struct sdxi_cxt *adm,
+					       u16 opcode_type, u16 pool_num,
+					       unsigned int timeout_ms,
+					       u16 *assigned_functions)
+{
+	struct sdxi_desc desc = {};
+	dma_addr_t dma;
+	u8 *buf;
+	u32 counts;
+	u32 target_scope;
+	int err;
+
+	if (!assigned_functions)
+		return -EINVAL;
+
+	err = sdxi_amd_qos_admin_ready(adm);
+	if (err)
+		return err;
+
+	buf = dma_alloc_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+				 &dma, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memset(buf, 0, SDXI_AMD_QOS_TEL_FIXED_BYTES);
+
+	if (!IS_ALIGNED(dma, SZ_4K)) {
+		err = -EIO;
+		goto out_free;
+	}
+
+	sdxi_amd_qos_desc_init(&desc, opcode_type,
+			       SDXI_AMD_QOS_DSC_SUBTYPE_TEL);
+
+	target_scope = FIELD_PREP(GENMASK(11, 0), pool_num);
+	put_unaligned_le32(target_scope, &desc.generic.operation[0]);
+	put_unaligned_le64(sdxi_amd_qos_query_selector(0,
+						       SDXI_AMD_QOS_TEL_QTYPE_POOL_CONFIG),
+			   &desc.generic.operation[4]);
+
+	/* telemetry_ptr is descriptor bits[191:128], starting at byte offset 16. */
+	put_unaligned_le64(dma, &desc.generic.operation[12]);
+
+	err = sdxi_adm_submit_desc(adm, &desc, timeout_ms, NULL);
+	if (err)
+		goto out_free;
+
+	dma_rmb();
+	counts = get_unaligned_le32(buf + 16);
+	*assigned_functions = (u16)(counts & 0xffff);
+
+out_free:
+	dma_free_coherent(sdxi_to_dev(sdxi), SDXI_AMD_QOS_TEL_FIXED_BYTES,
+			  buf, dma);
+	return err;
+}
-- 
2.56.1

