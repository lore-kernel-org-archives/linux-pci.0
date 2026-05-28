Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FF438239B;
	Thu, 28 May 2026 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957141; cv=fail; b=IipAslf+KzKzAkg3eKyQp5ZF92STfMfi+9/r422mw9khVvnAQ6x2FQVYIcRBNYCFdZvy3vQ6N+A8BxdlzQ7CgFOmHJUkFwvXdtS4dpNUXfzZlSdiWYgUzQkCJ2sY0p/PzbaX3kNpVNIxMbKhY4CNy/kVOh73M/Zxyo18PuuL8jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957141; c=relaxed/simple;
	bh=3xrFeNZmScWmec77Ta8ZH22G1FjuSm4HD1cXmtuZvGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSQEMBuFJz+Taqi+zctJmU0Dsohrf1MgzkCAb2CjJgbgPiR6F3mUiCJFJ+jtDeHZvo0il7VOoUnrE9jZWxbt8QT35YiGOnhYvQnzgTuqnuqyljRSGxL+OI5oTym35LSW7uzuP/FUE3adovehwvOhwaSg29ava0iEBMHsrO38ET8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N29v6cad; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N29v6cad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJcrRS+zFtzlOwgKuXhkMrDTYjL2PVB+PbAAiMxUj9chzJaRMmmcmxaDFWFOP/CJOvw5VHQ9r90j+RWRNpgmg3BUDpzR47CiuV+rJl/+3FYvFh7yYwkmgKocQQJuV+vf6OjZmf0Pyqz0A10MRGTVpsWrTkBkwZgoJTp6D/gxOFy7OvnPJnkw3H/8zAQAByf/CnW/3AGe8Iq1zP6BmTxoA3LPkddwTbpYy3IasXSt+hd6IIkQhuRbnNKKL6t5+o21Su8b8xt7Lmtm2x3hQSfCPh5r/lMq+I/Wp5+I9go9be5N4/Ild0hv5UhwI5VwmF5mPVJU3l7OED+wNLCo3zjemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2/8jP6kCUEPzTgBRpyKMJowgy8lnUzSlIQiWx3Payg=;
 b=sMGuZw5U3pp7E3zNzejyz5KTsSfc8TrMQ9jPJMy1nMl3tfAYSJYPiBQE5VHbFkRWyochAluU6ZoGBw6KV9Evhd+u+EDGSaZdWpOS0v1+BM962wlokW/rBmxPDI0Nb9oTanmIDm0LVrtu8AKVSLaGWzcM2swZPl2zQAX7N0WvkvYDaP+o0aSuglK0O4uJSh2yji9tm5zpisQgPGmueyHVUYpxWrCtpShFEDr255xvF7rkyZu5nJZu28aIIla00fPXWAdXziHLX6QNcxv8aoWaCf+ULWvlTzuCg1c0h/lWPjqR3FZGLIL6JtanORFHoXmjnWZyYnyGBQ3Np6iAqxnEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2/8jP6kCUEPzTgBRpyKMJowgy8lnUzSlIQiWx3Payg=;
 b=N29v6cad4CWFXyLkGfPYEMnrSpYCDIW2omXlTcj91T/+791hJ/DJ/l8e2UpwTck/xVmIQxUNbeH8jFnst5mfHAJLWsedcvhhfOnpoO1Gy8t3WMT5qWqkXTr9Z5Zy2NR4vMX0TrBUHv6JJiXx9MerUq9s+L8IPKqVo60OKSgXt8+d5WfumPwih5xUeAF8FGF/woQKqQdiB0kdG+56WPfVRrKx78x+XieVmuWn/VNkJviJhXbo60UbdXUM5lIvMeXuZzK2uGPpvg61t1vOJhzA76Rs40wob9QdVnCTSSY33M3P4Qci30JzDRORe88awxqQALZ6K3NOu/Q73aHmUxsVig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:13 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:12 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 6/9] cxl/pci: Track memdevs affected by CXL reset
