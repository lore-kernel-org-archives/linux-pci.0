Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572263E8C51;
	Tue, 20 Jan 2026 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948018; cv=fail; b=IXT54Xkz8ACVi7yZvMpedhB3AW/gjiTzJ6O2BZyeNv8KCvPcRh6GKyXFtFVg6l2x4iSaer4uim9UB3YbtGHf491VZku2MhFEWG4zVNaDj4ZBeM4tBwvqEkkbGmXqqZajiZ9YwauHrnYXeguR/rCOONRKmQ10SbjJE7fx0Day8ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948018; c=relaxed/simple;
	bh=myz64eTX1pmZlgs6fxDZfg6bVwjGzN2igSh3M5+xhfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSAzMc6eTtX6zXTbbuE+kpNcycTYnd6IxZaJjS/ypc76aPUaiuRhd02zZElr2DEZ0XcTk91eV/SrFG3xg/L+aoThPcO04skgPGW4K4XBaLBxwMxaCL/Ca9v9n04euMMrZq7yVl02BlryQLPAEFshL7LBQe/ng0/ZwLgjs34vVm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rRPQIB97; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rRPQIB97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhi2fyf0+xuKTAmSL3xyy+AYqXyTcML2xOp+kH2Cn6uS6WLfyTe2eiFBBoqWVKg15ysLSegRgEv8aZjdorBIDnAXIfl9oJ52Cg3kMJIkZf8ZTW8svdAj1HSC4LLFdFPP2KQze8tsEGOUexOk1d8PNpytVu9nu9QA/RywvtZga2Ky9/Va+3A+VdjkSC3RXc7A+PnpXXViNEogdKLgWBJp4HW62SQZmVCULb/rhdWMDxt/5CKIUf0LrpO3fZPL0BrMgeKkk02tURTI4U40YdJpr+IPPZC7Qp+mCcQzdsnBLBzRGY6Penp1mnODy/1w2Nt+hEo2Jp2ElYtYT2dfMfwdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEsivikuMf+jF8HTcv/5j+6rr73q+u4ZXo4oAjhZFKA=;
 b=Gk1o+DMUepUI4WdyZKSGN+y7W4y6akU2dC1mkOklCg1VTOn2pes79FsvGE9GXc0g96FyxPFZsW2sgMEKlb0ue018JTN/pod635ol2Y5tDTcZFQTKbfW+uiVfAqILtz6GgnkTqIvFZQncgNUFdTrcopKZvsbe5t3aPNBk7UvvZOQe+JNllbRgGRS4HGFqw6JTkRO7qOSMGTMYVzHfsNv+LHkW4n97NKNqjSD+HIP91cIq/U8a+RwTsK++TuQZuai3xUbEp+4gVameeJx/1Oi6WxvnXcOF0H0buWLycu3Zv0KD5LMHxUs0x+ISV0b0+5RJEyQwZCIsO7yOBccETwm7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEsivikuMf+jF8HTcv/5j+6rr73q+u4ZXo4oAjhZFKA=;
 b=rRPQIB97LBhEkrOI0PnygMkhgF48u5zhmhseFeU0mNmCqEF3VFlyotVU92+gEpaAfU/ByfRrNZEmTDhNRUQlA6PHYIjl/5VwtCIb+X9JGk1VTUFrVrQeJXagpBm2owiY24kiIC/8kY4Fzl3HAEhSJALqbBYQlBfTkB90xkcMYD7N/aYEMI2hQqDy1IV9De38FmCD4MMPrgrueEsTcgqBdZtmu2Dba4UKjXEKzcDhKEw6ZO6xstpzcjR+KVt+nsPTymFYIXvYsTyiIw8/R5eVxwtYxGoF2yVPlqBoFM4nsrEWJfvLf1CrtF3ap5LoOM7yJc4RzTM7qAqn22TjkuJchQ==
Received: from SA0PR11CA0063.namprd11.prod.outlook.com (2603:10b6:806:d2::8)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:26:48 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::1d) by SA0PR11CA0063.outlook.office365.com
 (2603:10b6:806:d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:27 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:27 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:26 -0800
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
	<jsequeira@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 04/10] PCI: add CXL reset method
