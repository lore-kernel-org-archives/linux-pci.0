Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55A379C24;
	Thu, 28 May 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957133; cv=fail; b=HJMrZZFG3yzNSigIm21sf/9D7Ax6MWyoXiZQN/E5Vnyve/t3svtQNe+sNIV3sqDRiA7cJX3UKCrEJnlJ2lrdbPm+mOFx0hm37Q9d1pPeACWir5MyBlEVyVDB056yyc3RQ9Z/6IG64M7xtbHcxca7HIHGJ1FN0wzj4oKU+sUaXks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957133; c=relaxed/simple;
	bh=2wFcGjWvXKhN5jE/VBC7vR4xwJZp2lXbU/TL7WEVGh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8G8v+cMgrCNVy2mn+Ie5QeFUGZXvvDHlXdrHcOr7Mm/0BPNuPw92Pi6af5HPR0g0wPkRlo5ssSj+ZeI7KfxmE3+8NEYCNM+ich55lLbYzpwVUrW+WTYWbqKVEY0jV9PgPozBDZ1/bpe+UappOhZa2y/5KI1IgL+i4cIVk4Crl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnCLJN6S; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnCLJN6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS2FBlta+OCKb4nHKpxm7ZDVGJV87V2STAFK3T/+FBRvSwxH85D63cyxm0ZRrwWkLyr6E5D0JUQ/kFWYD/rTXLDkfWkKtVh9Qda5DPoU7N3SlEN4xx2Qo9abmOwQA9QryULRN58ws5W+NCZfwTaVRfu12dtJVsyl865coGHyx8N2TWDbprTPJYDhSLzCTR2QPt+j6A43EMrXI22MAXb9XAtmvoCEi6BZXXvACqZOdXGoBTIpsG/5jgDd8JXZ4K+d2hf9/2RRVnkNFO8FvN0yHOuHRvEu4UnlX5ElmTokIXHP0cu23gUASuvieDp69gAg+5x1Td1LA4evMglNFoTb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPz81Na0atsrGNpENOLxedbFLl89Y++MtyYvn1ama4Q=;
 b=Qjpz/Ny1sD+KXdzrSFu3AAqe/jiGbnT6hMtgrEdttmAhXWtEQ+33szzouHC2GfHNvSGV8eRXIbfp2iMLpspdue8328tIl1rDPwypjP4eRX7o7tMX7LK6dbsKP+4uDOlhPM81asPo1qGzRrKpWWD6EdILOzc9P9qwRGs70AcdDH2bHuAOQWITL3rnhc+QbDnDgHg1RLhq2E6R4hGoJIqIphakVGAsJB8ZNkPJCsKHYfuzSrWyPoP0VOhEJeQd0eVysYb1++EJiVMGn9Mj3FNLFxST0xp0nZrvCpmgoNOJPLt9zAF8E4Z5I1BqJWh/Eh5fN0cXwaHMjLF/eTQjIp01Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPz81Na0atsrGNpENOLxedbFLl89Y++MtyYvn1ama4Q=;
 b=OnCLJN6Ssas19Njj1G+toJ/fxH7UdFmUu5NNv5Vy506bqc8v1e/iWVCj+1bNBf1t/OyG+txjFdxZMnZT3BFY2nHfFddJq/ltukdR8jOMy8OIq9v5P9365coVU3lHyFP1WMGQOqsiCmKhZ2WWT4D669tGm1lDivy8QdvVTpL8uNw7Uz6i3To6hAShv2EpnPHcUll6snDWo0QDd+kvcPqdbY8ubT2bDmE4WfXzuZxeOEFCYR1yxruznTM6z8flBRhZT8gOJghIklN7MyNUTE8KkGMRVCD62MpGi7FJ+ocuHLWT/fiDxBAFc4YeIFkofzq2SiRKH7GfbKNjQMtzxpeWGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 08:32:02 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:32:02 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v6 2/9] PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
