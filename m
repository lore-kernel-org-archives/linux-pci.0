Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10812D8DDB;
	Sun, 11 Oct 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684882; cv=fail; b=FR4YZ97PsJ4eGyj5IMnLF6K9gofj7FHYgreoPJMG4TPkKe82l4nwXYYPOYoqYCDEngTAiGynmMTVl+8ej2dZOhTiiqPX5mTGBTjPHjSkZxDU2uNe63ssrcqIWb+DP8cyIMoGCdTM1uD9LoS+3o/mj27q9G5irvUtB/ggzhq0LG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684882; c=relaxed/simple;
	bh=1gukd9lzq8iUDzF3YqOTEzTrUPmxoEuNT+YL+Ge6yGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZJv/Ko8so5q8Z9rMu6C51KAKg+x8B2WhpN9ruvGcz1FKA39qvsyksymSrjJDtdpFcB+izxcWU2mJTf4LFwxM13CJyKmCzBp2xW/eiG931tfly4+CKSKQgYC/SaXpVkls6JUVjwQ1DXYV8BHZRnd7kF7kgrEWtBKeZjaXLskn/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=satqMdHa; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="satqMdHa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDB6LDoxMjavAVU30SPOzaIHVU0ohaJqk3CiHnPPe+cyL1cVCv3bd98IzYWygBGcxT7d+xgDc55NuoVZQrUvrM9vaDt8Z8snJQe6+n1mEaQq6H35Z1unBMBlo4CmZpB3FanTRnwSh514Cc7XK/brfhQmO+hQh4x8wevpFQRSixIsxhE0uAzeR6HQIlaxnsjq797mGiuKArQN3R4Jr/vjA81sKIpfNPRnPz+sbOI0arRdqgPn3J8pEjjfu6Ioddm9r2mWF07oSAO52jqesARqcavWeitdaA8tJH3Z/sSiYTRLKQt7EZ2YCVpHxB8FoFfrWVxzs8y89zu9y57+xRY59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4y3+V+/dfJOcRoow5XT7oi9n6Fr5eEjaE5kcEHuO28=;
 b=xzMYvqIEiOSfON1g3zxZ0xHXjkc3FVqhQtWMFItgSjToKf2vyRczeaE018Ai8MhTAyIEnzpdrzEoR7bGQiU3bd4xhJ2KWAzgxSeoOeRl4HiX86DHSqS6JUv+iIS806lpvEe7G+mXrijzO4Ese6u0n3DKUvmVfB3n4RQzVW1oWEyxoTUkC5ZCa0dKOxz/O8ZiV6KcDYF4MVA121iUoMZ8VG1l5mNSGaERK9Jkyg0NEjtFKJ2FpsIoxr541dxakB7Cz6gJKlDsYPlNWsMxvmMOHlTNwPOqFhmilshWwhpH1GyrGJn4hG647PszM5HCZ7tfXRynFOPFAmEucsGO/ozvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4y3+V+/dfJOcRoow5XT7oi9n6Fr5eEjaE5kcEHuO28=;
 b=satqMdHaVXPhSUQvRfSvD2vUSCw9EbVh+Bc+kuAg2arNoRZcVM7zcQiQZV4CXwc2Od8BDjfZyINtgZi5wZAiJi4dEmUJ6pwRjTM+W4f+Ev77d2W0+7HOwmX54wZJQy0XuPf7CNfxWHZWrfH9nI2H4b3hNh7fdg/TSRvMF1+bpNu4o8GZLstVlP86Lpe9bCt+4Ttagn9wTabzNqV1igHbyF5gmRvdPb4+xvEA/Z3VjjRx+veFkd8Omh/AwT/41rYfFxgS2aY6buKfbnf/mx3NPDtDeJQupWZpnYI8WHh/uHzwNrjJnLBtbeo9TpDkWun1jSguLM1OMNCRkdroV9snHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MW4PR12MB6951.namprd12.prod.outlook.com
 (2603:10b6:303:209::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:14:34 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:14:34 +0000
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
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v15 02/16] cxl: Share CXL port upstream PCI device lookup
Date: Sun, 11 Oct 2026 02:14:08 +0000
Message-ID: <20261011021422.3428136-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011021422.3428136-1-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:303:87::19) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cac65eb-f1a7-4ecb-13aa-08df273d648a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|261009223027099003|921020|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Yvl7UeOOcgO6GedkWiapcNa24Y07t+fciVkJ6QHXIsirumqSQnzPqjrAPMz8Z6q5iH9y/9VAswKbnl5jQ9gQmyvShnaNVlwZFY0z7elgCtFoHMDJzQfbmZzxlrNaT4QJ6pvDh0cmmOrVYVcUd2ZapS+rRapAQloC1JHm/9i91y1T5mlh3YKv3keXfXyTWHDyxzdfS0WrkqBL56Qxfmjgfuq04xfR/0ujNMBpMhTWYCOYxJSXDBRSXBgDxiG2IObKQ5i6VTGh8B01M0lfF1RHg2rAk12/RGbfaK/4sU2/dqXuJx+7PsfNW+NmnoxGpNQ0qcTb3PDFXwQSl0+kiHGdvfbP9rlU7TQcc2Kn7mcUCD85/CmWrj7+xVRqWN2C367fl/aSaMxghG1kiQcbM48jxjLvBArf/3PiNcHO/g6casdlGbqCywJEb3glwfEsLeFfH5Ohf8+GZChv1TN6pHWfS7T0IUOQIa5jUO/QUcGOCaY94rQAbpKSv9pwceNgGbMaLwcRGgvOtg8v1FV3tRVjbafbflIoSoYWlbMscVw2XK16AmODAKYg3xrTYuSZgzn4TJwj5YAElbf/NeivZdnuHqJ3qAVCDp6OjwcVVexb95wo5abDCNUxylukPhBDR1/cuVSAXTbxN0mmL71OT6Uh2w5wS7FvWYdG4ofPko0n6rgL5cl9nt+ud60fN+glMuli8zF51RH6iBi+wbv/PhK2HQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(261009223027099003)(921020)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jt396vGTT5acz2VfUArZci3V73Xi1zU2mkl5ZP+pLqe++voApF3L0bgOIH7?=
 =?us-ascii?Q?7M59Ewey8Y4LZb808L94bMNe5pUl1ebHkrqcrJ/q+heU0hqQu94y5p5g3gWG?=
 =?us-ascii?Q?GmxX32AuBqxqh/n57no64z15UkvdfnobgV6Tr6wIAt1vHhR7DSbl3LaJYSHS?=
 =?us-ascii?Q?e8EKwgL6EEoj78PWSOz/HlaHpflrWh3DmAP3GXLgtdKh5ccsAiSohRc5x9r9?=
 =?us-ascii?Q?Mhk8C5GO3PCga8sJ1PYO0h5hVfm0mHUaVkLW1ti1R0WxSl/MOWqiING0FRk3?=
 =?us-ascii?Q?NVaZwjnGuNg/5oV92WYYAvj5NQHgOTVuPDHsiK/SLnlAoGlKm4bLXOURZsTQ?=
 =?us-ascii?Q?Homkdlt8W4yFeTNWQrA33AZ3xbO6bJqXW9mSf5b9033YmCAeV0sjO1KI9g6D?=
 =?us-ascii?Q?zMHHfn/8T/+vnD2MEFs4aTnSUCj7kjLAfGxFLd4X6mRl27GhG51q7BLvysUO?=
 =?us-ascii?Q?tmeRqA/03LOpMMC6S+vUhVQ1qfuI+kEI1FRwfqeNM/T8kkszg8hn4QHX8hs5?=
 =?us-ascii?Q?y46Vdgh4DJt2eoDnlguLKkS3Pk4cX8/Oznoa91dql/9TCRWaJwbEHgiKjCB9?=
 =?us-ascii?Q?8z/R0LEQCsAmWuk3MIlQtYtZBPXLkOhEifhdTnOKK4Byi/RWWYs2gRuJW1kn?=
 =?us-ascii?Q?skJROo8pjghUr26c6teNO9CKKqN1HMS6itygvYJ70XvhGpgEqgUKWBK1B4d/?=
 =?us-ascii?Q?sgZDMhsj2DQYcoGZ/jN76QvPxc2L4rigTWkmP555rd4vH7bGCsSPWhCfcw0W?=
 =?us-ascii?Q?ZX9P6AAkc8XU22Zt/qobJ81v6OeuczHoJW6AxHWJrJjfF++1IH/MnQ2h5ALw?=
 =?us-ascii?Q?gZ9rKzmkKgaOJXDfAnkOYw+/6VzQi/xbf4snDM7sZuqjI5yt+DBNmKy5Lcoe?=
 =?us-ascii?Q?3h+yGOK2bW30M82eGs2+YOfYVU6joGuSZb7d9/DGrZhQBEajK1hrVnlEHARn?=
 =?us-ascii?Q?IC/juKayTqRde1oMaodLVU/WPBK25AIDSsEgh8bj+PmMMvE6WOQbVwSDaf+v?=
 =?us-ascii?Q?vg9ibeq4NVPlcDCkPPvvTZ7juH5NBlkg3d5BAs5Gvz5eo+mOMuQ3mrIBAciI?=
 =?us-ascii?Q?JMwJ7bT+mvHKp8ftiMoChfd/LxFi3nRQMn8G/pNirv/gFBxmIFNTwbgqtreg?=
 =?us-ascii?Q?B+/KBZIgWi9IPKZvLzMJYd3JgS3i2jWEEABHn/Q4gXc6lb5RLdKaCzqvwOBa?=
 =?us-ascii?Q?5iR/6PxQIE8tRzhyM2WmvP0HzoLFx0Gc4vFMXMoQ71zDeYTd8rg3HqzOK875?=
 =?us-ascii?Q?RWf8fBJmkNZUzJfn4wKdgyi1e03PaLzDv1s5qhtmfNu0Hq3mdVSp4nm7BaQ/?=
 =?us-ascii?Q?dqRYNN3mmyTg+C3V3LI0K9PrPUOdw7eccK4+8GUIvipeXXYO9vF0yC0KNQhQ?=
 =?us-ascii?Q?0ojoRZ/EsF+swyPBghtOZdHFDNF9BIXRQlJ2iFSM64E7G/tJoX+Us4sUAOMD?=
 =?us-ascii?Q?0jTZwEPG/iPrx5qNIGxaS6D59QasO82Tol9DQtDD1sz+hCzBeId605fgTlGY?=
 =?us-ascii?Q?J556IxL9JPQPcsiuJyLfUe+gaqZvE4BGxUHcugs1sEgIfmArmuOzbjRgCUos?=
 =?us-ascii?Q?7ynuqxWbzVc5CUk8Q/Wr0Nmpz8mVthJ+12Zys93vn6ZlNXcZ13S6LWe6oggz?=
 =?us-ascii?Q?+1Ijn8szpx8IzI1vRlQeVoSdMQiM2Pw8ThkkC4711BU2NuKlOXCrwORLLbIG?=
 =?us-ascii?Q?iqk2bdvyt5piJ/XOltAh3z8PH+GTrGG5y6gMch065un0Q1krQTGjcxDIdkwV?=
 =?us-ascii?Q?pguTdXTfEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cac65eb-f1a7-4ecb-13aa-08df273d648a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:14:34.3934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRxeIse1TnZv8WSWIp0MSO3tt3JzCoJrv6A+P2o6FhicgauAeTqqileWFhFjsZoCW9RYpdZia+VgxrvetmEqwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

read_cdat_data() resolves a CXL port's upstream device to its backing PCI
device. HDM cache updates need the same mapping.

Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
PCI device to make caller ownership explicit.

Use automatic reference cleanup in read_cdat_data(), as suggested by
Li Ming, so early returns release the PCI device reference.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 16 ++--------------
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..983d7690c3a5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..c3c41efae5fd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -564,26 +564,14 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct device *uport = port->uport_dev;
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *doe_mb;
-	struct pci_dev *pdev = NULL;
-	struct cxl_memdev *cxlmd;
 	struct cdat_doe_rsp *buf;
 	size_t table_length, length;
 	int rc;
 
-	if (is_cxl_memdev(uport)) {
-		struct device *host;
-
-		cxlmd = to_cxl_memdev(uport);
-		host = cxlmd->dev.parent;
-		if (dev_is_pci(host))
-			pdev = to_pci_dev(host);
-	} else if (dev_is_pci(uport)) {
-		pdev = to_pci_dev(uport);
-	}
-
 	if (!pdev)
 		return;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..5dc2815d82d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,32 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/**
+ * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
+ * @port: CXL port to map to a PCI device
+ *
+ * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
+ * The caller must release the returned reference with pci_dev_put().
+ */
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
-- 
2.43.0

