Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793647654;
	b=0awSPV+ySsNZ4bpuoqvAqqgkhtjSSxo0V9cxpztdE+o7GzFIDPq1e8AXCZRG3kRaZZEk
	 tXtS57MPAzpzEHdHd7NYENaL0WBqKz5cikVLyB0NqL6V0y7tJRAvz4tWij5IQQfZRlDaK
	 1+eVX4zWBUMtKz9wz/biOCxsGP4WbpefCClB+6SGQQk5Qs6W/BDYukHlK4ZeJHQaibs7i
	 i+MNs86KDa9qiqNVEcG9TtfEWmhGNwKpXmr/ukJ3UmRMfVCf6Vly9kZItKKEj9FkeUlK8
	 1ZxqeTOmC+BK5cQbrwSSt3FTggTCt6ZB09PLwLzp2ANjgvNa7U6vr60ClGKkjFw4VHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647654;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iU2tKBABchSHhKRBnRGo5E5V3wNcEvHlhJj5f+v1Gvo=;
	b=kfiqnRNqfsTAyuEJChBnk5MBa4UEwb1ejlPILO58prrZxTakewm1S18GEn53JZGqyyyF
	 1LoI6SKcLnTz7eG9AOjT3OY6O7bhj6WDzW5yV6fkSJ4Uz3KNBZEL8d3gMBRunoAdoqe79
	 JuADl2vWXl4Q197uIeC1+RDT+Q8vtqVv5a0RA62nBzeBZuAy/Pq0ZKIbP/lAIZ/7C6gUz
	 pfBj3NvvVP4IR9Xry6PNyd6A7CPF+h+kNAD8oa7MbUll3qL7FqB8luqq+OL0WqVw4bG03
	 eeYLDhmUxyNBLVM/JCO8CUjmm+prNECZJZxcr8kfVLr7cw+ynhPz2apRcPE21fsVTRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wfmpV0yw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.62
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898C606A329;
	Mon,  2 Nov 2026 19:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7898C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wfmpV0yw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx9jFV0eS43ZHPkZTUVjV3tleXJspF+xt08EobC1bB1Yz4RQgAx8txXb5ix90/Rg4qCoCG5Y/rRDMrsDBMUrrp21+BFHcyjLqmW2PUIncb/x7b++ZAjVxOGLrx49kRUdHcDAMFzIk/jQQfSiU3qMfQTxi3XuC9ZUcKCkMMr2kYBzyzrU13umjiqPq3Pt8TgEulZTCb0WUpWwX81x/flr87oey1t3lOtha9phP+eMfecA9dSMdkXzYNgBUwnpTHUjpGJSNpxHMVdn7WP1dF68jMOiJnJ3eH6IMN0SMhsCtQ3bH44KQJ6SkcGrhNvomUQz5CBnlWKvjkyPJfkRB1TXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU2tKBABchSHhKRBnRGo5E5V3wNcEvHlhJj5f+v1Gvo=;
 b=Tg2VAs5GHyOgZLXGf95rCJmKBZ4XM+8yAtZcXsHM2Y8yBSI4bSCIwrX9itFKIT6ftoZXnoaJT3zCqe1NpyOvrIqlyyPZjyztChAkfPkVIIxouWLj5WnFuZDcQMM3AJZQuKlgVUdcDU/AgQpdUc4VC/i+ePeazbNcyUmUTTu2SkvHO5O4Hi9FRAwcI60tM7QCA8iP/8kYHVT5VJ8nErVNonCxSSJ91QF3qy7OfkAF18I/mhloWOQVd/SCXyXcxlK1B3CMNvdpZkrPdAQOZpwnqUVsUs95+yB1vshNO/SlEvEVqUHL0wWcGaGA607I94IFiOhTB650MbFZL3kvmcoYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU2tKBABchSHhKRBnRGo5E5V3wNcEvHlhJj5f+v1Gvo=;
 b=wfmpV0ywFl3skwkwGanaMdsYkxyqt+Q4dP4J8NkVZ+Un2hl+6xOB2UqmTfEqP56wytohEp/FbjUCbbWnG8TrKkwpIERpZN2q4C7YFgUB/5wKqBqdDi/5Cgp2/qdWQ5kcH6LpiqjJUemo7gJw+OiNk7U7hMjsMPH6AvRueZVlPSE4WOflxWge7x893Bc+ZcTlF1k3YoJkT1ZO8Bc/7K7pykhF23sXAguriJXk1m+o5qRlEoP0a/ANjmARv82Xt/4bYFjCk/phz5B+djp3pbbE4AquueMG98qTte9vyqcXOYn/woEdfJf45gTCBuRZTwVpS8ZVWI0NjuZ7C0wFuUSzWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:27:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:27:29 +0000
