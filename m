Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA442D46A1;
	Tue, 30 Jun 2026 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799500; cv=fail; b=IPjaXHR4hUi7tCE5knP55CyIdjdQdad0BZxEuOpXu3tG9Gkns7rhfFSRaidexCCYib5ecK8elNxC2ti1aBy1g9COE1LVEpau0qy8ohLliHDiySLD6fahmwNxMq7Kezp2RbOFE4b5NSrwWAFaRnCzuMOKSYD5bBPCFWELZ3t42aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799500; c=relaxed/simple;
	bh=Rg/qi9YiUhzwKFV33Ll3w8Yy/X5R4KzMztuWtktpneQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/2AKPhJW+QiViqWZYCoLPlMhWMugtbNIoWG9iidxt7ROUAch+gEs8yrQW+KfAy1YaoGZsknXBEMGIeum1umeYACRZ6wixk8d4r8in+MuQvt4giHHydVJSrkhM7v0fxBcp0CKUtAcraRpCEYqLztSEPjSWzDRnKytPGLFhl6tzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Dp/KQ9SS; arc=fail smtp.client-ip=52.101.84.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dp/KQ9SS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0sXFwZt2MYj7ZVaPsoUJmF6yyP62rqI/xYJ6PJ//iApDCkYhm0OdPnhEDWpCdfYwdTV5dEh7boDioXHeeLIh7qkfMzJA6jU4dThVu10+b6QltUs2z9Eor1LWofZL3WPLkQ+n+xdobVH7q0Q5Pf2kZfVi2HHjKbOndg6wq8xFswdy4jga7aOxq5KVPQ6tLVupGwIy3uWpreLE0FizomMtWEj999lQnzC8c0w0+mGLJlaUT+2Cl3Z2kcwSQwq1b0s2d8y+Va53P8WhVeSlbfp6HQTYtzkwLaHQ6lueOwG9mWCZWibsPCTyKDlA3ClRt5iocyFySKz0XNMq3N1x6e2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KldhSB0pud6g1HW/T6ibVITtB2vGFP1lJ68H0tQdAU=;
 b=F5Z2wwHiyqjA3bcMdMUxnpoIJNcByHWDnuGFyTMI8PxBQQ1oe6fGTNtWfb540Uk9s5DazsBmnbZDiAZDiLdCuKraXRuoYhoL7mCBlGTAZO64xZ4EMdcUs9RK2Gdvtww4akAgr5tXbjBDjTfg4CTJkR0Fy5Yw0KUOvhxPjCJobg/M06uCwqHILVscd4Yxp+x0DwwInBNffu0eAFgv5CidNDSUWJPOuCmu50cuvVwBFckhPgjOX0QshFBGrZnF+4YsqaiWphoxFHUUsThbLnlaavwSCXvHjY6WlQyJ6LGpv9c9MniWs97pnuWDlp+vGaNbZMENeQizFqrJSwXMCTWGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KldhSB0pud6g1HW/T6ibVITtB2vGFP1lJ68H0tQdAU=;
 b=Dp/KQ9SSjdh098Wpn6I5k2YazpGJAnaFmqtar5Y+u5/Ju093+6VnJ/B0S+WK6ZD7PWWscUFCUholuiinY90MBQIcfTHyQKzN8k/aXXNXHn/ANlTKyjMvKEvW+hUqWKmASH8NxFbKMFe6H3XFooRRLtdpyeUR3PCqp4pJsAC5gLoOLuwUyaCqYvagdV+b/nmHWSop9dqDi5RZ/rxuaFh5K3iXcDvEXqRPIk2OmYTzOJp2/mlVpiagn7eC/E1MamUta/DM+y1Hsr7Qa9MxjO4pOErvT9sOa83X8a5G4Tx11zX7XWI2KNvxcUejsn6U+Z7LqLb2IcU2KpvMUq5b4t4PNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:04:56 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:04:56 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V4 1/7] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
