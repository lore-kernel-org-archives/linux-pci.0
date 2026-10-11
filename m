Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01FA136351;
	Sun, 11 Oct 2026 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684911; cv=fail; b=jLJzXuy7X2OBaQ88i6qMaAMgWb8cG0ajuSOCsqHjjVMadzAedRZ5Y+NzdqrIV4pNjZ2PsTViwvmYaQiHh2GTvwuWNVGAr0cu5YASKZBhIDrTbGXl8EMOMVfmYDB6URa/yOSY0qE+LxWDr1L2hn3IK3fCeA+AN9gdP2buTLiRMCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684911; c=relaxed/simple;
	bh=ofVRFfAoibX2IJZBg/DPoVmsi/mnGN/uDdcF8uYvxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPF1VPW/JSNIeik86pb6oft+uFbabQXerJKXAJVd/U0bwv7n8PxEF6Uo7Zonn7+cBLP3lt0YCeZAvdf8DA4OmzWo46W3wNWkdfpfRpT+8+6hGJbK7py8s7tLsJWbydHzEhLIMRgB589s/AxGpVAq0uNvwsjme3fKGJ8wTE1MLrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qQ2VXAOQ; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qQ2VXAOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHdygxqKMQmM2UXMYkmcPnErEzgWDueX6iIaCNFd4EYjtEpIeWajx225cYhE0dDlkI3BMx2iya4OKMIa4ssu60qRgsLvWfK8/L4jypp2s0GmBU7InqE4GP1ps1CqAH8KPV5qN6wy1/NsXgV/ftcsNIM901ouoquQlSIxT4mgylDzk1irJUraJHZ+1ifXXDPi8iR+LIFZDkCVHvzsktAHP+hViT7r93nnGbUwO54Pg8OVpZN6p4F5ZiR5gofcqcdAZgMtE6Ukn7SUkdT1dhMgYnvxlKyU9/vr7ThAZ/eDZwKfSU4NJaRyM7NPxkETXFLkecD+eNeX67ccZ0fg3ni76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jgi+PadHjtAfG0kyUX3qolZVWXyHReqEQThuirRGek=;
 b=nE13vNikvLNXAq4OLVVvaNQnxeya3DxrheWM4AC9pNmlMaUpvZE6cO3o3GqfHbdqZC07H21i09ufEL78+hVSiGnZlrpf9zrdqa4vjaOg+iQ37cVZkpEMbf99LWkVdaDymhW1yhK2c0ew/eF9pbR4YXVud8HLd21yAzVeyScwjrffVc5Ez0I1QrBm4zYkMTkRTZ87iQI9y2bEg68hHnfjWcce61MRqmwYN3BJkgoi8fNn2pPWj7PtIlsynSjNhcJsBZqbz8lR410qEM1iubcA589IxhWmSjY5FqazFe3J9H/+ytaQDPh+brpAwVpvMorB1Mft5ATz+0dgJeTMjflU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jgi+PadHjtAfG0kyUX3qolZVWXyHReqEQThuirRGek=;
 b=qQ2VXAOQH5ATZYSApdBuCT4Cys4Fjus8ZAH1QFZXpBMWIq4rCLWOZI8lU5An2NAgsyAkObz0tyNizLOVRHZj37uqlwXlnRzk1S66a0JTv4xVW5LVwG7x2VhpD0BmLZaIwpeGxtfdsBDIL00opDoMlRlR99bFqb6yiwyRpq8tAcYOcsssgryEtf6dsB9V8AYTMwSRuygFB2YqCj3lb1+1cGBhw7ABEE95dhnJJu71nJUPlkMI8wRTLGcRwR12KNQGXv+kZGJxe6TQSr52T38dZlqVrJLyLyzZ35HpSdAcoFN+JTVl+/vM4lR7ZDAUFXt5eX0gHIsuoRizSLAsj2+JRQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:53 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:52 +0000
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
Subject: [PATCH v15 09/16] PCI/CXL: Cache endpoint HDM state during PCI enumeration
Date: Sun, 11 Oct 2026 02:14:15 +0000
Message-ID: <20261011021422.3428136-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: ae292197-d920-4a09-8234-08df273d6f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|260925021911599003|260925021311599003|260925022911599003|10067099003|261009220027099003|261009223327099003|261009223027099003|261009221227099003|261009221727099003|921020|11063799006|5023799004|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fFWNG73carmsAUJfFtpN1qfifLUpyLeloW9IXVHMqnJdhLQWWvyCQLfGLUoildww7K3trtXyzZ+1d17UFy9cZDaqrpZuZZgzNGL4z0R/ub8/CBj4K+m3p/U4F7XjWUpUKLu+GDUjZu6KRMTYZPutWR+w3slf+5LAUfs9LmdDxOiUEgSk5IzlqrrteboR7sqSFpP9Cb/NUuknHqkY4NbmmFz2r1MqazjFpEapI1gwFt7ggDQVkUnR8AfIP4dafrCvLYEwJUoRXYRiwIIPEcmDqo1IYg+WlroFKud1ZZB6EIOAWwZr2g0N5tVxnxwpuVuVYpAxS9NVoHCc9ya+3kCQmF08KNN5b9veia4a9GqIoGh2j2aRYhi/ktA36FpPZSVmNzkAEgenwRTWOIyL0L1k/pwEv/6GcWKcVxzYced7989Y1aFtYJQjH9rCX9p6+sZkIZjgo5449p69ds1ypmB+6mxtqOKjn/7gRbXbSAK4XcY1d51PF8WR2mWi51SSpayM0EWEi9hWIOrfQtT7kLgnaesn6M8HERQ7J9ValcMwIU3URCmkpecFImufRDWX+n0/yd/Mb+bTOgovymXhlOWPGLNeXIs3QjL6m8B0x7EX+y1T2rBaiD7H9FR+qdVYJ691q4vNtduKWm4ugepAD1YIXeOpZ83LuqAECvh9s10UHtoYOnDmcmBubvWmWDFdZXT6zsn1h1Jlcujj50J2/Kgf0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009221727099003)(921020)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jg62gKRJMRCmRLRHM7gCUkh4E90rJaabNg+tKm3oTnwumDHWVFPWlU5JumpZ?=
 =?us-ascii?Q?7JiEin3qYBcjKfAuc7VA1j1uEVa3etBWwjpVcdknHiwzYSO1KO4hebtOlmVi?=
 =?us-ascii?Q?0TYHISobpesrkg0w1eC9ge8L4P47QXtbwdA8/lf5SWfaBfbI+g9l5HrJCSH9?=
 =?us-ascii?Q?VbLD2101jdIT2QOtnGBRi2aK2YBXFvzXiXURb2x1IxTIKdhWpgK2PlkEE+Rz?=
 =?us-ascii?Q?pBvY1UDtbl+VC0zE8immLwwJGAlI6cuAPDQdZvc7eGvdKXecHjQm1Ytsa8mF?=
 =?us-ascii?Q?EfVaJ/pLk7Wy+owJV+t9e+QpHyz0VuuT6+z6K5ObGbuhLndQTjV9BC7wPx2o?=
 =?us-ascii?Q?nDSdpKRgN+inafvnNgB251I2s6X7yda/TeRppxksFseCQQqKDZ/he+kcbpbE?=
 =?us-ascii?Q?vrZAkk9e+1Cbje24EhCwYMG6MY5FR4yKoHGAlSiKHEnnHXUNUd3VGCB7KSTG?=
 =?us-ascii?Q?5Z9x2olx+yR9rjQBiCM1qJ9MUWDdgNgi2911glNt2NPyA7SmnLaMPDrp3h+h?=
 =?us-ascii?Q?eajahGgBQ/ON6THQvCTw8gGlOmR8WILF29L+pWEnQ/7mmzX951eiTJ2I8Nim?=
 =?us-ascii?Q?89ecKUWCNMrz5pi+1DdQ2A3fZN13C674Ha98t52Gi/qYLbtsvzS3I9ckpuUP?=
 =?us-ascii?Q?svBKMJC3rsquELzWAOThhuZIzkPuyO/ZJKgOyQw8d1z2YqeqoSJxAYXfp3qf?=
 =?us-ascii?Q?zwBs9Lo+fgdAIA3Pce+OU35QEWp+cLXqzFWkAARdO5K82dDAmuctYvf7b4Wn?=
 =?us-ascii?Q?ajGD4b+jOyVwuIDqCCJlOKOCFyAKDYtUyc8lQiXUoshGFSKtS8CqINf3E73w?=
 =?us-ascii?Q?yFkxOZ2W7EEMz4K+Z/kRKH6nloyx66qsu8RgFJx1TXlgh5/y8ITfqNMyeSHA?=
 =?us-ascii?Q?1ArPMdkru/GU6HRHivN367KF5olFsesQzBNeBSbN365IeoCfbH6TWzJMUydN?=
 =?us-ascii?Q?OwN6+Ft+wzQ8daUZpek3017NiLAmW7LDpGptykJZd22mVi27I0Jz4nKNEQdn?=
 =?us-ascii?Q?B7WYC9BDNAQbF7M6yG+UBvonWaRFbI4guiIMoHHVNfADqVqgtclYSeb0fsrV?=
 =?us-ascii?Q?LnEW7KSKYsm3XDfBQvJZTJScJaub9TStaDBcGlod2j9xT4iyGyuXgC+rvxgA?=
 =?us-ascii?Q?fOMr2bzppojkQ2IHm4XUpQ2uDRqSpvlMLDL7HDgKlrQi9Xem9OZhNa6M7CzI?=
 =?us-ascii?Q?hL64AWzfWpgbeYkl3aglhrymZjdLrKZKjQM/1nIxLa9oDQuPOqf8ZZo4tLbi?=
 =?us-ascii?Q?F8/RTDrtyTwDgrGqbQsa9rzwbXUrgDRwckKKK8WdtDmvZigRj0AU8UfdK/6L?=
 =?us-ascii?Q?x8lgnfP8HE4my1VuZ1eGxlplJMtWnW68ioT46lUqKKrT01I2Sbb2/tX6laNP?=
 =?us-ascii?Q?ZM1hkxfFuL4u5LHfGDW7IcNXjuxKagO6tcb7d3asGkcmdWkoKW5EPd4m49LL?=
 =?us-ascii?Q?8oAEK32yTAIAprsUFJ50gcTgzY9axqwkJhiECc1mCzRMV1P5a9l31WMxBOjv?=
 =?us-ascii?Q?Iq3PWt63hzGjgjE+2K+2FbmGXh9nMCABFrSajWMqLy6P8OQ7SWCejD+Z2p34?=
 =?us-ascii?Q?fxsHsJMzeBX3OupjFoaw7Dl814vby8FzXJOhfPE+LrI43CU+GScrE58RLZJU?=
 =?us-ascii?Q?HRw58oO5zTbpAtD1Y9QbshmDq5drQDpNcdCUUT/I6xYWu6dFfpzcm1cOLbCV?=
 =?us-ascii?Q?yyh769EJDsYiJVCYEKvMdJ1hWJEN+vA8r3TdhNE7X5G4AuqrimQoIEt9h4KT?=
 =?us-ascii?Q?+eM9s6/g6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae292197-d920-4a09-8234-08df273d6f8b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:52.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0xq3OTJab4XP6WO5LfMAHA0om/OH7RTspbl3rwLKmOic0ys+AC4UzYlScfMH/SDRFCkfTDtUi87fDF5ow0iAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
