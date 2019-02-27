Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26A9C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868492184A
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="r0F4GQlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfB0Q3g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:29:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50820 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfB0Q3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 11:29:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so6435925wmj.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvHip1Hf/d4ZB9GXF7oXvloqMECViQmpaQc9cCROwmg=;
        b=r0F4GQlHgois6QVEvAc9Xdr7FL850kASOxzr3tsf9gySHoXqnPX6S85+tRJnuPaI+M
         o5UK/VcrpA5zfUd4V6QWuWofMsFFEQB9cOjJPsN3Rs0yF+qCJglIkSoyPA07rmAZWNx8
         Mn+wtEH8e75Ff/xu5citEaeB3v8bmyOgivCqoYE1neKJytTn2mOl49OFXOZVo1SdCE2X
         CswTlD09yajrzfD6wmZXdcmp51sI8gRZB5cc4MYfSbjUPoYoezkwnrb3YtFz0/nk1VNH
         f1gflvQtpF+CApDO6R7p/3jsepRis8Tc3XRAOOcygQkJsUytx6KccTBkilxqItfOOXY/
         GM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvHip1Hf/d4ZB9GXF7oXvloqMECViQmpaQc9cCROwmg=;
        b=TOjtRHXyGCcLFwk/O04yZ4wwZEDXX5Mp68OWm0DZ8cAMhaw5sLY1cDHDyfYxw2ZypM
         QblW6/dgKVM0OcvxlyS03RuXn5OhxIu/iw7ShaIB9F21FF25RhuIKDIRT1vVMyw/qJa8
         DvVQbUHDMiKh756ihhQJfqSptqCHjIG9K80bjy7vx009uyQbJUMxUgd/vQ+StGXrg4Zs
         LdMYVtUOlVmEvGoAYL/ogpzEmPCZSdNuru0wm84CQj6B4HSu9EjuvOfIop/k03BJ92Y7
         hsyWAsWt6XvY8mbtfbmJUocptCRwQlJpybmwdj/2xNSmFSCBxdN6SPNm/UoXkkjzqopl
         vfNA==
X-Gm-Message-State: AHQUAuYNqM4Dj4xe+gKGPHz/rdq6s2eF2A1c/9IvUTqFqMR+FbRgkRuw
        vWtoVSHIQ0S9wejl8b4WJ5x3Hqwo9jMCecgUf+tNwg==
X-Google-Smtp-Source: AHgI3Iami3Rr4YuTUPLvQI30BemSrdkRe2VXBw1TsoB06UOvuHTZnIxGVLA6frnz7zWG2EC4IIOCu+Rl2IVXeEYEeUM=
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr56749wmf.65.1551284973600;
 Wed, 27 Feb 2019 08:29:33 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2XcJ+btfM64p4W7VrBvB6W89MZ=+8G5NYWP16MRrY56A@mail.gmail.com>
 <1551261667.2305.6.camel@pengutronix.de>
In-Reply-To: <1551261667.2305.6.camel@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 27 Feb 2019 08:29:22 -0800
Message-ID: <CAJ+vNU0b3ZwkYJBLJitCr=_m1wpK0R9KF-Tk2QZ6UwEPMwueqA@mail.gmail.com>
Subject: Re: IMX6 dwc PCI regression through switch - unable to request
 (legacy) interrupt (pci=nomsi)
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 2:01 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Tim,
>
> Am Dienstag, den 26.02.2019, 13:13 -0800 schrieb Tim Harvey:
> > Greetings,
> >
> > I've got a miniPCIe card with a TW6869 8x frame grabber that stopped
> > working on an IMX6 based board with a PLX switch with Linux 4.17 as
> > the driver errors out with 'tw686x 0000:07:00.0: unable to request
> > interrupt' (request_irq() fails). I've found this only happens on
> > boards that have a switch. Note I'm booting with pci=nomsi as well as
> > the IMX6 has a limitation where legacy IRQ's wont fire if MSI irq's
> > are enabled. Strangely I don't see this issue with other cards such
> > as
> > the ath9k with msi disabled.
> >
> > I bisected the issue to 7c5925afbc58c6d6b384e1dc051bb992969bf787
> > 'PCI:
> > dwc: Move MSI IRQs allocation to IRQ domains hierarchical API' which
> > due to continued changes in drivers/pci/dwc can no longer be
> > reverted.
> >
> > Any ideas what happened here? IMX6 PCIe through a bridge always seems
> > not so well tested and very fragile over the past couple of years.
>
> Thanks for the report. Both the DWC PCIe core in general and the i.MX6
> integration have some rough edges, which makes things fall from time to
> time. Having a PCIe bridge in the mix does extend the test space quite
> a bit.
>
> Does the following patch help? I didn't test it yet, but it's based on
> my assumption of what is going wrong with the referenced commit.
>
> Regards,
> Lucas
>
> ----------------------------->8--------------------------------------
>
> From 40b4fc03878a935fa81af226a8e759d4c72a3603 Mon Sep 17 00:00:00 2001
> From: Lucas Stach <l.stach@pengutronix.de>
> Date: Wed, 27 Feb 2019 10:50:20 +0100
> Subject: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
>
> Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> hierarchical API) the MSi init claims one of the controller IRQs as a
> chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> this line is shared with a PCIe legacy IRQ. When the line is claimed for
> the MSI domain, any device trying to use this legacy IRQs will fail to
> request this IRQ line.
>
> As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> as the core won't forward any legacy IRQs once any MSI has been enabled,
> users wishing to use legacy IRQs already need to explictly disable MSI
> support (usually via the pci=nomsi kernel commandline option). To avoid
> any issues with MSI conflicting with legacy IRQs, just skip all of the
> DWC MSI initalization, inclusing the IRQ line claim, when MSI is disabled.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..f4a8494f616b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         if (ret)
>                 pci->num_viewport = 2;
>
> -       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +       if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
>                 /*
>                  * If a specific SoC driver needs to change the
>                  * default number of vectors, it needs to implement
> --
> 2.20.1

Lucas,

Yes, this patch resolves the issue. Where did this come from? It looks
like it came from back in September but never made it upstream?

I'm a bit baffled why I see this issue pre-patch with 'and' without
pci=nomsi based on this patch? I do see other checks in
imx6_pcie_host_init() and imx6_add_pcie_port() for
IS_ENABLED(CONFIG_PCI_MSI) that do not have an accompanying check of
pci_msi_enabled() to see if its enabled at runtime... are these
problematic as well?

I'm wondering if pci=nosmi is not well tested. I use it because of the
issue where IMX6 can't use MSI and legacy interrupts at the same time
in addition to the fact that MSI shares a single hardware interrupt
while legacy at least has 4 unit interrupts (making it able to be
steered). I'm just not a fan of MSI in the embedded arena where users
have 1 or 2 PCI devices.

Regards,

Tim
