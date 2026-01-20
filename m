Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55A46AF29;
	Tue, 20 Jan 2026 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948042; cv=fail; b=lTOVYMu0zyDkV9qoCEU3DvJqOpIFd8lNClU7XGWXR+quCwi4fZmwPGS6pIwe1YTTVk1HihIrWwRC0CBw5ha8dFPL6ltpX8m+Fe3ixsxmFVdElQu1H3vjW5SLbCkLXlhCMe121ZGK2nrhfGsvstosTIa8BLfiiZqlP0ChzYvIq1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948042; c=relaxed/simple;
	bh=bKk5tvTOxTIlUfyYnD4tquH/Oy65EfUuXl8Z8fKtyMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ms5cJA1ujuq1fei08aUrJHLTeXsZ6qb2hu4EQqoO9OJcyd+e8fMHn1KrC9ShpkMbyRXBd4AoKMkU4q2vNUcjQSOJWiHBTARgx+I/HNzRwI7P9G85Xdzy4Y/abGicaOd17l/7NckUQm3pDfGN3M6xUWAGJ9o6fL8BP8PH6ssnOmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0/KrWc6; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0/KrWc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzhW2x3kyHYjBOiyUoxSWdFQ5/g67e9dVyY6m7tNbeUNh5LmcRTlYSlm6o6J1IVt+lCk1ADAdqryPcrgeSaQocQEDQyg5tAFaQH1DOFaGyMTF+pKQYUR6+du9APhR73bPbRIZr14FTTL5i5KkkWG5Y/rjnnMSpK69GFy6xIGSg8twv6WxypcWT/GHQcH0By60uu4glKfMeMSi6L4AT6Unvlh4pGxcxcpYKDjJxc8G8GMQRFCcyUqDufwT/CtTu66Mq9GIjZnVwn5dJbE/GdoCgGJRzzjuhLYTbe6Hvem2v4krtq6em5QXnaMyKI+jlWDKVVuRxQ12Nmx5ekkKDh+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUj2R5BA4QXpIlqk2WAptkJcS9tCiaTj4HWiHjCfXH0=;
 b=Y5BxOtLY8LznblHEy3fppBxjmKer2yUuveNMONypGHXWRCblVJClty4WEwHJ4Onrk1ZAUHBYS7NVXOC9/gJIqWkm4p3091+9Ta5Z7L+8NJo083ERe42UkKh8lJYgb7XXuK9lY0B/fo6IALEwUQ+ckM/UgthunjaONUfRob1fg4UNDoSGYUao0BJqK19W9w6LtzJ5p9D9ah1azJ1yJ2PiQVYNAHQBEYXw0MZyZjjKX23ajkwRt3XqX1ygPPDicFyACkIzejKYyygg2xAUql1A1gyzhLG5t8eG3BxPd5SjuD/fSf5KMpzmGuqW2rvjxJtyAIxce5xdtRwPRwpVcDiqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUj2R5BA4QXpIlqk2WAptkJcS9tCiaTj4HWiHjCfXH0=;
 b=h0/KrWc6kcSAkbepHHK9a+Dnp20rPdUlN0mm3p4CYdK6T15pls3nBWwioT3WavS0SkbCQOmmT6zApI6aadlZSby4eCu+f6itrpzlzIcG5AGvH/hRKcyWYs8srPSXsr2kC2Dv4JBILylhtJLsVSPPql+2hJuLt6/hz33ytoQCVQN0HnwEtb39MjkzijAlQbaVuJI16GOg7DVnVQSTpbqgXydiMmo3SIucSdR+QHAwV/MYAbt9WLoFL/xlvak6PEWuc2hakFYkPPJejA5ZpmKUqPy3xvQZggF9BVVTSGk/njoiZ1VL/UW+kt1cPKDSg9ABKWBFbTFlpP7FpNN/3Nk5fQ==
Received: from PH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::11)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:27:05 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:510:34b:cafe::54) by PH5P222CA0010.outlook.office365.com
 (2603:10b6:510:34b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:27:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:35 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:35 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:33 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 07/10] cxl: add host cache flush and multi-function reset
