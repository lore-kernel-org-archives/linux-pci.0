Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A04F4CE6;
	Thu,  1 Oct 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846590; cv=fail; b=Qfkidgmq+GZLYkI7nJAc4rkPEPvEq5obtFC4OYUzfe7Y6fH/+cfq+0mkLHg+8fNtLf94vzEdUTysxjTyKKFHYtcajKlh1PUQ/CpoSSFqjlZ4Of376yUqqZCjFGFKhei/TVOocgdv+WFQaqtAXuJfl0/8Db4uHlSoVY9XxHbrKwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846590; c=relaxed/simple;
	bh=vTqKdjaPS8B81XfoUOn8iW/lZvyhmT10knnXi8x3eFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iM05nnfJ0MFc04eihgTp83fTZtOmGwM467v/FQpKvJoQZpQye2o2IVKNXSRi91SrULJeTCPLQX0+QG71LjZ6b4btB68+TKs9KGcZSdsPVw133USKdpzYq87dyrbFIierESdqAdSW0nQ2XvqFNweSOVt78JcGC+UM6yULQOGEi68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZl0rg4O; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZl0rg4O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Dh6TpuJmpKgHmzIvTfcY9Gf9oqX5ZO0ivXfeB7pp7sk7OuGr9S+fSnbjREEaExdcu8yCnY0tAYZnOPzhvEvXyQuA9sHCYDqFBHbs5jCgCNObpcuiz8tD2OaMvahrw1rhNSkpv/GJEFRfWJxf4oSUANiONx0tAX85GYYOZ/N2U7his2GuyEAI9VLSzMcLmFo2I0y0RVh6P7H1v1Of/zkU7VT1YMSPtFvcqtX1aqnuEBbyiv+G6+/Pny9rRhTGoNuRI7I7p6EsMszImDNuRMHiQeMgxCWH/VbcDL2N1hLWcXlvY23WaJi4t0npiViWA5f2m8+YWMN5TwhCaRtx4Grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGert8XR1GOVk6roRMdJUUlAz41zwe+PKjbAhjOJ7aU=;
 b=o1AnC6zbyqcMgzxCQpg5PZDzOYLUxiyA+2G9ZDL9eWVCEmnCD4QYErt1Ri0i6ceduTuaulJxrXF8VDp5oHmqYnZlIEgtxRyLnFfo+kqrnckDE1WsCJyurkCxNh0wg0UJiwHfVNcqGL/T4FZ/3ToHFhMxxfhnxTNJeN4JC3eUniIbBKidCVne6szHVDWFAbjGnx3qaOC33OrPSMWxZM9eL9cbI4lhNG7EgMaDyMzCKSuXLfdzCGrehBbrc5jUlfB/uMI3HYFQ25JOop5lORJDFKI/EjsA3wUoL4EDK+JwyaTz2L58b/Pk/mcq6UiCnHMMGZHH5ztWoSbdjMMqa5sVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGert8XR1GOVk6roRMdJUUlAz41zwe+PKjbAhjOJ7aU=;
 b=qZl0rg4O11VLY5m4WPQbsp2unOSuwSqV/t87omJJXEzg9U07qW/zH6WA0biyrMKhjkUx7PE5BMMz0X7t1Wu6o5dnRZzb0DvMzAfqldwofYtOpHmkOsoJi4sLp9VYJyKceiKP4WiBFdGvl15bSUjKlIrKx3wWY3YMBrBZF43jLAh1orR6Dgitp7ONVARY/4U2EFquNFTrEC0OenkRArHlmfsR9gJ4o9J1SXX5dk0c3Qk0Tzqflm4MaWmTYjr6SqPi5m3iwXPvDteg6TmKUR7fcFFT25RGoGUnX8mEAWMwCqAVGqiXjqBZMxdWme3Zv4ufqDmQOH6zvlEX1+GFjPSW/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CY5PR12MB6300.namprd12.prod.outlook.com
 (2603:10b6:930:f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 09:23:00 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 09:23:00 +0000
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
Subject: [PATCH v14 10/16] cxl: Cache endpoint HDM state during PCI enumeration
Date: Thu,  1 Oct 2026 09:22:21 +0000
Message-ID: <20261001092227.3004747-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001092227.3004747-1-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a41eee-3782-4c2e-2c5c-08df1f9d965b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|56012099006|6133799003|921020|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mfaiRwYTqpop8PMnXEHfLDLm2oCpsO5M08fcmbvDG9gSuiJPsQCGBh8spTCVmaWr3HGy1opFYoULg4hfwbN1opmr1mvYsS03bi4nwgt6YRGhmxArmzaaH/+NMIMCKnWyf3hn57smlX3gVwyYrvzUfQ+r2om4f1mXjbBxV5KNuChte/jeAccPTCBuIMkyNorM1fI79/4EO3QlxilBwW5ibJ0hBBUqqaWiS6sUIkXBc8a7m1wliz5CbyqsCVphUppaK45aXEq87Ls77oaPIwijEBUHBcpi8Fd3cUdgn4LI+Q/gmODdAw7MVnYUqM3jdn8voWjZ28ZtlE++p4rZntt+kkC44CU2AINYl5QGWeubQ2K70wGfmY5yJ9A0psAYw5yxlgcvMCTiaavVE7Mq6eNcBQa6gERylk/VuuQTmiz0Ad5sI7BjUBfCIgr8S/D9yYEHuWv8XA4wQ8Ofe5U2aG73Dat0ZCMg7f0W5j2GH3fkmhEBQCpks6dsIlEadel4iiEfJrEJzTxafiKrKo2XHuqUCqBfZYoXDCahnCYZRhspeTESQtG7sGSR7nmbc+NqGduNzkUZ9uRMc2IzfJKVd0b8HDd4ClKS2Z4i4faGCk8rHuWWRx9DRHT6OhpUJr0BnpkTyVNekVXaT3gESPdo7Zd9fh6pHhwdb1eEFNN8dTNmDgONhGjGjxRX1WDhwPu3t0GnGEjs5QKqQBXT7NrybsHgfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(56012099006)(6133799003)(921020)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BkBAk3Hy7nzoQ9Lbl1uBgkVDFwqOKJzSlBxYn55kF8dVk5u0nRTdg8rhJhHh?=
 =?us-ascii?Q?kTYf8rTwHgfXlYHd2WupHpU4P0w2LKI7k2jeuEmutlFbW0rqMhxU9rmkjcJ6?=
 =?us-ascii?Q?u1UERSC5nlq/nTT097u0I/Ju3Lr0/KrE6Vvj8B49pFAQSZiehL+JzYdJ6h7O?=
 =?us-ascii?Q?Ys2s9ecA01qemanzsOB6iCsFVvL8D49DVHckZVlVVVcvv6DljPAo7QVfu3iD?=
 =?us-ascii?Q?3Z0bo1JBEGz62kIf0C+PMvd+WZOgtyWP7W0xSwUCyAVimtMnuNp9bYwdfU5F?=
 =?us-ascii?Q?AWi7J8iVvwpKpMmqHxajYCXDccA9f3+3Z5xp8kfnniNVvq/JDAOYvkK7/vTW?=
 =?us-ascii?Q?Fwll+EBfufu17oSfIsUjZfqd1Blhsf0GdssHpuO7qR4IMqExttyoPis3kp2V?=
 =?us-ascii?Q?m8lExa4/p41m+PGZPj7gyRDa1xZNLgSp6dszclGZpZTtwSmw+z5LtyrEYxmF?=
 =?us-ascii?Q?vmfLPcVkTB4/kfB6lGzXo/lU1Y8JzAdlmakwxYlyP4d7Z6n91DSJxKI6mJ6n?=
 =?us-ascii?Q?CRKlSL+cyVqOcvw7MQSNszf6eXsRA+sAhy6Yik83CdJ4Z7+uiDK2PTndnMAu?=
 =?us-ascii?Q?kSlNrTz6PS7feul6B0KPdGVSMIT0n64BpMEZKuAHf8Fg4G9WXAm9e+od3mzf?=
 =?us-ascii?Q?huM1PnNH/8loXcYN6J4vtZ22+44wALrXK8EUAB/WwKgkV/qI8fHiIXyREpKs?=
 =?us-ascii?Q?L+VasQpYbQv6V+St5QLg60YZzmY0FUmlLxnjGYKGAZZwFdHEGC7jqGv1nnoW?=
 =?us-ascii?Q?iOiESn1a6NE1tsqpg+6TO+GVswD1BDeG5J3Nx4PtKhFlxfLmARIPWHXBFeXr?=
 =?us-ascii?Q?igZqlXgnhcveR+nhtPW2NTw8PQojBK7OVj0e8q2KQ/na42SY/pG0NCoSqdWB?=
 =?us-ascii?Q?8L55pGr+4WNRY/4/chFsQTabTFOpeTaFZ0FOsFhZVplUu98yCsvr+53ZFxeV?=
 =?us-ascii?Q?rnp4dJRmeeKzku03BEcR6Fzf2FDWYOnh0ou9lXFcxb0vSykwvLZdjTOWhZw+?=
 =?us-ascii?Q?Q+bTxi6DdbjW4OWVfKXAAP67cM70//iBOiCCp44MdTAMQ4VJ48lbeakjZus+?=
 =?us-ascii?Q?CaOlRse/FM+I11kQ112P7Ni9JF4mkj97ggeTwZmNGum3U0jN5hQBDmQt3A/2?=
 =?us-ascii?Q?TWRjn7fOEzWrOPBlfj/mGd1Mi6aWSd6yULKSc+YmH68Nxbq5Y64j9wHbtHy6?=
 =?us-ascii?Q?+WTiHv7P8G6bFr0QwFMhFjeAZiwDoPreC6uW4ErRA3FB51EJD55Z5QJtDQJO?=
 =?us-ascii?Q?wADlhF/1sE49KQgu+Dx8ycov4SO+aHi26tZq66ZERuCOLyp1SMVHicy8jQC8?=
 =?us-ascii?Q?fnXq9B1nFd5cNpFMuLE5tbK91Tv0+GbUy1B6TKQAOo8GKSYnd1lZ/N81MhkK?=
 =?us-ascii?Q?DGzXyA/nbVsz7NSMz1pqD09DXJlf6uaNVMejUK/OkJbJ/0ZFzIK2CSZIOc4K?=
 =?us-ascii?Q?8ZhGqPCVyBFFDEz0Tyhv8Xudp3Ir4868bSCIGSQ1p75YicoGxj983oC2IZFn?=
 =?us-ascii?Q?6OKPVWRdj6M0F6xyh5TP489Yiw9o18kXrKoeVeM8gw4SGLIbL1vIi1nvbZAE?=
 =?us-ascii?Q?kZkFs2Obdb9kCKEYHPdlKGW25cBw5/MGh+6eOOjqKauJS4E7zKwAVoKD42Cf?=
 =?us-ascii?Q?GPcq6/sKboe01uHL2Z9Pl3Kxg8Iu1q7UFs6KHdJOGkbhulekIgD2X9/h7oXO?=
 =?us-ascii?Q?5oH9nEuALKI9wvlCzyvlYRTyaa/7y57s8d9sg27jm2ovd3ueNG8Ql/V0zPWB?=
 =?us-ascii?Q?xVViIHwmpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a41eee-3782-4c2e-2c5c-08df1f9d965b
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:23:00.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgyw3L8RUV1UfiL+onOk9TOY13qhczwVsAomFRbtPwP5eMkPgUj4CzhgxvpXMvaLCCrnYvke+YB0yx1Bu+BMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300

PCI capability initialization runs before BAR resources are finalized,
while driver binding is too late for driver-independent reset support.
Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
and before driver binding.

Cache BAR-relative HDM location, global control, decoder settings, and CXL
Device DVSEC Control, then publish the completed cache under cxl_rwsem.dpa.
Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
changes.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/Makefile   |   3 +-
 drivers/cxl/core/pci.c      |  15 +-
 drivers/cxl/core/regs.c     |   9 ++
 drivers/cxl/core/resource.c | 277 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/probe.c         |   2 +
 include/cxl/cxl.h           |  21 +++
 tools/testing/cxl/Kbuild    |   1 -
 8 files changed, 326 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 30470799e059..2335059f687a 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
-obj-$(CONFIG_CXL_RESET) += resource.o
+obj-$(CONFIG_CXL_RESET) += regs.o resource.o
 obj-$(CONFIG_CXL_SUSPEND) += suspend.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
@@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
 
 cxl_core-y := port.o
 cxl_core-y += pmem.o
-cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9411694b93b3..5fef673ecd65 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -180,6 +180,16 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
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
@@ -191,8 +201,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
+	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
+		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 		return 1;
+	}
 	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
 	ctrl |= val;
 
