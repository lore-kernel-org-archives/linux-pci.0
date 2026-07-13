Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A581311968;
	Mon, 13 Jul 2026 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909959; cv=fail; b=kqsHEd4qWhCPk+3DejtfRxf5Rb6LU7cUvQttsFF/50SXX6uzTD49l92soK5VpQa7xBj2Am/N1D1ktsFwnSb++vEvgSGkjBy+iSKvjWvKIcZl3lLItUpIVx+wTZQ6+E9zD/oMx7Gbgg5IH41bkEih/Eb5UvaM5wImNL7qJg3IZS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909959; c=relaxed/simple;
	bh=VMaAgKbRGA1hzQArIteObBK/Z1iQtpHh/xqA3drxe2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aeghVCG824d8/lBQ4e3bvmD6SIqXMeGQezf+w9ESssdFQ+pEDvaqGHzQ+XbAFL2lpuGmShvoa3EbM4+vsa/YL80LnNtAOi7k1oRO7b76DM4EPCt0cChwjrGTyB7TRnf2LttmJJL//0cmPiSlMlpa09feF1s1XGlLExJn8M0gMN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Av4uTjeE; arc=fail smtp.client-ip=40.107.130.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Av4uTjeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSjzBBUDhdVzcSNldEfUmHZSxcETSoURbCJJW5ic1T6bDenjrHutLIHkOqUqtYXMr8PmqE9C6IdWf1dWXRGa7TtpWhbhGG6e3tYk8XwE77yHQIOekWFTrsJTML86TNMkNZrp6+kdhOxG7p21fJYECPEgLIQDm5zsaLKoAJNyGNY+5Hdh1zMVmiUVDHj5h6rTlj1i9Gy04MImk90+KsqdBBmJnrcFwunNJhjHUak6fnAtCySqAKkeYl6gsKsPm4Ex0O8Qx2edLeWyq1b4Lvys039Vii4mr8oFbZOAHvgZMscUq7wzVL7mc7L4Ntfa7GPVRD6Dk0Y/s/kkQLzRuumGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9nOR5aMN8UyjB12uPh6f/wGG3WxMwoPeEaP/jLnL4w=;
 b=nkMU4lKNGkIp9M94UwP0ySw5Fc07fDlqQi72k074CnI38+lmOVkMdrtbF/NOqJqQKBq6tvmjLVggkBunr7pmA0FuSSq+B05iuzzcVrs1cr3cL6DfMCsHeMxIDe43vhfjepeml+w5mWqG+4i5TMqvEH0jZQxN570tF1I+J7Z44QTaSxNPI8m4t2aCQ+XxqrrNEW/o9HaRD/HEZIv5uq+r1wK584kyVCxrsUYoLp0JDxZ8jHQXeTj7jRKc8LOZcu//wxN51f5/YsqTCbw4qMpuuncQHlBAv1SxnxZZKofnZgHz3f4APQ/0esajy2YlCM+eFEOzMTlobE69qWVBH1mAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9nOR5aMN8UyjB12uPh6f/wGG3WxMwoPeEaP/jLnL4w=;
 b=Av4uTjeEaEpj+/Hh0zd8jaOsQFhScEH1Zt/X3JMg50NsOJG7KVIytdtvhmPvEZTluVkUhcseKRN3NKlrdVEDEVtdDjmPSOQjCPu/NVeyi8bHcMTAV6stUlAY2D23KWanEF2abILwgxhmkt3b3UJdmLR3kRWgYE5NUrMMowBSXs3bCTbL4G5yqbVeWHNbcDJ0Zl7+ABPSNLYIGhzQGq3JRCE1pPawU6Y2p3PybnDp07UkeXe1VukNFl18fWlAVVhGPFSwIAoybBXUkDNVhtgRjj+10R6gbXuELucfTmPZC1DOuyITCeGuPNC4qOnE0up/ooht5NSeSdQfj6/UQTYUbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 02:32:32 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 02:32:32 +0000
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
Subject: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Mon, 13 Jul 2026 10:34:34 +0800
Message-ID: <20260713023435.235765-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1332d335-e61a-40a0-4c56-08dee086fd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|6133799003|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	mjYgzIsiOafMIIpg29NnRmOfLKC7hRohiemxFUKTFRZrIK0PY8qwz4vhDcseG44mo+67S0bW6dMDxznkIUWBDaWnt/2nZFUdrrWbCI+qMfS/hsY8Jg7SBDKTRjktQ2KFmHsFpEsf+XlcFgqiDAD2hip0DKvq0jNK5B7TZMi8LIFtpTte8duOehjXBJzMQAAxOaPymXVhN81ukg4TOx/vl3WUg+Ts7gKoJ5qURcZ54pMVzNaRwTMZv8P4Qz/RrvMzHZW94bzFrXX8JxCexYYaqW9oHyMdSXBCrjiTJD+F3UlXc/vApaqaPa8/jmDHtuZvZitnBQyEj+F+Z+oxDjfvSlEivQacQq0pmIP7fCTMgXyhvE1zRzfzYgJsHus6+dCa0ufb6Yehl0dQdqrdzngstXU5mf24pxdjfySNndU5tArmrzkowW8g2aJL9oC6yByejN9iOd+jZPYZMSqRRWIMIltYLMNON+D3jduTDNzd1D5w3yPpqHpxjSreV464N8Mv5X3If3e6Iu9qCyj8z2g+dzRIjgoVa+EneOwe4ZbikgSkOkhnMQnQk3LdO95emkxFZVmQwg/klLMJihiRMoYE8LBelp6NBV2kn6TcaCT6ooUD+F6gsuRHtd4tkP75puD2MFLCatE9rOsmTJ+PVYbLo4rmBK1aQZAca8cv/c0jaH/ODW6Qyms/lfq+BGS8VvlUk64Cfu/A+B2BgNYPzUoyvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2PhXkrO6OqTK9cmy1Zp/J3SmdDYMD2JAa5yI/uyEfk4MTqrqnKrH5r4sTVgM?=
 =?us-ascii?Q?7Tj/7bcodKO40h6146NFTzFaRwma+R9oI16hU0mE2s8//Q+kzgSQA80Wubpe?=
 =?us-ascii?Q?KdVKXI3ZhePjnOT6MG0fsgQ7MayWxvLVDDCO+YFMUMPVk1/C4aFvDfIM87fy?=
 =?us-ascii?Q?87CVIxpAmGoLD6DhQeSOTe1jI+ak8MalttU1zYgimHnQXoXnQj/yzNTYu+Ma?=
 =?us-ascii?Q?Ab0XyU/51AL/0ChoqJtnh8m8gYbLvVCU9aKtrBlG8tS9o12LVkiyhMeDvG2w?=
 =?us-ascii?Q?sFQ5RhKeGaMV1r+UmmBJTKCynq0Zgi6Xm2259ex7KAkv0ontzC/KW5AAqPvo?=
 =?us-ascii?Q?oqqMZFfq3pFvaypPWyKObjeJrSRGCZnI4iLm3YY24wcQRCWOjDbY8gfuljb9?=
 =?us-ascii?Q?CL983IsvJpH16MV1KItwQm6tjsxftObpJw+dulvEg4yV2PRIKP1wr5pZwcoB?=
 =?us-ascii?Q?QuQRGqLUVNz0ee/V7n85M1pYrH9hvEnblrtqg+vX/8f7YUjWthPowcGxUXPy?=
 =?us-ascii?Q?AMxcWnxrdM1AxWsIREYyuBhmYksfg5SdsC7MA/2tlN/gTGVqFptIR7jH+j7s?=
 =?us-ascii?Q?R5Lwq9lZVz1bVOKnlOzuSW6q/PYAMjU26GzibJLJwjfVGPDCNe6OzMqPhlNW?=
 =?us-ascii?Q?vOeRQtMycPYo51BmgCI4ar8ov9obU7OAfgzBGn8gifA12fjmRMKX2YTmwjsM?=
 =?us-ascii?Q?35hx34+d7tygg5hYB0EFwufih3WBxHs+MNgRP8DCvEOPG/EZLt3C3MklspPn?=
 =?us-ascii?Q?kbyICZcCjuLdDM+0KU1JrGeTRpm+MsP1KuSTwp7xM7j2BDrXTr7pDwSm8r7Y?=
 =?us-ascii?Q?s2gdPS7jeoKFYBBx7sTlyxmbLWEzobVsQ1kGdzLg9BHWJRuj7BZ0lTtRejAT?=
 =?us-ascii?Q?iqFhEceUU0kQrZO4VyEFDf4LWlEWafUU/EeVXsKcNIm8Y3ruX7fXgRRptz9z?=
 =?us-ascii?Q?4OIbTnTo6ImABwpBOqUcj18ZxHn84KBE2coCRv+umpY9oho2Nft78oiTp/dT?=
 =?us-ascii?Q?sHQPuXQlEWd3xMlWxZyaYiXW0mbrs2UFdARCdmqo+HuYb/DJ17V+0jKKnLtR?=
 =?us-ascii?Q?R6D42qWIIheGlb5kGsQNavgfyLuPgjv0S6EcgfgJ+Zmh38a0G568OmjChBEs?=
 =?us-ascii?Q?mogzL2ce3DEfQeIyPm17hoClhTg4vY8juD9Y75cF+Uxr1imMFVw/aaxq7Lzh?=
 =?us-ascii?Q?sFgydgJfdzWxYgQNcobhmL1p7y4dZPsrUiXqRnuRKPiBC+siEhjHxllUuiAw?=
 =?us-ascii?Q?Kllv+zQtqGiK5E/h0oScM74wUbfyo34JgkhM/O3HhqTGGNWuvwDmu4lBw68C?=
 =?us-ascii?Q?GGBh/6d+nf7u9wB0Z+pf8kwSCty2Rjv6pRKb4Ygpid2OuaFUreY6tPyJ0IY7?=
 =?us-ascii?Q?mTcjZWYLo1vQd2cZVZSJEOuHAl7buRtlO9ARW6NyyU7rhh6uW/N8eiu4d/It?=
 =?us-ascii?Q?aHugIusMr+zois2/4ZqBXGwSscltdutq5l/M2rCpy+QjbTnWQVmgDnLUb+BC?=
 =?us-ascii?Q?bhc7Y8sq8tTw+UGCTj5Iu/FIt5/5KC9WxXOAnMDFDmneiC3WEQJsnsuTe5Cx?=
 =?us-ascii?Q?4Oi/CuzLNTSTBObVlLBOLCBx3bemvhlk/96rn20tupcPw4L1nMhRGoYsOMMZ?=
 =?us-ascii?Q?xhxfmLQdMrENM3XUYNl2CopCf9GP0Tu0R6SkjvRvzg8vNopTtlT7qdw1obW9?=
 =?us-ascii?Q?+KdzBXrDN5JxtWBHQmOp6ZlYFWO6PoIFXHpl0zE5uI7rY36etm0C1Ik591kG?=
 =?us-ascii?Q?FvNiX+B977Ida8JdFe8blSzYYDJEDpMQDlnFUUkq/8ou6ZNX1OS3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332d335-e61a-40a0-4c56-08dee086fd90
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 02:32:32.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRz1DzvVT8VyHngZ7pUKmIVVbWbB650vE+h2/zzY6INf2MHNEK83FphY4LX8loTO6dMLZDBlHkdSqGP15seSWy/VUWFpsj/CUQOIKDmq+ByNyewgoGCuUiWGsF290mfk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

