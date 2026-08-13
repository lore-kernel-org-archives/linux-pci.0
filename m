Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86D44E648;
	Thu, 13 Aug 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614007; cv=fail; b=ZLUUnuRaB4HiGqpE4FCLsLgNILn4a7saUfEATv/i4CcNWWRF/ljrxqQmrhiD8f8u89WtfeixBuhA5acQKhhbdXGT5+v7gN35NMuNRLjhTb8ViMk9kS6Tujhnb1yKNvaIJPvCQpRA4xPtYL1gT8IuyRV5wOM+7hQDoM+6KxpswsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614007; c=relaxed/simple;
	bh=msjnhpHL2tS9jCPZb/aG0NsdYR36kC4N9AaZB9wnzvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEqc0wOlmciLo6nQkQ8UYzi37MTCjfbCtfZdZcFVoAHn0q0cXd4QgNP0Wkw44fxDQhRrZnHrzVlg0IT1GXorvc5STNIOpEjlrac266rDDv9HeRHanvgX2meUANoSnHfD+O06rkboatWqqW8fneQbHfRcvU8B2CBK03DYFimp7f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tff/x51I; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tff/x51I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/oic3rWHHQ9iuMMIs9bdQQI1+C6E4iO4g67j9VrdYHurm1Hz9dxsgavtXv+CB89UBGEKPp3I6CxnHqGthMi+xtnd537uX2xKS8nLR+zc+240cOHpUoEmvPV+W14F+5A/Gop3yv/IQkvKeb3YewBqpL1s1LvQVw7kc0Km/rgAaKFU7GxiqgpG1u/fMPWRJstUhGkJSyJP0l4uD7oVfejv6xDLjlsfwkl3JSp0J5MNx/PkG79+WltT/R+pu59W1jXU0pk9xb8/ICr5SYh0sxBT6Rw9P0bOo+RsnenbAHjs8nX/CgTo/jpb/JFqOFS+qD591a32ywB70aaqWZPJ5TOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptnNQ/YrYyUTP/h63Mmqtu2lFyL1zrZabGScfLqAP6U=;
 b=u7a3FSQxcSh7f+EhTsmE7/uAI0IOt/aT2q+YtQQfUn9lTuyRzCsaTJ2hM7lQiCNrHNg3XRudcGnk1p+B+Si0OWNlYGUmX/QlbTjkFqBsYQu6GUMY8iiTho0NSqymDd1d9qabX4SfCXqei5vTNfvcLbfJW0EwT/sXvzCSK75AT0bSZzUctksu7HgEwRt7TDnzPr7W4rkn7SzUcGM+VcrmadUQRhjJDacIYY0njGxQUbza3UYSD5yUNZN4jo9BR+ks5pa7jMAKOO3/v7os51dyBK9yrVBBxUdaFdvAgaRvPzGkRa4zu8trx7wAwbgY0rI+DUYWGp2XQaksROAKP71AIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptnNQ/YrYyUTP/h63Mmqtu2lFyL1zrZabGScfLqAP6U=;
 b=tff/x51ICjg35cALG4Sg6RavqLQ5ItnP4U0hC7CC8W/1H5tXY4s/GwudnIxkdFLjqXf/HZVeeZAqMAtq43b65ovPrlz3k+hxJuBd+1ZuRvKmK57ZZ2eapVf5r5IhO4weAJscKrKLBzdXIHmwdmZWjofoECfDr/5UMaRjcwP1f0GLRFg3n1Gd0CqwEADn4NEVe6EMMU2qUmxG0asP27RFKPfOHFY2EDZt11w8SxF9HfD53MjqiT1o2zi4b3CSQY0zSKDa/x+nwqMtxWmuRkUSNieExnjbVjWwQMhHoursVwSrdm4eN8yDPVaxqidvJyvAKCzmXQdiE/Q3i0NIOfksmw==
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by SAWPR12MB999318.namprd12.prod.outlook.com (2603:10b6:806:55a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:40:03 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::2f) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 09:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:39:43 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:39:34 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v4 16/27] vfio/cxl: Shadow the CXL DVSEC body at open
Date: Thu, 13 Aug 2026 15:06:20 +0530
Message-ID: <20260813093631.2288172-17-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SAWPR12MB999318:EE_
X-MS-Office365-Filtering-Correlation-Id: 43193970-a912-4d65-ba06-08def91ed97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8/bDwGvcysBZWvTb3ht8aXZIsf5Lfsghm0kae5pZ5JXu/+lIsHmfOa3qA3wUeQlk5HKwffpyYkm5nGX+33BaDnPmGvr13nEMVzRegzuMX8F/eVZRu0eKDCvVIlM/t0tOZgClBGV35foVIJqqhixKI9Dch7Ex2ef8ggn49SJ3iSbsIlF5VlBQ8D4YSvp8B3c2TJo7aQhiTQzAglj2saOHwYbUvRRngIb/NEYyUw3mMVdeLOPES7zuRD21xlM4t8lTfLY1+9NPzDqZUnBNDQlJtZkdfNzcfPlRwLCJRbM86PYQj44P1QOgAcrNh0XVkGCtSugcV4f0ZlBHZq0VZ4H66yolFlXpHCfJ/pFPX6/6u2wM3oyysfZ7CWR68Fk5MsAxFs7wK1EROKNQT8xLIlDE3vnBAjnqqpabr3kLUo0uYAnbi+LxEPeJUZN1BzCxUN+jKkFgo69bOpmWQOm8NOqWdwI0aXL/yE31H/NUzA3z30LjvyZ63PI0S7LPYmtM7tPP82BlqmNl+Dq4zSqgRjHUJW/yphNKBPItrP9BkKD+rnkBUtOu2tTzmRXmZOo1/1BCii3nZb342cufmYQ0SLOzR0QVJNMG5Nn6TvVDLhirlFJtRP6ipzbtLTA+q/x0wNcgG0sVTDC9ET1VGhby0iaMQNfYfneEPgqpQBPcJCaYfItMXkB73Np4t42v2UQ3aRdSpEQ4BmpPtPeEnDrKn6UNk5wj374iZNXeq3ggs6CgdwSmrR8vSs1chqdnPOt0V0W6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MsjuFj2QFp7NQdN0tm57v8dKxco/dLjVW4ZkH5qJu5nJyxH4u8Re9TdsprpiWe+1BugyfANhYGtru0ueQO1KrSOERcqO4EYeP0zLQTv2K7Y1s1Kj2m9tKfDKWzXONOoOm5qEUKmsjBUz2nQairo1TWROnLVkMYy17HVKRAooSyykOS54w1MkjR6ktZpl8y6TgYZN2Je7dFQiBgzbsyyTdegqUBMVed96k4Z3UExc5tn68IIdSDPmiTCKQom6H56Fe5yZLo/1crnoYn0dW3a9q5ofVK7HriT75vglLFnhMHRvj3tI1vC2nox5rDSN05tyzB9O94IxDWWnrvoToWCRa4Oar4p4CnRnmVPQT+pRRbGdGxpe4cxDqNnvDAdl2YBCuO01882GpxN0MNXywwmRCtxzW/iIYoGQjCr/oHZ3E58q5GL1q1BnP1B9ozIaQRuA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:02.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43193970-a912-4d65-ba06-08def91ed97a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999318

