Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC26ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 10:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EAD2152C
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 10:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EAD2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeITQl2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:41:28 -0400
Received: from foss.arm.com ([217.140.101.70]:43994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeITQl2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 12:41:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A2D480D;
        Thu, 20 Sep 2018 03:58:33 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4B63F5BD;
        Thu, 20 Sep 2018 03:58:31 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:58:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        paul.gortmaker@windriver.com
Subject: Re: [PATCH v2] PCI: kirin: Fix section mismatch warning
Message-ID: <20180920105828.GB838@e107981-ln.cambridge.arm.com>
References: <20180919185341.31298-1-natechancellor@gmail.com>
 <CAKwvOdkeM3sj8M-LzTQd9M9-sM_K6n6FTz=TrNHd-3xPwg_VNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkeM3sj8M-LzTQd9M9-sM_K6n6FTz=TrNHd-3xPwg_VNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Paul]

On Wed, Sep 19, 2018 at 02:08:08PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 19, 2018 at 11:55 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > the function kirin_pcie_probe() to the function
> > .init.text:kirin_add_pcie_port()
> > The function kirin_pcie_probe() references
> > the function __init kirin_add_pcie_port().
> > This is often because kirin_pcie_probe lacks a __init
> > annotation or the annotation of kirin_add_pcie_port is wrong.
> >
> > Add the __init annotation to both kirin_pcie_probe and
> > kirin_pcie_add_msi then use builtin_platform_driver_probe
> > instead of builtin_platform_driver + .probe to avoid a section
> > mismatch warning with kirin_pcie_driver.
> >
> > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > Instead of removing the annotation on kirin_add_pcie_port, add it to
> > kirin_pcie_add_msi and kirin_pcie_probe. To avoid a warning with this
> > configuration, use builtin_platform_driver_probe.
> >
> >  drivers/pci/controller/dwc/pcie-kirin.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > index 5352e0c3be82..f64fed12de51 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -448,8 +448,8 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
> >         .host_init = kirin_pcie_host_init,
> >  };
> >
> > -static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > -                               struct platform_device *pdev)
> > +static int __init kirin_pcie_add_msi(struct dw_pcie *pci,
> > +                                    struct platform_device *pdev)
> >  {
> >         int irq;
> >
> > @@ -481,7 +481,7 @@ static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> >         return dw_pcie_host_init(&pci->pp);
> >  }
> >
> > -static int kirin_pcie_probe(struct platform_device *pdev)
> > +static int __init kirin_pcie_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct kirin_pcie *kirin_pcie;
> > @@ -533,11 +533,10 @@ static const struct of_device_id kirin_pcie_match[] = {
> >  };
> >
> >  static struct platform_driver kirin_pcie_driver = {
> > -       .probe                  = kirin_pcie_probe,
> >         .driver                 = {
> >                 .name                   = "kirin-pcie",
> >                 .of_match_table = kirin_pcie_match,
> >                 .suppress_bind_attrs = true,
> >         },
> >  };
> > -builtin_platform_driver(kirin_pcie_driver);
> > +builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);
> 
> It would be good to get additional review from someone who knows more
> about driver callback lifecycles, but I think this is the correct fix.
> Thanks Nathan.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

AFAICS we can't use builtin_platform_driver_probe() if the probe()
itself may need deferral (and I *reckon* it may need that, see eg
clk_get()) so I suspect we have to go back to v1 for the patch,
apologies if so.

Lorenzo
