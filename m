Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049942DA57;
	Tue,  4 Aug 2026 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871839; cv=fail; b=cS9U4rjhkprkX3moPe1gJvkDAllQJfWDB+wqMuxtgxCMDUAVNI22YoqJHYllzyUYl+gNoGn9UmeBlwI5QB3YufvyNBloVr0asSo5J1ujN8CeL3YuHBSs5+/pw2J1M20g+I2wWiO27tCEFVDQzR6idTNi+TCMYOWskcr3cahgWOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871839; c=relaxed/simple;
	bh=nwWUIJBAL7FpJqR3sJQVIBBfDEuZRfs0ui0VgesHINU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H04mjczliGa9xZtU500GsuLOodSESE6Y6z4/7yzKouHMYBUZFW0yPMiTe7p4qehwirQPPphOald5pCEFQ0zme3lPz67O2oy7A7955nPDUFoXFxlIcjts0wPNLz4WlIPfhhUW0bPH4uebyCNiMZ/FfsIXI6br8qII4mk7QAgdV60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bCXrTasP; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bCXrTasP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWwqBDMD18WaV7kK0aEfTjRQCXfgljISzjSYsD4g4fsgH0BFuWvzHVhFb8DKbGpEYbNdsHU1Q9+DuFWEmwFp/TQjxrDchTTgbyynpLpkSYsg+L71z2EzYsoqt/icMQnM8PKkJUqrCUvr6kNWFA1oOlWZ0oTXCLLvmfGC9ywUbIa5Yj1aztIXNYJ+1S2/GCGKEex1bTn4risFsv/BLcMvaqX93c0ihUMHUvfP4um+AkIm6bbDu13fChNtZV/oBolqobiqcNmg48WZjX3AV+3kiVMTMOLI4UFYRuixsAQ2e3zLavPkwjNWVt+rgtlrAHZugM8I5aOkFWtUT0bskp7RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMNoKZK7MUzEymrHsWn4y4vhdE0DJJUPdR7+IXKWSiE=;
 b=pzA2rF6jKtwEl0t1KjRnikoULkWL9HdHiXg8CwmUYTmdFXlcRIEZx3eEJ3nu4tIBf83kIpkE0t7zadteoYte90+U3rj1N1cS14oucedF2vtvXk8foMGMCinBRlUvV2V1DrejHqk53ORA5AiXueHOdRmTBbKOT5qtEWuiTq4nEm+iPXouU44FEtJ06NwojIzKUaTdie6zb9ZV8Ws9Csr/oSgiUdiUu4nc3/b1JBp+Dsk9DcO4hagsY/8DVnDRTTYpklEz4HKsbduuQSKkCZXHF8gbwAinYr/SAGFJNfv6zWrLgyKZb+6nryodNS8wwPCAcWbyrUxVdKQv6RVcQuGlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMNoKZK7MUzEymrHsWn4y4vhdE0DJJUPdR7+IXKWSiE=;
 b=bCXrTasPbKFhQbxAjTdJh+UWmYR6Fj0PUA943RnY8asbpckYhiip7cSXt38r3XwF9RZa0YMazzl8ftAGIJ0AYdvctbtXAg5641VHnrgqUoY6gev+yiKdqZjBSgovFLanxuAPd8/wxBB+gBJBRM+/tWUBE6Jrw7EoVv/pvJYVxP/CGLwMhsVnHdlXpAVXJE82rbpVWsjB5rjVEVbOaaSfEBjodG8S5HLAjoT+2sDBrcLsa0OkqSOIlOogIU8PR8ONjKuZf0IOcZEkFKmUTk9tpXsA9fE3nmATS9Z3oINGXSfYPzS5KBwycXUdp/7niHUY1KzqY8I7gL5tIfJenI+7zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:30:31 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:30:31 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v10 07/12] cxl: Validate HDM ranges before CXL reset