Date: Tue, 30 Jun 2026 14:07:04 +0800
Message-ID: <20260630060710.3294811-2-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: e3950daa-9278-45c8-e692-08ded66d82b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|19092799006|22082099003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	sjA6Cfv05Psg6lphoao3CoiuD9L0na4x8yE9bSBFArc3o9JoRe6Uo4bTzavJOXbGUHayvrNjvhOIbEm7+XDmMozr6lsgevSFDwXrlYZgUWef6WUOET0ZJrTRrXBpM8umfRD7KxKhrB2f1Zi6rjPebwPl2GsdR4DN/lAtzQniQB6/m7gt3qaNcb6cGTa3ol59y6NuFx2fpJQziWO0DEETViKKCqP1niqAGlpEH9QcFxHLzLvOpcndIxv0x9rc9PBld976/roZxjsmZviuLqdixvoAjPvdzUGACbVDdbkKQSG6aVFYwk1rxBl/gVIyeDrCfHcmUY80LloemA/mqdF7NmhBfHPYSgyNA1AH1Ql05qQlSSUb1mjGhe43MkSuh8zGBgyxkNcy00qBfXvDwtq/qcmN+TiK1QpfFxoecxXWo/2C9Q+rPyoQrp/m/XA1Q78lPKjMDIaMJN79maB69uuXlvhGYs1C2B42Vgr079P3hd966TfebC4WwuHREeQWfDb/NkKnXsOYJPYK+4jDgcq/HHvS7oSUADAfZ+ZJwGaKzbOBZL7Fa69t/Wzz/08L8tvKLrsMm3cuWX+pVlsZv12CHNQlOvoY5bH5+pzXk6GqN09b+nmOjUPXAeb1dNT9bRia/iFK2K58gFdORGVzkvkilvo9f4wkZRW+TA5wCf1/RPG0aPR7yWlv9LEwTSV0O0iBhsAn2Fv72yFD89OhwzVjPA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTmaYBpmNYcXsw3nYZFZx/zisigKBuYPI9Tsrv7JJgce5YKwyDET/sTn47Vu?=
 =?us-ascii?Q?RLkhMVWWDfczX9EfWxaQgkgUgiSboAsKD4Uby3JsAqL/xFj/32nyFBQC1Am7?=
 =?us-ascii?Q?iTJRfwaMbeLHPAEeJ5NZcBjdJmmYm4EK5PEG7V7Xxc1ykHJw0+jWX0nWyrHv?=
 =?us-ascii?Q?VSJdEN4IyCX5sVGoUUgmU8TSb4dfljXA6e+6m18k6A3o9cxHhFK/fgyx05H4?=
 =?us-ascii?Q?dljYWcJNMlxQEyeAJ8RcbvawfCxCnBfidHNCY+QuAGXFiacwoQWWedL+R6bF?=
 =?us-ascii?Q?2NHXQ7tXkCAWbGzAH8helm01levu16fm0BnNEgJRHuVLjHQoWy70bGJePAER?=
 =?us-ascii?Q?9Fan74O/i3fAhuBoNa/b4Ab+77OGBX+IncyRGeu2sJLXiXkR72uSRkKe/LVW?=
 =?us-ascii?Q?rpJzcbE81yd0S6On7cjEUzVPRxyg3i1hIKSuumu3KcUwFFKnC97RwjH9uVqp?=
 =?us-ascii?Q?L/bahGlP3vl31ZNG4rMhLP0FOUiFoA9mAJbJDEHC3XSF7o5lFgwTmzgYdrB3?=
 =?us-ascii?Q?rvjfMx22ICDyBenUUKfodGpOynNxqJvSfQY2YqHgnfXLPhf6z10feIM9iI5f?=
 =?us-ascii?Q?dc0KT/THdbWWBxxOb/f8+6QncE+wzPk94zU9sbYL6t5xRwHGRO5lH7UxuuOY?=
 =?us-ascii?Q?qfNcQz1HFMXVkEtg9XnCIgHflL1y6tA5hKRmRPB5H1zpRYzQn46XAjP/Xmmc?=
 =?us-ascii?Q?tyX8YD36So5PvTbEKGx3sS9GeyMxBM/oyMCmub5RtIipD2lUVOH87piX/5QS?=
 =?us-ascii?Q?dAA8wa7y7kgYblNUV1iQT1tX79trbTdwz3OcgAbHsD4/kLCp9xvRMWyPkA8k?=
 =?us-ascii?Q?inQlRMBzUR2a9eGx4KWqZXQG7ON06z4jvjW2oeox0khJz1V9G4IjR9L1QMp9?=
 =?us-ascii?Q?xoB4Y3obX0O/tpKHTUEu2nyTMAHoqa+ThLh6dj54V04SRo48bwPRXB+uZIGG?=
 =?us-ascii?Q?93YUVJpSh4B0y+PjFqFEdrsjei/nRHY6mEjOm8iE2WK2yi9lCeSzSaGCbGS7?=
 =?us-ascii?Q?dlqO0icKFMU0tP5f2jzDZ7dpz3j4PYe3dF2a0+fKo8x46y2QZ4hyEmfd8V5y?=
 =?us-ascii?Q?D7U8wV+kuPkI0cPtyHIxyyo2R3WAN4YxGZf3bUXUwpFSHw6okrZUI8lwQu47?=
 =?us-ascii?Q?Ae8QLBGMYd5ufTw8IAsN919rTRLhZt4YJT/AexiFtd7yR22VZkshWYhTH39e?=
 =?us-ascii?Q?3P4sHlk8+bq2S0DqeMVqKpvWbCv7/CDvbwOwdqB42UwniBdMk0m/1AyYCW2v?=
 =?us-ascii?Q?H3OsQ06jmAMNdiJPUIAtnq+E7RKjO/rb1vj6/rO1+sYD3kdFs38ok94y5J9I?=
 =?us-ascii?Q?jbUbIRSQw7GulbF0jhN0lW9DuAePBx2M1o0cknEyldHEGUpEH8PXIaLh+l8f?=
 =?us-ascii?Q?P5m0mFEHB1u75DIENMUf3+DSmDA7RE0xNUfDlSw5YGqcFNVv6VvHl7ilJmWf?=
 =?us-ascii?Q?v2S9TYcLgJ0vwMPD+3pqozCbC8mBSgy3NJfIK2Bo1dr7UcAYXdftWEvIN1pK?=
 =?us-ascii?Q?Oq1rPqQ26tBvwQKjTx/yy44bxIlCkVCb60DZNur1WeX2S0EfJqMGQWwsoa2O?=
 =?us-ascii?Q?2A0LTydpj4929fXPFzMaq1Zubkc9GxuJJmhrEpWKzeJE6Cu9JwwrRjwymRDA?=
 =?us-ascii?Q?sOgnAnU0rOA09p1KxLZ9nZHWWvVtFvg1TtZ4fWchnPgzeUS8CoaYBgtkQYwj?=
 =?us-ascii?Q?lG9HRRYCmAU2NH8g7JH1Sqvqw47h8n8xr4QVOY3EK3SoTjABnHqE28x4hJqn?=
 =?us-ascii?Q?o0IhDdpvFEgdDNNjed7JKSuuKncrPcWn3Dx2LcVkIIs09At0hMaJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3950daa-9278-45c8-e692-08ded66d82b3
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:04:56.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+0G2x+GBMsmYMyDQN4ouNFIkuGconl/GA7CMSPK9DIuqrLLiuueEli+ydtMETG18t7Jh0DB1ncrpSo9LHmTUtId8aLubAq1P3YnKiEE6tluBsjAhWeNPK9lrifXS2UD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

From: Sherry Sun <sherry.sun@nxp.com>

Move the power supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index fe9046c03ddd..c52b8897f999 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -756,12 +756,12 @@ &pcie {
 	pinctrl-0 = <&pinctrl_pcie>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
 &pcie_port0 {
 	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie>;
 };
 
 &pwm1 {
-- 
2.50.1

