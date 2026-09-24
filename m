Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CD43CEC7;
	Thu, 24 Sep 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239830; cv=fail; b=g6/Rl0GvQfzxcJIIuqN+EccqxbvPtYCimjoK+GEkXGKPlj7y8sZd7CI0BJysurknPVMlXwTIZWIGkuYgEsrTJ4z8bR9CRbgLIr92nkKgYD+DNjUpBecferNedcl9uR4LIrcqQ0zBUg83TezQKgJphxTuZB5qJeJukRuMloh/FIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239830; c=relaxed/simple;
	bh=ZUnrHQQJRsxxrnop3u/cNPFb7xPbU9rul3WUIbvV03s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOj2CPPjqoPd1xZ+5CBOOUv9iqYw+VwBBQHB+QB7KlTkB7pIGpbR3WsXfdu5Y1kdFrH8EAyuYaD3mgDC1UCd0vLZPA98AmewUqhCnv8fYQ0aZetIaAu+Puogoojgv8VoU4dOjiUYLmyRUQOU1bfTfpbwfwp08jJ54daK8qCn7m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wuq5dZN+; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wuq5dZN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oep+NLwArXvbn1DcX0SYWdP7dXwy5DTmgH6kwMBt17QkWqPo8Ar9MGaldj1rBfyvMwcJ7/L52FmDFdx5G3Aowjk5Ywrm86NY9yiLyFH9EAfICDwSMknBgFMgH2NOSQQIrqpYC/bhSd83+oBcnI4G46asbtERQJz4kzL4MiGV3UVOLxBsFm5UbyFUHZWECdK4RiweFmGk6IJvWpGsNK/GHmWJGjCCn+/UViPCGhXx4/ABR3oSIgvfLysy62670I7EAUua9ya2EaAxFpMRyQ6HzwCnSQDyhIFlhJVnJw2dOsHtmQAoqJc4nPW8tvlQpN9VyMqlwbi6ezHRM4twSYChIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MchcSiYq/CSAIJSKbNwQ79wcn7xTFrnpwLrMUn9jAZE=;
 b=hp8ERS/ZVXSnI/1LovBVStWaI/JzsfMu9obfc7ByEU7BoW3MExO5tDs+EWTlK15yEcsshHYndf84Wb84eOz8dFOytPexQF6nxO672xA13P9vDygvdjNRPpiq3cx/sX8knG8JFpvBpkBHFrYnmLlHg9jyZYk3ZPXYM17uG5w+837MicicxOG3kdzrKqKMZ59xFyj+sLSJbdv64IfktWXOoCsIKOyPRXaUAl0qcVKpGlHaY6IGxPtUtZsNP71gejXmERHlEukcoCxl9XDYKPr343TAvnEqZGu2vzOLiHNoz4B7BizSqK5gi67YL0oXeqGrZYPekj+7bipFWDU4G5UHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MchcSiYq/CSAIJSKbNwQ79wcn7xTFrnpwLrMUn9jAZE=;
 b=Wuq5dZN+JkQgemtH1ccZLMJHMLc8GCiAtXuAyrpV9JNqTDWemnUFtWhh1lSoDmlsquRXiTlFdvtb839IHlQxiA9SB84/COdde3vOkKwskKZ3eEJfUJi5dDFjlyzHkEujR02MQGMbvP6s/lnSmKUKJObbOq+9ed2pX8WosReMQxbZ+ZaxBogJfGTrJFbxEmvPphd6k+VG2Jn4nZh8K05XbRBrkpcQcqYncwibgfz6Ynz6SBWmD+j4z/JKmb+0V/cpRqZVQyW/AGVlDEphKRLZ2bsJtsyHqH2IetIjo0Y8g47g+5OZ1t70ODuwV0QAlCxcp1HrIvZuWD8Z5Lq1aUYIEA==
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 (2603:10a6:150:30c::14) by VI1PR04MB7182.eurprd04.prod.outlook.com
 (2603:10a6:800:121::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:50:18 +0000
Received: from GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe]) by GV2PR04MB12019.eurprd04.prod.outlook.com
 ([fe80::ed75:bac1:2554:5cbe%3]) with mapi id 15.21.0382.012; Thu, 24 Sep 2026
 08:50:18 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Lucas Stach
	<l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for conditional
 set/clear
Thread-Topic: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for conditional
 set/clear
Thread-Index: AQHdS//d1ZNf3D2sOUmby9NCsaF/ErbdaM8Q
Date: Thu, 24 Sep 2026 08:50:18 +0000
Message-ID:
 <GV2PR04MB12019083AAA5EC21BFC83E7238C812@GV2PR04MB12019.eurprd04.prod.outlook.com>
