Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020081.outbound.protection.outlook.com [52.101.229.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C42D47EF;
	Tue, 17 Feb 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315576; cv=fail; b=sa24I4SOa6vDjndR4syh44LuxCr/xxNnE1GX25WUAUf/PsyLumPvjFt1FQlt82msouOsRD+WErkbM2sqYhV9HTtBCajHVCGiW3sJLOj0K4UrZnzlOeem7Kp2gwc5Hmapftb2ciis5mgNgVjqp4hanifeQr/SEpur6M1mUfjgxF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315576; c=relaxed/simple;
	bh=mUTtB8aFb5kR+xTUrZ52lLRiPJEjgs72ScZvmKIVD5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o++SNkfG3ZqQQYJuoUUMGDEl8i7J+56O4eMHObSdf2j3/evJ8RNXsRXycPQ2Eb9Ei+ek98ba2YORx5teo6wD2n+I0YMg4+9+Hw7FyBOZ5TYVc5dBTx6xc/C5nrFSV6lH7TS+ZkuStPmLcLxvhBnL9kmirmsHPzfj1XZdSQV8/zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GXxLCKUx; arc=fail smtp.client-ip=52.101.229.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GXxLCKUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9DLPGzzoV5necupURYysGWBEefKFUmdND0T9z86RD4Kec6NN/dV/I9lpQhVcW1o681TB/WNU3dcKQKEtCRn/+zs801fi8UKDH5aH2PVzwlzQsjNG/KdLihessX17z9J2G3CzrHAquFmCE6pdR1aGoSfUGyN6ruiVD25J6FDWRVticSv2W17Lc8Xt+Aobf6wHg0aF+Dm8acpefg1yLUKm3ol4wa808dBBpRRckPnKKbrdD38+SxXaH1kJI0+e+8P7Vfz7bopclTQ9HTylLevl0EtfuhD3XH6qBb4SHeLHhbhSC+HmabKbj4OC3ZOO+SMMAZUrnPwES8OAeUbc/M6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spInnTauDhyUjwxofCAO5D7/6vcd1NV/KlDf0/6wvIw=;
 b=TqY1IYZ6Cb7DfLh8On1N9KmBllBtcPgGfspxKewO+EFMmxRjrxB2gnyOMfReDG1VS+P+xxlZecmvVltN4O5gA4KTZfjgEV3AyEQi506IlrA+6b4j8X72nClBB7/ECHGG5THaeya4sj74wfA0ij4/8wyHPniVx7nV4ct4DEwXIYbCL5EZQkyf8TCVJ23mk+B8tdhuAG3yaniXmrvpU/As+Z47UxZ5loXf0Safx1fNaJ4a5E+/qaJYJaLNnQsK82YxkDxGsdCpnWw1s0Rvpf7drD7e+Il6c4l76r5KC6x1+I5fqZg4ouiGYUrO6fW4DN+dcreLSOyARLf9KomKi09/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spInnTauDhyUjwxofCAO5D7/6vcd1NV/KlDf0/6wvIw=;
 b=GXxLCKUxE+BxKI/oue2Gbyj5IBq0/KXuie8cf6rroWbhF0guSN4zyka3YXK72GK6jOo37GEehg8eUNC9eMOu37lnRMZ7yxumlAvVaMpkazKIDEY5xOUgYN9jJ0QKBkB1uBgHYbozvHlxTfpd2Dd4Hp76izLhl4nkc3s+WQZDWUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7132.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 08:06:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 08:06:09 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v8 2/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
Date: Tue, 17 Feb 2026 17:05:54 +0900
Message-ID: <20260217080601.3808847-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217080601.3808847-1-den@valinux.co.jp>
References: <20260217080601.3808847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f852bc6-c1d4-4fbb-267b-08de6dfb68a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqzwQQGbprpoqxW7bsWnyeeEDndf3mtvy/XUVD92pGS0YU/HFQhXxiSHSl97?=
 =?us-ascii?Q?JuWB6lNAa3EK+A5kDz5+isApQHM5Vsj2YfdemOxDDGcAJ70rcOcafrguczmu?=
 =?us-ascii?Q?fVqi8yJSZfqp3o0pRIEBU1YH6VeP58qUCKT9/SMqCo6iFSXz4VYylDxyUs3k?=
 =?us-ascii?Q?zKOxIXbslxkIbzDIUeb5HgF50kcD9WwNOUJFLDy33tVkeV44Pc3a9/9gA64T?=
 =?us-ascii?Q?I1GFg0QyRtWaAUEXzTLdeo8z9SofDPmNHS2YYRnJ/lKhtXSjuuAAHQiM1Oeo?=
 =?us-ascii?Q?Lk9OScQTmZdetpDkmZzce5XvSYhPINrjYs4RK5mWiEENixERk3Mcjug6KN7a?=
 =?us-ascii?Q?zoJoa2ciB+1+N3y19olOSqpTnWis//RkjtpAMV4mINsvawo3bhAb+yatApR6?=
 =?us-ascii?Q?/3zpsEjexgEHUmG3JXHK/lxKYImfnYEdtRzSAEpZnTR35ePSbNLSPzooqI/7?=
 =?us-ascii?Q?e+3KHshIZRu0M1RQ/Skp9lsdJder1eEBC5SMT+vZGJ2+mMD2n1Ovm8XHpaEy?=
 =?us-ascii?Q?EXKdect7YTIDqnL31aIlAxRzDn3cw0fgfC6k0SGSAbOTRSBmVzxmRJyJsvh+?=
 =?us-ascii?Q?wR3DfAs7GoT6ecAp1ZWagHbuUGi+qp5FQmrerdE2ewidQE+6h8Cfk3JbJ31c?=
 =?us-ascii?Q?QsOmVkf8TvIjP/xGzQIOmUr6oyB25c9qkeni7/i2JW2pMklXvKOcYoj9OvCm?=
 =?us-ascii?Q?2adHREBNu47jKwZ9zrELqdwBmKGdkHEKM3bT0pt7XYY/PudezbBAY4o3G5T5?=
 =?us-ascii?Q?RFxsBGSiuTT5uvQACjBCvv5UShbtFsh/NfK9F2BcvfafkfdjaleNyjwarvYt?=
 =?us-ascii?Q?ltrM+AMBLaxIIFwwMFs3f7osbUeL28Q8stJ6mEkdCitC3jFmZ1+0V+uU1QoY?=
 =?us-ascii?Q?lRcvSoLrARUkfiCGj4vaK+OyEZ3664YEmoKyXSpRR+WDoVSydLJOJ6wtPFuN?=
 =?us-ascii?Q?yZ9OyQl4htjBTejj1eW9PBeJsn7YSSV6WuTsCKriYmi6Dc6ebeufQZBcJ9pm?=
 =?us-ascii?Q?dH4quZf5w2os3iVQecaQVgqUJn91HjiaB7on0wNMppnAnEG3ZauO9tEDybA7?=
 =?us-ascii?Q?CvfRk9XLUOYLvmNzaRjb21ua2WY1AYr3zddWaBFF2fUYCTZbU7Ugg8OmIHqq?=
 =?us-ascii?Q?L1Zuth664kFsYUXmn0EOlzu6XK2ngM2j+8/7DNFPYdG8qpsSiKqiQ10AHRY1?=
 =?us-ascii?Q?hTxH7hOHVUCeyRxeol1i6FJAuuSw7eRF7yeEmSe4AZPoe4kZIOPEIZwIrzUS?=
 =?us-ascii?Q?bczu0nBE6L7QvsOAVFK2awxdavz/gXPNMA09gkYYI3SRpjf7WiCcOAIMVCni?=
 =?us-ascii?Q?KDQSK4ABZF4SoEmK2UpoahBQDM97LcYw00kTA0PjFNotv1/38QoMOjus0OH3?=
 =?us-ascii?Q?uEu7Im39xGBlZ0Y7B8bwTawqZfDBmVMTpJS2qKWqv5j3LPkp/yYPE9sG1OcK?=
 =?us-ascii?Q?p4b27nnxZCtpQvd/PvD8TMYkBM0ZMc+DG2Y4+RwaZfohqoTKO2hpcjqi5vDL?=
 =?us-ascii?Q?Y3GMAZ1o0sGzhcH0HekJNbY0xFH1KgeYBDv/jvlLvgT5s2HjsIAToIMOaMFZ?=
 =?us-ascii?Q?BqtSQCmc4u7HJs6xaJlFEmJKSz5qxdsHEcWAZBQZxqauBBbC9dK9zHyaQPIP?=
 =?us-ascii?Q?fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XdJJkRcjLqj4+hsMdHGbXxAb+XhmJMDLA7lRE4qiM+IQbEiGKqYWhZ92tTn2?=
 =?us-ascii?Q?60lTMFcbcrpRWmSxuTR/MDyw5MrQ67aqi5NhGxzRvdzYZNiZh3/JC8FqzLWf?=
 =?us-ascii?Q?cPUwEgSm4JjkWN6DUGhfoMov6JlMuHclCtRvhceI5/Dupqbnob7mg7Roboyo?=
 =?us-ascii?Q?yi7g1JIf/IGvEDzlBX8i6Uuxx9ih4KXOpXelT7sylQAjahrhZ+fl7X7LoUmd?=
 =?us-ascii?Q?aRM3OHS9XRPHumoVHAXpuJJuMrHwpzrNTwuPzT1fbAyEgb9uLKmDpfhHJhhT?=
 =?us-ascii?Q?loZ5vdKXyxsQzEVwsZWcZZsnHz867uX3G+q3EOUMENF9/lMZYai//KLypmfo?=
 =?us-ascii?Q?lq6Y2oov1SgzumAEt95X60iFKB8vUkSwD/OtZQALKWSaILgWFdbYExKoCKvH?=
 =?us-ascii?Q?cfema5PLNsLjt187JLYuoWBgQ0Cl3ZKnUA6FjdP+QcowuA/m46V8qnEu6Xvx?=
 =?us-ascii?Q?3hBihGm+CgxBk5YAgzf2Xxlff6B4bs/9XLgxaSpT2Z4Ibcbj5Q4BYq1Vkfd+?=
 =?us-ascii?Q?+8AV9SCFFtGwcDoqddnqotXryciJUCANdlpQveqkBYuQh29hTZdH/Ukx91ZQ?=
 =?us-ascii?Q?C9YCsfd9715eoHhabh8xqpgFjUbaSkyOQwz7C07dHs7lPP4x1RJn11QFEW7K?=
 =?us-ascii?Q?oG2KkVHbPLwyie3XjpnoYFXb2EvRoMT8suhzK/d8cj4Msfa6uI/cFPHfz/JG?=
 =?us-ascii?Q?RQDuhCuP4lefXYJR6AYNVInvEFZ/58cI2EPgxjtUipRteNjq6zM4KJzlpAHe?=
 =?us-ascii?Q?fvgDsX+9VQpqx30NxwQSwepQ+HoPft17E9AWSR3oIwWM6zFUSUk1O/L62DhP?=
 =?us-ascii?Q?60SfYIMGt1SDYWlU02dG3ug7ZhbAx+3ZPsBb1XRjDOVEUex0R58n/3wI4vll?=
 =?us-ascii?Q?2KJg45udk+xMnCiXVeOK0JhnH3cv+ZQGC1SGKyDy/hVPkKbz4gifEWyGKTNa?=
 =?us-ascii?Q?gjhlSeBvxj1IOHjVarbPYhH/WDzRJvmkle7Y53qw4jI1fLesPcVvKKfzB8pe?=
 =?us-ascii?Q?WDiIRfnm/DHWcz7BoQCAv28PJdNJj96xqW/8++tQ0POIHzH2qdWrs1lAeRxN?=
 =?us-ascii?Q?0AIucpAJZCllPSaytdAVYFisBZhXlWFiFdHbCuGeBlLadZXppWJwuPw9vz5N?=
 =?us-ascii?Q?071hNs4g86rUgg7+brEzq82wGAK65Dt3s3EPdi5PqZr2OT0+5rf3KB2A+Rk6?=
 =?us-ascii?Q?QppBBA9nCsHCw4SysAQqGTSZ5MA9al4bAauVX/43WnwtnDZkanJj4FwneDwZ?=
 =?us-ascii?Q?kjj534e3b15XlTeSvg08YT5Am+JzJBG0ZB+Pt2K27BaFGhRLgDMviZXjkcrr?=
 =?us-ascii?Q?orVaM4u6Ppybdh03W2Td8hAn6xEU2CkMQFxrXlx37unclEluI9aNXRqUE8TM?=
 =?us-ascii?Q?nvWhoUEuIiKc2iO5qi+c8X60Vr/uWm1BPqnuBSlbHAqb97p8Rhoe+T1nBSdg?=
 =?us-ascii?Q?1b1aXGLRPkSdIvAeR4RQ0YKtr9oI93w1xs4xJJi353JZF4AyTm4mCC1iJs3a?=
 =?us-ascii?Q?4QNexBPP2bSFBrtfFk4sIlcFaqFl09VlEFLzKKjdum0Fcqoe6lwJSyTSa0zJ?=
 =?us-ascii?Q?8JDKZcnIzgOHM5czvfdkLKQWr2SEur+lVifT0RcwNpszLNkpc6+rqp53FZRC?=
 =?us-ascii?Q?LLJvOs1zbEeu9Fj7ajuS3Xlpnv6Mr770r3LzspimkoPhUJxm5l+/zHuIMslT?=
 =?us-ascii?Q?TaCAmiRc0ZF3eFsETsApmnwjlFuHe2jczw81Ip3nVpm6uhaeWXRlo2iWtt9X?=
 =?us-ascii?Q?15+fw3Ezp0jVGNhOA6hZNnRVPApusAn+u8ZMPpGM7aPgVHci53jF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f852bc6-c1d4-4fbb-267b-08de6dfb68a7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 08:06:09.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfBOo6YAXULZwvr9H8ybiatH572pqctDwJCFthVVLkpGP4FMLQM+BHAB7Wg9y8AJbrTI3dph1UTthNJEAIol4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7132

On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
are permanently mapped to BAR4 and must not be repurposed by EPF
drivers.

When the remote peer needs to access these registers, it must use the
fixed BAR4 window instead of creating another inbound mapping in a
different BAR. Mixing the fixed window with an additional mapping can
lead to incorrect behavior.

Advertise the DMA controller MMIO window as a reserved BAR subregion so
EPF drivers can reuse it safely.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 5b17da63151d..ecc28093c589 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
+static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
+	{
+		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
+		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
+		.offset = 0x0,
+		.size = 0x2000,
+	},
+};
+
 /*
  * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
  * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
@@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
-	.bar[BAR_4] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = {
+		.type = BAR_RESERVED,
+		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
+		.rsvd_regions = rk3588_bar4_rsvd,
+	},
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
-- 
2.51.0