binding, so reset can restore it without a bound CXL driver.

Save the HDM register location, decoder settings, and Device DVSEC state.
Validate capability reads and decoder counts, and restore PCI_COMMAND
after temporary MMIO access, reporting restoration failures.

Keep PCI discovery separate from shared HDM helpers. Move cxl_rwsem into
built-in state code and protect cache publication with its DPA lock, so
the cache remains usable when cxl_core is modular.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Assisted-by: LLM
---
 MAINTAINERS                  |   1 +
 drivers/cxl/core/Makefile    |   3 +-
 drivers/cxl/core/hdm.c       |   5 -
 drivers/cxl/core/hdm_regs.c  |  99 ++++++++++++++++
 drivers/cxl/core/hdm_state.c |  64 ++++++++++
 drivers/cxl/core/pci.c       |  17 ++-
 drivers/cxl/core/regs.c      |   9 ++
 drivers/cxl/cxl.h            |   3 -
 drivers/pci/Makefile         |   1 +
 drivers/pci/bus.c            |   1 +
 drivers/pci/cxl.c            | 223 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h            |   8 ++
 drivers/pci/probe.c          |   1 +
 include/cxl/cxl.h            |   6 +
 include/cxl/hdm.h            |  12 ++
 include/cxl/pci.h            |  13 ++
 tools/testing/cxl/Kbuild     |   1 -
 17 files changed, 454 insertions(+), 13 deletions(-)
 create mode 100644 drivers/cxl/core/hdm_state.c
 create mode 100644 drivers/pci/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c..b874340b0265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6572,6 +6572,7 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/cxl.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 6703c1729396..9a77e68d44ce 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
+obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b57257efbf4e..a0d8f6a66810 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -17,11 +17,6 @@
  * for enumerating these registers and capabilities.
  */
 
-struct cxl_rwsem cxl_rwsem = {
-	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
-	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
-};
-
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
 {
 	int rc;
diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
index b6ee4becde8d..f0b360867655 100644
--- a/drivers/cxl/core/hdm_regs.c
+++ b/drivers/cxl/core/hdm_regs.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -174,3 +175,101 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
+
+/**
+ * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
+ * @dev: device for error reporting
+ * @hdm: mapped HDM decoder capability
+ * @size: size of the mapping
+ *
+ * Return: the decoder count, or a negative errno if the count is reserved or
+ * the mapping cannot hold every decoder.
+ */
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size)
+{
+	int count;
+
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count < 0)
+		return count;
+
+	/* The last decoder's target-list high register must fit in the mapping. */
+	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
+		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
+		return -ENXIO;
+	}
+
+	return count;
+}
+
+/* Read one endpoint decoder; a disabled decoder keeps only its id. */
+static int cxl_hdm_read_decoder_settings(struct device *dev,
+					 struct cxl_endpoint_decoder_settings *settings,
+					 void __iomem *hdm, int id)
+{
+	u64 base, size;
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
+	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
+	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	rc = cxl_hdm_unpack_decoder(&settings->config, id, ctrl, base, size);
+	if (rc) {
+		dev_err(dev,
+			"CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+
+	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
+		*settings = (struct cxl_endpoint_decoder_settings) {
+			.config.id = id,
+		};
+	else
+		settings->skip =
+			((u64)readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id)) << 32) |
+			readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
+
+	return 0;
+}
+
+/**
+ * cxl_hdm_read_state() - read endpoint HDM decoder state
+ * @dev: device for error messages
+ * @hdm: mapped HDM decoder capability
+ * @info: state to fill; @info->decoder_count must be set
+ *
+ * Return: 0 on success, or a negative errno if a decoder holds an invalid
+ * configuration or the decoder count changed while reading.
+ */
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info)
+{
+	int count;
+	int rc;
+
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	for (int i = 0; i < info->decoder_count; i++) {
+		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
+						    hdm, i);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * A changed decoder count means the snapshot no longer describes the
+	 * complete hardware state. Reject it rather than publish a partial cache.
+	 */
+	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (count != info->decoder_count) {
+		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
+			info->decoder_count, count);
+		return -ENXIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
new file mode 100644
index 000000000000..9a31f5996c74
--- /dev/null
+++ b/drivers/cxl/core/hdm_state.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+#include <linux/cleanup.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+
+#include <cxl/hdm.h>
+#include "cxl.h"
+#include "core.h"
+
+/*
+ * CXL state that must stay available while no CXL driver is bound: the CXL
+ * locks and the per-device HDM cache filled during PCI enumeration.
+ */
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
+EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
+
+/* A published cache is usable only if its HDM register block was mapped. */
+bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
+{
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	return *slot && (*slot)->hdm_size;
+}
+
+/**
+ * cxl_hdm_cache_publish() - publish HDM state read during enumeration
+ * @slot: cache pointer owned by the device, for example &pci_dev->hdm
+ * @info: state to publish
+ *
+ * Ownership of @info passes to @slot, or @info is freed if another caller
+ * published first.
+ */
+void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
+			   struct cxl_hdm_info *info)
+{
+	struct cxl_hdm_info *new __free(kfree) = info;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	/* Another initializer may have published while we read MMIO. */
+	if (!*slot)
+		*slot = no_free_ptr(new);
+}
+
+/**
+ * cxl_hdm_cache_release() - unpublish and free cached HDM state
+ * @slot: cache pointer owned by the device
+ *
+ * Take the DPA write lock to exclude readers while clearing @slot, then
+ * free the unpublished cache after releasing the lock.
+ */
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
+{
+	struct cxl_hdm_info *info;
+
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
+		info = *slot;
+		/* Unpublish before freeing so readers cannot see stale state. */
+		*slot = NULL;
+	}
+	kfree(info);
+}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2acddb472103..88d25d0776b4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -250,6 +250,16 @@ int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
 