Date: Tue, 20 Jan 2026 22:26:07 +0000
Message-ID: <20260120222610.2227109-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: d169fbd4-227a-418d-ecfc-08de58730a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rm9ILSGbnGpOrcre61KIgBvgo60wpha+3OBPG9rBeAqDhs+d3mciPHD9pjl0?=
 =?us-ascii?Q?wC+P3zHeITUc7LcH1i5K5bCdBFiaH1ZOCbUzFsrrqgVlHSGpj9au6WvQ7/ja?=
 =?us-ascii?Q?D9vr0kpAssCTAlOZFrct9XV4LPF1hYYiov2jjc2unR30otOCIoEe0syGlYk+?=
 =?us-ascii?Q?36zTRa6Y8O8MOyU9BA2ohwasnXDod4+QlaSsNJK+xvO1bOPF6drkyO3A+DeC?=
 =?us-ascii?Q?ETzZ8s0mryFx94kP11Om8Z1NtOqlkDwJWHKvsSA/sLhMzbCHiAHkq5lHdHkC?=
 =?us-ascii?Q?tSnTNDjYf+szIpqJlbaDl2dq17zBQy+Xuo2lR5Z7/7ou1F0UA9cQp94jgYd3?=
 =?us-ascii?Q?9lhenDjC1Kpg3ws7irgviEqpfGrTIQcDUp1qPmgyMmH5WFGPqcIbiXL1nvno?=
 =?us-ascii?Q?WckEsoYpdlDVzebpsfDlIT+ZymLNoH+Ia8EekDep08c9ACbyklr6cgQL4/UI?=
 =?us-ascii?Q?TMQ+uLQ3mrMAdoMZpv/0nXXZMmDOU4bosIr0QWlLfeM2OcmXKln9bWLH69ui?=
 =?us-ascii?Q?Lj7xLtoxfuf7xmKRQNQDyfTc3NFcrUDfmqIqQnzV5BnnfC2UZ5k7TrYNfhHR?=
 =?us-ascii?Q?HTQi/VP3fkztpgYq5nlzl0xLgIHB28b9M6F4wXfGkatahQPoO9IKJpADoxY4?=
 =?us-ascii?Q?C6kCf2PWGkLodQaauETAcUBAFWH/BGBFrRb0rMD9XL5Z7wzSaUg6sgEycFRW?=
 =?us-ascii?Q?CbQcMhRVckW3Vv6PmS1oD72vgNR221h4osKQwraVxDc+i+V/q365t4V5Ing8?=
 =?us-ascii?Q?scM/92+v9loqwjg5RjYtlgToBDSYOGDeTFhlvWhdE2oNdOLecm4k+JFiclbJ?=
 =?us-ascii?Q?8k35PEXDwNVi9NTDnfaTdPTErfK3b+VQdI0fTpfcQxqKpgFtsaaNGHu96RsJ?=
 =?us-ascii?Q?5gNpdcAPLR14Oyt9Am4KI4L5hANWQXDR5HolKu6O7Aac2D3LzW6YVVY332Qw?=
 =?us-ascii?Q?cIkXVcnS1Q4gN5vyhCs9ifoP/43FABYI5iL5BeEIGgnsoSSAAjtehMw7YLbA?=
 =?us-ascii?Q?TuOQu54oh+gVusUg3qPdryiM8pCOFDaQtglgAiWCzJ0nromYanV2D8O9G8k3?=
 =?us-ascii?Q?hKLTZuo/DM+Jka0AKWhHU+b+9OhnedrHbBbQApC0Nb7+zmFBWC12A0PL6DpH?=
 =?us-ascii?Q?dMmTXiGujX22u9QVYWbaaCPsmLvdxRMgqT103GoXAHSjI+fmf3HKLtPhj9/A?=
 =?us-ascii?Q?aiEnEZfyTc/dhPFEf6UQuLeAlpDiYJHHzas8agX9o8W4iK2bbNLNyS+o2CeK?=
 =?us-ascii?Q?FpW5oas1gZGEI5/hp9uI2K5ZMiBcEs7ZtHvF2iDQX606OfBo8R7u27GNWl84?=
 =?us-ascii?Q?cZPRna6PDQOoPXXjwKFPIdYDfMHnhOGygTYFlbP6rik0Sn5vEq044+miz1NC?=
 =?us-ascii?Q?fwkbQYyT2qFGC1C8YJztKZycEf8D2zgEWF8/v341mY9PovtIAPjvoqXJtKW4?=
 =?us-ascii?Q?tM9K4xiE3Go6bIzBldfn+GsTI9+bOQdhMMFAP4JO/I5w3TQ5/NrN9B5HqCou?=
 =?us-ascii?Q?Bk/4NahcWb1DHxxjZWK1Wle0wVF49kvY2eUVr6476QHoqCBYgdmb9hwtex5g?=
 =?us-ascii?Q?aHYLfO2aFuOf3Y0jNr3H8FAb5T0pF1EwiyWbh00gCiQhqXF+dVBwTs5eN+t3?=
 =?us-ascii?Q?l8VY622xbzWT3pkJKV5k8AcUI3ixDgUkwR+Adi8dfrws?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:27:04.8481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d169fbd4-227a-418d-ecfc-08de58730a3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351

From: Srirangan Madhavan <smadhavan@nvidia.com>

Flush host CPU caches for mapped HDM ranges after teardown and prepare
sibling Type 2 functions on multi-function devices. The host cache
maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+
invalidate on arm64 via memremap() and on_each_cpu(), matching the
required ordering before reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 150 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e4134162e82a..f9cc452ccb8a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,10 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <linux/align.h>
+#include <linux/cache.h>
+#include <linux/cacheflush.h>
+#include <linux/smp.h>
 #include <cxl/mailbox.h>
 #include <cxl/pci.h>
 #include "cxlmem.h"
@@ -1085,6 +1089,71 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
 	return cxlds->type == CXL_DEVTYPE_DEVMEM;
 }

