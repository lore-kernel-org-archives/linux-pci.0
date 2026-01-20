Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F763B9608;
	Tue, 20 Jan 2026 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948022; cv=fail; b=eeFtE8DZZFhkFCjuk/JqcL3Z0aaui/7VMhZzkPmzB8O9XkQcf+2bojpsbsY/W7FdF2aZhDq+K6Qen3ma14YwxWyHcI4WYvz8rMgtl6MDZavxgfG/wErxuS/7xy3keO6SS36GVbJ+j7dCtiFp2KMEHncfHNO7gKhBKE+GWWC9izE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948022; c=relaxed/simple;
	bh=JPIlCpctj7x0W0dUM5G7ePUZDFeHzDiHNinnJfCZ950=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4WfhS0/UNRTglJv9BGWhH8Nq7zHFDjMFjSp3fm6rbktLJWEOJpGkGkXDmx70AZgqa0FTw+9ZL7zEqPi9yWzztrAX0KYTkUwizaxNQ6E8P8OGE4/ENmdgkTaeq0WmNANAVLcsexQu+940JDHWI3G5B9nhKfUg1mfX0s03Bpd1mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gtpK2ZEh; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gtpK2ZEh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh6ojCfkFftTpSCdm8TAk/4Yc7MmI1bQs92b+fF/5cNaEoMJnS/HR/329Lo8Xvt7vKNMts0yyPd/zoLGMtsM5O4aiWKBuSL5Hd6cMiiwK+qSuI4PLDnpUTeK8M+21c+jGccQdMjOAFUDzRSMiIIs9J4aQgW7mtCbd99cN8sIwzfFT2zvGTyTBTfdADEtoBugi8U/ZdwgqzFJQfGrCQlLA0tjzTDOmjtq/AsiK2kbjc9VoVmScMemQm8713zInCSkoZioZc8HxAsi0vIXZEnz23MekoF+xlYUdg/1tm310DmTpXy/TWoSB7W8oEY5z9AHyFvOzrlgV/GCtFSNw8nYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0kD6d/+eB7+zLeHiv8Q7IFsetg7P8Bpk63eQIkRglo=;
 b=xxbp62jyy4VNJf7B46l8sD3rThh/+mZXltK2fXL6uaPa3uJbTYUgzGw7+jOxrRuKZBd3M7e4fHRe28Tg5/wxbe+3r+5sPhqhnwenfPqXljj9nGuDLNUOrcVHwysam+ZA0icOqWK+HWPNOkC0/JCHVj3AugWkg2HI43x7Obi4EI7UfJSjLbpsq5pPMmzOvhPIR7SSzj3wmU8ONgwhIUk7IvUoZnXriSHKosyi4FAQAPPOjCJVotAbYUVvJq/4zr8zI6UQFi4P5sBCJ8mXhdSat5fHhON4jaJNgQXFpEATvehUvRB4IYKGxEr+tErAbGWfDbWRW6BZsTrPw4atkHA+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0kD6d/+eB7+zLeHiv8Q7IFsetg7P8Bpk63eQIkRglo=;
 b=gtpK2ZEhhI2q1CyoNghXAFj0dTdvVy6AHOCJ8WYKbqAzeErzH8CRjyuUHim1mdH5b8qvh96eNhqcOPSLrHGUCeTqbgCOlf2ilgn5xF0Phw/oIKnTd616HCW9csgJ58R8BNZFR6KA6JjiBeUwxKOKyS59V0xyEe6c8HjSOFxVHncvtgcyal6AD250tWzpfvMBiz+nHGFdEqnv/FaO1Id0ZCzKdS3ZNwHvztyBqIJq6NDCdd26qWjJFv0hJ1r6l+iie+Wxi1DkhfsHbBSb1ewaYeBVYcQreZVY+8fUA9M8jOH2vyivYj9x2mvRc+7N3qntQbs3EEzBA/2kov9jVb33lg==
