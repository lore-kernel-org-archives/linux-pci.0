Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110E319601;
	Wed, 24 Jun 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320848; cv=fail; b=jYZjRZM5PXBV9T2Nezg4pDCrTA9s7FNO34/+LzzYPx7xJxy/u6KEEHMVR9sQa0jp8Ye6omAvidGRNpvMnR++QUMZAzpXwgCXdOBYBK8w/pqL0TWuC3VcIPYRpXgqJLBKYoFC0L9vgam+/+d+LeFpkqKYPyRePFk496cvMqNekQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320848; c=relaxed/simple;
	bh=BvELTznE047LVz2B0WVZw2pxGNUFVaBlJbCysuYl778=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kky+sBDmHJkd9bPiV6e+ka62RV7UaaDVNXgQ9a8R4IHkCcu9iV5edEu4sH003cZKkjvJP1bJmsg7nnqFiJRQWMI4t4q/2XKRjw8OqSL61TzdtxmB7lqgYeVDrjceR1RNBYdpwJck0ZalumKxRv0vjk+FdWa+8DZgmUf0H2ns1YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K7fLoNjC; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K7fLoNjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG+uy6K0xfg4Zd90n+f3GUr63WdEU7mJIsshfYRp1JsoeOf0iLekSP8hVtedh/vZZQxnXqoRhgkKWEtr0AXpw114pNpyRvaKpaUgMdKCPiO2fGquTDX9Fq/+TBj0lsn6zxuFtZJkO24M1cYYWSMyWOcaVhNcCq9EhzJz/Mkv2Liw0/WglKIocSMKYCxlGbQVcimMVfwTEOZH8MexF8sy5OqXpvamh6ANYmDenCKPEWnoqLaudA6mwdLn4ir21+rdZNwHdA82SfaqxPncZJNu5ypwWpVX5kXFYshjBEctPJ7nPNH4F/3bpXfdSdlMY1zMT6JZiTGV9u5ZpCrblhtlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCeU78O4Ei/++LRoHI2gISdHuBoZoN+yVg6CfLZM6TE=;
 b=fwRki1YCPosl2yPDqVfzlirqx0RLij/Q8WIxmR52lBKVxR0GJoSbVGKGrqYf8NSl4huvSDeyhVvKK37saga5wZzOWJqOo6+5ZnZPN7WmEclpyWZRe6Pts4/IXqFK14AH2ghcAsV/D58rFUEr8FU10apzqh5Rj+zJjA3PdJHvDc+NbhlYUxe4B5wIwuAchUW+E9qKq8NXtaiWTPM9mvQewrNIbhy7Ye8HTJH7ey/I/CCAJ0aSkSPXyseJBtCX94dynyjnWkGGwiTpcu5HkICYgnCAAHcjxYG7SeK1wafIvvvYpr8R+rBEzjA0J7LAmAKY7dJSlb9uVZKyd+A7w0OQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCeU78O4Ei/++LRoHI2gISdHuBoZoN+yVg6CfLZM6TE=;
 b=K7fLoNjCCS7I95sKqiq/jj7kpix2Y+cjknCjZV//dHb7Gmtp1x6/guIOGRc5lnIsrMWxmSrM+vRYV/KFiLCghG5KZ8G9TDBO2hCdN8PvLe08qJR79kE5qgrxRReizjE3VU4uOl98CSMQJ/+L2A1bv2Mj2k9LLHjXiR4MXZQt4QBaupePR1RVZwz6izXTDap+gTKpTfdJ9HdqUm6GrJpnhZCbwMsgY16kbXEfMMbmOi8AJXwohXz0CZHHx6PIUTA1Ja83zOJ+voxi4RpZ7i4dfe4XZApqpc83VY9JKUWTjjanCk3XQQmHevDLG5fIMgpg4LIkVx2eqs7JDQ0uy7z8Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10593.eurprd04.prod.outlook.com (2603:10a6:800:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 17:07:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 17:07:22 +0000
Date: Wed, 24 Jun 2026 12:07:09 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"brgl@kernel.org" <brgl@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <ajwOvZUlOEQzmjsu@SMW015318>
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com>
 <20260623030736.1421537-2-sherry.sun@oss.nxp.com>
 <ajqZBM6IkbDLiVu2@SMW015318>
 <VI0PR04MB121147C305022511469FB603A92ED2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB121147C305022511469FB603A92ED2@VI0PR04MB12114.eurprd04.prod.outlook.com>
