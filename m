Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FB4F3905;
	Thu,  1 Oct 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846593; cv=fail; b=S3Wf0nUs6VxgocLKPewM2+b4r0et5X9w5q309meLzTJGae5JkAXaIFvX72Hhb1aXdmgRaTn68dH07wR/WOjjSDJ21+pENMnyzA174XFnTvuhG2mc5gGiODssWJo0VawJEayEv/w/5ThK5cWffMudC1M0xFCY+n+c+sWviKltNhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846593; c=relaxed/simple;
	bh=oj+lmaN56G5niirM88AIhTXR1DkJhYQ20yFKwLZRxEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPuQO3o02opIOSH1RZSSHqKn0aQsZlNNGSD1yUdEUl7ZJLtTbDJcfpUZMME1UhaYfYhqnFV+FlYXKFzH9dIlXwk6WGrlRRpRj3qyxhK1OteHkYxbz5O6Hk5aLnRq/EX0Pk0PpVkl+sS0VtYqaXTZiaNzl53pup4Bdsm2b39kiVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WF5ZiLpi; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WF5ZiLpi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR0gBJLQyE+alH2yM1+s+GZBw0hVAFrBthcZVtcS/31rKwC7TUFVhNeQRrF/GEsqptHg+nbH8m8GvwcbELUuaIcei8/OhbH+CjiTlZLlO0h+lXM0QBrSTgrcQDQX1WIB8LEtO03MXgcWy1K7awC7uFksKwrHMflKrrA+SGuvLFPEtsykZYSZzV7u4dgUZQ/yXSU0U2C1mf+jc+Rfd7TVp7E0akFkBcBgnXtH0R/JT0Lbs8fM0xgQNkrVK/6vkdK/JdZx/yjlbvyZqPKw8ETTlt7I91LXxUnunt9iUI6YmJPAKjkCAD6efKKY/IaLQbRFXv6E5KF0NNPyLmVX67qG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AovlrGliDTrRs74XESS1T3/XBQLZLgu2OL6R7gkMejc=;
 b=A7wHJUubs5xQgisxXA+pxc9ITnvGvK5dNRLhxL+HHKTb5/0bmMfTAW7zYQUeRJ9mkkZhmhjm8uXSUSZpquG3GRMGNKE9GKyhjEp9k8v6o3pJvQEOB7+8V6a6vZ/Jv0YBAkJtEEUJCJA8tm0YFzO7VCifZI6ubA7IhjsOlZs92lujnBWeYnnM2mpEFmbq8XD22clF+NZLteLgIf8GulX2Hpofjo8AEd88LNZGcLwRhGfeZtgxWwq1WieZhbqTD++FpyEp1TBUxIOBRJKBE3sNLgv2HWwGAEfrWqF351PrRepeJCXVrL0s2N+u3WEcqLbxk5N38GcaLCh+JuRDoLtg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AovlrGliDTrRs74XESS1T3/XBQLZLgu2OL6R7gkMejc=;
 b=WF5ZiLpiqAVdC2n7KFIZikIr6livZoWiVPeSxSdZqXiHWXzn+lFV0x2dTQomPal7ULNX+23aPdiF5SMsHOQwHn2nIx8+UT227UmXphL22R8JLgI6dwhG884QS0oXEwsuOnOHHYtIdblfJSQ6IqcT3LdIpN+fsDIvyvfCQWhwUDdu5/Kw84mkLykcYY4Oq99c/qQ1Tq+QmKPf7P3dFGjS4utY2pDvyrzbxLWHHuwj3t0ZHZvR+DogHsiwex7OEoFVnFqLJZO/wDEP5qqZqmtkA+f+cS6kD07/DZF9EK8NeevBJAAYHLfpHaXDQLoHyGramYsf+b0u4y54lE3zW0pnlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:03 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:03 +0000
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
Subject: [PATCH v14 11/16] cxl: Add CXL Device Reset sequencing
Date: Thu,  1 Oct 2026 09:22:22 +0000
Message-ID: <20261001092227.3004747-12-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fa769b-ec73-4072-47ae-08df1f9d97ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|3023799007|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CAqhpnfBn3SaouALXcyA73QMQvr3cKGGBmiP44W+2Uq12Lw49hMXhtDGyucEZ1MmgidfX4H/SSNDazpvJ8RBKrDVb4I7Om6kxhBtTM2Y8qoqSmuGZnfX4V6cGDw3q5bdPnNfMRqzgylqtaJ7hB5IyFICwSYjY1eubWKxWLCz2qRKLfXG4UhP35KILJEv+jpvXZlYlJ8rodn/sHjR2yYvcgtcxGyhZGxS9C8SY0Syufywtv8WyB5EMTxGkprvw/QIZsDoHIXvzhTbp5gPdrxIsIEm9SHWvYZDqUCcW5q1OYettPKW7PNwIRDhSv61vNN6rtiIPbWni3t7aBwe2aWi31zMJhZsqc8W4PYbBQqFGv5dZzrIryM5D/Vjcb2ZdrfMQCSRWFO+HhXzsOEcKGs4Yfi+JiBmrhjew5jdtccu+/x1kw3RgaMreiJTg+lJUMwIGEEzM9YhB+8nsYRz17yzNchjR8pbSZwarN/kERWhov4mB4ckWVh/s4QtskrA0KsGSjGATm3K+hhEDSCj+MB6bDD5QnzKeyfGorxoppsvQZhG6GmSrUW04zkY7dAL8pYG0FocQ0u7pc9qQNYmF5vyU9DA1PIv8kt9tFoM5zE3iuro+Ebxe6uod81lNVa1vRXILgDWT7r8I+rqBL2XfVNZ45dZ5/0FboG2hjwD5NHHOCNZeU3kamPBsnbbZOOCm4azEPuZ4srLpvDhAxGolENq+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(3023799007)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvfrdFGfprTLCxmFJEJLlI8rZE6kXxdgKTnk60pf1J53br9M5XUaHwH/0MMA?=
 =?us-ascii?Q?trRlRV0vqgcGgfYJKBusH95Hn6Mfac4uimknOkDiQeI4flNrKk09ozGpX7+H?=
 =?us-ascii?Q?LfvN8ts+cCFSdDGN/fPle039jKSf7xrw+4Yoq/OdVm5OokxKItNNy+Gawuhb?=
 =?us-ascii?Q?h8N85lBoJrjG4oK1FgATUPzSzaU7GKEdeBkEijPbUxfP2CWaIWiRqfLg3L7t?=
 =?us-ascii?Q?blAtcx4GtA1b3ZkVdFC/jl5TO2+7ztk8uFlL0xV3jCYgJPBnbA5jboqxgsoK?=
 =?us-ascii?Q?1oWyUtKtsdDQCf27AfJ7tOFgyhVu3hKdlvh3ZAxrMatbFTeBunpKKTUsvHO3?=
 =?us-ascii?Q?MeBxVVaOFISLvG24GreL50/nBSlevGSS2HYCw4IwZ3j7EVi2IOubd593I1i8?=
 =?us-ascii?Q?SRHdtu7mjyEOO/wiE2GfKZ8Nfunsh1aAfJ38nPfsOdwvNyOSZIHde31BLNWz?=
 =?us-ascii?Q?JqhK9UZ0QG1AFBzMnQwCXtj/33PnK8sR1T8xNUWhoVneCQF+HEtCphcUu1oE?=
 =?us-ascii?Q?G2+wRJry9g8PPhYCgzW3fpzyHtdZZKmX2bLz5UAdzU1q90dVC7AMzin6IE26?=
 =?us-ascii?Q?ErJbPxNaAYow6+MmDg9103ty9VQ+q0aMr8flU0vdal9sz/T8/l23miAA4g+z?=
 =?us-ascii?Q?wWEIUg8aP6gPdaQZoTeQeH4Ur9dVPPD8re6VjGrM/Hf17w5TEI6HmXybV6Az?=
 =?us-ascii?Q?Tp56ASpmzWFQAcWo0ifOqY46JIXSLYKer5TL354UxDWsfcrzQWcxxqP3C2ED?=
 =?us-ascii?Q?n5J+TYdP48gWu0lV5lri//R+h/mdMnOPWXBu383EA4QP8PKpnS92y2gL/dx8?=
 =?us-ascii?Q?sjVH1Ue2CUr7Q2jSIRW6F0ZzbDGimB/o4WD+FpsxRiwc95nr4KmU/y8cSJue?=
 =?us-ascii?Q?c+0taj6c8pjRh9EnRP3y/l6b+M3i90T7xPFaYID7VhrYymQb/YQG61FDYoWy?=
 =?us-ascii?Q?zSAdabVKvZzYHkVx+Ln2T1osLSKO3iBi9cl0atio3eXCWRe5WPBIFn+HG8+j?=
 =?us-ascii?Q?QBtEk9HzgpQieZu6q+zTY67GaFByq1hHmKd997uK8eO7liqhucbQmRkie4qd?=
 =?us-ascii?Q?Ac1SloyXHDVtoi8OSYuiQ4gP26QT+pUct+8JSnfR11NE9NjW6V5o1YM4isTX?=
 =?us-ascii?Q?5YxlVcPtPhckVjhV9ld34OCmRCFua0HUBcry3z2DWWjdbzKRXzzgjpe/091U?=
 =?us-ascii?Q?ZrCBL2qO1gFJN0Kd6UWhPZikOyx5Oh2BwelKYPvxJKwxS2juNTHB+q6tUutf?=
 =?us-ascii?Q?v1ENrh4tl/UwaGQN//1QjiZgPyoGvBQLhWCibxzLB7F9zYzage0KYOe02s/9?=
 =?us-ascii?Q?wCL7laIKQMtTEVGHVEENfAW2Vedl4UTP89Puu4FPMs3Ofm3zQf5qTmskQbrX?=
 =?us-ascii?Q?8GgQwZbw2Cl98kb6qop0dbAcxcxS1GXnaD0cq6MyBvcR/zm3HDR1kzRczq+4?=
 =?us-ascii?Q?r1CWSO+iyDhNyPHH+PXm5wFlAAPppx2zYJjSwR6a/159v4IzJ1Ijm1r+MFRR?=
 =?us-ascii?Q?ZecmNyEzz7cbbbdpLn0Gu1L7xBc8DbBXTtMES1HlIIUan1nUQCTa3M16BTL8?=
 =?us-ascii?Q?U6N/0BbbfQ8RNxDlZz4//W4iVIaaRoXyBXghNcTzBFASOBFfo868XzVqvFew?=
 =?us-ascii?Q?Jw7LLQWkGUfoOKvmMFvWcnY0NRkiWWbDn/LSRrze6qTYfJcjKg7DrU90gnK9?=
 =?us-ascii?Q?AjfgqWq7ezTM5BIFJpr8XpIggQnA4H+KB5FijENjAUo5InvZyXWTxDBy3TdT?=
 =?us-ascii?Q?PfQIYrQIeg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fa769b-ec73-4072-47ae-08df1f9d97ea
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:03.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEpvNOFZlrwk5Nf3j5N96x89vpmpTM/sT19KsVx6LD6jDy1lBV77ji8uto/l+kRr8e50U2atUKABPIVKi0idDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
perform supported writeback, drain transactions, prepare the IOMMU,
initiate reset with Memory Clear enabled, and wait for completion.