@@ -200,6 +212,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
+	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
 	return 0;
 }
 
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
diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
index 8d2fbc49a06f..c3f53c1b93fd 100644
--- a/drivers/cxl/core/resource.c
+++ b/drivers/cxl/core/resource.c
@@ -2,9 +2,17 @@
 /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
 #include <linux/delay.h>
 #include <linux/bug.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <cxl/pci.h>
 
 #include "cxl.h"
 #include "core.h"
@@ -166,3 +174,272 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
+
+static int cxl_pci_hdm_dvsec(struct pci_dev *pdev)
+{
+	u16 cap;
+	int dvsec;
+	int rc;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return -ENXIO;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap))
+		return -ENXIO;
+
+	return dvsec;
+}
+
+static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
+				    struct cxl_decoder_settings *settings,
+				    void __iomem *hdm, int id)
+{
+	u64 target_or_skip, base, size;
+	u32 ctrl;
+	int rc;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
+	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
+	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	target_or_skip =
+		((u64)readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id)) << 32) |
+		readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
+
+	rc = cxl_hdm_unpack_decoder(settings, id, ctrl, base, size,
+				    target_or_skip);
+	if (rc) {
+		pci_err(pdev,
+			"CXL HDM decoder %d has invalid configuration: %d\n",
+			id, rc);
+		return rc;
+	}
+
+	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
+		*settings = (struct cxl_decoder_settings) {
+			.config.id = id,
+		};
+
+	return 0;
+}
+
+static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
+					  struct cxl_register_map *map,
+					  resource_size_t *hdm_offset,
+					  int *decoder_count)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	void __iomem *hdm;
+	size_t required;
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
+	*decoder_count =
+		cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (*decoder_count < 0) {
+		iounmap(hdm);
+		return ERR_PTR(*decoder_count);
+	}
+
+	/* The last decoder's target-list high register must fit in the mapping. */
+	required = CXL_HDM_DECODER0_TL_HIGH(*decoder_count - 1) + sizeof(u32);
+	if (required > hdm_map->size) {
+		pci_err(pdev,
+			"CXL HDM decoder count exceeds mapped register block\n");
+		iounmap(hdm);
+		return ERR_PTR(-ENXIO);
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
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	info->dvsec_ctrl = dvsec_ctrl;
+	info->dvsec_ctrl_valid = true;
+
+	for (int i = 0; i < decoder_count; i++) {
+		rc = cxl_pci_hdm_read_decoder(pdev, &info->settings[i], hdm, i);
+		if (rc)
+			goto out_free;
+	}
+
+	/*
+	 * A changed decoder count means the snapshot no longer describes the
+	 * complete hardware state. Reject it rather than publish a partial cache.
+	 */
+	rc = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (rc != decoder_count) {
+		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
+			decoder_count, rc);
+		rc = -ENXIO;
+		goto out_free;
+	}
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
+	if (IS_ERR(info)) {
+		pci_err(pdev,
+			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+			pcibios_err_to_errno(rc));
+		return info;
+	}
+
+	kfree(info);
+	return ERR_PTR(pcibios_err_to_errno(rc));
+}
+
+static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	struct cxl_register_map map = { };
+	struct resource *bar;
+	int dvsec;
+	int rc;
+
+	/* Avoid duplicate MMIO reads when the cache is already present. */
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		if (pdev->hdm)
+			return 0;
+
+	dvsec = cxl_pci_hdm_dvsec(pdev);
+	if (dvsec == -ENXIO)
+		return 0;
+	if (dvsec < 0)
+		return dvsec;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS)
+		return -ENODEV;
+
+	bar = &pdev->resource[map.bar];
+	if (!pci_resource_len(pdev, map.bar) ||
+	    (bar->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
+	    resource_type(bar) != IORESOURCE_MEM || !bar->start || !bar->end)
+		return -ENODEV;
+
+	struct cxl_hdm_info *read_info =
+		cxl_pci_hdm_read_info(pdev, &map, dvsec);
+	if (IS_ERR(read_info))
+		return PTR_ERR(read_info);
+
+	struct cxl_hdm_info *info __free(kfree) = read_info;
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	/* Another initializer may have published while we read MMIO. */
+	if (!pdev->hdm)
+		pdev->hdm = no_free_ptr(info);
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
+EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_cache_init, "cxl_core");
+
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	/* Unpublish before freeing so subsequent readers cannot use stale state. */
+	pdev->hdm = NULL;
+	kfree(info);
+}
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 655ed53436d3..d866452222b6 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <cxl/cxl.h>
 
 #include "pci.h"
 