X-ClientProxiedBy: PH0PR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:510:f::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5251e32f-c3f6-407c-cb9b-08ded2130e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|19092799006|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KP16XMoHxEeP2nybigti+V4+lyQT2LoE8AosYXRonInaMRdxSQhmUKQdyC1wo9EJXBF+bcQ0+Gcqf5N9fHsbfmpRGtdOomjtLwanJmXgLo+0HxYcf/BfiKytO1Nq0oXgkBjyddbfl2rOEiKqG6QCCC5rMERfV+GHj/RCiNIq6ITsXpj3j6ZmcCDlt6YWi9SC5QRDNaKyYmAztqqVLZ1s/MsdQJxcylUpCM5i9JwQZLJSGTEHJx6hlIiGnVD5EIV5mUOH9v1SL7dntFYqnFKDcw0aQnCqiOFTA7iPdhMdQYPFUwkXVtnN24BAcVNm87by2Y5YRxw53NT5sKzcuT3DPXhYJZJ+3UPkMUJko1VBRZOp810zkof9PWwikY/Z9G/ga3DEXqD5gNdCuOZ+IAe2cIJwI0qGJQp67Zw13e+WdlloCrR/SyQbIX/a0CtxSS/iBmGa2Jem2Lq579fl4gb0uXb+rbABUSoIsuSHW1pgmSgIg1EucPgI/ypEsPFEFY7mfNQ0dHTSMtiuj8EDC4TMmNAkCNyEtJqpAb0v0v56hKHASEYEQnfBMv7++hJ9qtqvPMHa2h2U06Zr7Nhtmfe6zjv9THiavBkZZNIycpem3O4Y7pOnVT0rNrZtB6onGL5ele5trSNodGSZ9ItsMIqrfPQs6pEVPw9JkFatZS6ykpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(19092799006)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nFGbfuyYICRHMWs/Y8B9mf24RE914qLFiu/fYN3jPuRcx4zYqD2lDEKQ0/3K?=
 =?us-ascii?Q?ORjDIxAS2DIMZsj8QeHSC8KYa2xfssSnWYLQC5/ammx/TVFBY3sUKbnFM5D7?=
 =?us-ascii?Q?j4/JQgfxia9PViitygvKq64mt4L4EpTrArvaF5bvWkpvVDapLVxQe2Kz1icV?=
 =?us-ascii?Q?QBYT9JQprnhDmLjTKaiD38v7gdZl5eE0PPJqjG2vijfqYerqdGmdC2D2TsMk?=
 =?us-ascii?Q?C/PPVsZLfJlwOMmKMaL91LcnZLD8RC2OpzZtM/UO2iJCDPJzo0eNKo6YSs8X?=
 =?us-ascii?Q?l/A/8Xmwmt99PY643MJHal++sRXhIr8s/aBZ1WIwxjb4aGOumn5qp9xmgQk0?=
 =?us-ascii?Q?04+D+/UH9K5doiKP7KrEShWEVOIHdwqxYIVYnQiia3GR4WcDwF4p6HkQJFLv?=
 =?us-ascii?Q?Btx00lCVqGK1lnZkAtammh2OJQPrC0DF9k/a16JkBnoKuSGQORZ+Ey6g9weS?=
 =?us-ascii?Q?FQZDL7WmsK2rnecLzvRT+Aexy80treeppmSMsf5BfTSeS+5qM+NWQaeOtEje?=
 =?us-ascii?Q?sTZOvKXrmboZvoW7D+JspIjXEbG+FoNUUYrHndFY5tY10AMEij3AYrYUZ6+u?=
 =?us-ascii?Q?Id8vHZKVAm+sOV8Tjr166HRRoDhQoMUlyVA3hzAh49XqAFqwrPK2PZz5TI+b?=
 =?us-ascii?Q?DsrPVsexGA8li5IvxT5PZqbGdL8TY4AziAXFCFVkZ0fjNjJRIwPJUs/xx1IF?=
 =?us-ascii?Q?mWBfBNnOq0srqnWtum7M+3kYbaOcFLF1peUSLHRx3YasXAxica9KqG5nPF2C?=
 =?us-ascii?Q?SDO2LVKj7rG+BWO4l3R5CLNLU+LOJzKrbaL1fuEki0DjsYaci5Z5wGlG/qT+?=
 =?us-ascii?Q?PSypqiJDg8crkrcs+aLSJ3paRXRJDw/Rb/r77DvJhFM5EsqzRO/gx0J/xBSH?=
 =?us-ascii?Q?4r/ga8/NeER6nxx9RYkMUIB4nUP4W+T8gJznlLC7p2l0jJ3JPn+LolMPmfuQ?=
 =?us-ascii?Q?bYnLSOMfhmZb+pPlslL+ZsqrxuqIFL9gnaaTlpcUr82t9OyCFGBZf49ftMfI?=
 =?us-ascii?Q?lrjBbp/aoGA1gByKJ+C/fdtI4yB2UPCQknKAO1EzqKoGB+599xDRIjdCKPa3?=
 =?us-ascii?Q?tO4G0/Nj+LE2KqyXXS1fAOrO/pDn+c/045fjLoEfFD/40IwumaKOO/skJXYQ?=
 =?us-ascii?Q?bnrAIa4cefF70On04w7iB3gdAAdQKfeBy/c9GGE+MoK9Ix0I+2JdQJMPpyJv?=
 =?us-ascii?Q?+2QR8cNdrxPz4unpLIhyes/nMQjThUUoLwak4J+1W7G0/Oed96/lZbEDvRtc?=
 =?us-ascii?Q?f23uRn3Fqm1dp9hffyNMZu5CYFNDm/k5atF8CxVXV9H5hGqsIV5FIt3X+m3F?=
 =?us-ascii?Q?hqUiOzMYwaUnP3PQl+bxy2Yu5WmD43uf4wKoHhIoj480yxD5qacqZlYKlq7F?=
 =?us-ascii?Q?aaPA71OYUs6QSOcp7tYJs5pnwDDN1Y77QTHxsmJaojl1B2jdjzQACS0zoXTj?=
 =?us-ascii?Q?v8UIONB5LM3W0luO8eXpklePWYeRrw4iPF3373jiucYx0uITT+P4rPiLHMvW?=
 =?us-ascii?Q?5SYBda0AUOWnv1P9C95zg85LmIuTCIYMDFkOCST4Hg1mMv9OYBRXEmL9Ygi+?=
 =?us-ascii?Q?M/7lYhpSRqWCVKOPfdN59jcVEONHu6LgblfZnDBYomrc0OGaVqAdmZRyGk7s?=
 =?us-ascii?Q?R9W3oo9LZ5C9Oc1JYHl7Gr+gaeLjj1a8dGSk113QsR10kfVzS5bYn+2Pcrx1?=
 =?us-ascii?Q?NS86J0SZ8cDtzxra6EQrKOO29nG/5oKH4zSRIclDoETHdVUAF1Uonnr+FQ1M?=
 =?us-ascii?Q?9g8HSrOlTwmDQJ+7ln1mILCTvKk6KUZADOVxYHHbOXvXeetlrQdX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5251e32f-c3f6-407c-cb9b-08ded2130e22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:07:22.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pax29aTdBiwNxw6xN15uimGaccLRPk0Kv4lzLm3J29nwlMnfszi3Ejmzd13cCeiPJzFrJaQPSLaf4Zeluemh0ro74hAu+0gxebRteUQeiqxjAM4w85NTFQHxFsGTeTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10593

