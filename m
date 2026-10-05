Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021121.outbound.protection.outlook.com [40.107.74.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C722E7375;
	Mon,  5 Oct 2026 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180867; cv=fail; b=S9U+awK5RMnX2uiURC0vL2ggt4RLGQzDM2UW+B10i9STdaWt0BY69CCZIBbNHaXHdpC2U+oz5bphozTKucPkKe81pVRUzo4igqb32j+FnPUU5crm0YSQWbfWkFy2/jEiWRIHgHazOEGQYs6pGG42tzzs6VxAykdZ0E8t87+mOho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180867; c=relaxed/simple;
	bh=xmQPMUnXbDK52Ty6EN8IbVrmNMqEdKoKJvg1nvxZx6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ym9HaQVkXHV+/UQ9LhWX9Emy769R/bljTd+sU3LcpdsDw0524Y/nZ0VJzE2Yc2GQyiiXiTijWFvjco8E6lSTUSNvjE/hW1g0ds8qhf94v+SJovi7XDywGw+IfXrsJkcAf2t1DMsy3HdouA1w5qBt8Mn3eM0JIC8J/ffRn2O9zao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Sq3Tsw0A; arc=fail smtp.client-ip=40.107.74.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Sq3Tsw0A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrpV5uv+O6miS2bUy4SWcYeFdT5gUCYT3W4y+dBZlMzYwQMScdGM9RpXWgf1zueRJ1eCcH6tnyV4dsoNLrnSapZM7ZSDeYiYzem9uy1mBFJcpIlvSZ3bwN7xmq+4eGOz711GlSDRNlYXSzMH/jpnhCCWojUbVhj32ynCnBAnKuQV4f8Q687admZV8MDKg25rY22O5dkEuFaseyi5y3HgoE2z4lxFMakYzKLjhaHcAtThYsvfFdeQjxNgyJbVseNiDYLHw0yL49SMyXWGubO2IWJ8Cqx1a3l2mgESHJZDIt6L4PLOgIUWbLx9gnF0FBU3FTBqt3+8VQk/klo9wIHCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjpnYK8gjMyFxEdmcDklC5AJbt/oZx/CENNEtRLhDKc=;
 b=K4RqjcUTamAHwrZfJv/4w23Jtsxiz9+9Sfjmrap/7+JECMYy7ExbbO5tRbaIWoEnRzofC99J96afOnLxekHnXxfbQ5TCgBeB1S6PTpEhtD8mIgEhC8bhQGZ0mtOcdE9feO3JHnLBEESUjzCPgd15mW/DECBr8SmvvxFNfj6Mb0VwEXqTfJR8q5ez/Hmo7DwYIkzPKUAcTJSJ9ks+vhOY/L/IyKf/DLha51/x6p9GCf/a/XqrRbuMP47+ca0LdzMEK9mzDRQ8K8aNJd1ksKesqcVugLI2oVbs5V28070MKWbhDWjU7qMAGjmG6VewydgKZYY+8oy1CSXu/88S79btVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjpnYK8gjMyFxEdmcDklC5AJbt/oZx/CENNEtRLhDKc=;
 b=Sq3Tsw0AIwpwe0vG3g4Cynn3tmPQUFbdh8xDguymAC0rNoDc4DN4jCkgLKpcq2B71H4s+ZmDzGUWy8kLmTp3Ip+hlXMko8ZCt+b0bpfnzTawUnj7Ud32FQZg73n9W4Pl9ZikDvuSOwliXcKMAiGZM3IDSzHrMuI8+GI85fyJA6U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB5377.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:384::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:14:19 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:14:19 +0000
Date: Mon, 5 Oct 2026 15:14:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] PCI: rcar-gen4: Add Root Port reset support
Message-ID: <eivzz4zumuu32zrycw6wpt3orzk2dvlzuvj34krmbhjf7a3a6u@ccvu2nkupzid>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-10-den@valinux.co.jp>
 <f9258887-2cc5-4c88-b465-5ac7fc1e82ea@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9258887-2cc5-4c88-b465-5ac7fc1e82ea@mailbox.org>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3cd8a9-456f-43c5-4b05-08df22a7e408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10070799003|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xE5xDbALZfhOmBa2xHGp7iP3jHWd65ojHmivRCyaVIIU2BPCWzvdcmDQn4itPRR/1d/1Yf7diSdlH9TcjXH2jB6n9JLGm9PGg1hEEY6Pwcfy4D7piMsRPmcEYyynrb+R6fNB812KMr+dfjELfFnUJ8ooJCg6KgHliWGEG/kE/t9ddhr/WpOg1L/QEsCUbFd9hXE7vmZRNGeeS+rqRnnHOvXCey/kLSrEk723RJSuIhC1nepw0feUuoI/HymwVktTPqhiWvWUVvNhIjldvSFBmj5EmsDmhdY1lTKkmc+ubpG7mQLVUbRC10Ht4nSFuXj+MpEUfQtSMODax5LrregdXkM7yzTu9uq1JBXLj7ok2BTwflyna+oflHd9Bo/p2NhQW6EwJe+PTBr/E6RHAgWDV1qaFOVd2gRDvsC8sW8liV3h9Aydt0MDt6lqNglyBDw6q0z15mlzyvKwoyJnHj1zw03O9xJVfqzMG+pRj4VC3Ho1z7jEkmtBne4wr4A8+hPtzd+bMOEJFkwsO8q6My/GMRBBeLYIMvE3My0eY755wDOpy1tafSVXxKBWE5pedEPzERdZFhOc9p1jstUgPPhao27JgfYsHQwRj3dQeU0JexhdcewXRbljisyz1y4CuwjD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdZnREYnahZEao0EByeh1IA9mwy28YJTaI2ODGqkZxmXfCAJyPRe5gKtz2u8?=
 =?us-ascii?Q?03oiJTCvMymkddDaF+WcoBCYc5nnEoXdLpIXhQMoEvblmMp9GfzxzpF+rBKC?=
 =?us-ascii?Q?0gzyQXDkFs4R6L5gj6LvuTnFbmiajZgGJAbYecvkFRQvByRGi9G5vaceru7a?=
 =?us-ascii?Q?83rkFAJZ0tCqi2mCDV5ARooz0nKQP9a1lVYden4EH7WG7IDyNtYw1IRMaPjN?=
 =?us-ascii?Q?9+YJK3NHCLIm/rBb5uqRPcY42YyVX2lwz5hp90FrerxUcwFa2vWG4xdvoHG7?=
 =?us-ascii?Q?Jg/U5TrHUVg5reHLqMBFUve/GnU9JgvR+FyAvxPW9WFvOapvlqsAKjvkGdbz?=
 =?us-ascii?Q?ZQnM3sz6138h8yD86E6GaJkc4hCPvMt+0hdaP9rfwae4WGFvUC68opZGZn9E?=
 =?us-ascii?Q?+w4Izp496irdpgq45jhzujEK/ZhsS6X9iteV6bCCzIL3v+C7IUMtLW/4ILz/?=
 =?us-ascii?Q?l1jEuVeBt8LjmPZZ8KfnjwRsrz5lZuTIK1b7ZgaZiOVdeDbLk9SgIqE8LN1k?=
 =?us-ascii?Q?xVqVcuf0kKwcUgzDg3OXbVvpoCtFvxlEEkfVbsZzDXOY257ULyjvK9OnySYM?=
 =?us-ascii?Q?3SPrLXbs6gYENEBV8p4TqNBgteJoODJfT+ywya5ndkU30H4C+s2JQxnCSEWC?=
 =?us-ascii?Q?hITX4TQwXzHAZNxgG1PCagQJctDGETvzBG3M48/1lmvUhO4L6dfFPc8R0BGj?=
 =?us-ascii?Q?Ocx8t+ew037K39komNFgeeA3KhbuewpR7IOAKvdTPZQFMQcc3OoJJxvj4s8x?=
 =?us-ascii?Q?+1Rr+9+Pz3Jo9Od/cbc44qvQx2rV1vpL8VyFfiZW+LWViCgXeGBpO6QxEa5s?=
 =?us-ascii?Q?dwsJ/qcyG08YVVsebOW3o2/ClIgNDZII5eqtNwNyrSfJdYzDhB/p2RTDLuoY?=
 =?us-ascii?Q?fwyvVCr6/NmKj1B/FVJC6/MjYvAhMoPKkz2k9njSMuAvuSrNpn9NVt+13mDE?=
 =?us-ascii?Q?iOyaaJfD//sseHAQF4gugQDvFdsI1Ivm6EwYXq28uE0KA0DKv+G9Sf517bFJ?=
 =?us-ascii?Q?bxCznxKpKEjuKVZNQ1xI0unEjZFoZvF6IGMb6PyyA8DBisE7OSWG0/1ryI39?=
 =?us-ascii?Q?FO4kr02luMmsdRD/tDE46PxMKes4RbDpPxGAK0EsZY0a4rI9+L6w/s75D3mA?=
 =?us-ascii?Q?HiJUgKaZ3o8Ou3i5YLMLslIp6EKlpDajmflV7Tkf35mT2ccgpT1Iq2vetKPV?=
 =?us-ascii?Q?9GChGZdn0HNBBTGHrQvOcCDKKJqHCv8j6pVyiSvrEhkPX2h5zSOpbvMv0Ou4?=
 =?us-ascii?Q?B4ubE1T434OkMnY9eDXfdWdd7fXfucyunK80/aG0a3lmFqdD6S7A8NGx+e7E?=
 =?us-ascii?Q?50ShKCZXeR4HhY340VZxI1vNNkh3m7P6SZxo7xRtV18jji2W6a5h0yBbS1mN?=
 =?us-ascii?Q?stlPr18Yms0mKPYNbZNs8FzF1bGkcBVrYiksEwk5kFHbQWa3vH+HdV47unGK?=
 =?us-ascii?Q?FzWfEd1mdYaN4sGhrf+N1666UcjTXJvT61myZ6cquaBBFstFo/peJTmd2RPm?=
 =?us-ascii?Q?xtw4qYPfds/g0doZr6nbKXHl81yEYvhHtEsvJSiHNSmo7zzL3x4hegB2aLMI?=
 =?us-ascii?Q?6aglyyIDpJk8lXuk1XKzhKV9JhFfaBfeMfGrSeVhBp29VR1BQKGbZ8dW2Ahf?=
 =?us-ascii?Q?/Y+uioHBRCIryMtGSkByQzi70oFd6QMivveP26f65OL0C7/FI+MVuYljIevA?=
 =?us-ascii?Q?Lp0lV95y+IK3CGN0jbcZiKXV/bI2Ma8Dn7WY/xvMtMK9HeVBrq3dlCx3HARk?=
 =?us-ascii?Q?gJxqs8ULoXhAjuh3rGcbfbd62kvIC92tcZ9Xo4XFok/B9P35O92y?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3cd8a9-456f-43c5-4b05-08df22a7e408
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:14:19.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4Hlox0Z4LbMGcVgL5o5Aab7MdrFsbM7bPuefb487s3xYrTSdEmoBgLVyuKPlLWr0mCrWmSsyqeI1yWPYQe9yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5377

