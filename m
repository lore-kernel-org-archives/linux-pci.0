Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA912FD69A;
	Sun, 11 Oct 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684918; cv=fail; b=S9PdHYLiSqaWnsDnvsSPlbKedvGoTyWlHq7BZrCQmnRVm1vxLmQIHCTlNLhbMqlleadkmOSABvIH0O8mC8jCWY4lypza6ztqBIZ2n47KQwBdUAUbp8Z7aHD+lp8Qq8r6AY4rm2J1e1ZmCCuHv8pw0vqO1TmTmmDgCDZw8BRmDvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684918; c=relaxed/simple;
	bh=qMhFx92obKdsnkKwXZV5Q0KruoPzkx2fZkmvjUpDXjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xs6tRjX1queZwou43biFiwTbRuE5qEgzZREmTi8Dxn+42Am4Pbt5Y8jbEyHEj/QxwXQXXqxRosBX6cN3b8eHHvGdpZD0eqWTZTAvW4r0ZliZ/p8QJsF7NYPyJq4GR4W/dJg+yiHTaAhrPOZWinoxWFvKRWKfQTWXLsgzL9COdxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AJTbhyJG; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AJTbhyJG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgfz2M/VJjiRgF/T48OLv7uk6Ig+QGfEvHYrfPdZbw9f1SROIV/xcmmtwrOi2j+wfprmOl/0dr/pWsdlGt8eWCFivtVxzBe+zhstMVHbVqOOo58pajYrk9rNgeEsHaYnAQIy6YEeoPejc4PwVOHdE6V9M0SFd9p0xNH5op8oolHSjpaRbOGDgoYmVjVHDKy9lNrDL+zHIK7xhq5ugDjMkZQavIqpR4CXiFmRknZ4ttET1r22GKURgkuc7GWVsoE6Tjsy/mK2UVRP6Xb7efSRcWX4P6Anz4Sz5VIQ4NLIgCKKZmckXbTMn+bXdzpvOdGGC/wstc0GWRdW2PlJtpEgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwNLTjkSxkiYXETXAXpSDEl2Mr56AYbozu+YTT2mhKA=;
 b=hWVSPmxnOvcNHjVy3uLoVip6tMQK17GyrvUeHtMehrv5TZSx3CQSYcbn3qdZoPxSspHzJcRSXVxD/LXQBQ1UVju/xnEcGlkpQ0H9b7HSpmLDsSZzvqWmGjPDqbCCEJHbbObaYsEhUketX5PAt2FPXJIPpDbhpPa71fJK8ek6Wj+CtATaANXlYIZDDplm1ZLN/v2t+m+tYMHZau0PImbOm6rNwiJfdmTVwHBtJNSyfi6veUNehrat/UmmOBmjDxzq6/jm/5ZosB/XXBwhvSCERjjMA8Vg6Keagcti+GFuug4KtN6b8R/7ZXUrVRxV9qF8ayrzdvNbKNRiw6xPe96eJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwNLTjkSxkiYXETXAXpSDEl2Mr56AYbozu+YTT2mhKA=;
 b=AJTbhyJGa300ucy6VkPrEyqUSeshnsiHnvnF+grpMyG9QeNIkAitQF80Kz1QhOKmEj9IaLEFOhEFxuN0ZiynWoXaG7WhZxCkv8S3WnOOfrcFJkeqIBbE9DeiNd4qxhIfFcu9FWcRMyw7H4clLcbXk1TFpfS1ztOSLjzZAmOboBgk5B/VTSChsJI4AUh40a7u9NbEOqogQSycCs8sQeQ7eQLTps3RjWJ6Zf+U4E6qQtCHQueZONxlAlyqMsFptK68cMGy0Fx6Sk//Scp9SRZbURAZvgEfI265yX1VmfUaoi9qWmEKnOihFr2cWT+YvldnhXQIe7jG0aV3w36eHHf3sQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:15:07 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:15:07 +0000
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
Subject: [PATCH v15 15/16] PCI/CXL: Restore CXL state after CXL bus reset
Date: Sun, 11 Oct 2026 02:14:21 +0000
Message-ID: <20261011021422.3428136-16-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::13) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 7660b4fb-e475-4083-7cac-08df273d784a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Xejxp2nmXiibbK+EeD11J+Y2R2vhgltdo+BlqxB37n5rGjb+m8qGPfTrBeRroOF6wF5Fko++s5BAOpN5Rb7xTCz8I3TBRVgDDMZciSn69hK5TJb/hoRtk/MpQfFFK3pmhNyoogupfIasay/a8MPkKj5CdismotxqNtKAVjNXDXq2J7cKPk0hG0pMrxO78gUbUMgLzMMQlA7ap1cl18tFwCH1pmRj5V4LyWK74JP82USCfFSS5JsfMAdWkTzWoZUle7sfwVa/Yj9F6hKs/TWlNF4skQs6wSNDGi/AgdUUwaeEPHkJ41NzWuZsgrY+/cwiEMHEswhbIueYZgA6xn4Bvb2bPdIjgKJmJvMxNkpgpKJ99LKtqo/u5pxy3o2hpvHW8/mPEBXz8QdsmXJFoLR5pXBURnDB0M1czII20eQuhI493pgBWJzqw5C2UEtHx2AVFO7/wtD4AyPkhw3we8WKOxlZl5D3y8Ubfcqisw12YxK3wXQ4mR2D37icE0+sxzis7pIFZOynYvNNmLpg3hegqZPmuDZ6mgenYSoWKgn20HY1nmzY46QEGtSXeYF6f160j20lrULgW6TWlfFsPqN3BG6FQ9/fvPP+LSpmMiSRtXurubNWQIlT5Dso6xoBA2XC/JsWAtb5iolXXTJgulqQ9/CI4FNyJ2FkGZZX41TaS3U4Xp+1VBpAQ/X5ZcdR9/yxy2sfdulwNvMLHA3R63Yhtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/si7oYdaS4VmzjkjqzZ5rJO7gahZe9qN0jxoWbbqTWmSLfoGk59X3A/YoFT?=
 =?us-ascii?Q?8DuHT8d/ke2fs5tgVfR/fn2TKF8KdShNV0CcSUkPcPYZOe4ffdatgKey0rhw?=
 =?us-ascii?Q?3qScsMLX1UjEW3An4EiQVwOixXD0gnMZGWjuored/F7koeP4jknGtjrravPo?=
 =?us-ascii?Q?LvE2CEim99ViJVVnGevMb0WJhiBgp9CXcwJxmM1nXCiyIjs2Zy9G7kpc3uxN?=
 =?us-ascii?Q?ueCS9wJQtcOFkimmES85lqTVEvdLNREJxeJK9S3SLhJl9P5ybtzHmU9l9XXw?=
 =?us-ascii?Q?DtKgqNHCQUuhDQFjjBGHx5kHnW0/aeItuYk3rAJoTVyzc843cprr2v3rVgDm?=
 =?us-ascii?Q?s6IvGDwHinDpagiFGgJ9qYA8fYelmLbhHa5YZOXVLe9+70OIA1CTuL+v2WeY?=
 =?us-ascii?Q?rPlYqQDTqVS6xJHMJcOUsLDL7vIVIKJGoyPfX9LhrYnF8gy+ByWNh304FnaJ?=
 =?us-ascii?Q?YTFOy6wZcaLn6WoUGVq1+f5upXF854A5609ccPyHuhAEKeCtzBk46XvZ0dar?=
 =?us-ascii?Q?Q1ZOoN7E7ON4dOOgUnZoaZ5n1UdTiZ/ErabRN91ZihO/5TsL+Izw+gdTnUTp?=
 =?us-ascii?Q?lpmRMQyTXXdRqS/SCkBaW3y+wbGc+bABIHCxwx1/SYR400XmljfPOnTw7BBE?=
 =?us-ascii?Q?V3INwey2cYjVZgvPogf0932hKLEClghWfDHCrPcTiELvTpykpYFNKKIdR58l?=
 =?us-ascii?Q?juMP0bN5Pxji8Nnexb5Hl9w4X6RLV5iV89J8EMiT8Xudc5yKiPp0/w9S7b48?=
 =?us-ascii?Q?NdOlTtcQ+UqhT7Lr1h7GGIkmhAy150BGgvwijDFzIlFIOyyeK++grAGkGw4z?=
 =?us-ascii?Q?9CPGiqrByEDQv6V/sMUs1VwVvh7mlk0haKz5HbdT9z2S3J3tPSHz6nrGBRI0?=
 =?us-ascii?Q?Baqq/QvtQdzRddzR7XkbGvy9GoJaPvkrtsdjKVZbAxjBs3uFhTWfaKc7jYWH?=
 =?us-ascii?Q?kGbjCQYlJviX/Q/01QOxlbOnWWD5PJGLf4/IGxR1lWQJZq10lmGH/g6Ef+OD?=
 =?us-ascii?Q?SVSVujwULOsHJmwKAxMe28JYctYEjwEiWekpZ9OtlQWhJJBvrhSoqb+iilof?=
 =?us-ascii?Q?PM6A0ErThYCI2wvcOg+MfohYrkN+1g5bCNaZ3ml1flNEVmfLyVfY1zVLnSGJ?=
 =?us-ascii?Q?RwWiL2N5Nic4uObjszv9lxNVbu97r71o8Y9Ktl3ZUJ7/b+6dx9MjlB+Mwhiy?=
 =?us-ascii?Q?QmYEDJZMjxy2uZYsus2+5pqo8aDzA4QolRUwU8NI7CkSOhfP0vhS87SJRUnB?=
 =?us-ascii?Q?IyxkMfDyLmKvYWe3QYnwfozgP9zZ9kT6UUqyepinpAynkTObswINui3SnxCD?=
 =?us-ascii?Q?zYxPvq4RstTjVcTwgm7Cs37e5MoWpmHvUUGP2MkGMH9a5/gQ5wEdcOTjun6K?=
 =?us-ascii?Q?NXFgNP3jWzJz/Zr/KSsTwxnxRg6ym+YpBM8+H/LFnms/H7PVyc+CkAfDh6bu?=
 =?us-ascii?Q?m2nXEReE4zfyNU7hZuokDj7k9QQnHeJaVdIxF5oqYynr6fjMd6ArD5meWudN?=
 =?us-ascii?Q?okYoQ17cQkxa2nFiPCfdX6/W6estbdCkPvzM0MqviJtbaV/YLT9ZsqYR8wWk?=
 =?us-ascii?Q?jKb4TJsDrZ/PjT9xfX8Ki8Dd25zP9RRS2BrKldEmnnFn/fbLtrkGnC/uKGqp?=
 =?us-ascii?Q?C/ngLL0VKufyvnBmoBGX7vCiH68vRaGeqSGQCIJ7IGxXfANsBrw8MVP2IC0I?=
 =?us-ascii?Q?QwEdbxGWq1fPN0DBxYbuiWcBctmkaC5hGH37jDYj4B2+px97WmOLw4who9en?=
 =?us-ascii?Q?iZZsZY3uPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7660b4fb-e475-4083-7cac-08df273d784a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:15:07.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK4WYLAGXPQ+foEfZCKSJoV5v88MM+oibOGj+oKtK23dIpsbrx1xwgT7bQv5jms5bfkVdImbzPXvCyDUHG2FAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