From: Sherry Sun <sherry.sun@nxp.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support
for getting the pwrseq device if the OF graph link is present.

Once obtained, pwrseq_power_on() is called to power up the M.2 Bluetooth
card. The power sequencer descriptor is obtained via pwrseq_get() with
the UART controller device (serdev->ctrl->dev), since the OF graph
link is defined on the UART controller node.

Also add the explicit pwrseq_put() call in all exit paths, pwrseq_put()
already calls pwrseq_power_off() internally, so no separate
pwrseq_power_off() call is needed.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Hi Frank and Bartosz, this V6 patch using pwrseq_put() in all exit paths to
fix the power sequencer reference leak issue during BT driver unload and
reload as reported by sashiko. I'm keeping your Reviewed-by tag. I can
remove it if you think it's inappropriate.
---
 drivers/bluetooth/btnxpuart.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..81a11ac05114 100644
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
@@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
+	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+		struct pwrseq_desc *pwrseq;
+
+		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
+		if (IS_ERR(pwrseq))
+			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
+					     "failed to get pwrseq\n");
+
+		nxpdev->pwrseq = pwrseq;
+		err = pwrseq_power_on(pwrseq);
+		if (err)
+			goto err_pwrseq_put;
+	}
+
 	/* Initialize and register HCI device */
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		dev_err(&serdev->dev, "Can't allocate HCI device\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_pwrseq_put;
 	}
 
 	reset_control_deassert(nxpdev->pdn);
@@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (bacmp(&ba, BDADDR_ANY))
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
 
-	if (hci_register_dev(hdev) < 0) {
+	err = hci_register_dev(hdev);
+	if (err < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
 	}
 
-	if (ps_setup(hdev))
+	if (ps_setup(hdev)) {
+		err = -ENODEV;
 		goto probe_fail_unregister;
+	}
 
 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
 			   nxp_coredump_notify);
@@ -1925,7 +1946,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 probe_fail:
 	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
-	return -ENODEV;
+err_pwrseq_put:
+	if (nxpdev->pwrseq)
+		pwrseq_put(nxpdev->pwrseq);
+	return err;
 }
 
 static void nxp_serdev_remove(struct serdev_device *serdev)
@@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	reset_control_assert(nxpdev->pdn);
+	if (nxpdev->pwrseq)
+		pwrseq_put(nxpdev->pwrseq);
 	hci_free_dev(hdev);
 }
 
-- 
2.50.1

