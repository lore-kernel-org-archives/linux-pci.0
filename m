Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09710466B62;
	Tue, 20 Jan 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948035; cv=fail; b=KloMOOrg1xMe6YrkkAXsHdX/rRJQqvu++j24UlsYmgyxpzekoAoTJc6OFanLHqqa3oKq1oUpBHZkt3uxFrOzcl8N1ffKFU8Nj8/B0A23tKJgpyj9citFfwA0cTBAAHZDTzj/0sta4FI+Mr7bdMwH0vGjXQT9lcG5sbx8sbu1gi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948035; c=relaxed/simple;
	bh=BrhIJQH8bCmXFnT93m53OlLfYHSPWBDg8PgkAN4BN+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnTvq2aSnbIAF69fFRXoS2zpFcy9cd6MQSWD6ia1WGgh0P+Z2OcOkCMISIzpo1OdnOVKkIERC3NrJbJ2wcSA/Hos3KvwglhlfzJuA2jwozqqNI0RZ4Wx1GiRMLke1sNlhmE83bpje2Z9AvBbtfxAWF+oVWzUZuMWKd4oua3Vxbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pa3D6/PG; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pa3D6/PG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvlycdqo+da7DyLDTw9JPX314ou7Nn4BDYSP7edX8RJRcOJmKW7KecoQs2Cd8+F9d+a3SBWSKzIJ1oCj0uv6/IclxA/kuP9j0c+HiYAzs0MPNNWnReFGpF5PG5duqrb4WCfNDkaNWZIhlgTYSQ5we++MByOO+o3HB0pSx7IOYxyJG+M/2Y+BdZr7lnhpd+NHvDJ/r6QU52E1/nQlz4mVGXnxk5azvSMIzIzQUi06NQJ4e8XIsQIvOMKB2OZ2NVdds8C4+A1NCv3fE+NdpUYP8H2ik5H6ecOgD4COLNvUxDRSyyEEXanmFLRNOU866IQiYeoBWjPRuQ0D8Q8cPN9RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+60PMf/OcjZvzcTHf9dryEXieYGKDLVkytXfEmh9Wd0=;
 b=WcQcX1xrlmr8GvfFHASppfohjtIIuK5SXqr+SeBVuLTWhNmmZkrPbhVMdidAZV89lPtsNuNKwW3DnK8dJ7LyrlEY7TjVsMCZLh+vvw4hbcdXYkVRwPBs8kUFkzQ6bOQFwNFvkBi0cXFNza3Dqa1wnlXzzvq3EHt+JlwgBtd/0cdsyyi1IQE1uhdRUJ88kV4rO0prrbDZvCPfI81DuYu/XpKsMUvU6Kh4rw/5Pw0FjHHzbrWte5JPaZJb03Y+mC+w7fHYUNqT6h1bc7lTLbLvJUVhqYGumUTm8oTlhXiZgTMQUq446nyz5/iZ0eGqPECupRZWqmSkF1C4ST//V1di+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+60PMf/OcjZvzcTHf9dryEXieYGKDLVkytXfEmh9Wd0=;
 b=Pa3D6/PGVpRppDrKeMCWhIf9Wn+VhKgUlq0ATockMrz6FsBPP+wMFsihDwMEkQtHzUtv3sco1IOljPm2kOuRj48+EshlqrtgzXR2nrtUq8j09h1+I7qyv3dSDZamAz6l1CETMaQaj2dqo0LKlb51mqD3fxQUlq+J22sQoB3U/WUcSkACiNfvVTNO1ffu9cRB7O7slP+B5AVkaumobf8pZb5X1hGUy0/kL49rP5PGlAovnFAT8bzYdge2G30KTqGTJ2RsYVd+kwiI2Me+y+4O16SX70GRm1swdKhISUnBiuZ5iESiXa75tPhAAAjKEuKlcrqP9A5eoCc6zt2Eh4wPWg==
