Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792210;
	b=t0+6oZ7NibbUiwuiUzKa/GUAor9A2itXzfIUC5FF+IXT4SWlVJ5mqorcYX6RF39Ov5dG
	 lBTPfX6EvXrwi9/kGvgcFtUXfrxChLfOx6Y71SIpv5s7py2gw9hOruc+p/UdfUq1dzwTB
	 MfVwOQ3PqE5TJbsr/0zdBUiHqdDbhlGzx/SbuJY5os/5PZgNbHbXF+Eg2pjbffmGditiS
	 cMpzXc+pTYhn49fsxttdM1xzbMFLCd8EqLpUAK5nu9xMqE4vjiXaqxA3a8394MwBMMSV6
	 IgN+TUTQmlSEuFF+njFarjrMF/IlIf745vqO9pJpz0Nq8kJ5MYt+oIY7WYjzzeGyWpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792210;
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
	bh=IDZAFkpNWaQCslMLak6FnX2P04gbpIbOwbL8wNa9kp8=;
	b=EsvGDJrucJByZad5eDeTf4cCaMfdAvYY/tEpzMHV0EIAXinsksKVDRdiqXluOoOyqzBo
	 M7oFrMdu8dSvurRFyfip4ZRV17yFfvK3jcTKCvhOgn8daap07qDBVMyxtBxWgMXCvZUoC
	 eNOHCOgp4VY64FQ+N1PF8EHyQ3ZjuTlY5UJp4VsSxIeSnwMwqdEaVwJnVst31BwrryYJe
	 u/QeuT9tBrdyf9OQxGqP6VedFehxCC9dy2zapcv3Nfsg1M6KNkOVssponIVJCFcujTpqm
	 ns2BVy6lgaOsZkO7nSHECX+0hxi3aS9/FezpQIXdj7xiRzAxnyF2SRedyArNMDH9dJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mx99o4FD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.53
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1C606A326;
	Wed,  4 Nov 2026 11:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=mx99o4FD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOi49boszJCe6fcOzDELUvmjoNl5Ip/hVxXLygElAvsKCqN69DCpl6Nu4O1+C4KtV/9d7YHjvP2B2hf4v15xBSY2bTOs4n/sieyTdgE9Genwrl1uwb4pE2gm9n5FprioqoTdgSbcWDmM835H/D3goA8oZCvf5zzXvthEiG5vzmqBQ48uZC8A1GFZvHjPvBag3IA9ojCZ5jL8FgB2wTVTJw1Hj5Tdkh2J8ELD7falbXVeQ3NiMq/jwOWuZ5kyLAVgkWa7Wm9WG4sZs8TkpUtdF0bzavwL+LDwG3ARJBkd67iEoQbee+MPWGeGI3zksiJ+/EWs6hEMm9HVw7IvubeZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDZAFkpNWaQCslMLak6FnX2P04gbpIbOwbL8wNa9kp8=;
 b=RmNotyqzC7U7e4dIEIWzvK/Zgv2023odym6h2zrzEouSddyLSt3D29u2QutAhbjXkws0FtIRdWkzW2wHW3TRz1KmKtfcToSTTOztLz5clWPu+joWDNldXWK31HB2AAeNcKwh6P0+liwtYsBKL0E96+4w4gUsXdYxf0eOxc+arWcl0NQK4YsdO0jb7IR0+mravAa2cQ4LPrsFAstPcgG7aHJGVqXIbYyH+HomHf/Ay1DP2GBp1nGm0ow/1UPRYgFt1l/56FZ+EW05ENdKVXu7GuDNmAW8cijXipf/CUGXikW9uQiwS7fb5+MFgsKdwONtNNseYXQXWSHewdnHhqWw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDZAFkpNWaQCslMLak6FnX2P04gbpIbOwbL8wNa9kp8=;
 b=mx99o4FDKPCUTiYscWcCRIcufP9WPZFWHY3afsMY+vnhqvhIg1s8pOOtsaedXyNWwokXWds5qeLg+iaRKRu8iRtSQ38aDxF4wYr9905IgYn+b7Fb7wmGQYJsG8TmpjvndE7sijnELzhij5ZkEXCH67REDAfeDCbq7TK/pKv2KLrdqSJCD/7WyoyumU4coFtrreATXO1PsDH+oWwk8grkwUY0XymqyTdc4Pn1fLzzbToAUIfnD2A9yPICj3XA1tpTFu2fpMlucJ9k5Ziqz3UPpFImjyog2nOAo3YGuiDf2PXzI868aiSrL6S6iLdHfXLggvcDXMepXZ8sCYz3m97ukA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:36:47 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:36:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: altera-msi: Convert to subsys_platform_driver()