control state. Restore the cached state after a successful cxl_bus reset
while IOMMU exclusion remains active.

Restore PCI configuration first so HDM MMIO is accessible, and preserve a
disabled state if restoration fails.

Copy the cached state before the reset, then refresh its decoder settings
from the cache under the CXL region quiesce once the reset completes. A
region decommit during the reset updates the cache, and restoring the
earlier decoders would leave the endpoint decoding an HPA range that the
CXL core considers free. Keep global and DVSEC control from before the
reset, since a refresh during the reset can read them as all-ones.

The prepare/restore interface and decoder-refresh structure follow Dave
Jiang's cxl-type2-reset reference branch.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b93f0c8e67b198a63786fd3721b7177ab9df60be
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci/pci.c
---
 drivers/cxl/core/hdm_state.c | 31 ++++++++++++++++++
 drivers/pci/cxl.c            | 62 ++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c            | 14 ++++++++
 drivers/pci/pci.h            | 16 ++++++++++
 include/cxl/hdm.h            |  2 ++
 5 files changed, 125 insertions(+)

diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
index cef604013350..95daeda0ef80 100644
--- a/drivers/cxl/core/hdm_state.c
+++ b/drivers/cxl/core/hdm_state.c
@@ -120,6 +120,37 @@ struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot)
 	return copy;
 }
 
