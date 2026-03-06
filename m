Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AF33A9F5;
	Fri,  6 Mar 2026 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789066; cv=fail; b=XT/eP6a/SH7fpkMP+BPb4vChrxIkxCWR+X5xtN81nH+wPv8Yr8ribVPrBw8gVvX9k3TGTaWqQ9rPqCssoVuHHmxAZMQIlLSvFQEepaNVas7PoQiTpUADG9o8nUoDL/7g55sM7fpxa3r5Lxj5l4wiScMbYyeO9mwg/zNTl8gXYNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789066; c=relaxed/simple;
	bh=jH6hkkn1Vy9+csNjgNcz0jICawfc8FwtgvxC6oNv+vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzJaB1LeUL0skFDYXJEtzgHsbVQ1n2QMCxb2S0wr/clSeLcuT6/6zqKF/Or02NZE0chC2wRtjs/myvnHZQAiSLU9EXH6kUWKjis0bdhl4SLMFgIH2ehiyX+4ZfvZA5uxUHxwFMfZVA/gmzRFJ3QSvV2R4luyKVp4wLR8yXmMMRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h2IkrwwB; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2IkrwwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDkpzBmWSlFSUwazal2eEyio6aR+Q++KwA4ERZUeWnqtjo93xtVhm9D5fgL9Bex7c3ydNBw+qTnDNe1rIY8faG32B/oi782SLDWefayI8xC34RRroXDKiRALdaReBuL5ToaOrMfM4fWC9CzWUhHhJAqNuMuuLdL/MFNtGVGue7BFX+NA6FtsoIDnDE/NReiBVqHbuvz2fd0EtfusmSf5bxePKjwiFnthfygRa+gd3Tmji45GQKwwrimohbgBIsh4Mplxyh3TML1Vk8D1IqI89vUTKpnx1NmoibEgtpHIXLjcXnUuZlzkvJzkfMzIpjE6jDeV2rKlNB/xx3H/qRWGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjn+B81Ogq8rn1z2vOjWIGNWowDuxp35OvFtgDHuqbU=;
 b=lp9KChpAyOGlcFfZTrM3/AMfuOkgEUNf/GxWoAB1PhC2YH6c81CyXs1VBbYu0zTw1fi4DO4pSUKNlBX19HCRQ27CGOG6zuF6v8G6eIKMhmlPh357yM8IGvHksPbiIN6fvuRHiB2vxQoMi4ov9Fq5QT2txULZug72Omhj3qlsATV1ZYwoZiBOqzW4gcx+yk4dEXxmSMUyIFwxJJM9XPsltiUOKUyXnuGLHsttbKWIRKD2d2bwDWqH0F//N7AhVqlt6Yljn149z7PVgyxDYu/SsYgn7g0nhPQdD1VpHfrSqbYhPxr96r45+pppO5KBKT2xnsgjYiVKGlf+RF8py/luFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjn+B81Ogq8rn1z2vOjWIGNWowDuxp35OvFtgDHuqbU=;
 b=h2IkrwwBT84/7/pnmmi9T/S5S8//bnjo1ruPOa/cJzETyyrK+Fxo0AuKfDZpaEbGU83G5FzGuwyDsu7lp2McEX8XTaoxYHcgwkLzLejH/kKWbcs+iyC5vlOAI4u/a3lNRbRspwDjNP9rOpDECa1RYc6SIZ9iqtfBdch+4Dla6nFeoK0CCuet1Usrd3fzh+2EOVOj5nOV31J7lzgdh+Bm/Q3TUaiv/BsWnQLzN22FGhzW0zRByt9DeRQpzEAL4QL1OOIEtodhQiNvxGZzGTu/frNSpD1IHsd4Gr57p1ODxcyjxACVvmb00La64WOWxLInvvGmq6I+77p94qXclm7JAw==
