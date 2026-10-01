Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE994F85CB;
	Thu,  1 Oct 2026 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846602; cv=fail; b=kJ7W/PRVV4AHlIbr+N0cY4AicAptGBFrEnWBDd2+LBtAARm8gXmBYfKNEpOhX4Td1s0rZa4D8YF4xOckbtUgLLxJBAmW4RNTPbFpRUPs5Lrs24pVB8QiwyI/VHj4k1LYqV/MTlsLBb5OWxm7tiQFBopGvbuqHh8fD0LmfCPvdFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846602; c=relaxed/simple;
	bh=n77LN/pJHXoNfDVfyvip53huMu+bXCoTPrpG4KI64Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0JokQFNf/Lug1tsSK5Dgw+1KNV9RYt26sZY3D5h9XcKQqWCLogzMoj74ZyJ6BVBVYnVgP+tOLVrt8G1gMmWCRkKqGP9Cdg68aot9ZtpHsWWhkn10X2nAtWQeWDNkJMpHJiY2MPlwbfiV4Gy6yIFhkrDLa2k3sBEDWB0E0NW6UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dT6FzeSI; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dT6FzeSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpOu+Krk0QrrqT9PHb/JVMM0nIXUk5pIHWFC++9m4dYhF99raHIhpziP02SnMbbPYU7zkzYoqQPwc1qNOI+AmqBCvzP7X9PsSCDyfsmbDWaxCHpbyg27jyez9iUHfd1Lpmz+2sRuKsfWLZLdSQU76wuydVbCFLyQUkYm2dZPSYHRkzyinjWOpgnMSBZeXBOAgwA2XATOA96/SDKXk7Drv9GuIgdauBA3xgyWS8fjrTSMC+LJMz1QmUYrM3Jeqp76U4tIJApPIk6WmwOJU8eApVI5DFhjbxOZ8CNG6nlHHVh/mAyB/w0WQLvgg3IoMvzU0aMuaT3bWfBONa242tVQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icQDELAa5aJBY82+uRawyhmZuLIRsBxGA/BSdgWIV7Y=;
 b=REwMqMq4mWDDcb2I83Bnrf3PDg1s3aMvqnL744++M29BnRsm6sDLXX2/mpQCj6S5gFXEMFGMKCCCKfIyOPVKjxHLYeBm7GpjMEWd19xF2KsQ39Ui5G+65yFLBMPUz3Q8H/p5fWA9lG+oVnV7mfAOkT4/uYIr3sqULqixD0HezyPL4m24nT/Ej6gdPTZ1eGJepxInO8rqpjk1KU0gJr9oweObP0oZvSPdcwoLGjSNA/Y4ZN6QKwusfTFP66mbu0Az6jA23z8VZsQ/uPI4f2xzeta1PtJA2uRNEYm9jLNzThIyJLcxMPkvmazhWRy9eD1p4Aqv8SGOeB/qdL1t/EOhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icQDELAa5aJBY82+uRawyhmZuLIRsBxGA/BSdgWIV7Y=;
 b=dT6FzeSI7uaOBYQp6Uig7SmUv23xkqfldLYp/eE5LhQ8EysK+tK6o4s5lZAjdKeb3jU/2BLTA4NzrZSW8LTOoV0GdYRu6Alv4DcaU8IVJ7qbGUm8M3TPjBORchjGRBHPF3u5QXs+iZp8SNJmX4k5mn4Ed9Hs2/B+sJkoVHD3nqcqXm7wud4Shs+WFxzs/dU8mGMKc25Sm/R7vhWWhjCGDl+iNK5BUhzUfGZjP79c+xLSUk6kDOlnMekVkSTdzb81YkNPRuVYXbs1nr96k6uBFwYdsfRzrrG8sjbHrsPZvcBfNs0DSi2yZqrviQw/Lr5Vav8x3ytkYBVkqqf71hZAZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:15 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:15 +0000
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
Subject: [PATCH v14 15/16] PCI/CXL: Expose CXL Reset as a PCI reset method
Date: Thu,  1 Oct 2026 09:22:26 +0000
Message-ID: <20261001092227.3004747-16-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ace661-7b07-4efb-3b63-08df1f9d9f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|3023799007|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1gXJRxuT11mnZHVw9QnHZO9B2m32raKM2L9+KVzABsLP359j3qT8Uk0g4JUXqN2TH9Nh9dLDRd3oXUQsRsH2C17nKVzgobBp3rj+5FaUlT4OcDHyqhUohMny+k4hjdY/UAlui6zsbi8tk4b2JZ47UveZXt1J20V/lB7NELXSRB91LLvhx6+s8St4sqNxbK2mSB1XjP3f0OQFm2xGpFcfyhAKQ4FM2wdZJ3T3J4ucWdZOKTUHpJ2MFd7bub/fB57v+pjvEK4gOfgxNQryjYDyijh1A6w5604Jkh8WB1LX84kLj4pvb0DYc/HZ/a9SgyH3j1fIYMsDIxL4CF6gtbkQ/26yI5T9g7p18AgzJU+NLwz8EyK5itWvhszIRueruuprSMMGh778nhBQJH3A74Y1Sk8FGCqdhxvY9anjtk+BDKmZkCLnmc4/EQe3zNnGkNgVJF6/l6kiVoj/ktOJTp0+HFR2Hoak3r/LDvQdJWB7f2wSSljI4E4g6uQ7bL0PIfDasYCMfUA60PfW1npSDX4kLFcbmVhbD9oyvFzrR4DA/78mX0jm8BU1rb9OE0lGGlqIGwvF31SXQB5nvCzCO5hpR0QKJY3TY0eJY8F2P5XMSJTLnQMb9GSIL4layXjw4qVTcRp+fk7fAg7J4tPxg92EKpS3fwl9TCf/zuaCJu0t0XDvbtg5ckZpOYiDW2uj+GqPqU8nR8iNMy/78CygeisXqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(3023799007)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6NfPbBOCsorMTgAm8auGl4Sukhp77zdZEsPBonTZys8HhAghrYX3BWujZPu?=
 =?us-ascii?Q?sK9tub0mfbbfqsQP4AdCEe89yqqXqOmWt96qjSm+zj8OK7OcFKVu+sBU1ju9?=
 =?us-ascii?Q?4Pm42PyvRPg2QQRfbEZjlBjs+yMqb4OMW31pQGjMW+N7kG605yIflHzSFxuh?=
 =?us-ascii?Q?ribbC7VMUV3Y40WQgYbjYVJepJFJAH5TWBG21Bx3vUpp/FnOF/wbI6Q2U6wl?=
 =?us-ascii?Q?wrfYpZNIuASvLSyjwZJ4u24+MeMAcsNrmDIOvj8HAxMfsDw8wFUjQPmPrt2p?=
 =?us-ascii?Q?GkuB0Bw3L4CaZvhKhSlGGsw1q/P9/Wb1OEVCIwgE4cTb3aPNENUcZSU4/aI3?=
 =?us-ascii?Q?m9sEAJF62uAxoQmJaTYFwckooEq9VCnZptfZyil7cVSl8gGSkANsQ+wu7KqF?=
 =?us-ascii?Q?CYJbGu7OmWcZwRUlM0YeH0CJwr6E15LkJro6enVM7dNQPKc9BhM7FODY/D1v?=
 =?us-ascii?Q?t/5gWurBds4tC3FUe/RjR+AUnLaHZEwM+IC+6VpdlU9Brly8QlqkQ6HnMxLt?=
 =?us-ascii?Q?xzQx7tZpxoRhjcTujRFI0R68TGmE2a/LWlUo0X7GbP1OY2K8VoZ5dVkyd0BG?=
 =?us-ascii?Q?1PP/FDF0Cx5y0XYWACatsu46U035KW553S2umstBHnPAN/zg5CZNM19f+EWL?=
 =?us-ascii?Q?YmBc8ZnY1LuzUTBQrsOld4mJg1Lpp76Qt4CkoQNq6xg1qvjKbeW2a6uXK2UF?=
 =?us-ascii?Q?casVV/ekVvsGZG23DURu0SDbXRS59bPQ03Z3JMNB4S9+b04WHPEwZ6952TNi?=
 =?us-ascii?Q?j8SklC9TO2VITnv67CR6Ia7az4TQMwF1TApGTHJm9wPIxXz79Xp31XMBkvzB?=
 =?us-ascii?Q?rhMq0cUAs7BFRJ6ZUPTYN5DYEvcLIvtMmQYbGGeDFRSaWiOImaarKv5yqO9m?=
 =?us-ascii?Q?0toZH2Vp0B+CQI3gMziNnkNC34i8pq3pboQ3bVtfWLOsQVw7KqAW6gTWKgdR?=
 =?us-ascii?Q?vsfgv/CDqAr7Rb/Y4cFVdb6Uu/6Vl4BbRF3ecwz/mKel9dtGNgmFc+k1ranK?=
 =?us-ascii?Q?zjAkQXdIuhPgRSmrYxt9tdJrB3wBUQzZGIgODIjPNndQUav8GWAYCW9UpAHh?=
 =?us-ascii?Q?wrxJARK0+6d4tNx95jgSFfBwAQP28d0rioOHOEo4byieEyyryeh5kcqJUJD6?=
 =?us-ascii?Q?/uhTcQfuglt1L+yCznI0vakEmlWmRfJEWdtcdUuqCljRKe1lsYJTLapjfWYz?=
 =?us-ascii?Q?kDJzXpEBvxCHNu6WNyIBbDzFCMyx5V8ZNgzxcanR0YHTI8f0M0WNdcnxPUJd?=
 =?us-ascii?Q?UpK+osB6eD1/8VFOxpGUQgM4f3P9+TF5ktlbUHkPxzAXrh7hXgubG1itIlAW?=
 =?us-ascii?Q?b0T4Std4MmxXzvyV1NZisu1KnTQfgYRvFRpKSOmKCAtvFQvuB3LZeOnoDwEU?=
 =?us-ascii?Q?2KNYP1mLYEQUL+FMxr8K08pyCXO8/IdkxRnGn0ppfnuUQiBYliRXRuf+4bE+?=
 =?us-ascii?Q?UnPYCZ9tFOgnQryDaLEiyZLmWsuRGHG+GBqAjTrOD3zHkE1GYqTQPpm5cFxm?=
 =?us-ascii?Q?CRNNbvpkrSt97ZbN/D9f4fcBN7NVFkPSJa9BeOLPW8qksdlyqkmKus3bXHZQ?=
 =?us-ascii?Q?edFa4GXTVVVqUCnBnWWIaCnA7nkJUo+WjfjrHlq+hHobFFYfVmnzMoj6xUQn?=
 =?us-ascii?Q?F103rIGgAkLahy4FEyuvjCdoDQMgDeIappNifc1yxA4s85PW+yunK1PbFXZl?=
 =?us-ascii?Q?Nk0XQ3BkYJLNfnefjvA6KX2iO7SfxzgFs3Mpn7UrWCCzrYs0yxiF2o2coYfW?=
 =?us-ascii?Q?bj28rPduVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ace661-7b07-4efb-3b63-08df1f9d9f12
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:14.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bQh1dHw9wdPov1acVt6PkXlYbRkwFYxB7xi2Hzo7kPqIAuQzKC/2EeIpJssvNHW2RAVAtnjYFeB4ONUDfFfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

