Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793955633;
	b=ePatC3qyZXJUKWMxvZl1M4CUXY1dSzEMNdzC5P1PCyjTqY02zK0mDQ8GDhuRk6O5tgoI
	 bBX7DVV1qTdI8hQcZST3NssSoH6C2t0ap8QvkvMl+mrRP34Z54ym7G8SUYn31cVxrgw6w
	 i9GV/k0JOkE2xiSfGxUfxgWAktajH9KdLfE83MnwRAvuJ4nwmXtow+noQQJ0h8FOMP0YJ
	 gkpGTye1EvT5a6Rvvhl9lSf2NjEFZlGuSZZ+XBPI7BkUgeyt84SSwUK2zG2Qpu0fOKWSd
	 O96aHzdMNkb0rB4R8/61TUYiO5RjBbr3sIkUEwq2rfyniTO2ty5bnbTgkaeqxy8EHhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955633;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
	bh=1w3AzzRYR9DYbpvsWJJRIhrUxpVqjutTSEJqg0ka938=;
	b=ER5Z1pU1SdW+3snZpYPAY0qcrGt4f+2jsrjr9bPIyqPdI89Og/VgGxz9FmKXXqurwRy1
	 6xLPYH2qgSAeGMh3orkkWP6QFT9/C5VM8eD7gjcZ+NQXYviO+WA75XA3/nU/TJqOwDvSy
	 3Hv+J76lzSyk6panoFwrcpYipqnD3hQuFdiSBVArOSFu9+zhlKi8+nNsAljuHMOV13lj2
	 fmqxBeUczEBx0TVspSoMk7Crv+roQCra0sGllzrPennzd3kohgbp8RrmMqTbMWV5xdJAW
	 lEpcZ9rUn9HWPUjwxzkbS1Yp5yFkYpSlrK7Ht/b/zPlOJTeqUth54plWg+HrIEY1SIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZTdRwV9j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.24
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD19606A32D;
	Fri,  6 Nov 2026 09:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD19606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZTdRwV9j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSk8PvoMdmilQZvKIx82yy26vdWGIY5loJ2UXQyF0UDU7/7YTAWA4sCJGOk94k2/8IfcsuSmG4kuhzlziQqoa9nV6c6E7hdcvlfY8y85IxvKQL71i/6L4TeQizr2seQVgDj8wclBTrZ24S5MBiCOrPfejiuvYQ8Y+uZgxn+qLLZ+g4WWXsodSTyAwFKWbJ742HPJrt1Mj8nJnX9hts0NV8tT54vZtCtZnX1AEpKuJP/PF4NfexaF4AFBWidVg3sMn31TVKmg57XH5C/khxGFgGlUVrQJfVHwMtopOE/Xo7usVCMqL3b79zFe8NGSrae6UUh97s+94n1ucPpq3BRQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w3AzzRYR9DYbpvsWJJRIhrUxpVqjutTSEJqg0ka938=;
 b=GtYylSuf4YgIBG9UhpMACPIvyVYZNqtbdXU/jn/xBwXUNYfz0Gmlg6e2DEM8USjGWL9pTOr6kyq/BIoJ5z4qKnb5+vegEGKsFOAX9+MkOBBAwVK7tS/nAqXgTGw/fXJR9m9kAg8+eB86OXi5G8NbZCCHTbZC9YNJT9Vt0+zmKG0DChSPkCGlOQ0xyKUI1nw+DGnJbFUIf+jUOwxwXqpxappl0kXgrzlQKh6Csyjo7ZC6EliYw3CJgp8D47KROn/xcp+5AXKpa0rcj5w0ufzmegmUbEtx/Y34IAdBvxF0rl09DC+jSnVos6o7+IOO1TPbcQvHSfeXPjCHmKerBUHpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w3AzzRYR9DYbpvsWJJRIhrUxpVqjutTSEJqg0ka938=;
 b=ZTdRwV9jUKqsZqOl89jvuBme8B1HNZDHjpwMsxLCbkjYDzBiTbVBjUoNQkUtjmjqvqhZj/7mnC4HdMfrrsLUoVcuTYtJfEmr0neNI/N6tFap4PqA8HHqzpSqNyFH8M0sGCB09HIiSTcqfrJsJlvFnBKG9964QJI81OvUpjWADhVR0j3RF773l3Ke0o+bDmlhCA4i/ASbWfwjesg3FSxR+LJAj99vfboY5UYbgTE+LNYpnNl3lklNOK/xjwL7LOc5j9dU+QqYdIa2SYie2g6cp8eNwE12Aq6F8uRBoEZo4WZ3kQmcALvdhPz+rzQG1EY0krBgQhSu9rG9cxI855F9WA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 09:00:26 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:00:26 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@oss.nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: imx6: Enable L1SS support when supports_clkreq is true