Date: Tue,  4 Aug 2026 19:29:53 +0000
Message-ID: <20260804192958.1823952-8-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804192958.1823952-1-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: e37ea599-0121-4d3e-acfb-08def25ed882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Hork+IoayP7UaBvHmHkX4xz9YtDbKlfXzrhI0q5v/2/Sd51pS0cUWFdETCgZJ0gYYs9u/pC6dR19QpbwFEq7vL0cycIdscHo33GwPZ5lhzELF71cdIJ6c0pRznjF+iFPYNDkKSQOax8T3re1X3Ps0HHjuMc+5ndYnWWnFcu3UjtC9QIeIHJ7tSS7liNWGz9Ccn24EpCqTzyG+I2q5zcMfQhcA48n3Fa1w9K2PCHXmm80VnFfbPDXK+I58xyIRugcngaRYWxbuzTKKBjQvlS3ztxESPFCwZT4dZStl7DQws4lfRZ94+XujEwA5lRt7PFk4HduWG78C9oxW/ZNmPRqqKU6UVEKruDKibMbkc12PD3+IxvVaFl/PhDHEVQ3yS+u/SCwECFjzlc/aZppecdFr6ZyVCklcY0lih/G57YMdE5yAPachRS5GuS3m50A/zT+n2WTKN8DLKJyb6P1fpdICYFTfnBnkzBku6s51xv+GHIDU4DaGNRfSXbtx/Xk3/qGAJFrSuwgUBh2JX8XdQQa0x+gRZXikGYxOjBbwZTGJcncXK9j2GPnIpedfG/mJwMlxhadeJ04iW3Lz7UduNNRP3ff02rJj5nxccokm5Agyy0zDQxLlWqe8PCmnoNGCFxY9hNAHsr3UhGwXhZuqxIgIZyBYBAfsA3vpcUAcKSgIlTyq20PRRCuL9IBnx6uSK0EfLPXf2TbV8ezEFb2I3bRgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xyKldM57q3FTfSuS5gTc2BBrzkBNwU+R6Fl1tq3C0vIYLn9jXBEEJqUNNHUy?=
 =?us-ascii?Q?khxsuSnYIq9q5W2HnrvEhS6sO0BbddPUD8UL4y1vZ9euiC3YGQ4sCIjBp6hj?=
 =?us-ascii?Q?HBHVBrQpb7pWu5LGmI02VNBt/hAWNnOkKK4xRXXOeExReGs3T43595skx/Wv?=
 =?us-ascii?Q?m4ZSSgE8VrDpOEEJFOX16A36bAaWawRoZbfoufyzFEUhUzFRI2CeOW8Lz1Pn?=
 =?us-ascii?Q?AkJs0bsn/w/y+mM1pzvpXONlgBv6Fg47eKW8pexh14WlYywRKZt8OFaBcDUW?=
 =?us-ascii?Q?XEGxN8F1a4vqFMkbnplg1TLo050BtnHZhXp1BHxwQGLeA+z+b5WlSFyuMOTX?=
 =?us-ascii?Q?DLf5tTBTNTz3q71/pOctnqxr4/Bb20pvzrxow8DSgAmp9lQfLKDS1srxBFzQ?=
 =?us-ascii?Q?ZID7grZba990waRWOXAKjioV84U8MdjIfuMCbYU+LZMCX5ANmRvYT2hukjBD?=
 =?us-ascii?Q?BSRPcU1vS0c/a997mXYO+ocVpaaorHQ0vRoln6kHOfVVT8td5ucGExUOwW8e?=
 =?us-ascii?Q?siC7MDBW7sngj9rA6zMMpGQKNfuBjzTIwJQTp90p7q03leb9NXLCJKJE7vNn?=
 =?us-ascii?Q?JpqX4z9VmGcgYdn6cv2mSSq+bJa+CYX+k2KG9Dg4ez+a13m3EzNIU063VJxe?=
 =?us-ascii?Q?5pxi8VJtmAOrPyuZuL8TWXiiY6mzxn3MTDTu7MdG+LCgRLZ4mJVaW7RqCFwM?=
 =?us-ascii?Q?4TV8luTyaiGiJCNUWU62IUdmj0LY6f1goPS9Ac9p0wQUXsAy7aw0dqpXWrvn?=
 =?us-ascii?Q?gHbo/Z8PECIkxWUBB6UPBhJ0g2uYi7LL8dv+BhE8y8gmBX/jy8LWIo6DRU67?=
 =?us-ascii?Q?8lPv0RmJhNTC1hA2Ycy0z95W4GwLsugJDAeEmxcL/rFAbM0KuQHIJK4KOluo?=
 =?us-ascii?Q?NvTHbydOtZBDCkCRYHx+8JbPLWOCXUOgdSbkB3htdFajjrhtc856hKC67s1e?=
 =?us-ascii?Q?xBexGBgmeVwB8kSce2FpA+nUzjPXcA8EllMg/Dbt90naLLOA2q0ODPRn7WzC?=
 =?us-ascii?Q?kO1JPNAw/ZlY9qC1I1+K0F5KG03Czxkel/LbwpKHxQ88eaiGGW2hoRf5PwKe?=
 =?us-ascii?Q?WwvmgaNN182FKVXFQgL2pFPZuq1GVgFTxczVtP/xD2k9ahp3JrxHPZ+yPUR0?=
 =?us-ascii?Q?UpHETjuXXvGF5P+clGlsT5od3ZzrtYy1V1ksWroTu1ypATkj1SRe+G59rQ98?=
 =?us-ascii?Q?rEWQ5I4hR+810BFORbqVvMIe/8VWCyj5iD67Aa8PsRMXnVN11GiEXwLNpj9W?=
 =?us-ascii?Q?J2KIOAFCS+3fRU0cknkSCXRlXkn/W374V4TeUHu1jfEwv/A3yoV0LA7YU+v2?=
 =?us-ascii?Q?vFMYSlntrD730g0WPM8c6yY00ijrM985+AghO5UcUflz9xTL5Jl8wGDbDSp6?=
 =?us-ascii?Q?RcvBa3phJedbp+7LDYXqIWVGQVXebdePNusvG+f82OKzX3PYIs0f2osFgk4J?=
 =?us-ascii?Q?6vdu1swFsfon0/Vm6APip+P5QmQdi0ZokHzNtL10C3A+eZ+5CUKhLwjI3e1K?=
 =?us-ascii?Q?04Yel9ggO/9ubcTl8ZHgzhECHlxOJOdTmeLbogPZbn9BPoEEUJp0WEmF941g?=
 =?us-ascii?Q?0YueyOu3hBxWZzwGWSj700FiEpblnIqHjiv0w6o+ryrSiy29ibgxoi7ICEE8?=
 =?us-ascii?Q?0DlafzC8QyDDwbS1tEQiparlorR83NbDIOAEJHaEW3ZhC+x4Eef4JGhIjc4M?=
 =?us-ascii?Q?z9/M4J8kZywYgXNIo16+RRJmK/lhtsT8CvuSlX2r6aVNXj+2RQqv/m7d7u+e?=
 =?us-ascii?Q?GLWrwIIb/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ea599-0121-4d3e-acfb-08def25ed882
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:30:30.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XoujlgrUALwixHONdbhCsUF7Y+XGssdWmUO1YusoG9NisGCeWGeBYIqSYOx5i3+cpBAZGzjRU0KjgwfR6eGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

