Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0622330B0B;
	Tue, 23 Jun 2026 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185112; cv=fail; b=P2RdgNtnnK4N6ezMiqdMOy3NRejO16JntdYAVIfa+7fBtlOzUbG1pTepkBySjoJfGJDJYwhgsVhKD8NOh6A6bGHAbwQcrz/JRBe7hV8Isifn/E00DSbZ+2Uw/L8pCpmtd47B6nspOODTuw6IVis2Ndm9urn0tXfAfry6DP2c/1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185112; c=relaxed/simple;
	bh=jThCbIMWjXEQ3mUJpVsK0hXsZeOhQXwBVMYizK3DGLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGHWYvSHuJ/+clzfvtNTnRkHWXP8apyMgUGlD9R8g+36ut5a73j+0y5XXyoleNG2tQfXSc0sE+NF0SOfBFj+qnWv0erq99/31LeY2NbW8kbbXKgxg6kTVRZk5ixLcRRB6L2Ktufk4+2Lv1zReH8rVKDgpnPccOcXcskCri9SJ5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUJ0DsG/; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUJ0DsG/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJuXmIDl8hx1RGZ+cW21ErqPgea3zaVZdbDC4l73cFxjsqZwDujy7SofoCo130zgtYZeRkvCpHrJwLc+lj/6tF4Qr+L4e9r3EsM1X5+JIu1SaVsglOKrVfuf2fubxxUP2srmBWKh/tPFpJfYtiB4ivV8IbVh6SotqpsGkjpzfoeMShX+mfq6PHY/DTro4iv3B3vqwVMv3vSCNI3OrxIgpE025Ie9JDoojCAjBQCzjaConzsjVEpVi85Drjyee9bZk7VwiaFxqQgRa7IRg29e/c9fDk63WPdbknzMcjxI6QeySkTZAUOiSx7bP4NOdsIB3g5b4dTGRWMLZylu5dHWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FDVY+dMJHBp6b5zFPAOM5NeukbsiDSN10/G+G4qoyo=;
 b=XLcHsIeyyvYC882zwKdLNRK/9BnPTUB4E+sp2puKh3eZxdaOvtf+78qPXZ3Vab5acUphRoF35UO2UfP1qjQy0A7G9dIhJB5dvAvkBiUdxSqkYrEoqkQveAbyrz7Qzq//KdRb63Vk7V4+clcDvpXCZwXOxb4qxDdzlABZcnO4alIWwqour8coxLjUBoQ5GF5XINf+K7h2IE4BdUHB9pe44FPZx94azB0LESousjDYZ9Mt6b8Zmqv7G39AawL47g6rYvAO2npz8vJ/cXk6H0lRTZ++gRlwqU4jRy7gKJoXXTf8uNpnJegKucxp4S2DQL2p/NMJLRwqEEvYMXFkgRXbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FDVY+dMJHBp6b5zFPAOM5NeukbsiDSN10/G+G4qoyo=;
 b=dUJ0DsG/gWAk71wWFX8fcIt+1UEhve1jisZSCvOjm2119RiVW8n7bfT0XuE/EBQsXaFLiaEewhHkLDQ/tZI9ZiW47fjqSiZkcPaLmRxIQXVEEQRG266rK5gLQuw3zvQMdfBgrlb8oeIKrLYcT9Aezmv2sKJ4MAtIk8j7FiQDmubZouKl0yf+I0XtXZHi0d1v+RSLz5Iq1I1fGY6X7JRQqGMzFAh0MY8VQIGa9dSSkfdxzN30J66Pz8FgvoGbJHnXuzqyk9y6PrCgs2EojypqzxvjMVsec24G3qBjD39dZYUMZZOPnX4lGeySERDgt8QH3wV4akcAKkGvd7FkS3SdGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:25:07 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:06 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
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
Subject: [PATCH v7 04/11] PCI: Export pci_dev_save_and_disable() and pci_dev_restore()
Date: Tue, 23 Jun 2026 03:24:46 +0000
Message-ID: <20260623032453.3404772-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f31218d-e6d2-484b-1185-08ded0d705ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info:
	i/Nwe+uYn5tTyLs9R9Owp3iwcq7V7KvEQxNlvt6P81fVOWuQpMjvDuheEz31sIm12TSjGKZxFwyTL2VGL3w19It0cSsIpeYmVAHbNrVvjxqpmdyx0kwErZPxLF+wFFXv5Y49r8PYwge6cKK55ZL5XtlgrKG8pRvS3P/RyWMDwla1Hm5ccriD2Upue1aFsJerBNcZOoGfce6y2SKSSRu6uvv3t+Gg9NFGieD+w85FF+fG+4loE3KK/OvSKURttzkhNvTKTOj+XaFST5BylJiMoft3yxNnpjSz9Pbc0/OYfvijkwVfFrd2tJXWLsFcNLDKEtS1uM1959+R6a6vsNwCF9lEYmnmvlKfs8sb3ZsUl1z6y+lIY9uZskKjeo0O7TuIKlrwYZkpLFZsGa6AFhFUYGWqkDX3wrhVSnZEdVp0ZAjUFQ8D7ADMofWVPkYMVK4YX1KYa4BrSFbFhh16yvLQoyjqH8hUQbUKibV3bss1fZWRlUycdYETIcD6KM3r0HWwVXPPV/i84hJWXkYZ2QtqTdkU6PUkNCMpan4F/t+amEVt0vrPpTBxLIU6El42xtn0tKNsgzTGqa59pFGp/Ko9WX6u3wqDizA+RfoJzr+0ISDh3xZkp8nwlIK2924pVFEfe6OKJobnqSc3I/NafJRXFuZpRYQ8qdWFXp2s4TsfCPve5U5hAycSVqXbq9ixQcxbvroLgJSnNZhfob8jH+Vq3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(5023799004)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1jSaEghe5+CfJwNLK8DIyjq1GkJ4tCnXTLDVGRHk+0JiLaJn2MTtIoDrONE?=
 =?us-ascii?Q?RuDqOEr5xQF/E0oijXbgT4q/Y3mpLzjhyldW2fUDLjZ8ZsCd4enj8OtpA+vZ?=
 =?us-ascii?Q?+GXznByGAwLsvWIacH6c0Ykeias0sg4NqX21340WKr+e5dSgVfP7325f9TtC?=
 =?us-ascii?Q?zlD8ikya7tl+PQja0E6lQP9HZYxqMcpvXmXw9VNGdA5IkjYFXTYQghBoRfez?=
 =?us-ascii?Q?yrXIuWkEnp3IzzLScIM9fB/1AvTJnOxvNILX2ZxsIJnbX133jjCFQioRqSkU?=
 =?us-ascii?Q?kUqHOEKPiIRBzdPv2JA2eWtOUPKhHkIdxFbBIJZNr4bu2+OF7zksdkDVYba7?=
 =?us-ascii?Q?AZKMHCpg816AIGpSVKJE/DjQnZ08E/QTsTDH7Sbjd9+e0zwCNmecliQL5q0U?=
 =?us-ascii?Q?9w27e+gCIgHGo6MJaH1+6HON6PiqHPw9rmEIPDV0SgVJ9VFtVkP2mDOpY4hH?=
 =?us-ascii?Q?rOm2+hXuB/5ziCAfPsddu1QFYrU9piz7us8/VoSJaPoA2shCL4ChdcZQsN0a?=
 =?us-ascii?Q?Ykfa5Qd2Tot76lXiG7BZuP0Zib3tCE1UO9+N6feBIH2eML/LGYPK+yhUayZ3?=
 =?us-ascii?Q?4OsqrGBk3PO8CZ7cFTMOy68q1dtIpAhJbqjUjyMfQ2WltHbQ6wN5j26vxfbg?=
 =?us-ascii?Q?iEe2XTp9wwplVhW+qoYR0LPMm1lcry8F0aHbVNb1SAgja/aMPGzCp/Tmft3b?=
 =?us-ascii?Q?5GibwLh2PVHHdby+gD3G8hMBUeJ6p98APdZ3qIhqFHnuF7Dai+G/xoSyATKw?=
 =?us-ascii?Q?/3iVzjRY/oaWOeI4LxO+Wn+bNavP+jRx1v4GpZEcf33/ZZsgKsif++gvrT3Y?=
 =?us-ascii?Q?OFcjpTdUdGPLFiKzkXdIi3r6vtjci1yXmg6w0jGzSjaICyoYDEks22JwZ7+u?=
 =?us-ascii?Q?vKyQxwD+W07poOUjsP8RU6BFXJrPZwogBQPQch8zzHHabtMCz19t7upvzp31?=
 =?us-ascii?Q?8ICj0wwMGBrKPiF2lxsJCudJWYl9xE/56t7o9FuL5SMrtsqXMFZWYvzB2fbF?=
 =?us-ascii?Q?pt45k7ZTv++xe8/aoeOUxIpd+EWxlVeTDh0YqKB15AHh2+wqQHWoQfo7TUzH?=
 =?us-ascii?Q?DVv2zr+YraIOyYrz63RSX2rfi48f5S2KsvMOkFSWoWMd7NX2lZV4EE0C9zIm?=
 =?us-ascii?Q?yq53P/GUH3WucoAOGReMhu91OqBD8vprU0tFoBYapcSogYgryvcOmsXPFGLo?=
 =?us-ascii?Q?jMjpv1vXGJP7/F9wLZkljQN0PHHnwKwf/jyRUtK3VnzgL9lQ1v0WdO+1SdOF?=
 =?us-ascii?Q?pQzxGUVg/m1s9rO8Ep2JYZSnVfaLTTeCK9Cs7AikNGLv3506Ha3JOdf+8RSB?=
 =?us-ascii?Q?e/xKeMfrpGobSRilFX3UfHp6Shoii9EKCwyvlvk/YJg/MQyXMSaEv0Y9igwZ?=
 =?us-ascii?Q?vkZEwIlRTzdmi7QoaZXo5ZJ7VpOg9nCxDP4FasL2Btxz74NX3aBQYHYjH6EU?=
 =?us-ascii?Q?GmX/nzvt1hKcGAPnlvHx7/tKjSL4Zi7YWUP88/7CvhPc+Xeymfny31L2aLqt?=
 =?us-ascii?Q?NSVmY4UG5es6Q7stGR7IY2J4UZxzYf4tLBFSQZpDtZ1LNYf580zG3QelOfP+?=
 =?us-ascii?Q?2OrT5H24FP22CyIzFTfPN7Q0kOiLXmo+DwEN93KBNKc94cLQ6IYh1MscXYE6?=
 =?us-ascii?Q?D9u/7uSbPoK72sj1CWnyNGIRw0nAABkpdKrmWaII/3zPwnRQUvyFbm1wXPC2?=
 =?us-ascii?Q?Q3rl1CoooPQ+XLYeRss+a9cfHkl/IkcgWog8oW1VmE7T1vggxn1i/ukMhL/e?=
 =?us-ascii?Q?HlJrRm+hvA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f31218d-e6d2-484b-1185-08ded0d705ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:06.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUA0uAsuXBouZ4K5YzfLxqSbolDw4N/kf3yl95gw06D63474flVt9HwZKq+BHCVfdqSLMxI+AFegh8dpVbdMBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Export the standard PCI reset save/disable and restore helpers so CXL reset
can split that lifecycle around CXL-specific sequencing while preserving
driver reset_prepare/reset_done callbacks and PCI config-state handling.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c   | 23 +++++++++++++++++++++--
 include/linux/pci.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..360f2aaee10c 100644
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
@@ -5036,12 +5044,22 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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
 
+	device_lock_assert(&dev->dev);
 	pci_restore_state(dev);
 
 	/*
@@ -5054,6 +5072,7 @@ static void pci_dev_restore(struct pci_dev *dev)
 	else if (dev->driver)
 		pci_warn(dev, "reset done");
 }
+EXPORT_SYMBOL_GPL(pci_dev_restore);
 
 /* dev->reset_methods[] is a 0-terminated list of indices into this array */
 const struct pci_reset_fn_method pci_reset_fn_methods[] = {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7db2daf8597c..4df030837a3a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2018,6 +2018,8 @@ void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
 DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
+void pci_dev_save_and_disable(struct pci_dev *dev);
+void pci_dev_restore(struct pci_dev *dev);
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
-- 
2.43.0

