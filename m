Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CB37D13D;
	Tue, 23 Jun 2026 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225176; cv=fail; b=RHqSoh514RARdcuXtYJVEVyfdazHuZfXFhLHlfVyDmQdqhI94zzRjMFmzkuvIoFNrJIAkPtEK1cnrHGWJHcylRpYgbt5LaB9FyFzsbHK4xXz1F8iKCBVtPIDd/PX0MhBgIIiqrgpheI1MBP2jHvVARkr8KAuTzbx9tGNiB6cWx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225176; c=relaxed/simple;
	bh=1LD/QSnPYTvfrLm6WMeUSMlMpiAK1B82eBWmCXrJ11k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q6Rqzlg6xazzi58uG9egQ14O8/uggn18Qu1GrAJ13YpOmi6REcdB2P5wxlZoYidtgwuE02+s+W1jQcmOPizSPec6s7OY6DLx+KjhNgY3HH7jzXI0b83hheneV/Bw3Ac1KshNHxaIKXWJcfSVdOtYe/iRa5ZdTDRR7rPxaELcRBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bpdpJ81W; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bpdpJ81W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzxsnzlRnWScTrOQBDIcEN0rMPWr4pHTfOVkQDwjUWU7YFaIVq4YHcBLIhqNxq04QDchms5926xK5eQuEPxkECEwx7DjrEtTdybq7t7RnZRHHEQb/9KLemrnTtwAgYm/y44CeeOqdYADZCpCKVQwsIn6DQVowyHlttN/4HAaBE2q/ljxOdyDZbNApycQDA1RFstFkuzr93s/8l+9F2rrziSerMbqwHIWAgXANLvPGhGVey614rY166mjXGL9ICs6K5MFfRAz+VRCoT1tbrDMIkn4AMNn6eFYsz4tc4jgY60HCfIWsl15IMRWqDjNrEcm/Ti7IiPl60/k215HZEglDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62dA7ve1PNO0TWg+bckaadD4iFexevwMzP6r8lhMcH8=;
 b=aWjpefjv/6ZDibqyvXf6vOy1jd0Pm7xqKkYHlS5xQa/Ava5dqE+SglmgBgRFStEeIpXOMnCzcMTrSqwQRmR89/swwlstqIoj+uE5djXLHXAEMZn76Q1e1ck7D8B1D/BcyDdy5LAAeAAQkX1Q8YGpg3L5fNPZyGEUcb/8PlZHujRHFBl7QtzuHGoJbKhg29apl62OYrA77xcL7iIDtorzBAgiHRshnPWQBqkaO4DmwE9t0oklNA3JSkbk78zeNF6BhaDWeUzf9pCy5htom0wkjNSdEco5zBpmyFurHd9PQ0E1ygqF7gTziqnZ3jxWFoGfT2KXcAZN1E8p4L5WH+5hlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62dA7ve1PNO0TWg+bckaadD4iFexevwMzP6r8lhMcH8=;
 b=bpdpJ81WTKUAhQoSYtdZerpwfya2SZ7B635zTlm9HOYzkURwz2ZUM2teor0By2mUXlyY578jCJzs3/b5nEGwhg1RF6e6KCJWzEb7ey9Vapua9Hlamqz/jyReX+VFWimP+Ls8pvQlua4EuIeP1C2olm6k1RLlyWLZPVZPrIdvqVQSxBPcunHuhktXQBdM1Qq3wBybHMGwZvgSeQMQIbGZzO+z7hmIxvqtjEyYEzkQFsH1Ye9K8tXhtsRqDQ+8APQgtm/B1cSzPgWZjoG5Fofl+mNrQkGm4vISl9tYLuIenm2ZO16vdkemtueM01wUksRgVipgIV4YJhxq9vgeeJX0YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:32:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 14:32:51 +0000
Date: Tue, 23 Jun 2026 09:32:36 -0500
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
Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <ajqZBM6IkbDLiVu2@SMW015318>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
 <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
