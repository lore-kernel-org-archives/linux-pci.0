Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719DA31715F;
	Tue, 10 Mar 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156236; cv=fail; b=jyn1MC9wlXeJrKfV5YxdnsYXItF649Q9iAMeTAoC3iqPlCgaNL6Yy1mUTe1XFNA85pu2Ctyoe6LG49z40mjGZOvHJuFuL5bm/L9BF/sxWLVVFki2s9Id1AV1VEFBm+i8aTQDTzJ/7lO4ahU6sG5rO8K2VSFxaJ6lSrXwDq7aGQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156236; c=relaxed/simple;
	bh=wq2KY2hntMWQpQ7X48ZBRLClcvkUvwMHNZqSqIBe4tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hA6YXg6TfPJ1DTpKOw0LRm7g/U64drgnutY2PFw64s1vBD1PEDQ/AZ7a2RUh/lBRPmn9fs7NUJxKofs8hDG/2SnyuOs5wOjj6kiJUkNreG1tt4D+5eb/N3PcnBBE9xku0eyid1w3t94jo3JBTfuw/Cp6mxJdaR/PZ3AJTSkigkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RKXYCZww; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RKXYCZww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKp8Oy3Z3OroCh9OqO5UKKGBVRzdR6F3N9BghtHp1cQQpyAPH63OMd8rYORquarVUOpyCiRlgZpGrHa0+UPhdT6o1SNsfr4PSk+G4uzQ72AcZJK3qUrlQ2dAKfFYxfljTV2DspKoQ5UvYUDt8ezfVBqGW8fdfIL5DCfyUqPd7O77v37561sD6BjgCpKljSn4h8P3iLxT61Ss+MxcWfvUOtumQkGGncbLe9NSHcb5YnUk1WQF7ZIqbXzqSUPK3SrAbGdXiU1R90uthaySV+8xpKWGIKmiy6iENIZ5sH/diG9L2KQqx6MYg/xuUuOy0161Z9jt4ggT3sUpYicSOiB7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMGlkNgRfmW0WZkBPii+MnaoNLvkWEKsO8PlpD0+fTY=;
 b=aPQt7fQTJL4NIUdNbUDDklSJwJITaBH+ZP1XQOVkITkGmyP/eo0pTRcYTY/EEAKozXpFgakGCdYzWK+TWH6J4BiEx2+uIls3mgkl+XniLKQ+xMPhjnBUJL4/eplRIVONq9fTw+R2Fd/OGVtSFoTIoMc4WEXdk5d+dRAdQGYRu9C2oHGYvHJ8KCHGGkem6ztUOX5M/ztF/VbtCF0vz17SV/RFg+Ec5quMF0cjZbFrIFIJGpOclipjTCDo49Kc+ssrGSeIjdp+nPWL2mTnTulPeLWNhVi8edutuYq6/RlQ0tbypE8uE2q+A9uRiTDHEHyo0dfYmyFT1ukyZ4N7DJ30Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMGlkNgRfmW0WZkBPii+MnaoNLvkWEKsO8PlpD0+fTY=;
 b=RKXYCZwwNLgk9NeQuSp+zcJ94gSiAwFmbkLDZxwDH9DpmiaI8yg4TKO2rzdqef2djqfYgzEtPK8oBP/2r/y5LTnYmymu4rhIxmQHR1Y0oHVwQ00VTbWdFMFYJHmUKzuTC5Cy18wBuPITkneQAKSEOnDpyVOSp3zyfISapyA/7RNyybxsAT6CQGJqWvHdfszMlHnJX3VNFGAIQU2HYfrtcsbeOwOXbtg9KFCBcpx0dfv1+afDblT6RTv5hxwMTye6eqEoYeFF2RPll3F6DQMNgfOsvMW3MQsSZ3vJ4AMgZ71r8Pw0ZTwcaueeXtPhduUhAuLK3TPcQ4z2dXwFJxVuGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Tue, 10 Mar
 2026 15:23:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Tue, 10 Mar 2026
 15:23:51 +0000
Date: Tue, 10 Mar 2026 11:23:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 04/13] PCI: imx6: Assert PERST# before enabling
 regulators