+/**
+ * cxl_hdm_cache_copy_decoders() - refresh the decoders of a snapshot
+ * @slot: cache pointer owned by the device
+ * @dst: snapshot of the same device from cxl_hdm_cache_snapshot()
+ *
+ * Copy only the per-decoder settings, which region commit and teardown keep
+ * current. Leave the rest of @dst, including global and DVSEC control, as
+ * captured: a refresh during a reset may have read those registers from a
+ * device that returned all-ones.
+ *
+ * Return: 0 on success, -ENXIO when nothing is published, or -EINVAL when
+ * @dst holds a different number of decoders.
+ */
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst)
+{
+	struct cxl_hdm_info *info;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	info = *slot;
+	if (!info)
+		return -ENXIO;
+	if (info->decoder_count != dst->decoder_count)
+		return -EINVAL;
+
+	memcpy(dst->settings, info->settings,
+	       flex_array_size(info, settings, info->decoder_count));
+	return 0;
+}
+
 void cxl_region_quiesce_lock(void)
 	__acquires(cxl_region_quiesce)
 	__context_unsafe(token maps to cxl_rwsem.region)
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index 7a225e215ca5..ed0b6f619c70 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -372,6 +372,68 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
 	return rc;
 }
 
+/**
+ * pci_cxl_reset_prepare() - allocate HDM state storage ahead of a bus reset
+ * @pdev: device about to be reset
+ *
+ * Copy the cached HDM state before the reset, so that restoring cannot fail
+ * for lack of memory. The decoder settings are refreshed when the state is
+ * restored.
+ *
+ * Return: storage for cxl_restore_state_after_pci_reset(), to be freed with
+ * kfree(); NULL when @pdev has no cached HDM state; or an ERR_PTR() on
+ * failure.
+ */
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *snapshot;
+
+	device_lock_assert(&pdev->dev);
+	snapshot = cxl_hdm_cache_snapshot(&pdev->hdm);
+	if (IS_ERR(snapshot) && PTR_ERR(snapshot) == -ENXIO)
+		return NULL;
+
+	return snapshot;
+}
+
+/**
+ * cxl_restore_state_after_pci_reset() - restore CXL state after a bus reset
+ * @pdev: device that was reset
+ * @snapshot: storage from pci_cxl_reset_prepare()
+ *
+ * Under the region quiesce, refresh the decoder settings in @snapshot from the
+ * cache and restore: first the PCI configuration needed to reach HDM MMIO,
+ * then the HDM decoder and CXL Device DVSEC state. Leave @pdev disabled on
+ * failure.
+ *
+ * Refresh the decoders now rather than rely on the copy taken before the
+ * reset: a region commit or teardown during the reset has updated the cache,
+ * and restoring older decoders would leave the device decoding ranges the
+ * CXL core considers free.
+ */
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot)
+{
+	u16 command;
+	int rc;
+
+	device_lock_assert(&pdev->dev);
+	cxl_region_quiesce_lock();
+
+	rc = cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);
+	if (!rc) {
+		cxl_restore_pci_state_for_hdm_restore(pdev, &command);
+		rc = cxl_restore_state(pdev, snapshot);
+	}
+	if (rc)
+		cxl_reset_save_disabled_state(pdev);
+	else
+		rc = cxl_reset_save_restored_state(pdev, command);
+
+	cxl_region_quiesce_unlock();
+	return rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b58a6a613311..cecf8e681e69 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5014,6 +5014,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
+	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
 	struct pci_dev *bridge;
 	u16 dvsec, reg, val;
 	int rc;
