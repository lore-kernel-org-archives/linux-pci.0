Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791AC3E63BD;
	Thu, 18 Jun 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777364; cv=fail; b=BR81sVDSZW9kDyQM8ejM0HEU8dIu+bu1NguxodsuJ+GYKLgxin3Nx05/WZq1vDNM91+Z7iDtXJJBFfRZgMtV/kDE5kVAukLlILizo2M1e51uczndrViD4rtMx+Uik7uGdIgQijmJSTazF93cRp8MqHVUPdRQvn+CgVDZrekpqIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777364; c=relaxed/simple;
	bh=5ajnyrmmtugMQUhTA0YhuMyh3FGNoh9hP7ns0Sb5RG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0e3Vvk2CGHKxPij/Q+3CcOhgkpUXi5lrDtiEKLZUrKGFaY7wRHwvGJTUlL3iQNOhkBCq2EWkahsQnESnmg4STC68fKZF6axbEZH4T1T1wbkXI1NBjrE28ovKU1umW7lhQifT9dvFq6v+Un5/nmKUZ6EJLVkEjr3RsMCNSO43AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LamNveGz; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LamNveGz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW9JmdazYj/P9J0dErXlzJmvpE1kxw/GiX8J+crfYEn8+4LD3v20crZ7ZeA2y2TvXgyvykXNjTefmTUzqNmBt9RZ3nB+DiYedHuAbszVz2wen67QZEOG17SA1ySKTs8URfAFJykRYMvbs9KN4+gRDEQfjwcmwflV70sxPUWM7O06W5v6h98eJG9xswmGHesj63VOQDefKRUIelFO3a+UMEWlGNIVHjQe9cg/DYj0Lb+6SfiZR+OhV3xYORF46Kg36MyYw2ywV6A7NuuF4FOwBNe3nkgppIeQlJiI6ZtoTOZeErp+tsuogAqWFgAxtcm9ojbWt3G/C6dvxVVASsqdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pJrYEZnj6ZVlqAf/Lps+tfebuSRM2ZFmR31avkhfMY=;
 b=tlvgvN8GrWqamzQX7MURQZTgY9n0bolusyL8QPuK5vcCMGHWieguDYgzrHP1eMtmsWcBg6iO25SbS1M2KDhBVfdZQRzI8VTZ9g+V0nVMNBDuhmVjLtp+LDoTysV3KKKNxiJO2g06ja85bs4KHtsmw+NuE6wJQPeBcMQNO7iPhQ79EiWUv4TwvBjpv2HYIRUe+sqb/fhFIA0BuzfF3xb1UhdMEISyt0+5ySRcsYdQvXSZnObLoChuGtLWfmJ5amwwMIXoBOMdL2Szadw5ZbDC49JDFqSBktfFNdTcnsvAnj05+Kzzyd0Hq4ZehUr8cf095R7Tp31nukd6GLjU3gqZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pJrYEZnj6ZVlqAf/Lps+tfebuSRM2ZFmR31avkhfMY=;
 b=LamNveGzqCc/kC7dyKacNz8Q9x4x+wfMzqtu/vB+2ylfl01ZNqnvadsZJYHtrMAu10zfHpFFFNSzwIzrRViJwO+uJ9HDciaXfi1lRecjOwOQDkGHEXOaJhpbtFAyLnLGZuFqR7pWR3QFbx0ckzPumdIp1pDx2HQ9A0Upf398NqF/cgBgIdYDswz07wB2y5ap4aEdbI3SdEWEYvu7iJGcpUUJE7fTemgtYfr3exEpmcTF1rUvCcjpVM1M8gG/zc0OeQNzD0Qu7VMyLCn7I42kv3Nqcs4ZtGN3jMnAHz4m+udxg2hUnlqtKOOJZPMu+pQum3fCTwpGlCTjF872f1ddkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI1PR04MB9905.eurprd04.prod.outlook.com (2603:10a6:800:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 10:09:15 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 10:09:15 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	brgl@kernel.org
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Thu, 18 Jun 2026 18:10:42 +0800
Message-ID: <20260618101047.4185497-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0304.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::16) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI1PR04MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ce774b-9f6d-46dd-9d24-08decd21a6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|921020|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/AhJWXjPJRkESbKEW16mpvhprDp9gR20qdqRC74H0bWwvQJrFu4cwsbAe2GNgyo+6HoF1lWcMmz1bfWXDADNd4oBx201AljgytfSNeTUXtBikPsWdCM7WqgyfycLwPC/9GYGONSm65imkxsz1gdk2DamUBOTJBfMlg19gZmDNn1i3mJPg9WoUK6tUuus/CQrAKqV0dh3ae14mjt5fH0NBwb7V9is7wzHBnFaKQBQTwkOIoLoV2mwEOljnRe7idSwjg94j1YzIpUbHT0CNsNYN61wlrUmgMfYCBRVClMaK9G88PfoiXK5IjnP8QuKmO+wy2xDYZ8/lSwvtVfHbMdjtSAazr5HtpqJGsMP5MBQmcsVmHtoljwY4aHtqlql5QTkTJGWePw0VJ+/RrITtKP3/1f6Fq1rLm2hJb695bnL3tetOWqqlkOvpikUkOr6vFJzT/THouPGYo4aWQOfEkXMfVUwmsOj1yc/+nc4ANi69g2jfEzR/K1NCQbppLQiHJH+S1ydONNkcibjj3zVfcJbGqFLD50GIil2xF+izPNL/c0bnd1Z86Gwt3B98IrPNw/2as2GHAFC2ZTtPHwfffuFAFKvg1LOdNE7EPNCPeglvUDIKgmEVRbHGdrG+nr/yGTi7tagDyif3wrMxgUGu+xHrS5Ns7o3rkLQstiGZQIBikm//xiIJfxUJq06w6bEsscEBNri23PxzF/sxeMbvXdH4xKEuKgKz3dw3/IVA+g8+og=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKqBZdGUDGhhvA/ciuoSHswueTPCHbxOei+k1EO3sF7Oy4MIsZptR3eFAfJb?=
 =?us-ascii?Q?hwMozJtBQZQWqDRCbeKtWMIaWFCP20W/rhu27I+qNr4fE5MzslbZ80sSEJs/?=
 =?us-ascii?Q?CzlOOxTfQhjcI7y2I6mIJvu7FTfFzHn4Ld94ytaubplmiHxHwFFymSRp5ZHj?=
 =?us-ascii?Q?g13H3mxnFkVBKNJTzovidio766LTumPYoX9EoGhtruyzKIxN86hJDfeXzH5E?=
 =?us-ascii?Q?/7o7f6nE8OeawsCHaGOY1gOSp88iYQNpGdgPeuwM8FFHz0H4PwngnviIu18s?=
 =?us-ascii?Q?Up5f7LP9DhN8rq3fde8R/YkfzWEkEV2pzEAAv1sJQ/qaD9WitwbZBmvnhd3G?=
 =?us-ascii?Q?nnwsfSh/xoFvVpvm7UDJ6PMxVMeUEP3Bv8innZwT0V1GRcnTeCxFHmdu7Sps?=
 =?us-ascii?Q?QXwKujYZPSL3w7UemQm1jkT2QTi3ul4qk6wCcqyvu/QcwabxOZcJrVWfIzh1?=
 =?us-ascii?Q?1E7n8hyBBfYy7IOJzg1D/FQaTHh8ceLRYi7D3vp/2OYTcD8CYwLuf+n5Se7h?=
 =?us-ascii?Q?90CzjKTe1bVe4vrohFwoY4RtU4ZX5EYIY6m9vuY2ThUtDE2lTgkDYNJ0Lm3o?=
 =?us-ascii?Q?n6fGqFvJLJbyhV+UUMXwks8l7U2I6aVPgK7kihrozvJIeJid7TSQA/qLRPwA?=
 =?us-ascii?Q?q5QkAnIZGMrZhVUwYSEmfF1BmLW55WPR8fwo1Adg2Nq3ScoiJ6PoyI9FBJ4E?=
 =?us-ascii?Q?+L7OTh5CQgHSGPm0jwLI1584Pbjzedv81dJzF9c6FIppyA39SlLlBlxVk5lw?=
 =?us-ascii?Q?gAj9NwwCsSjfK/XURoW4AbSs8ml/ohtSZMeCJwyBras18RCg/LNoOtmhE1aY?=
 =?us-ascii?Q?JCRu9/JTGSwquXyGSNAv14FLzH4ZZIYVEsCLqwoE8gaaN/W6p8wFXxknQpTF?=
 =?us-ascii?Q?6dcMlm+hMN/JxnynYin9nyNn2dJ89HY6fzhrfhrUebPNT8QcyGi3zP9NDWhd?=
 =?us-ascii?Q?Kd7EBJb3EXbs/d35VLJyVVbQav+7SV/p64O+1y/uHsKggDCryZly+txzVBp/?=
 =?us-ascii?Q?LS31/+KdAFUQ1WJGIwTI/VeyPpSnqaMqv+8qjdoMvR0gjSbWaaZlmTmXMoWp?=
 =?us-ascii?Q?n41OvPugxE71XzETE4Abw7D1xfOW73Bl+7Y9Hg78vC1UODaxM0OciV1H6XGV?=
 =?us-ascii?Q?HlTwYT8h4Y1mstD17JE6ZYgjHcoQ/XOxiKcBNFplaQ9m45BLFu5PsyxYUYGz?=
 =?us-ascii?Q?zeBprVAfzwtsuG69WOHE6HaePPBOqWq7wxn4A1grTOl7f2dqTm3/fw3a9qV8?=
 =?us-ascii?Q?MaaCV0xWF21/YQA+Pw9opXeR1iKyYiYJECDDr5ohZaWnMc4k1a0MZF9umthc?=
 =?us-ascii?Q?cDkJHpjwkhy3x0DyO6as6BbT1f3bea8UlTzr9I2B1j1fdwbrlmYars9KCoit?=
 =?us-ascii?Q?dFnJMQiHBw84KNuB2rqL7/hMR1LFv+mqzVFXrMvyLnbWYrkZEVwhoMLYSsfg?=
 =?us-ascii?Q?oUSK5Yb1z2+RrCnmxfcJi2nnTJaDYEvEP9ZoK5J+cFKi+aoWDorJ+cSwlWFi?=
 =?us-ascii?Q?iXVN6DPbytH3wScGQO1e+l/6VdQTA0HOCX6acDSodrlBCGFLsrXUZ1jc2VCJ?=
 =?us-ascii?Q?NlYc/WOXWaYz4KDkzcLAYxoWXq3fWTyMNM1r5fpnVbL8YfVns/uhqVJS2yvb?=
 =?us-ascii?Q?dHiAqanmBpq3sKbgMNmvEnt5TolbrEYkOpXlUPkX73lEjxcNl9wm+G90atwh?=
 =?us-ascii?Q?teFj/Z6Wou4D1lwTu8nHvpblq6Wub8JC0iSRhab3iVeRKYGWAJCNhFOmyfgC?=
 =?us-ascii?Q?kgtOZL9dhn3urcmFRenlOTP9BNBY43QHeXg4VpDX4uS3vO7o/e45?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ce774b-9f6d-46dd-9d24-08decd21a6d1
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 10:09:15.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBhILDTaHBQalMw7EYh9tUVLhiJ1zgCahSs9Cu5G8AfOnlWS3MQmjrkiPXYJQSpJrIFT921NLYqLM+aKG9m/+YsUI9koTeckuL6QODXKGOgBjG9ZfXvR5Y2Ngsvxv7wM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9905