From: Frank.Li@oss.nxp.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] PCI: endpoint: pci-epf-test: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 14:27:19 -0500
Message-ID: <20261102192722.4051764-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:510:f::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: d87d633b-468e-4afd-9fd2-08df39175587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|23010399003|1800799024|6133799003|10067099003|18002099003|921020|261102123227099003|11063799006|261021123027099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FH1Sr1BmVx5FKomPVw7Uk5u/8Tqsf1RjJD8YwyJCdJpqmfIEqqwiTGSdRZgxMBKuJDxhXDc+IXulXvC293ci9rxEToeSTUTD29vkKBr7ICm7sFDxv7YnYHDmq79y6DErO6woA4dBzpa+bK15AVQHP7WOgiwg51Bgsg871377R66LND+IrChdL3aSWPTW5UJy6XdDrMnqk60dBb/DbRNB4jR2JHuOXzSWdsSi7XbgTYaTfSrlmpY5cph98hYE2u/BYvg8HGGRVDXGHPYbxMdkS8zeWxCY9RzqIJ8P2ZW5wDBhUMK25im0QGvwleXm4ze+Iw+hRkAnlKTR3eO9qJ1pErVwk8jJfC5AOB+Pfuf0VrMLbEFkcFbCDP1LssXSOmzB2MV7u24MTXaD1vamJGP12yH2EETmdne/YocvRu3onQ6zG3uL7jGw+Hei5QIMyiVzuSblaeFioTu3UBYrRIzIy/IpqxBEOLNHsIh5mtEW7fzxZxGFIp3sT++OHcWAKxfb28+3JLhStWepR04Qcwe8P3TnPgY5tT1Eqwf4ggVLsxy/e9y1A6HWs1R5oCx1haDfY0jZbopQdmN6vkjPv3/QsdBNse05Kp8gdOXR1VIjJgoIpARGzyHRw67TBoZitZgYo7jSFjdA/iPOtm4RoyTARYJdeaebZUm6I7ykgXrkdY9RyY3xsvRZhz3o9K/KcXMSUzINbFTWuDZ8PxEblRzjdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(921020)(261102123227099003)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4KulBNq/b6YvFt9ynaCj6peL2cJKiFHcNDP9WBGTYTBBfi5Fbey8x8uLQMm?=
 =?us-ascii?Q?qDW+3MMZwfEleeRMnClprFNcIWnJ0lcaNkz30q4mgJ1IHqAhT2kOroOR6c9p?=
 =?us-ascii?Q?fYJeUiKHvKEtwdqpyeVUueGEhG6BC50HZPZtCaYAwJCVwRgWs7a3biBbFL6l?=
 =?us-ascii?Q?bWVCVaX2gUNkPFOvKtPU4PVztRZqVKpVO0zNVzeA9GT+DnQKM4utP3HzxhA9?=
 =?us-ascii?Q?7JTubxHyfzfKsZdGJ4RihrYzlGBpUdd4UF7CCBbXi+NnOGeHi0q3vjfb8nYZ?=
 =?us-ascii?Q?gNY17H0/+l+GD5dkmnOD2hFyZi5Cj7UrcJRhk6XSsKHUHucTg167dMpU3BKo?=
 =?us-ascii?Q?yPEJX/aDDadE9OgMhUh6mkjDQ9C1E4l2/be740F4LtkP3oMhxNBwbgIenI5H?=
 =?us-ascii?Q?Vsyx94V++KqxloyNbaN6JyK8uCv59sh1IKfZ0ZVVIOWYwE3GgdZ72/S5TzsJ?=
 =?us-ascii?Q?oqvfW5dPU+FqUrsm7LVhVtM7LT+Y2QU3LdVLa0RRAb3xuwCaKXUwLqQsURYn?=
 =?us-ascii?Q?8nw37GJ667T2x4KEb8bl3vf6Pf4sStW3xmanVMxl8fzOS18H7C9gYQHrJUAw?=
 =?us-ascii?Q?5ifrRVen6UDvpCgaWykPSATI7CNqa1xIc+NPi3+Y0Frdr5ai4EbCuo1Hj1W2?=
 =?us-ascii?Q?4SebwxNvfZqRHz8mzpLxYHJnWmJzjD5l+5TyhoWi/SRqsuZuktxwtWvE6uUA?=
 =?us-ascii?Q?m57Q4TPDFd1bAjl9se65iqZITSV7xFR10g8RXbJ2CsnUFxseAja35rp4nCi/?=
 =?us-ascii?Q?tA7n8f23O18mwpOrbeLFG0XyXq7L2yH/t0sn1LTsk/tj377nOAJqe2ySBJQF?=
 =?us-ascii?Q?3apjpgHuNJ/vUIlfbJ/6C7Om1qXMQ27u7H+RaHvrzDBWKlcIqwBPBYnqQrle?=
 =?us-ascii?Q?nH5xsUFWjJ5z2o1ujUBHk6kjLn3qdK7zrvt04syBE7oVMZxQ3BVzcm15PMgW?=
 =?us-ascii?Q?TtOL+whqFOlGp2PM6Fe1Fx8c39e/DgfqZ13w+jOBxvP/Vm/2fnsJliXplcvi?=
 =?us-ascii?Q?20yVjXV1DNTSPatRNWGqCRIBnSBf2vPChrcErVGkm5vXCS6Zhwphd/3guBrt?=
 =?us-ascii?Q?1iel1NllNDlGFvhX3DSsbvM0z5QzSjGZp+MBZFmyMB2MFlgjGGuFxeGCwzZo?=
 =?us-ascii?Q?38MJ7Hvao3iCn3sA0IcdSGhKzu27Hi6X/GQf6j8pYghNojR605rEn95VU4ge?=
 =?us-ascii?Q?zhmB9+ZAu5LAG1ePhcz1iRJ78StkjisEGb2MTq6kfQEL70SodrFJOffftb9A?=
 =?us-ascii?Q?NJ5BsadmmkWOz3V/LUhCZiuMKO2GHPWmEImxoYJMLZrS5hetBVXyYQQi8/Mv?=
 =?us-ascii?Q?5f5YXzE0ZtfGDT4C4yUT94pnRo4SCv9WiJ7Wuf9r8Gn246yVrqr3fJWVjC1y?=
 =?us-ascii?Q?DcCKvlw997HO3TAdbgPGvir1sJMb65l5aS62pruexg0KjCzOH9CEQB6Bg9t7?=
 =?us-ascii?Q?XVUPfCqIavNbRZCu8iXMWIxii703d+8XTAJ53qarkiTfWi3+FukWoCgz05df?=
 =?us-ascii?Q?OGZg2J4A7Sfns63JhkfxFkNb0syvAquD1/JlmK0FRXK7WDELGA2aDfI6N7Lr?=
 =?us-ascii?Q?4noP7zaoUcrnRbTgjbMGABEy498XXb3FBFiCNKK7cve74D1sEi2LUCqJae10?=
 =?us-ascii?Q?D6vh+YEN/4f6M/cxPTDWaz0jTU7T1sL2v6sC/rqxmrpQnU7Uxa3cZbFuegay?=
 =?us-ascii?Q?4OUVNma+N5bOsiTQhi83FVrC1JRw4SLbGPwgC7C8ypGVCzx49TDPOQ1xaM4c?=
 =?us-ascii?Q?b5eVl+kb0BJ5HFbtfcgeZYImoLQP4mwft7rgTKmTj32XVao1TvaO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87d633b-468e-4afd-9fd2-08df39175587
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:27:29.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnx4J65aRUGjsXlsEdkPXny5VVoy09xaZ5pC3yIEArtEUmNNaIC55NaEYXPO2oFE2Wq8CHDtiNLk0bBzQktNXb/oxuMNGs/3vbiSZHQ2DGDHc5P10JsH94qux71E7s+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa8e4c01..3ec7e1a05b2b9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -197,8 +197,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 
 	reinit_completion(&epf_test->transfer_complete);
 	epf_test->transfer_chan = chan;
-	tx->callback = pci_epf_test_dma_callback;
-	tx->callback_param = epf_test;
+	dmaengine_desc_set_callback(tx, pci_epf_test_dma_callback, NULL, epf_test);
 	epf_test->transfer_cookie = dmaengine_submit(tx);
 
 	ret = dma_submit_error(epf_test->transfer_cookie);
-- 
2.43.0

