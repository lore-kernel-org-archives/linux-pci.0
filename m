Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62097495528;
	Tue,  5 May 2026 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002355; cv=fail; b=RGuVdi3vm7eUiNteh5C99lJyvYW1PBQEwF9ff3z6pGWMIMHpLLz/GvXc3p5EPiuHT3hzQU03xIpR3jFeUiSJ0mi+aEnRADiZNckE6OL+I48+5EblLwE0ZIktzntDol729Ujai59wLzB8mPYcqmjVUeeLAeEEm2oytpdOSxxax4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002355; c=relaxed/simple;
	bh=mCpnIbdvI0KTGcrYf6k+Sne5X/TZ7kwYc39qdxCiYqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/nwo3w3NX296Y1Fbiyl4W8xAHp6zgUNKdkbhsfYKuwWJ2Dh+0Ub+7mL5ABULdJBxJ1QffJ/dM4T4C+cVugadomS5tG/12lKIHgTaQB0KnUt5Ic5J3wPWjUlFRHgrHulCG2BBSAz3kx5Slzobo8CdlafmOmzIrY7S7ypuWEeRs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PmfRajcU; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PmfRajcU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy4FQunya1WXuTWLIuenJV+UM51tzESFh55mQg0705wX7d0dVD5kKQWXCAZBrE/8T2hbhKT7n5y8J40HhGD3Y+InHTrL7ZZfIsnMb6Fwpth/gCcpA8NEHvRp4jN4Z1S3FWkc47tLI/ahxzx9hBWURdKoCVwKKYQ1arUp3Uwf1U/Mgw3UO8v6SukpY3MDDdtiq9iBV3fc5tY66JNwbxgQhWddZVLlzQl0Mufx/wrkFZ9vib37eizhMgD5c/SoR7wNgHRu+YY8Rrobfbs0URASnLRP4qq1vqOq57Cz4Obvv8aidVeWyzZWhDdlvDWcl6Nhc7HKdPX86/0nP5kNPfyUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeMv9h4w5dwSbf85yn4ph7wHp752ZhiCyf0/raOLZI0=;
 b=EzXYziwNcckFWIiTSOJjG34eG293iqpgVbXxn+bsLAQlnFjZgQ8t/hIzWFP+XjXJgHRPDrUOhewPxx+FIKrAZ40DUL9M8kJzneWlT/x37P72xaBbrumPqjM1KF82elOqwk6GpMXQNSqUl2snTRx8bVB3XDPruk3pRe4FBty0hMAp7zc21PF1FsGfuOQTqkB+iqTHwrQdMv8/1uM972+/teOptFlxxah5TkAecyE6Q7n/cY0SbQ3NFv7CYYACMk1qUgYQ1tlVQbClXUj3mJVPppo/YESvrHRbRFuoIm37xR+OzowFwsrw0ysrlkbeE3IG11yBvWTnCr4weqJ00+l7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeMv9h4w5dwSbf85yn4ph7wHp752ZhiCyf0/raOLZI0=;
 b=PmfRajcUoPjmFFGNPkfelcSHDN8b985R9hda3zf/epRYeKoTUH08KPUY91eytBRf2k/YfBrvdd8hDxQI8iJ07oZ32OCWn9XzDFXEeTugK9RxVluAlKCwdBMTtOgk/1/noBW7Y5lNXJ4glvKDzkVReKfGgFJe+DSwynGdWbjh1jI=
Received: from DS7PR03CA0154.namprd03.prod.outlook.com (2603:10b6:5:3b2::9) by
 LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Tue, 5 May 2026 17:32:26 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::b6) by DS7PR03CA0154.outlook.office365.com
 (2603:10b6:5:3b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 17:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:32:21 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:32:20 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 08/11] cxl: Remove Endpoint AER correctable handler
