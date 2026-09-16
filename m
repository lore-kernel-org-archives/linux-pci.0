Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F6D49A3B8;
	Wed, 16 Sep 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583994; cv=fail; b=UGNwgR6JOj0+W3g8EXHcBAX55eRsmeEDHDcoAZ5hDgw3nRjJJz/YJUVofqimPNv3tsCxkbK0JRGTh5+hD2apoXZpAZY3l1bapYy6d2XXtF9ftxOdDSeQ+Uk38TW9j0cVSPeAzaEjDL+DoeE1PfSPM6gfTWLZMFOyGPDe1F6wph0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583994; c=relaxed/simple;
	bh=f5i3rA7NUzzHXlApCWrRYCBT3nzbTHtgDO4Icw9ARkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIs1TMJ7HLfTmTzB5XDYmnXXo+1PrA7mh0FjjGuTi45exmXDXKC1h7dcblKmW3jFEG5Ly0Pu0odI3L3dZpWA3t6RUtaGEhET8zD1NY6o7klb24uroPScOAy1bNDFIM2n+By9/4OXznm1LJ+wmK03mDdx014aaUMhSMRa7aJkcdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MTvrE/Ad; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTvrE/Ad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzYMaT8qcPvTHG/toW0T0KM+ji6vekuaRxDGJ/Wo49c69FAVjl72+eGXMQuWLOvzsJ0PjQGj7uw5UdXDBykQrFMmvm4MDF+GBXCPsxVAfiyHduirDyOhAEugvbgXVhRufKJJuB2pFl0u3m80J6w7TnVyeL2dSM22m69tizUsr9JP9L6al01iyxxC4tT9AWfOdneoXOgz99TJ07ilK5GLzszLOHCheM1Gzh+a8F/DpJ695nxSNlZRxkWym089pkLtgM7B7bd/yDb/Mkgh9egTsFRS8jY6ti27IBsI8LRHR0D+RhPqCkU5KHPR6xtAF1+4rGLLhBOQxO6aEjib8NAVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzHyQt3VpKz4x2nLBG1Ze0pYKzj8nPmd6FetmIjClFM=;
 b=xYC/grb7bQ1hq3SF9eZrZPzBPy59MJA2b2QTwY/I6M+9nT8ePHvkk0XqAzsqlSmc5Oprr70g45IJC3Zeq4ClhWlrUsHDIcB2n+r7vxdZxMx+bpiImH0jI29D2hpNZcAXNbEESnJfdQugwctXCMkeFL6KRjWRmtYsSw6z7KL03E3oR9zpZNyCqxEiWWadkvOromobGa+H+P0MuPzZ9W7jtNmB6zEmH6CCFWvRLXGQvpMPgCn6j/j6Mr6EVA8e61yFlPttywbyzZYGvT438ZS6jd5Oi6xrpuqTTPeqRjhE0Ub1FxJ4YKWYRhINRjKGCwxna1fEQnJ6DhelEK3cWIOMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzHyQt3VpKz4x2nLBG1Ze0pYKzj8nPmd6FetmIjClFM=;
 b=MTvrE/AdIkdt6ggZKxqHNz8xXKVZwC8rJTNG/i+ZsIqPYG3WOj3SMRwLziNjlp65Am5VaKjjdgVNvC3BRooe5j1tKI4cfOMW6YDU5e8Xp1tQAQD9iTLKWOhXXLd8q+pnfddtjxqW/OsReg0qawsVDfiMvk2A1uv/0vhFqbGgbUkt5GZpR/ujNnHNOFFU7DHxg4gE90fsqY4qhX/2K5ezCqYgZje1Es5J6pg6QPBXDly8kaCs+8UF+ykEFnaBUIJnSyUrvAiymiis1vqcZOYt4CJvZ3VrtS4cKNgR3syWVaDWBvJJ8Zp/QChsFOn0ZgMFQuAoO4cKElPeCYQHomiMTA==
