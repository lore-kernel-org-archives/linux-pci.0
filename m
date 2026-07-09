Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF936CE03;
	Thu,  9 Jul 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608209; cv=fail; b=dd5pAI4DQZYhM4QOAFHlsfij6L8iCPM6r4qn6MJbcrkr0kKeBodSmuPeFmQE/iDkzXsIdU/OayydE+UGRBYvw6f3OCv7LZL9cniG7VzPJNJPx7VpWOag+tWjf4RocpEyuSoYON1z/BGofwMWTzrB3g191csgQUXwVVFLCT3D8zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608209; c=relaxed/simple;
	bh=FBW2OHGlr6ySBO4gMZsAox60vWGUiUUoxZeupIwMOFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MkNxfJFO7ygB2rPCBbwKdTWK5uABIo6yvQNq/ZDONOHa0u0vzlbs0yULy2srZ7gI7KvAUOq0HAbnH3LLHvYd9RfFkLrP04N1FcjorL6zT0OT3XfAzHrFKe1CYXAJu3H6oK5klHxVSa0wiT4NiCewSYSManR3gD1FdG8MPDp2YmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p5RD+N7u; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p5RD+N7u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZCm3IlEB94cqrGjGi4oTWNuBZUF+hAqmg/F9kI39fZDD31jeHBoBmFRY/OHlqooA44AwqL7TPdS2Cg2z6izQOqp80IdBXfN/2BoaBdGdwmqxjnI2PCAxeyy0Hx56K4WQxz5aG6KCuCMT+m9JihBZEea60C2n0oi9t+DPGcFXJSYGjCMr3E2FPWlWgv5MDpIu7AJPm2FmSbqFxyvshHdMFwVUbwNzIaiY0PpFZMUSSALm0dxSWlnU+m5QO9KQ10aAtqbnSyQhygO6JXOOFT4yh+XbWYiI4b+UReNDX8iuLHOV5NGkyaAsoazBWrCmgMqtZNObQeqaLhKlN/GZerZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbw/nzl+kgJvK+ax4xbtOPir91QsnYFIPDVBu3SfArg=;
 b=NUItrKklU+qkbRRQyKT3cL9ahFvLPjBwz3jAoNelpmFpW+OI7gIDCOBNcsH4e/6yJH3emVr0pm3T79kHf3aklj8Gs5T8fFSdx8aOLAiL6ifpjusW9iOcLTTzFEDpa9RWUuPCED6uVibZWQgIdE6FJKPKspCJB7Okk6S+GfaJ6b5QKuZopbWY4HiE5AR+oHz9dPi4+LdEYi/PIziWzrKNhqJICvfvCbINjblkraSjHdqSr57Dym2bnRRclg3K378l7K4ujLqpOrZGBnr7X2W0TN4RFussdLOafB2Hy0+3K1Uex9qu4dcOUwUhFNJsJ9K1hK/lxbniMdyyLZc+unpukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbw/nzl+kgJvK+ax4xbtOPir91QsnYFIPDVBu3SfArg=;
 b=p5RD+N7uzKq4p49E7TFchqC/w+t3nkbf8j5UpIX7Zh5BcyNzNPa3XMB3rbpWGJaNLx35XMBp9VoXAceSrtJGSrRGEI+1mrUQBzHX6543KVxomIpAF8ncc0XjwjZIic6RzT+Vo3gqhgekHoeojQW5+BOPCWZsYLEY2TA8oRz+nWZQldPGApABW6M2QAaMiwTy7YrvzMb+enbCE8VNs5in4PVYpGf1hUGjCBtDAkRLoPtO8ltBNwoQHYlkNHSfJXxLK9qWEks+MGK/aHRNv4hZkb9F6HY6YmanfPL/XS2uNxbWWCEx1ReS3dHEuHVuSnCTQBn9ar9XqEV6Tnt7LONftQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB11460.eurprd04.prod.outlook.com (2603:10a6:10:5ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 14:43:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 14:43:18 +0000
Date: Thu, 9 Jul 2026 09:43:07 -0500
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
Subject: Re: [PATCH V5 1/4] PCI: imx6: Move pci_pwrctrl_create_devices() to
 imx_pcie_probe()
Message-ID: <ak-ze5X_zYGoKvjI@SMW015318>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709101555.3034853-2-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB11460:EE_
X-MS-Office365-Filtering-Correlation-Id: bf654f09-43f1-4632-8d8c-08deddc86a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|7416014|1800799024|4143699003|18002099003|5023799004|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Yr8JkocKyHOzy/0xld7g6WZLdoceIWKq4y86vWYQzM5MiSqpYdvB/gZOt1GCR8e0SgHuoNZkfK+zM8yBg/ihZjc/++1PtEMFDpyQqWUDTwi6WryAkx1BGsSD48Pr9IMKW7dSSArCUmxKiZukE1PXaTPLmEOSVrEvFTDJDFnAILfGMWtZFpIhFmKH/vQnXZwo2BO9YxqecsS7t7bDNBX45ZYssa6XZCEir9oSwNMkYAbGenmAMqNKqV6WSauc30I90az15pL7fTZG6UTZkPIbx2yWahZvY9hiY2+JA/sKGDGZXNK1dYd1HHf40FUm8Vqu+nLIVpt7qj31TPbN/72Xv1BXJGPoKQvD0HC5Q0pJqHjIpaQhdi2BwsuJWIbDU10hz8yKiMKluQ8esSrD+2LfGSad4fQFLdWCPpDJOe8Y4VQA24zLPCJPEq6k41BzWF/dpvtdw8YJUc0jBbUAlPNUtroMPQwW1x9UGPRI/Rob6/C9aWcwnIYy7BA+A5HJ2+ObuWiy9s042vD/mrDuXsbA5+Jlfn/AwKOJxVB0DaZwNbUNXJzIihQEWGPt4oA+hZ51fKFiYYBvD6EPn95XusePwaBeY5PCsB0EOfVD5KBhGDZpAHF+cu9TwnlD4vvKxdMTtEv9YdtSTRcBYlAYwIrpXtZFlOu9QDIC9z8fzQVKTp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(7416014)(1800799024)(4143699003)(18002099003)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LLeD+qpcDN4ifH0VsOM/e4JZFg54Mnc6cbfI39q0AlYvX8vNaWIHJStnTs42?=
 =?us-ascii?Q?+H3BenUb4EWNXn/GbVa9RRz2G0uyI2QE6mHb9A/3U20a1mlkdEiqzKS44Q1X?=
 =?us-ascii?Q?hapENuSghPdokjF/F8HkuuZDWaVWT49ifzf8tdatBs5Yu/UrYcKLCoTbNI81?=
 =?us-ascii?Q?+j0p7KO2IOoqtHNZGLQXNOx6U1YVIyPzMPveRJbr/bHCcmm1HSnisVud8Ojs?=
 =?us-ascii?Q?E+YHvE4zdkm+SUciPJlaPzkT/uLhLPJmJjH62X8lsBgfsTJUwANA9XyErBUS?=
 =?us-ascii?Q?un46gi5EMQ7tUgWs7awpproEQM03bPi2xzeJY6h5RpubWLutl0tubJECqhhh?=
 =?us-ascii?Q?XshbMYjh+znIS6IOYg71GnAdDuuOrfUXPTkODiKVQDrrNY83FuvTiW/pb6pv?=
 =?us-ascii?Q?iXBw8vGzM3IzzQy/aiaU3+R1tQtJ1K6RS65rfPwyx//77d53nvmcR2aGcqN7?=
 =?us-ascii?Q?I/r3VCb2njDg2SfxjbfT/FVwE64oIJUX1t5k1w5W5KHqls4umHNyAmKmFzBN?=
 =?us-ascii?Q?MKxyRhsRdeIsKnbAnrD1qk9H0ehqr8pf14RjqW5tAiI4k1MZlppDViakvyQa?=
 =?us-ascii?Q?VRMS/TvKbCulUcHZKYqWdoM5TMP9LZ+Cm+ART6Aim/nI1RyeynswC01h8zmE?=
 =?us-ascii?Q?Trh3fIi0tCcjLOvGw6R3Xy5umiFjouCPkucwVraILZYdxl9mUYvFSpMhEi/7?=
 =?us-ascii?Q?zOUoaZ7KkvKr1CT0fYWuJj8Dv/GTDDhTmP2thKsCbVUC2f7IJ0+sFd7izTHf?=
 =?us-ascii?Q?GLahGThhgIyyCb3kSh3FmOL76PbZwMEUxQCJqfRhL53+f3pz/pB3teErybkZ?=
 =?us-ascii?Q?qJ0bZyLw0vSWGUKJ0u+vGmaHNn6ZrhssI215TW1ClE7oBFAcLuvh1IoEMbOX?=
 =?us-ascii?Q?uR4gO71Lq38YsXntBqlvLNXNuIJ6cWj9SmXK53SzJJKqrU3pj3VEmtpshKQ9?=
 =?us-ascii?Q?XyUc7XRrLwBvpjAkd5E1/3MNKLWhDQNJqOxgtrU4mNWgK1tt9m1Www2fy+f/?=
 =?us-ascii?Q?6nKhwp+YWpkqaDZ9GVWT5ghtTkl3X9i0k2f44eCoDi8NRUPBjgnIYSQi1mk+?=
 =?us-ascii?Q?WumCalXwUSRp54eGX/xBbEiJRLYuHKwha5UcUIcvaNu6ykEbbfHzvXiJMRx/?=
 =?us-ascii?Q?bIfRDImvKzmEqfw5TijHt523Gxt1H6crezKRf7kq9CalNxWc8/CfaDvjA2NE?=
 =?us-ascii?Q?XUZsUwDdbUn3yXQppKuk3uXsf2yRXuUztGSioW80ZUc6WLFR2kIhmlHZLntG?=
 =?us-ascii?Q?3aj8v0siNZc58Cvx2P0s8/12YGXTn/rmzggl0JjRZ87haItu/DJY3On+2EZj?=
 =?us-ascii?Q?stdVwHaeXLUVP07UitXiRiMC9ODHnpD7usp/2wtikiG8JamzEiAIT1HASMIj?=
 =?us-ascii?Q?IljSt+iqZxpTWE/yKbiE+4nBrYghjxPBVXjYQ04hcdvpLqgzEnJIKMVECLnq?=
 =?us-ascii?Q?03pM10735v7tKiMNQy4t9TSXfpA3CcjgyXYWuMRdnKYoUd4N7N3TfSKSuMKP?=
 =?us-ascii?Q?ZLSuf30psATSszRUX7iN+HUXF0RA63kdKIWqYfUoMF961SeVJLUyZPA9RHmw?=
 =?us-ascii?Q?2E8H6wDe2rh6S6qS/hsGTHPoimiOJD49CuDdXtnqxmodC56w48e+nQz/YbxJ?=
 =?us-ascii?Q?9REGGfFM6Kajpo4ZlmM1Ew2ZYzLcR/8jh87A4hVEcNFn17VtNXMPe0z0cIIL?=
 =?us-ascii?Q?sqsR6IGu96b+H6O/ZXRo/GWwSgkXEO6XNt2de5cJDyJfKBiByZvIC7eOg4gG?=
 =?us-ascii?Q?iz163rMoTrGFjFlDZipzMlpx4DKbW3txlUKi9tm7UrKt83S14sAj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf654f09-43f1-4632-8d8c-08deddc86a9e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:43:18.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTE6xlAEIEqS7Na5vUcN5dSYoBsyXcvAhugecOV//ihrvN7IPvx0t7LXN/xqdLABakYLqaLtuhq6UGpotSFrjO0F2FJOq+A84WZaO+tYcqhEF3oCvqXFOxsE3JjFZZK8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11460

On Thu, Jul 09, 2026 at 06:15:52PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Previously, pci_pwrctrl_create_devices() was placed in
> imx_pcie_host_init(), which is the .init callback of dw_pcie_host_ops.
> This callback is invoked not only during probe, but also during resume.
>
> This caused pci_pwrctrl_create_devices() to be called multiple
> times across suspend/resume cycles, which is unnecessary since the
> pwrctrl devices only need to be created once.
>
> Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is only
> called once during probe, similar to other regulator_get calls.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index f55a68f60eea..92f8e4a299e8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1382,16 +1382,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>
> -	ret = pci_pwrctrl_create_devices(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to create pwrctrl devices\n");
> -		goto err_reg_disable;
> -	}
> -
>  	ret = pci_pwrctrl_power_on_devices(dev);
>  	if (ret) {
>  		dev_err(dev, "failed to power on pwrctrl devices\n");
> -		goto err_pwrctrl_destroy;
> +		goto err_reg_disable;
>  	}
>
>  	ret = imx_pcie_clk_enable(imx_pcie);
> @@ -1461,9 +1455,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	imx_pcie_clk_disable(imx_pcie);
>  err_pwrctrl_power_off:
>  	pci_pwrctrl_power_off_devices(dev);
> -err_pwrctrl_destroy:
> -	if (ret != -EPROBE_DEFER)
> -		pci_pwrctrl_destroy_devices(dev);
>  err_reg_disable:
>  	if (imx_pcie->vpcie)
>  		regulator_disable(imx_pcie->vpcie);
> @@ -1954,11 +1945,15 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	ret = pci_pwrctrl_create_devices(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +
>  	pci->use_parent_dt_ranges = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
>  		if (ret < 0)
> -			return ret;
> +			goto err_pwrctrl_destroy;
>
>  		/*
>  		 * FIXME: Only single Device (EPF) is supported due to the
> @@ -1973,7 +1968,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		pci->pp.use_atu_msg = true;
>  		ret = dw_pcie_host_init(&pci->pp);
>  		if (ret < 0)
> -			return ret;
> +			goto err_pwrctrl_destroy;
>
>  		if (pci_msi_enabled()) {
>  			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> @@ -1985,6 +1980,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	}
>
>  	return 0;
> +
> +err_pwrctrl_destroy:
> +	if (ret != -EPROBE_DEFER)
> +		pci_pwrctrl_destroy_devices(dev);
> +	return ret;
>  }
>
>  static void imx_pcie_shutdown(struct platform_device *pdev)
> --
> 2.50.1
>
>