References: <20260924083429.461746-1-peng.fan@oss.nxp.com>
In-Reply-To: <20260924083429.461746-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12019:EE_|VI1PR04MB7182:EE_
x-ms-office365-filtering-correlation-id: bc341144-21fa-4a39-ad31-08df1a18dc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|22082099003|18002099003|921020|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info:
 6+0pQAZiMlcmJ+7m3lDD5R7fK5w8ppfETK3k3C9YZeh46RUsdzJXh6fD6PAzcsdYqgu+mvEjCQGYj46AFSO3qe2o8zQHbrNsemeBgzvRpKg3+1YIrCTcJ2kXFA2qwlw7xhgN3b29kZH+ID4o2q8/SOwARn/3pXpKGmZ2NrshydO9HCyh4EOGhrUz+WNHSCxC3nXnEyJDVDaZBdv5m166+nO/9Nmpbck6IjhkjvGcD6bmNrwsggwOWSU9nl3l7gOa/kGPuaTRD9b4jYi6k0GFd9l+pp2MhVLKQqDTnk2jO9iF/FScZbUidcTFU8+DCAJtulLF9uHb5V/UyCAVYmci6fV5D6Vp1SLCFIxEYM60D0cLVk1IeeUkPrwNVGRWJEOXAI6koYGZTJPUrdRKKhL87cMRdn4aQjX+Ww/RCwY01CGA7K+gG7Q8IUxsft3MienjSKcJsjZSwcjN7IKNyYPf5GpIqEEQPn9j/G6I5GbJNnnR4hz5NNDBQIVE7vpvDo0LcVjihhtcNL5d/TkFFoyqd5+5vNyBpqdQejPcAMQeDOC9982uTZl+C7EM6+UohHWWVTcB5diw9jOyzWVgV8yJUPxLehJRsjCxX+c/qMv3omi+NHtMh12U22OWfYgWfMIG2Bfwf23ygEQR/hhKO8yjb7hl0kufrkuKpXHyNkszZ9DfEqNLOak8My8VVlgEhzzc9we0ds3a0tJ/ZrR7qrPJw80UJxXGcQibm12H1wIhsWxGKfXqgGlCmiY52Qy81lWf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12019.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(22082099003)(18002099003)(921020)(38070700021)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?cdYSlatfcD7FylWWhw1EOwG6R+vZzrIuUw5LPaKnWE3+4DF678ScIUQ459?=
 =?iso-8859-2?Q?v1rH38vZ7Ha1ii+Y7WJotgm8A3HEY6+LS2tSl8VW2J91WRPP5J9fMzpt35?=
 =?iso-8859-2?Q?GJg4Gz7tpmQECV1g6BqqSCHapzSt4efRc3uV3byzl22ctVGScx9n0yZ/HG?=
 =?iso-8859-2?Q?RxNYlK2XP0M+E0mWIYdG/R41+T2W8C55cNb5ctGvDfyRnzIS33LzaC05rZ?=
 =?iso-8859-2?Q?j2qwFLp5ADAfSrq/3sAoc1pqWvVK5nn3pkns35yUU/Y1iGRjXFFRO2OOcj?=
 =?iso-8859-2?Q?VRwr5RRm4tZx2AV5NtdU4bd+U/k3bLqe7O1xTUolldOI+wI0R58XkAZSaj?=
 =?iso-8859-2?Q?YONXRTi3sGkKRz3BDOtbI48r2OMeWO+yHhqJ1nfq+vH35QJJ0vfyKTBE+I?=
 =?iso-8859-2?Q?MGHSPu4/pZrK7f5T6gbd9Nf+0cfkzYw7D+jymLSJQEkYw6nPfyOjZyO6ta?=
 =?iso-8859-2?Q?6VtirJ65GHddRmAm66BCLXW1v3SkyaQQiDzeZVezc1PID8F1JcQTGJtvX0?=
 =?iso-8859-2?Q?hbtBvZ/CI2sFCVhHplWfxmvAh8KwjWhBSDvynu3Ds9DU80yFCP3q0p5K1q?=
 =?iso-8859-2?Q?G+/JzJFz8OS2OkIHp3wgmGj670phqrLnsypd8Jgv3t32lFtUOHHGjO8e9L?=
 =?iso-8859-2?Q?aoqX/M1zelE+slvYdZrSyMmJZ/+U//9jycC+TR71Ua6EnV8JRMsVTRyDRD?=
 =?iso-8859-2?Q?6/0ZTmP/RQzF3QKZcp8hNu7qsr+InEcUh8aJmaoiZmy8hkHkxoezwR9ZF+?=
 =?iso-8859-2?Q?LuOT3YbmOblOtDbVBjksXo31ZB3fTJTvJMCOH1rgBo5jmlEVtf8plu56k5?=
 =?iso-8859-2?Q?yW0I1G5yCsqbjVcGD6zaea3bHs6riCVuRyjBsgI9k/Bof0Hd1AjNhA/R8f?=
 =?iso-8859-2?Q?B2Wjg9L8OkOFy4+cDGZ/oCIMDjl7EvoSRwfNSGUHNPosXhh3mGQgcmbhjU?=
 =?iso-8859-2?Q?esm6Yemu1uUIzVs7ill0zPk/3It03eETZ8TdbXBnw3jdnSKFF6N20wuGm+?=
 =?iso-8859-2?Q?WbnmyrMeAakhEzUjGapV7gg8fGeNvWU9/Wkhu3SXEU4+8zVb9kY2JXrDXe?=
 =?iso-8859-2?Q?/MNGQYcwmId1ITnjQxV7MHLUbPC6MnjL/B/juqIjKXqfD4NGyVGIQ79v5a?=
 =?iso-8859-2?Q?VDrgzI+EKS6gn/95WgnjxXBAq9elSKLL7CJV71GUMRfVnHXWyQqMRLaQLr?=
 =?iso-8859-2?Q?aVTihyy2N5cBu0TTFMHdZBJHjq+akZZh3NzXQrvqCa/DcsQWz79Nse5w7e?=
 =?iso-8859-2?Q?88XIYRNmPKmSe2d8TxLhegpCp5WqhH+qYR5kvadrV9RJQnmG+N+3VLdpIC?=
 =?iso-8859-2?Q?bHUr0D+xBxUzGnhiYsgH7KfyipyFR455+7dwN1M6d6N30OBCZVmaG8ozKn?=
 =?iso-8859-2?Q?pRb2NmXdWyoFQeSveTpw5PqFqW5EpKRIUmk3DHuHOq6TVX+Y7sSjMUF4NC?=
 =?iso-8859-2?Q?sOFHhtAn8cxoM1mTQziI803rJ7VJ1X7mPsuTLGFatcVUseVBVOPOibLjep?=
 =?iso-8859-2?Q?bMzVIJvV7A77S1A9B09myfnZFEdcgdDqs078kdGFMP2kNl0dlBQook5Unf?=
 =?iso-8859-2?Q?XKHltRhJotVqJzLCD+zaW3OJFsHEsG3sVJbLBZ736ivqVBXdOp+asjP1t0?=
 =?iso-8859-2?Q?SCWpEMMderlFCgJOapeunfjsV4shfy83UfS+TQhjwCdQutZzxQvE8hVxDA?=
 =?iso-8859-2?Q?R9zEUrS9agHQtMvSLc/9ulrs6YMfjKFXUlYXPkvImFjZGJQpOjX3McjO2M?=
 =?iso-8859-2?Q?YrRbW4O5RvIyvlAck+FRzPjsmr0/5ARLyP9E+5tebFb2BX?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12019.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc341144-21fa-4a39-ad31-08df1a18dc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 08:50:18.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g26Hjv1wSUR3wXyeq7M31HOB+OcquRhxn1k/JvB6Hxn7swnAadBwXvgdpVtb/tGsU9FtRdb0DnjvzZCcEBy3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182

> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Thursday, September 24, 2026 4:34 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzy=
sztof
> Wilczy=F1ski <kwilczynski@kernel.org>; Manivannan Sadhasivam
> <mani@kernel.org>; Rob Herring <robh@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>
> Cc: linux-kernel@vger.kernel.org; Peng Fan <peng.fan@nxp.com>; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev
> Subject: [PATCH] PCI: dwc: imx6: use regmap_assign_bits() for conditional
> set/clear
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Replace multiple if/else blocks using regmap_set_bits()/regmap_clear_bits=
()
> with the simpler regmap_assign_bits() calls.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
Thanks.
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

Best Regards
Richard Zhu
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 32 +++++++--------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 28fed010b503f..e2e55a88e0132 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -747,12 +747,8 @@ static int imx_pcie_attach_pd(struct device *dev)
>=20
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool ena=
ble)
> {
> -	if (enable)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_REF_CLK_EN, enable);
>=20
>  	return 0;
>  }
> @@ -868,12 +864,8 @@ static void imx_pcie_clk_disable(struct imx_pcie
> *imx_pcie)
>=20
>  static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert=
)  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, assert);
>=20
>  	/* Force PCIe PHY reset */
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
> IMX6SX_GPR5_PCIE_BTNRST_RESET, @@ -883,12 +875,8 @@ static int
> imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>=20
>  static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert=
)  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_TEST_PD);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_TEST_PD, assert);
>=20
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> IMX6Q_GPR1_PCIE_SW_RST,
>  			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0); @@ -
> 901,12 +889,8 @@ static int imx6qp_pcie_core_reset(struct imx_pcie
> *imx_pcie, bool assert)
>=20
>  static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)=
  {
> -	if (assert)
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -	else
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				  IMX6Q_GPR1_PCIE_TEST_PD);
> +	regmap_assign_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			   IMX6Q_GPR1_PCIE_TEST_PD, assert);
>=20
>  	if (!assert)
>  		usleep_range(200, 500);
> --
> 2.50.1