Date: Thu, 28 May 2026 08:31:51 +0000
Message-ID: <20260528083154.137979-7-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: e6776fba-6a9e-4f7a-75ce-08debc939dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	xz+Ct3DDKNScGvcwDzKhX50/zzcgUGkbShgB+KPz4RrHyYx9lSfte446npCZb+587nVV2rpDjbk0phqXATWEwfw7j1VqbnnfxYKhjKYyv/Vtw+iJMnyQC/iwW6pNANjIkwdSWs5JLgKVrDpcoAWFzOsTNvA1FIj/K8CWdjuYwX3sR+uHAxqX05qXmRtSUrV7SEzOI+qK+fI7Ve76glJ7sIMhGWAEJhHnKhh8vxzbHXeLYO3AqbholY50xRsP5P/yckPXDUCm2ggk1NVdPoHTwrnt7wAREmZQ3DE7vKJxBRJi8OdSEhhWggSXm4uzyHJvN6DqypYgx0qgAPv5xoRwDmRvkuReD4P64YUBhbO6P7TDz3Y1VnOaI0bL335RSqD0sN5dFhTrYpUKmqmpZX4lNAtT9TZWUqCzorpnMiSyTSra5N2aL99xdpxZRk1deEzPTGomtWIfMC0e79TTjl2BrmaYXK6OuJ6H54GP1LJ93CYqszCEKAFLphhcJcIbuEP4dnyu/knV+TUJfclZIFW6uiK9zfT8H7MSq9EANrkEv7NN0LjX8ELstj4iyrNCf5sP0QjodZWqPM37e8y0bCGjHlPG6AWfESrjCvwY62vPJsTguf91CPX70QzT1DongE4uXKKP+1kEpUmeR55ztnkJxXpvQG58j2m6+qb4K87wBj6lqX5XcQ24ZQi/r2sBaVqhfF70U6GkYLVLX2pmn5WgOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5tngl4YFE2P0ZXTy8sVYS4+8liU/cMeHx1ATy/VFp5wpk6TLAyzQwRX6Z9x?=
 =?us-ascii?Q?k5hvqMUEuSEVfzV7kfT/uRO/BhIyc2/PwrcLBkiyy6D4CFF5djVh8Ar3Rul6?=
 =?us-ascii?Q?jqHEyB4g6Ju5F5C+PW8/0S7n9FG10bNxoXEFGWPVuZWarEd9JW7KYHjooIuU?=
 =?us-ascii?Q?lWo4fxMBVEsv+ro9gdxcwfADPtRrWRpygOg0WykhVTLPsBATk6zCTrIwy3dB?=
 =?us-ascii?Q?B59HIafv6eWr3b58lqNS7HCgNTxpIx4gyq0QUujFyvsfygyEKPXxJH9I4L+m?=
 =?us-ascii?Q?HPmHd3vq8Q59cf32H69FAzIAxm4yxfeg2ieWfPIb3sgho7M+tVCNSV1dCB9X?=
 =?us-ascii?Q?SPloE9Pj33rtmDBlTpRe6XEYMRdoppr8pomHkcpDzSop2sO6CRmPOwMT32v5?=
 =?us-ascii?Q?nI1ibnomAKELp27ch15/72RfD/uVVULewPK3Umvs/MkaJrwONiYOe3Hx8+8U?=
 =?us-ascii?Q?hZXiR38+TBkLI+0CIc+liIElZvyEPquhR9ZeMBNTHBV8PqCxY0PJwULImHAP?=
 =?us-ascii?Q?PpHB30+l2vjGxO2qXYa99BBJezr6PwuFfYnioy66bJWdrPOCj9GXC7Wj5dzR?=
 =?us-ascii?Q?dsSsK68OwLyg3kfMlHa3P1yvC4fn0CDnqZnSBBkrOyY8s04h8lm4j5bzKqba?=
 =?us-ascii?Q?WkWf9poyda3orvHoX05xv8h5DAJT4punBYYraV0wgjbcS8vkzZU35HAqleqA?=
 =?us-ascii?Q?FjXPD+HKo6QT6TmDxx9u3fkMZ0pBzryd/bPyY2/rHHV0zueyrelnJbr2Wo2H?=
 =?us-ascii?Q?UFntNarLDLSMDCicp8jtCZBr6xjpAAAEhDvPa2Kiozqyszx0H3EQNjOlSwv1?=
 =?us-ascii?Q?8DbdtNRXDJQ5Xtr1Hf9TpkSmbxDGxhOwMo8xXPYcNfXpbHsqq952nBNk6pXa?=
 =?us-ascii?Q?hUgiKIWc5M4Sb4yTH+YCZIQufiydCPl7cez6CyN3/mWpHbpyNuvPr5fA5OHD?=
 =?us-ascii?Q?Vb2PExrgy6HD77/Aqs61aFuZ1OUxyhSzqLUCJ7J7vTuLjLXbl4aZQ+4PlLlI?=
 =?us-ascii?Q?+xJF4N2bLBPH9PLJ+88qTV4O0uS3G6oKz0dxbPuvEQXm8OLsKO8rGs4jahN9?=
 =?us-ascii?Q?LMX6nLHeAtneoRydIWy8dta3yCh8jK4JXEVqp87/l3fEEDtgGDAIVgO6/liS?=
 =?us-ascii?Q?XOCZWid9jKt7TMpSnqgNl5/O/X/yTjjcG3HA+hWOBVHz1okI+tylmH+mYRW/?=
 =?us-ascii?Q?d0l1PcLniZkkYl7AJHY3G681esr44FC6XkbYq5pR4/Hwl8AHTkZ6nYnGPIza?=
 =?us-ascii?Q?1O6yw5u2/nR5eMJuPU4EWHp+KjDSbKoxtWiDMc7BuQnYm+kwFDr74oXhGiVz?=
 =?us-ascii?Q?5s0si3yoK2cWD4ZH0X+ZL+03tOt65cZeQAkOoDCrFOaKN0eBSgjMhVSVhPDA?=
 =?us-ascii?Q?ZbPWg6DA8yfbn8qTnAltwcIFHy0fFT3tbAeJtYrbaKMKtZviFrqn1gsbZTVo?=
 =?us-ascii?Q?Uw157NT22qy1DdA+GrM5JNrxAIplIwACT7oghVviqTkTSMKy0vlMgzJ1HHLR?=
 =?us-ascii?Q?jHSnnhp9zG9P0oAiE8NJJ2Q4HV58nZ/l+TMCULGfG6DsUoG0efuXyGYSSMvr?=
 =?us-ascii?Q?Aeoy6FN+/Ze4uFvnwrWvxmW+9k6BveYHOz1nR+sOY/pzIdTUqd595mTWBSgN?=
 =?us-ascii?Q?eycHng6RWW+2n921z06LdXHCsznXNRaktN5zZ3nqyQRIJ5zOfrC46ZObJLAD?=
 =?us-ascii?Q?UpXcq1/oAAseF72hjBXzEZt38nBn1xI13H74jNSlsdRwBWU4+sMdXgMkb+sI?=
 =?us-ascii?Q?XD1VKxfvng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6776fba-6a9e-4f7a-75ce-08debc939dd7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:12.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xi46sLx1iQIHvMF1+TKLL6Tw/vepzMndGa9+d9/O2W8D5lDBgywV2EBUo5H7WQUMU3wbGoPscP8Lc5hmKZgAsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