Date: Tue, 5 May 2026 12:30:26 -0500
Message-ID: <20260505173029.2718246-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: c13e8d1e-5f93-4a07-b01a-08deaacc4397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tyB3RC91f0jdtxARGeGYh5yLGVNEZgJT0IaJIxK0N6lnYWSVDd7H4AlAPZjDyaCeAG0oXuTd8hBrqVrbB8EGEAetAv/rpDP1dFfjGOtvwe6dpQFKFJhVoSWeZw6pbXjnjrPmb0J1h1qq++KwOYbW99fRiMdeFYCu5imRP7FS5WwIvsKSLwRvduLucyUcuWyovJvzGk+fFyaKCuSKlv1IBakIs5SU35yFFrbYLrgmEHVGZljvtKJRRvp+S8fc6kCjhumB2R/aDXHLCQyUmbZYTwks7LFvtA6zWPbbBIu6RGrKrLPQayM20eOpIUX8Kly4pQt3R1uWe8rNCx788i4lmKcrmu4FOuqSYUvQ92VH4dj4ZBhpSO6q/7tIZxrjaQD0m7DE/u3WlXuoPb0/otuIwlqzBSkuPeE/eOgLzBgInJpY5xYp/vyeZiz+WGkYLTrf4g77vGdoTmZAf/ZEP6P94J/s4aeIt4XNNpHGKcg7lywJSGnDb3JftJhGCt7UHMw87ko+Dfk+f5UbGppcLzNXgTsRStIdSy6nrv0Sg1rOm2LzXOTvdTUfUO1P4zBN7JsNDuHVZb5uxJ9t7CxyZBjfWIye0YZCOjsPbQk6Kud6p8WS3mzbqSMnCx7rUPb9G+PXyma5NGhIhRQNFeEkXT44QPmdhLRhm0db4QS4f5p2PGV7Ou0QxiQoyc/dp4K6h5yTpyrErSbLbC1KRg2sr7JgbXSSM1PcD8KD3FlK+EQPw+p0kDK4MkglMtmU/A/mEWdDZV0YhUCqnYOt+lW9337VVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/t3qwL4kKbiQFOwnrA7NHnTI2T4Lu8t1b+RRu/TseZwb+yH/CD8hfjCjVkOki5D1JcJ0dfkb9TvsAzqawzw3qGAoY36Y39Zk3FRjgyrZXV9PGXVURAGqqujhEDRI1aSPxqIM4cHIXHtCyXsP+EINSS26LpL5R+WqIYeyyhlTPikzpfG3GJXIRanVc4WToTYKDlqSgOnwInlqzmDHYdoPXaJsoWjUg/HtaJNwU3vrhSozkrEJwphMVscgJ2M/TvFYOpbtFclpJEMM9Saoa0w9G6Y4b3MIu7Ny/BDwX6mwBxQxYkpAmepr9Iltyix9Nva5vnpiioEu2iZeQKYZN6JxG1DE8KbBGQyA00q7UaWoSINUGmkaAFPgKRX4Tt1H6/U61n7rut5vmv1uqMhOwbRGvR+UACFfwHMrVHbdij0SJIuF9GhVzYk5thnWJG6wVBef
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:32:21.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c13e8d1e-5f93-4a07-b01a-08deaacc4397
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

CXL drivers no longer need their own correctable PCI AER handler. The
PCIe AER correctable status is logged and cleared by the AER driver,
and CXL RAS correctable status is now logged and cleared via the new
common CXL protocol error flow: cxl_handle_proto_error() invokes
cxl_handle_cor_ras() for VH Endpoints, and dispatches to
cxl_handle_rdport_errors() for RCDs (which calls cxl_handle_cor_ras()
with the RCH dport's RAS register block). Both paths are reached via
the AER-CXL kfifo, so the .cor_error_detected callback in the CXL PCI
driver is redundant.

Remove cxl_cor_error_detected() and drop the .cor_error_detected entry
from cxl_pci's pci_error_handlers.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- Update commit message
- Add Reviewed-by from Jonathan and DaveJ

Changes in v15->v16:
- None

Changes in v14->v15:
- Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
  in the AER driver. (Dan)
- Update commit message (Terry)

Changes in v13->v14:
- New commit
- Change cxl_cor_error_detected() parameter to &pdev->dev device from
  memdev device. (Terry)
- Updated commit message (Terry)
---
 drivers/cxl/core/ras.c | 20 --------------------
 drivers/cxl/cxlpci.h   |  3 ---
 drivers/cxl/pci.c      |  1 -
 3 files changed, 24 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 1f1dd20623f6..5cc4087c2807 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -253,26 +253,6 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	return true;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
-				   cxlmd->endpoint->regs.ras);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7b..06c46adcf0f6 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,14 +89,11 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
 static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 						  pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..5eb64ced0de5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1004,7 +1004,6 @@ static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
-- 
2.34.1