Date: Thu, 28 May 2026 08:31:47 +0000
Message-ID: <20260528083154.137979-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528083154.137979-1-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::9) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbf4212-6206-4c91-ba34-08debc9397d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|11063799006|5023799004|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	rxKH4TfamZuoqF0m/YVRPim9zf9NQx+xtQA8ZMnXn8984cdQlq2UXZmy6WzgCsRJMPe2g79302fObHRMVOJD2M/8AAvUtdqOSg4tQcqn28UjMDQlWx1VLMW+scXV8JpYMo64gHO65v+IN77McJyEVobJTq3gv/oOTf/u3ZY0+u6CKlOWKbidtfrc2XKLF0aU4HjerP4VQP9j7CaXGum7Uczg5czlXHHnXfM+BQV210Nw0Ndex+QO0SrPKu3iOs5ndIwCRp2PD23GVj13xukR4kV6E6qZY1bA0UVXPRbnJnn5a7GoWrvTyc6xBaaX5sJZSjKGKxDjj+i0FOXbGjsG0siv9ncH2S3TOj8os/ZWxFbiecZdlGh8SlKtZ2AtWXfEB74TXVy3sFEOjYh5p8SQsTo1yNo02I0RSjVohlmgrsZxikMdWuadAODNZ1R7uVddkpyzJquJZDpUoDZZ8jKBCOH/nNtDEfQiKkGjiYPicdHuUEAqHkNvVuN9UfGs082g9dn2XPmLr4NnKeSmHi8RprLYG/zG5ceftgXqGtkwWYNAIFe/5XcPE0bPKv8Y648buTfETmPkWlsdHoopMv8ZPzbRsMlZ5pw+fQfQy9FkOBwm3vKiSUJGih35YRqhAFbnkt4A4QaAPiNMWuPwoJgzJZrWE/mIj06WnSK/EXS1q10rHEX1sHs+Lt38MkrQxOSK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2icjN2Yat9E0WaLLOdrO8YmEIUZpgs1FggCyIZPWW/715J+Vk6P0ky+aTuw?=
 =?us-ascii?Q?WvFt6bkBgZPJYJ1USgkriyEFz5F28y0X8Hoywxae9pr6MV0nz470efHY5CDs?=
 =?us-ascii?Q?Zp+3TFGcdx7msGJUGIjVAAZD7bK1qqrxnT/NXlOIr2fGAfNKgZmwSparJXOb?=
 =?us-ascii?Q?TSlCppXEx/57EYbG5apl67QRENT9eMHEe79AilzpABTT9sdEcLItHMjZ/+KX?=
 =?us-ascii?Q?F+zc+n+Hs7FPM1p33vhk8FKrQmHcd3j+xd+fibECUVcr+Ur3J7mwwttIlrHu?=
 =?us-ascii?Q?sePn+v0BocdA8O1IfBoOrtjouHsRaPi2TGza5TFdAWvm+Jj1SMIeepRRu0bH?=
 =?us-ascii?Q?yZFDwy/V8wovogAv9t2jn/aJ3lBTskdV2N6st09cNF1I5Dfsty0BcQP58cXj?=
 =?us-ascii?Q?HrpVuxiRaFxh1WMR+2qDt4tmyf2bh66/id6CLG/Te5CVsRZ8xM7OvQhCKiOC?=
 =?us-ascii?Q?GIonA+Snu1jRWAMcX4aS8F9dc34t1xPZtYBFzIpZqKazoXHuBrEjO8aW5WUG?=
 =?us-ascii?Q?vxt+UXQpFA+qJieVCmWLnCeBH5t4WTSJb2s/HMZDOhO1N6hsjJh3JEUrLwXA?=
 =?us-ascii?Q?pRmfbYoULwUsrnFCcuCKqLpKuiOCNJLwpDXwqa/GxPqmxPQnkrZCL/aF6n5d?=
 =?us-ascii?Q?o+aDDTkPbvqO46OWM34S31byUbmhGgKoSG09UV9urx9Bsr7b9+8eNFBn5czn?=
 =?us-ascii?Q?MOQnLrdnSXyS8TJfykx4JupFTqtJWCjjdFTvm7J0UYx/Ygxe182VKsCZjkBP?=
 =?us-ascii?Q?LbYXG9OD/SWOM94QhVYgJR94DDXaVeBFwFgg0XeE82y6+Dy9Tnyh8Qxy168M?=
 =?us-ascii?Q?UcWMB5P3OLqpZxLAHvi5J/r7cszfxu0dWr52CEsHpQ5l7wA1VgQAAH10wc8F?=
 =?us-ascii?Q?P2lDMDpcIhDC8ZrAidc4IsRNlD4Iw6xpES3AYNHPCoxZruPxSxGqa8zTlFAJ?=
 =?us-ascii?Q?ZbBC1NI2uCW61f+olHjrODwQWrwRT+xiY3kiGsNmbu5GNtzMgSSyWbBGIbkB?=
 =?us-ascii?Q?8bfRwWmbaaR8s9cRrwJbz1Qi0HTP+xyBOnXO6CFuREJdPwL7J4qZQ7+NbiTH?=
 =?us-ascii?Q?vvk8202PzMq/IqmQORwoLXCyuKsTgrmURXO19OqdhEJnhWL6zl2DQ/39R+5L?=
 =?us-ascii?Q?5FXGEear7pcUop48ubSc4vP5Bsug9JdvGb7+iJBQkDEfP4L6P5ALj5b1vehv?=
 =?us-ascii?Q?njuqm2rYfgdmZOkSm/RLmNeaiYZEvmXqGUQDtmVVkS8RoqgDedALI2ntVW8v?=
 =?us-ascii?Q?8Uop+99ikPJhjOSMZ+rkQ6lBicf32tcwPtiYIZ9pINrF1w2yISNUr3HzOL2/?=
 =?us-ascii?Q?zZPLkE/tceoO2EonRRk46Jo8clugTqe4brPU1JoDL6S2iR2KESmmoQSMQKyN?=
 =?us-ascii?Q?rwXsHI+Hynm7YPYpD+l0W8zzZcZB4a23QJwoljUi9sWHl72La3ogInWQvxGA?=
 =?us-ascii?Q?WaGfo4EaBuQ2MEACraBTZg/y5zpFzL34nz5YRFyQqPutfy2ZHhV2+Hj77DBi?=
 =?us-ascii?Q?2DCPs7CnYGHohvYB7Gazs5WxBTnlL6YfUpgjbPHvPODlQCs+RsRORpxtAd5f?=
 =?us-ascii?Q?inlKHsav9QQgjetstVDruDB5rUHs58WN6AZhba5ZHufyJTUe7EmysXxk+00M?=
 =?us-ascii?Q?79JDQFGjZcisNZWuSJi73DaBn8PYPchqLAutbFe5tVdOLJecMt6UjWoeXyMP?=
 =?us-ascii?Q?D+q+xTk2O4mKPu8PdZD2QE7Udlg85c3Roajz/mTP1tic4LL7aMIojzd6KLDa?=
 =?us-ascii?Q?7CZD/jDwCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbf4212-6206-4c91-ba34-08debc9397d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:32:02.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uLghgORbQr+XSQvOjwBIcr9S73youhff6H5/J7lkWMpOQjbBlz7nafefquTICYRfMSHIZPdc9AqaeCcRrbGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Export pci_dev_save_and_disable() and pci_dev_restore() so CXL reset