Date: Fri,  6 Nov 2026 17:03:42 +0800
Message-Id: <20261106090342.2601665-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd84dd1-e886-4606-9c7e-08df3be46637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|19092799006|921020|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OwZ1W9EHgumQct7rUiBVXzCbBEKa0Z/CpDdIYwgsRNw3rRPR7nkozmj0JMMA3Segg2WzDnHU3t6JZb2zZntK9nHXwohKbUqRWfwpI6q4L9yMBNcgKF0zzLBVE3ecW0agsypz5b5wCSWa/D6wif52ZMr2/xUkI0LshddEvvclLe8TLYRUIWa5k1hAdaNwQfztCdcMSJBXNlk+p3pYN8HjnHM0RSHLDmTUBBjxUxnlqyZ6h+JsLhwmbDXTZcRx/e+dM43lag7D7UCPhYxsE/QXDLt3Y5gh8kIcpGG0QSD51IydTqeA5ez1O2+PgRr/YJW8B14N8R1O2IGZthBYXz/0JQkkmsWakbVZ2Z6fb2Y4RqggdB5VXcQVp+uRg6ClJ67mYr8ghpUCLpKtFAv5Zc0/26qHeEgc6bmrAEfUDsSMOkXVzUvNMBVjVAC0bIFM+5DhIHHTejcVWaGGdgM+VVMl6wzTowxh6P+u04SM/5mme6+fgYPuTCs5j5t7JkkqbQFaYXB3iCHJuKXn0LrryXv0JIOErmKKmqwRJWeOzC8BMH80Z7UGdvogWOy0sX4rBeIkQyHgIhjCk1mznfVQYRPRVus/aPkL16STA7jw8RjPXa8VCHCX8pIi0CS86TRm+QyrHlspOcMITIouFG2UWopr2oGM2Q+KBmHpyGT50TpU4d6rvaNsQyNvVJ54uolGilkJLr898cJXRivSEHt2rRXsvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(19092799006)(921020)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjSUyYoDvO80kPYRfOxy8X18yBkcgmIFEPedq4FqW7tG/SYTH62oe54T85Ey?=
 =?us-ascii?Q?hpdTYl0g7P85lptPm5DQfFnqy6GiclCZD5R09GlPhVo7/fHi7vo0s9WWaxb7?=
 =?us-ascii?Q?Z9HEwUoA52xyqMAEZuIu/gnmtYKuMWkJCtdhIFVJFTWts27g56GOrvJXlxfD?=
 =?us-ascii?Q?Bmc3z0SwRjqe/hC1YChC6aj7D8K4kENs9YkHksuIXJkfryxKVszV1anWVyvd?=
 =?us-ascii?Q?MVLhfPXauLRYIFN8oAxJsFpQQjfRBjyWM+ep4TgpsC+eU2H9LhR1vUO7C9Wf?=
 =?us-ascii?Q?wEzn/O+NxErRFFjPN9sb4LPERDq2kL7YjBtRD/LcxG1+aNgCI8k76U+GA/7A?=
 =?us-ascii?Q?as6Rdkv2pXmmAHF0wfc4EoT5S0UnE+VPtAAvbAwyS81vDKb8bYEM+pkrZodl?=
 =?us-ascii?Q?N/0eHrAt9eIuz2qXXTEsvNvPWcrk0MoG1ajgNsbIcDZDFRtCwyo2ozKX8yso?=
 =?us-ascii?Q?YveKRBJvgsp19+YTz4NkL7mzb6dvqeeNtRynPKrUnU0Cdcac7bMArzt2yP5R?=
 =?us-ascii?Q?es2GwXc8gVe1PGo1sR3e2itwJ50uiFiNVlO8CNKS9mUBBnA1wsBLcoYh1dkS?=
 =?us-ascii?Q?O7WIMeHMF6jlM8wueUCx2JZSZI3n14z/fq098jSmDOMnSZYSniZKe/XQ40yG?=
 =?us-ascii?Q?1MBmzBRM5VLSVvmO4ZMmJw5A8wXd9FEGVjANF+Z/Mgi43n6ic2koghI6irST?=
 =?us-ascii?Q?BXEf3A33l0+G6lVPWnEIotnRuybWDGJkYqNt44SI2gbsj8Eh8xJnCWRuricD?=
 =?us-ascii?Q?R5yY3xUxa08xHcbyagTb/TmuAKcAwyXHtlon/OYdYCN8Aq0I0/i1LTlW2noE?=
 =?us-ascii?Q?oDcsjM1YGliiCgVpLlZiguiPKSvDgNEnjsxYsmwbccgKklAZ2Y7anOdmU5fn?=
 =?us-ascii?Q?QFWG6aq3VTntqzmhT8DtLH+pA8iAnuA1+gvR0WdsSHsIXn0eIuntThV2dSCo?=
 =?us-ascii?Q?rYUtWID2VXLhCsL3usddEJJlZr7o2xYnL/dorenV3msK3d5oqxc2PNe9pw+s?=
 =?us-ascii?Q?PKlx0xbqQoecbBGvpC6RxH6VYVNTa2/zObsI09GpVAoDWWnBotOzZnqUChRl?=
 =?us-ascii?Q?iCIBfR2UnGfSGV3mZImGy+SchCtbsO0gDTbIHj3tLYifyIUmQF06+HG5QCc0?=
 =?us-ascii?Q?gMmQq1xn9KHmgbOXmrp1i8RTgQyGqnUEltGvxJbyMvAAmWIlI25UUeyfs4C4?=
 =?us-ascii?Q?cBp70eT3ENn4897qtnq7eAkX5+MOjRFHX6bt6Q84BhPFhPwDR/9cQSOQpumv?=
 =?us-ascii?Q?lmiDbLTDo7akxncbe6bPQ2pLg6TxkXWumUBGdIgWu/LeCUAu5q9B4R8opSKb?=
 =?us-ascii?Q?VoCj/fkzVVjV451ZWKI57c/bLHgeLnVTN2/wtsV9wB+Ywnzyn5Vt6yoI+81r?=
 =?us-ascii?Q?ugg+Lc6hHuQwjxSN7XQP66pBaIO0RQnJbzn4p7GdnCh8c2nLY4DeyFHJWQot?=
 =?us-ascii?Q?G8OxDgqtz/XmRZsvOOWwXKdMtaaMKz/w24YDcXNXwLwTF/N9A9e1n764KoIj?=
 =?us-ascii?Q?5cj8Sz7Bpi61f8ky6OumQoVkwMi70/AgxRM1fosEFTYBjVEkhie7c08a9cD4?=
 =?us-ascii?Q?DlDA3bzj6nBzH77f8kLt0voi56DFYXzD1tJ87NtdNFrcgVclcKb9vnDRv5qg?=
 =?us-ascii?Q?qZpO1gcdkIZspMGg45Cz/zqRCHIfs68A0YfKUP/L+t1JF+zk5CT+tzoszhrO?=
 =?us-ascii?Q?iIr4SMWDMU342+2YGwF+VMTUVtwyS9B7LSjqgAhFAenmoOBfIO3L89u+FkDk?=
 =?us-ascii?Q?csHdn+DbpmIn7sVcnO5eRkIi0YUo/4BzESA73IKKcGf01SlCcIRg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd84dd1-e886-4606-9c7e-08df3be46637
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:00:26.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMbwyVyEOIeRCnGQJ/0beZ671z4pgPXLDIkO/Mu/5Byg91nkR0UpDwAAKrVbCYV9I1SY6e5lr6GrW5/qAndEbqYRv0YXtCJjYL+zQqlq318FaYZ5waQ1/slB+RMpzfLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429

From: Richard Zhu <hongxing.zhu@nxp.com>

Add support L1SS support for the i.MX6 PCIe controller when the
`supports_clkreq` flag is set.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 83fbd998551d0..4eee02e135656 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1501,6 +1501,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 
 	imx_setup_phy_mpll(imx_pcie);
 
+	if (imx_pcie->supports_clkreq)
+		pci->l1ss_support = true;
+
 	return 0;
 
 err_phy_off:
-- 
2.34.1

