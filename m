Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819454654;
	Thu,  5 Mar 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724748; cv=fail; b=ZevVt6uift8xL20UvLPqGmpVWTFfHgFdU4c6dSEFi/YzWcw7ZidBx6Aq3LHyzoUj9YqA357Aj1YPZiq65c+COv/EYVpXzLqqXbGPqH6koJsFLJItJI9SmLn656anP+zJapy6fhxuDX8vfWH5p+UWQSabTNcch7262muN57t4eQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724748; c=relaxed/simple;
	bh=54/0QlMbD3yfS/ndafyi6yTgQapooR/m5ctbOPL5KlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hf2m9P2mPYVNNEwaWVmaE92JDFT8l6QhvthMZAlK/xX3c/+Q1yU1R3iw6twTC4reF23aiXj3HOYkND35U14MSf+zm1/AhDEwKeY93breAvWphbgfQsXlWkV3CHtcpxO8ZEX6fP7t46RLjY/5AMzfO5ssSVfIQNJ4n+H88bLm28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J+rVZWVv; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J+rVZWVv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzCar6BtFDoSuJFNDYNnE04rribedd8o4+OOaRZMEKQIARO2PJbJaezlIQILifmJW6oTr+UGGxIe8rWBDgvNppmRC0Upg5dCDWynzzm7f8sH1/cS1YYfHMADlYY8rZ4RNm5WG5smegMSyKiWr2pF3sir/ZUaCYBfGcYANVM21eILBwB7ZT6Rsfhh+Dq2NijbkuXiEXFLho64SNlYCuPa9quz2L5gUnHKNITcA2FfkeGLc/uLnNb5YepzUbG6k3QGlldybH3sXSbEk1BEh6544k1QcIuNg/JBo4OUWYf7PGlCG/qqJakFpGXI2mLgUApR2c9HzYIxyXyAH1DMblYPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN6y+kI2YfDkrkpPMJZpKmNmx8d7dzN040/0jEUGVEU=;
 b=u47WSvONZE1aAhC0Y9RqWQBTOniFa4DsxP2B8CGmMXag81Wzl3W6AvzvPcq9mbmq1HGlF7Slcihi6jHKUg0cySl+LplwWSsPZl4Zv6UdRj9n+FGzX4TVIDbH8sNL3fuxCQzxuqV1D4CjRvZahWb9kib6rW/aL4CSr9gN1CCUH6XtSi4JB/2Cstrw2rOC5E87C3eqtpn18G7QQcCbUMyvOoBvwt40jX0sInxV0tyjGQny6243Mq2vjoUEMgiSFbCFiuKYNC964XL28meHHULID0S/ge0BoXnz+f1JLKDSrVpNbqgjgtVdpmQeuUXiTk9u/KGo1dzOJdEbo2znQqSZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN6y+kI2YfDkrkpPMJZpKmNmx8d7dzN040/0jEUGVEU=;
 b=J+rVZWVvkf1pYxo00EW5ckqOznG0PjIn9UVOLIF3rPC5xwAmYo8rapbbYDa8hLlVBQeDl+yE/CzsLKCt1Mu2Q4PrmL0hA8k5qLXh2jKdt8PTgcNo8L2f2liQw/JWe860bUgz7OOZk/ondIUb5JzG9tXIhHtewQFEAEwl+XYnli4VQZ7CyGY3Azc0PEI76KQmG8MOPenyUSktRAtuqwJewfBycToDvGedBiLmIAlws/7lzeCDNvPKbVvOtOpvPFc9x5nXknEISyNDgYLsWQ//yKav+qrVFwLrOCZuN8jNQ+rkWzms45TkysEwVxiFNZYNQE+Xe1kTMOs+YCVSq4PfaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10156.eurprd04.prod.outlook.com (2603:10a6:150:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:32:23 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 15:32:23 +0000
Date: Thu, 5 Mar 2026 10:32:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Change imx_pcie_deassert_core_reset() to
 return void