Before reset, require cached HDM decoder state, collect enabled decoder
ranges, and reserve them with request_mem_region(). This rejects reset
while affected CXL memory is busy and keeps the validation stable
through reset.

If CPU cache invalidation support is available, invalidate the affected
ranges before reset. If the runtime backend is unavailable, continue
after the range reservation succeeds.

Reject CXL Reset when no cached HDM decoder state is available. The reset
path needs the cached address map to validate affected ranges and perform
CPU cache invalidation. Also reject normalized-addressing decoders for
now because the cached decoder range is not a system physical address.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 250 +++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index c10e84b240a0..6d4528f77c53 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -10,6 +10,8 @@
 #include <linux/iommu.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/memregion.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 
@@ -501,6 +503,224 @@ static const u32 cxl_reset_timeout_ms[] = {
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
+	struct cxl_hdm_info *info;
+	int rc;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
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
+	if (hpa_range->end < hpa_range->start)
+		return -EINVAL;
+
+	if (hpa_range->start > RESOURCE_SIZE_MAX ||
+	    hpa_range->end > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource address size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	*len = range_len(hpa_range);
+	if (!*len || *len > RESOURCE_SIZE_MAX) {
+		pci_err(pdev,
+			"CXL reset range [%#llx-%#llx] exceeds resource size\n",
+			hpa_range->start, hpa_range->end);
+		return -EOVERFLOW;
+	}
+
+	if (*len > SIZE_MAX) {
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
 static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
 {
 	int dvsec, rc;
@@ -534,6 +754,20 @@ static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)
 	return dvsec;
 }
 
+static bool cxl_reset_hdm_available(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	/*
+	 * pdev->hdm is owned by the PCI device and released with pci_dev, so
+	 * reset-method probes and reset requests can test availability without
+	 * a CXL driver bound to the device.
+	 */
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	return info && info->hdm_size;
+}
+
 #define CXL_RESET_CTRL2_CMD_MASK \
 	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
 
@@ -736,7 +970,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
 
 int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
+	struct cxl_hdm_range_context range_ctx;
 	int dvsec;
+	int rc;
 	u16 cap;
 
 	dvsec = cxl_reset_dvsec(pdev, &cap);
@@ -746,5 +982,17 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (probe)
 		return 0;
 
-	return cxl_reset_execute(pdev, dvsec, cap);
+	if (!cxl_reset_hdm_available(pdev))
+		return -ENOTTY;
+
+	cxl_hdm_range_context_init(&range_ctx);
+
+	scoped_guard(rwsem_write, &cxl_rwsem.region) {
+		rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
+		if (!rc)
+			rc = cxl_reset_execute(pdev, dvsec, cap);
+		cxl_hdm_range_context_destroy(&range_ctx);
+	}
+
+	return rc;
 }
-- 
2.43.0

