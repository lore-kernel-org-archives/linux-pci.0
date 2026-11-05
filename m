Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892576;
	b=qpCIltnBPHxpq1GS2wAB7moOelpDI37YsmqnPxF2UNKuPhc6MQQW+BkJel4XTQHTfNor
	 viNW0/PzcJnFmKabCnpWAWu8WW8LexQLJbyJIBdDQWFscLgYQmxOu6GGFQiLGn11PdAZg
	 oiPOeYAMBrP3c175hGEjoo8A6sOLZUWnKFBtDJtKxNh/DzZkhufXaRuUszV5PhL3B7w6o
	 pMjnMo15pih0udwu3PTU0pOk/bi9p4FRMgMRL0rbtQbu5I1yT7dx6ta1FSd+A5+uSV5ny
	 VJr/QLuWIJjxxD9xLqJaGe9wc1FTppRsslRVw+rafQ5aGhEnAK6h1giBQhMx6thMbog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892576;
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
	bh=OdSyAVizp7sbcE1fxXSbMqb3JMkq0m8Mv/3jzTYhM1c=;
	b=zOFADI0BnwreP/Xsy+c9XmjILF+7EGAsz/Kk6pJ7oqeB9XursnaZRwbkZ+YAkBAS17FT
	 FVc966TXmrtcBH97PP6kLOlsRYqaqRgiDFZpwjguPEq2eb2JP8owq4JX9HmI9r+QrTEgJ
	 Frs3fWuha2PbTmWy/YedsNHbSTrev48MowMol9dJMFwUmBlqe/leAXY190O1xpqV+Nw4o
	 2sU0KyhnZbRzSqhbAbZk8du8LJ7MqjjdM3Ufb2ubJ0e9D2wACtN800Z62bLdgP5HF2k92
	 zb1R6kHT16SDrujQpYeKRblAqeirGT680Res/9pfDOJ9R0jFTPV6i3OM424OuSr9t+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TLoNAZC3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.57
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2D606D813;
	Thu,  5 Nov 2026 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC2D606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TLoNAZC3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNz9hSFklFSAsidiUQ2ody8ENQ/4WrBd84EIvbQX6zQG8pestwRi1uQ6gBjQ8SiBbZCWm/NAu8AxqRMiR3uK2RtynOT4KPjQ4j9lsBpf7SqMXNGL+9H7BM2vInSJLq3clEEmWzGpWZ6jXmJ8un9wOKjtkYosGMWP876QkdYXpAJ6KEMXdRG4pxsAeor4U+jS1mYaN63zBs3xzK+tST6MidwDR03l06m9K1k8P/mq/LlCySckrLOyjGJHNhXWuHcwIM1MR5UgQMw1H3oO12vKPWM/HkmcUHM8ikSO0BYDgVd+Az3x4bQtSzJUzXzhrS2TNm2StIOoQasjKMYXP1NJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdSyAVizp7sbcE1fxXSbMqb3JMkq0m8Mv/3jzTYhM1c=;
 b=IU8N7nlHPPY70nf51GZhDsYbvaBwjtMBG+SFWLVYKYY6V2pwP6aGxDI3TyC0msfZyN/OA+5RCQUrGu7iCQ6MCQVpbsFotK1y10iWPGVIMC5enwro7Ngac5JmTv0Btrr+pP14am8an89cgK7Qt+yibYW8Pi03rCP6bIEuj8fcCWA2W313/Xzjm7trB9/W1kR2sBx1D8TEeRnBKxCpRmk1nmBZkig9FZ2KHuqrKuIsHLsD+PJhQD+HrjxPJmW/bY0PkllIrXsHjypjAFxPTeSkYTZIhycovr6xjkWAuWNvEND4KkElvLVbzc4fUFLN8HDz3p1RqQ+vpWANdLEtm+pqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdSyAVizp7sbcE1fxXSbMqb3JMkq0m8Mv/3jzTYhM1c=;
 b=TLoNAZC3GP/MP7OwLCSDtAfHyHFRt7/Xt8DZyfsIX9m+ZOH2lSL/859NOgvF5s1hDEWyi6V40SRxBuF7Ahw176r4jO5/XBAeMuJLt99iwmMHkQmh0gGoH1nnDf8V0fAC0qe5YxQGvAXuHO9tD327x5zjm3dK1tI2m0xyV9OYHn6IgHbQKiRJtmi5pZDgqCS6X3wz7ta0Ky0Srh96XmfYOyfHmUJwOEajaCpgsmFOV0pP8Tuk/fpL9kgdyGmkpHzdxPP2nv2/NC/IFeJdO4gzxkzHx3K2wGpVO8P1JskFzwUquRtuhkN0YfL0Md8AKCuhV4f32rnVk3T02Jw8IzppKw==