Message-ID: <abA3cM-Icmz47Ti2@lizhi-Precision-Tower-5810>
References: <20260310015426.365675-1-sherry.sun@nxp.com>
 <20260310015426.365675-5-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310015426.365675-5-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: f548b2b8-cf65-4ac9-1726-08de7eb9086f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	I52nz5lX1KJgJ37lfjQETSN7MiTRZ6IqJ2BDLpOFwr+8t40F2X62HV75Rc06wXK6c6edY2yBoutWjvfUdbbFv632xiZ0zt8mLrzpriOoGKZzi0gCkyrdvR3BOjKJINFYSaIz6OKxCr4AtzEO33z6KSIwE1i9p5xDNHfUkTOW92fGguO6nvKrpRVTJfDmJglwKolegVfCO8NK2lgOtthT6rZX7xrNoCnkkVPjMGqhOZaZS735oQSDbW9H35OQddiwtz3Lpves3UTZtFxMDmJ6UMhjuc0ri05o2tKD75DiT5l8S4+mfdLs0K2esDAWeDwfqT53tVoBiFXUAl3+Ed5AwFBJv/BrcJcr3uj6c6r7ATT1j4WbrrT29F1KRF5ZH1WTh7F6xFI8mLa4jxG1bUHASILFERWZRS4351k219LSlIbCpCN2Dl+TtV4zogt0hgnrQT0FdC6b8M2iQS3NXfM7eO56+cg5SQL5Dgma/a2nROKGrtuYZVxZR67R0I3iOsfFCkSj3fxZI3XL1rr9GbQL+c7kD4HS5V1w+z0SESK9Q1Rjegse7KWM4QP/48ZKEyyZ0yPPiIIjDZ7bIBX9hYC9AR42yeU97htiQhrLAyC2nhF5vJJsWgr6ObQnFsQPJld+a/VHzg3IvkgtS8l3gU10TUKrTja8jFqm0rN6PxoZHRnjFL2FRm+PYIYnRXTYTGsjbvF0B7WhhCb3uOqs/Jai6k/henyExszYu8+7xCTLzhWU9vDGN0TtWtUEE7MNwEz6FvnoI3HBY62t7jBOeZmb4pHNhsxd9i6w2+QsfyHQ/Vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czRAcRrezlkzprOx7M1CFyIQ9ljc4CT8458iDmV1frx3FTIjaGegirvqkLML?=
 =?us-ascii?Q?jNubVjw19G+9CQXWy65T28W2IRyOTmlZUYBkV3t1AZfkaZGnaZs+ZNr2+oq1?=
 =?us-ascii?Q?9Cvi5We9CFbANT64X8K2800DjXM0X21KIt5uO8KrMHTEej5fHIn/bhmoOtZG?=
 =?us-ascii?Q?1S2X2CnsDC8rxn2k6uyejtMjdsVkV/OvhzBgE9kX6KgP4uaMVmy5Gb9H3jWj?=
 =?us-ascii?Q?oMiJTaxPOGQRU9wZit6HVXfJmD5J4M7T2Trb7omTbHmcmFnCtJLbqnBEbeDU?=
 =?us-ascii?Q?WM/ZsZc79eBhPfq5zKKjvZsDZLSAS0ISuas2Dg/R08iSeu3pRZZpeoINNDZ3?=
 =?us-ascii?Q?eeQLqUqEIYLZt37xs0IV2TkxXXNmySfWGub9K2o3h+1ywnJHjb6E5fCqSLIZ?=
 =?us-ascii?Q?mpn1EvRhHx2uFWFtMLvEYEJzUjWFKNrZ0WuZ/X4Ml8rgDhEjzmPRiQyTdFxy?=
 =?us-ascii?Q?aorNdqx7yUDtdW/gTay6z6FAzzkCxtpUDxdl7GFjMfKSAyee+X+DV4+CRCiR?=
 =?us-ascii?Q?koe4D/Usub6xbfTtgVX6pT7pY6zw56Z3jlFJvUn8t3R1k0qSW+KyE2I8KUvF?=
 =?us-ascii?Q?7CGm2T22MnzcGZv+vTk2XRnGE3XQ7Igstvf1Be4HBE+QVU2Ydzo8rduP67KT?=
 =?us-ascii?Q?TVB6wzFBF+UxEBOn4vJ58WoBafqpHKwy9UNayK6kEGLnGsqA1yYZmMlnac1U?=
 =?us-ascii?Q?yI5iPw9JgjibCDkWxMmCL+yKPnBCevX/0x08IZobDP0BmoH1QOmuaTz4sAYo?=
 =?us-ascii?Q?s9C6AVjgfwGK44feIwsu9OE7s/aaMdOWnMkBClBCcaaWGDj5+2yxB8Ae0Ggo?=
 =?us-ascii?Q?PPmAtqkK+dE/YRlU+hnH6FuN9sPER236mhzWHMSmQTODxpwYq7dSxdbWW3ik?=
 =?us-ascii?Q?dawEE3/H0Q20agettyUlHNF8IEOWxZm+j6PB3ooL/T/ym91Bdb96M7ISQ7lZ?=
 =?us-ascii?Q?I3xI5cs2F/DWdjaMkn6zV4WBPQHb8uEmp+e5X0hujhe8Pf3E+wXFaMAp4t7s?=
 =?us-ascii?Q?Jk0M29YqDj3pwei7fmjUw5nIKYaHITMruyVYlU3nsRgP7fst00M8MQm8Sl/F?=
 =?us-ascii?Q?0Utb2v6a3CkFpGo4125d/hbQJcMgSgIbKPw4cHJ1aA0SuAujs55R/O67hrvA?=
 =?us-ascii?Q?cSIHOe8Fx9SF/am9TFxO1uy0dnGKsjqVgCVJn6si2ynKNHdcoeFVHSbbgInh?=
 =?us-ascii?Q?4Z8v/dO/MbO7c1OQuD1YL9VOuPE3P1LG4r0Uulj1x7ymDEt7vITpUBZ0G59t?=
 =?us-ascii?Q?AxXKWG/YRkGw82YSn5YaMQsIbd1nXwezkXKyCq2jEhnjlvjpdfHTQwRV1Qj2?=
 =?us-ascii?Q?fvh17wtX8yo+ZWqBEMCo+hLbmwcwgHxUXfrwgmMYPAP3aMxKY2KdYlbRG8PI?=
 =?us-ascii?Q?qjZ96m95RZm/KcZuvzYNV8E+2JKtNRdL62vjkBzQBpBI0wQJnbsLITl9GSTt?=
 =?us-ascii?Q?tOzVfPJfoqymkKx73ATQAvMU0qAUwSqNpEYAOSzoR4sNMbHPQZOLtGVPo3Dl?=
 =?us-ascii?Q?QhODgSX/tIliVoQOXkMYCCw6NdcRS09vZ3nW/gA2jH2NffS5uCH2YYjaZGIh?=
 =?us-ascii?Q?dxCQglSiUMDiUXynEgXrbGxfsTAmsJO/J5yjNKP+w4Ivo/HYNRZt2pSnHctq?=
 =?us-ascii?Q?abkH2rdeIX7jdIUGusP77mr1fdiS6eLhskj3B+3Q3ZD8QlIBrNTGp+lcb3EU?=
 =?us-ascii?Q?8uRvKittxDBZcEdLwpj7sXvrTVqh+pbcj/P5YHOdtJPn6XJFyAu5O00PphUT?=
 =?us-ascii?Q?BEkumfSalA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f548b2b8-cf65-4ac9-1726-08de7eb9086f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 15:23:51.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlgV73jF1XbUIERR6I1ELhuyEvnMsOMLs27C3sBjHZY7a4U1OMceoGa1buF/eDGB/hJoq+Ii5C/KZJbSkU3h2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912