Received: from SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) by MN2PR12MB4389.namprd12.prod.outlook.com
 (2603:10b6:208:262::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 22:26:50 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::cd) by SN6PR2101CA0010.outlook.office365.com
 (2603:10b6:805:106::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Tue,
 20 Jan 2026 22:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 22:26:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:29 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:29 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:28 -0800
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
Subject: [PATCH v4 05/10] cxl: add reset prepare and region teardown
Date: Tue, 20 Jan 2026 22:26:05 +0000
Message-ID: <20260120222610.2227109-6-smadhavan@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 390b8b4e-8562-450e-2ed4-08de58730192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHTGAP4m24jrG4fIEAFGfrWt8IIoK2//I/KzDiX7ZD/Lh95kbcKwL0iyU9ed?=
 =?us-ascii?Q?Is8X+IPjKvYv3HJW1V2M6Joa18+J0tIKpFti3d8D2M0preM9Yb8ynBfDAhkL?=
 =?us-ascii?Q?OGjBMHZcUvLgWdCD8qE1Mo9kg3GAz9cquw42w1QbgIJx1P4Jjje1HILbTPBY?=
 =?us-ascii?Q?qTT9Nll15/k4Qso5t6PoK76aGuaJwNgJjxk2AI7N/e4gjrtTFMOS+ya6vzmm?=
 =?us-ascii?Q?8Swk01ylMXVEgx0Fa7we+KGH1uGzqYv/QWWT2nwrsIS/u92FYoHDJjJGLaLj?=
 =?us-ascii?Q?75mNw/QEQqzYCIcGOnA2l2TK+S6K03tmxLYO40mrCNqF3r+8jl1yGDrke/I5?=
 =?us-ascii?Q?pJIOWQkLqo2ON49kk3Ke19OEZFxj5GaUCCPtIACg6ML0urDLOgiINrkt2G5c?=
 =?us-ascii?Q?duQ6uyqP2m41DCetYb+utjXP9gduKk0qA0WiA0oN9QJScoVJWyyls7k0bx3x?=
 =?us-ascii?Q?Fvh5jPNlGrLcmAkwIcOfMoHmmeFVkGx6M6el1wPxSpeC2BCIhm1tYTZYPlmr?=
 =?us-ascii?Q?qzohMmK4Pmpy7/Wi4KMo1U8IkBkw75mb5PjX5c3WJfvCtH/EWI+3Gd0XPEtU?=
 =?us-ascii?Q?jPFQHHlrGrVoY+saRhDKzmmaAwsqMlTbICemydSbNkqkCcqv+8k0jr8mM1XG?=
 =?us-ascii?Q?g5W2NHocQLzdhSohoWyRaOJnEdXX34zy0SBVyoxl/SGhX3/k2PjGXZgmHz4g?=
 =?us-ascii?Q?r3frVFMfAhs/kOdCSdPykJwKoSUDkiRSH3zCpPEEdOVmTr/JJr0qBIkfp8mj?=
 =?us-ascii?Q?aOYd6T76vo4AgKK4jn3Bj1n3ieoTovjy8yyMY9qWtvcn1+6PwfpVMc8AWM95?=
 =?us-ascii?Q?ppnUdGsTSPn+elTDS4+805vHsJBO2+Qb/SrKs7A1/HdpGUAWMDI2Ep8wrN+A?=
 =?us-ascii?Q?bhFOjPTXlzSSCXjhm9hEqizAGt7y6d0iXQ48jUG+veWCoNFDKVN68kOdgKyJ?=
 =?us-ascii?Q?Vzl+7k9qVC5mexLQ/Bx7OjZyTPdfmOUTI39i8unMy2FVvdFhjyhNj9ZyqZ8a?=
 =?us-ascii?Q?O43DbNcqA2tcBURgNhfOUz80cXq93/w7G7b4c26Sdn6aq30AJvvciBL7G9PM?=
 =?us-ascii?Q?eraJrHnoZl9MAunAxRaW64w7h8OhKXmUNyY2QIcz4LxZLQCrzqEfjtqOGyTv?=
 =?us-ascii?Q?Sb23NjYcz8cAox2o9Cs7xJKjuWMdIgmXIPV1qAPf+SnWWGlOjCbq/kZnQKUF?=
 =?us-ascii?Q?kcmF31K3d6mw1AHqhdRO6wDJmb12/01B9C5eF8ZoQ/ZSWtPUegm2+CHfcp0h?=
 =?us-ascii?Q?0k2vTqvO0wOHH+LTQTwILc8Nci7KYPhuYtczbBWLLkC1CR6NZhF06edZeFQX?=
 =?us-ascii?Q?kSHtjkzR6SvZyiqb2czhXCJYoweIHg5xee2txu8od+fe6hLzba8l7lmmCtfG?=
 =?us-ascii?Q?mjV6LCYFBs3iMeIyC4n2qm1WnVswY+a8qZvj4nKr25X4MDnRy4qkinWij1qB?=
 =?us-ascii?Q?F5SfMDJHI3jMKjc2Ak1MV3trKkwb8b/j77A8AY78Vd8p89AsH3PYLGcVveef?=
 =?us-ascii?Q?e8e8uWnHP4uddB6fw+rqwytEkZoFqeR2FSLwMrZ553b46tgiup+qbiwEzyZh?=
 =?us-ascii?Q?HQzS1Jvibq5cjgNQBtNMr4XU2SZT/1ZybOokUPR277uRW8qTB3Z0xPZ/q5T6?=
 =?us-ascii?Q?N3pClKOgYry8G37TdC1v5n8thF6n55FPATy6D+6C4A/b1tVAfWYrJLVJikDS?=
 =?us-ascii?Q?FhGt/NtxQuWgTAKLDdKttdx0vXE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:26:50.2551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390b8b4e-8562-450e-2ed4-08de58730192
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

From: Srirangan Madhavan <smadhavan@nvidia.com>

Prepare a Type 2 device for cxl_reset by validating memory is offline,
flushing device caches for region participants, and tearing down decoders
under cxl_region_rwsem. The lock stays held across reset to prevent new
region creation while reset is in progress.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/pci.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b562e607ec46..e4134162e82a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1085,6 +1085,220 @@ bool cxl_is_type2_device(struct pci_dev *pdev)
 	return cxlds->type == CXL_DEVTYPE_DEVMEM;
 }

