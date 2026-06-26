Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF032309F00;
	Fri, 26 Jun 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441051; cv=fail; b=UFGcI2bjA0//DXy1Zhl+t05jO/rMrCJ2aRSUVVwpQYyxz91RpWMkKnw3aMmJclwRV9h8dF5S22JMhB3CVqvjPOFEVrtS5Z0vhuIT1P3dbubMTbVuiScFiVHt6FWDpoR2d0sl2PkFoYP3qzf+1Q6smaMDIPWXawP9fDriJz/CzAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441051; c=relaxed/simple;
	bh=0tMh2SxL3wOF2p5dBgNz7s0QDIDO6WMlsl4IGvO0XjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmUEEp2TDVADkZKrdHu+Q3kD73b7Hs44tF4dVjbYVBi3TxjG1aZAYw63w6WEC6cEOe4TPvyncOxY3HZH/3yybJIyEQXimgKUHYd7RqQo7cqBT0nqb2JNS36+7qLaDrZ8IqsxmMf2f3dbyDhSsVaEMih5UOPRdY/MagdMqOISnI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WODcdBXx; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WODcdBXx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHQnTxZs0W3ycvBCEaP1yRDf1p+hExK433pYY2IaaCIzTSFafOZOZmLTWz0L2pWia6y5owH+6cpgCneBroApdyS5DBfEFZukNNUwjxiIM6AxTiE2Rlx7ao9Mfr3MhRQ1V01DOwCqwE0L7E1XpdIJdFa2QBw5MyDrus16nmvjYBBoHLj9ewCyry28190vGKTS5qWZ1yhwOGQLVf+E+48484IuU2CofTV92i9swvG3lzi/iDvz1PlwQKkFNU7dh+hvhuUNO7fNkyIZG7jTjqraSBDMroylmi9cu7QgPI7uQTtNWbe/yFjFPlwLspUlxP5vB7HgBNtQ+QjNQWtAI7Ifag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2OSHw//4vO105a7kgzxxoO08HrKP5nicKMjdIwGdvg=;
 b=MukpNAUIwUHygjtyGsDGtq9EIFiOAvmXS8nL5oB8GQVCeGSJ6sBwkew3BOIcOtQ1xALwThIKRd/FvuOqjKTtMOzVFyV/c+oHERrUaNYhlDvJse96URz8EQWs6TPCi9z0q3XWNXjqRPq6C9f0PHoMQmDcw9uGt/DpU0KhThX8BKlwF4ruoI/59muLnIVxD1OcqFqwtYJ7HsOLTc7ymbZxYa0s3Cp9YU90obcBz7PXJUPAJZ565Hzq8xh1Yny408VvZV6g9xe5bfp8bMHIKDMQcAySEiDyv5mBgBnHPvj0IoXC9049XREQSNNraJ/W9H/KKplL6iejJN4amr8Ar+cFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2OSHw//4vO105a7kgzxxoO08HrKP5nicKMjdIwGdvg=;
 b=WODcdBXxOPiSMsUfKAWAqSpgU9YHDqn9ewCWEeBG1kydCAHFtvvagts/GfTYSCJ7HhMFqe5RObPO4Z0+8iLi8eNWA8yXpfakJMwTgksx+8cST9ZA3fom7gWJvSbnR6/tpAGb4mtccCRfoKBcc9b7h+Pcd2qtl7ITXyGkQYgSDqXeeduuZE28p/gReBYFbcHhUDUUozljh2dvOkKJoWCU7/E50tq0hjEu+1o8t948wLzyKTS7CHkeS76uM9lwvKsI1ONcp7gebadcyGTvNkh3izwX9c+lBH77tboyWE+F8Q960cJEJ0M4db7JdqndbOOtBnYhBzAxXtI7bnPjwre+bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 02:30:46 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 02:30:46 +0000
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
Subject: [PATCH V3 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Fri, 26 Jun 2026 10:31:21 +0800
Message-ID: <20260626023126.2189931-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0324.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::19) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 237d3ec1-3b47-4e63-178c-08ded32aedcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	W9Y8iN8ajsRCyBkzb7BzY53MIs7w14kpxgT441lP8p51z9Vl6RkqANY8Nxdasl97ZkDd0xXgSE0JPneudZ3PeYQ3+O5xjtVuswP/bgdjD3rh/5K1QD4MQXRcHDxw7SmK+5EfxaiHAhHpukCZNjTTtoIwjMnUsr1dqxU5qt45f7x2Icmkvcunfk057AakdK8uAUwKGojeb0Xc8aVwA2u7qSP0WhaONsC+SPkA8fQDYhozyS7f2Rgi8HqcKiMobpGi7dobOrImA+PcAzmaGHQ6GfoiRAjOdLwQ2YKIAXgbEqARyR90bcmnvQjSWrLJQdr/UCD0yRxiWjo73l4bXVTkrpK17W7zImA+FbqGBueW++7Vvft+btgAa9ZW3SK+nzC3DcEDUH1MOdyRgKBOtEuaPgLvgUwPz0bZzsj0sUf0Y+I4KomQgVQ9a6VA0MXKQVJ5osQKzH5AHxLsVRiAOZWBoTVQGudv0nd1si3aGdoErvUkxLeIyIr2uA+ZhNuj+rhs7ebheaV+UTuDzQmLdXGuv3/X0IndcHEeXxSNwVhUTzkqgMo3XHe9US31ZhzMsaALp60baKkB9kwSks/myhXwIgb3CwGdDWez6byGAeHZT7g6jTRJRrabCQ8ZcG1IenA13i8SBO1r7ZDbfiauC/du5UIUv9uS/+cLFF+swzgW6aW//6KolZXKaev1UcWn5dBnfgpOi8zy1u8BRl7k+xobFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bw/UuhSJjBOUtwa/YQ/Mpjb3+3CE22TllWK0GnazXIIYkM7oayG3Gv/25E8N?=
 =?us-ascii?Q?BEDCV3A7lh+x2Uv27yooRD8CxOy8wXLCIPGpesiPayuePN/1q/k1V7/uB1rQ?=
 =?us-ascii?Q?fOeZ7jADOpUV5PU+K86jE7gcj/bjel+GBisb1aGiFeMqXg+LEZKtTb9jLbfI?=
 =?us-ascii?Q?Ocs0cepxwB6a/BpAuVxufDjljBSC5QBg4UvJH3BuYuVUwpWZP0YcVhKHXpMD?=
 =?us-ascii?Q?spP61+ErknTF87JiODAO8DRNrBrbkoUFg5sRURo6VPIlMYJHWbPgwlbnq6Fm?=
 =?us-ascii?Q?FNHH35oftPovw4oOXX28RzKcUEHDwh97tADmUWf+b1roZLtzzJWdTKLvTZ5r?=
 =?us-ascii?Q?Ar7LBnVCMHD1h8NZ/eKoQ0XUoGGHWyc3DZ5DcDJo5IAj2ftM4xIQeRVSYK2S?=
 =?us-ascii?Q?1f+uGVcm6WCUZxsy2FUga7J8n72g2b8Xk91D7rFDjFE8xl4Vau9hoCrXMAiR?=
 =?us-ascii?Q?AaRu1o3W81KcAe6BccvHycFqGCOIiAecD0f17iPWRt1nHbPiPypxLzbROscq?=
 =?us-ascii?Q?daod1I0Yn3GH+IHqozintriV2mnHPmt63LLZ7m0Ay9E80Y/6Dp7BzYLhOnA0?=
 =?us-ascii?Q?kYSu/tDsYveGepLkBgxYbu9tisP0Yk1jsfMnYcs7hP6obhs9D4uRgfhj5Pa2?=
 =?us-ascii?Q?+H8A/JtD/L5F5eS10Swrr5BwFX/0BmftinsKIoHjXKe/AuuILlpR2iUx6snq?=
 =?us-ascii?Q?pnBabSTbhzywckl0avB3G2tpl+Giyf+sBDqMo+WcjixSQsNNX8BhG3HIIJHL?=
 =?us-ascii?Q?ROGXZ/bARG66jxs01Xd4jHyY3eySF3UtOdfszNIXGTY2IgJllhUpJwoMMySq?=
 =?us-ascii?Q?Vk7DruV/pnxzSv47jW4O9V2B+mSommcHF4Yn5sQvQQqpvu3zjKaYKymdtE48?=
 =?us-ascii?Q?uSRTCpmb9vWljulcmJ/2amb4zKTPx+RxzH3XNcJK4JKGD6JmxDDgFfGkgyxd?=
 =?us-ascii?Q?CZtgxe//whewZU2rseVdYxj8cfEHyugue35y5TVzZlcAz+yNsVg9/AntxcUv?=
 =?us-ascii?Q?vL4GOh8GU925z8i18nijVO7cuHCq/1E/QZpfYkdwI8oWltNu7i/Icajvgk7C?=
 =?us-ascii?Q?48wyvhbpmV3yo6+0Hq9G9hNuNVHRoHDD90dF0KP/rqQ9CP8AvjNF31MtW12b?=
 =?us-ascii?Q?r0DvDkqjiI5R9pdf3cw9KfKwhngfU9mnY+oGO+GLF7eFTJlZDGq5TkvBAZNe?=
 =?us-ascii?Q?eogLXC/iBCugDU7TSQzyr0Ebzy35rVR/Ph/23lEPFHOluyQvGsY3LKAwBNqt?=
 =?us-ascii?Q?dXMtVbnTyMhIkMZUA3U1DNUngmQSj5P2IzKuqg+YmBg6g9CjFK+tT4D+gDAb?=
 =?us-ascii?Q?ywtFO1A0DmQb3hL2RY6sKPmIUIaicK3gJvYg6YvJ2fVRETkeLunw2tPIWkZC?=
 =?us-ascii?Q?jUOUuxkjsWjFx3cR0P2dmHbWPLmQyIz9WFhX8KXtAyjVtmatVbyiZOSDM+Mk?=
 =?us-ascii?Q?QwEcCxMwjVlpPTRPmErVXJwDLxnbEoDzKq5quFqduf8xL0Yyo9ftr6W5SjbK?=
 =?us-ascii?Q?lJtqymMEUOgxaJvwWx7SJTfnAOZqt1A+MqpYxfTAL8OheyD0cD/0UEiGM3gF?=
 =?us-ascii?Q?fGIPjdMU+ogEeBg3V2d+3iCwLZ5KfnbBcHEGZsIrv3cg6o3CFLKk8PvGLsXH?=
 =?us-ascii?Q?9Yzv+zd8vBHCp0yXB+FsvpDISpzJu0zfqa9Lf2v5DoLAHYwiJfcoqwNH2raj?=
 =?us-ascii?Q?IRxuY9s25yxbw3Cd8uIA6mwrZVK0f8UpY50eCFx/JWWDoDNsSnkH3lJpK3w0?=
 =?us-ascii?Q?8WwNwv5MJGQVO65A0+0273LP0Wh1kc+FyDlaIFyopvqwm1jp1xyI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237d3ec1-3b47-4e63-178c-08ded32aedcf
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 02:30:46.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw0IzZtHJwZBZ+yPxvverYRNOOdAPLHz7rF3VHqqiH5yxmXK/NvAiDKIsbEmWb0xD0LJj7/USyOaKfvB76GPT/RCKhVUZLnbnyhdgfTE2BegYHYFy9q8zRzpvtifl7HL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445

From: Sherry Sun <sherry.sun@nxp.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
pwrseq_power_on() is called to power up the M.2 Bluetooth card. The power
sequencer descriptor is obtained via devm_pwrseq_get(), so the power-off
and cleanup are handled automatically when the device is unbound.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