Register cxl_reset with the PCI reset-method interface and place it before
FLR, which does not reset CXL.cache or CXL.mem protocol state.

Return -ENOTTY when device capabilities, function scope, cached HDM state,
or required cache synchronization do not permit a safe reset.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/resource.c | 8 ++++----
 drivers/pci/pci.c           | 2 ++
 include/linux/pci.h         | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 0acc471d0d7e..efbab341b30f 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -1264,9 +1264,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(cap))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
 	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
@@ -1275,9 +1275,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 
 	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
-		return pcibios_err_to_errno(rc);
+		return probe ? -ENOTTY : pcibios_err_to_errno(rc);
 	if (PCI_POSSIBLE_ERROR(ctrl))
-		return -ENODEV;
+		return probe ? -ENOTTY : -ENODEV;
 	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
 	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
 		return -ENOTTY;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fe611340f5ab..dc57a202c91f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -35,6 +35,7 @@
 #include <linux/aer.h>
 #include <linux/bitfield.h>
 #include <linux/suspend.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 DEFINE_MUTEX(pci_slot_mutex);
@@ -5148,6 +5149,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ },
 	{ pci_dev_specific_reset, .name = "device_specific" },
 	{ pci_dev_acpi_reset, .name = "acpi" },
+	{ cxl_reset_function, .name = "cxl_reset" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7bb37fcb556d..743b57ff885a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,7 +52,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.43.0

