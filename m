Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF33A5E94;
	Thu,  9 Jul 2026 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559049; cv=fail; b=t5bImPrpD4aUc++Zd41MaEoo7DMCn8C6ceOKAlsbiPOxi39bY4a2kna82EbnOxmzY0ms4/3u5Dc1mxX4QK/himDSDkkqDr9F4Z9jVSeubG/A2aORU1b1fxWYZ6nLukSHjQCBppuNBQouIe11aPGdW67vXxdnYC3LevGmPXCbMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559049; c=relaxed/simple;
	bh=zb4DxDrUz7+d8N0fJiQ5w1fYsqDuLmCo8I2ha0JNMCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAalQZQ2y2MQ4YfEz0PB9st2fKv82Rh0cIrXf5pPtIvUjFzz6Ge6P/oTN7E/c21AUHJpg/D+ljtlGXOF8+0bqzbAR3CY8WNgsFZNodTWV4nR2P0qKkrkY3/aDPUsU6uQXBEz6yNf9QT28EkpBivLOS/mZoacw1TSp7JPu/SL/1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwbCZW6j; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwbCZW6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzGEuT46p5CDKb3usGitN5ue8RBou+kpcR67zt5clKGgEeigAa6oDzpPjEY8jjpciAG5IsnV96GlYX6CkJ+LKNjnA2/P529vOkD3lPb+PFo/mcl0oka6ekuANLKtYBMMH9KFyBbgLr9FuQlhUsaXiKGsuWOefQdJEYg6GYzcOK0DLdInJZZbPl63MM8DzPpJodexjsb8335EIVnr4jMrxp323QbSTTUwkKPl7hFYs4TrY1wjsDpXQpwC7xM9rH8QNHBrG6Z9DOdLreaAyUcZk143v7Bkhd3aIJW+9tYuugtLEXehtcvejHpPLU/if1+577xRGeF/NtKQAYfltt6u8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3mRkIXoSrE7aiQqOpP21T1JL8kefVyYiuYXfJVWxkM=;
 b=akymk3oxCzLyy2z4LYkHySFg7V+VCMR9W8RlnLBQo6/fT8OethMhNtT1T9cpoRUsvmPz4GmYNi3SAR7tMRYnijc5ZHLGiQpDFsSrakjKyn9+KkM0JsZVPVw1yf5D13PUf+hmu6Hq9OAIdJ5bM+de3AObYT0qXJBHZqYXHfX6rQojgEAIHwRotsZAyGFzlCsvU+c5m/RHq2DmokfRZZNT3BW5sGAZfBF1KbjMdwf6I7Rwnnx2tetcyoWgw3KTwrAUqkyiDIAymvHJPf/M8V3HAgpDIMbbbYvFbkY10+UbjslLaeEk06WlkJI30XbGCBhR1d/huu/8jaqlXxAjwvRgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3mRkIXoSrE7aiQqOpP21T1JL8kefVyYiuYXfJVWxkM=;
 b=RwbCZW6jpG9cXpTVW5roKWeHcnwaN3M5dSfJ8XJWtlqZ+07N1+sCV0+0Hlc8PuV1Ia2d2O8/Y3PqLcKpEq3o02voXeCEnLBfqZzMoiAwd6IG73d0x9hqJi4qj0qLtCpZ0IAF/tVM5UBdJ2o29TarhEIqAheKDF3XjH2K/w5LyLmW/S56Vxhv5XYaDlx+nJ7VLWUZl45f1I/NrMYMAVW8Ty5Ug6JtRuocjP3X2T2VDtLD1gMSwVr5yH7Nw6eQP/op7m0vpCMmDBdtgOD9ordFU2ORH69PqH+CAsXYjY7VRNraiKBbnuzIfECDamvbjgUalJqIAsjXzdcbtYiVC/SLEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:04:05 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:04:05 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v9 11/11] PCI/CXL: Restore HDM state after CXL bus reset
