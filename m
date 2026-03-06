Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4137757C;
	Fri,  6 Mar 2026 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784072; cv=fail; b=dS5aTHtjjPWXGezLoU1A4WggvfseHrbkpRP4orDe7jOBxZ4j5BdKlTlxTkqN3hfdTNGUyLks5wIs+Lrzo2pYLAYbA642oxo37ywJo1iMTVRj7pVPsWPBGPrZUvKjwtY7hx/kK/YmKRlfqS5cpq64NJQHqOQvFrFQ85Wnn9o66Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784072; c=relaxed/simple;
	bh=RgAegdEWk7w9fwJA0zgUXNBDxGokJBWvji2ZVwDxT/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxWvf3dJnc7L7QyzsqIwyCcG0dk29uV4Zi8XFE3P0lI2HTDC0cukcN/lMNvIkuxeWPkFM4f6iMkoId00qXaOZ3kfUBZ32Xwkul8geNifKvD4LyitDW95d4y3qWFBXNTrSrCE0Do9zwalUQQC8mFNVOCywKQ07DS5RGJoo8SutUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDKW9ClX; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDKW9ClX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwCGMxdABcHi7kuWfOP7EIi15EpGX3DHb+qwFt0uaWlTCox9A9735JZC9UpyuGlhJuBcT5Mqf3UK4bodJlWcjYkNTqw6DGFEHPDBJK0d2GRCsHINMXZkpc3k3z2piQyjUBxxTlcUlNiPWqeBaoekoS0hCJN/p7b6gD6KZeRDM3V78ZrgAMdcsum0Qbc52/ty7xibGjNMZEwMW3PAan43luUhxQn/bFtvM9vIkDCXcnrZU3uKPbrv1UaNioMXN/tcPPF9wucBNqwNPQt0Z1UIqsdbUccLG+x75pmwJ4eTn2nRIk5s9KD221OoHx1z53aLuCmIT78Tv+pEvJmgySkiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2NnZlvqRw49E//yVydmnVBI94tPKYj2gKXsqwSE2wM=;
 b=XCCegJvZu6qHhUJvB+fEfZW0IlKQ2uD2Y6OfIYItrI9xcPlnJSZq5M/k4Km+wO2HYkueLinBSQeJK6VR1Mv/oedawTh572Y3Jz/km1hKSbrMbjr2FgIFDbwMaJ5lo/MwV9JxJk8ZZtP77APCuX+dO2XY96C3b+Mp+TjpvKRabSOr2Igru9iS9YU7iGYlMA8O7DLbwF+qyty9zMUK/CxSRDVeHtBv2Zp1g0e1RT7eARAk89VRTYE5OGKAp3g5AljcqU60iYKgRKqpkAhVEBVUKq2rGBtwCjOAhYYxgiZg6K2xhMvMTFA0bZwvuQpjkRU08NTyKNUkjeggcsFwRN341Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2NnZlvqRw49E//yVydmnVBI94tPKYj2gKXsqwSE2wM=;
 b=SDKW9ClXJrz8WuMZAFV+Qvg5S3yTQnmBusiuN5kP5Lnt+qwvjip6BpXLv06UdSAixs/mnQoqiBitPky/1h9cacHvV5gTkmAH9VwjLMQIUHb9PJtIWIl+tjQ5CydGBZgDI9mlW9k1e3oKIuDVdrx3BBIBMQeM7eFACXdynclfp9GgEjahe8xUvKPfOhPui+9JY6Mo2tjWOPFwa6Z3gm21KugmGoTwpdxZjiUdgpgEOBvvAA337X/snPA2F7GnupANzkU12UkW2bOGS6Y4Z64c00ayXwWubwIDvLx5OuN/A1cOrnDc/Rt1jClrJzikQRZvRTvW8uiX1aT9dfVMrSXkYg==
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 08:01:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::1b) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 08:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:01:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 00:00:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 00:00:49 -0800
Received: from build-smadhavan-noble-20260205.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 6 Mar 2026 00:00:48 -0800
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
Subject: [PATCH 3/5] PCI: Add virtual extended cap save buffer for CXL state
Date: Fri, 6 Mar 2026 08:00:17 +0000
Message-ID: <20260306080026.116789-4-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306080026.116789-1-smadhavan@nvidia.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: afc25db9-655d-48d1-033d-08de7b568592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	HNrV41fduHGqEd39g+xNgxiBFTe+1WuAKfea2iMgJmpbbZgD8BkT5uRYoy3RmixXsSP4t3qukZ5ltABNNvM5mlaVQg+xJQlwsg4Vg3w6/794xUThIZtw6y/4xvEPGE7NkqyZhXAeMuz9Kyt1wqcH48BxP3vrs25lnvJ7u/mgw+LO3IxohuU551rTsShyZa3sLiG8QWHMYlarFq607pQ9mQwOKwphSE6GAopp9Zzgud6kvJcJm4EaUN4/mRD1gcCMxAr4/N5gw2bclq9fWIf0IksHzIqqHfa2bYK/KbZjZKtbVAxTj1OLKmjhUGiKtgEqBTUh6aem9/fhygiYUKErRw+92kYH1sNPg+nOZ3plzEkrefafvA1y5BrAPnjFlh0Sjhh1bKHc72ITWj+nkItTaMN5/VVuStyevMTMAp6YpLe466pkmRt5a5ImJjCSEU6bvyy8Fg2dN5ZrRFlomozFWcqCSjx8dJfY3ErHQd/9FbLiGjjRjPD+a+NnhoVWxA0STm6GNnkDemw6r5GJqB9ZyZMe0xDLgUrdWwXaw1ZeEiyqELuL7Bti+oAWFkC5b4K6SkOsukmXwkXLFdwKLLeuZLbYnNidfJ1K7KIWVyPbDxPs0Ea1xKGdjp0/arYqHlnjcWzKLQZAbXLihtXzRsSX8tLKoLcWNtImeeCuUaJJLWF7gwjlWtqagLkqCSImesBU2Yo4N42fsg1oxie/8PI7TzvdAIc4P/HNVmyBkNeZauWIHFAyZUWdfiS4e35y1p5UAnll1pvSG1yWHkVIN0Qtrg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	trNPqUnSnykhuML9BZnN6WGyqVVon3CKw1ry6YB3YWa2VHrErsod3FWtdLY1eROHvIsWd+7IdKq/cWXF7TIbJnEqjOioI0WANTr6ozbZPwS8U2Ch2mLQgA6oJZAn45damr8kvgFpAFXxlTZgTS9UudawYZISXgX+CK8N4zRFNdKx1s5qY2upJTaLLh5UQJawePABYX+EabIB3Pp5qK4TCN7/oonmtw2iwHNK1HUxJIMNwJy0ZreaBh3YGXC5nD0qs1MVexQkiEGokYWPhdadgEq8aLvUpMwLWtqvOnGDB5iuKIn0gIShmSuS1SySve222xGK03iAvjWd8RuJ1M0c1Ym8V+VNqS3Oihqle2OBw7wkp+VRqJjDM3/VHkjFTiofZxhxqHF3ulSmgO1lTUmOqjHemh+WRVhvUCTCesqQlfw+CHsWSSK6SVYArXrUtzPS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:01:06.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc25db9-655d-48d1-033d-08de7b568592
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add pci_add_virtual_ext_cap_save_buffer() to allocate save buffers
using virtual cap IDs (above PCI_EXT_CAP_ID_MAX) that don't require
a real capability in config space.

