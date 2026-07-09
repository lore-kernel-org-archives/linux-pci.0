Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5278385D8B;
	Thu,  9 Jul 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608855; cv=fail; b=IHf0K/EVL1z0XX7cHzrdfBHaTIk6qbGxetXs8CDrcS1lF2CRP9m/r5DOioVvF4WmqNGc1ONRV1ux5E//g9s0jnb4X8ofkwbxUpR+JCJpm/jdnSYmUcGcQbX6J0QiZ3pjsefHrlA5m4MUuWbp1Z+UUkPzQkI2hgMB8sfGt2RPiwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608855; c=relaxed/simple;
	bh=h6S2Qr/4wdYT717wxcIHanW4OvIF2vkC4f3WhzdstNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZDBBdGlyfBFHEaAS9PYzS3lVsnSpknI5BAwEkZcqqeMFbcFEEnKR6A1RuVOpGz0fS3Not4LkJjLVRQJ0qnTVxdoIvxsM2Y1Fd4hei837mZa704gTTjwjW8hNnOYVq6VxerHjADsH4AmX02imyLXlBG31sTc8g5gij22Hlq55UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Jwh/F/pz; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jwh/F/pz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrDmTJ9ekJwY3vquk75jT9rvXhgwTRkMruTZXav+cKn/i7EhERJ7YAdrDop7SfpgZ39wg6PXoDKRAAiS8hvMJXX2WCgq4mfSHaTpd/YPXDoNmd2G+22S73EHzf5ToM65eCNN0WXlO4sChxO2F/IgtV7cq0wEfxwS5Gq6yeNZv+v0QNWZ1TpVCZVk42lesGhFRfKx6NRK97RVm5ZbQ2uSJAv3FsRaVXKJTYLFyWf9zBHA3WrOQMhicewqEvROmRP4iJKHy+s/GDLfFoklLS9r7u3tSTcwUwXmrnzohBEVX/NfOiO6j9M5HS914v5dyc8eouxNWiVG88Jh8tU2YDXjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gs/+wI51uvlfIZPezddyVcPdCnytuHjB3tFf5wchmA=;
 b=Q2W7N45rDmM7WY1ZlzA457jvDq9ojDy4aFUg8r4Ai6o/xGLrl7B8iphaNdNM4U2bO4Dp4lTT7EAnDuZJRo4ZxE7wnjtbJKb2TtI6PVuFmCAcSSiOgyiqLA5a7Aql/5/NEnTz3JAoH3M2gNJEUdjqA60q40lgUD022s7sq5PMwH+Yz2Rcl0KVKgXJKLnXWZH4FSsBzrAKmFj370R5Cip4qfaEU0anzzrAzZmwArwyOayaN8FCE+MmBdt70fuoyQ89TqB+2UXDqGIfXsIfV98uZwE1yPbb/qzgcjzlnrGfDqq3LPQe7J8igYw1tF6Ja5uVfUab2cr2edOrHJ06Spg0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gs/+wI51uvlfIZPezddyVcPdCnytuHjB3tFf5wchmA=;
 b=Jwh/F/pzDI7BhHG8CnXhIGMXyLqQ0Ei1z/FZ6BsbBfP35HMCI0aNgXmjYI8sKR7WU3gtrN4h75vhgMZRkF0XTUDsLw4fOldnbu7AyqafyQ6mwvcCWhoRNRf6B6PSsF7KlKNwQ+yLg3gqXVc6L6o8uUSVUrfdOInnEXil3K5sEaGGWki3eCvISOKLZ6JWcpQ6Q7OZl6ny+yAqITHrC3X5DNkic22+nTBz73q3vaOwapWNiebAGSIEFmCVJ6LuiIvCLul/WRXsUQ28YIFzh/5GmXnD7iBNLQhw08RBclEe24wsNinBxLgCewkSaGXN1C4JBLWudBmIUSD9iUcnSMUGKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB11741.eurprd04.prod.outlook.com (2603:10a6:20b:6f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:54:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 14:54:10 +0000
Date: Thu, 9 Jul 2026 09:53:57 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, sherry.sun@nxp.com
Subject: Re: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <ak-2BQEUMg8Ewjz9@SMW015318>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB11741:EE_
X-MS-Office365-Filtering-Correlation-Id: cd670e94-8c90-40c0-e5ff-08deddc9ef30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|19092799006|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PSFR9sD2ngAsK2mgpQNVcuJV++Cu2XOvB5LUW822j39lkXYYGFfAaTP9HFgvRnHgWZY3EHsYWTbfY87mK7dOg88tqOLJSDdspqmreTDB8TjnuA553v2Zr1y5oDeytvWvnZiCzfxkf+xP+CGIWrXoeFQNSKmuPqQ6ggRgPasXr92kGJPcbbnITFlqvoVnm15RJaewQVbemGoK9H1CtX0VzbKyUFToNnDUuON3Q6d08X3Eafix4/YLpYb0auY4FkPFfP/yhhcFZKjU2IyKTQDGsN5jeLF6+FOThXEAQjZ3P/Oo3sH6Lf+rqxj+GQQLyouTHJYkQwPYnsyGWmr26K2Uq9VHbPNgM7ManjduBThpo59jLMxdBgKk2/2J+FyF7Afb4tE/E2icQd0UFSAhhvnykULaCmzGn1oiBKowNYFKSWkMvvP4TKgKZnSKDQCyhtOzld29MJsxXfhqBdht4Ic5oBm7qNOuXVJfd9yXfkwGgoYAko0U2PnKPz1bm16ovvY1P0fLlteC146zzIuMY+82dzPQ/d47PKE1bTZ3uzdySZbCx2vtYh8aSe59ZbZxq3AcThLuiup6J3ZVpJMpnhsCx61Ra3rk+mOCGUnair/SfdPK7bhDdnSvP7J6Z3TOZlDGUq/JGU/YgYPUZ+NwWkDCekVgTgLZITX9Br6tTUm9gLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPdj9wfj6V7/BC8bPj/SiAvmlBtb9cSbI1XFogddXOD9yhmrzxtoMeV8Cqso?=
 =?us-ascii?Q?z6ax4DL+9CzokvcuoiiyzQh6nFLbixwKwZNTdkPUdX2+xdEq78E1O7+xdozi?=
 =?us-ascii?Q?w0zNioObnqm+LWqQ+OyNFN0E//5AQeg8co1AAPDcDaYI4m7tgHzYogJptoNU?=
 =?us-ascii?Q?4WrX/EMk6E9sweeZWQDm0dOOKrDZuY7c++U13ebH1CrgFbM02r24zfG1Vzz9?=
 =?us-ascii?Q?5ZXxxQBU9ZHL7bxx4O9m8Bi3B73kYVNgQhFNZ4Epm0GSHHo3Hz2YLHvAmkzi?=
 =?us-ascii?Q?MID1IZgdnWwbT6PIxGKgXFYh8vdZEfyTFz3XlEKY4mXKWaUt4U1s8hm9x1SF?=
 =?us-ascii?Q?4OG5o7hijbB1HsjnteGsYaJd3p/9q8rplbEkDxBX7jF8h8+H/MiCk/T5Hpmn?=
 =?us-ascii?Q?/rpofaF4J2DTnQcHA5nkd7tnyXwd975Zg1eRGwXBrIsDm4g+MiM20kiYy3fe?=
 =?us-ascii?Q?yhrEYvn+/pbv+ylp+rkyvUQDNHz73iiNe9WSDLiPvDqYd8leSW96OZwPrv3a?=
 =?us-ascii?Q?2zcbM8D028RhvGUUbwfe6j4IsFUlpCCkBKjkHmqX05nIF/vFGQPKFx8A8s/s?=
 =?us-ascii?Q?ikjaciALyS29Sw2zAMyVtYAwVdS3l/jtWDS0ciIcq8lyRIOim04PjNDtKVIB?=
 =?us-ascii?Q?ZRO6OqkEHfLB5hCjVRhnHCuAok21HSP5jy2bsbwt6SaolWXeie6f/OUEtODn?=
 =?us-ascii?Q?ulZuXTNbqGFBJemOY7Nn9uIDfnS/EwBc0KznIiUPihXislO0SQDBoVCuiTWM?=
 =?us-ascii?Q?yWjR4HDBx7YAUitU/KBdOtZBd1xpbnRiI/oHcHpkwMKWqurmfH9VmX4v78pf?=
 =?us-ascii?Q?0X5Aw7Kus5GM1JEykBPjmaM+yMXR3U4BgiB7hfI7ElehFJ3LEHAKmmjISy5V?=
 =?us-ascii?Q?25kVk1Yhi5aVKFuGUNjBEsebGcy8fLbfp9JyEDgOQDKopP+4Dq9f0MHSdSND?=
 =?us-ascii?Q?2Jkss81IXl89InKguWfj1EPQQEArE/cmcraaF8FxSH3zs2Oszcec7cyPxu0u?=
 =?us-ascii?Q?vI4fufcnjtETBA5q0uNU6K6TEXw4KkRsAq3D49l9u598jDqe3qqddV/529jc?=
 =?us-ascii?Q?hb83J7ADsJbsmulvGvdUAtrSJT4W3d5rlN9smZWRhP9Oyotrq6T0SrfTwXTw?=
 =?us-ascii?Q?6kyOBJULs1uCF0V6CPi6kzZGZiOKuXIRcj8K58fDJOdd2TC+g30jIo+B70qw?=
 =?us-ascii?Q?4+tKZT3PcLxsz8gl/idCujUc/oPuZAq/737FV1Csv7sicSmiBmog1RA4MZxG?=
 =?us-ascii?Q?YmaioqjtazHefmYsOjz9PM/YqTmNzffYBHFlVsrFrzTvSJu/0B62HndcmE9b?=
 =?us-ascii?Q?MaVXM4s9I6tUjT8n3Mq6qS7ZgSF3zUaVsivTt0YtzvkRGkpKOYIsG+U07onI?=
 =?us-ascii?Q?OIv6/3LEC5nqU2OGaR9Iliu7Wz4ytic+xO2JfHZVbuhUEW4qwjinWZOpn2B/?=
 =?us-ascii?Q?bI5RlIQgHi46R9qDuPiBlQ3WNfsJv6ezDQPUoAT+yG1hXLj0Xgt4YsXhkhZt?=
 =?us-ascii?Q?R/YdphltIicjpZVs7QGeXBcAKIjiHiPNsrLiIs9xGN5umzUS5f0IqkFrB+bv?=
 =?us-ascii?Q?2X7N56EIJz2gLeMYhHP9jm/ya/KefZ0KFFWgt4bPdZXapAUgf2u50gp5Yz5M?=
 =?us-ascii?Q?FoQpC9NtV6nsLuwvrNTsfuD833Vaqi0fjt8kKr7LVRFR52iPzSsRs/JJ82GT?=
 =?us-ascii?Q?y44PDPECDNSM2Hc8PEaEjSZoRH8tofpVPtPNvxzRs3AS9LRP+k1pfn7UHi2i?=
 =?us-ascii?Q?iWFGGrPcUJ7H3TAjX84ssJ6GWE2zpqO3nswBDA2Hkq+8PjXNwh+m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd670e94-8c90-40c0-e5ff-08deddc9ef30
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:54:10.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIoLWCrGxdG+ZNUjE6v00kXc68EEtMLtUSiB4vyAgIEK7BAx5r7vXUa1nT+ZT1zuq7KaEdcCqrwDMvV8qAVs5JvQDLjTn7kYy45MK/Ea0HqP9huFk62vOPqkeppiuDkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11741

On Thu, Jul 09, 2026 at 06:15:53PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> suspend to preserve wakeup capability of the devices and also not to
> power on the devices in the init path.
>
> This allows controller power-off to be skipped when some devices (e.g.
> M.2 Key E cards without auxiliary power) need to support PCIe L2 link
> state and wake-up mechanisms.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 92f8e4a299e8..afcf3b6bf3cd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>
> -	ret = pci_pwrctrl_power_on_devices(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> -		goto err_reg_disable;
> +	if (!pp->skip_pwrctrl_off) {

if pci_pwrctrl_power_on_devices is true, where call pci_pwrctrl_power_on_devices()

> +		ret = pci_pwrctrl_power_on_devices(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to power on pwrctrl devices\n");
> +			goto err_reg_disable;
> +		}
>  	}
>
>  	ret = imx_pcie_clk_enable(imx_pcie);
> @@ -1454,7 +1456,8 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
>  err_pwrctrl_power_off:
> -	pci_pwrctrl_power_off_devices(dev);
> +	if (!pp->skip_pwrctrl_off)
> +		pci_pwrctrl_power_off_devices(dev);
>  err_reg_disable:
>  	if (imx_pcie->vpcie)
>  		regulator_disable(imx_pcie->vpcie);
> @@ -1473,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
>
> -	pci_pwrctrl_power_off_devices(pci->dev);
> +	if (!pci->pp.skip_pwrctrl_off)
> +		pci_pwrctrl_power_off_devices(pci->dev);

Not sure if there are counter in side power_(on|off) function, if not,
just skip power_off is enough.

Frank

>  	if (imx_pcie->vpcie)
>  		regulator_disable(imx_pcie->vpcie);
>  }
> --
> 2.50.1
>
>
