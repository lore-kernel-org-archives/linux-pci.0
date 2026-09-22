Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07D52B1E9;
	Tue, 22 Sep 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066397; cv=fail; b=hwe/Fbs34tKAEhr6KtDeMs7S/jD6P/34phv+MpffDUjcaxoN9TF2BtMm3C7vV/yzuR091Q2LJh+drtZF3AN28ssDaLU89P4hrT0UIcRSjbOCUND2DZuWqW3l9saebJ0BFgtNrSlVmTB9jVyRB3TmY7CyIfOkhWifArnffNAYD9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066397; c=relaxed/simple;
	bh=zmxseeFok9AmWawiwBcRC8MkIngi26+vLJ+US/jSBNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSk124gX0Sk3eHsrQzjtwqsnBKwX7fRcd/bDrEv09Zpaiwg0NQfZ5flawtqCmP480PrxCKgHW+6psqKpcsQYgEuv0dawyMQrwm0DaZnmVOjFCcIN7S7Lj1owatsKvVEtfNjpl4ob1RhCyEy1aEfoHHRxXqLleTlGfqGJ5J5egH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p5I7+Tta; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p5I7+Tta"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INL+fSRbuyvAXa1fWjiCLeuFbNogD6+NDlSrsa5eJpwVkqo9aHvkJqO6AC+yV7XcHhqz1MS3DuiPxVdWI00lyedXDyxEzdAV7by8Fxqw69nv3Qz5PstOsIW06XfbVqcXlGqP0+8G7cHRRBIKUaAMbJRGShh0QdrTB13h9M31roG4Dd47GV9jpxQ6zbULJX8BrD5F/NoVGNJQptjTZPweRG+bVs1/IEdokUTYWmbzDcU3KP96o7K9AZfzPBCyEhhybEYrOyKlBec7cXDXCQPFaTcJHMYAqyrABVhSDvNEeQGSSiOCukIzl+GlmyFVnNzc7K9Io+gHwGz5fAuXqjMG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdWsppsqp7Okj9pAv9tHU2/5zAaBKBmBC7oR0DcXINY=;
 b=H5HdU2grxnVSKDm8C2AQgAUCSf6TsuwTBvniKRSPQt7zbTyw0Kj+xcWamh6+FlELzyMeoG2/gTnWiG1QQT4wi1mnVpJH9ZC+xehDQOKHK1ifOr0BJ8RONz5MkhTytWw5/i1k4U/1NeUVZg1n+PhU22qcuNsJojPim6xBaKRa/d8LZkQR80PbyTAYe/yKEwJfT+QnjxvssJKZBBwWiuUAM6OaOomV0ClehgMODaoqkcRN3prSE5bSZbDl9VQ9n7LlNW1m0ibb1o7XUi4RdIXrciwjixSbki3wzdTw9qua700i2l9nFQfc4EZ/fa+hnWTyXtc0k+qlOsUXRGq5O1yfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdWsppsqp7Okj9pAv9tHU2/5zAaBKBmBC7oR0DcXINY=;
 b=p5I7+Tta/My583wsUoUXC0tMTV7WaSXnq2Uo80KCq0SpWa0F8uEpgHBA8urZibTnGHeTfXSGdad7sE1aEDKqETCjVi59dizCN7g6DywTSSfhtEcBSxbQ1eZlQj/mueBE1HtcV209YAAFsqd0Ac70d4nhYIDvp03+oM2a3b2SJeKsioVZ4EVzHG/Y66YytKBzJRSjZLBJbYP0N72A9DT+Xu2fQTPW8a2H/FvOrtwUHpzo2h3kK9TZ+AmAm/RqqKv/Sbhl2D7tSsjILgP4ZVzj6EK4TSodXjAKwHkcT7c5944ZogtUagB4+RYjMWhyzfXJqqpcGzorZw5xN82xQiBg3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:49 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:49 +0000
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
Subject: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI enumeration
Date: Tue, 22 Sep 2026 08:39:18 +0000
Message-ID: <20260922083924.2451158-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e34269a-cc90-4a26-1e0d-08df18851090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hWDAU2GLAsSkDkA2KseTZ59tCEOuMYB1Cq531VBBrheSaCp5kEuSlGr32Lk/AvJq+0abBm75uBMwD2ydfhPgREdgaWtTq7EvG8KDlSQOYTOYckjdGLTlcFDPFh9alhB2wZpIenL3hMV3WM6TUUwkC+QHAI0WI1QH0Y8QPllvfRmMaLTDf5yu0knLkwlIIn4AwfgFj33IM3RbO72UNyQdPOkz0dNFmXH5xKYvHOBsSe/GrGk8beHAf2qLfjRUF95gqT5YZlOshlG8y3MteZxYeKmaRLtAo+VhgevH5M1a9b29OO3iNMOw2CQH1ZrHJQs81JPc98bEujVl44beW+mvTdEH0UmuaIM2yX2U/OpZ+xL6+kIGEPQs43q0KVrcaPn/15kPsEN828ds+CRXlGXd9KQKI3/keUCIqlUC1Y77cCG+gP+8BjiJPJzuN40bAAeuLIEuFRqzR6yQOEvZ4HIpeujRu6/Jhv+6BPqffZ7J7ZeF9MzHQWhZZfzzhGX/dlAIM7X11g7Vtkt07bubYnuCLESuDrDmUYvmAf676y1jTu4Gwn/lE/wSuqsGeqseJ4yOk5MWx70hv1NQXaQKZSb0yKruMiS1LaDsy081WIQK29IsrnINf1SrQkwblZTAv3PStheKmkuMhJqUYtbP8mSTPP6WqRG20bXY0An887Y38QHp7voWu3OOMhOgKlooAx1c1Fq+1oDddw3du9mLoke11w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BA/HLhjhxIhzd5N2j+W67VrlyjtSryOncN6MJMrywJBnKzXM+HGCXS9hj24r?=
 =?us-ascii?Q?2/mWCrS4pRljWmhmhhscuHMnYTRJ8MTXsFvJuoCEtdCx0iBBlPqPNfKeXmi0?=
 =?us-ascii?Q?7WzsaKHU9eUbqSPr+71uXpPvh5dB0E87EgCS1c+gAH2XplRBL2k9PxrdWdWJ?=
 =?us-ascii?Q?wXgZHDbkjdc1u81bxaC+B1bGcT4TgpUQv81mn3hhM28hcRFrV2VKr1ZJZAaz?=
 =?us-ascii?Q?H3IDeZtCjGwpYxhjT2WBXverZmbcffQPAnc2ztnX8JoACm1m64FU55WAPBL/?=
 =?us-ascii?Q?yZSK4T9AUm0nQApiytmF59LlOft0I4J5GJ9V/VM+qhrExud4sWE3LxZDULwV?=
 =?us-ascii?Q?Q0T8ZMZO8xJo98tY78iRUwuawZb8BKLJAmnS3zXvewJJKWZRFvxakfKflXNt?=
 =?us-ascii?Q?AE/JrRPrsrMX+uijrbTUEALPkGgiJXf2IlKB+DOC/OzFIwj61e6WtUiHkn59?=
 =?us-ascii?Q?nbJI3TEuGOtFWUd0Ud/5bkIqQpT5rBTiat1AzSaOC0TfRqfzLZL7zg9ssBBg?=
 =?us-ascii?Q?nWtQld4JV2XE19OP7vJxMSMYuNRgs3RTQnJEiOYezmjMT7a71ba9Fl5GIh8g?=
 =?us-ascii?Q?d9KZBbpfkNkJa8S4hqeO/Wi//H83UBn+HDslMPCQNRUyxdE+OEOv10vNsVAp?=
 =?us-ascii?Q?nPJhlj4NSB+N6g4WvQaNqN31uz2g9UV/1IMWxBaDijdkIB7rLFF41FHWlXzO?=
 =?us-ascii?Q?eHW8ovX75dkn80dw1Rq91GIkMMiOc2GCVTR4dvzMZeYpgaV1eu7Ee4/t3MHn?=
 =?us-ascii?Q?4flv0kRq+PDYpfVIQohaR1camwPaK/Th2bk727KTzIzOGMUvbQGAmcazn3w0?=
 =?us-ascii?Q?mi/c2HlvAKVnR0WnBWf0rSni2XMMndJL3b7JZfEFZjvEEm4ZTLIJ0IosxRoq?=
 =?us-ascii?Q?3ChgOYmgjbYIu0Ql1dMh2wfaj8TbhM0dQ99O+tQ7Ml4vyrRSLhvufNyBuw/L?=
 =?us-ascii?Q?YyMFea8SFtmZk+mi0uiO0sXZpdG5JGYp6WudMoBpYG3x4OYReKG/fK5AXmad?=
 =?us-ascii?Q?8pRcUHuM117v5SECQ8sfhaNGOEy1xOkUyxmUqKvSwmlvWIxnf9RYj0uDjOQl?=
 =?us-ascii?Q?cOF8iug26iK+Mpokf7/xRC09GEhpSfhjTL6KGdUFVf95c7d0GSAOBZmNPHTh?=
 =?us-ascii?Q?yEAfLw/5aYLUzXtD8UbQaAD7X4eMW/MZHapjaDM5+f6vuWGD9Bf2119I5pUX?=
 =?us-ascii?Q?36Cd+1Pz7qZ1NYFOzVYANXJe3lRhWE6NZkn5pdcVIQluDOGm1qozXuM7ABAj?=
 =?us-ascii?Q?YvCMKTi1FZLc7c4wkTcId2ymO2IHPZJ/P3yHDBkxKkz0w0Alu+tGspxXXEHt?=
 =?us-ascii?Q?cPMxsXaUP/Xu06yPbd+1BRk8x5ppA4VGJj3n7IMygyHSsvCTd4Mz6pZZKDw0?=
 =?us-ascii?Q?Ad0MeRc8lSNkfayl2cCRQVC3K7oQSPF+nJwKmsrc8FzE0MaYpETSBlFm5vrB?=
 =?us-ascii?Q?iK13gpWeLEhSLvzgYm3ewvGt1WzrmFh/5qytv4FFGxGKl93SfYrcJm4n/IZV?=
 =?us-ascii?Q?9XTIZIYwg5KmBbzSK51hLQduAHTveqfKNQhzcqhKvGLX8ZBS4UQ4ws8eO0Vq?=
 =?us-ascii?Q?cvgoJKA7fTQilTNIsZ1cHe5kGy220LE4inv5KUyh/ejq6k9hVGvzZcMOvBDV?=
 =?us-ascii?Q?tKhfTwZvd2mjQmFWXxONzdmN5VLz9Z4C4DTfy6QiYo68NIl3IRnttiToPIkP?=
 =?us-ascii?Q?dZ+IxbmYb6UVZak+HXdhNAKGSX1p36wbkiLhcTyrZUXAalu0e40PaEeu6yNm?=
 =?us-ascii?Q?08jksyRa2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e34269a-cc90-4a26-1e0d-08df18851090
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:49.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yikTGoqAoAA3GYhPTVMdHzRppLYr2LTmK6iL0qR1PCJHdKau62sSnaXTG1dDWGOy7hidc/ew7zjmJlcnHxdleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

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
 drivers/cxl/core/pci.c      |  15 ++-
 drivers/cxl/core/regs.c     |   9 ++
 drivers/cxl/core/resource.c | 255 ++++++++++++++++++++++++++++++++++++
 drivers/pci/bus.c           |   2 +
 drivers/pci/probe.c         |   2 +
 include/cxl/cxl.h           |  21 +++
 tools/testing/cxl/Kbuild    |   1 -
 8 files changed, 304 insertions(+), 4 deletions(-)

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
index bf7fc77626d9..cf7fefd595a2 100644
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
index 7eea2bc38d94..b5f8c28e613f 100644
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
@@ -164,3 +172,250 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
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
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap))
+		return -ENOTTY;
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
+static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
+				   struct cxl_register_map *map, int dvsec,
+				   struct cxl_hdm_info **out)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	struct cxl_hdm_info *info = NULL;
+	resource_size_t hdm_offset;
+	void __iomem *hdm;
+	int decoder_count;
+	size_t required;
+	u16 dvsec_ctrl;
+	int rc;
+
+	rc = cxl_setup_regs(map);
+	if (rc)
+		return rc;
+	if (!hdm_map->valid)
+		return -ENODEV;
+	if (hdm_map->offset > map->max_size ||
+	    hdm_map->size > map->max_size - hdm_map->offset)
+		return -ENXIO;
+	if (check_add_overflow(map->bar_offset,
+			       (resource_size_t)hdm_map->offset, &hdm_offset))
+		return -EOVERFLOW;
+
+	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
+	if (!hdm)
+		return -ENOMEM;
+
+	decoder_count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
+	if (decoder_count < 0) {
+		rc = decoder_count;
+		goto out_unmap;
+	}
+
+	required = CXL_HDM_DECODER0_TL_HIGH(decoder_count - 1) +
+		   sizeof(u32);
+	if (required > hdm_map->size) {
+		pci_err(pdev,
+			"CXL HDM decoder count exceeds mapped register block\n");
+		rc = -ENXIO;
+		goto out_unmap;
+	}
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out_unmap;
+	}
+
+	info = kzalloc(struct_size(info, settings, decoder_count), GFP_KERNEL);
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
+			goto out_unmap;
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
+		goto out_unmap;
+	}
+
+	*out = info;
+	info = NULL;
+	rc = 0;
+
+out_unmap:
+	kfree(info);
+	iounmap(hdm);
+	return rc;
+}
+
+static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
+				 struct cxl_register_map *map, int dvsec,
+				 struct cxl_hdm_info **out)
+{
+	bool restore_command = false;
+	u16 command;
+	int rc, rc2;
+
+	guard(pci_dev)(pdev);
+
+	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	if (!(command & PCI_COMMAND_MEMORY)) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND,
+					   command | PCI_COMMAND_MEMORY);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		restore_command = true;
+	}
+
+	rc = __cxl_pci_hdm_read_info(pdev, map, dvsec, out);
+	if (!restore_command)
+		return rc;
+
+	if (!rc) {
+		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
+		return pcibios_err_to_errno(rc);
+	}
+
+	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
+	if (rc2)
+		pci_err(pdev,
+			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
+			pcibios_err_to_errno(rc2));
+
+	return rc;
+}
+
+static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info __free(kfree) = NULL;
+	struct cxl_register_map map = { };
+	struct resource *bar;
+	int dvsec;
+	int rc;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		if (pdev->hdm)
+			return 0;
+
+	dvsec = cxl_pci_hdm_dvsec(pdev);
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
+	rc = cxl_pci_hdm_read_info(pdev, &map, dvsec, &info);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
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
+	if (rc && rc != -ENOTTY && rc != -ENODEV)
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
index 005259e38f4b..4bad41e74f74 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,7 @@ enum cxl_devtype {
 };
 
 struct cxl_region;
+struct pci_dev;
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -87,6 +88,9 @@ struct cxl_decoder_settings {
  * @dvsec_ctrl: CXL DVSEC control register
  * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
  * @settings: per-decoder programming state
+ *
+ * Publication through pci_dev.hdm and all mutable fields are protected by
+ * cxl_rwsem.dpa.
  */
 struct cxl_hdm_info {
 	int decoder_count;
@@ -172,6 +176,8 @@ struct cxl_pmu_reg_map {
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
+ * @bar: PCI BAR containing the register block
+ * @bar_offset: register block offset relative to @bar
  * @reg_type: see enum cxl_regloc_type
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
@@ -182,6 +188,8 @@ struct cxl_register_map {
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
+	int bar;
+	resource_size_t bar_offset;
 	u8 reg_type;
 	union {
 		struct cxl_component_reg_map component_map;
@@ -190,6 +198,19 @@ struct cxl_register_map {
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