Received: from SN7PR04CA0092.namprd04.prod.outlook.com (2603:10b6:806:122::7)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 09:24:19 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::a0) by SN7PR04CA0092.outlook.office365.com
 (2603:10b6:806:122::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 09:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 09:24:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 01:23:50 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 6 Mar 2026 01:23:48 -0800
From: <smadhavan@nvidia.com>
To: <bhelgaas@google.com>, <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
CC: <alwilliamson@nvidia.com>, <jeshuas@nvidia.com>, <vsethi@nvidia.com>,
	<skancherla@nvidia.com>, <vaslot@nvidia.com>, <sdonthineni@nvidia.com>,
	<mhonap@nvidia.com>, <vidyas@nvidia.com>, <jan@nvidia.com>,
	<mochs@nvidia.com>, <dschumacher@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Srirangan
 Madhavan" <smadhavan@nvidia.com>
Subject: [PATCH v5 4/7] cxl: Add multi-function sibling coordination for CXL reset
Date: Fri, 6 Mar 2026 09:23:19 +0000
Message-ID: <20260306092322.148765-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092322.148765-1-smadhavan@nvidia.com>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: a501e4ed-a50a-403e-811d-08de7b622537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	40kJgdGg0eihmc0NuLXMG8HHW1+LJfeIioYDEqLD5Sl+eqny4sz4+RkdaUvGjbCy8YZful0E6x2EIrZTT1baWubCPtq2rQt9FnziCbYkNC6uBghbKSVI9i2F0zRaGn8ERtz3UjuC5+8HCiRo+5+Qimq5eAF67suZ48z/eho1A8XYnQ43J9IGab4uexW6vf/9sSli47o06cLFp+saeZyMDG0FIQilVnnCQEaG8msCDzdNGnfI8KASW/Kje95ZAA4z3vQDSoMIH1b7M1BwrE4MMr69NLnYIhg2F8eA13PG99jNyh0wMUVs8Rvcd4AsRTjK6AUY49Uc/rVHpapE0fckiNG0LtFq+Yf8UmuJGwTMeDDRyRJLfnKo5lwl1ckFUwbHG3fB7f4PRTGIKAl/VP6V4o0+89h1keiitCAILdbeWAHucXnx+u1dtG1bz7ZjlyX/V5665K33WccxsOPznQxDWExJ0ZdApAeT551mdUgOeNz2f3DZ5sIlJ8fUCBuXn/em/8HD4SVdTbbAkVRkuEMdPTUczGF0z6kwngyyRT9oMcAwP1ZGXo0NyI9VSECFxfLBbN78hke8Dw9nv/8VlF/ymt//v5bmvhPuq5CrtkEYjT0B+5cpW1iiZ1xtFMeKwnTW3IBrDjGtyfYROv4cfdsPe/jtgqtliGMFvFWoOeEWaSKQ/oUqUVQwNZ44KizrQZ1Np5pcjrtEGx6bE6M1O4136t2+B6eiH4IpnKDwceZs9tNqFID0+9+YsrKpGRbGj1t6nPIoE3wBmVNR0gKpqwgEBA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oGROdB1L2t6saaoxFZyZHtMMmSu8menLj3tELlrc4M/Y/4BwXQ+okdcEaC5o+cVsEVi9Tk3Uy4XpeW8tX6QnlY3baixy8E77j4941ryTN0sgjCYhm+uWlz/Ip11UveCTnehPir6UvcDHPjRabQeAezBf3PZTcSmQ5asYUEGCgDBsqq2vXPdWI8eJ9gYRg8Yq3El0GaBI5ms9Ql7jzvEsdhzgJ/nUg4DrJtgcYo5+fgrQlinEhRlg86v9IeavtqYVzolGgXrm3j/TPzY3d45jCFKNHDzxDBGizMr87a2VlOpt3KUDzmzsH54rVhTq1IePgMI9vhHXUxZGigR0w6mSdgOtPkyndOBeLoKo7VzD/dgTriWvS3aa6aonotsrpLxMmtgKnp2z4/xjT+BajAFpHGYKPsOKqtmpXOgAw6SdrKaS/9dtA23yGwiqpkZSng91
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:24:19.3063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a501e4ed-a50a-403e-811d-08de7b622537
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add sibling PCI function save/disable/restore coordination for CXL
reset. Before reset, all CXL.cachemem sibling functions are locked,
saved, and disabled; after reset they are restored. The Non-CXL Function
Map DVSEC and per-function DVSEC capability register are consulted to
skip non-CXL and CXL.io-only functions. A global mutex serializes
concurrent resets to prevent deadlocks between sibling functions.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/pci.c | 137 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9e6f0c4b3cb6..b6f10a2cb404 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -15,6 +15,9 @@
 #include "core.h"
 #include "trace.h"

+/* Initial sibling array capacity: covers max non-ARI functions per slot */
+#define CXL_RESET_SIBLINGS_INIT	8
+
 /**
  * DOC: cxl core pci
  *
@@ -979,3 +982,137 @@ static int __maybe_unused cxl_reset_flush_cpu_caches(struct cxl_memdev *cxlmd)
 	device_for_each_child(&endpoint->dev, NULL, cxl_decoder_flush_cache);
 	return 0;
 }
+
+/*
+ * Serialize all CXL reset operations globally.
+ */
+static DEFINE_MUTEX(cxl_reset_mutex);
+
+struct cxl_reset_context {
+	struct pci_dev *target;
+	struct pci_dev **pci_functions;
+	int pci_func_count;
+	int pci_func_cap;
+};
+
+/*
+ * Check if a sibling function is non-CXL using the Non-CXL Function Map
+ * DVSEC. Returns true if fn is listed as non-CXL, false otherwise (including
+ * on any read failure).
+ */
+static bool cxl_is_non_cxl_function(struct pci_dev *pdev,
+				     u16 func_map_dvsec, int fn)
+{
+	int reg, bit;
+	u32 map;
+
+	if (pci_ari_enabled(pdev->bus)) {
+		reg = fn / 32;
+		bit = fn % 32;
+	} else {
+		reg = fn;
+		bit = PCI_SLOT(pdev->devfn);
+	}
+
+	if (pci_read_config_dword(pdev,
+				   func_map_dvsec + PCI_DVSEC_CXL_FUNCTION_MAP_REG + (reg * 4),
+				   &map))
+		return false;
+
+	return map & BIT(bit);
+}
+
+struct cxl_reset_walk_ctx {
+	struct cxl_reset_context *ctx;
+	u16 func_map_dvsec;
+	bool ari;
+};
+
+static int cxl_reset_collect_sibling(struct pci_dev *func, void *data)
+{
+	struct cxl_reset_walk_ctx *wctx = data;
+	struct cxl_reset_context *ctx = wctx->ctx;
+	struct pci_dev *pdev = ctx->target;
+	u16 dvsec, cap;
+	int fn;
+
+	if (func == pdev)
+		return 0;
+
+	if (!wctx->ari &&
+	    PCI_SLOT(func->devfn) != PCI_SLOT(pdev->devfn))
+		return 0;
+
+	fn = wctx->ari ? func->devfn : PCI_FUNC(func->devfn);
+	if (wctx->func_map_dvsec &&
+	    cxl_is_non_cxl_function(pdev, wctx->func_map_dvsec, fn))
+		return 0;
+
+	/* Only coordinate with siblings that have CXL.cachemem */
+	dvsec = pci_find_dvsec_capability(func, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return 0;
+	if (pci_read_config_word(func, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return 0;
+	if (!(cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
+		     PCI_DVSEC_CXL_MEM_CAPABLE)))
+		return 0;
+
+	/* Grow sibling array; double capacity for ARI devices when running out of space */
+	if (ctx->pci_func_count >= ctx->pci_func_cap) {
+		struct pci_dev **new;
+		int new_cap = ctx->pci_func_cap ? ctx->pci_func_cap * 2
+						: CXL_RESET_SIBLINGS_INIT;
+
+		new = krealloc(ctx->pci_functions,
+			       new_cap * sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return 1;
+		ctx->pci_functions = new;
+		ctx->pci_func_cap = new_cap;
+	}
+
+	pci_dev_get(func);
+	ctx->pci_functions[ctx->pci_func_count++] = func;
+	return 0;
+}
+
+static void __maybe_unused cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	struct cxl_reset_walk_ctx wctx;
+	int i;
+
+	ctx->pci_func_count = 0;
+	ctx->pci_functions = NULL;
+	ctx->pci_func_cap = 0;
+
+	wctx.ctx = ctx;
+	wctx.ari = pci_ari_enabled(pdev->bus);
+	wctx.func_map_dvsec = pci_find_dvsec_capability(pdev,
+			PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_FUNCTION_MAP);
+
+	/* Collect CXL.cachemem siblings under pci_bus_sem */
+	pci_walk_bus(pdev->bus, cxl_reset_collect_sibling, &wctx);
+
+	/* Lock and save/disable siblings outside pci_bus_sem */
+	for (i = 0; i < ctx->pci_func_count; i++) {
+		pci_dev_lock(ctx->pci_functions[i]);
+		pci_dev_save_and_disable(ctx->pci_functions[i]);
+	}
+}
+
+static void __maybe_unused cxl_pci_functions_reset_done(struct cxl_reset_context *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->pci_func_count; i++) {
+		pci_dev_restore(ctx->pci_functions[i]);
+		pci_dev_unlock(ctx->pci_functions[i]);
+		pci_dev_put(ctx->pci_functions[i]);
+	}
+	kfree(ctx->pci_functions);
+	ctx->pci_functions = NULL;
+	ctx->pci_func_count = 0;
+}
--
2.43.0