@@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	/* Save config space for error recoverability */
 	pci_save_state(dev);
+	pci_cxl_hdm_cache_init(dev);
 
 	/*
 	 * Enable runtime PM, which potentially allows the device to
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5af..752347464a4d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
 #include <trace/events/pci.h>
+#include <cxl/cxl.h>
 #include "pci.h"
 
 static struct resource busn_resource = {
@@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
 	struct pci_dev *pci_dev;
 
 	pci_dev = to_pci_dev(dev);
+	pci_cxl_hdm_cache_release(pci_dev);
 	pci_release_capabilities(pci_dev);
 	pci_release_of_node(pci_dev);
 	pcibios_release_device(pci_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e200c5c56b92..a1c63e031dd4 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -92,6 +93,9 @@ struct cxl_decoder_settings {
  * @dvsec_ctrl: CXL DVSEC control register
  * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
  * @settings: per-decoder programming state
+ *
+ * Publication through pci_dev.hdm and all mutable fields are protected by
+ * cxl_rwsem.dpa.
  */
 struct cxl_hdm_info {
 	int decoder_count;
@@ -177,6 +181,8 @@ struct cxl_pmu_reg_map {
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
+ * @bar: PCI BAR containing the register block
+ * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
@@ -187,6 +193,8 @@ struct cxl_register_map {
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
+	int bar;
+	resource_size_t bar_offset;
 	u8 reg_type;
 	union {
 		struct cxl_component_reg_map component_map;
@@ -195,6 +203,19 @@ struct cxl_register_map {
 	};
 };
 
+#ifdef CONFIG_CXL_RESET
+void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
+void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+#else
+static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+}
+
+static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
+{
+}
+#endif
+
 /**
  * struct cxl_dpa_perf - DPA performance property entry
  * @dpa_range: range for DPA address
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