The existing pci_add_ext_cap_save_buffer() cannot be used for
CXL DVSEC state because it calls pci_find_saved_ext_cap()
which searches for a matching capability in PCI config space.
The CXL state saved here is a synthetic snapshot (DVSEC+HDM)
and should not be tied to a real extended-cap instance. A
virtual extended-cap save buffer API (cap IDs above
PCI_EXT_CAP_ID_MAX) allows PCI to track this state without
a backing config space capability.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c | 20 ++++++++++++++++++++
 drivers/pci/pci.h | 18 ++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..dc8181f13864 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3446,6 +3446,26 @@ int pci_add_ext_cap_save_buffer(struct pci_dev *dev, u16 cap, unsigned int size)
 	return _pci_add_cap_save_buffer(dev, cap, true, size);
 }

+int pci_add_virtual_ext_cap_save_buffer(struct pci_dev *dev, u16 cap,
+					unsigned int size)
+{
+	struct pci_cap_saved_state *save_state;
+
+	if (cap <= PCI_EXT_CAP_ID_MAX)
+		return -EINVAL;
+
+	save_state = kzalloc(sizeof(*save_state) + size, GFP_KERNEL);
+	if (!save_state)
+		return -ENOMEM;
+
+	save_state->cap.cap_nr = cap;
+	save_state->cap.cap_extended = true;
+	save_state->cap.size = size;
+	pci_add_saved_cap(dev, save_state);
+
+	return 0;
+}
+
 /**
  * pci_allocate_cap_save_buffers - allocate buffers for saving capabilities
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..05c57f1e4701 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -245,15 +245,33 @@ struct pci_cap_saved_state {
 	struct pci_cap_saved_data	cap;
 };

+/*
+ * Virtual extended cap ID for CXL DVSEC state in the cap save chain.
+ */
+#define PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL	0xFFFF
+static_assert(PCI_EXT_CAP_ID_MAX < PCI_EXT_CAP_ID_CXL_DVSEC_VIRTUAL);
+
 void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 void pci_free_cap_save_buffers(struct pci_dev *dev);
 int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
 int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
 				u16 cap, unsigned int size);
+int pci_add_virtual_ext_cap_save_buffer(struct pci_dev *dev, u16 cap,
+					unsigned int size);
 struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);

+#ifdef CONFIG_PCI_CXL
+void pci_allocate_cxl_save_buffer(struct pci_dev *dev);
+void pci_save_cxl_state(struct pci_dev *dev);
+void pci_restore_cxl_state(struct pci_dev *dev);
+#else
+static inline void pci_allocate_cxl_save_buffer(struct pci_dev *dev) { }
+static inline void pci_save_cxl_state(struct pci_dev *dev) { }
+static inline void pci_restore_cxl_state(struct pci_dev *dev) { }
+#endif
+
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
--
2.43.0