Observe the 100 ms post-reset quiet period before polling Status2, and
treat an all-ones read as not ready. Treat Control2 command bits as
transient state, restore cache policy on exit, preserve the primary error,
and abort when IOMMU preparation fails.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c   | 252 ++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h             |   7 +
 include/uapi/linux/pci_regs.h |  14 ++
 3 files changed, 273 insertions(+)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index c3f53c1b93fd..94f854520a1c 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -8,6 +8,8 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -443,3 +445,253 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 	pdev->hdm = NULL;
 	kfree(info);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+#define CXL_RESET_MAX_WAIT_MS 20000
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
+					    u16 set, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl2))
+		return -ENODEV;
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
+	 * that remains set in the value read back while updating persistent
+	 * Control2 state.
+	 */
+	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	while (time_before(jiffies, deadline)) {
+		usleep_range(CXL_CACHE_WBI_POLL_US,
+			     CXL_CACHE_WBI_POLL_US * 2);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (PCI_POSSIBLE_ERROR(status2))
+			return -ENODEV;
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	}
+
+	/* Do not miss completion concurrent with the polling deadline. */
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+				  &status2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(status2))
+		return -ENODEV;
+	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return rc;
+
+	return cxl_reset_wait_cache_wbi(pdev, dvsec);
+}
+
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+					      saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
+					      PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, CXL_RESET_MAX_WAIT_MS);
+		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+	}
+
+	/* Allow one retry after the mandatory 100 ms quiet period. */
+	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
+			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
+			     CXL_RESET_MAX_WAIT_MS);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	for (;;) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	}
+}
+
+static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
+{
+	if (initiate)
+		return cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
+						      PCI_DVSEC_CXL_INIT_CXL_RST |
+						      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
+						      0);
+
+	return cxl_reset_update_ctrl2_no_replay(pdev, dvsec, 0,
+					      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+}
+
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+		return -ETIMEDOUT;
+	}
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_clear_memory(pdev, dvsec, true);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
+	rc2 = cxl_clear_memory(pdev, dvsec, false);
+	if (rc2)
+		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
+	rc = rc ?: rc2;
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	u16 saved_ctrl2;
+	int rc, rc2;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		return -ENODEV;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (!rc)
+		rc = __cxl_reset_execute(pdev, dvsec, cap);
+	/* Restore cache policy after any attempt to disable caching. */
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	return rc ?: rc2;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	int dvsec, rc;
+	u16 cap, ctrl;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(cap))
+		return -ENODEV;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a1c63e031dd4..9904eaed5af1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -6,6 +6,7 @@
 #define __CXL_CXL_H__
 
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
 #include <linux/range.h>
@@ -206,6 +207,7 @@ struct cxl_register_map {
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 {
@@ -214,6 +216,11 @@ static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 }
+
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 /**
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..7224857c7b30 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,8 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
+#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