+static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
+{
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (!pdev->hdm)
+		return;
+
+	pdev->hdm->dvsec_ctrl = ctrl;
+	pdev->hdm->dvsec_ctrl_valid = true;
+}
+
 static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -261,8 +271,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
+		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 		return 1;
+	}
 	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
@@ -270,6 +282,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
+	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 	return 0;
 }
 
@@ -360,7 +373,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 * capable, there is no point in continuing to enable CXL.mem.
 	 */
 	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
-	if (!hdm_count || hdm_count > 2)
+	if (!cxl_dvsec_hdm_count_valid(hdm_count))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..ba1f942d20e1 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 	return ret_val;
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
 
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
@@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	}
 
 	map->reg_type = reg_type;
+	map->bar = bar;
+	map->bar_offset = offset;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
@@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	*map = (struct cxl_register_map) {
 		.host = &pdev->dev,
 		.resource = CXL_RESOURCE_NONE,
+		.bar = -1,
 	};
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
@@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+	map->bar = -1;
+	map->bar_offset = 0;
 	if (index == CXL_INSTANCES_COUNT)
 		return instance;
 
@@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
 
 	return offset;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
 
 static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
 {
@@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
 
 	return component_reg_phys;
 }
+EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport)
@@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 688350c7c5fb..ad4e80be2bd7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -239,9 +239,6 @@ enum cxl_regloc_type;
 int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
 int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