Date: Tue, 20 Jan 2026 22:26:04 +0000
Message-ID: <20260120222610.2227109-5-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 034d2cc9-c1a1-4b2d-e350-08de5872ffd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kf3AP47jsHsZl99PgHvmVswwXSuQHELk3bhUszuoJKKodynCcvXljYQ1Rbkm?=
 =?us-ascii?Q?/C7Q6QfipJqhPccS2qkAIkGUgXDJ6nKsEaLMJ1+aqVOF4Cimo1R/+YBK37lk?=
 =?us-ascii?Q?xEdOhBzKJ16wNDqOcjMu8HBAcVrFIlTaGdhI/gDzgRJMOOOzTd7ac9e8Ei0/?=
 =?us-ascii?Q?04BBWcZtrE21rTeGiy83XoEr9EsdEfyUY6vXlFJjjyREIlCzhunoSEcGQx1E?=
 =?us-ascii?Q?jcaeLftfjwdQD6hIsgLH6zfxHN3OetNwwLwBHKFQas+KlRiADbT3jUnNi6HR?=
 =?us-ascii?Q?FCi12aJu/WAxHtehdJIIX3kYx5mr1vp1rzGQqozN5RxUHMG4jEqWle5vZfAu?=
 =?us-ascii?Q?1L38SVAAKp4lf4ljyVRJ4lIQObTTe7gDqGkvPhEFjBc5m6r4BPyL6Z/9IuFL?=
 =?us-ascii?Q?mu6rKCDRPldlF72t/DZlVJz5bUqQDVxk20eU9i2/wGztl2zp+SJCwBuiYEKO?=
 =?us-ascii?Q?bWrW1NCcsGCNXPwoHpgwRQ1ZIx3dRs20L5h3eYOL5stmB1J2TVkrvcGcCOaE?=
 =?us-ascii?Q?Vjw1IZIklA8gxRGlxzgMQRvtl6fh8iXQkP9lN9EB32XI0vzENRr8yQZcBc4L?=
 =?us-ascii?Q?CZt92y8xogIL/roPfES9CbqPqpZAW1HqKMJd8F9eCkA/UW6tT8XU2GzlGW2t?=
 =?us-ascii?Q?ZTbGYZWqnTgT3x4RMC33HLrxmDM3pSNkvBDU0zZy8AOZortexYYNArgnhZ7f?=
 =?us-ascii?Q?H5rWzf/fhZLzM6ZlCfFgymaypfwXAg963EGUCUmI5IWcO1r9ea6002PkxL3K?=
 =?us-ascii?Q?bMWWoToCNHpPaw3tUka861n7lXSDUI8zSq4mdG17PyJxpum2fZPmifQjr7c8?=
 =?us-ascii?Q?VnyiCnhA9ZU5A1kv4Rnuj0toC0c6izeYJuF4YWVr2QEu9TTiOBN1O8X3G57R?=
 =?us-ascii?Q?Y6b0vaKaEC7b5orZoaifOrsX3Gb7eoex9d1+DssdFYmoMl4CoQMMOdnJ7g9h?=
 =?us-ascii?Q?MLLQSrnWaMe1ql0leXgSrGgdaDPN/e7WdD1aAVWx+OJ0qjogkXh7Sm/UbzqN?=
 =?us-ascii?Q?cmshC0nDll4lAYwzGROEEv5Js0j26iZG3te55DN2AJ+h8iGbB6oWibSENQC/?=
 =?us-ascii?Q?fp+RY47cR+q4+e6bYPsAANJ4qazxJu3TV1ViMz8NitdFeQCbUBa03U4YrXOS?=
 =?us-ascii?Q?zv6JO1i0IMII++2+XFoJzdJogvhIzSYIYFQhtr24t/JkcGXbHdBnNU9kN8Px?=
 =?us-ascii?Q?7+7ecOinohsa4t+/rDfTZUl/dtjEe4v9yqTKff6SaoQChRkQA4bOHfWUYUuE?=
 =?us-ascii?Q?5WltyoSX/t2OI+fg4AKNC7jS3hAyUz5GDZFZwUE5Lo1j/kh40j5Ifsz/2+NY?=
 =?us-ascii?Q?8fPoq4+IGn7vYt5/b7sB9RyBxg456alJLnWAznV0qZ5mjdDLiLVG9cCMEVhM?=
 =?us-ascii?Q?zADnWSbNX3zT5ACP3I9RSzDGQweVcHAzKz62TWd3NMzSCDI+qzCVmKDlXHbF?=
 =?us-ascii?Q?L1Nh3RXq3oUL7kAR8xGzACZk6z4hFprfhWi4bFBu+7U1dj+dmsbGQjbkxSIQ?=
 =?us-ascii?Q?d9EJeVQolcsrR56cxFOdkuZD4P+O9Kc3jX7xWl/nYZa3b4jMbE++AoJR/ms2?=
 =?us-ascii?Q?2yBhuXOhhwkF9wqqFsQLOsqYnt6+mbVlUOdkKOJeNFhYJGrtP9A61Of1LVEH?=
 =?us-ascii?Q?d1SF0sPMtp/7SjjjADkMceWZ1iWFsl+c5vk+xnKAcA9jz/YIIzRNBLpeD8k3?=
 =?us-ascii?Q?+2rC0mqwmNS66lxiw5Oj4nwuv28=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:47.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d2cc9-c1a1-4b2d-e350-08de5872ffd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