On Wed, Jun 24, 2026 at 07:09:26AM +0000, Sherry Sun wrote:
> > Subject: Re: [PATCH V2 1/8] PCI: imx6: Add skip_pwrctrl_off flag support
> >
> > On Tue, Jun 23, 2026 at 11:07:28AM +0800, Sherry Sun (OSS) wrote:
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > >
> > > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > > suspend to preserve wakeup capability of the devices and also not to
> > > power on the devices in the init path.
> > > This allows controller power-off to be skipped when some devices(e.g.
> > > M.2 cards key E without auxiliary power) required to support PCIe L2
> > > link state and wake-up mechanisms.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 36
> > > +++++++++++++++++----------
> > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 0fa716d1ed75..ff5a9565dbbf 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1382,16 +1382,20 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> > *pp)
> > >  		}
> > >  	}
> > >
> > > -	ret = pci_pwrctrl_create_devices(dev);
> > > -	if (ret) {
> > > -		dev_err(dev, "failed to create pwrctrl devices\n");
> > > -		goto err_reg_disable;
> > > +	if (!pci->suspended) {
> > > +		ret = pci_pwrctrl_create_devices(dev);
> >
> > Is possible move pci_pwrctrl_create_devices() of pci_pwrctrl_create_devices
> >
> > and call it direct at probe() function, like other regulator_get function.
> >
>
> Hi Frank,
> That makes sense. However, if we move pci_pwrctrl_create_devices () to
> probe(), we may need to add the following goto err_pwrctrl_destroy path
> in imx_pcie_probe() to properly handle errors from
> pci_pwrctrl_power_on_devices(), is that acceptable?

Can you add a API devm_pci_pwrctrl_create_devices() ?

Frank

>
> @@ -1960,11 +1949,15 @@ static int imx_pcie_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       ret = pci_pwrctrl_create_devices(dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +
>         pci->use_parent_dt_ranges = true;
>         if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>                 ret = imx_add_pcie_ep(imx_pcie, pdev);
>                 if (ret < 0)
> -                       return ret;
> +                       goto err_pwrctrl_destroy;
>
>                 /*
>                  * FIXME: Only single Device (EPF) is supported due to the
> @@ -1979,7 +1972,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>                 pci->pp.use_atu_msg = true;
>                 ret = dw_pcie_host_init(&pci->pp);
>                 if (ret < 0)
> -                       return ret;
> +                       goto err_pwrctrl_destroy;
>
>                 if (pci_msi_enabled()) {
>                         u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> @@ -1991,6 +1984,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
>         }
>
>         return 0;
> +
> +err_pwrctrl_destroy:
> +       if (ret != -EPROBE_DEFER)
> +               pci_pwrctrl_destroy_devices(dev);
> +       return ret;
>  }
>
> Best Regards
> Sherry
>
> >
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to create pwrctrl devices\n");
> > > +			goto err_reg_disable;
> > > +		}
> > >  	}
> > >
> > > -	ret = pci_pwrctrl_power_on_devices(dev);
> > > -	if (ret) {
> > > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > > -		goto err_pwrctrl_destroy;
> > > +	if (!pp->skip_pwrctrl_off) {
> > > +		ret = pci_pwrctrl_power_on_devices(dev);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to power on pwrctrl devices\n");
> > > +			goto err_pwrctrl_destroy;
> > > +		}
> > >  	}
> > >
> > >  	ret = imx_pcie_clk_enable(imx_pcie); @@ -1460,9 +1464,10 @@
> > static
> > > int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > >  err_clk_disable:
> > >  	imx_pcie_clk_disable(imx_pcie);
> > >  err_pwrctrl_power_off:
> > > -	pci_pwrctrl_power_off_devices(dev);
> > > +	if (!pp->skip_pwrctrl_off)
> > > +		pci_pwrctrl_power_off_devices(dev);
> > >  err_pwrctrl_destroy:
> > > -	if (ret != -EPROBE_DEFER)
> > > +	if (ret != -EPROBE_DEFER && !pci->suspended)
> > >  		pci_pwrctrl_destroy_devices(dev);
> > >  err_reg_disable:
> > >  	if (imx_pcie->vpcie)
> > > @@ -1482,7 +1487,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp
> > *pp)
> > >  	}
> > >  	imx_pcie_clk_disable(imx_pcie);
> > >
> > > -	pci_pwrctrl_power_off_devices(pci->dev);
> > > +	if (!pci->pp.skip_pwrctrl_off)
> > > +		pci_pwrctrl_power_off_devices(pci->dev);
> > >  	if (imx_pcie->vpcie)
> > >  		regulator_disable(imx_pcie->vpcie);
> > >  }
> > > @@ -1990,12 +1996,16 @@ static int imx_pcie_probe(struct
> > > platform_device *pdev)  static void imx_pcie_shutdown(struct
> > > platform_device *pdev)  {
> > >  	struct imx_pcie *imx_pcie = platform_get_drvdata(pdev);
> > > +	struct dw_pcie *pci = imx_pcie->pci;
> > > +	struct dw_pcie_rp *pp = &pci->pp;
> > >
> > >  	/* bring down link, so bootloader gets clean state in case of reboot */
> > >  	imx_pcie_assert_core_reset(imx_pcie);
> > >  	imx_pcie_assert_perst(imx_pcie, true);
> > > -	pci_pwrctrl_power_off_devices(&pdev->dev);
> > > -	pci_pwrctrl_destroy_devices(&pdev->dev);
> > > +	if (!pp->skip_pwrctrl_off)
> > > +		pci_pwrctrl_power_off_devices(&pdev->dev);
> > > +	if (!pci->suspended)
> > > +		pci_pwrctrl_destroy_devices(&pdev->dev);
> > >  }
> > >
> > >  static const struct imx_pcie_drvdata drvdata[] = {
> > > --
> > > 2.50.1
> > >
> > >
