Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6F3B635A;
	Fri, 10 Jul 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718650; cv=fail; b=pZ/sZb03NsbBFWqwN+BlRu5rJC6Di+2saeF40i7SFkqXxF07YYuq6twT/bQqDtrPdo6ceGH6VR/6e1ftyIGkwwF+z2iWlWOPn9o0KJfKQfPzrfqE8zIYZh7dri9u49WSHoDsC79+fSljPDm2gzkBXD5YKUOqA5adPQb9VCyD604=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718650; c=relaxed/simple;
	bh=ASaccPxLFGoT4gjLDpFy4nrX090dqDX/gkykB/F0sA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bOd9aaycHzCB34e8e1XXy1p7r+2WD/br2gb8qipxZ++lFi80wx2pBOC9iegD9+tV1Sdi9RLSvII4zu/nZFZRGSawE9jDBGr/+ETe45DaYcEVXndYlmwEEqPkkSebz9VwHXL2S/sOHeux2EdUhAN8bgptMwe3aRlVJdk5lCgcAeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PxSc0uUX; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PxSc0uUX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpVTRIaIUuFyQ1NwDTUigHi6ay2jfYAwOP7yAE2uBtOrxEmfdhbt4x8s9eyCq8XUD2vgEFborQDxb9+eYRLIWAtxRbbf6hd6fG8AVTZEOMPA0n/7px1w26B8kqfYxEMcVoCmb+chp/yVqpXRpQTSH9prLt0c0HGvRBcrL2R/JM7PM7IXhDXkpbqLzzpdFUbI9nB2xrcVCE0j5QfXQY0kpP9nU1f6bcwl/zsI41J/UmdEyV3Wy8ws2zAbNFukpKPKF5b1uVxpjb6SzinQ3ly09MIFScXiVpCk0n+JgoPun2RIpk4MnHCwvXof9N5c2Ww8juULzeL1Wtwz/hWdzl12aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/l8vy5zZkoDag1MWepxwlUdBv52+qXKsGL67itiZIE=;
 b=baPoa88XtwYM3YPxXk4TATyhdkyZhyKXy0IIWiyR2qs17OEVnaqJHFVNO0EG2dM2+ztqcfCeeCfpPbpnEozC0MNfmwfgT+SglpTKwJrf35To3u2akTBoXssrYH9udbxAE5OjD+WDdHfn6uzhghR6DIMtmONHvghFO7DYV6rv8ZSBe7WvrDmsCHJ+0wxnVoCK/2Q2UDm1f4TLUQAnrTBYajYIWM4Hii//OvkD6z8TEGpRPgJFDJg0EzzSM9oxQgkn1c/Z53itSvfms474TadNh2Xbm23aj/fjMmWiWpFFHBZrC0x9G3P0lvEwllVpfRK5JScaT9/yBmkTk9Hnf+XSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/l8vy5zZkoDag1MWepxwlUdBv52+qXKsGL67itiZIE=;
 b=PxSc0uUXmZ3qYeYNgJhMQ/M3rCR0Dh+0MKvH+yJ5kODA0FDpdvu+r0u/qniXzoRvyMplz6KcnJQptRbAd9G2WZ1btRsZV9K/t1rNS3P8I/Hj3p05ZSnUOH81yMwzL7FYQPR5jjCa/fO0CW702P+BCVY9THAWFbwYSptM8Z1OJ8N/ex0FkrXWgtQ2oYO1E/byinYHNx2jtwuALtwObBnzsSx+aW3FSCPxM3pqn6e/xgny/MMzQstuFldRDSNNo+Gy3xsAJmdVaalrLz7qj+SaSF19mBeIyzt+Ium99+4CTkxRycpoh6xn9B8nd6YSZFZFZ+tKf4D2EEgHiz1fx7Bv5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 21:24:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 21:24:05 +0000