Received: from SN7PR04CA0183.namprd04.prod.outlook.com (2603:10b6:806:126::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 20 Jan
 2026 22:27:02 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::10) by SN7PR04CA0183.outlook.office365.com
 (2603:10b6:806:126::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:26:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:27:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:39 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:38 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:37 -0800
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
Subject: [PATCH v4 08/10] cxl: add DVSEC config save/restore
Date: Tue, 20 Jan 2026 22:26:08 +0000
Message-ID: <20260120222610.2227109-9-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d450f3-6d96-44e2-93bf-08de5873087d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnImRZF3FhyULtFTJF7RYpPvfclIAuv+zecyt/UjSRawVBUOve1YSak7ZyEg?=
 =?us-ascii?Q?JCfCAq7V9erTlGeQUJyZLdbNvhL82aKjCKUVefTckuWQVzbhWFQAPouSwhwk?=
 =?us-ascii?Q?kleDrIU89zuYS3h8qJAP3fkqdsQORkkamsC/1y2ikdjKO8JmfXNA6j5Kx1ZP?=
 =?us-ascii?Q?YalvP8sLHH4yMpPIhRL0zpZhOhi0kT4kXzZdzudyyGkEx72eX2TGNCK/eq14?=
 =?us-ascii?Q?+j8qbPGIne/W5cxeD9o0vQ7XYgVKolOYedb9fzpDj+qL/sUwXMEPGjxZOTAh?=
 =?us-ascii?Q?+nIH4qdS4RcM6romFLYvYQQ3iVWB5SrF2NY7dCjKdcoJ2t9CMriXSMyz4Uv3?=
 =?us-ascii?Q?xkskFT3FodrAQ5WVTxjW9+GgjiewAVRw4XrohnFMb4nwu9UwURk+8NTvQUS7?=
 =?us-ascii?Q?ytzTqspUtoAA7B0YyKhAcBXBPKP//rodIJ8z+Q70WjkIJ429tGcIPTCaBnVg?=
 =?us-ascii?Q?SHf+DTrn/TLsVqw9grxvOhomx8BpmWbc95PO5X/99rE825DBADkaSsG4HeJC?=
 =?us-ascii?Q?gIBEU3K/JzuHRrRD7YhbfGtuEtjem4AhnSPocW5wpHus3IQGhfMb73EIXxNd?=
 =?us-ascii?Q?Zq9S7HFy6NR1CQM8pxh4WRhega87mabozy4yMJYA4Qt3wV/oUMGNltOM/Qu6?=
 =?us-ascii?Q?ZWGGPEf0NL4AXIkcSUQmIYVyAmfbaeW+cRksr6A5e42tTrZh8mtbHY9L3B2C?=
 =?us-ascii?Q?sXnnZot+nfot3vaKU6xFOdnEInDiYyZLFaHuwk9AL616CKJLh+TzvFJgdDBO?=
 =?us-ascii?Q?3p0yuJHamwyqLnFKoYNlmfeY9iV8rEayVuAXZ4mO72N4DdfQfFu8dXGPzfyS?=
 =?us-ascii?Q?GD1pnUfiAoSPMJdHegnh98Rt5OwGYGpzrtqyP9X/8vOugYhUw1VbXPN1eTG1?=
 =?us-ascii?Q?T+OFElu2tJinf4ArSZ/C441PiSicRcHPYjdP18Qt1al896voyHwHayMivYle?=
 =?us-ascii?Q?pDttxxAOtzE/0wFIBj/Qpjbmv+4Dgt3jTxh8WpwQJLUPp6+Pr4ejvxyrRrED?=
 =?us-ascii?Q?VPayQ8nNIJjFCxpSqGwGLlhZEIOnnfkGiKfOWLd5B8o3rmr63yPzWxT7qnJh?=
 =?us-ascii?Q?B+BLRcAnF0GSJ/z6Hs3ybt/v0ayhxCGYeJdN25C5pPmck/4ReChbRYqRIGCf?=
 =?us-ascii?Q?KoOjeyASpR9ByIIgtfblfK7erupoXfjmxYaH1X0ZqbJKhfwUCDtGt7sxrVfQ?=
 =?us-ascii?Q?7aNnY+TUIS0U4AuNIXssk8kmOXvMCA0WrEyduRy1XVp5wseIdXBSaG+aqGQA?=
 =?us-ascii?Q?+rTzdPwKUBwrQpvN0FgLyeBxmoqk0qX0nkV5q512crDKQpqR/zsVD2SXt9vi?=
 =?us-ascii?Q?XhE5HE8Rx5NsuU0rPsQ1nWIQRhCvVYEDunuEkjOyMYiOL4rkGRySvH1+XlqU?=
 =?us-ascii?Q?EM4co0bpPlyCXOau3GXfRlng/Xcc5hjModzAaE/N8pgFWZeouyOOwN7FygcJ?=
 =?us-ascii?Q?z4Vn7TI2UVsvtL3bMBP9S1LcZJSBhoaUvrp6vMAAURZaqaptLnWITcn5E7tQ?=
 =?us-ascii?Q?CJHahmxJftuuRTO3eG26t+Z62O/rDHQwGTwLqOlXID7T2WeTSag3rm/0oTvj?=
 =?us-ascii?Q?ZH31UuMZ/4DnIahLPn3d9/hMdCozgB9MQpBGuwq4uG7jcE7noxSZ6n8V7Mdn?=
 =?us-ascii?Q?n/CGLUagp0CkFdnpLe7ghNbCICHqDMAov9RHNWwTaa6XIbjgfnAHw99qYgEo?=
 =?us-ascii?Q?dmSCzXy/USh1bPzQhKstYykTmo4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:27:01.8622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d450f3-6d96-44e2-93bf-08de5873087d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

From: Srirangan Madhavan <smadhavan@nvidia.com>

Save and restore CXL DVSEC control registers across reset with
CONFIG_LOCK handling so RWL fields are preserved when locked. This
maintains device policy and capability state across cxl_reset while
avoiding writes to locked fields.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 include/cxl/pci.h |  15 +++++++
 2 files changed, 122 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f9cc452ccb8a..7d6a0ef70b2d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1154,6 +1154,113 @@ static int cxl_region_flush_host_cpu_caches(struct device *dev, void *data)
 	return 0;
 }