CXL reset is scoped to the CXL.cache/mem function set, so reset
orchestration needs to account for the target memdev and any affected
sibling-function memdevs.

Add reset context tracking for affected memdevs. Collect the memdevs
associated with the target and sibling PCI functions, track which ones
are active, collect their regions, and provide helpers to lock and
revalidate the active memdevs before reset proceeds.

The reset orchestration and CXL.mem restore flow are added separately.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 176 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1dd880f5a333..c755c18c8d84 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1106,8 +1106,17 @@ cxl_reset_flush_cpu_caches(struct cxl_reset_region_context *ctx)
 	return 0;
 }
 
+struct cxl_reset_memdev {
+	struct cxl_memdev *cxlmd;
+	bool active;
+	bool locked;
+};
+
 struct cxl_reset_context {
 	struct pci_dev *target;
+	struct cxl_reset_memdev *memdevs;
+	int nr_memdevs;
+	int memdev_capacity;
 	struct pci_dev **siblings;
 	int nr_siblings;
 	int sibling_capacity;
@@ -1237,6 +1246,173 @@ static int cxl_reset_collect_siblings(struct cxl_reset_context *ctx)
 	return wctx.rc;
 }
 
+static int cxl_reset_match_memdev_by_parent(struct device *dev,
+					    const void *parent)
+{
+	return is_cxl_memdev(dev) && dev->parent == parent;
+}
+
+static bool cxl_reset_memdev_active(struct cxl_memdev *cxlmd)
+{
+	return cxlmd->dev.driver && cxlmd->endpoint &&
+	       !IS_ERR(cxlmd->endpoint);
+}
+
+static int cxl_reset_collect_pci_memdev(struct cxl_reset_context *ctx,
+					struct pci_dev *pdev)
+{
+	struct cxl_reset_memdev *memdevs;
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	int capacity, i;
+
+	dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
+			      cxl_reset_match_memdev_by_parent);
+	if (!dev)
+		return 0;
+
+	cxlmd = to_cxl_memdev(dev);
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		if (ctx->memdevs[i].cxlmd == cxlmd) {
+			put_device(dev);
+			return 0;
+		}
+	}
+
+	if (ctx->nr_memdevs < ctx->memdev_capacity)
+		goto add;
+
+	capacity = ctx->memdev_capacity ? ctx->memdev_capacity * 2 :
+		   CXL_RESET_SIBLINGS_INIT;
+	memdevs = krealloc(ctx->memdevs, capacity * sizeof(*memdevs),
+			   GFP_KERNEL);
+	if (!memdevs) {
+		put_device(dev);
+		return -ENOMEM;
+	}
+
+	ctx->memdevs = memdevs;
+	ctx->memdev_capacity = capacity;
+
+add:
+	ctx->memdevs[ctx->nr_memdevs++] = (struct cxl_reset_memdev) {
+		.cxlmd = cxlmd,
+	};
+	return 0;
+}
+
+/*
+ * CXL Reset is device scoped for CXL.cache/mem. Use the affected PCI
+ * function set to find memdevs whose regions and endpoint decoder state must
+ * be handled around the reset.
+ */
+static int __maybe_unused cxl_reset_collect_memdevs(struct cxl_reset_context *ctx)
+{
+	int rc, i;
+
+	rc = cxl_reset_collect_pci_memdev(ctx, ctx->target);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ctx->nr_siblings; i++) {
+		rc = cxl_reset_collect_pci_memdev(ctx, ctx->siblings[i]);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused
+cxl_reset_collect_regions(struct cxl_reset_context *ctx,
+			  struct cxl_reset_region_context *region_ctx)
+{
+	int rc, i;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
+		struct cxl_memdev *cxlmd = rmd->cxlmd;
+
+		if (!device_trylock(&cxlmd->dev))
+			return -EAGAIN;
+
+		if (cxl_reset_memdev_active(cxlmd)) {
+			rc = cxl_reset_collect_memdev_regions(region_ctx,
+							      cxlmd);
+			if (!rc)
+				rmd->active = true;
+		} else {
+			rc = 0;
+		}
+
+		device_unlock(&cxlmd->dev);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void cxl_reset_unlock_memdevs(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	for (i = ctx->nr_memdevs - 1; i >= 0; i--) {
+		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
+
+		if (!rmd->locked)
+			continue;
+
+		device_unlock(&rmd->cxlmd->dev);
+		rmd->locked = false;
+	}
+}
+
+static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+
+	for (i = 0; i < ctx->nr_memdevs; i++) {
+		struct cxl_reset_memdev *rmd = &ctx->memdevs[i];
+		struct cxl_memdev *cxlmd = rmd->cxlmd;
+
+		if (!rmd->active)
+			continue;
+
+		if (!device_trylock(&cxlmd->dev))
+			goto err;
+
+		rmd->locked = true;
+		if (!cxl_reset_memdev_active(cxlmd)) {
+			cxl_reset_unlock_memdevs(ctx);
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+
+err:
+	cxl_reset_unlock_memdevs(ctx);
+	return -EAGAIN;
+}
+
+static void __maybe_unused cxl_reset_put_memdevs(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->nr_memdevs; i++)
+		put_device(&ctx->memdevs[i].cxlmd->dev);
+
+	kfree(ctx->memdevs);
+	ctx->memdevs = NULL;
+	ctx->nr_memdevs = 0;
+	ctx->memdev_capacity = 0;
+}
+
 static void cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
 {
 	int i;
-- 
2.43.0

