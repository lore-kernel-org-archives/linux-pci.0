Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43D2F7EEE;
	Thu, 18 Jun 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807859; cv=fail; b=ieeFiMqOlP9BgBswIZcdq+846g/u9UZrQjp6npCQzuySdfVr/X5+Vg5y0tdYMWetJAgmyVPtmZ/E/hn9PcdZieFgU4+bzQIMVQrnPtvMV0Gx4on+uC8DYuVDypAKQHtNgKu4FbSTcEuetgRLh3FyznMFommwCXOcyJ+VuBnEwHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807859; c=relaxed/simple;
	bh=TbYaJEqpFQ3p5PJhPM2I7qZ0sZ3cYG8rJleRFtaBz+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWdPhJggdKytOKg6KTUqkwcmbjYYbm/vRYgUqlKjWpXbNp74sJc0VIhtVljLVMiAbM4rxIKTqpBMVwZlQG0WNRLYzgmqJGOUPiB86OPhGYJrgO7PPT6YhtOQcrimkBy0RDSJBmp+l6fu+1JLX71tl8+2ABDwb9J6iS0Hjru6y2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pxP7+Q48; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pxP7+Q48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtD7+9pB0hkkidth4S4G6rrsf3ZUZWrBpQDdoG1Co+xrnC8F/5jq31cROnxtMQ1j2GHg41cqhDnwD93Qgd3EdEugJZIwjnOmZ2JxXuzg25Qea3nNEzKoWXYAx/ZUhq0wX1i/RcNoGwI6ba5+sSBuhr8f3xbNU68T1g6W6V0Y2EduTxN9iAMcuA91hzvJmVO3vp0BvJslEfaS/PA6iUkLQYn9cRA4JCXxPyXTs85aqRKnhF24ekG9TM/eM90vqussRHobjIUuj2p8FrnJx6fLyZyDPK8D7wNQkvnY7Ajnr2wO7yT9HnlB4DysjUDvQaVBNkr1lmN+kkVgx6oJ/JoPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24topQqO61YewG0no4HHCOE6b77HkVyOBmWuEoQtLo0=;
 b=C8mQBY00zhw6uR12oU3IOJD46OUTHqgzXpJ404argfuVQ70KjNnDgsY3YMvuTZoU3DCWESx7MHcYPLLcqpCGNgXiC3Q2rPdN7My+FSqhkNIXUbxGUAD3Xin/wk/kbsKWm8tNiO7/4l2w5wP0L3SXuLqFVZWOJ/hjxUUntiWJk7le1P/pt9/Tu77CHInOUykV/WIRS9N+fbqz89kunXetDvFF9Enhs2Vswi1xZpyNkpAFmDco5SZiybzSacASMNAy9sNmDu9D4tWkP9dT3Jxu4J9/vHJL96S+E3OnBxwQBeiP+8W59RVpa2+OvmHc8He87OvfthqXQ7HoDiljdUEfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24topQqO61YewG0no4HHCOE6b77HkVyOBmWuEoQtLo0=;
 b=pxP7+Q483iz1q4Cw3LJUg1qmr14vPg8spNd/3CRiOTQgkXxyXfNInd6XD5S9yBR+sa5Zg3dgo58fY3q6CZfQXgj5+nVryr1J4hElM9hIVdnSfRcgZT2VNSoqg7qvpc5JTPTXeHr6+hgZB+4C4DoVZf5Jul4RbJ8rNuLNutp/SHuD3S8bec+5xzfr/hz/I9u3zmjSgCQqo85bH8j7ICuxKNKYvEg4K3HCuxHHAaPZyBfduS1V/1YRN7wrJPk4CaWSf0nvvqBv1zXNqZnX2vN9DOY1B5OTt5qYYuB4EV4SVdQVgRoXCLDmCf/5XKJEo5VJ9eBKC1KHhLhZh8+cbBO3Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 18:37:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 18:37:34 +0000