X-ClientProxiedBy: PH8PR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: de1657a0-8aca-4d0a-3001-08ded1344dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ed/2Rf+hsnT6MKu2azuRV/pgt+95jZp0fPrJVrbHMV2h7Gt5vZq8ZcQSgRkzHcZFqpdbU3BeG+X17YJO691Eup0iO3Qpgv5C1NntStK5LWBRtqd14X4wDnwuqEfB4qcahSS5YdC0/W86KGM8x1nEJSN06CqCQUn4E7pwhikupIbUvQWnZs32khodZYItGixmiDpiBSPXc+EQ5lAXompQKueNgwJXIYORhy7ENUxr52R8wRkU90fPB1npZFM1FD9oIT2btWxm051ka5znQYhTn6+baYyBfos0wHW4iQh/OG2GkEocJacwtAVmIK5APnFDJzsz5jJVQpchAxjxW+W+iKVC1pXd1pjC6cJYATMgAInG4CfbW8U1OisYd5XTjAlMrw93qGytwCzKzNXy8Qz7dwBrq5fJsLvyrRxl/zuR0r7ozQF2rjBwx51xDFpLFO4OHVxdLR1wpkkMVSpj+hpd6TObwkIh/hE0gBMPM71G1V1O93TxWEoWmp1suIzC4vGpVBJLdiXgiePONowpFPX+yNtpSIldqGwsdENx3kjrBcxPtv3iwYUK3mvnDdIVOe1l0MxrquFG9E5vx8IwIGkpS1CxArGah/hKWBYo/lp+VGkmQNZ8kgzJHUrYwrZiraFhL7yMJa4FYH86pzbhWa2E7kXZ7rDxtSSjGG+eNtR7zDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9t6Zu4AZ0GZp2K+zm/SbNCXO2xmp5bXdm6nn7f/FXgepsEUko0faJw7wzHKy?=
 =?us-ascii?Q?K7+7G4SnH4ktNTc3ytf92w+pv+X2js3m75fS5CbsivcaHk1VkrrIIpZBzgyy?=
 =?us-ascii?Q?sisHI7AybtUsHpUPLlUIlAhFEVwXL4ijs2E8h1VAr0+qtAhr24THFyutqPbN?=
 =?us-ascii?Q?qQ35UwN1M9y1MNuaK7PpQ6SBlMcWY7RbDfGjPbZFS/Wil/Qa3uOr6mOt2HXk?=
 =?us-ascii?Q?UZv4PjVxjj5HHhzGc5uk3vXTzz3zKlRAM8ieySNNtA87dZOYoRcK9xybtrh2?=
 =?us-ascii?Q?+97uqPyOQdFEZX5vzbhH0X9c4uAWYjk0EHSHVnfr54ZcNjvxhOPvQYW8rICb?=
 =?us-ascii?Q?1GC6QKDAslak8c0pbhUL/c5wUTF1WatQjriRuDNyGBqVASDGySqxwgcH6rAy?=
 =?us-ascii?Q?6z2vKrZucZKZk2WcNsJz4sc3rwaACcRiSUO1yuZ//9VxGHfE5YTBv4EnQcop?=
 =?us-ascii?Q?cgWcXcXdZbXfhJLOyntYN51GTZWvUdmpTciQvd0iZoH2bLQqen0YH8YVGMDM?=
 =?us-ascii?Q?FrbU8iyz6UMDVwt7KPEmZ6BznHYHM4wQoKseh/Ji6oGC7LdW2cskhvefe4Xn?=
 =?us-ascii?Q?WAgQT2AQHMhppQEbiV3gDLOMCGog1SnxQ7yZkUp+1Ts9D29/nuABtHqkqJBi?=
 =?us-ascii?Q?BsKkk4AfTAbojW37BG5ni36CXIGr4jN5jTzca2iGezOs7D6kHf4Myj888B4S?=
 =?us-ascii?Q?oprGn4lNs+G8r2zDKbyquXX0yUwAvgpiUukx5Gh+tFwJVm+7s5hMVIe5kf7l?=
 =?us-ascii?Q?FntHXi1IEDRebnD4Ps27pKCJt60wZ4oF6/TjMofQHjQXV3/aUUtCGHxSQPgT?=
 =?us-ascii?Q?P75UuLGzbv1sXFMPbNP9H/vjSUm8SiguShb4sBIxX5hZ+Sgy9dbNPMgpL2fN?=
 =?us-ascii?Q?jeFzjaH1vzHhMWDVtV5zj6ZPaSEbRUnX69x34ZSNpHd/+1AA+pU7/MNvbHPA?=
 =?us-ascii?Q?FlcASHOERqln8ryHhJYFnUjBGAE3Vx63YY4prFepCl91/kdwsCwO3ecssMRd?=
 =?us-ascii?Q?zlF/oW7gGV2QdqkmR31EMU6pjP96xw17S+/AIn5YnaFl42Sm72erTGd6h56r?=
 =?us-ascii?Q?YtkuuDQgXmulY1wRi1ogrESA0XaHiz+QGidRmZaypnong9TX6xHm/Wxalm0U?=
 =?us-ascii?Q?AU8HfJYTIRkkUsg3py11gN7OfLVEF0OGZR9HKATuG7eqNSAN0CG8i6PcH7BK?=
 =?us-ascii?Q?4QHk6Y8DpKBs1QqnHXmBIPgILFNvQVjuYuODKQvUislSrityrp+v1lXI3RsI?=
 =?us-ascii?Q?n8dUz653NosRjCqcKG7GAVmcLOpMkmbLWUO4w//GayG1yQX1ae9jc8Vbmg5+?=
 =?us-ascii?Q?phFl5Vvp/6cj0906p5tgAE2z/vbsnqcNfWYVUEDbd1ugujipjO1kq4ZFlezW?=
 =?us-ascii?Q?cO2xzHKntutyMG9RNqYpe7uQu+psYfQvSKB6uQWou6dgK5mCeBKmj4khO1qI?=
 =?us-ascii?Q?1Ym8KY0mQxIYMbr6GF36P/tXfkJ+OFF6Wa97mC36ICQ3uGXt5YaMu9X08e4E?=
 =?us-ascii?Q?reIVL8+tilzuTz66AbF5OSqqeJ5XHmIWmeOalsEPTZZtBsIij2SguWZbm1uN?=
 =?us-ascii?Q?rZMzsIUYSs8ww5NaQSvCkuggqJYIPTqhEdQskvEVD045FVeS69WGPpLpVFCK?=
 =?us-ascii?Q?X+cBwdIXdHiLn9MXMxQThznDaB3VNq/rC4IXmIjPxlyp2dF3OGl6tGLT9DAq?=
 =?us-ascii?Q?HQs7+83d9Z2pduroMOLrxJGCQNsxnASzANAVM3x5ZWsYIFNqmhtsDGKHxh0Z?=
 =?us-ascii?Q?lIu/dAFJ2TXbwXIybGbZ8RD8l/W4DwZNd/uBosVzj2fu4HFJMfi3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1657a0-8aca-4d0a-3001-08ded1344dd9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:32:51.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAO9okzuLSnV7ooxWd9bhFhZ0eTEg6secES/6MMMQFsP7IwfTPl52Mh9mc0max6bSRjElj0RoD5ZBwPf/0jjDn4BNT4ATzNlWrGoXEZJH8tzqEGgTtzkBI8mX/4QgirC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002

On Tue, Jun 23, 2026 at 11:07:28AM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> suspend to preserve wakeup capability of the devices and also not to power
> on the devices in the init path.
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

Is possible move pci_pwrctrl_create_devices() of pci_pwrctrl_create_devices

and call it direct at probe() function, like other regulator_get function.

Frank

> +		if (ret) {
> +			dev_err(dev, "failed to create pwrctrl devices\n");
> +			goto err_reg_disable;
> +		}
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