Date: Wed,  4 Nov 2026 19:32:35 +0800
Message-ID: <20261104113235.1634024-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: cae1ce0f-6028-4be5-13d4-08df3a67c90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|18002099003|56012099006|11063799006|261022075727099003|261102123227099003|261009221227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ZJ0D6SNotriTI5r6vf/lEW5eTg7vLtE6PycYtAjTOBe5YhXdNcu3BxffVpUvYfQGz+c+xeklHkYJXAzjrr7gq90PDrfsZPLJB0MSctS24s6LAjhWDdc+bjoeNMhqT5Y7Nvbhxp4SBzoAzebkQyPTl8gqx0tABmGYewlewUoE1m+46CamjrgWmB43T7GSWoAlca4r4IDuv3oa2bFmoXud8lTzNX7sjRsrL5Q+v7kKZRJjRg2sbUmqNTrPCACqga64UCBapYx7XCqdH+esNhdtF7LvT5iEM7L9873J76Kuc3Jtb4nvm0EkxTfinXXy/FmaQQDdA0nQhZ7ROiY1Fb2SwNr7wkZco2hl6ngoo6KJxmgEl/zA6MRJ8PGKRpGzuc+rLdVxuMfPESUTdPGqI5twYUJVCH3UhXTk2Pum4Ce/hhfllR0uQC97GBFQBXOjLxq+SKJHnmPRNyBqePu6oCNO+iI1NpVhhD9GpyDGQU89Cp53XuTYtDk0Y0MK3tSA8pFMw1sDC3c8yOmr55LefO61i/C31d27nRV9MpMdHWtVLkU3QiuUDGZqXcNAvtEyzBLRiWv+qWawVT0RjkpbHQKV4BLWQQbG9jXF7YexkQqGki+XRnP/Wa9FBxLjBNmTdjQSP2Vbl4m0RH0dvOUsBZXGSsFGQIDhCV23bHSbXHv+6zw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261102123227099003)(261009221227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CW53Z4grS7sNCxgEkyJDSkFVDq4+jICP1a3J72YWLOIaStSbTaf0sHj5rDlE?=
 =?us-ascii?Q?5GOo+r1i+VCli3JhSqC04s+3Vo/XPCvKljxwkU+StaZRoVXGtuqt1qMgmby1?=
 =?us-ascii?Q?mCtOCcyALBt4/t1qTb5eONBVjsi3cr3CDwfk+EuDj0swQwJs1+yDB35x1oMj?=
 =?us-ascii?Q?zKJ8ZEmAXbUI45ZUPn8JB8UJWwSmSkG8ufHM1l4DxTP7kgXxpdlbNotLs0pQ?=
 =?us-ascii?Q?Mu92WU07DxCrujWF+XV+KJhENqfyXxK90PtryND9fprhhAB4fHIwo3zWTFRZ?=
 =?us-ascii?Q?NGOnG21IuS6wxh4ggSAf5PLeE3EQuwOd7EjXwyyhNb4gYiLLJfG90okmdL1/?=
 =?us-ascii?Q?Qy6kmlZyxKgc5c8kcuR+1thX0CnJTiVOdLVq33YcjBKlA1wPu631Crm9NwIm?=
 =?us-ascii?Q?UL5jiE50+vY4VuAYYTC7aS5WBFigeW08kerb8VHsUwQI7WiATfGXTkMR39Ph?=
 =?us-ascii?Q?Y6gwCXoLl6+ZxbZ7XZ+apKdIBuorVwC0jwl74LsvY8Ms9iXF7SYXoJe0ARbM?=
 =?us-ascii?Q?I+iTGjUX7e46YacuA0p9tPQAUHNTPG2fu+nPkUvC7Fi9juAvCI2LJsmm7GdT?=
 =?us-ascii?Q?mlrGmH3R3utrN4tsqB1tqcZAQ4c9qyS792s/a3wjIi6uwPB14veRJaA1ae3N?=
 =?us-ascii?Q?FdjAOxUoTEY64dKv9qpyTNPHzaDoJvUoodv0NWRT61WG/EV2AAXiCKFQCgRz?=
 =?us-ascii?Q?5Cv1i3sgzB5ebOocWST13Cp08BYFJfLokT6Tx9PVZb+Js/tpP1CfLcOQz4Uj?=
 =?us-ascii?Q?ULN0OA7n3rdBlDZEBaPAupFkmzwbslGHCRJoQPm27fvd/sEHS2EHY+y86U4/?=
 =?us-ascii?Q?NYmPjvwECaBER98IvCQf7j6a1L3OF1H0S3EUMSNNYyUd1r/qMf7jVNNd0DNC?=
 =?us-ascii?Q?zmxByxGctAurmw57EM5nN8PgpJniQCNXhgEwYpjPEgfLmVB1xAYIkvdDXOb7?=
 =?us-ascii?Q?sbo+tSjtL+PqIVRp2Xns5DcOoMeJu9BmnDMZT8YbkkCDGgbLQEZSzFcR6Y02?=
 =?us-ascii?Q?9Rx0CoRNWj/fDgEHDS2ySSxDKOUPssQWq1+MPzqM0YoFRLP9IL524FgKX7BU?=
 =?us-ascii?Q?V1Q58Vy4vBa5HkwuBMo/Ex/HsuizjxQPFOcCOj+YfZL/WdqZaD0YefdOFFLb?=
 =?us-ascii?Q?M6kXmzdAeWTsjs0ySzm3lIsnGAYA4xHA1cKyTPJFJNhcGgw8wkNeekIsK1bH?=
 =?us-ascii?Q?sB5yG0JEJhaRd26QgGsPYbtZ0Gxl7bHxtTa4LphFVCDBpV7U4bcvg02oUpCe?=
 =?us-ascii?Q?kNIxaq+lGzsKLSqQZZ0ePOMuLcL3N/v+zOmON5xj+Teei5YCim/mnQCsKdwK?=
 =?us-ascii?Q?fR9HqPeOpv1+t5hw2yeSeh31/UtycIbsehBtUnciF02vlZA6eEGyimoZ7+8e?=
 =?us-ascii?Q?G4ZbzpVK/eWzuFl1P+XBsM6sYjMxcSZO2yKtFovYuaSEJPZ1NsL31b23tq5j?=
 =?us-ascii?Q?GNhEA6Ajbyn55ggk9orEkVs0O/rRs04q+2bsHPacG64EyHgw8RcAaQpUGNXl?=
 =?us-ascii?Q?AaNuFVv+4+OsEJOyw5VAk7Scqr2hpIsK60aoBor3k8HK1C60LMYcYXPDjC0+?=
 =?us-ascii?Q?KMwzcRc7wHTNfNpf7sPPkbDfwcEZV+7QZl5F4mcmLv7Lgm6IMTSwtgE5lj8V?=
 =?us-ascii?Q?HQdgCirPKgb69frHUSkQzFFeu7eDD5MKKzdrfq5gm0d5eI87552gPY1FXDgI?=
 =?us-ascii?Q?Uer4/b3A5xWjUosOqUp77y8kxujjH2mYKx0Y3rKGbpintusZEj8LhL7Nd6Ix?=
 =?us-ascii?Q?tqrPuaO1EdboVgSf5RYNXAWCVzF+LmWfWmkwFEKYv2xCTejfhgS4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae1ce0f-6028-4be5-13d4-08df3a67c90b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:35:54.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mSSodwrweOTOeC5qrX5IMUgTItNVBtXRtZ6dgsI4TKJdIcK28CZtD29AmXj4YcK4Vn1W/IUy2zYWeP/kENsXwz8Ws1xcaXfXwomghj/DfYCz/HpIXMPDqRlTwInZQjl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

From: Peng Fan <peng.fan@nxp.com>

Replace the open-coded subsys_initcall()/module_exit() platform driver
registration with subsys_platform_driver().

No functional change.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/controller/pcie-altera-msi.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index ea2ca2e70f20..8c0696cbd4ae 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -267,18 +267,7 @@ static struct platform_driver altera_msi_driver = {
 	.remove = altera_msi_remove,
 };
 
-static int __init altera_msi_init(void)
-{
-	return platform_driver_register(&altera_msi_driver);
-}
-
-static void __exit altera_msi_exit(void)
-{
-	platform_driver_unregister(&altera_msi_driver);
-}
-
-subsys_initcall(altera_msi_init);
+subsys_platform_driver(altera_msi_driver);
 MODULE_DEVICE_TABLE(of, altera_msi_of_match);
-module_exit(altera_msi_exit);
 MODULE_DESCRIPTION("Altera PCIe MSI support driver");
 MODULE_LICENSE("GPL v2");
-- 
2.51.0