orchestration can reuse the PCI core reset lifecycle for non-standard
reset flows.

These helpers invoke driver reset_prepare/reset_done callbacks, save and
restore PCI config state, and disable the device while the caller holds
the device lock.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 22 ++++++++++++++++++++--
 include/linux/pci.h |  2 ++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..75d2f4074750 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5003,7 +5003,15 @@ void pci_dev_unlock(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_unlock);
 
-static void pci_dev_save_and_disable(struct pci_dev *dev)
+/**
+ * pci_dev_save_and_disable - Save device state and disable it
+ * @dev: PCI device to save and disable
+ *
+ * Save the PCI configuration state, invoke the driver's reset_prepare()
+ * callback if present, and disable the device by clearing the Command
+ * register. The device lock must be held by the caller.
+ */
+void pci_dev_save_and_disable(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -5036,8 +5044,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
 }
+EXPORT_SYMBOL_GPL(pci_dev_save_and_disable);
 
-static void pci_dev_restore(struct pci_dev *dev)
+/**
+ * pci_dev_restore - Restore device state after reset
+ * @dev: PCI device to restore
+ *
+ * Restore the saved PCI configuration state and invoke the driver's
+ * reset_done() callback if present. The device lock must be held by the
+ * caller.
+ */
+void pci_dev_restore(struct pci_dev *dev)
 {
 	const struct pci_error_handlers *err_handler =
 			dev->driver ? dev->driver->err_handler : NULL;
@@ -5054,6 +5071,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 	else if (dev->driver)
 		pci_warn(dev, "reset done");
 }
+EXPORT_SYMBOL_GPL(pci_dev_restore);
 
 /* dev->reset_methods[] is a 0-terminated list of indices into this array */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..d6303e16e11b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2012,6 +2012,8 @@ void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
 DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+void pci_dev_save_and_disable(struct pci_dev *dev);
+void pci_dev_restore(struct pci_dev *dev);
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
-- 
2.43.0