+static int cxl_check_region_driver_bound(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	if (cxld->region && cxld->region->driver)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int cxl_decoder_kill_region_iter(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	int rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxled->cxld.region)
+		return 0;
+
+	cxl_decoder_kill_region_locked(cxled);
+
+	rc = device_for_each_child(&cxled->cxld.dev, NULL,
+				   cxl_check_region_driver_bound);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int cxl_device_cache_wb_invalidate(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	u16 reg, val, cap;
+	int dvsec, rc;
+
+	if (!cxlds)
+		return -ENODEV;
+
+	dvsec = cxlds->cxl_dvsec;
+	if (!dvsec)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_CACHE_WBI_CAPABLE))
+		return 1;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &val);
+	if (rc)
+		return rc;
+
+	val |= CXL_DVSEC_INIT_CACHE_WBI;
+	rc = pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, val);
+	if (rc)
+		return rc;
+
+	do {
+		rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
+		if (rc)
+			return rc;
+	} while (!(reg & CXL_DVSEC_CACHE_INVALID));
+
+	return 0;
+}
+
+static int cxl_region_flush_device_caches(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct cxl_region_params *p = &cxlr->params;
+	struct pci_dev *target_pdev = data;
+	int i, rc;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	if (!cxlr || !cxlr->params.res)
+		return 0;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *target_cxled = p->targets[i];
+		struct cxl_memdev *target_cxlmd = cxled_to_memdev(target_cxled);
+		struct cxl_dev_state *target_cxlds = target_cxlmd->cxlds;
+
+		if (!target_cxlds || !target_cxlds->pdev)
+			continue;
+
+		if (target_cxlds->pdev != target_pdev)
+			continue;
+
+		rc = cxl_device_cache_wb_invalidate(target_pdev);
+		if (rc && rc != 1)
+			return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_reset_prepare_memdev - Prepare CXL device for reset
+ * @pdev: PCI device
+ *
+ * Validates it's safe to reset and tears down regions atomically under lock.
+ * Acquires cxl_region_rwsem and keeps it held throughout reset.
+ *
+ * Return: 0 on success (lock held), -EBUSY if memory online, negative on error
+ */
+static int cxl_reset_prepare_memdev(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd;
+	struct cxl_port *endpoint;
+	int rc;
+
+	if (!cxlds)
+		return -ENODEV;
+
+	cxlmd = cxlds->cxlmd;
+	if (!cxlmd)
+		return -ENODEV;
+
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		return 0;
+
+	if (cxl_num_decoders_committed(endpoint) == 0)
+		return 0;
+
+	down_write(&cxl_region_rwsem);
+
+	/* Check and error out if memory is online */
+	rc = device_for_each_child(&endpoint->dev, NULL,
+				   cxl_check_region_driver_bound);
+	if (rc) {
+		up_write(&cxl_region_rwsem);
+		dev_err(&pdev->dev,
+			"Reset blocked: device has active regions with drivers bound\n");
+		return -EBUSY;
+	}
+
+	/* Flush device caches and tear down regions */
+	device_for_each_child(&endpoint->dev, pdev,
+			      cxl_region_flush_device_caches);
+
+	rc = device_for_each_child(&endpoint->dev, NULL,
+				   cxl_decoder_kill_region_iter);
+	if (rc) {
+		up_write(&cxl_region_rwsem);
+		dev_err(&pdev->dev, "Failed to tear down regions: %d\n", rc);
+		return rc;
+	}
+
+	/* Keep cxl_region_rwsem held, released by cleanup function */
+	return 0;
+}
+
+/**
+ * cxl_reset_cleanup_memdev - Release locks after CXL reset
+ * @pdev: PCI device
+ */
+static void cxl_reset_cleanup_memdev(struct pci_dev *pdev)
+{
+	if (lockdep_is_held_type(&cxl_region_rwsem, -1))
+		up_write(&cxl_region_rwsem);
+}
+
+/**
+ * cxl_reset_prepare_device - Prepare CXL device for reset
+ * @pdev: PCI device being reset
+ *
+ * CXL-reset-specific preparation. Validates memory is offline, flushes
+ * device caches, and tears down regions.
+ *
+ * Returns: 0 on success, -EBUSY if memory online, negative on error
+ */
+int cxl_reset_prepare_device(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = cxl_reset_prepare_memdev(pdev);
+	if (rc) {
+		if (rc == -EBUSY)
+			dev_err(&pdev->dev,
+				"Cannot reset: device has online memory or active regions\n");
+		else
+			dev_err(&pdev->dev,
+				"Failed to prepare device for reset: %d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_prepare_device, "CXL");
+
+/**
+ * cxl_reset_cleanup_device - Cleanup after CXL reset
+ * @pdev: PCI device that was reset
+ *
+ * Releases region locks held during reset.
+ */
+void cxl_reset_cleanup_device(struct pci_dev *pdev)
+{
+	cxl_reset_cleanup_memdev(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_reset_cleanup_device, "CXL");
+
 static void cxl_error_resume(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
--
2.34.1

