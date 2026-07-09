Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDF39A7E1;
	Thu,  9 Jul 2026 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559035; cv=fail; b=McfyuxYRrshbj1Oce2CLiOrvJXK1r0EWMmzGo+jk+I3mL/SjDY5ayMLJGMqt0TIA+m4MDOQcnqvgMCkzWf3WPGW34rBCRBV2k+FjkHlxWNjGBjDGzgjNJNttNuwJix/EmQPfISgGYL4SQfCudE2wjCIHoO57K9YiQmu8HPcIBbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559035; c=relaxed/simple;
	bh=rKLuWcOKsX0RFyPahQ89yMxHbtKIWyrfJIirmx4o7fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PprWgjzzHaJjC2Leh4q6Amv/NOVET8Ed7vwQgXXCRCeiOJiERRKXBWFJplF6bi+PHm+U4elwNTkcTIbHTGU8W368qSK9ZO2Kumqm6Km+gg5VRVmAnTckymmzgLLyINOVlJttuyNECQCnYZKggBWduMzo7tV1YL2AqpxXnXqjd50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0XlBkO2; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0XlBkO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H36TK89iC3h2xx4MWGtG+Yz8SbRFPXPGY6DxysiQQmhop+yDKPUiBtssFjiRIIaUJrg+OPoNQUHt8xjn1+DPgHBnR0oAhD/Hm1aaFhFGy4ePT1kQ4IpTtuzvtpli1o0uFSFMP2l1bT2FxjPD6HwwR9koc/AK1UrWj8E39buNHklsIVEFy3kah6dQPGMJ2CWpWdukmWmsBtNUwupQ1bW5qMgnNB2M1nmOjnxhP3pKumhd7oLnAGtlgQS3Ar+j5K3ExT6wpNzEKgweDsZyh/KOcptK7FVUxyb60ggHyTeFdNbw8zrnTvRxNuMwfq/IAm+BQ8eeWxxFxCulzaPQ7kpDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHVq27xAX4PEuFkPMQkJy8kubEenACtpV54yZVRnKec=;
 b=fDJOs4OvxR8PPv6I+RicRncz+jfOMeSZZMLXi+HtQdk7ECC9PLqCZqyfinQHeBgdIdHvS9i+nHAPa2u0jARYuvY7FyJ6Nv3aj2qddHarWoQVBlDYugLO47H6k/OSgU+cIjQ4iLq5b8uui8d1rS9WJRrsCXP6AL4SeV+OzfCfQemDa+8648FhbVAZUuV+0IzYBteYE8NkvgxrBXx3Vxbs79wVG+gSthWYWeawkOjtscjGRnQoM1qNGTUk9+iSnVwpE97v+6PMaJi2uv6x5eIWbWIK1CKA1BS+M4jINQqVY2J4hxzNu+hRnYbPmrNaQbcX6EhlnuheWRSBgRn1XBzhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHVq27xAX4PEuFkPMQkJy8kubEenACtpV54yZVRnKec=;
 b=C0XlBkO2outOgR3SqWTk01NvFQN4Ow9N3E+ySGL5z8GraNB9kOnsiHk47YNGJUWkrxwqCwfr+3KblwYw12qziGjnvjQU5hJshmEOOFGMW+N2mZTohgXOIwxBTaruZkoFU/Ch5l/C/mt1KRkbRi8InDDwXeW1vGPbXALyJ24tpS+FClA7BQ8bMMVi+NEmyXxyYjlnAxqkG0nMegdxgY8XaBv8hV5jPLeufCp4Egw1IFeQhICuZmILJ9Ze5ZfB2zLxubb0wRQW2ZwtQ6V2NEqWNhvATrzAVsybwJ9Ms/azfpYLszIMyoQ+K8hzvMdf8sr8rd1wUmKtVDlpthKKI9KUwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV2PR12MB999071.namprd12.prod.outlook.com (2603:10b6:408:352::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 01:03:51 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 01:03:51 +0000
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
Subject: [PATCH v9 06/11] cxl: Validate HDM ranges before CXL reset
Date: Thu,  9 Jul 2026 01:02:59 +0000
Message-ID: <20260709010304.680422-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709010304.680422-1-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV2PR12MB999071:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ff8e8a-fbe1-400a-9719-08dedd55f05c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZsruskRteu0BneYECC/H/xn8pYNzxlFczql46UMx5qalFoQOR0zaiM4PVy0DjFODqbbsmn4d8Hja4f0dUXXRuLJOsfy3ge5dc3ZF2mJePWrjMI3MjCSWedLuVBP86hCESXjrlJ4dj3sxb3Iy+xgVXbEkmRfchJGoTv9vvbFygnq55y5e/83923vic3fSRUwafza7fJmdZ0nQMu+AE7WfAiKmfZvQDEwOoP9VPJq1/QBi67XhiEYs9beKo9TcZtNtPqAobSNdSQyu/VN1QvcZODLCM/Agl7RmZfHFU6j6NsiAdrcNxjIWpHjFLsearSAOhe1WHYz6xHfPWlfYkgy2MD/1pEfUBVLhhnjIz1uHcvCcCv3otDufpxQTgmK2bEFqXvA4HKtIKqfyElV8LxSJcSZki+Z+bC7PNpouYkDpeG5geWUsAEIre4ead+j2p2p5qji9jOr59sKv3z+om4u8GRbbwd1FgUMElmeKQviosYDexjuiJkzx1bMiMEQZogirFSv61RVfXSdeODRBjojTekxSGxTvk+mvKWR3K2eJBKk9f2+ZltFh7q8zeBApIMR3DeVmgHEEJN5KeCvz9wo7inHrNnvGogsqwYMhsmSNXFae0OxFvsVgEi2ja43B2CtKoRzhCdpjwUTTWv9GEUqhTzYFH/Gn5DS4GXZlUAjWR3zG8S+C7pE5PvRAERI8CkA1XjIm9Y+JPaUfdcXnGn0VJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFUj/xUax1vwv0HSkXdz0NTRhwUgtfBCc0x3KDeVjEFnO6KQW0miwi25EuoY?=
 =?us-ascii?Q?uFITM8wqSkmr9xDOBAUUzoDpJQTJqVjiI4Gn0d+SoYrF2+LbvGbmFtuMC5NV?=
 =?us-ascii?Q?zlM371kkCCmxZysQK81H9IslifOhNzrgZBNtXzjirCo1ga2zf0WSHIPNS7xD?=
 =?us-ascii?Q?Uaq6q4RRlldsNvEfTxYIcfihWNTZZTuDTg5c909UWG4hmsXilLt6jSprc7RO?=
 =?us-ascii?Q?GCDdnI1I+Z2RYRVrw2O64Xf/QnvIh9OQ3MRmzvlhFWTxlmDS4lKHiJphdjGa?=
 =?us-ascii?Q?tmJ40n+IUnNUGuPN7TcNjH6v7pArXcISUAHAKK/q/olAC6r1zlUZ2E4EYTvS?=
 =?us-ascii?Q?2MZCEFQbv1/nRgCGp7ErP3w+unN/8teM7SWiJeWbRHgXvizg7H0/Z3+0GDk7?=
 =?us-ascii?Q?4QYnuOlk+E3yJoYbsI3JCRGGQnlxhLG399t/mJqdU/k1hbMD2T9Mz1OjMNTj?=
 =?us-ascii?Q?0vcPdi0Ro7qZY/z8K0VBziJZVx0esVzoQn6DA4LCOeUVCSj4omCNaGNuvGAa?=
 =?us-ascii?Q?E7vHc3cEhFz0l/ogxn29LzaqSvHx51bbZrn7x9AHBH3w4CJD9bDDDwFHK0cg?=
 =?us-ascii?Q?T5Vx2vja3e1iPdu5Mq+rjHXf/x0ZJT3Yj7pEtmQGI/xaedGYlRInTaSnvXOm?=
 =?us-ascii?Q?u0OR5T2AcjB9BqS72DL/r22cY6Dp+aCNsibrXm23VQrMj/0WHKx8u+LlJwx9?=
 =?us-ascii?Q?JdU8HwtlAztcTbcQwsdRhAwy+YzJAEW2IxHFV3xqRzlP8cOqysTCaA7JQp/g?=
 =?us-ascii?Q?3P5YDRPbVrwbhRwO8crGCz2Hev0cxMoJwNBjjKnuSKPwcuunhYMqqRNTO6OQ?=
 =?us-ascii?Q?O00Byd1PuzThLVYFFirU6rzZ8agiwRbCbyNDPM4VYw4Klr58Tvkg87JF6FGy?=
 =?us-ascii?Q?74XJA2XKIBmSfiKIlH3U68VMZ1jThBBQvsjoNwAO3QfJx1q9yqixWNMYhfiI?=
 =?us-ascii?Q?RdFevTpUhH43jYXe9NQu0qAZV/IXr7s5u8I8br5mlFK+8sPnRKWAcIGRJZWB?=
 =?us-ascii?Q?dhIR/xkrwxnY1LQDvQgvDAyDT/E1VWOIwsSrUJA5I3vViJt9ayX4Q//6NcOF?=
 =?us-ascii?Q?Ett6jXkRFwYZ2Fl0cAIzN5NeBsn7aQ0XVpuoyM5bDCadHvIw3dRSeDlyh87I?=
 =?us-ascii?Q?ZwZVKqzS079gkRsimMZCj29Qk0y+Kq+9bhoLhRIITHV8DP81UVu3+hII6rVm?=
 =?us-ascii?Q?2HdXopG2PSjeALMSxk3PJ0lqTh8K+m0QdkBHkWeLEUpcSEj1+mDk+80dV6se?=
 =?us-ascii?Q?t0vVQY5tQ1YySYU/HHNZVLsxXJ2tBj9pj7oUaGwCu2fl61DKvg3xuMUXzS+3?=
 =?us-ascii?Q?aOTLW8sTbMRVAarWxnioVNEOvgfKPxLZ5gBFKKHx9TRRoqgGiLbtSzUVoc3i?=
 =?us-ascii?Q?nV390rEODtJmdm5P7pfWef1oIFLDQBb6eo/8XQRd/tRBtMuiTeTECA6hx27O?=
 =?us-ascii?Q?sA/YDL09wfb9LYZ4J+4FDVA+xzut2MWoQ4FklubHndUhBRB0VVYAZu5nGla6?=
 =?us-ascii?Q?w0ylV3TLNXNLpZzlSt+aNXE53Gx1AU33dLVVm4GaIxPTZj7NNSacjWV1+782?=
 =?us-ascii?Q?IBmHuLqAVwITb6jyMSrn/9AC3mcsPnlj39fBwwkXFfMqEMGVeG8GeKYSDoNt?=
 =?us-ascii?Q?hIaklXOjmg1O+af4oLCIipJetBv8MDuFArJ7MomqBLGNYYcivsOHXMD8zwbH?=
 =?us-ascii?Q?jJnU/kZre8lKH5RTvjLUJ4Mq461/g0hnSk23d2/KZ6Gc21wxPob/tpToqHeO?=
 =?us-ascii?Q?5nYnEW+YJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ff8e8a-fbe1-400a-9719-08dedd55f05c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:03:50.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozhw2Wv23mdD69UFpBBI+vbRPPeGYL4o9kCNI0qfsQlzdeDcjzr3bWlHJtpehK508LPGR1TgUDFBrzCr4pTu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999071

Before reset, collect enabled cached HDM decoder ranges and reserve them
with request_mem_region(). This rejects reset while affected CXL memory is
busy and keeps the validation stable through reset.

If CPU cache invalidation support is available, invalidate the affected
ranges before reset. If the runtime backend is unavailable, continue after
the range reservation succeeds.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/reset.c | 240 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 7a9b1ecfadcf..fb741b66e502 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -10,6 +10,8 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -467,6 +469,231 @@ static const u32 cxl_reset_timeout_ms[] = {
 #define CXL_CACHE_WBI_TIMEOUT_US 100000
 #define CXL_CACHE_WBI_POLL_US 100
 
+struct cxl_hdm_range {
+	struct list_head list;
+	struct pci_dev *pdev;
+	struct range hpa_range;
+	struct resource *res;
+};
+
+struct cxl_hdm_range_context {
+	struct list_head ranges;
+};
+
+static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
+{
+	INIT_LIST_HEAD(&ctx->ranges);
+}
+
+static void cxl_hdm_range_context_destroy(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range, *next;
+
+	list_for_each_entry_safe(range, next, &ctx->ranges, list) {
+		list_del(&range->list);
+		if (range->res)
+			release_mem_region(range->hpa_range.start,
+					   resource_size(range->res));
+		kfree(range);
+	}
+}
+
+static int cxl_hdm_range_add(struct cxl_hdm_range_context *ctx,
+			     struct pci_dev *pdev, const struct range *hpa_range)
+{
+	struct cxl_hdm_range *range;
+
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	list_for_each_entry(range, &ctx->ranges, list)
+		if (range->hpa_range.start == hpa_range->start &&
+		    range->hpa_range.end == hpa_range->end)
+			return 0;
+
+	range = kzalloc_obj(*range);
+	if (!range)
+		return -ENOMEM;
+
+	range->pdev = pdev;
+	range->hpa_range = *hpa_range;
+	list_add_tail(&range->list, &ctx->ranges);
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_collect(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+	int rc;
+
+	if (!info) {
+		pci_err(pdev, "CXL HDM decoder state unavailable\n");
+		return -ENXIO;
+	}
+
+	for (int i = 0; i < info->decoder_count; i++) {
+		struct cxl_decoder_settings *settings = &info->settings[i];
+
+		if (!(settings->flags & CXL_DECODER_F_ENABLE))
+			continue;
+
+		if (settings->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING) {
+			pci_err(pdev,
+				"CXL reset does not support normalized address decoders\n");
+			return -EOPNOTSUPP;
+		}
+
+		rc = cxl_hdm_range_add(ctx, pdev, &settings->hpa_range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_len(struct pci_dev *pdev,
+			     const struct range *hpa_range, u64 *len)
+{
+	if (sizeof(resource_size_t) < sizeof(hpa_range->start) &&
+	    (hpa_range->start > (resource_size_t)~0ULL ||
+	     hpa_range->end > (resource_size_t)~0ULL)) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	if (!hpa_range->start && hpa_range->end == U64_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	*len = range_len(hpa_range);
+	if (sizeof(resource_size_t) < sizeof(*len) &&
+	    *len > (resource_size_t)~0ULL) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (sizeof(size_t) < sizeof(*len) && *len > SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds cache flush size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_request(struct cxl_hdm_range *range)
+{
+	struct pci_dev *pdev = range->pdev;
+	const struct range *hpa_range = &range->hpa_range;
+	u64 len;
+	int rc;
+
+	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
+	if (rc)
+		return rc;
+
+	range->res = request_mem_region(hpa_range->start, len, "cxl_reset");
+	if (!range->res) {
+		pci_err(pdev,
+			"cannot reset while CXL memory range is busy [%#llx-%#llx]\n",
+			hpa_range->start, hpa_range->end);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_request(struct cxl_hdm_range_context *ctx)
+{
+	struct cxl_hdm_range *range;
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		rc = cxl_hdm_range_request(range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_range_flush_cache(struct cxl_hdm_range *range)
+{
+	struct pci_dev *pdev = range->pdev;
+	const struct range *hpa_range = &range->hpa_range;
+	u64 len;
+	int rc;
+
+	rc = cxl_hdm_range_len(pdev, hpa_range, &len);
+	if (rc)
+		return rc;
+
+	rc = cpu_cache_invalidate_memregion(hpa_range->start, len);
+	if (rc)
+		pci_err(pdev,
+			"failed to invalidate CPU cache [%#llx-%#llx]: %d\n",
+			hpa_range->start, hpa_range->end, rc);
+
+	return rc;
+}
+
+static int cxl_hdm_ranges_flush_cpu_caches(struct cxl_hdm_range_context *ctx,
+					   struct pci_dev *pdev)
+{
+	struct cxl_hdm_range *range;
+	int rc;
+
+	if (list_empty(&ctx->ranges))
+		return 0;
+
+	if (!cpu_cache_has_invalidate_memregion()) {
+		pci_warn(pdev,
+			 "CPU cache synchronization unavailable; continuing without cache invalidation\n");
+		return 0;
+	}
+
+	list_for_each_entry(range, &ctx->ranges, list) {
+		rc = cxl_hdm_range_flush_cache(range);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_hdm_ranges_prepare(struct cxl_hdm_range_context *ctx,
+				  struct pci_dev *pdev)
+{
+	int rc;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	rc = cxl_hdm_ranges_collect(ctx, pdev);
+	if (rc)
+		return rc;
+
+	rc = cxl_hdm_ranges_request(ctx);
+	if (rc)
+		return rc;
+
+	return cxl_hdm_ranges_flush_cpu_caches(ctx, pdev);
+}
+
 static int cxl_reset_dvsec(struct pci_dev *pdev)
 {
 	int dvsec, rc;
@@ -662,7 +889,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec;
+	int rc;
 
 	dvsec = cxl_reset_dvsec(pdev);
 	if (dvsec < 0)
@@ -671,5 +900,14 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
-	return cxl_reset_execute(pdev, dvsec);
+	cxl_hdm_range_context_init(&range_ctx);
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		if (!rc)
+			rc = cxl_reset_execute(pdev, dvsec);
+	}
+
+	cxl_hdm_range_context_destroy(&range_ctx);
+	return rc;
 }
-- 
2.43.0