Date: Thu,  9 Jul 2026 01:03:04 +0000
Message-ID: <20260709010304.680422-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ca481f-fce3-4c65-7215-08dedd55f91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	HZRFdHqO9EFGh/c6Tmgvd2qvCvq4i+PC9cysosUapsUJ4OJyoRLKVy3X29uc9PRzUGugbTEuZqYSjXH/4FSoCNyZ8q8Di5puUOL/7UV97RETEJ239og2qYXsB1GErBsXrA5hLd3KhrtCYRaUHQDN78HnFqW8zAawIfzRUSJHxHgHKeQsFY+aBRsnKzCL1rwr6MV2huNJu++RERfK1dcHUnkQzpiIINnL6PdEf/spMD0Vp3i4KVoR1/kEzy3zWCbdmlqLOA2TEdYmSf1SIbHmX0XDIL7EFJZKuEwEw+aCKd7zIHYaQg7cJS2eF/HvlvG/F3jfy7THXm4L0cR9w/lP0a42gJXWcGLB/YUp1G8YGizLNmWoo6D9CwTEys4IQ3BDl6Fz4wMyy8pvEuXq1FMbm+WtbfpwKDDeT7Qs+yZKG2W/sUAkwmqYU1geZDZ6FEYRGQLAb+Alfi/Or+v5TQh+1drKQ63xIDtDinbUDa2KfXD2i5MRIo0ISV4YPMonEpYUZFbNLBSBgp4KQvyMEiGnLM/Gba0w295CPUvZhGD2V6Nv9wXjtB3vbHecRbWI8S41JyRTxADzWvVWGhGY2Kh99Gg4liHQlq+F9ljPCw6vwaZw0n4HtAhpwQPWyy+l80mo1e+/9hkXOUM9UjoyarEJWE5NmeZezeH1elC2SkfUdzKlem7KXBvIEahdGyRH5Zev3gTIi19Icpo7xGGX877tnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wZ1ARTaF7eq+Epm/TqX1Z6BaZFaxOHmKYlbzE0t3HrHncLIpQ4J15bFekNMj?=
 =?us-ascii?Q?AKDKilQwrI91R9d50hEWETeV+oGYlh2PMBuFELIeFVTb1qKaY5UCbL7HM56l?=
 =?us-ascii?Q?07GKCcatKC9U86OH3y0kFqGx5i7+yO7YcQQAaspKzSx9bRZA15lozK62B6QH?=
 =?us-ascii?Q?EPFOu17j5Y6+Xh09n/+HVhnVhy+3pXJw4NjJ2TaUQA4zR1OwB++UfeTH1kgO?=
 =?us-ascii?Q?+sFEc+0aO4L7xU1Dc9rIwvvTYMiif75HbErzXCc9euSGDpFkZgZFY92ZlGjn?=
 =?us-ascii?Q?Q0dl3FfY2SPJdppPe5jvMTcVbgVvvNDuH9RJgbfYElO523Q4UKvPaGGw1z1Y?=
 =?us-ascii?Q?+jsE+I6sWsdjnBtfvZL9QRbvKsh2e5BnUtmrjBNfnH71EomS0L1kcYKItoov?=
 =?us-ascii?Q?ND4h3N6mpGKnEkTvLyRVAjlm1JC+kZPOZpUXKUBJ+8PUR9iM5I0dCq8WTYuO?=
 =?us-ascii?Q?GVJtDLtc6dmddZpoQurNgZ1hWCIWX2FxQKGEMc1Y60zQiBxDjKa9u4Ypsu+3?=
 =?us-ascii?Q?6BKaMcoRK0PosKP34Tmkl8+EXmnT8rf9qVGB9H2D2utENhb2MPGTE6t+ACXX?=
 =?us-ascii?Q?dCQuKWYryuc0cchS42aAyKN7FCcmQgtZf9dHyVaSnFqZ04BICj8tgKzlxgs/?=
 =?us-ascii?Q?msw3vM399bc3tVQYc+9O7WiNDPtqldBNAUa0ceAnrXPKL4LtLcCSgDmVlSsA?=
 =?us-ascii?Q?QGhayw+xao3Wm/sTqcfr6Nyq98xtICw3Bug9d5Fh37fPJJtUCjRVZ37H/d6N?=
 =?us-ascii?Q?InBckwDj1PAnmFbkBBE2hR8pLrDLSM5BD/5BvO5qPcHAnbJh5bmVNSPmbjz2?=
 =?us-ascii?Q?qFbMLUG0q9qQU9QVwmPTQNiMyWVjYA/vrqUcekc6cTsNDGCIHUSDhQzzpob5?=
 =?us-ascii?Q?jcIlCJYHfTz2ySuGBJ064uKDfHvQWrX1z6l7B9pY1jmTrX2B6SXxuNCSQCaO?=
 =?us-ascii?Q?MfU/kybakUyxIbfkjuh4R5G/egWlSmYf4sFhjXOrhJG0aocT8mCtUJAC4P0q?=
 =?us-ascii?Q?7KyiszMVeTJS8w6+ziBISKu0GPV++V0bf3SkxSCEgsDCmkt0aWWRzP7Qgq21?=
 =?us-ascii?Q?9EEfZAGW227qFiCdw+JGKp1iP+l8FbXjAk+ej75COr4SVIUrR+lg3Ypx8zu6?=
 =?us-ascii?Q?Dw9/Fo2olXajRx4xCy7mpqWDFuoB7fEyjOOddQPxcz//Acn3t58UKG0TmNYI?=
 =?us-ascii?Q?Rn2NCmSilTSlolTEzO6EgpeLrg9enXRSjCGH3lmV3ZY4GA3Rl8b6BGRkDUpB?=
 =?us-ascii?Q?ffBGlLKfNfG6lqvOWBRvVs9Dbw/x0/U2oxScvxuWBbruHL/i13/K9sjb3i0p?=
 =?us-ascii?Q?wIUtguz3E6mVyGMyxxmzBxWG66xQImAZeIibcNDpohzCOUwlRwkccJEKi3Eh?=
 =?us-ascii?Q?ZBcpREb4+fY2NsPfrF4kuTbXdF9ZhXCttxIB9vvM/NguYDDjSjqQHM9AiN5T?=
 =?us-ascii?Q?QYhy+cUxUza1KQJI8zk6ihTohfpYIOr2CLcip8qiwF7vmV114v+5/sdEgTdR?=
 =?us-ascii?Q?dBRTw+GERKsY5oYREUnqndnF48PXKPEsxleln/UvHgibR5qvzAgEK+hUMeyI?=
 =?us-ascii?Q?c1LRTGLVgFC9inXm9Ul5pwTTRKhr9Gnd5mHS+CytegOmVspHkAGCCRgDXpPw?=
 =?us-ascii?Q?Kv8og1uytvKJsx/0nMt7Hq6UVr597fs6eCLgCK1+B6eCaBtG93dadTMsFnDJ?=
 =?us-ascii?Q?nQvOUJi3a5fd9LLStH+JY5Ikqkd2aPPI13qwn/SRq3lYtnWSp3K2U92uIt4+?=
 =?us-ascii?Q?iE7XFZ5cfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ca481f-fce3-4c65-7215-08dedd55f91a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:04:05.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLyl2rkq/Ia/h0JkvtmtlHq3U5g7fW5qigyEOBfNxNUqDlm+EgmQakmjlyEpEuLSfvdVI0UfBKsFwxRs2+XR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

