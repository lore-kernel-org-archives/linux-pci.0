Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E4274652;
	Tue, 23 Jun 2026 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183941; cv=fail; b=s2cxP2N1ixy/vCSefGPXnoIfnfrOBv5wDj+XZpvZOzOCkVZdUmZOmqz+Y9QghRJWlhkgCJ3fg++uV1z3fC508wHxu8qXGbmYYUfHEOAbtGdSzj3yU+HZs47LDB6JZuKoefv/K5Cl3fL26s0z4KmCrA9oBVXdsUKGeDQ/hTPUIGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183941; c=relaxed/simple;
	bh=Q9c6MqBzstm+MA9GQwurjUBMiMPvXoYV8z27HQcQU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpPEaBeSnFUVaDXcwphlo72+/xzpDdfcKOH3GwRdjPGh3H7rM2QtmOaBakunhCeMydMHzEu78btwnce+MUtLBxl0YkZ4Y3olpsdkG4/rZrFjR3XpOKvg9iF0MpJxiryA1YbZhdxW5m4HCDiepLDoTb7HTC3Lpx4EdI7KCsOjWbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K1H85S9M; arc=fail smtp.client-ip=52.101.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K1H85S9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFw5uIbA+vyVj8h1v9R5iA6qLz9zWq/LfaCLX7MWzjO19XkzuHW3H7Uzm0Wmwapu9hsuqRL6WNGEE5fytsVcfY74URI1GU9KmQRisc5ZIGvrtIMPG49UcsOZzWkOREul0gQeD6n9YhBvqhGvzVbPREmW32K2diSdEnFHhuMV9IQ63Ps6ZCVOvGqH93jkcLBBHfLK6Exmj/eEXpNHEtuJqx5xbANICLYgcF5zXhLgLJLwwQdx1juVJY1Rpp2vG8MRt7YhFRQ5MsFxo8yNHEXZgEA1AvXYbTS4V1LvuFSctf515Aw3Nnt+qjEANTZ8tx+u4ujkfNv7hln9T5SKMZclDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Seq7IGYMzaeU7zgICCeYPk+OgIg53+6Le2APKdfvUbA=;
 b=YDt/bwiOtQGrNc6YKqkcCigC7VYhoDemyK3PVNIkXNWYTHNDKn503h6YZZgUznSOTng1rPPD/VvK2g+A+sAHltTFrA4ht7rZHzn5UqAOzd5WzErcrVbHMVofV5wuT/l6mzOhbD/7tLiKbdxbN8xxCBcuQB4g1GSoTHzKyvbC0AuFOS9XQNw8qw+PNtzOxTHjz00EUUl8XkGJuGCrxbGPPq16d0UPK4CdNCmR0SaXPIfBSSsEaqNKXWaQMzyjksmdpFzBVpmXr/kBrMJtCOt4TA3ZasFxXbiiMmniOvffVpy/oby6haFZhd72vC0nj763SA4aI48CNI/ldJutK2AXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Seq7IGYMzaeU7zgICCeYPk+OgIg53+6Le2APKdfvUbA=;
 b=K1H85S9M8k2h1tf+d9YqoOmJ5iuWoHOZCmdS6HigVt0NzfQI5e1L/mgd8ZSVfRF6PtPwdcFV7iX0coOzWPmolRogwMHMkpmCiKJaDU4+5hZXSN+jspOjWTE4/CIt/Y/MHdPSuS/o+ca2brfBdlUa8ADmwj51+Xan2001Cv0WYIf9QQiTlVMwM2b581CxOQuzEocBy+kW1uNVnaOOGdxB+r530pSOyoXPFC071ux4ADVTaA5vAp38bbhFDvH47kaUQgSFSxyFFZGaKcQEudY5FBldvLuTfOm6S5Jeve1bg2PTl1d1mGO11B3FjrzxR2MofVCYCsoq6o2hXdj6CgHw9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB12188.eurprd04.prod.outlook.com (2603:10a6:800:332::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 03:05:37 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:05:37 +0000
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
Subject: [PATCH V2 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 23 Jun 2026 11:07:30 +0800
Message-ID: <20260623030736.1421537-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB12188:EE_
X-MS-Office365-Filtering-Correlation-Id: 019718ad-d728-4acc-3fbd-08ded0d44ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NEAldwmLC/kyNut120rtU7i3tLmqSK6bir3B28EJgpKe0ca5FHa3fF2N6LRStg3pV5gw9cpkxOyKsc8BgS+WuwsRuZ3iEBKeZO+DZvpU34/twA4qrQf41Tkc6f188/pjOv0KWblOSERipgtD2ODyd7cYo4bGduq0Y+RO0OrulM8xV1PLNzd6Z1ywim2r1ZWXCMyNBvo9msQz2JlTAtO5zLJAPmvRMb6XOgaTHNU1NZ7sb0A1X9z8B9mQn5UxqdKbu+wPAvRFSGVCO9viOUEVrR/AcLv9ikBmb/ZRTQzkXJTAQglQ3nuMnqf8jM09UcWv/HdB0/bI2lYxJedTxrPTVkoujFk2PEtIebBhWyXqhdWlj36dBp+bmGiOv8hViz0UbDjwsrYnqqTgyAe0bKNFI0KCHOx9MHvgrFavjm/TG8Dc3JDWaOZAKaIKDBZN/Og4dXcIB1YQVitu/gdS+bPOlRL9Rbe+afhfM3ztZ9cUHQhEuG8pHJhzSjjYHtnY3Xn74uy9zT+A3mCwsMyQtMBHcm1CSLSrclJD7IUzY9v+bXVbPF/bvGhMw+f9Ayq2UHXS7X88vnt9DsApKVb57cY8RbmiQ/+nh2CORZg74EMX0lH6TOqpL5yxzUXfx49bGz3xSVIQG2dmPWU/MgIofIoWxTOIai/JerBsv9jiqebrwg10iXmz0Gw9FqjMMRWQdJ1NfeNRQU2ehSynSSrJpUwq0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Y2sKkAczC9HhGNU00qJ5XqVILZQP8Kdzata5Hpiy4I9VvyaqekSDNZsZ0su?=
 =?us-ascii?Q?oEjKdKjZLM9YimiNAWClWP3smr4+gnwgygMWDYKckyfPHrYxf+0oDEWLtF59?=
 =?us-ascii?Q?meE/czwmzcmvFBEQV11jVV9WN1XQsgqg83X5R7S8TQEQN8DsUe0UIEQiMpYw?=
 =?us-ascii?Q?0HrFY/nfvigXTgI9P6g5k6cbTkVef0bS5cnzLj3ipx514/8gNEThmNM0haZb?=
 =?us-ascii?Q?jPsLCj7mk1rs8OMeUczNdZCZgx4hRpwNYT5gAFuk4d8A6JU0VR32Z0wNIxD2?=
 =?us-ascii?Q?3bFxsjjI7UVruuJ+hUArW1X5fszfMn/zc0/qNghsDan3oFl244Q1BQ+bZsTH?=
 =?us-ascii?Q?6VkcNtSup/Zg+MBExzkpqlpl0f7Cx0aiDD2cpj/LiBh4shi32JZhgMRQv2EC?=
 =?us-ascii?Q?0pEl9WbSSel+A9yYM4Qjd3O/nAY0QRhyP5NjVjqNr0KluVs/EKaXHbezl1q0?=
 =?us-ascii?Q?2/43sCxNQffHxeEl3EGhpvI/+EU56+ndGM1iIrc+971EJ6LlZdTgkMoSaD3M?=
 =?us-ascii?Q?TTXAfJKsiTeF+1zG5ftE+xLVKAhL9xYGI33CesnSEMQzVwvjuqM/Kq7hZaPv?=
 =?us-ascii?Q?Y9ZJQYKRUbqFBN/QBftho2cGPfVcBLTTU9wWzEh6Uc2PQFUPeDWtrTaXfGdT?=
 =?us-ascii?Q?JMCNNkieVTwi/dXIQgVFh+N8tavXNW0Yn/AQf4vf5seZ+GWhF0/4vGmP1ZyK?=
 =?us-ascii?Q?4VYf/reIrMY6Y9xL83NQNzuCqY1fFHKhKBbjGNKvPWGfdcEnRGh8PkbmWNuR?=
 =?us-ascii?Q?RRFq/PgRI8fc2MCv1LS6Hnw4IPt1Y/+8ycXkAe4PhRyYcx0YZHBvWUCZNOJE?=
 =?us-ascii?Q?U59w1OEIDWLQANoh5JUJVmalkol7jvbsxaY/JlSPsNa01PuxTBQJ7ocyvmwk?=
 =?us-ascii?Q?gEfvk6g8rC3myiLZb+IcDrQgvE3XQpRepjWMKXiRy2RS6wcs0sB9d3fEov+O?=
 =?us-ascii?Q?xikLsH0TCopi+EV6ade5bnUhobmt5m6KwUX2Updyu6+DOCIlkzroByiPLLC4?=
 =?us-ascii?Q?RtA4sXMMZho5uC3sgWNAbqcnEY/38JLijA9q9f0/VJmwefaLiVj1EFncTEgl?=
 =?us-ascii?Q?l9Ystl/m5ViaqByTR+HviINWHZ+37WG8pMFdR7mSNb0ft6X2L4GYGIP1nkad?=
 =?us-ascii?Q?kFVa3KRyBMlnsSBbJswmHWHrXYxUomgC1+r5o4kZvHfTQ91BQA3ObCgu//9R?=
 =?us-ascii?Q?KG4B/5YR91mQqqVlqek4nhjMmRCyW20MS9XVArv97GLoRJAYvwSQ/FnHBYqC?=
 =?us-ascii?Q?+1s8h+XHG3dNRGDmmB3zqZGW6En+S/XxDwG5b8HRWoI7D2Um7PlDA6eSfNtY?=
 =?us-ascii?Q?5b++ZWIM7OSjV/tmlKziYIJtEWsWAb+Du+WuyxuZ/9g4vd17FFRV88Y6O6wl?=
 =?us-ascii?Q?fUlivLe/M4GxgMF8MngNX4uUoesSRO7IOGQuvyDi9S1tp3SWLsmcbN0KaeKZ?=
 =?us-ascii?Q?sAnrMS0uPU15rJDctVuvqsKybT2IQwVE3SUSDyK8kmkKhaZj7DSgx53HBCym?=
 =?us-ascii?Q?qYufTVMg5u3W3fH+winPZeA+RwYw4f3Cv9zxwzFhbpHlA/wpSl87E4gWHKAj?=
 =?us-ascii?Q?xfbvzsW+S0ZlRFRe4C/jRJGS4zrrmub9PSFwXc0kNSZOw4dhylEpZszooG23?=
 =?us-ascii?Q?68EdqG5PXx5q3PSgKLzpTwncAcbHW04TvbWez6TCWgjRBtzGuXtC400YoqZP?=
 =?us-ascii?Q?FhmUhd9IsAjCTXoWgl+8YE5xwy2mwKR4PCW2o/mtuc66v3SE2Pt1es+qctRD?=
 =?us-ascii?Q?LjnYE3+MGgxLWQAQA3Opn+wzGLL9e8eEVfRM9suV5t3B93tdz83W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019718ad-d728-4acc-3fbd-08ded0d44ca3
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:05:37.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlRQlTNLDk2QjvGZgEbEt/sQA1Px24pGgLYPg1JXVHLku3kxqUuaP5KBEWDxMq/iqMd5gDy6efS2VsAnKL2dOKkf1Pwsvq4v2BsXBvi8CKd7OFP5kx1dHzHtyjUSJrik
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12188

From: Sherry Sun <sherry.sun@nxp.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
pwrseq_power_on() is called to power up the M.2 Bluetooth card. The power
sequencer descriptor is obtained via devm_pwrseq_get(), so the power-off
and cleanup are handled automatically when the device is unbound.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce48..438ccaa2b56d 100644
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
@@ -1866,6 +1868,18 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
+	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+		struct pwrseq_desc *pwrseq;
+
+		pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+		if (IS_ERR(pwrseq))
+			return PTR_ERR(pwrseq);
+
+		err = pwrseq_power_on(pwrseq);
+		if (err)
+			return err;
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
-- 
2.50.1