Date: Fri, 10 Jul 2026 16:23:55 -0500
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
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Message-ID: <alFi63W80HiYfDfC@SMW015318>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
 <ak-2BQEUMg8Ewjz9@SMW015318>
 <VI0PR04MB12114FB4F1C79ADFA5F3F215092FD2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI0PR04MB12114FB4F1C79ADFA5F3F215092FD2@VI0PR04MB12114.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c425c46-0a74-4960-65fc-08dedec991da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9n5wKRjOeQTr3Jn/mJMmarfc806vFgxs2I9u0Ywh/demo94IIRdaYkMs/SL72vLBjJwXxfD0O7YEHqWdNge5jBwHy3IhVgXREZlIN0yTvoax8B2bLl9+A5/4W2kgIJQ+pr9Yb+tDW5p7W+kbxiKCqigZ+kYdATYnCTenq4z4A/gaCZGDSotK1QxhQt86mP3RvPBhExbXyKNyvICdTFjOnftqzSLBGKcc09/wRtEHvPbmGuagvchE0WNbmnc4g9VlWNdEVNPafTvRpLyw4TTspKhuoqHx5xjYeku9I4flUP7nPS5+oLEZzS1uM7UpyGd0p9J2rfaiKFmb9gFlAeBdrGIcJL7xSYRrdbPxANq1pMcBVR5ziybFBdkas7iy619jmbsbVUu/Rq4tiadKRgeL6kVxeJKoIRNvkgT38oTLD/cwB4oH94dhF+e1G2ElIjR7ajmeagaY0y/wa2mJllKj+vJFAD6tH0bzmtLr/xRjgFbc2QuUvBUxKb+nj8M0xkioiW5TVJs9ayAwz64W/Om/yubLCq/avVH1X5tUZsoivCeL4pBxl9fSZBJr0A4RVkMe2tOve7DfOqRqkvJcSvxB+i44JmOir2ozLI2KmVp1fDTLqM38GjXREFq0IspXe2/Kwz/qf/r4y9d5KKlMLRM5ggzBoIFSMZxMiKcyMwJEXpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fQB9KoXla8nd/oTq50dgvUzKpFGLQp8F3KmNvueoJ1RtymstOTgkEeDN+Ngu?=
 =?us-ascii?Q?IW7jZN15aULNhzgL1AFqeDQ+N+DaeNHHlNouxGERxxCu1WLHQmidy3TtMI6q?=
 =?us-ascii?Q?vy2vvwooT2OileB7BHCLCoDFlafm3zw06MTebUuiLMB5pDVwgO8+rK/93/35?=
 =?us-ascii?Q?mOpOH0uKo9OwwEThEbWqxIldfTl5ksLaMHfPIcVG3hI23xgShAp/59vmmJwc?=
 =?us-ascii?Q?Z2+1RXw6a7Fw45+vVu0dsx+CpOKXpzRaShSzIAV9HzVj0vVB2vJns1/o1LmZ?=
 =?us-ascii?Q?H953j/hGS9SqZ2O6typAXAkcG06hTj1fmRcHxENZekM+8W0TaWZHFOtLatJM?=
 =?us-ascii?Q?ecuAVc4btGtExfKAeBhpGdAZMtnuYYQQniD9tAm2KrWl47EAnWt/OOB0p9nm?=
 =?us-ascii?Q?6jFQOj+9nM8J8vc5RIMMtyFGJ/CLZNFkvVIDsSX2MFWIFxeFYiB3MH/Od0XK?=
 =?us-ascii?Q?FdY/lbHlfEfXYQT9MByhjyN09qe6HwnelRrjuG5Ac2O4VmZ0QrYYprgCzlJb?=
 =?us-ascii?Q?Ia9mNzoPHNK+eN0Le8W1BljORJLTelYcLuInEceXuRpF7URxpDP4bv6GW/jL?=
 =?us-ascii?Q?OV25JEVON7X1E+fSR3DIvXwRV+E6wTcaEYBk9UBe07ON3+KpnphYSrljjm1I?=
 =?us-ascii?Q?XhyJEg7iyiwaVRap6Fnu1Z/hCS9mC/Xc3UHME9C5dGLkBu6ppDxdwd9Asmeb?=
 =?us-ascii?Q?heCffx6dnfGwQTfa6zx6wospdvHK125HmMnlA4Pa/EkEkA0z85uXOj95KWZl?=
 =?us-ascii?Q?qi3P7clfse3FxBhClO1WiBJIC2JTe/sSf66oeFpjZNWwkoJLdA8BRnoTF5LX?=
 =?us-ascii?Q?9Tsq+E95PpjZbg2f5ddQH2qIDaWYUnshnb745WBXrGGC0UEnBo3Iw4PyFvGL?=
 =?us-ascii?Q?cjvI8CxYh+V7PNopy/TTrqHiE5kGFswqbD+6CgvjjpVcTKEJXe0E+NzwLnRn?=
 =?us-ascii?Q?DTTMqkHnZi8Qt7M6OSwYEZGCmfFvn+Om3/mnLHYC47ezfqsMbqjDU5IEpmEx?=
 =?us-ascii?Q?dhI+MZ5lK72kZFeh26WJuQj/NVRQT59p9oNc7b5uAskm0Qs2OVz7LAgzWkWx?=
 =?us-ascii?Q?c53YyNE6M+icMmUbr6de3gK+FoylrUXFn7NSDTh+pf7nt40x/e5UsbbUwnQY?=
 =?us-ascii?Q?I5JDADHpMLfEtWNXPt3XV8/w8fCz4ziTR8y0fvB+d4sNemC8IV4uUXq7eQRH?=
 =?us-ascii?Q?0ueMPNz9l92ksZflfTuZq3LdtGXyQvDmAPNcFX5IxiHlgFK2Q0NxVZE9XCRF?=
 =?us-ascii?Q?DlZJuydpTEso1CGvDWt+08ZdIyi6mm589qICcPvFN3Ghy3eX2Cd3kKv3xOKc?=
 =?us-ascii?Q?2OZiML2hwGVmnaPQ0ROao0DI5k6gDiwmQS5oqZFVTKD9zqnYS/hbfYYcehPe?=
 =?us-ascii?Q?TVNcnZ/SgZuYczoHW3HZe+qyK8AdfBmBaPnOpBuJlQr03vb+H3yEKbr32azS?=
 =?us-ascii?Q?CwWwk7p4x0sNwVItEm39vyCG4qs0sZHM7l6vTQEv/wwPWe5tQwTVKQHr4pS6?=
 =?us-ascii?Q?FW3zaWAOIAhO0LI+HD3+FarnNh1tsNy3pQlsmFKtQMLmubulRCqtgD7OD+jJ?=
 =?us-ascii?Q?DMT8nL/lk82sqQysGPhPBnsKnWP7LJLI4yIJ1PNAr08daJ3vZAAxdpo48H/M?=
 =?us-ascii?Q?YkH1WrWA/bVQ3YgFNTEbGOC5AdAHy2B3u6cnc8fE7ag2kYiU+dbrCV+fygfl?=
 =?us-ascii?Q?cOAU8waQluVaXH3UCzsTxvGznQ7N7LETuesos3oSLUoInqDuk4owKmyXc/Gp?=
 =?us-ascii?Q?P0x4liE67r/hLzlGc9lBuhaEhk34HxoJXEOng+9Tz6Gr55oORwYx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c425c46-0a74-4960-65fc-08dedec991da
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 21:24:05.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJP40vf728jW82pX92ppteU48cG0Ccb3fDCHcL3X3FV5kzwaIMj33b6BgD3qqF5giMJGBgFkcpyTKx6XPQGrWhdbyOAxkdPhuEd+M/zAq7YMGz8hRIqbICJZO2oQJf5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