On Tue, Mar 10, 2026 at 09:54:17AM +0800, Sherry Sun wrote:
> According to the PCIe initialization requirements, PERST# signal should
> be asserted before applying power to the PCIe device, and deasserted
> after power and reference clock are stable.
>
> Currently, the driver enables the vpcie3v3aux regulator in
> imx_pcie_probe() before PERST# is asserted in imx_pcie_host_init(),
> which violates the PCIe power sequencing requirements. However, there
> is no issue so far because PERST# is requested as GPIOD_OUT_HIGH in
> imx_pcie_probe(), which guarantees that PERST# is asserted before
> enabling the vpcie3v3aux regulator.
>
> This is a preparation patch for the upcoming changes that will parse the

Nit: This is prepare for ...

> reset property using the new Root Port binding, which will use
> GPIOD_ASIS when requesting the reset GPIO. With GPIOD_ASIS, the GPIO
> state is not guaranteed, so explicit sequencing is required.
>
> Fix the power sequencing by:
> 1. Moving vpcie3v3aux regulator enable from probe to
>    imx_pcie_host_init(), where it can be properly sequenced with PERST#.
> 2. Moving imx_pcie_assert_perst() before regulator and clock enable to
>    ensure correct ordering.
>
> The vpcie3v3aux regulator is kept enabled for the entire PCIe controller
> lifecycle and automatically disabled on device removal via devm cleanup.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
...
>  static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
>  {
>  	if (assert) {
> @@ -1240,6 +1249,29 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	int ret;
>
> +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> +		pp->bridge->enable_device = imx_pcie_enable_device;
> +		pp->bridge->disable_device = imx_pcie_disable_device;
> +	}

are you sure need move this part? it is not related preset and vaux.

> +
> +	imx_pcie_assert_perst(imx_pcie, true);
> +
> +	/* Keep 3.3Vaux supply enabled for the entire PCIe controller lifecycle */
> +	if (imx_pcie->vpcie_aux && !imx_pcie->vpcie_aux_enabled) {

How about two pcie shared one vaux regulator?

...
>  		if (ret) {
> @@ -1790,9 +1816,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  	imx_pcie->supports_clkreq = of_property_read_bool(node, "supports-clkreq");
>
> -	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
> -	if (ret < 0 && ret != -ENODEV)
> -		return dev_err_probe(dev, ret, "failed to enable Vaux supply\n");
> +	imx_pcie->vpcie_aux = devm_regulator_get_optional(&pdev->dev, "vpcie3v3aux");
> +	if (IS_ERR(imx_pcie->vpcie_aux)) {
> +		if (PTR_ERR(imx_pcie->vpcie_aux) != -ENODEV)
> +			return PTR_ERR(imx_pcie->vpcie_aux);

keep old dev_err_probe(), just message change to "failed to get Vaux supply".

Frnak
> +		imx_pcie->vpcie_aux = NULL;
> +	}
>
>  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
> --
> 2.37.1
>
