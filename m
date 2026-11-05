Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892575;
	b=QDJjTDWADeeJDK+RGfdUA+i3WivF/xJZ5N7AM3f6mLDZESJn/YXezc/o8tjVgFPp+Dvv
	 xKEQfpVexYB8FI1qXBJq0Wi+uJ10+9AX45q02Gj/OAQ+AfcdbJtsiSnTzb5b6WFvXONvM
	 AvXaemaxx0yhrZE8XQ99AKRbQQ/zQqzo9gEGZqaDAm/W31sMsw5W69u6qB6aEtyW+GwjG
	 JF+jq0OCO/41C8Sl0Q79b6qVitRpfOVnHVZ5tXbLH1MuYuM7uST7vknYw0wsttpSrHpds
	 x4w3S41+gKiW/dQgP/ZPoOuXPyOcZ/MI8VkBBtKYgq/V6kXzvz/YtQAutKNJ2C70R9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892575;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lXnfzGILnOXRFwCF0b4qg9HuxoF+oN2N8gZ0jPp/KnA=;
	b=HYM0YVLU+X4Rz/1TApdOEC31vO3EDa268PHUYiAQhLd/qd2xc8xenI1p5Q03QVprF/S0
	 rGfuCZD6mlmaldugcOfc8zcM708T+674pU3AhK/IB8iT+2ldSPH4dzU9Pk4knk1LtJa+m
	 scMjzit6s6NEhBvQONC1TC/0BqRQiWhPsq51eV1xWKl7LN3WesyXa6Kjss4cZK4rsO6r/
	 EEOxr/djr5gIBcASCR5DErpPjBC45M4yeuJeUCxLcajnAWKjqDoTXc0K6Q/U/vTUdB0zG
	 xfHPoesrTzAqGCYiYfnRImuuoeirsaTEMaw9GmQ4xF7w8tv2FJkh0dZGtWsah2LJc5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="GSYMDO/4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.11
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EE606A326;
	Thu,  5 Nov 2026 15:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GSYMDO/4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL0k21CbOJ61gyGBOwXcdim4S+rNT9LthcDOcByOmNrueLaURh6n/hzgQItfnms8ata1pqobvchBBP/Z2TBkipJ9RygmjHCsX+UC2qRy+OrtLlHZ9KLD3I/zPpPoG+cfc6NZApEXd3ChKuMzvhYqivRqG2yAEL1kBdjtg8jTkW144P9WNIgozKYl65GFP31Qf66axRkKN0s3SiPwW8zZUG8z9pjJJ6Nzn/4X2k+3PRrWcuJegvJPwom3L5qFjt37r69vv6V/7lTDRnXBebAweh/SVRUxiSx9XhmtYWCUXbeck8u9gRzs3K2gAnLqIC5LYAPLq7U99UvVO9R3VjM+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXnfzGILnOXRFwCF0b4qg9HuxoF+oN2N8gZ0jPp/KnA=;
 b=QdClGuhtC3tHBp0ZjgB8QgqofL8/S484U84FPdOOSZKqbUxy98h4RqCwqSsQ5g9iyz52NBUcx/OJhofpqnQWmNL64w7f5cvf9Ide5hLTz8q14x0IT5LbE1JYF2AMfzoki7F+RYRtXX7KdI3CNV9HWt+e6B71qi6u1bpQaWn02Cn1KXhKdYnpQlha/HsYprb/D2Ugjz3aEzC3oH9X8AI/mGGZOqa3vmsRIdgtzpydcgaJTkT/B5g1o+wAULLewEMhX8I69u/VdrUMSvud9GWRqmmtXADfEwjzqSWEj3q0OZugJ/1/c9wt4lK944nu45nckHAu4REYnkZVAtErg7FChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXnfzGILnOXRFwCF0b4qg9HuxoF+oN2N8gZ0jPp/KnA=;
 b=GSYMDO/4kpsLVTxbcDF7+WfA7Mh++cjvNWHw7cE6UigPUsuMDaBFy396c+93FqiZPSQhvZiuisdpZn3XWZGn7mlfcAZ/WvN2Zu1XZuFYtKUGNrKEMcS/MlaDi2xONgoQQ9uzJxb4luxT61ZhweGQZVnvhxMH6l6HdBXTwkGeQxjWlhntnMqk8RQqPTMcacel2H0p5PVvXHo5ilB0q3GwHyeHkUlx5M5ydefyAVOpzSTP2aMK5tBTVy/c2/2Bl9lHJ7J0I7MIAVbdTxO5n3Rx4KeTGrUXUbIDvsDLv06wpz9dEBF4HXA15pw4pH5/Q1xU4O2OKRg0a8hbiQekZcVjzA==
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:29:27 +0000
Received: from CH2PEPF000166C6.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::7b) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 15:29:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000166C6.mail.protection.outlook.com (10.167.244.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:29:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:12 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:12 -0800
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<terry.bowman@amd.com>, <nik.borisov@suse.com>, <brads@mainlining.org>,
	<lukas@wunner.de>, <rrichter@amd.com>, <gourry@gourry.net>
Subject: [RFC PATCH v2 5/5] cxl: Invalidate cached coherent range when Normalized Addressing is detected
Date: Thu, 5 Nov 2026 15:29:09 +0000
Message-ID: <20261105152909.53452-6-ankita@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105152909.53452-1-ankita@nvidia.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C6:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: ef89a187-1aaf-4fd7-56d1-08df3b519469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|10067099003|22082099003|6133799003|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	q/WWEKIfkPuEpyKk8BrAYiy7aTPw7OJdK64PZcvF4lYSDc+2hCetsV3tjqKbRaKHQS7LBmlQty2FjsgEAO60/M4QRPTftmgwKsRZYcTuDePA9UbYsKR9ib/DKD1FcGiRNvP8ryznv2grGr+8w2pkVs4oY2dhu8oaqBV2ZFIjqZUDCfu063E0VBT9cmyF8iIhyjSwXA+SSRkgoVLNNGDQABqw4QzssTCXe4BET6QNhdKezXf0LNmB0U3OyW40G4rdHxSwJ/KuN0tQdx9Yv+haGFpxhaahNLWQhj2Dl9IL34z2zrkV1fviQiqJ/jYQNo5w0ivCev2bDF9wqwev5FwTa+hBU3EVdnczW92BhSyaDt/+akCLIlNB3LFGvg8u1BAfUeIrnzZd+gxAsycJeu8pPRQ+NskJthYxqmp6mpmnud4qV4Twtgbx4cFPkKs5SVyuiLEaMThrSwoeoqi7/3C25JSixeTXmHnpWVYWdIvNdNWHMdYewkzOIdx4EcsStMB2U186/8jUkAMvciE801nqZ1GxPnGQvf0X1IjP7BoSUYOrP8ZaCyaj3fenD1Jz3h1crAIHlkeB6lVWaU6NB+Cht7ETVCkz8hKSGBICm7bcp32U8WnHu6Dywpa6cnLGSBGdEzA2xCS6WWcmyyLYCEjP5cHdsFviL+8zrh0guS3lhjuMi2iUwE8qJ/SG+uiKWphJ5MXw6irr59AUWVw0DKJtFw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kL2w5wI4e174GdEvTEsGdrs6pSuPrNDJiJBxje3Y0bRK0hwA7RDX0PutDVoqfrtT7Va8+U1NtCPcCNcF2F0RuY38lEBABF1l867AHGUcT2SHsWC0u3Qf2/qmpzFkkJ/Zyn5kFxcA4qXpG9jraOCpwTJ9S6T3J3vy9+yVV2FeIcf0i5yRgyqNlqByik3+NTZi2pSCV7usoHkayGgY+dDLVeCTiSPYQ+L9ZqRt69T9KCU6kkUhoNCGibvjBfhSsPo9n2rBP4b9N7yHpf1KwxaapI1CnTWR10j8Y7kvE3atfK6HtNZQMQnx9RtStLyNECQaiOGIQ8NKsWjMLXVfhaqUdRMuYG6Y3G0taawh7p5zq8Gr870JP5c+S50tj8L5wbs0RRL/lbLvLqph6QFlNVK6lJCNSwZHjMzrbxib9AMTQzxXlYNzQ+kIoDjuCdwLvyXK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:27.6745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89a187-1aaf-4fd7-56d1-08df3b519469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190

In case of Normalized addressing, the HDM decoders report DPA instead
of HPA. Determine such case and ensure the pdev->coh_resource[] do not
cache it.

CXL_DECODER_F_NORMALIZED_ADDRESSING is only set on a decoder once the
endpoint is assembled into a region in cxl_prm_setup_root(). This is
well after the HDM decoders are snapshotted and populated in
pdev->coh_resource[]. So the DPA would be populated in the
pdev->coh_resource.

Add pci_cxl_hdm_coh_invalidate() and call it later when the normalized
addressing is identified to clear the cached value.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/cxl/core/atl.c      |  6 ++++++
 drivers/cxl/core/core.h     |  9 +++++++++
 drivers/cxl/core/resource.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 07ce7c50c47a..2bf4d73fd02f 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -175,6 +175,12 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 	cxld->config.flags |= CXL_DECODER_F_LOCK;
 	cxld->config.flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
 
+	/*
+	 * The PCI-core snapshot of this decoder was taken before the flag was
+	 * known. Invalidate it so a DPA is never exposed as a coherent HPA.
+	 */
+	pci_cxl_hdm_coh_invalidate(pci_dev, cxld->config.id);
+
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1aabbbb4ae5e..97d27a27ab67 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,6 +139,15 @@ struct cxl_rwsem {
 
 extern struct cxl_rwsem cxl_rwsem;
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev, int decoder_id);
+#else
+static inline void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev,
+					      int decoder_id)
+{
+}
+#endif
+
 void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings);
 int cxld_await_commit(void __iomem *hdm, int id);
 
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index d837f8e952a9..d0774926da2d 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -527,6 +527,38 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	kfree(info);
 }
 
+/*
+ * A decoder is found to use Normalized Addressing only once the endpoint is
+ * assembled into a region, after the snapshot. Record the flag in the cached
+ * settings and drop the coherent range so a DPA is never reported as an HPA.
+ */
+void pci_cxl_hdm_coh_invalidate(struct pci_dev *pdev, int decoder_id)
+{
+	struct cxl_hdm_info *info;
+	struct resource *res;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info || decoder_id < 0 || decoder_id >= info->decoder_count)
+		return;
+
+	info->settings[decoder_id].config.flags |=
+		CXL_DECODER_F_NORMALIZED_ADDRESSING;
+
+	if (decoder_id >= PCI_CXL_MAX_COHERENT_RANGES)
+		return;
+
+	res = &pdev->coh_resource[decoder_id];
+	if (!res->flags)
+		return;
+
+	pci_warn(pdev, "CXL coherent range: decoder%d uses Normalized Addressing, dropping %pR\n",
+		 decoder_id, res);
+	if (res->parent)
+		remove_resource(res);
+	memset(res, 0, sizeof(*res));
+}
+
 static void __iomem *cxl_pci_hdm_ioremap_current(struct pci_dev *pdev,
 						 int bar,
 						 resource_size_t offset,
-- 
2.53.0