Date: Thu, 18 Jun 2026 13:37:21 -0500
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
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <ajQ64ZswbmTceIGO@SMW015318>
References: <20260618101047.4185497-1-sherry.sun@oss.nxp.com>
 <20260618101047.4185497-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618101047.4185497-2-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: SN7PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:806:122::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bcf840-08fa-483a-e2cc-08decd68a99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|19092799006|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cVkp2BHagsNGmL9/GDFMjaiCIlWVtTMZWxuKwVa0Btct8dY1nYikn/IcXSup5ooNjYaz0SfqtH1eHtJhySfsmMLKT450EMA6HuNwS4NpQn2TIljl7foXkS0KcJUe8XiFIuILaLTsNgN4GAzSrxbMtFOZg/jdxAR7/mUlwdGPwjZ9JLn2fl6kxsDCjwsZrXdVmwyH1683Lt03hzVfXbg/VyIMnekN0rqL89u8prsjNdjYEOO9CYOLbSuVc2osuqGS4QfnUnK12zD6jVzMHmvc2awv6x7dMn5UsREpPCzbAwrdnaNhlEAoTgfzKGKrM2tyX66qf93cex2Xc5S/qtZwxnRNAy3GmLI3V4voYgnK5EOD1RhtQ0ROiDmVjP7PzIhQ3OJIBVacbyd1yQiIX7gC/Mvcqu2WZjZwPb4KxHJGEdwEWk0P0krdSRAx7CVMthzloAl66J7C6cct8tCRIKtCVBJ2gcDwfLztkAtLN5pAJsgcWgM7ZQSM+gMgpgSAjYx6dtzVJG7swnJ41kVrRbdDtnL/G1gQeQusoExl2LG53qExXvxzB4v3gr+5bu8LYcbyjmYSP/ZnVwM0GVTE/luDXef/nE9MOu94BcbP0H41252omWhBUTZFI1/QXDOOT4AlMsRhPPw/Vf3+0ZNuLlRV6Q9qIJ6umt7ShkAjhhOciifTjGwmz9sA3NIKJPJSmHNX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1YCxVGwMF4Gf31tGGn0b9FqSwUpsABSWDOoyiN4RcyApQ6D0VtxbJpiqW0k?=
 =?us-ascii?Q?ZB+GfYxviLzJHdNYsHHBIuA5pni/QchMmrAgltdwrD4Z5U/JLMG4QCnEDTxq?=
 =?us-ascii?Q?E0kGcWc1gbmwVGpuXwfrHZBYt6xDHRyaRWutxrhi7p6eI4weL+0KflEiJaeG?=
 =?us-ascii?Q?atqmt0Ees8F7zgYEec4j1pDWSkNs9c9PW5oRNk5zkKX6ORb3ITPEJEWVc2lJ?=
 =?us-ascii?Q?z92chvyPzbJlnyr+ZjbQJMZbGL4yZHsmnzcn2lL3j+TMJn10EkbABz7D20zD?=
 =?us-ascii?Q?wfa7rXqmWb1Z29NL03qzuK4J9IPKwxZAN8tzqkfJuy+z95rOZ1w9xsYwE3sG?=
 =?us-ascii?Q?GbZUV0r8kzeSj27xvL1x0xIg97nrVM7fonn6Qt8XHI45P7Ag2135FHBwh/cA?=
 =?us-ascii?Q?MTI4IdwCYmOuHxK+12+3yvhYy7Rs/UroVNagNDxkJdV81f5gczNWD4q6FQJ3?=
 =?us-ascii?Q?ODFM0/UWjJjJwArVA4oDUL4EaoUvPRwb/292GNil59VaebindH2/T/+NqK1P?=
 =?us-ascii?Q?pXG87Jlu80EVWnhAxMzxANraxfH3gMOkkJgKxgHEHGvUXS/yGk5xqRqduXdl?=
 =?us-ascii?Q?G2wHTnw5jaDJMmqB2liAed5hP3c3UK/ZC+MKTMD+GK8qNjX1HXcj565gfXfm?=
 =?us-ascii?Q?LhsZeDUdywrrzLP4yE8fUjTBY8a0QIVJALQNYlr/pJ1ti2rlNPmDLFTfL8fA?=
 =?us-ascii?Q?/VwJ9h8xtDzqF35Bv8lfpZgz5JaTnE82uzEfAtHNxai0uV3e/0W0NNUTR/M9?=
 =?us-ascii?Q?bzNZAKKis1NDmGgFyBoflk3BnFarO3+eV9QrbZIdYq5eiYDukwptYpIp7oyg?=
 =?us-ascii?Q?cJ/0iY6sfds+CR6NaxYTnMthbb65rj+X5FPh2n3fYxIjoOy0yj0JIkWf9WII?=
 =?us-ascii?Q?O03YCbK0n1xTN6n2LyMCL9BQTmfhYrmaY8hWrJEIW97NM1AlZXbO/R3KH7Is?=
 =?us-ascii?Q?V+BhylqL+42kPwNjI/Z6xEP6H+7G2Ju5zv0sgF1gijCEMYgDDITha1WAX+xQ?=
 =?us-ascii?Q?TRvpfHs8C+k7mkPWGThBAAHvqS9w2CVxqHoK29lfkK5FP9Uurg4VKb3aIgS/?=
 =?us-ascii?Q?bbqjHzX5TEcswfUwexRRnshsqqC9ATWb1iD638mpxC0OA9ay9mJEs8eeNimI?=
 =?us-ascii?Q?wdaACiiWJdS7RNec1fyYCTT/nyB07uLZU4GjDUvtIzZCIP6TH1vJyp6f1/Vc?=
 =?us-ascii?Q?DGi/0Wayzupo/9eQuc+x5Z4qvzVeIU6+CqGoMt/gabX8zYQRVxWO7fm8yhao?=
 =?us-ascii?Q?DAhKSzjbBHO+GPDnVi1ICs1i5sLp7duE/bwVpj3b4dZ0mlPQKC7GKAfIfRyf?=
 =?us-ascii?Q?WWPKbXeyoZ4zazCxpyjwf9/E+vNPi4mbWe1XaDyoMKZRbaciqIJ2iPNpuEdr?=
 =?us-ascii?Q?+Eyy6nbl8QRf91HwyhnWP3rFCr8JVaz9C6m/QDMOneo/umLEoksCDe5NLCwU?=
 =?us-ascii?Q?GHjbFwPMOQC4l1W20m80zcWKQ57hd4nfpdb+oTLejUM8Xi8tPVaJa7liF6Ya?=
 =?us-ascii?Q?VKU5YpK5Gywb/P104MPqipyjJn4W7AwnfnAPSuTm56aUSWUcrSRoqno9Kl+b?=
 =?us-ascii?Q?3oDVlg6+Il7VTYlRtOZCCeLYNEP3MN/DinoHPk+zuxAsbH0fbtBGBPtgxSfR?=
 =?us-ascii?Q?Ndok5g3vtoRy2zEpC7PpJmZS6aFrLevE+rXu5tV8Av9lqaB5tg1yy5me/GCi?=
 =?us-ascii?Q?kOvWSAw7aiTZA0KqYbFpmvSRnjmKs3iEGk19ayKv7aouXlnr9dfPxHQ3bjsA?=
 =?us-ascii?Q?17jffCV6C26RbRsP0JcGitTzr/Yg3T9sn+qFoVtm5aqE04JS8l8x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bcf840-08fa-483a-e2cc-08decd68a99d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 18:37:34.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NAFEKdADreiPf/FT17/edg7jw0brkJTfu+oQD3IB5liHZtXy8KXchL+H2hagFQ2VVtup85z6CE0yZVQ4DSfpYEDNGas44mZgCw22GaZOspk4wetak8jGr/MkVql15di
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230

