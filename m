Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A97202C48;
	Tue,  3 Feb 2026 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087193; cv=fail; b=E/6ghfJuOIJ+TeZncy+N8w4WjbxBAsKrFBvB/xMSnRfsiyD4c1zKyZ2f/upwCSJvif4uKW8mKPqXUALpb3/DkF9056MJpc8mkkIDn85T1elXpIB/gvh+HGOJWe6qjQkUIc0ajO2SSnqK1tKc0K+ysXvxcv+9Fjatkzg1Lx0L5RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087193; c=relaxed/simple;
	bh=DlBU/8kG1VMH3RQYfeq2D8goyacgKarrPw6SDGn/XmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+cxdxRPwfbeKeJTyfPWRlk1WPcV0ObWjwgoS5KZVSshu5vYatS5FP5pYX3IujDeVs1IxyZmPJy8cxeVTfAZxI2g2+hTDfG+vxrhdG7B61ePkbHfV6e2xzcUBsXjRAYvEQ7ZvvTDIaCCGSrWBtNIrE3OeEj/EYhD4nA812oS3S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wEPRWzMe; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wEPRWzMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATuJ+Hr/AgrJyoo/X+VH4pZ33693RWcFHSleKFhDIsr/kjtSH49UieJ0Edjdro9r4zc3EuYaY7i6D9NtwWq3lQVR7HGKXAgHJ1VUkd+qGX8PiW7+relFNqrEZ0euQrsGj0Ym5Hcp6UZ+q8SQV3JvAQ69xeqNSgmgA7iY7U4QQhbh+w+2hQu/NSj0ooNb2Y6i8+1zbhgyFuzKRPLWvvqDk9NoSJaPn82rt3VhCkcFMHV5ctR31kEMx0DCBb/EkY1NyEvjcYZ2brnaEBJPTIObLqtz8yccjhvGZcufcVplSGCkAuIzrMeVWiCVQrSfOm5TKYOnOYzZ8myMt7HNs1s3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiffkvD88E6KSxAXL4GywZDaYETpvjFNrGW7B76LMeo=;
 b=Qz1/glrOd0qSCwYeiyO+W7U18MNn9qJfjjMxxLxBgBD/8DdV0a1zOjwyZ7TPZXei/CYyi92al2euBWHpvIy67/YijCWibHfliop5cfy/GvaL5tIzACyGI7pfQluMY2V2P8f3DhW/1Koilk0fed0XOvsJ2Ka4HSefej5DudstEyvuTQSu8eckVNff/AxCEiMFLl+h3IwQIjKo2UKUHZaBuLbaHnYH5nMzhtwp3y7Gfod0kq3dd2NBt80NSdWY/ZvPuyhCPkoxLUw8l38d6GWNhmxxj30nnGj6QKxUYmewlDuuia6n29qovT4MYvQulVWs1nLwdreNp+ZT98Uxg0tkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiffkvD88E6KSxAXL4GywZDaYETpvjFNrGW7B76LMeo=;
 b=wEPRWzMe9K5jZc17IXYesJGXxQtMSElZbCykli9S+A3Oq7VT2ERvPx8riAmwyyYRBb+VyRNyAuC9r+gExoIqOWao7KmPhXCWy7B7ZGYOT/54j3C4UYrfdXBThbtBctLPuEDzAH0SU3filPrteAolt7zBLwVmmzkMxoERX/QZPHs=
