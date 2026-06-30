Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6A3F1AB6;
	Tue, 30 Jun 2026 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815444; cv=fail; b=iubfcL2m+tax71rbx1XG7nvwBWa8T12RDKxWAjT/JQJGNnOVgfq9fLIjn9U0CNmmRPM5OVxCYKZsxpTU5uj8ZKOVS245LW3ByM5waA8Xm73AvnAq6k+uGG4RvbR6F57eCeM8fdArqGdvE/yxrqEFNUiKdpcbR0UUmUjm0ro8ooI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815444; c=relaxed/simple;
	bh=wL2mn66Imzta5Ic4KYpjVqw9cUBI/dxyoNYKNcpnugU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMM4LidQ7TAnlMlgR19bFPLG1nZAnxMpdjZqlxoYsYc9GHGvFFTPHwN7WqrTzhl02DOgIA/LPU0KtLcUsKjBb5LUMJEOfsjwV+RGmNNCM/QR18cjYHiGbC36kZRXAzZvre3w4FNA1cV7BhNmcpvI/R3nx14jINL0+OHZNuAgDV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DSQsWOV0; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DSQsWOV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZCoNkwvz4XWp0gC6Q7+iZaiYuFtWLRQnPI/GR/04pF+ZgbzytzC8p8mq8fc0mml3qmVBk+2TAOE9iKCCEsRxL8sO2pKfLIsTYPopw1F76GFmfaBL2DtWWhVxWWQmLr0eZImUu3nLZMDkl5lPN5Jds99Q3GuV1VMhfJvbp/hv+hDaZaQY+p++XdvvqEx831UzHgXKqH8obbGLQAmWWunkPU+Kz5Ca3cUtP96iR6efMfNd2L4GSooEmNUbf2Edyf5kiDuIy55SlP1yvUOiNcNn5rZzrYjzar/VlE+NGdhVsjob1BinkNjcsfUI7s4pCRXeO27IHHZjxaTwEN8EIExMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUQW25S6Bhys8Qe/7LDT6iVVuqhtAZpKp78g0YFbPMw=;
 b=TdiH7m9bKCveCSNjB9Ib/dykaTxiP9ZApqlR7nd1FyZ28X6JI91S5Zl9uUOFTk7Pi1p2Omgt5A3mXDz4KqAoQ8CTb6Y7ILDfg8RYaG+mZizlYSlbckVOk/XVu7ZgZvGT0VyERaJtMUu4OQ587kM94Y+cKAOv2abz+VOv1rRtsOGowUPYhz9GTmnsO+qfCt4pXgZ3rvovOc3AA/JZKsk4oRk+EiPHMCbnw+mHiItwg3RmiuB/0uckrEG26PrE7kVfUnqPQqI1V/6DPuS8YIlGbFoaXN8e4xuC0FKAobSWbrR5V2Udw63rx+JfyTB0QZfXDFneLFuHhDaxqoDFWJufgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUQW25S6Bhys8Qe/7LDT6iVVuqhtAZpKp78g0YFbPMw=;
 b=DSQsWOV0BGSVVKNCdMfX55QzosuUCtTE2UHnFALcWodpmp4Kh4dfQJAjE0DtAqUl5yqqkwy65V79yub/ZO0WQXPqZV2C0D5zCqmQQGGzeETrPnsykw7RWVuhn+YGZE8WyIwcrS7rdIBOTDg0/scJyp7EZAC2rx7e2GDEe9q/uFFbxPSujBnG26tNM8OpuTRXnvNwodzzHsCzHTCrNC2znQHKT1KmXu450IqmeVBYBxqelCe2Hh/Pi5GLqobYOzZYsdJwLi+mHSPhvd1SV20F5yb8SI8l7lr487nWlf7XAc1H1dnDUMR5pzhBHY/4zLsZuX/i4ibdUKnf6Zqy8KGktA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AS8PR04MB8547.eurprd04.prod.outlook.com (2603:10a6:20b:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:30:39 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:30:39 +0000
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
Subject: [PATCH V4 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq
Date: Tue, 30 Jun 2026 18:31:34 +0800
Message-ID: <20260630103139.3823329-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AS8PR04MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd5ced0-28e8-427f-4d6c-08ded692a0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	gz50DuXhbSI8TFRTkHYc8TNhpMRT++KUVzJVJQ7/50FWRBYED+u/XvO7xMwJbIhzaXrkRM2tPUP4kw/LB6ds6KvlcYrM9DaPMX2GUHtIdE9mHnCeM/+lUYWcTKAeKFVAlzYd8owi3iZ2QVOJC+CD+MbnA3f04Ilv1t1nVKsOcLOoxdhYPVg/wyQAQcXT9MRVUVXLTcxhiknhnAcp87OgRDDxQ+YSOUKg7/GRfsjB/RIWdwZuZjW58UNt7+1pR0gxCDAfRbRO/jUb8c1Wpyz7QO22U4uFEQh1GZbeTL3Sv4gPPHYoxPh/4yj0Cg985g7MOWBzwgrfkP8FcNxpCoxKX9ZuWMbChBBeHicUouspkRuoO32UYZJJpxDDSg2a6JEorT9ej+2BWEKU6XUdhvySQ7o9joADJshzBl4l1OtW9hGr3HbFfhA163sgpxbgR7XiB3RZTuV+5s4NdCUPCGh8I3N8+M3gvnMts4rv4bVESGwYsGkRse65KQO7b52leu7DrPrF+Orb8bBA/db8V9Wg/MAcNzN5Qlh1uuilCGewv67rXsyETr5hrxBvSIfvOGCXCBw7Soxm829DHX3UQHYstsMvpnGATMIItFeRrL9ivy+tg1ughaTHCHPk8pvXoJb9tRrh/Bz1VFw1yKOLmfbJPKH2yFQg9mbmiWcn1ChNuImknNydKx37Ap9zeRtzLnx3Tbp+jE6QiDGvmGUeIZQ3gQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NA6ZyAgA4P+JfyfUWzEOu8L5UmklfirlrHhR4xk9zEmGXjlA9KDsh5TLXIIf?=
 =?us-ascii?Q?wowgMHBpHtFMK4/4iRESNMs9mQl2yOCznrs/g1yFNLn+5PdQtMo+VUm6ry3K?=
 =?us-ascii?Q?jlnkobKIFoWe1QlO3y9bpXje9sVlQ7JNHYWIl/UWPS61o8O+fB6EJo1l0lL+?=
 =?us-ascii?Q?kh11+dFjqNyh+UDHfDAKcrwKoj0Am2BeQJSoHFqNxgBA9Yp9eE0HdPp3bNQm?=
 =?us-ascii?Q?IrzVEUkhUoZTdC5OZA9x4PEl+h6JlpNVE8Hh0bYycQ5UHR8Myd/kri1ViLqN?=
 =?us-ascii?Q?cMQgVR27bohOhx4Q8rJXXdGv+7Klgru+hI0djuWgCP0GQYuedKK6GXLy7o8w?=
 =?us-ascii?Q?+Y7uYKDHtJiir+CdI3ImCjEHioaIK68HubrwHtj8D7U+gpfkj1AjZLC+pakU?=
 =?us-ascii?Q?cGBZxz7xA0sfZdnB0Xmj12VuPWpHDhrkEUeR4Xhx7Sl5Qo0uqQpi9SUR71dJ?=
 =?us-ascii?Q?qbq1hb57nlXp4IJsSiGY2GjLYKwQUOnRA7QSPhlqaMbYV3QyHBcY9k2Xl5Dg?=
 =?us-ascii?Q?JQTbnAZGIYN+kH5HD9Qk0Aa45HQ3YmnyWqF4aN59p66pc4d5DIsKjAXjbfmF?=
 =?us-ascii?Q?VbAFyWk114jDTdZxxKitJGI3mFjcLMcRHCp0nIDESicHITQOI6kUN4EgPrTZ?=
 =?us-ascii?Q?uWEQL1UsZ3taJm60lk/eqRI1l+Z5fISdKQd3iXflQsKfF1fmU9B4N0B8z5FC?=
 =?us-ascii?Q?smZ+XNzvzcmU/gHNpcoAcl259g9hKCA07IP0K+nGr1qAdVCn2Rt/N7THZI2k?=
 =?us-ascii?Q?RLRTDEPRVtgkm5RVOX618mPrHhO8A5cMLzT4Ix8LxPIIOLtoY+yl2yzKssjd?=
 =?us-ascii?Q?Lr5CUQZApfTaqSsSiKGjY/tgMnvTFb2zoAOnW7tvw0/AIAqK8PtuNBH9jbB5?=
 =?us-ascii?Q?NMy+B28M99bhb9dQ6GMXnA54c0m+IOPIY+jbXhMrl80P4rZ7k0vjP8LkgwP+?=
 =?us-ascii?Q?qSeB5X/Tazh6ZK+9U2wWb49uuetuQexC7RNohi+aHuoVxMsHWRBzpjZTZhMs?=
 =?us-ascii?Q?iQFw8YiY9F4rlwvOHLu43nQWTJiQJKKR7wOleEgn6TCSHD9PGqtIop4ADrvd?=
 =?us-ascii?Q?UZKepKg7Pt5CiUZA0YKIPI4wXIc/2CX3Ben22S/q+ubEk8m6hMs1C7l8MI5a?=
 =?us-ascii?Q?g3JXsbl0yDswQGuL2awAVDxVNgf/MG5Y9tyzTe8Ns9bFSiM/LuNHJEl0qd6p?=
 =?us-ascii?Q?pZzQs2KOjGKxx7hmFJ4/yXTYGxzZCkGxDsWAbiI3Zsw9BZazFCUpUjMH5nln?=
 =?us-ascii?Q?2a5eXgnm0fwdapaFPTmKM1Y9G7JhPsUMXXsD3ri2zTQe+uxvjOxvRdxlIM+j?=
 =?us-ascii?Q?92ciJHTM8WJIJfD2pe+cvbM19TXNJZtncSAqbrK3xDMK5Fxp+v/FrTumZ1u8?=
 =?us-ascii?Q?8NhCpoNR1hzY3Tcp5/Zj7qSZqRw070cNIT6IAY8ai07Di9fv9nwZcIhka5qz?=
 =?us-ascii?Q?6fiILTMPkukFAIs2uHGPMAKzqvZoPHdFOMkLdcip49ccM7Q5n1OawmfDzKXE?=
 =?us-ascii?Q?x3cCMadzJFV8q0gqTBqZPsg3wCTcB/b74+myS3m+bEhs8Es/iZ0eWhyPBpUh?=
 =?us-ascii?Q?MDfjXIlxgv+iV+9CkxMNJkYHiTQNWpGQYvH31vHuatjt9yOgcan6G+O25Kot?=
 =?us-ascii?Q?CydD8Rc66TGV6Rnt6ri57kBIk5mzD5+9xAIKZ/eHnj3VewXRUj86QnFKzI66?=
 =?us-ascii?Q?PQ6j7Eh3pLJj4rO9IW8HeOJxOqdRb/CTMPc5AkdwSh1hF58/LKH1UJuviPca?=
 =?us-ascii?Q?ecHabrN//HCF5XmYTdfq22mXn8iQcphfTllPVFMIkbaNOE+1LZzY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd5ced0-28e8-427f-4d6c-08ded692a0e7
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:30:39.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etaYfQ2Abemp7W6+Zp6meSpMkE6Esaib4qkcvvPRFs3C2uDBUf7zOQwQYFLGPQGQjc5wImjMs9Kwz/dyD36RFUXQ81UmB7YN/ZHWeNQkdab9JQUc9CtGZA2GD8JlSTE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8547

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
index 6a1cffe08d5f..fc5ff23ec1cd 100644
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
@@ -1872,6 +1874,18 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
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