-int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..7a5d9f7297e9 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
 obj-$(CONFIG_PCI_DOE)		+= doe.o
+obj-$(CONFIG_CXL_RESET)		+= cxl.o
 obj-$(CONFIG_PCI_IDE)		+= ide.o
 obj-$(CONFIG_PCI_TSM)		+= tsm.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..aad567fb7c56 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_cache_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
new file mode 100644
index 000000000000..471b57391593
--- /dev/null
+++ b/drivers/pci/cxl.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
+/*
+ * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
+ * memory device at enumeration, so it can be restored after a reset without
+ * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ */
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxl/hdm.h>
+#include <cxl/pci.h>
+
+#include "pci.h"
+
+/* Find the CXL Device DVSEC and read its capability register. */
+static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
+{
+	int rc;
+
+	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					   PCI_DVSEC_CXL_DEVICE);
+	if (!*dvsec)
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(*cap))
+		return -ENODEV;
+
+	return 0;
+}
+
+static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
+{
+	struct resource *res = &pdev->resource[bar];
+
+	return pci_resource_len(pdev, bar) &&
+	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
+	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
+}
+
+static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
+					  struct cxl_register_map *map,
+					  resource_size_t *hdm_offset,
+					  int *decoder_count)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	void __iomem *hdm;
+	int rc;
+
+	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return ERR_PTR(rc);
+	if (!hdm_map->valid)
+		return ERR_PTR(-ENODEV);
+	if (hdm_map->offset > map->max_size ||
+	    hdm_map->size > map->max_size - hdm_map->offset)
+		return ERR_PTR(-ENXIO);
+	if (check_add_overflow(map->bar_offset,
+			       (resource_size_t)hdm_map->offset, hdm_offset))
+		return ERR_PTR(-EOVERFLOW);
+
+	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
+	if (!hdm)
+		return ERR_PTR(-ENOMEM);
+
+	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
+					      hdm_map->size);
+	if (*decoder_count < 0) {
+		iounmap(hdm);
+		return ERR_PTR(*decoder_count);
+	}
+
+	return hdm;
+}
+
+static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						    struct cxl_register_map *map,
+						    int dvsec)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	resource_size_t hdm_offset;
+	void __iomem *hdm;
+	int decoder_count;
+	u16 dvsec_ctrl;
+	int rc;
+
+	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
+	if (IS_ERR(hdm))
+		return ERR_CAST(hdm);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out_unmap;
+	}
+
+	struct cxl_hdm_info *info =
+		kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto out_unmap;
+	}
+
+	info->decoder_count = decoder_count;
+	info->hdm_bar = map->bar;
+	info->hdm_offset = hdm_offset;
+	info->hdm_size = hdm_map->size;
+	info->dvsec = dvsec;
+	info->dvsec_ctrl = dvsec_ctrl;
+	info->dvsec_ctrl_valid = true;
+
+	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
+	if (rc)
+		goto out_free;
+
+	iounmap(hdm);
+	return info;
+
+out_free:
+	kfree(info);
+out_unmap:
+	iounmap(hdm);
+	return ERR_PTR(rc);
+}
+
+static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						  struct cxl_register_map *map,
+						  int dvsec)
+{
+	struct cxl_hdm_info *info;
+	u16 command;
+	int rc;
+
+	guard(pci_dev)(pdev);
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return ERR_PTR(pcibios_err_to_errno(rc));
+
+	if (command & PCI_COMMAND_MEMORY)
+		return __cxl_pci_hdm_read_info(pdev, map, dvsec);
+
+	rc = pci_write_config_word(pdev, PCI_COMMAND,
+				   command | PCI_COMMAND_MEMORY);
+	if (rc)
+		return ERR_PTR(pcibios_err_to_errno(rc));
+
+	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
+	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (!rc)
+		return info;
+
+	pci_err(pdev,
+		"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+		pcibios_err_to_errno(rc));
+	if (IS_ERR(info))
+		return info;
+
+	kfree(info);
+	return ERR_PTR(pcibios_err_to_errno(rc));
+}
+
+static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { };
+	u16 dvsec, cap;
+	int rc;
+
+	/* Avoid duplicate MMIO reads when the cache is already present. */
+	if (cxl_hdm_cache_present(&pdev->hdm))
+		return 0;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc == -ENOTTY)
+		return 0;
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
+		return 0;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
+	    !cxl_pci_bar_assigned(pdev, map.bar))
+		return -ENODEV;
+
+	struct cxl_hdm_info *read_info =
+		cxl_pci_hdm_read_info(pdev, &map, dvsec);
+	if (IS_ERR(read_info))
+		return PTR_ERR(read_info);
+
+	/* Another initializer may have published while we read MMIO. */
+	cxl_hdm_cache_publish(&pdev->hdm, read_info);
+
+	return 0;
+}
+
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = __pci_cxl_hdm_cache_init(pdev);
+	if (rc)
+		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
+}
+
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
+{
+	cxl_hdm_cache_release(&pdev->hdm);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..9e218f236e66 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
 static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #endif
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
+static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+#endif
+
 #ifdef CONFIG_PCI_NPEM
 void pci_npem_create(struct pci_dev *dev);
 void pci_npem_remove(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..cb52357344ed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_cache_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index b29374b34cfa..3e70f74685b6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -27,6 +27,7 @@ enum cxl_devtype {
 
 struct cxl_region;
 struct cxl_hdm_info;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -149,6 +150,8 @@ struct cxl_pmu_reg_map {
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
+ * @bar: PCI BAR containing the register block
+ * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
@@ -159,6 +162,8 @@ struct cxl_register_map {
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
+	int bar;
+	resource_size_t bar_offset;
 	u8 reg_type;
 	union {
 		struct cxl_component_reg_map component_map;
@@ -167,6 +172,7 @@ struct cxl_register_map {
 	};
 };
 
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
index d5e7efd2ffc0..af7cef649446 100644
--- a/include/cxl/hdm.h
+++ b/include/cxl/hdm.h
@@ -23,6 +23,7 @@ struct cxl_endpoint_decoder_settings {
  * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
  * @hdm_size: size of the HDM decoder register block
  * @global_ctrl: HDM decoder global control register
+ * @dvsec: config space offset of the CXL Device DVSEC
  * @dvsec_ctrl: CXL DVSEC control register
  * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
  * @settings: per-endpoint-decoder programming state
@@ -36,9 +37,20 @@ struct cxl_hdm_info {
 	resource_size_t hdm_offset;
 	resource_size_t hdm_size;
 	u32 global_ctrl;
+	u16 dvsec;
 	u16 dvsec_ctrl;
 	bool dvsec_ctrl_valid;
 	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
 };
+struct device;
+
+int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
+				 resource_size_t size);
+int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
+		       struct cxl_hdm_info *info);
+bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
+void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
+			   struct cxl_hdm_info *info);
+void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
 
 #endif /* __CXL_HDM_H__ */
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 3e0000015871..b15d7e415e27 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,8 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
+#include <linux/types.h>
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
@@ -19,4 +21,15 @@ struct pci_dev;
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		       struct cxl_register_map *map);
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
+/*
+ * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
+ * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
+ */
+static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
+{
+	return hdm_count == 1 || hdm_count == 2;
+}
 #endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e80500f457a9 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -55,7 +55,6 @@ obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
-cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
-- 
2.43.0

