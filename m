Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011065.outbound.protection.outlook.com [52.101.57.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F6595754;
	Wed, 16 Sep 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583957; cv=fail; b=DQq1xPh63Izxvp/nq6QzNyu/o3Z79HWzpWtG17Zi91I1mBVjMz0At56N/oQgunkZDbc9cMArQaf2VXvqxQGsl+KAnoExY6gWxmet5ySYjOt/xNpHss6anaH7BSNfsiOVOnsRJ98W++wdmstk38SUqgEA7dGChYlvw0rWsZNsG/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583957; c=relaxed/simple;
	bh=mMIPR2K0gPNzaC2OFoLEuH9FgHS32X7Od7XE873vcAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiPoycfDW5jgF2hPa7M75tO4KQgBUI9T4p99nkk9fqCMku/ONrCqvSeXU8RqZbc9GAuirdUkzthVGthONKAR+kL/wR64OPqh+F03U2AQD4a2jem1xc5/tWQFWo+7omwZygtXhqTXhJQo7qkVm9YF1iz1kghrnLSC3E4SrVW4QzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAafQxim; arc=fail smtp.client-ip=52.101.57.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bAafQxim"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxWfelwnTupJb9drH5U1apulsau+5uquEI/E/MSUaWHGuPmwZeFC1d5ahNevDwmYL7psg99LvmJf4Ppb189QG9LygfN9DtkLcKOTWaZyLy1FcVgkjxVbaQqqSq3KBsgsm4rJknlRcViRpiENzxjP8lJsi73yWf+luXg8Tz3cIHnAeERiro4wWXdlnbd2S37xCOEltFPgGi0trsCQkDC6oPMBIYeT/h79zx6SHmzNqiwBF+Z05Rxntqo9xld1cnL4WUlW2OsjXmTtGa2ltrThC7Aq2/Yb/9B1z99BP7R25lt4kUBKObtX2XKMsirWcjAqhX7VOtAb93qbLepGV4Ojjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYdUfPw7WkvlUAqrjHiTmiE52xpdzadRZZc3VnC+yoM=;
 b=Bm/wDUBKrCe9xj9OgSdUWR+nXbv9OxwKJNwR4mHRTQ05rIPOJyfx2yccZplMw/bQB81vwC3/PifICaUWZwCFAyp+9qPZzc9IDBsIPuzdWzZk9sLytSsizCcscLip521JYUaeDYhCl8w8Ifg/dQ3MdFikzeubHsz/xD2AUKCbBD3qU8rQLXU+XJpV+r78kQ3AGL1/NMpaKdW5aChNwJbFiOU3Jh3CzjGNmxAuqInSwNFh9SUs2knWxTAC3kmmKFwX36EKkcmM3UqKFn/PY9TqW4cpcZmZXaFk6A5W6JGS4wkTqwQwQUXpYLuaZFq1QOsdlX7u4TzQE/re8Q6jRLsANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYdUfPw7WkvlUAqrjHiTmiE52xpdzadRZZc3VnC+yoM=;
 b=bAafQximcF4eLelA9qaloJdLI2lBV2WewQoK6SwGy9Kq2wgYF3KUSOk8esX9iFbhjZbw+56Kje/LuK0XCIdybSYyRMDq5FOtzrc7vEVhy3D/8ZrFEvg/F9Wa/YSvL08HqH3KD8FbxRb8OAkLIYHfPrXvqQ1YelGoaOpaYi7sHGNUlg7mMf7WVbz+ZSrXbi9OA0wFbiowI2O1Jk4LS4xwPpygb17Xc2nVYaUQqVYu9t8Gp8qvYJ//fD++4RhMK4e+snP3YJ1gEWFfYIqtLNye+OaHfZwfXLSiT7YNx25NYFUgKaglA+4zcngkMK38HaEgVZ16+yXC7i77PG/pFSDeLw==
Received: from BN9PR03CA0320.namprd03.prod.outlook.com (2603:10b6:408:112::25)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 18:38:31 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::56) by BN9PR03CA0320.outlook.office365.com
 (2603:10b6:408:112::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:07 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:58 -0700
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
Subject: [PATCH v5 13/27] vfio/pci: Bracket PCI resets with the CXL reset hooks
Date: Thu, 17 Sep 2026 00:05:26 +0530
Message-ID: <20260916183540.3813685-14-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 445c10df-50a1-4929-e78b-08df1421b514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|18002099003|22082099003|56012099006|10067099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	OTd8ldwEKYu1RMY2xlRlaETxsjZkYEne3PMt6111mXdwFKplg/5lQqA3NOESVInmVXEyEGtlgNwjx0Ay6BMJ9Mf4D3tzT2Un2DTjj9DizDo1bD+ShsMBxMy3v4Q080eKOXZM11f6al1yTrqLajz91pAlfiRxhdyLiH1WgQXCPDj0F3dyirLbmLN5kIz227Jd/QqlaHYnkMKzAHQl55cOBbC7Cc3td5Q5w5KUEnNVIhq5n5bj3DOUHmUNqUV3R17UdbUCF1lfE3WlZnMhAyvO69ixbDHx5/cmi7JaxUqVDcmNjofFHQifkSGI1faRIYZFadWh5uErvB9rKl7utky9vnpRVImDEcNZS/7ewRzVzqxyaQXTinu4HqGtP1/lJDs4wwZmtgYaWJvQaHBBZEvTP229/7766KM6sVmsvsnEjKvV4ZwM3kJxdGSWQ6dTt8teay9vyh6QoFv242H7Bk169Zt5ATV8cWtA815TDZ9SzHYteKmHDzKpuWOIbIRRedWuDA+goOH4klT4CR/mX0TYWidf9r1udE7FD9htSj+H5DWnqcgOkc4y6sG9qWOMvCfh2JDvvjHlKzWxjNHUWHMUvV/wbWPk5svTlZpQzpOa/Ei2SrfcJM5nfgpv9hiE9mMFZr4i81apenYgCKS/+zhEf5IXFdFqM96W0IFqo0Pe5rWSSGXU13G6Li2RGvPu2awxrpT5jyp+scbZ6qlmZJCNoI81H7LIFLM4j7dAOqZO+pEB2yrE2ZcYXu/JhXgndj5s
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IvPBJgrmiXugV89yOAHrRqtOvZqJgjSv82RTsV+i1oIbsDECNIIaNwKz7mhUUJPr8dwRY6eFOdLCzw4kTUY4GvTRIvGqxocrnNstbXkqx6UquOcTfnScY1B5wSVU43YM+zPQ9vkCPDZ+DjTSSZgBAUtPGMKiey2ItVxIijnwCAM+AzZxxkRpDMj/RFe6t/h4SvD3/J1hnIsM5hIenu5GkN1upPswXFlBEsHI1xu+Vnwik8ERvIzaJRKVSiOICrpLY6i62dgTmDIJPfc1vtcSa83Td3XVba1+GUL/xbB5YeTLLSVcj4xyMCQW3z+ZigSkp344BTlZ07sB/iyRVFpVV9g7PVzDmXBK+93xYYQZg5jkQbECDpGkyHxmrW/SNZNQGL2b+YeAVbYRKzeXzKckvOEzu9NWeOfX/5IsBy2CeW1MKPn+XOtqnrcq9v+9z9PK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:31.2527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c10df-50a1-4929-e78b-08df1421b514
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device must quiesce its coherent link before any reset and
restore its HDM decoder state afterward, or a reset can leave the device
mastering the bus over decoders that are no longer valid. This has to
happen around every reset the PCI core drives for the device, not only
the ones VFIO issues directly.

Add reset_prepare and reset_done to the CXL ops and register the matching
pci_error_handlers callbacks.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 18 ++++++++++++++++++
 include/linux/vfio_pci_core.h    |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 2f593b2721a1..a91e07181847 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2794,8 +2794,26 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
+static void vfio_pci_core_reset_prepare(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (vdev->cxl_ops)
+		vdev->cxl_ops->reset_prepare(vdev);
+}
+
+static void vfio_pci_core_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (vdev->cxl_ops)
+		vdev->cxl_ops->reset_done(vdev);
+}
+
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_prepare = vfio_pci_core_reset_prepare,
+	.reset_done = vfio_pci_core_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 643f32c2141f..6ebf9a26275e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -72,6 +72,8 @@ struct vfio_cxl_ops {
 	void	(*release)(struct vfio_pci_core_device *vdev);
 	int	(*open_device)(struct vfio_pci_core_device *vdev);
 	void	(*close_device)(struct vfio_pci_core_device *vdev);
+	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
+	void	(*reset_done)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.25.1

