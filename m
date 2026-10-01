Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376043E16A5;
	Thu,  1 Oct 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870178; cv=fail; b=AoMNm1TRBrj9XNMfZ6v4oAD2hri7MBZRr/Nah8F3RDW1w9qR1DeEIVG80AmNwPHIt9o+0VS6xuu+8OIL93hviXQKxR7DaRaEhBjxzXezUg97deCuMhORbVeMwGyzdFshVo0pcc1MXydlFrjKem7HU1DQLcEqH17iH95JRyqZSJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870178; c=relaxed/simple;
	bh=JOoWYmXSHcI/zKoz1NAe/tW/ochoCpRh37jadWrEJSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVigKrRlqX/X9+296kr//FJov4Rs2ZQMpkmGZqgJNQdJk5v7wYs5uFjgNxEg6iWpLAejBofX7ikwu643hpWi7Zy/3ciArT3vw7LO0XznUZ7ccnkyw53KZz69NSzWosNSd8XBQtjF23dct2Tx5smRTrzqXg7oN6tNPOQ/hU/M6mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edA3a7A8; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edA3a7A8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSXoqadKETDsEPlKCSxFUfTE1ngGBnviaGx8ULSms0Tw3osKPltC5UzmOHeqpY2Oc55Wr0+FYPpj65QdZ+67QnM6GTkPgl21gUV1+5yTkfllqwlz4rZLp4Khn+2lovu7mTeAcHA4vvHp4j6C72isq5u56F4rjQbjgBdOz3eWQfTx8vbl1mAo9eAvbiKbtPvr+5/SOTpaqmWgY+8vBnRQCueAd57YTB0QfOqBzTSwZDl7pvdPjKlsyUm3Qrt44M3+kcocx/CL7tvaPle2CA5QzCPGxM2mO7yG2/bJ/Xr/Vi7oIdAlWlTkTCYkuHV4tkEn5NRoOoLJY7191Fzi8Q/vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGX9WeFflVvhVGh2ZHOaTtG9a3odIewZoxZBfIpl3do=;
 b=dnawDo7ZcDm0tthUJfYIqoZX3+Ki+0R+Bvc4gnk/2kAO5NkwkVcRxbm3qNxJJTrlyYjTHyRBtFKRxOe8+xGUR3WIfTTLNrm51yEZiNruZxXCvsPBHnMYUKoWeMc6vdEqrDvQdoFEeaABm4Qj5xpgAsWqmLaiCM7m1k/14zw8z55bdnaFRchJYdjHMLzVMERvDiG+W4eWS33DSee5wL0NvU6iMV0iqcv3KgE4CjnLDqS+iHz8t6MXo4/c/859Cab3y/+9dAjQKQ7ksON9/XCPgBdWJt6uol5dqJsJT8WoiG0UHpOUe3XLkG4T2tls/rUQXC24xS/UJqk/poZSDQfOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGX9WeFflVvhVGh2ZHOaTtG9a3odIewZoxZBfIpl3do=;
 b=edA3a7A8e7ODdN/IFTHkkf4xsia8Ta0KHmtflVZt+TwGan5TXkv/fJ23s/mQLzuERedeXpTRjoQzk7C2DkCnlbTE60meffCgrG7c/AVkypMyKbcTVj2qm6zaYLztFyFLUZcAlOLlpCOTUXBaEoqj+Bx1udJhYJlBwRr3QUkDRBE=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 15:56:09 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::85) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu, 1
 Oct 2026 15:56:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:56:08 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:56:07 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <fengchengwen@huawei.com>,
	<wei.huang2@amd.com>
Subject: [PATCH RFC 1/3] PCI/TPH: Factor out the ST _DSM evaluation
Date: Thu, 1 Oct 2026 10:55:49 -0500
Message-ID: <20261001155551.4182899-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001155551.4182899-1-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 021666e6-8ec5-42f1-d81d-08df1fd48259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|22082099003|6133799003|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	t+zI/Wz8RuqvhkJkvAHnAX6bt7sQDIpwR17T8cqZDDOS+iO8Gylm5okO5kkZn8GPXW7zi/2Od2xhh25oWqwy+2qUheudHkxrlQqyYd0qZr7f6PGKBQzpGmy2f7Tz+OTsB5xCIDJMZ8Nicr5E4Qo19GMIuz7Wdn8qjqNBkF9bm0DkljittpOQ30zoMhrF8ZIfQL1yyINexZQPzg+Ksepd1Fes8lbYOekvg9FkZpzLpMTtUMHoyzkV2I18M2tVjsFqxaeD1tJVxl2ZjJj1HlFVOyc+LPdQCBqI7h04+J1Uo1UFbv0LYUduJEHqTtVgNz0/0E+olPoQ263wnOctx3A7hWAeC88/OOrOX5Y82RpgeI0Utt12lqjOcq1+e84+RdHV7ZycmPyu+m7P8QgqePpO/OmrREP+/gV0sSw9xaapVTLQ0O/Os8tJJL8PmuRGTscwJF4FAftrqj/+Y9Q1NCUDuDRqckgJf4p7crenryHSXIusunEyEGQj1fGCY9yZopYLU28FF9TihP5U2TeyGDzTY8wP8PGe71YDK+DxvZMReY63uHsDg0nU56Q0mJWhJuF85qWG92RUqFYfMHkFgrt4PfaXg+SSYSqEwx4WZJzJcukI3cKXc0PGclR17y5hkMIcmbcGTAQJo3S2aMe547TBdpt01TRjDiuJDZAyk9Ouf5M7FJSsT4epCmrKq/BlVJuRa1EdvuNp2VeW5TueXCyibw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(22082099003)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GEBUSi5ogbxGAOo6TZYT+ZAABDAiHVFVz9MNqCnARFjOpws9vX6yHtynrvCUCwvJ3e026L+R7BvSjRvG45moefyooTOMpUpeCKShO8n/4xin142pLCE465mZMjdEJsC653CIJTtXngXtuLz0rIbENT7XlyOOG2LNUTnX0s1VsaTjwa8A3hkhOF1BLJhYf3EMau71japy8xpNWdMtx8+XMvjzeFo35oX2CkNkhluq/jA5Xhh79dYWBAe/k5IpLC31FOmPMc9ZZhDFr53rc93eoUjkpAY5POejeYLYKa8olXl4sV9XdvhVQxMj+dm3KxY+2Zai9Z7Ec94/8aHkh6rq/GJW7gsxxMni1WhDOg/028kh/bR36ksyNdGEWMNrqqE9Mcne8IjgoUKNYGqYcJ8DXNazTmgLUuwcpF67sJdcYGkCWZHbhsI6r3cQg/Jq/kDZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:56:08.9332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021666e6-8ec5-42f1-d81d-08df1fd48259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

