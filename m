Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020142.outbound.protection.outlook.com [52.101.228.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDC3A16AB;
	Tue, 18 Aug 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065807; cv=fail; b=nDEbG8au8tBF3FkjkU1duf/TDazGKQYDeZmmOycb/WH2TNWdVmlzQkIj/4eAzzuJlaKgrcG6+h2ghmbNZY7dJwV0zXMqUbZg12/o3um9bCIhyfjAnS1ndwA7FSQouyUm1X+E7nN824EWZTGqX757sOytHdN6ZdrShchSstdmZGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065807; c=relaxed/simple;
	bh=dYI7VOtnabM9+mER7Krtw/KB+GP1RX9YjE8iFL8jdhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XbvGOF3suS55lltAt9zg33Qs8fXsL8r/+ZglHmPqIzydkqbqI0pIMmFb/50oeORABT40ePiuAbgf5xPAOiUMvl9kI2Hw0PcmOM9WGkQMv+A/6grsgPpdJBxbJdM0Jw4op7GzG0kcSlR3+nXRYFFWyHE0XIv4ptHW1LkSaRS9Jlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wI7yPv46; arc=fail smtp.client-ip=52.101.228.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wI7yPv46"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc6emwBBjEmjjxnkmpAQ7TWH74LAswJPlVdlx2p7zfQRml9fgiWYk96dZBvk72eGC+THy3q2wbpC9be+42CGpPgei1UyJ7Inmsu4H9+wQhETaAdHkCgA9epHl+V5OObSfEdvCz2J2DMc6D0Xm5NCFJRV2iDo0JoDWMWcEZIm54NxmimFueyGSdFUkzTGA2w2SkZyojrdAIhd7Hwp4jnOlh3q+K40+QjzKAdwWGJD7OSbXgkhDSFmQ8XN2uOg7thdncs0ho1Kdfrayweqfb9WUcip/m6B9uHKcRyUY/rURrjzQ2SWf66/TxJOR37rsxezenhhu13uM0t2YfdVxnLBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLmr5/ZZwdIbH58q3REHtaG4VJWCXOajK96ZkZKbDrQ=;
 b=zHeaA7wJPSIBNRJUMHSCdy2NLb+TEmlJci8kTzxqyF7EyI07vOrPbEEeLJn3UYzOsBkF0zqaOfU/mGwUcgIuu+ZghX1BsIad809DeoZlR6BTDKU9t6aB/nzFHORxIA1eBfm1TgAdCjWy79HHuccoQMND64rfwpPZjb9I+3V/tgw96HLjjs/xXqZs0f51k0RAIFZZj4gtSJDoHc+xQnI80Xp7qImsCWDRA913jljlzJPGs0FiG6VUJGD4k7x2LYxeh0rsMB/urQxe6PROjET8gjckmCGgoYq82SuYXXmgmoE6WIbFy2Eq/CMJcI3rmfZtBPAYmRSRywEnZPBv98uIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLmr5/ZZwdIbH58q3REHtaG4VJWCXOajK96ZkZKbDrQ=;
 b=wI7yPv46vp3/1fTPxaPli54AuO6Qs2/JWj3F/LFI445aVChwqe990FzR/64jaQ8tCRQaOId4I1xvTajkpxROXSGxLnT5EV7JqDLLwKbOj234jiwCbg3G1FG8bXNXk3Pn/s2FXc9BxUAcoxJI47XkVdAXhHWYpVPe7hxl/ARFVJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5150.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 15:10:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 15:10:01 +0000
Date: Wed, 19 Aug 2026 00:09:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	linux-pci@vger.kernel.org, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in
 rcar_gen4_pcie_ep_deinit()
Message-ID: <zi6an774rs4zsvz4rgvskvchlcz3ontuih7ztime673pw55axf@updaznhtexix>
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
 <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
 <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: de82365b-e8ae-4faf-4d9a-08defd3ac681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|10070799003|376014|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003|5023799004|27256017;
X-Microsoft-Antispam-Message-Info:
	Nva3fZYAQuDcFPNzdR5+AweB+ZwXgw31Gy+wNVqc1DcuXPdEJBKNSQlgBkzMMtZAX4+XOlOFm/bAwB+sgvcsGcmKTpieFhvV6eWdqdWDkHDFq6vxfMB3HINUWFcpjwM5cFgVet9uMlOIYD5bW3ppUKT+ssdxCBuCXcc08A2aLLG2bHwb/O4G/wUvOr6Hz395ppLsyhfPgGAj3zXhytt8W0SdY3C1ZemOwsiPrCbqRE5eChXPgHyynVCftINPwCc6o4ji0qze4P28wU1/8cYTsC8hzDVLqCpWEhelpm4GHGURlG0OlbALlm3uQ1eW0Q1c5yhVwl0I+9mvcKc+NWNHrFWVVfElvOQ8GuQeI6M8abC4fF+vv4jsnKjb4PrFrDH4gNXCUmrJI4wHCMVqlQihH8T1Wx6rSzKaEEWVwctYWEC1JGe0Ucy/i7+B8JW6SayHlJEle+1P0rweFsyz9bb5x6VyCFh+m0V/bYK8sgu12BGxhmSL2MkzVhbMCjL2wDvrNjvYpXEb/FPhiMKeMlibGW7ilGEYyo7xDnSXdiLuJOnxiX/XiQe0tOACb7Qr40wweSiRaVbGnsJHKU7Wd654lAaSKCxYUknQ+zmmDg+ITUfIibSeCI6OTskAjc+FvW3C6/y331ZUXVn1Sql5ZCfMGf/t2HxsBboiGslmJ/YJpsasiKspA0/rOpgCRp9wXNiX4q/equRlj5G3gvfEKLy57w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(10070799003)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5AbV0WueVGJcv9m/Ei2GFIcJzmxQdajJGwvZ0GWX0jwzuREMfdHmJoHipcQ?=
 =?us-ascii?Q?2pyct/2TDG2wiX3taY3WWHaR6vh+TeJncdS/ttyAYB96yKNm8g+IP48coGWV?=
 =?us-ascii?Q?s4AjvzYey6ccGM1SbgKo1cIL95BSm/JTbb9G/5uyHhM4pDJwFnlxTV9gSHFU?=
 =?us-ascii?Q?ScM1/DZ2IBhMTxU1mwOyHKLRGPo/jspyfucih8zpaSyB2w8z9hTGRbSXufLX?=
 =?us-ascii?Q?Q4DyBYclD+fmwfuIcGY+xB/1CwZzMuG6oN9mzVyeGqI4Hd8vbN6JpyXRDzWH?=
 =?us-ascii?Q?+6OMf4M5iTQCAHs1J2+EwOndCq+YYpePWyMx21+gE5ivNVy0tTnei4ccplBc?=
 =?us-ascii?Q?rIeqdnob4ihrlwtbjCn8v9QY6XkaBIiEJQ9JQmWcs7NIH2xbylKE+rRQwX04?=
 =?us-ascii?Q?qabPqjE6grN+69e/8dZkvVcHQrROfrh/FhqOhwbbElrY9xjgwQct0oxB2U6N?=
 =?us-ascii?Q?4FnokRSHx9f2+gWTbIPsPOZNqbLqZ18wQXx10tiY9V1XMn96LAIy5U9DTapF?=
 =?us-ascii?Q?oUYNecVK9SrUIC7FpZyMCQ5q4ihAg5dfxmybGhN2lLTUCRw4f++LZVPDMcwo?=
 =?us-ascii?Q?yieqh+20M9cCzFWIDD4zC+OKRpiRmSjxpmDpyG2P4qX1J9ZRFjVIQqD8315M?=
 =?us-ascii?Q?muMATMhwdUDv/J16zG6Emk48WxycmE/6ngyN5UVpClQs603CRQe4N7+hU0+X?=
 =?us-ascii?Q?UUE4658vyebSK3XMMypRXpbyzYFqnDP9ySUgpW34kANo/j7uu9xGUB8L7j/6?=
 =?us-ascii?Q?D/rTO57JyUoPOug0sTFO2KxsJw6qe4+Y7cH2cD8PhW2pmMrUPX749BxZSVIE?=
 =?us-ascii?Q?VJApyMyU6h6z44vS25+XYbrYLW06u5I8ifw/1CW5Bv6UJ6A6DvwUTvykwQpo?=
 =?us-ascii?Q?xcPN8ngo6hIdNHqmgCe/eUgjN5SA+GFzEvVF9BWqohIw2k1yeB8nc/Mub+J4?=
 =?us-ascii?Q?YHgzE/w7iHE9UUJT5lQyPj5CmolfkNvxFTnIOlktKh8ZJBCFwO9oqQmWxt51?=
 =?us-ascii?Q?MSAjWexEIOBa5KhyQLP3pdTFpi45aQ7bhXufiQpY5jXcewvKRlUwQqkQ76sF?=
 =?us-ascii?Q?8hl5sIsZanVTepkYY9CS3n4oYPWAmXA0HOu6u6BheKAsJSr+9A3j/cSxS6xK?=
 =?us-ascii?Q?IKZ62R/Dw6xUS14NQMwCpi3EYV4C4+iW16ZyQOj60TYPDXjatPnShAMAufdc?=
 =?us-ascii?Q?Nd9FkHuwAMGmBrQkKbj7BFLSVFP3CvBYCEApujhKa7q1o8qi8UlDg3unyUug?=
 =?us-ascii?Q?Q01P56s+FZ9pyRudQQ9jnwX/nBewnpqKOR5xCQHmEDZosYUmWMNku2z0wfp0?=
 =?us-ascii?Q?Bsv0qaWgCARAEFMA7xUnyi4+1pPAl9nci8dJiBFz04oz6AIiLr6iSiNOFWpi?=
 =?us-ascii?Q?Vye/0+9Nk+lbJKz1TvjkXLPAu2bXRNWlATKHPfmBx1hFq4uI1J17c97qN00O?=
 =?us-ascii?Q?kcqTxQD5w/UuA/FSl99DnTHBMo0PLFaw+DKBhed+wfCazcrP9KNtQV2jgskw?=
 =?us-ascii?Q?5vJptFmgnJAR1CBgwO62lLLBCl7mwVQ6sfaOEr9QvoZR61pBUYl1Hsscw2UU?=
 =?us-ascii?Q?pVNsHecQ2Uk+bw3zBQWL4YQ2TRP+OaMqKK+vvpixcMK9Wb75XhJ4IluT5vZz?=
 =?us-ascii?Q?edZKWqcM84Np8k89PuBebltV5YBvQYMsfdFE1a8U1vddIZvrtWfD/FWQSrCd?=
 =?us-ascii?Q?X4FWp3x/3vlFNN2AtBDue5BWy6e1LQ3qu/S8dWozQw9MC4mU4uqJCCwW15yY?=
 =?us-ascii?Q?eFZ4djRtL3yVYy2AssXB0kuhWXesF90nFhkFWf2KAInRC4+mV0yz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: de82365b-e8ae-4faf-4d9a-08defd3ac681
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 15:10:01.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xfy8fSJ20/StboD9G1NXZpBgv93uaqWvD4lVgsDIud3B+qmnEVtpS2JD2do1tn3zdau2AEO/4MS6+Kqr3KtQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5150

On Tue, Aug 18, 2026 at 08:57:55AM +0200, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Tue, 18 Aug 2026 at 07:55, Koichiro Den <den@valinux.co.jp> wrote:
> > On Thu, Aug 13, 2026 at 11:18:22AM +0200, Marek Vasut wrote:
> > > Initialize PCIEDMAINTSTSEN in rcar_gen4_pcie_ep_pre_init() to 0,
> > > and in case rcar_gen4_pcie_common_init() fails and the result
> > > propagates to dw_pcie_ep_init(), the invoke common deinit instead
> > > of endpoint deinit, because we are certain the PCIEDMAINTSTSEN
> > > register is already 0 and the common deinit does not do any register
> > > accesses.
> > >
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> > > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > > @@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> > >       struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> > >       int ret;
> > >
> > > +     writel(0, rcar->base + PCIEDMAINTSTSEN);
> > > +
> >
> > 1. The new writel(0, PCIEDMAINTSTSEN) runs before clk_bulk_prepare_enable().
> >    Is MSTP024 expected to be already released at this point? I added the quick
> >    check like below on Spider, and confirmed that the clock was already enabled.
> >
> >    --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >    +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> >    @@ -9,6 +9,7 @@
> >      */
> >
> >     #include <linux/delay.h>
> >    +#include <linux/clk-provider.h>
> >     #include <linux/firmware.h>
> >     #include <linux/interrupt.h>
> >     #include <linux/io.h>
> >    @@ -487,6 +488,10 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> >            struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> >            int ret;
> >
> >    +       if (__clk_is_enabled(dw->core_clks[DW_PCIE_CORE_CLK].clk))
> >    +               dev_info(dw->dev,
> >    +                        "PCIEC module clock was already enabled\n");
> >    +
> >            writel(0, rcar->base + PCIEDMAINTSTSEN);
> >
> >            ret = rcar_gen4_pcie_common_init(rcar);
> >
> >    If that is not guaranteed, wouldn't this write rely on firmware or some
> >    earlier user leaving the module clock enabled?
> 
> The module clock is enabled through Runtime PM:
> 
>     rcar_gen4_pcie_probe
>     -> rcar_gen4_pcie_prepare
>             -> pm_runtime_resume_and_get

Hi Geert,

I see, CPG_MOD 624. Thanks! Then I am not sure the original writel() is actually
unclocked. It runs before pm_runtime_put(), so runtime PM still keeps that clock
enabled. If "unclocked" means ref clock instead, the new writel() also runs
before clk_bulk_prepare_enable(). Probably I'm missing something again. I would
appreciate it if you could shed light on this.


P.S. I also ran two error injection experiments on an S4 Spider. This is also
related to question #2 in my previous comment.

- When I injected a failure inside common_init(), its error path unwound the
  bulk clocks itself. Calling common_deinit() afterwards triggered "already
  disabled/unprepared" warnings.
- When I injected a failure after pre_init() had succeeded, PCIEDMAINTSTSEN read
  back as 0xffff both before and after common_deinit().

So I think clean-up needs to know whether pre_init() completed, rather than
always calling common_deinit(). Something like this (field declaration omitted):

--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -487,17 +487,24 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
        struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
        int ret;

        ret = rcar_gen4_pcie_common_init(rcar);
        if (ret)
                return ret;

        writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
+       rcar->ep_pre_init_done = true;

        return 0;
 }

 static void rcar_gen4_pcie_ep_deinit(struct rcar_gen4_pcie *rcar)
 {
+       if (!rcar->ep_pre_init_done)
+               return;
+
+       rcar->ep_pre_init_done = false;
        writel(0, rcar->base + PCIEDMAINTSTSEN);
        rcar_gen4_pcie_common_deinit(rcar);
 }

I may be missing something again, so please just take it with a pinch of salt.

Best regards,
Koichiro

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