Received: from CH2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:610:55::35)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 15:29:26 +0000
Received: from CH2PEPF000166C5.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::6e) by CH2PR18CA0055.outlook.office365.com
 (2603:10b6:610:55::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:29:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000166C5.mail.protection.outlook.com (10.167.244.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:29:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:10 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:10 -0800
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
Subject: [RFC PATCH v2 2/5] PCI/CXL: Populate and insert/remove pdev->coh_resource[]
Date: Thu, 5 Nov 2026 15:29:06 +0000
Message-ID: <20261105152909.53452-3-ankita@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C5:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4621045c-b461-4e4f-cf49-08df3b5193ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|261009223027099003|261021123027099003|261021121427099003|11063799006|56012099006|261026121527099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TLnxKsXCb5bWNBLIHPPXcY30C0s+ZMfeUYA1ORHBgCkD5Iv34xc1nny+axyCUkxDVCQd/1qW2YhZxNtR7vgWirqeh7k4YcjSJoPMvzTJsmjBuAVz9mWbuOXrckXKbJHG6yLCVoqEfVE7QPFYVxYZGQEAskN71tuDuYhpPymAr5llveMeot2H7q9qj+056Rd8I+mzuc2qOgHp5iCHMAtVb1nvLAMSch5upex4Nf3MRtmoNZbnKu2UfnYaazz7y2ylb6Vwn5Oe8oScDzUDMLzxRVwW/6nSaT2HOt7Wcs90RQPLGk45sUxmnvraR0dwaAeB7Iowtse1YO27MlUWIsBk/7DXy2Xp2QQamzAhk1cOpqOFG5IocfTXzsTtbbuR+seutEJIjF+jzZaYiHZTce49s2pS0w8+m/jhX0rQlJiGF9SC83/CMmIXwjeMa/IIbyjcXhgLe5lKbv5QzmqcpoQpHaOPNMhKc2llSVczu3yAFjPfKU507QBgbSGhCSH+/vIa3aHtOkLsauI33ksPaHGGv1Gc01cWQBBJzo/GxKZIFVeFEHmSIogWjRjxXAg5YVOhFpvIQ2VAzRC/FLfJdsnjpIP6iznj2HWggOKA3iIcwtc4zxE2jpBCwRiwOV/0Dsh/o2GNgOZYl0iKMh50RBezPbwzJeTGG4hQpfwMFVfxfaDDfm6lOcahpdQYP6+AW/aNiYAAI9/OeeZJRuQJSYGlEA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261026121527099003)(10067099003)(18002099003)(261102123227099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/tGnlafeGEmQuRJ18si+bL9QRfxLNc52HT20FfEtDevwssXrN7p2dMUW2WVDLO0EFdQuPaij147jouCkV73C9Bxzaz4MxJaSfIivES3Z8sAbabNyY5CfWiZuMfELT5ZitvsQvMFx1DjEdl0jmngcbZQkIqsIrcnZJMtbGaR5zFTLSboCHhAFcoQUp22m+9As7d08JJP9qkhosJMziQPbDtBsrm6nG8WlpomprR34r9PwhaVYEDJZIyM2ZT1MSeqbSRmxCKyQI39LF+3ACUC/BPNXho7w03LW5aDuJb2tlsho52BbHzXLPdi4dzIaLliSr3D6dEP+WO1HyWCjtsuenspVr0h6D5wiW6e5TPzu+vMtnMH+XuLtKZ+5mpttydFSCosK5ucwhp08u3GzI5vezFjCqYndWPyuH1wgomvNlA226Qq8Pzf0DP3HvVbpxega
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:26.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621045c-b461-4e4f-cf49-08df3b5193ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On systems with precommitted HDM decoders, the firmware programs
the decoders before any software runs. This range also stays constant
over the runs.

Snapshot precommitted CXL HDM decoder ranges into a new
pdev->coh_resource[] array, so later code has a known-good source for
a device coherent (CXL) windows without re-scanning decoder
registers.

Only decoders that are enabled and locked are recorded, since an
unlocked decoder can be reprogrammed and leave the snapshot stale.
Zero-sized decoders are skipped. Decoders found to use Normalized
Addressing (a DPA rather than an HPA) are dropped later, once the flag is
known in a follow-up patch.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/cxl/core/resource.c | 60 ++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h         | 14 +++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 3422139ae3ab..d837f8e952a9 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -404,6 +404,54 @@ static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
 	return ERR_PTR(pcibios_err_to_errno(rc));
 }
 
+/*
+ * Snapshot committed decoders into pdev->coh_resource[] which is called
+ * once per pdev before any driver can bind, so a populated entry is
+ * always firmware-committed and not driver-committed.
+ *
+ * Insert each entry into iomem_resource for /proc/iomem visibility and
+ * conflict detection.
+ */
+static void cxl_populate_coh_resource(struct pci_dev *pdev,
+				      struct cxl_hdm_info *info)
+{
+	int count = min(info->decoder_count, PCI_CXL_MAX_COHERENT_RANGES);
+
+	for (int i = 0; i < count; i++) {
+		struct cxl_decoder_config *config = &info->settings[i].config;
+		struct resource *res = &pdev->coh_resource[i];
+		struct resource *conflict;
+		u64 size = range_len(&config->hpa_range);
+
+		/*
+		 * Only a decoder that is both enabled and locked has a fixed
+		 * mapping that won't change under the snapshot. Also skip a
+		 * zero-sized decoder, whose resource end would wrap.
+		 */
+		if ((config->flags &
+		     (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)) !=
+			    (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK) ||
+		    !size)
+			continue;
+
+		*res = DEFINE_RES_NAMED_DESC(config->hpa_range.start, size,
+					     "CXL coherent memory",
+					     IORESOURCE_MEM, IORES_DESC_NONE);
+
+		conflict = insert_resource_conflict(&iomem_resource, res);
+		if (conflict) {
+			pci_warn(pdev,
+				 "CXL coherent range: decoder%d %pR conflicts with %s %pR, leaving unpopulated\n",
+				 i, res, conflict->name, conflict);
+			memset(res, 0, sizeof(*res));
+			continue;
+		}
+
+		pci_info(pdev, "CXL coherent range: decoder%d precommitted, populated %pR\n",
+			 i, res);
+	}
+}
+
 static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 {
 	struct cxl_register_map map = { };
@@ -442,8 +490,10 @@ static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 	struct cxl_hdm_info *info __free(kfree) = read_info;
 	guard(rwsem_write)(&cxl_rwsem.dpa);
 	/* Another initializer may have published while we read MMIO. */
-	if (!pdev->hdm)
+	if (!pdev->hdm) {
+		cxl_populate_coh_resource(pdev, info);
 		pdev->hdm = no_free_ptr(info);
+	}
 
 	return 0;
 }
@@ -466,6 +516,14 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	info = pdev->hdm;
 	/* Unpublish before freeing so subsequent readers cannot use stale state. */
 	pdev->hdm = NULL;
+
+	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *res = &pdev->coh_resource[i];
+
+		if (res->parent)
+			remove_resource(res);
+	}
+
 	kfree(info);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d24fc65c049..ad7917895f4c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -148,6 +148,13 @@ enum {
 	DEVICE_COUNT_RESOURCE = PCI_NUM_RESOURCES,
 };
 
+/*
+ * Max CXL HDM decoders tracked per endpoint in pci_dev->coh_resource[].
+ * CXL 3.1 spec section 8.2.4.20.1 - CXL HDM Decoder Capability Register,
+ * mention a max of 10 decoders for a CXL device.
+ */
+#define PCI_CXL_MAX_COHERENT_RANGES 10
+
 /**
  * enum pci_interrupt_pin - PCI INTx interrupt values
  * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
@@ -573,6 +580,13 @@ struct pci_dev {
 #endif
 #ifdef CONFIG_CXL_RESET
 	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+	/*
+	 * Precommitted CXL HDM decoder coherent ranges, snapshotted before
+	 * any driver binds. One entry per decoder index. Only written by
+	 * pci_cxl_hdm_cache_init()/_release(), outside any bound driver's
+	 * read window.
+	 */
+	struct resource coh_resource[PCI_CXL_MAX_COHERENT_RANGES];
 #endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
-- 
2.53.0