Message-ID: <aamh_jNadvXQMGs2@lizhi-Precision-Tower-5810>
References: <20260305095259.235049-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305095259.235049-1-sherry.sun@nxp.com>
X-ClientProxiedBy: PH8PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:510:2da::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a328ffa-5df4-4f74-0d76-08de7acc659d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	8YJ2QItm4iox7+pVoVPEHrkvW8dN9eC4QmZU65INiHi7a99c/7fEYf5qYTssrEuPcsqIMItybPDIonaGWiDZfp3EUzha0r87Ltkpc4j+1Vv1jPrVw6ABa9TXtyunHd8WGzAUjWiV7u4nY0m45KCBNnAu/Tlkekm20aT1yNfhhoxXN0zKFhqdfG91K2bn3CqYu3suRxFQrIhVCulIuIdOViwEOL7PHZjrkVDY1MFYPZEwCyvcqMK8eEkddGWMFYJa3gbCUWrtZ1NtTwveygpVYE29DAOYOHdhoJKfgdQc/GuxFKGeDFNxlsZgru5PWpof3A2AzhwDlMMGYqjfTUy9ZbHbj+h2zAJJ3VXqAy4LH1JdhNrzLUkdkqA07BMfp3n963zjFBP+Bu2BKNSrYfBBec3bV7HGNbBaUF1w0y3SgbilsXbKrYOdp5bTm+8r9syXHJXSBd2BW3Ep9N/X2G/xCAgtmoIQdDP3l7qIqikU/ab2MDFNdSYjns6El6UkdAMTTK5+OQcmspJMeLpyKkZTRL6vhKxKSyLVDkzE1cqHj7QPA3q4DVbMeu+TOkAqQ2BWRKkPxRcwgt26pzzXhSNv448gsc0w2wjiL0rACZSouAHvI1J0RaQmrpDQ+N+1xUc8qwJfHrR4O29EDvdX7ZOIu0nfaB3+xpqL0Z0xwEuJigCiU1G97JhMqncI3ak4tSK854V9ehS826+M9DDM9pXJKnoT9jSOiFtiacO/DAXQkLvtlghBW3oAtOk+hIST0L37CCzaaCwDOw11O62Kvu2+GjzbrFb2gb+I98JFnWLSnOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Y1GGRBy87BygNyATtqotnXi6HmMb1HTb9myFR/fDj3w3RORFsFPddyr7YHx?=
 =?us-ascii?Q?j+apj8VAZMTiEvsug2BgBsh6hpr0uuH2o03dpRXqMZsltzRDA3jKZ917Bm11?=
 =?us-ascii?Q?xB5CbsURtng78VJlHA+HywbI0p3cGq+wvwQPHXTemNDKLd4BasRZiTw1VLmI?=
 =?us-ascii?Q?51m1sI0juxT/0a0s714IOFW5j34gpMyjs2wnLiKZOzsUhTjD6FRT+QRhVPc/?=
 =?us-ascii?Q?milRQEPFIF7TqXnVW30LHTJ7NUofu89FZNNpUja2AGPBWkNxsbSUWhP0PNLa?=
 =?us-ascii?Q?j7Pn4kDk7rkCx2LgxqHhb03Ihx+kX9MQNtqxXXNbV40DxHwbDaDvvLESpggQ?=
 =?us-ascii?Q?iOkrO6G35IP38OyHp9U9qhDxNh+d8w2hc7dK5F6KL2OuOJRE+kQCJgjzum4l?=
 =?us-ascii?Q?dLzwROvLHI1DmNZ03oARalnzfqFVzqkOqiKchbO3W3U6zKh0afDJAyi2269/?=
 =?us-ascii?Q?C2sNawwJz5VkkBJbHVgC61HshF2wH853WUmhD6hruHwgqLK+ktJpjIAPveo0?=
 =?us-ascii?Q?htvMjFxRFhi8WcYB6u+63w7eN4RU/IM9DTJKde/wlBQ3q5cejGXQGbvPbs81?=
 =?us-ascii?Q?32tAyTHHLPMZBfO2zLOtywzCG6NPa7GDkVHfkhFh2q6GvI8LD6mYxrDeuGmO?=
 =?us-ascii?Q?EtrgQCshkmCNzd9zz/PL3Wak1G3SsMgmORrJUANhm7NzlTG23cRYLfS8Q9AR?=
 =?us-ascii?Q?nrPPHD/CaCOzIt6t/BU5NTIHgpTWt5AArGEAI41QCeaUYfiZMzjxtQtWb+Yp?=
 =?us-ascii?Q?hd34J4t0InxLVG0RVRVtC3tAP9suNCCN8aj93JnZwO0G9tGDkKz8gx1nPqUR?=
 =?us-ascii?Q?7SjfilEOzYy03SWPMiI5hdg3XvE3HOkUCoL5eYhpmdtNIsjWRSnpf7gAtnkQ?=
 =?us-ascii?Q?JeFyll7crIgZQJR4JPOcjw7MBvtV5ZbVT19UvljyrdeoXpicmRwvi8KZUzWV?=
 =?us-ascii?Q?+ugjs6vuiyUR0VKVtkR2Ln7DWAKwhS009Pl+Rm7XajHgW8gGytD0iMpctHLA?=
 =?us-ascii?Q?pknWJ0cnMl6EfbtvRbmM9Q/z2lpSk0c1WBdP1gfoU8Q/Uc+r+YanrvvZ6KIY?=
 =?us-ascii?Q?859E0G6FogMYkqB1/D5GQJsOoKuXTSuagmFZZhW5tSoVST8plLodmL/eetGH?=
 =?us-ascii?Q?ghJo7kI7XYnsz+R/jBIqplp6kIuQDHjBvlxGHPlDcytabE7awAilYhSe82tF?=
 =?us-ascii?Q?3YS0wZNTD1HddVnNTL5+CUcLHMFXmf1t2wtbnG4AUPU21sgkY6NeMILrQ7vg?=
 =?us-ascii?Q?gUSH5jQ6rvtCni0vqzHX3GgSA5GBeV6xw7S7DeFFNLFbpIE8aK1nVcqQRk4b?=
 =?us-ascii?Q?Okn9j9x6mdVM4JY4qkSKNZisMqqQu9Qz9HS4d9bh1hgEEAN/04vu/JPPrN2W?=
 =?us-ascii?Q?4dkaeX9+jOA5B2ZfNU2te4E/v+N0szaMkQ6FVba2gig/8tad16o0bUQ50/gH?=
 =?us-ascii?Q?sw6BbimnofK5ZN3qPXUDIKVMc/9SOaPMSp2Y+exh23qtN3APv2MqMYHwUWwj?=
 =?us-ascii?Q?H+Wj9jPzEWXGUkJhMRBBk1dL1PrXPCPxAqpDxoFLJTLEy31fs8YxVvGx7Y+s?=
 =?us-ascii?Q?E1yr+yM+JQ5N3ZNS5CM6twf463WWm7E1O1ycyK4CAZY+2DEiuZyOhZGIZtGo?=
 =?us-ascii?Q?mxV0eAIXHtA+QrNausYEuVfSWDmqRffbeivWv/VKyCCtRsP28cBKEZ1p4aEz?=
 =?us-ascii?Q?zabLd87qre9vZAFUMNubZHV7quEOdFE4XUsBLT17gSUksgPpIXCeZBUtHEe9?=
 =?us-ascii?Q?mmXcMUPmGA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a328ffa-5df4-4f74-0d76-08de7acc659d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 15:32:23.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 985rTZxK+VE9lNkNWyln4YtlJmubEB6wUc4Ysy3jfZPQYWEfLzv2N41n3i+pZIYqLTBb7NwdoAePp5QQUfbRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10156

