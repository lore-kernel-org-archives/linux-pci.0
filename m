Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B631D371;
	Tue,  3 Feb 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087273; cv=fail; b=rLurPOSbxwTxX+16EFIfhbfI96t0Zb5yEEnprRUxZJus4sd91TB1+lI2P1ZORBuge6rhbhKqq017sccKCWjDSV5HIAIXhvCxzcEEye6WCL1Lu1biUaAKZDCvnxfItkhKprSP3rHnYWcO71gu9MEGfbImTfXu8eeoe9FioIE+Xw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087273; c=relaxed/simple;
	bh=s8+ezmRjxMU20oVCNkBqYzlhKELLKQbC/behH/37274=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzaDVUyUFliSBLVIZR6enl8xNTQL8qchNbFGVVJFoJi6F7NAPMQ3BuhQYSUqWVL0HDGebv5HQea0Sejw4O5o3NbJurIm/Y882t1iZcfAfmhOXp+rWuZkhv5HOKx0mDwbgOtX/CIx9bLqfxrT82n0ICbegI/dQc1Jt4RNloV2kck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Vdzn/5B; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Vdzn/5B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMlc5kk0pBHCtbyVBhmBjCwrraJCuJfMKqzcD/WsPYMuSMlr7jUymyxul7STTWa55DCMfYo68cST1hfSC5ano3PSy4WOrTS8qbUrMzyhYGEIbTtXkmimrrxLx8rOcxQe2fLXheR59U577TXg3x5rvi4+e8bseltBEYjhnv9ryoQrQ+xT72hXPbJf5lbPaF3OUVl4eK3TkSMN0lYitqyiBvWJ0QVzIpPHlAn9HxZ/sUR9249OMsNdIjuY7UL0ogifbha7fafeU3gUImAP4fF43A3FHU0/OtCvTGpp7DRMw2yVEZdO6YY8RgSPzhvHwSM0stPKE8H0jnMmV2PfThT2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynsx/y+/f84zbCSGzS7HBt0p4teyehJi1UIKicdqLjU=;
 b=HRVe5bmaGWgO/5mu/pm6++TY5M/z5KxLUOZA3WnQIh1JSk+hKSOlWymCWF1RPyvLY0dhzekAkO+1xB8yXfi07fbdLlsxXmGFNwe5+XJgFn8I5PH5ohRNB0HDQ0sLOOQGTQ+oSZSuvnIAwEFviclN6xlIjxvpfjQR5MTOYUzLwI1ldX1l7TtutDc/jtpznVi9wPsKup1YxMAQXEkZcUVPxDOWv8qRdIpTBA46lu5HrvR495PzQ/jboiduWg5vhzeE67HpUhgIGrlkcEnsYLNfQzEhAVPIlfQ8Q7EowhqTzEtRoeWdAlLyu0WASpdSv72hj8T8OFsft5yndVCXQkaarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynsx/y+/f84zbCSGzS7HBt0p4teyehJi1UIKicdqLjU=;
 b=5Vdzn/5BWFBb9fymvnVzhLmySsOOlYz2BvySkqBsjLPBvJohO/qSY54FNvFOKpjvET35P8FEjd9t63HkGaNHE1Ue2sXZV9jxziOuLrrFnbm0ICnj8PyCOGPmDLcYx3Zf7oe+BFTmux3vvDljZ37ypSiNv8cEhYWdiO/CSniDEDM=
Received: from MN2PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:160::42)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Tue, 3 Feb
 2026 02:54:23 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::2b) by MN2PR13CA0029.outlook.office365.com
 (2603:10b6:208:160::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 02:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:54:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:54:22 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v15 7/9] cxl: Update Endpoint AER uncorrectable handler