From: Srirangan Madhavan <smadhavan@nvidia.com>

Add a PCI reset method "cxl_reset" that drives the CXL reset sequence using
DVSEC controls and timeout encoding. The method is restricted to
Type 2 devices, limiting the scope of the changes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601172246.rz4Orygn-lkp@intel.com/
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 104 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  10 ++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8bb07e253646..e2d5ff25ab67 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4892,6 +4892,109 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }

+static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
+{
+	/*
+	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
+	 * under section 8.1.3.1 DVSEC CXL Capability.
+	 */
+	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
+	u16 reg;
+	u32 timeout_ms;
+	int rc, ind;
+
+	/* Check if CXL Reset MEM CLR is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
+		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
+					  &reg);
+		if (rc)
+			return rc;
+
+		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
+		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+	}
+
+	/* Read timeout value. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return rc;
+	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
+	timeout_ms = reset_timeouts_ms[ind];
+
+	/* Write reset config. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+
+	reg |= CXL_DVSEC_INIT_CXL_RESET;
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	/* Wait till timeout and then check reset status is complete. */
+	msleep(timeout_ms);
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
+	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
+		return -ETIMEDOUT;
+
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
+	if (rc)
+		return rc;
+	reg &= (~CXL_DVSEC_DISABLE_CACHING);
+	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
+
+	return 0;
+}
+
+/**
+ * cxl_reset - initiate a cxl reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a cxl reset on @dev.
+ */
+static int cxl_reset(struct pci_dev *dev, bool probe)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	/* Check if CXL Reset is supported. */
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if ((reg & CXL_DVSEC_CXL_RST_CAPABLE) == 0)
+		return -ENOTTY;
+
+#if !IS_REACHABLE(CONFIG_CXL_PCI)
+	return -ENOTTY;
+#endif
+
+	/*
+	 * Expose CXL reset for Type 2 devices.
+	 */
+	if (!cxl_is_type2_device(dev))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
+
+	return cxl_reset_init(dev, dvsec);
+}
+
 static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge;
@@ -5016,6 +5119,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..4a8c4767db6e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)

 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9

 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
@@ -1464,6 +1464,14 @@ int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,

 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
+#ifdef CONFIG_CXL_PCI
+bool cxl_is_type2_device(struct pci_dev *dev);
+#else
+static inline bool cxl_is_type2_device(struct pci_dev *dev)
+{
+	return false;
+}
+#endif
 void pci_ignore_hotplug(struct pci_dev *dev);
 struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
 int pci_status_get_and_clear_errors(struct pci_dev *pdev);
--
2.34.1