On Fri, Jul 10, 2026 at 02:16:35AM +0000, Sherry Sun wrote:
> > Subject: Re: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
> >
> > On Thu, Jul 09, 2026 at 06:15:53PM +0800, Sherry Sun (OSS) wrote:
> > > From: Sherry Sun <sherry.sun@nxp.com>
> > >
> > > Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> > > suspend to preserve wakeup capability of the devices and also not to
> > > power on the devices in the init path.
> > >
> > > This allows controller power-off to be skipped when some devices (e.g.
> > > M.2 Key E cards without auxiliary power) need to support PCIe L2 link
> > > state and wake-up mechanisms.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 92f8e4a299e8..afcf3b6bf3cd 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -1382,10 +1382,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp
> > *pp)
> > >  		}
> > >  	}
> > >
> > > -	ret = pci_pwrctrl_power_on_devices(dev);
> > > -	if (ret) {
> > > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > > -		goto err_reg_disable;
> > > +	if (!pp->skip_pwrctrl_off) {
> >
> > if pci_pwrctrl_power_on_devices is true, where call
> > pci_pwrctrl_power_on_devices()
>
> Hi Frank,
> The skip_pwrctrl_off flag defaults to false during the pcie bus probing phase,
> so the pci_pwrctrl_power_on_devices() is called at least once to ensure all
> regulators are enabled.
> The value of skip_pwrctrl_off is only changed in dw_pcie_suspend_noirq(),
> and is refreshed by calling the pci_host_common_d3cold_possible() each
> time a suspend occurs.
> This is why we use this flag at runtime to avoid powering off devices during
> suspend to preserve wakeup capability of the devices.

Okay, It would be better this part code can move into common dwc later.
this is not specific for imx.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank

>
> >
> > > +		ret = pci_pwrctrl_power_on_devices(dev);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to power on pwrctrl devices\n");
> > > +			goto err_reg_disable;
> > > +		}
> > >  	}
> > >
> > >  	ret = imx_pcie_clk_enable(imx_pcie); @@ -1454,7 +1456,8 @@ static
> > > int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > >  err_clk_disable:
> > >  	imx_pcie_clk_disable(imx_pcie);
> > >  err_pwrctrl_power_off:
> > > -	pci_pwrctrl_power_off_devices(dev);
> > > +	if (!pp->skip_pwrctrl_off)
> > > +		pci_pwrctrl_power_off_devices(dev);
> > >  err_reg_disable:
> > >  	if (imx_pcie->vpcie)
> > >  		regulator_disable(imx_pcie->vpcie);
> > > @@ -1473,7 +1476,8 @@ static void imx_pcie_host_exit(struct dw_pcie_rp
> > *pp)
> > >  	}
> > >  	imx_pcie_clk_disable(imx_pcie);
> > >
> > > -	pci_pwrctrl_power_off_devices(pci->dev);
> > > +	if (!pci->pp.skip_pwrctrl_off)
> > > +		pci_pwrctrl_power_off_devices(pci->dev);
> >
> > Not sure if there are counter in side power_(on|off) function, if not, just skip
> > power_off is enough.
>
> It depends on the pwrctrl drivers implementation, for the generic pwrctrl, it will
> call regulator_bulk_enable/disable() to handle this, so has enable/use counter.
>
> As mentioned above, the value of skip_pwrctrl_off is refreshed in
> dw_pcie_suspend_noirq() for each suspend/resume, so we need this runtime
> check to avoid powering off some specific devices during suspend.
>
> Best Regards
> Sherry