From: Sherry Sun <sherry.sun@nxp.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..1aa8972f0dab 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -9,6 +9,8 @@
 
 #include <linux/serdev.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/skbuff.h>
 #include <linux/unaligned.h>
 #include <linux/firmware.h>
@@ -211,6 +213,7 @@ struct btnxpuart_dev {
 
 	struct ps_data psdata;
 	struct btnxpuart_data *nxp_data;
+	struct pwrseq_desc *pwrseq;
 	struct reset_control *pdn;
 	struct hci_uart hu;
 };
@@ -1866,11 +1869,27 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
+	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+		struct pwrseq_desc *pwrseq;
+
+		pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+		if (IS_ERR(pwrseq))
+			return PTR_ERR(pwrseq);
+
+		nxpdev->pwrseq = pwrseq;
+		err = pwrseq_power_on(pwrseq);
+		if (err) {
+			dev_err(&serdev->dev, "Failed to power on pwrseq\n");
+			return err;
+		}
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		dev_err(&serdev->dev, "Can't allocate HCI device\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_pwrseq_power_off;
 	}
 
 	reset_control_deassert(nxpdev->pdn);
@@ -1903,11 +1922,14 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
+		err = -ENODEV;
 		goto probe_fail;
 	}
 
-	if (ps_setup(hdev))
+	if (ps_setup(hdev)) {
+		err = -ENODEV;
 		goto probe_fail;
+	}
 
 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
 			   nxp_coredump_notify);
@@ -1917,7 +1939,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 probe_fail:
 	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
-	return -ENODEV;
+err_pwrseq_power_off:
+	if (nxpdev->pwrseq)
+		pwrseq_power_off(nxpdev->pwrseq);
+	return err;
 }
 
 static void nxp_serdev_remove(struct serdev_device *serdev)
@@ -1944,6 +1969,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	reset_control_assert(nxpdev->pdn);
+	if (nxpdev->pwrseq)
+		pwrseq_power_off(nxpdev->pwrseq);
 	hci_free_dev(hdev);
 }
 
-- 
2.50.1

