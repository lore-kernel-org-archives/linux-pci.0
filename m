Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD6EC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4BF208D9
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 15:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsms6BGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4BF208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeJAVu0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:50:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43264 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbeJAVu0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 17:50:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so4235509wrt.10;
        Mon, 01 Oct 2018 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JfxWUnw1twuY8+Pb1zHNdn9zkHVvkGGdGhL52DbTc5Y=;
        b=Nsms6BGw8xbTmJgcW35/4ZBAxTn6gJLG6J0u+9SoVa2aEZY37UlSfOIn+iqfN6L0Ud
         3wqVyFR7Q41fF2PvyxMQnU4v2qWnMxP1cBkb1eA4GiyatxOOTFfVQFI1OdpJSjBkXIZl
         nt4pZ6Zg5SVPei+cmDOH8SaehZu5X3DCGgi4y7PZ6iBACHNrkwYIVKh3MJxHNDgoLoE0
         mpkDusGm6+/JqzQDBMh4zquGz553rWzbGnQKfUp5HnenIl8+xtBfvoDr9udGFmoPQM17
         WuH/LgzagtKhQEw1JPoMMjktum0YcyYFLAXyLNQ9PwXJgyc8r4Oh+PItMHlNDqurdy22
         SQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JfxWUnw1twuY8+Pb1zHNdn9zkHVvkGGdGhL52DbTc5Y=;
        b=oXs86gEgZ+8wfJmmPku5KBaVUmYaZ4FpgW+r0SXHQH9Epu54KHbKOaBgrK9dIqiFH4
         LVqAi2Ur7RNJjynBMNT9DpheKj081HUwn78O9GWk9MnYOt3luFgjhMXYXFZ4s5AQSgQC
         ghqe9+nQVGyNQ3UMB41EiwMvSLhiRDLa/2o5RKX7IrfNu2HVZoR77tecoo+8E6RWi6WK
         FV2EsRnie+Og8/7KU1Y8wHvByEAqGanuQrNBmeo3zibiPT/M27GUv4+cjUxjeDz14JLN
         PRdwXwHv6otmNRJXWXAy6dB/OPJS8J0fCD3rh2yxhHgOc5cPURuoH9B7ttKvSyGayKte
         2yPA==
X-Gm-Message-State: ABuFfoikq1uLl5e16cxXQq5QQwqy/Bct3sGxYp3RU718HGAmrTatKxVj
        TiyXPkv5N4DH62m8SQ9QhDMy2dfIbiyjsg==
X-Google-Smtp-Source: ACcGV62Sfmv6UV/JBTJF+anN4cUSoPVIrguy7JM9boaR516u9F+0gCjsfCvQMsOiDR16q/qq7YAMnw==
X-Received: by 2002:adf:c3cd:: with SMTP id d13-v6mr7823398wrg.68.1538406728036;
        Mon, 01 Oct 2018 08:12:08 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w2-v6sm14943087wre.46.2018.10.01.08.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 08:12:07 -0700 (PDT)
Date:   Mon, 1 Oct 2018 08:12:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        paul.gortmaker@windriver.com
Subject: Re: [PATCH v2] PCI: kirin: Fix section mismatch warning
Message-ID: <20181001151205.GA17607@flashbox>
References: <20180919185341.31298-1-natechancellor@gmail.com>
 <CAKwvOdkeM3sj8M-LzTQd9M9-sM_K6n6FTz=TrNHd-3xPwg_VNw@mail.gmail.com>
 <20180920105828.GB838@e107981-ln.cambridge.arm.com>
 <20181001145341.GC13049@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001145341.GC13049@red-moon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 03:53:41PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Sep 20, 2018 at 11:58:28AM +0100, Lorenzo Pieralisi wrote:
> > [+Paul]
> > 
> > On Wed, Sep 19, 2018 at 02:08:08PM -0700, Nick Desaulniers wrote:
> > > On Wed, Sep 19, 2018 at 11:55 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> > > > the function kirin_pcie_probe() to the function
> > > > .init.text:kirin_add_pcie_port()
> > > > The function kirin_pcie_probe() references
> > > > the function __init kirin_add_pcie_port().
> > > > This is often because kirin_pcie_probe lacks a __init
> > > > annotation or the annotation of kirin_add_pcie_port is wrong.
> > > >
> > > > Add the __init annotation to both kirin_pcie_probe and
> > > > kirin_pcie_add_msi then use builtin_platform_driver_probe
> > > > instead of builtin_platform_driver + .probe to avoid a section
> > > > mismatch warning with kirin_pcie_driver.
> > > >
> > > > Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> > > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >
> > > > v1 -> v2:
> > > >
> > > > Instead of removing the annotation on kirin_add_pcie_port, add it to
> > > > kirin_pcie_add_msi and kirin_pcie_probe. To avoid a warning with this
> > > > configuration, use builtin_platform_driver_probe.
> > > >
> > > >  drivers/pci/controller/dwc/pcie-kirin.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > index 5352e0c3be82..f64fed12de51 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > > @@ -448,8 +448,8 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
> > > >         .host_init = kirin_pcie_host_init,
> > > >  };
> > > >
> > > > -static int kirin_pcie_add_msi(struct dw_pcie *pci,
> > > > -                               struct platform_device *pdev)
> > > > +static int __init kirin_pcie_add_msi(struct dw_pcie *pci,
> > > > +                                    struct platform_device *pdev)
> > > >  {
> > > >         int irq;
> > > >
> > > > @@ -481,7 +481,7 @@ static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> > > >         return dw_pcie_host_init(&pci->pp);
> > > >  }
> > > >
> > > > -static int kirin_pcie_probe(struct platform_device *pdev)
> > > > +static int __init kirin_pcie_probe(struct platform_device *pdev)
> > > >  {
> > > >         struct device *dev = &pdev->dev;
> > > >         struct kirin_pcie *kirin_pcie;
> > > > @@ -533,11 +533,10 @@ static const struct of_device_id kirin_pcie_match[] = {
> > > >  };
> > > >
> > > >  static struct platform_driver kirin_pcie_driver = {
> > > > -       .probe                  = kirin_pcie_probe,
> > > >         .driver                 = {
> > > >                 .name                   = "kirin-pcie",
> > > >                 .of_match_table = kirin_pcie_match,
> > > >                 .suppress_bind_attrs = true,
> > > >         },
> > > >  };
> > > > -builtin_platform_driver(kirin_pcie_driver);
> > > > +builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);
> > > 
> > > It would be good to get additional review from someone who knows more
> > > about driver callback lifecycles, but I think this is the correct fix.
> > > Thanks Nathan.
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > AFAICS we can't use builtin_platform_driver_probe() if the probe()
> > itself may need deferral (and I *reckon* it may need that, see eg
> > clk_get()) so I suspect we have to go back to v1 for the patch,
> > apologies if so.
> 
> I think that the best course of action consists in merging v1 since
> we have not reached a definitive conclusion on v2, please let me
> know.
> 
> Thanks,
> Lorenzo

Hi Lorenzo,

I am perfectly fine with v1 being merged as either patch solves the
warning. I agree with Nick that if this version works it would be more
proper but it also carries more risk with regards to deferral like you
stated. Please let me know if I need to resend it.

Thanks,
Nathan