On Thu, Mar 05, 2026 at 05:52:59PM +0800, Sherry Sun wrote:
> The function imx_pcie_deassert_core_reset() always returns 0 and the
> return value is not used meaningfully by its callers.
>
> Change the return type from int to void to simplify the code and
> remove unnecessary error handling paths. No functional change intended.
>
> Fixes: 835a345b18b0 ("PCI: imx6: Reformat suspend callback to keep symmetric with resume")

This don't impact user and it belongs code improvement. So needn't fix tag
here.

After remove fix tags

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 81a7093494c8..ba6e7c7ee625 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -906,7 +906,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  	gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
>  }
>
> -static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
> +static void imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>
> @@ -920,8 +920,6 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
>  		msleep(100);
>  	}
> -
> -	return 0;
>  }
>
>  static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
> @@ -1292,11 +1290,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	/* Make sure that PCIe LTSSM is cleared */
>  	imx_pcie_ltssm_disable(dev);
>
> -	ret = imx_pcie_deassert_core_reset(imx_pcie);
> -	if (ret < 0) {
> -		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
> -		goto err_phy_off;
> -	}
> +	imx_pcie_deassert_core_reset(imx_pcie);
>
>  	if (imx_pcie->drvdata->wait_pll_lock) {
>  		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
> @@ -1613,9 +1607,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
>  		if (ret)
>  			return ret;
> -		ret = imx_pcie_deassert_core_reset(imx_pcie);
> -		if (ret)
> -			return ret;
> +		imx_pcie_deassert_core_reset(imx_pcie);
>
>  		/*
>  		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
> --
> 2.37.1
>