On Sun, Oct 04, 2026 at 02:11:37AM +0200, Marek Vasut wrote:
> On 9/28/26 6:52 PM, Koichiro Den wrote:
> > Implement the host bridge reset_root_port() callback so PCI error
> > recovery can reset and reinitialize the R-Car controller. This also
> > provides the reset operation for the link-down handling added later.
> > 
> > Call .reinit() with clocks and PHY initialization retained, restore
> > the Root Port registers and restart link training.
> > 
> > Rather than tracking which APP interrupt enables survive the power
> > reset, derive them from software state through a single helper. A flag
> > keeps the sources masked from the start of a reset until one succeeds,
> > so a failed reinitialization does not re-enable them against an
> > uninitialized controller.
> > 
> > Serialize the reset with a mutex, as not all callers hold the Root
> > Port's device lock: pci_try_reset_function() on a downstream device only
> > locks that device before falling back to a parent bus reset.
> 
> Please pardon my ignorance, but is this maybe something that could be fixed
> in the core code ?

Yes. pci_reset_function() has locked the upstream bridge since 7e89efc6e9e4
("PCI: Lock upstream bridge for pci_reset_function()"), but
pci_try_reset_function() and pci_reset_function_locked() still do not. I am not
sure whether this is intentional, but in either case, that is a core matter and
separate from this series.