+#ifdef CONFIG_ARM64
+struct cxl_cache_flush_ctx {
+	void *va;
+	size_t len;
+};
+
+static void cxl_flush_by_va_local(void *info)
+{
+	struct cxl_cache_flush_ctx *ctx = info;
+
+	dcache_clean_inval_poc((unsigned long)ctx->va,
+			       (unsigned long)ctx->va + ctx->len);
+	asm volatile("dsb ish" ::: "memory");
+}
+#endif
+
+static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct resource *res;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	res = cxlr->params.res;
+
+#ifdef CONFIG_X86
+	static bool flushed;
+
+	if (!flushed) {
+		wbinvd_on_all_cpus();
+		flushed = true;
+	}
+#elif defined(CONFIG_ARM64)
+	void *va;
+	size_t len, line_size = L1_CACHE_BYTES;
+	phys_addr_t start, end, aligned_start, aligned_end;
+	struct cxl_cache_flush_ctx flush_ctx;
+
+	start = res->start;
+	end = res->end;
+
+	aligned_start = ALIGN_DOWN(start, line_size);
+	aligned_end = ALIGN(end + 1, line_size);
+	len = aligned_end - aligned_start;
+
+	va = memremap(aligned_start, len, MEMREMAP_WB);
+	if (!va) {
+		pr_warn("Failed to map region for cache flush\n");
+		return 0;
+	}
+
+	flush_ctx.va = va;
+	flush_ctx.len = len;
+	on_each_cpu(cxl_flush_by_va_local, &flush_ctx, 1);
+
+	memunmap(va);
+#endif
+	return 0;
+}
+
 static int cxl_check_region_driver_bound(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
@@ -1245,6 +1314,9 @@ static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
 		return rc;
 	}

+	device_for_each_child(&endpoint->dev, NULL,
+			      cxl_region_flush_host_cpu_caches);
+
 	/* Keep cxl_region_rwsem held, released by cleanup function */
 	return 0;
 }
@@ -1259,12 +1331,79 @@ static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
 		up_write(&cxl_region_rwsem);
 }

+static int cxl_reset_prepare_all_functions(struct pci_dev *pdev)
+{
+	struct pci_dev *func_dev;
+	unsigned int devfn;
+	int func, rc;
+	struct pci_dev *prepared_funcs[8] = { NULL };
+	int prepared_count = 0;
+
+	for (func = 0; func < 8; func++) {
+		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
+
+		if (devfn == pdev->devfn)
+			continue;
+
+		func_dev = pci_get_slot(pdev->bus, devfn);
+		if (!func_dev)
+			continue;
+
+		if (!cxl_is_type2_device(func_dev)) {
+			pci_dev_put(func_dev);
+			continue;
+		}
+
+		rc = cxl_reset_prepare_memdev(func_dev);
+		if (rc) {
+			pci_dev_put(func_dev);
+			goto cleanup_funcs;
+		}
+
+		prepared_funcs[prepared_count++] = func_dev;
+	}
+
+	return 0;
+
+cleanup_funcs:
+	for (func = 0; func < prepared_count; func++) {
+		if (prepared_funcs[func]) {
+			cxl_reset_cleanup_memdev(prepared_funcs[func]);
+			pci_dev_put(prepared_funcs[func]);
+		}
+	}
+	return rc;
+}
+
+static void cxl_reset_cleanup_all_functions(struct pci_dev *pdev)
+{
+	struct pci_dev *func_dev;
+	unsigned int devfn;
+	int func;
+
+	for (func = 0; func < 8; func++) {
+		devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), func);
+
+		if (devfn == pdev->devfn)
+			continue;
+
+		func_dev = pci_get_slot(pdev->bus, devfn);
+		if (!func_dev)
+			continue;
+
+		if (cxl_is_type2_device(func_dev))
+			cxl_reset_cleanup_memdev(func_dev);
+
+		pci_dev_put(func_dev);
+	}
+}
+
 /**
  * cxl_reset_prepare_device - Prepare CXL device for reset
  * @pdev: PCI device being reset
  *
  * CXL-reset-specific preparation. Validates memory is offline, flushes
- * device caches, and tears down regions.
+ * device caches, and tears down regions for device and siblings.
  *
  * Returns: 0 on success, -EBUSY if memory online, negative on error
  */
@@ -1283,6 +1422,12 @@ int cxl_reset_prepare_device(struct pci_dev *pdev)
 		return rc;
 	}

+	rc = cxl_reset_prepare_all_functions(pdev);
+	if (rc) {
+		cxl_reset_cleanup_memdev(pdev);
+		return rc;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
@@ -1291,10 +1436,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
  * cxl_reset_cleanup_device - Cleanup after CXL reset
  * @pdev: PCI device that was reset
  *
- * Releases region locks held during reset.
+ * Releases region locks for device and all sibling functions.
  */
 void cxl_reset_cleanup_device(struct pci_dev *pdev)
 {
+	cxl_reset_cleanup_all_functions(pdev);
 	cxl_reset_cleanup_memdev(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
--
2.34.1