On Thu, Jun 18, 2026 at 06:10:40PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Use dw_pcie::skip_pwrctrl_off to avoid powering off devices during suspend
> to preserve wakeup capability of the devices and also not to power on the
> devices in the init path.
> This allows controller power-off to be skipped when some devices(e.g. M.2
> cards key E without auxiliary power) required to support PCIe L2 link state
> and wake-up mechanisms.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 36 +++++++++++++++++----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 0fa716d1ed75..ff5a9565dbbf 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1382,16 +1382,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>
> -	ret = pci_pwrctrl_create_devices(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to create pwrctrl devices\n");
> -		goto err_reg_disable;
> +	if (!pci->suspended) {
> +		ret = pci_pwrctrl_create_devices(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to create pwrctrl devices\n");
> +			goto err_reg_disable;
> +		}

supposed create_devices only do once.

pci_pwrctrl_power_on_devices() controller on and off for difference case.

Frank
>  	}
>
> -	ret = pci_pwrctrl_power_on_devices(dev);
> -	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> -		goto err_pwrctrl_destroy;
> +	if (!pp->skip_pwrctrl_off) {
> +		ret = pci_pwrctrl_power_on_devices(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to power on pwrctrl devices\n");
> +			goto err_pwrctrl_destroy;
> +		}
>  	}
>
>  	ret = imx_pcie_clk_enable(imx_pcie);
> @@ -1460,9 +1464,10 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
>  err_pwrctrl_power_off:
> -	pci_pwrctrl_power_off_devices(dev);
> +	if (!pp->skip_pwrctrl_off)
> +		pci_pwrctrl_power_off_devices(dev);
>  err_pwrctrl_destroy:
> -	if (ret != -EPROBE_DEFER)
> +	if (ret != -EPROBE_DEFER && !pci->suspended)
>  		pci_pwrctrl_destroy_devices(dev);
>  err_reg_disable:
>  	if (imx_pcie->vpcie)
> @@ -1482,7 +1487,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
>
> -	pci_pwrctrl_power_off_devices(pci->dev);
> +	if (!pci->pp.skip_pwrctrl_off)
> +		pci_pwrctrl_power_off_devices(pci->dev);
>  	if (imx_pcie->vpcie)
>  		regulator_disable(imx_pcie->vpcie);
>  }
> @@ -1990,12 +1996,16 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  static void imx_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
>
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx_pcie_assert_core_reset(imx_pcie);
>  	imx_pcie_assert_perst(imx_pcie, true);
> -	pci_pwrctrl_power_off_devices(&pdev->dev);
> -	pci_pwrctrl_destroy_devices(&pdev->dev);
> +	if (!pp->skip_pwrctrl_off)
> +		pci_pwrctrl_power_off_devices(&pdev->dev);
> +	if (!pci->suspended)
> +		pci_pwrctrl_destroy_devices(&pdev->dev);
>  }
>
>  static const struct imx_pcie_drvdata drvdata[] = {
> --
> 2.50.1
>
>