Date: Mon, 2 Feb 2026 20:52:42 -0600
Message-ID: <20260203025244.3093805-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203025244.3093805-1-terry.bowman@amd.com>
References: <20260203025244.3093805-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: c267ffb4-1c37-4a33-4a2b-08de62cf8953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|30052699003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ree6WvnXW4sO2rxmoDqcjMqdr7ExImZ0/HOk/jWdNOIgjE27z7ODsxlfrpxJ?=
 =?us-ascii?Q?O39FDufvPHkIvTfNKQZpPl8YIgct0q+LbXDWOmmlihZUcGuQ8lYazJOzvluM?=
 =?us-ascii?Q?PyZQaGA+pmVoIEbtNjFUZF4s5HJQkpczI6pTzpy4osO+sYgOJ+WbcB3+nt8n?=
 =?us-ascii?Q?PZAWWyWhSdny/v82RUPXNulcEW6snILQhvgPUpk82mZg2xn5lhCCGXlp62be?=
 =?us-ascii?Q?K89auywLvF9hTzlfMFd0sMFFtllKqURaeFevf/O7w1EeSASvdHtM75wchcLk?=
 =?us-ascii?Q?GRY51YcXtfKWeELNTFSifrxnwSrcZo0/SyOUzBvPUTUs7JgmBzp8iNFN2oC2?=
 =?us-ascii?Q?MyMu3Q7IWiN45OhwVZwFUb2ARpNTmTpPWQgMygpNi4Wje5ACq9bYR6VZlvmz?=
 =?us-ascii?Q?9iWJ0LDAwiQjNnJ2bcHJFRrj/1qkDZD1mgeg8mGtvU6ROqOlfEr5UMAP1N3I?=
 =?us-ascii?Q?RJv1xGIX3uktLZry+0w5zf96HiaAxIj4kdBtHucwWHqR7zt/wcUj7C2uwMYt?=
 =?us-ascii?Q?fJ6elPvFN8zWzxw0pmfmGK1XPsAdUIBLJ016Kf6FyFiK5iNx6cl7W70x/QVy?=
 =?us-ascii?Q?a+U7DMKSbE/qXHADJzYJV1YZGMoDtazBrpZ7B4HqSkg3GG9lFnJEkRUNW5Kj?=
 =?us-ascii?Q?L6VG+Fhv+cRTiDC8TyoQifCl2fO8iJ+WI7nrovFli49Y7UrUfl0z43FFGwU4?=
 =?us-ascii?Q?usBrCoXaNvYJ3rO84Z7HwP86b8LRAT7DfSeOhXx9fC3QyozM271MUh0MM+/B?=
 =?us-ascii?Q?tCepzJHryh58PJUweZUsbNzFY+4q/oiCEbydt/Jd9fnQ7mRpI4CiYw3edqfq?=
 =?us-ascii?Q?g+zpGc6o51PJPr7nweNKweTBYnh/ziYkusG+htYrZEQIXbUv0iniQ8IBQ6Gm?=
 =?us-ascii?Q?gOy6wc9h2t7Knh5X8wmG4IRHXQjOBzkeZJzJk47xoG0YQrW7w6UstMj2fG+r?=
 =?us-ascii?Q?jTnoSVdLvRa0TnIHbYOG06kaNzg9b2kz1f8WwUbFBlse3GGqZ5JhPE6BV8Qh?=
 =?us-ascii?Q?+2QFkQT8BXdA7yqd62biAcSmtwV5XCb52Y4lmtVH6FHCxaIwrJofeAzf3vn+?=
 =?us-ascii?Q?YIcNA4PFKAJ1kHP/4BsXgz141ED8ynhJdfkjnskSwNg7O+nhb4IEZVFoQ5A3?=
 =?us-ascii?Q?KVLXlul6H1SSKUIvy4wnO9F7GyVB+3aCTH2kIgvfWS748B7Rgl+/BLKrgclu?=
 =?us-ascii?Q?Em4QEBssuWOPYBGx0UQRFBS2J4D6KKWGRj8HJt4+/fLNl+4RuzBk5KFHcx4Q?=
 =?us-ascii?Q?6todLVNoJYPy5pvOkcPhkavyRNVUvpVkzl62Gl6/7YFeX5vZKWQBLaEivtgo?=
 =?us-ascii?Q?bagehqSK5U3gqdQTo5I8SAbsvmb3cQMezoC+YxuAYK0s0YTMJmUpEDIo+d8j?=
 =?us-ascii?Q?DM0qY6Kwvucsy28g31exvMf3EVCRrRVcj5L1qMVgo+enFOXfmUUqfQParH0T?=
 =?us-ascii?Q?jrx13qhCGSI6AczhsQf1/iOyjtWHQz6HTM744mCrOWzgWXL+3IPtN7OX6xxX?=
 =?us-ascii?Q?PhV+9sCHannCT+5tUSyDxZEYQKHSSb+TlY62vVgtKsTOV1bE/FD+VXmt+O3l?=
 =?us-ascii?Q?ZllGMnXv+Bbvy2skDlk6MgQQlnJlGzWAIaV2qBPw5q+A+cqfzYhhk3v9uEMc?=
 =?us-ascii?Q?XZd5yut82hhlt4Ou5NxgLw3j2p8Q5HeZrVCiEQY74UJpsgpGz4sisyCz5+20?=
 =?us-ascii?Q?Cza7Jk9e4rQmPL/YiMQyPqbB3kk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(30052699003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x85ingmKju/okL8SnbEPuFT2N7ihuSsW73Ht2f8ZnVNoPedCYTisL1Gk9P5ljEGB1Z0bdaYPb1XK8WReFAUz+8+3LdmQN0aczbAhFvwLqjwS4TnwGh7UKjex8T9IeGeRIpVFsnm0Sd81Pk13jwg7V707xEf6G9yjh9hEvo70kSCCdyluWh5kwvU7AWE2ZGDOSZ2bKXbBnnRwiP4v2o/JXSLmJxq1TIsPzSunW54mGqsDPJNH74CO6lRqIR/ZuqxQIYS5I704R8h0BMLICAeUbu7IJ9raUkAtLfn4se936Uh2WlMfqKma9gnDKFtGZxtKREUKKCx1XYquRhBd13eSkIN+uOPZMnhTr3Du7U+X1YOfzU8S39tjSG1jvGSkwkhe2cTs5Z3KmHaruYXqyPss1saF4KaSf4Kt3FVPVIokSHSnSI4WM/1ALEJNqILaMioQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:54:23.4445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c267ffb4-1c37-4a33-4a2b-08de62cf8953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

CXL drivers now implement protocol RAS support. PCI protocol errors,
however, continue to be reported via the AER capability and must still be
handled by a PCI error recovery callback.

Replace the existing cxl_error_detected() callback in cxl/pci.c with a
new cxl_pci_error_detected() implementation that handles only uncorrectable
PCI protocol errors reported through AER.

Introduce helper named cxl_handler_aer() amd implement to handle and
log the CXL device's AER error.

This cleanly separates CXL protocol error handling from PCI AER handling
and ensures that each subsystem processes only the errors it is
responsible.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v14->v15:
- Title update (Terry)
- Change cxl_pci_error-detected() to handle & log AER (Terry)
- Update commit message (Terry)
- Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)