However: more to the point, your question made me look at this again, and I now
believe the mutex (rcar->reset_lock) was not needed in the first place. Every
path to reset_root_port() already holds a device lock that excludes the others:
- error recovery and bus resets go through pci_bus_lock(), which locks the Root
  Port and every device below it, and
- pci_try_reset_function() (even without the upstream bridge locked, as I noted
  above) holds the lock of the downstream device, which pci_parent_bus_reset()
  only accepts when it is the only device on the bus.

So I will drop the mutex in v3. Thanks for making me look at this again, it
really helps!

> 
> [...]
> 
> > +/*
> > + * R-Car Gen4 controllers have a single Root Port per instance, so the
> 
> I have two nitpicks here.
> 
> First, this is also applicable to R-Car Gen5 SoC PCIe4 controller, so please
> rephrase as:
> 
> -R-Car Gen4 controllers ...
> +R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller ...
> 
> Second, in another review thread, Bjorn mentioned it would be good to be
> more explicit about what is SoC generation and what is PCIe generation:
> 
> https://lore.kernel.org/all/20260928222442.GA2266778@bhelgaas/
> 
> That is also why I used such a lengthy sentence above, that is
> 
>                               Controllers are here
>                                         |
>                        _________________^__________________
>                       |                                    |
>                vvvvvvvvvvvvvvvv                    vvvvvvvvvvvvvvvv
> R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller ...
>       ^^^^^^^^                            ^^^^^^^^
>           |                                   |
>           '----------------- -----------------'
>                             V
>                             |
>                    SoC generation is here

That all makes sense. Thanks for the advice and for pointing me to the context.
I'll use your wording in the comment and all relevant commit messages in v3.

Best regards,
Koichiro Den

> 
> > + * 'pci_dev' is ignored and the whole controller is reset.
> > + */
> > +static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
> > +					  struct pci_dev *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
> > +	struct dw_pcie *dw = &rcar->dw;
> > +	struct dw_pcie_rp *pp = &dw->pp;
> > +	struct device *dev = dw->dev;
> > +	int ret;
> The rest looks good, thank you !