Received: from SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::8)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 18:38:45 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::7f) by SA1P222CA0098.outlook.office365.com
 (2603:10b6:806:35e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:16 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:07 -0700
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
Subject: [PATCH v5 14/27] vfio/pci: Provide an opt-out for the CXL Type-2 extensions
Date: Thu, 17 Sep 2026 00:05:27 +0530
Message-ID: <20260916183540.3813685-15-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 535d4023-7749-4418-2383-08df1421bd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZzrKh745uuDycZWWn2FeHFvsJzsCDR4m2lzX4kj99nFFSRbfqbk2JcVPZCkt8Bf5nVTjNfBRJ9ntytSyYGfJ4Str/ltp3TKdWmjZax2nN+ed/998FQSuho0Qp5YMLqa96XQr5m50BuXoBgTEtRAopPyLaiSMT8MUtr490efwZdxlukNzZ8Ras0yxrNWFSlR0DZD724H7XL6g0x9V12ZFjfOQ64lVK2WkXfRe6ot95BU/acHF0r6eCW0vcYLpxwyChYhsW6h0eeIexV7+F/tDmDkHnf26ZQdRZw+PYodQt7rUfVzYsLQ+8fgNZUAa+OWNN6aLCGyTr7aKvQcrcCAgfySgThc/n3F2M6qCE6RG/qokOkTrxJytVOMK0uTm/0ggstkXjvNRVmf/vECTj3DyvOLQZIpTWtH6hnw7BnYTkUs18KlhFDyJ04U5NIYelBGPBQbS+I7uZpNPk4weu3VOpq50HZS9mSDK3ujqskBgANem0vU18BdpejZc6y0CqxdfU/L9AmutKZ+MjCkR+bqpDfruglmOWaNkuKeiD+y8o60UgkgtyPBt/Gv5oRRSFUHjK2pBR+GNNtt44OPsTOHeru8TY5mUfMg6uKXHg5AKsJXbIDdG99MUjPvC9x5znQ4Rh5rdb7hqFyCagIjGPswqPURsxgZoAOgJnKmKa+kJoazyxvEFO12/i5hpwLaK+pYMwiW+KgeIEGu4WhidjcTfu8DNlWpuRsvYqGKFTgeYWM0cWYBw95Oog7RliKUqUcs9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bHpZdTN8PSeRqND/2KMtRDl8M6cn3P/dKhPpLwtf4yiCEZk+rkDPphdlnRTV/2NgvqeASKwJg0pqcb9zHPZwxkd56uYWWu64/grFprkRF2E0P6zstfLygQJUtxtMuoQMDt3JcsJ9YqSVfKEZ81bLUoSnY7yozFNYq6VCsDNAHG/lqDWsaMSaSQqbvTbmGmfuq4xCPPd5mh7dFtYDxMtyeSv6iaPLqy60suCy+3jcbkrz49DVQ7r6aC7WHYPdhXMl5pjSo89ZucFP/dyHOolVvljniMrCjJrCEFy/fY6eC4Or7O6NcYe5+A1uYzca5sbdIZALgO8aQY9pmEAOq8xqW83DblugGHOM0f47Gmw2FXisB1J8yCrg7BIENXWv+BvrtmLNddE4XM4SXbOIgDFGQEiOSw9djHX8QyDWLxWVv5vLVeSaNZ0dNV0rp0gUeUvh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:44.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d4023-7749-4418-2383-08df1421bd3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6

From: Manish Honap <mhonap@nvidia.com>

Let an admin or a variant driver keep the CXL Type-2 extensions out of
the path and drive the device as plain vfio-pci. Add a
vfio_pci.disable_cxl module parameter, and let a variant driver set
vdev->disable_cxl in its own init callback for per-device control. The
parameter is built only when the CXL provider is configured.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c   | 13 +++++++++++++
 include/linux/vfio_pci_core.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..66f2e318d8e5 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,16 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+/*
+ * A variant driver may instead set vdev->disable_cxl in its own init callback
+ * for per-device control without this module-wide parameter.
+ */
+static bool disable_cxl;
+module_param(disable_cxl, bool, 0644);
+MODULE_PARM_DESC(disable_cxl, "Disable CXL Type-2 extensions for all devices bound to vfio-pci.");
+#endif
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -142,6 +152,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
+#if IS_ENABLED(CONFIG_VFIO_CXL)
+	vdev->disable_cxl = disable_cxl;
+#endif
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 6ebf9a26275e..475a0ecf9e4f 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,6 +149,7 @@ struct vfio_pci_core_device {
 	bool			disable_idle_d3:1;
 	bool			nointxmask:1;
 	bool			disable_vga:1;
+	bool			disable_cxl:1;
 	/* Flags modified at runtime - dedicated storage unit */
 	bool			needs_reset;
 	bool			pm_intx_masked;
-- 
2.25.1