The ACPI _DSM that returns the CPU to Steering Tag (ST) mapping is
evaluated in one place today, with the lookup of the ACPI device providing
it open coded in pcie_tph_get_cpu_st().

Factor the handle lookup and the per-CPU query into tph_dsm_handle() and
tph_get_cpu_st_info() so other callers can reuse them, name the _DSM
revision instead of repeating the bare number, and constify the ST info
passed to tph_extract_tag().

No functional change introduced.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/pci/tph.c | 65 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 655ffd60e62f..d2c6d3dda202 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -18,6 +18,9 @@
 static bool pci_tph_disabled;
 
 #ifdef CONFIG_ACPI
+#define TPH_ST_DSM_REV		7
+#define TPH_ST_DSM_FUNC_INDEX	0xF
+
 /*
  * The st_info struct defines the Steering Tag (ST) info returned by the
  * firmware PCI ACPI _DSM method (rev=0x7, func=0xF, "_DSM to Query Cache
@@ -54,7 +57,7 @@ union st_info {
 };
 
 static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
-			   union st_info *info)
+			   const union st_info *info)
 {
 	switch (req_type) {
 	case PCI_TPH_REQ_TPH_ONLY: /* 8-bit tag */
@@ -88,13 +91,12 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
 	return 0;
 }
 
-#define TPH_ST_DSM_FUNC_INDEX	0xF
 static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 				  union st_info *st_out)
 {
 	union acpi_object arg3[3], in_obj, *out_obj;
 
-	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, TPH_ST_DSM_REV,
 			    BIT(TPH_ST_DSM_FUNC_INDEX)))
 		return AE_ERROR;
 
@@ -114,7 +116,7 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 	in_obj.package.count = ARRAY_SIZE(arg3);
 	in_obj.package.elements = arg3;
 
-	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
+	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, TPH_ST_DSM_REV,
 				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
 	if (!out_obj)
 		return AE_ERROR;
@@ -130,6 +132,43 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
 
 	return AE_OK;
 }
+
+/*
+ * The ST _DSM is provided by the ACPI device of the Root Port's host bridge,
+ * so all Root Ports below the same host bridge share one ST mapping.
+ */
+static acpi_handle tph_dsm_handle(struct pci_dev *pdev)
+{
+	struct pci_dev *rp;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return NULL;
+
+	return ACPI_HANDLE(rp->bus->bridge);
+}
+
+/* Query the firmware for the ST info of @cpu - Return 0 if OK, else -errno */
+static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
+			       union st_info *info)
+{
+	acpi_handle handle;
+	u32 cpu_uid;
+	int ret;
+
+	handle = tph_dsm_handle(pdev);
+	if (!handle)
+		return -ENODEV;
+
+	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+	if (ret)
+		return ret;
+
+	if (tph_invoke_dsm(handle, cpu_uid, info) != AE_OK)
+		return -EINVAL;
+
+	return 0;
+}
 #endif
 
 /* Update the TPH Requester Enable field of TPH Control Register */
@@ -247,27 +286,13 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
-	struct pci_dev *rp;
-	acpi_handle rp_acpi_handle;
 	union st_info info;
-	u32 cpu_uid;
 	int ret;
 
-	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
-	if (ret != 0)
+	ret = tph_get_cpu_st_info(pdev, cpu, &info);
+	if (ret)
 		return ret;
 
-	rp = pcie_find_root_port(pdev);
-	if (!rp || !rp->bus || !rp->bus->bridge)
-		return -ENODEV;
-
-	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
-
-	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
-		*tag = 0;
-		return -EINVAL;
-	}
-
 	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
 
 	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
-- 
2.55.0