@@ -5036,6 +5037,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	if (rc)
 		return -ENOTTY;
 
+	snapshot = pci_cxl_reset_prepare(dev);
+	if (IS_ERR(snapshot))
+		return PTR_ERR(snapshot);
+
+	/* Raw reset callers may not have saved the PCI state needed for restore. */
+	if (snapshot && !dev->state_saved) {
+		pci_err(dev, "CXL bus reset requires saved PCI state\n");
+		return -EINVAL;
+	}
+
 	rc = pci_dev_reset_iommu_prepare(dev);
 	if (rc) {
 		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
@@ -5056,6 +5067,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
 				      reg);
 
+	if (!rc && snapshot)
+		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
+
 	pci_dev_reset_iommu_done(dev);
 	return rc;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 743e65abd758..476e8eefafb2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,10 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+struct cxl_hdm_info;
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
 int cxl_reset_function(struct pci_dev *pdev, bool probe);
+struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev);
+int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				      struct cxl_hdm_info *snapshot);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
@@ -741,6 +745,18 @@ static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
 {
 	return -ENOTTY;
 }
+
+static inline struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev)
+{
+	return NULL;
+}
+
+static inline int
+cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
+				  struct cxl_hdm_info *snapshot)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index 445093cf0452..02cad2d74329 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -60,6 +60,8 @@ void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
 void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 bool cxl_hdm_cache_dvsec_decode(struct cxl_hdm_info *const *slot);
 struct cxl_hdm_info *cxl_hdm_cache_snapshot(struct cxl_hdm_info *const *slot);
+int cxl_hdm_cache_copy_decoders(struct cxl_hdm_info *const *slot,
+				struct cxl_hdm_info *dst);
 
 /*
  * Region quiesce blocks CXL region commit and teardown, and with them decoder
-- 
2.43.0