From: Manish Honap <mhonap@nvidia.com>

Sample the CXL DVSEC body into a per-open shadow when the guest opens the
device, and free it at close. Reading it here rather than at bind picks
up any change from a low-power transition, and gives the DVSEC access
handler added next a per-tenant copy to serve from.

Annotate the shadow with __counted_by_ptr(dvsec_dwords) so its accesses
are bounds-checked against the recorded dword count.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 39 ++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index d19fd638f538..2e516a0929c6 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
+#include <linux/slab.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
 #include <cxl/pci.h>
@@ -17,11 +18,19 @@
  * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
+ * @dvsec: CXL device DVSEC config-space offset
+ * @dvsec_len: length of the DVSEC body
+ * @dvsec_dwords: dword count of @dvsec_shadow
+ * @dvsec_shadow: guest view of the CXL DVSEC body, sampled at open
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
+	u16 dvsec;
+	u32 dvsec_len;
+	u32 dvsec_dwords;
+	u32 *dvsec_shadow __counted_by_ptr(dvsec_dwords);
 };
 
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
@@ -71,6 +80,8 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (!cxl)
 		return -ENOMEM;
 
+	cxl->dvsec = dvsec;
+
 	/*
 	 * vfio-pci requests the whole component BAR when the guest opens the
 	 * device. Declare the BAR owned so the CXL core maps the HDM/RAS
@@ -102,11 +113,39 @@ static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	struct pci_dev *pdev = vdev->pdev;
+	u32 hdr, *shadow;
+	int i, dwords;
+
+	/*
+	 * Sample the DVSEC body now rather than at bind: a low-power
+	 * transition could have changed it since the device was bound.
+	 */
+	pci_read_config_dword(pdev, cxl->dvsec + PCI_DVSEC_HEADER1, &hdr);
+	cxl->dvsec_len = PCI_DVSEC_HEADER1_LEN(hdr);
+	dwords = cxl->dvsec_len / sizeof(u32);
+
+	shadow = kcalloc(dwords, sizeof(u32), GFP_KERNEL);
+	if (!shadow)
+		return -ENOMEM;
+
+	for (i = 0; i < dwords; i++)
+		pci_read_config_dword(pdev, cxl->dvsec + i * sizeof(u32),
+				      &shadow[i]);
+
+	cxl->dvsec_dwords = dwords;
+	cxl->dvsec_shadow = shadow;
+
 	return 0;
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	kfree(cxl->dvsec_shadow);
+	cxl->dvsec_shadow = NULL;
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
-- 
2.25.1