+/*
+ * CXL DVSEC register save/restore
+ */
+static int cxl_save_dvsec_state(struct pci_dev *pdev,
+				struct cxl_type2_saved_state *state, int dvsec)
+{
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+				  &state->dvsec_ctrl);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				  &state->dvsec_ctrl2);
+	return rc;
+}
+
+static int cxl_restore_dvsec_state(struct pci_dev *pdev,
+				   const struct cxl_type2_saved_state *state,
+				   int dvsec, bool config_locked)
+{
+	int rc;
+	u16 val_to_restore;
+
+	if (config_locked) {
+		u16 current_val;
+
+		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+					  &current_val);
+		if (rc)
+			return rc;
+
+		val_to_restore = (current_val & CXL_DVSEC_CTRL_RWL_MASK) |
+				 (state->dvsec_ctrl & ~CXL_DVSEC_CTRL_RWL_MASK);
+	} else {
+		val_to_restore = state->dvsec_ctrl;
+	}
+
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL_OFFSET,
+				   val_to_restore);
+	if (rc)
+		return rc;
+
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+				   state->dvsec_ctrl2);
+	return rc;
+}
+
+/**
+ * cxl_config_save_state - Save CXL configuration state
+ * @pdev: PCI device
+ * @state: Structure to store saved state
+ *
+ * Saves CXL DVSEC state before reset.
+ */
+int cxl_config_save_state(struct pci_dev *pdev,
+			  struct cxl_type2_saved_state *state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	int dvsec;
+
+	if (!cxlds || !state)
+		return -EINVAL;
+
+	memset(state, 0, sizeof(*state));
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	return cxl_save_dvsec_state(pdev, state, dvsec);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
+
+/**
+ * cxl_config_restore_state - Restore CXL configuration state
+ * @pdev: PCI device
+ * @state: Previously saved state
+ *
+ * Restores CXL DVSEC state after reset.
+ */
+int cxl_config_restore_state(struct pci_dev *pdev,
+			     const struct cxl_type2_saved_state *state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	bool config_locked;
+	int rc, dvsec;
+	u16 lock_reg;
+
+	if (!cxlds || !state)
+		return -EINVAL;
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_LOCK_OFFSET, &lock_reg);
+	if (rc)
+		return rc;
+
+	config_locked = !!(lock_reg & CXL_DVSEC_LOCK_CONFIG_LOCK);
+
+	return cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_config_restore_state, "CXL");
+
 static int cxl_check_region_driver_bound(struct device *dev, void *data)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 71d8de5de948..2c629ded73cc 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,18 @@
 #ifndef __CXL_ACCEL_PCI_H
 #define __CXL_ACCEL_PCI_H

+/* CXL Type 2 device state for save/restore across reset */
+struct cxl_type2_saved_state {
+	/* DVSEC registers */
+	u16 dvsec_ctrl;
+	u16 dvsec_ctrl2;
+};
+
+int cxl_config_save_state(struct pci_dev *pdev,
+			  struct cxl_type2_saved_state *state);
+int cxl_config_restore_state(struct pci_dev *pdev,
+			     const struct cxl_type2_saved_state *state);
+
 /*
  * See section 8.1 Configuration Space Registers in the CXL 2.0
  * Specification. Names are taken straight from the specification with "CXL" and
@@ -23,6 +35,7 @@
 #define     CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE	BIT(11)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define     CXL_DVSEC_CTRL_RWL_MASK	0x5FED
 #define   CXL_DVSEC_CTRL2_OFFSET	0x10
 #define     CXL_DVSEC_DISABLE_CACHING	BIT(0)
 #define     CXL_DVSEC_INIT_CACHE_WBI	BIT(1)
@@ -32,6 +45,8 @@
 #define     CXL_DVSEC_CACHE_INVALID	BIT(0)
 #define     CXL_DVSEC_CXL_RST_COMPLETE	BIT(1)
 #define     CXL_DVSEC_CXL_RESET_ERR	BIT(2)
+#define   CXL_DVSEC_LOCK_OFFSET		0x14
+#define     CXL_DVSEC_LOCK_CONFIG_LOCK	BIT(0)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
--
2.34.1