CXL bus reset can clear HDM global control and decoder programming. Restore
cached HDM state after a successful cxl_bus reset while the IOMMU reset block
remains active.

This intentionally restores only the HDM component decoder state cached by the
CXL reset support. It does not attempt to restore CXL Device DVSEC
range/control registers.

This was exercised with cxl_bus reset on a CXL Type 2 device. Testing confirmed
that CXL Device DVSEC range/control state is a separate restore class from HDM
component decoder state.

This depends on the CXL reset series because it reuses the HDM state cache and
restore helper introduced there.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 5 +++++
 drivers/pci/pci.c        | 3 +++
 include/cxl/cxl.h        | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index f708c7b80acf..67cdc51182f7 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -894,6 +894,11 @@ static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
 	return cxl_restore_hdm(ctx->target);
 }
 
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	return cxl_restore_hdm(pdev);
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ef25ba5f7fe9..b394704950a5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5004,6 +5004,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc)
+		rc = cxl_restore_hdm_after_pci_reset(dev);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index de58f484b7d9..c1019e1b3b27 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -154,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
 #ifdef CONFIG_CXL_HDM
 void pci_cxl_hdm_init(struct pci_dev *pdev);
 void pci_cxl_hdm_release(struct pci_dev *pdev);
+int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
@@ -164,6 +165,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
 {
 }
 
+static inline int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
+{
+	return 0;
+}
+
 static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
-- 
2.43.0

