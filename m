Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F89372EF1;
	Fri, 19 Jun 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878291; cv=fail; b=OhDfoTGvd5DHivFAmDZ4+2NoyxDK01abrvkSwt7yUv539H8ihLFdmFgXxhdLYeqtD9b+vvo5H3hOuTMZMdKtIJNKqqfAM7drdw5vcMCyXMM5tzwJSCgppsVlH59GAcxGv8lCm8xcr2vV3QP8Ep9rc/X1hBjAjZ/QS+L96P6IzLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878291; c=relaxed/simple;
	bh=BYcZeCB9CVSQ06AuMhYEbCKs9CNsEMt4e/nrkT8MTbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gz50ep67HIPkycZ040+3KVZDR0PYL5xaAovP/U0/Mxa2zwPDbluAyhT+Ff8dMXta11lDUxl3WasTliw31GeMuO4kqzZ92P9l/QOdEeN35SurTdtQXCvb5VeDeFZTsZ9fGv12YMB4SHUfjjSiYh+Z8nZ3Bj9MWMDSUbb4Gwkvawk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wyyfm7s2; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wyyfm7s2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi9gHWta1F5pqe0BjWsdyffKCx9s5fHszAGQbPe4qVD8CBdOh5QIsW7OXdF/MLhiqgCGbvW9XwGwZKtrtcjBXs+2bIyn7LFu7QpTMO8PDudn3IanOQp2fxuwe0fTBDXpjCTETFyC21zWhRCe5eRTHge/2c/hL+SOfo1lQwejjzEACXmHUEjjPOOnoYghrIK3+IDoWBRmiQ8BVTwjYfeU7WAwi6eCkptq4z13cqiIcZjdVmJ23jmF1vh6a+LkFe/ciqIvPHKcQtNmSIqor0Zci1sYEcyDaPUAqVqKbwasyTFSKjvArHoVDHY10V1P6eBUe4jX+MEjuC2bLJqaXOedCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik4OGOC5XSbSFI8naOc1uOSjba4/5cyLxJDotU/zGcQ=;
 b=EOQEAlOjN9K5q+r06Nth2nGKF5a98n4Fwcqgf0efbSmAw3j/GdI5VDLM62e4jeAljyCe72B84MsijwIvBDePPbp6oA7yAQDqNrkfQ5aSKldktA5qBkx+yf6OwmpzSWhfanIdia0FWh+kpSx7fDh3hD2bgbO7/B6QomG2jujiOtfp7q6sbFg6eoX0pIDQ3UY5PgxvZINO5vE9Sl+DNIjCYJuANXYm5hZVR56RbPmHBiNLLVMkOr1k+iExpYZQmgVqffYBrivQ79nYCfst66/Ubj7LI4FW3/fQaizoOdf3KWUXqqBSPBxDDnzp38InkMAKozenpj2mqN+pxPPAselwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik4OGOC5XSbSFI8naOc1uOSjba4/5cyLxJDotU/zGcQ=;
 b=Wyyfm7s21T03MKSjWUnb+aPu4oPAt2kjol7n/nkQqCdhUZRt36+eeZo9OtKSUht+M2YBmnOKuLx+E51bKkLn94t0Jciu/P1nEL+TOSXEz4uLIrIikyNdF3pSjge4OLM3NaIKWtgLYgi0Wkg2KQWWJK/OJTF7nzt74SU70HJQ1JDIONAgGNBKe7CFVNcMqS7LE2sfsxLy3OPtkU1mnnJxwZtSTCem/W2Zc0seLZRpNH3o7tw6bB+D7H9Q/fUsQLDI+ajZB1FdA9gOC/0e3DLiRlgdbuCYb11xSCla+NxsSI/vDiYQDRIbOkOBe03Ajn9yo3fXQZK+dxjgl7Fhwm0g7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB12566.eurprd04.prod.outlook.com (2603:10a6:20b:77a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 14:11:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 14:11:27 +0000
Date: Fri, 19 Jun 2026 09:11:17 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: imx6: Use dev_err_probe
Message-ID: <ajVOBbPYqXoz7oeD@SMW015318>
References: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB12566:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aeab6c7-d074-4dd4-2ffc-08dece0ca74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4bvKLNjIDMdHgb9KZxIyrCDncgl3J29mWJcGB+0SXDUfbGoG4S5dddw2q8dBgWH+tENRUH9Tbot7c/ADBY6EdLQ7uEnwHjMCSnDWEzBBwgPsazzLmD2eyM8Pb8kk4yKKRfsbJ9mG+R9iCedGuIEFu24swhygLjp3AHTcnPdtuQxqxv7xRzovsDrCejLxD2xHlyHgP7V8nMIajM/p+B751ks2rNr/pDwywn/56Wp03Y1M9EJLPHmXsKE7zQL2P2BGTouEF3mxlIwfZp0UsXbXl1fbKdNH5F+lSsrbxFWt1itXS82QlTCP19Sb+pIUwy/vB9kd6F6iB4Sn2ZNL21w3IRLOa1Y8ZiMDCZ6zd41ARwrIzRwyoU8VjlVu44ShdIOGrILDf+1x3nJJhdTzkHkjEu+VDJVcFJCgJrsJA3Oyz2H+KfZs1k8m9ixWUZ4vsRHBHhHki6H14Dtydj/vP9UcAHmJ6Uo78iIdX730Mvg/g6ybTsqmS8QphCM6whGah/EPh1w3znf8DjrJxjA3NxLglM/upSG5x31TX/TgvPpXvoVadcSc5K0KTtZhCQpijPhAHW6tprdOMXwR/SG1/63t3uSdCdzNueDdPT/okHpJmc1nmU+/SR0foa915gIoILwL5IanrriumEr6X1h9tb90SFzcDpvKUFIv0viikeavvKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDoh9PcrOjDwdLfR0Xdz/6tcWqBNKYFXNz6jKRwBpYvG2kfGNhU+/Br374zB?=
 =?us-ascii?Q?D4pwkcUFdDSYXCWbyVbbEbsgx0AaSMXSn4MSIx5JlFlCDZtIWffrVj5ziVBB?=
 =?us-ascii?Q?drNzisl6fVs6hcFvEP6jLpQS7H/xfBJNI0jBhn3GPU6hC7bV8thEU0xiKJ0+?=
 =?us-ascii?Q?rDNVLVaFlfaRZDGuger7FqzmzYEj7dan8HPW9FvxyZKNF6gsDWNKuepog36v?=
 =?us-ascii?Q?WxvdJ8vSpZ4e6nNZMWxfGQF3zhzbLI0Ps4SqFkok0mrVmCwW3JQpD6D1clJN?=
 =?us-ascii?Q?tbbNUJBJgNdTJ9455fh6ZPhEjxWh2WH60FgWsS6MxLVxtrEo0d3yQLaMhBiU?=
 =?us-ascii?Q?7nTTeNquIJGjWLIkRif/3XHo7jxWXy3M7AuEcJJY7xpPnPt4/CxTFbGOEiSt?=
 =?us-ascii?Q?y/cgVmL3XyP/OsbGU/RNH7M4BO0x24A47Rl3s6cpeOu/4EZrtd+QDsLuFD0C?=
 =?us-ascii?Q?i+1b5wtW9r8RqnAJgk9PUQzfP9YFgt2xyl3CW5oTgxnI7xUCp8xXMSWXh0kh?=
 =?us-ascii?Q?prTnyoaYkAvF5+yqbjtqhaLjdPbSVRJQm2G0frOXpuEYp8b9bFVWHH1AOUyW?=
 =?us-ascii?Q?p4kj6D1TPMnBKPCMSWkr4RIIxbgklzKANJO9nFlQzvXYi0fZkyiCG6RRraCx?=
 =?us-ascii?Q?sAA0mu6bGPVxtHvyQnbnngRCPPaUuLhacP7FpaDc/C+HCHz4pb6U5FWBxVXR?=
 =?us-ascii?Q?2BDvVuOb4CnpB8P1h46Sa77cOnJ96YMw0EmLW5eS+md47P6I9/i+wFvZMzUX?=
 =?us-ascii?Q?rHcJZzSQarIOquyBql9EjCN1hRDBNWqajCgSSGcKqXNz89T9qdTZh2CLpSHF?=
 =?us-ascii?Q?TH73TliwRfK5pfl4S7jovmJ8BsL6+JQgXO9Fe5T/mc7AZt/APKVQQvrRzOkn?=
 =?us-ascii?Q?bootK/8suR6pfCCPI2/yTn2cmNHtY1u+bNLQAxjNBa/wwbPP5DheFSEUWRQY?=
 =?us-ascii?Q?PNMXkwclpSRcyliUL14oa7ooHJDsfCTvDfEih+a+1XXnB+lg6YyNWE26VtJ8?=
 =?us-ascii?Q?En7MNKQ+og5h7fTDiHuEbHJIZ7fOswDXnl+alF0eLGwNqZdP7/qsLNIVLhhX?=
 =?us-ascii?Q?cxeZnEaxaQ+VcERalTBpW3eJtzwIQ83buiW1QGP0fu+917JePNSdJ7iE1oQI?=
 =?us-ascii?Q?+sncMZOG3NRohwNfwVknUgoImSD9Jd1L6MedFHnRx4tUXEjCgGpJjn1rNSoA?=
 =?us-ascii?Q?xmVQz6oic67DyOfcAOkyMCqSDV4FwmqQ7F/apuTTKLrIF6jQ1PxEq2PqHFjw?=
 =?us-ascii?Q?eg05ahPatuNi4DgeLEEjh4ZKyYJBKtnmjDZz5tIFgzzxuFvOZ7CkhBqpmYUf?=
 =?us-ascii?Q?lO3Vs0vfvSJT5LFeKZUvD934MdOEtCJVDBngqQunRCoO7O9Y/Y2Y6eQhC8Ha?=
 =?us-ascii?Q?+Tct3KzUkydkF/bZHLVmN3fbijyQu32dHmHcqApZlwfTW0y2WsaVB1tXMtYO?=
 =?us-ascii?Q?uT0dTGGKvueS3oEthkpLX8SLp8EVwxl3UXr4p3A2fGEm8Paojq+/8Fi4Ma6l?=
 =?us-ascii?Q?UBMkk21s3IisALCs0orckid4BorJ3Ex7TAPdruOn8Zkw/PGAoy3SS3Qrp9+Z?=
 =?us-ascii?Q?URDj+JmgtzP7gsOviegooHiCS0NBszw0K7o1Wsj2EdKdgdz+WuWDLeXmgUpc?=
 =?us-ascii?Q?gDLfDZ6ieqbnmcKt5++ZUv8xmvqWxIl811glA/K/ykyx+j4i3MX26jqa+F0F?=
 =?us-ascii?Q?hxoHnojdURViiXfWT+UoAPGLZxCJHQtpyR4xUnFYXzHTqCmlOvV64GdCjojb?=
 =?us-ascii?Q?JR/8o2ReRc/Zh9UCwqqNpP3KDEaRu0MQMj0+n7Wd/JmTn472cShA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeab6c7-d074-4dd4-2ffc-08dece0ca74d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:11:27.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9/sd44w6U5qs7hZR8bnTHZKxMS/QXCzCSqByIQJjiITCLB8xA6I8XdBMKHrvyRNxhglmgzw8YMRb8+fu0wzODe3XRZ6+Ye9fboN4XtDxA6Z9dHK2cl/Tlc9MNJkFEVi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12566

On Fri, Jun 19, 2026 at 01:25:33PM +0200, Alexander Stein wrote:
> pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
> an error message. Use dev_err_probe to silence this non-error message.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 98e1db751132a..b7a502e9a1c59 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1381,7 +1381,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>
>  	ret = pci_pwrctrl_power_on_devices(dev);
>  	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> +		dev_err_probe(dev, ret, "failed to power on pwrctrl devices\n");
>  		goto err_pwrctrl_destroy;
>  	}
>
> --
> 2.54.0
>
>