Changes in v13->v14:
- Update commit headline (Bjorn)
- Rename pci_error_detected()/pci_cor_error_detected() ->
  cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
- Remove now-invalid comment in cxl_error_detected() (Jonathan)
- Split into separate patches for UCE and CE (Terry)

Changes in v12->v13:
- Update commit messaqge (Terry)
- Updated all the implementation and commit message. (Terry)
- Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
  pdev (Dave Jiang)

Changes in v11->v12:
- None

Changes in v10->v11:
- cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
- cxl_error_detected() - Remove extra line (Shiju)
- Changes moved to core/ras.c (Terry)
- cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
- Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
- Move #include "pci.h from cxl.h to core.h (Terry)
- Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
---
 drivers/cxl/core/ras.c | 68 +++++++++++++++---------------------------
 drivers/cxl/cxlpci.h   |  9 +++---
 drivers/cxl/pci.c      |  6 ++--
 3 files changed, 31 insertions(+), 52 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 970ff3df442c..061e6aaec176 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -441,55 +441,35 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+static bool cxl_handle_aer(struct pci_dev *pdev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return PCI_ERS_RESULT_DISCONNECT;
-		}
+	struct aer_capability_regs aer;
+	u32 aer_cap = pdev->aer_cap;
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
-		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
-				    cxlmd->endpoint->regs.ras);
+	if (!aer_cap) {
+		pr_warn_ratelimited("%s: AER capability isn't present\n",
+				    pci_name(pdev));
+		return false;
 	}
 
-	switch (state) {
-	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		dev_warn(&pdev->dev,
-			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
-		return PCI_ERS_RESULT_NEED_RESET;
-	case pci_channel_io_perm_failure:
-		dev_warn(&pdev->dev,
-			 "failure state error detected, request disconnect\n");
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-	return PCI_ERS_RESULT_NEED_RESET;
+	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS, &aer.uncor_status);
+	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK, &aer.uncor_mask);
+
+	/* The AER driver logged the error */
+	pci_aer_clear_nonfatal_status(pdev);
+	pci_aer_clear_fatal_status(pdev);
+
+	return (aer.uncor_status & aer.uncor_mask);
+}
+
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t error)
+{
+	u32 rc = cxl_handle_aer(pdev);
+
+	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_CAN_RECOVER;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 970add0256e9..5534422b496c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,15 +79,14 @@ void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
 void cxl_cor_error_detected(struct pci_dev *pdev);
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t error);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
 static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index acb0eb2a13c3..ff741adc7c7f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
+static const struct pci_error_handlers pci_error_handlers = {
+	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
 	.cor_error_detected	= cxl_cor_error_detected,
@@ -1063,7 +1063,7 @@ static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1