Received: from BL6PEPF00013E08.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:5) by DM4PR12MB9734.namprd12.prod.outlook.com
 (2603:10b6:8:225::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 02:53:07 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF00013E08.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 02:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 02:53:06 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 20:53:00 -0600
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
Subject: [PATCH v15 1/9] PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
Date: Mon, 2 Feb 2026 20:52:36 -0600
Message-ID: <20260203025244.3093805-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM4PR12MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e30885-26d1-420d-d2d3-08de62cf5b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1aHIfTgQcS5MpdKvA/SyO5/ZPAIVJa4C6zabUNKDN4q7bwI8rYcmKAk+3Z+?=
 =?us-ascii?Q?W3/sJiN8qhl6B6JQB9EHHRA56Flaxcgxw9iwmCxwQMX63PN/JlzEoEsBn3We?=
 =?us-ascii?Q?ZctaT1dte4YRfICwZyXaTIJKxeq/oL0AuwnhVFTXloQnOq8CSw7X526+sWzE?=
 =?us-ascii?Q?w+sgtXajB8S239OvMN/RgF9lrR8XAzkNY0KJ7CLjqJq2sPxR06IsG1sda3tU?=
 =?us-ascii?Q?vzRs75LyBAk8l5+Me7OZdPF85LQpf6aHMddqklRdNVJRMxM3v6QzCFwxW/BU?=
 =?us-ascii?Q?BaUCPdQh73c7s2+fT6wgFRnYaNwUmBm4w9aoMV7LevGJQW8ptnsxNzTz86rG?=
 =?us-ascii?Q?TpzfntGzgKgAqrvSrZQVENUJJKe/vjqdTzc9aYRt94QGiau+ViiyMVB8SmeK?=
 =?us-ascii?Q?Ti2HB7qT0jdBc3yuZ+o5bcdDTQUXmBHAOWrZYTITenN0rsPRjSHQG6gUIwCu?=
 =?us-ascii?Q?ertz61kmCgDoLsZWiUChJHUfVbbgXi7NwCdcFKdL88B7qhCHnkHIDTnCn/oy?=
 =?us-ascii?Q?2cFVmlrUvYW8HbVHAqTf5PlMj1YQwCPnlLUrxnQwiSpgIvZ/6SmmAXOJg9ki?=
 =?us-ascii?Q?ov1RT8C/FCwCTXzJnI2Bs0vx9BDGSNCDqGMryQPk0pbu5Ub093NkW6VFIfSs?=
 =?us-ascii?Q?mGjnmav1JY/3xCFD4roYJvXkfHxbMttkO42m4uK8OEr2vMT8VnfF0Pqcc2VH?=
 =?us-ascii?Q?LlGSVUIEMcWrYbpUTIlkPFyQ/wOTkHoUAUVrgDDPkSTfl641mdaaUrsa51JK?=
 =?us-ascii?Q?1QK1TtSLg+clXsrNLDc+VMxFaNjtU5APVIHDt0fxPWSOqYbPO5KAKRlQdr1O?=
 =?us-ascii?Q?UIzLWuF6ZlQQQRbu1BytrTugK1rAUGpx2vlzvZSKVJPcCCnFN2ahrIehsMjV?=
 =?us-ascii?Q?UGGAW1czFhoC56sgK4JVfpNz4RDAyKZmB8+IjHGZtrVGF9Upzh5PX1kt1/UL?=
 =?us-ascii?Q?CWW5zs3iKo7zaOixGTqY20vqFwNGEWpsBPDLBn7Px4s4rosMyGrePQnDrmHF?=
 =?us-ascii?Q?avfv6dtthFCYm0kskPn6pvmBWcjgqLCBmscKlqCdcK88/50sFFLD6HahM62H?=
 =?us-ascii?Q?Vs0cOWl1WlGB2cPDIzjRRw6r00bxEbtKNtNvh9vyElL7Cpn+MuvdfhBXMd6Y?=
 =?us-ascii?Q?JHHlKfHPqoTrCEGO/5G/MOikBwWVYZjR0jwYJL+ndG+iWSssaK06zycz/PXe?=
 =?us-ascii?Q?X2x6j1XyuHh9nvx3kzqf1R/YhHweRlSPRuulL5QIkiahK3U/ay43EwiVwaOU?=
 =?us-ascii?Q?y9Z/HhDJ9Ef0cAeTFoktJVUOlisKTX7xzTy2gLnxzNwtNVBh+eK5IboyByGd?=
 =?us-ascii?Q?vBShk8NXyXINGRgFqsyHbB5kd7/c7x8swXfOs+5IM7NKWy+cj+GupQPkHjmJ?=
 =?us-ascii?Q?AlCc2JE6v4vkTZksXz1zwMeG4VoiKTvHHnuoL36HgLHDq+IqPi3djK9wShTE?=
 =?us-ascii?Q?8iOFinmjJ3PtE5SO+HT3E8tP9qT/nWF8hhOtjIaSPXtOtYct0lCchnlrasb4?=
 =?us-ascii?Q?Evu1DOm8YWVrbaxsx1uGCthUUz4ZZgQnVZzE34XFrdwmsAnud3f1048NU3Nd?=
 =?us-ascii?Q?7Jck8DVUzSJ/EynV/5goF9SQry1VkwjJ8cUPVMg8Jd1q6PatD1GHCiO/ksdt?=
 =?us-ascii?Q?6wfE/8ugYblnjYHiln6B66Zwk9Ogd1/S/+OJsRdFBvVGLb8wE4MtiDWujk/U?=
 =?us-ascii?Q?8fIuf0jNhpSOBNV9kf21O9lCIug=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7RT5a8/+0laJyW9Ubqbg/QMIKmOLE3avDt5MYdfYIqLE5ipoEvDk+mfw18atRXzS1MXAw8G4STSs2yERqN/UekI+d6MGhYAgvx3Tm1sCv/C3rtGsGz1vuSI/D7N1775Evw7IDbM+rQUewGeOwW7vMig0i59VJobtj6YfKEmpsCrS+HB6LzoYM7TjXH8/IXjKkZZjS76y63DGyc2HapDZzlb1cGLhCOaRQr9Ezpl/5KFOlHQgjCeGvcQ1SK5c9qliPNBhnOP8eAdKZyjca/wZekM57yo+diXqf1D7y5Xp+fvihOI8dOQZc9BKFrR3OjD30ARLhL8d1ScXvPAHJ1quh4XgRwpRM8iunVMZ97suwzDUrYqmF0GD182kh9JYmY8N4jJlofUvuyICzwvGSim89vSjBLQO+Skxbf53XVWpw+pTWdxjpOZkFPozgiLc57H5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 02:53:06.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e30885-26d1-420d-d2d3-08de62cf5b83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9734

CXL virtual hierarchy (VH) RAS handling for CXL Port devices will be added
soon. This requires a notification mechanism for the AER driver to share
the AER interrupt with the CXL driver. The notification will be used as an
indication for the CXL drivers to handle and log the CXL RAS errors.

Note, 'CXL protocol error' terminology will refer to CXL VH and not
CXL RCH errors unless specifically noted going forward.

Introduce a new file in the AER driver to handle the CXL protocol errors
named pci/pcie/aer_cxl_vh.c.

Add a kfifo work queue to be used by the AER and CXL drivers. The AER
driver will be the sole kfifo producer adding work and the cxl_core will be
the sole kfifo consumer removing work. Add the boilerplate kfifo support.
Encapsulate the kfifo, RW semaphore, and work pointer in a single structure.

Add CXL work queue handler registration functions in the AER driver. Export
the functions allowing CXL driver to access. Implement registration
functions for the CXL driver to assign or clear the work handler function.
Synchronize accesses using the RW semaphore.

Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work data.
This will contain a reference to the PCI error source device and the error
severity. This will be used when the work is dequeued by the cxl_core driver.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v14->v15:
- Moved pci_dev_get() call to this patch (Dave)

Changes in v13 -> v14:
- Replaced workqueue_types.h include with 'struct work_struct'
  predeclaration (Bjorn)
- Update error message (Bjorn)
- Reordered 'struct cxl_proto_err_work_data' (Bjorn)
- Remove export of cxl_error_is_native() here (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by
- Update error message (Ben)

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
 drivers/pci/pcie/Makefile     |  1 +
 drivers/pci/pcie/aer.c        | 15 ++-----
 drivers/pci/pcie/aer_cxl_vh.c | 79 +++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |  4 ++
 include/linux/aer.h           | 22 ++++++++++
 5 files changed, 110 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..62d3d3c69a5d 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 49a4bd13c2d2..7af10a74da34 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1155,16 +1155,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
  */
 EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
-#ifdef CONFIG_CXL_RAS
-bool is_aer_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-#endif
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1201,7 +1191,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		cxl_forward_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 000000000000..de8bca383159
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
+
+#include <linux/types.h>
+#include <linux/bitfield.h>
+#include <linux/kfifo.h>
+#include <linux/aer.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	struct rw_semaphore rw_sema;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rw_sema = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rw_sema)
+};
+
+bool is_aer_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_aer_internal_error(info);
+}
+
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = (struct cxl_proto_err_work_data) {
+		.severity = info->severity,
+		.pdev = pdev
+	};
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	pci_dev_get(pdev);
+	if (!cxl_proto_err_kfifo.work || !kfifo_put(&cxl_proto_err_kfifo.fifo, wd)) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo error");
+		return;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+}
+
+void cxl_register_proto_err_work(struct work_struct *work)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = work;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
+
+void cxl_unregister_proto_err_work(void)
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rw_sema);
+	cxl_proto_err_kfifo.work = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
+
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rw_sema);
+	return kfifo_get(&cxl_proto_err_kfifo.fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c84..66a6b8099c96 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,9 +130,13 @@ struct aer_err_info;
 bool is_aer_internal_error(struct aer_err_info *info);
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
 #endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..f351e41dd979 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -53,6 +53,16 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @pdev: PCI device detecting the error
+ * @severity: AER severity
+ */
+struct cxl_proto_err_work_data {
+	struct pci_dev *pdev;
+	int severity;
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -66,6 +76,18 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+struct work_struct;
+
+#ifdef CONFIG_CXL_RAS
+int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
+void cxl_register_proto_err_work(struct work_struct *work);
+void cxl_unregister_proto_err_work(void);
+#else
+static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
+static inline void cxl_register_proto_err_work(struct work_struct *work) { }
+static inline void cxl_unregister_proto_err_work(void) { }
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1

