Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E7C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF02070D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbfCVM3s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:29:48 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43094 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390816AbfCVM3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 08:29:46 -0400
Received: by mail-vs1-f66.google.com with SMTP id i207so1234772vsd.10;
        Fri, 22 Mar 2019 05:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u95oa377k1b3PA5wrjxR0goiknXMa0KRr9sfArFdG4M=;
        b=DyjTu0gozUmcIUuHsMPkMfAGSai2eJw1COnlzlkQjP8huon4c6fInwXXKy4VgG2PFI
         MqkJ1dmdbKhHkhxvuWiigPfcTU7Wq6RS1VP0fvBaFlSFv+c8Vjf9QzfTedyY4OEyMO6f
         NaKWJKezTEf71VXQSZRpUj4iqBK1dS5EGnJg2rV+sxW3Mp/woy9WnaISY0dkLBJ7EE3w
         Qp1eN4BscNbAqhObYGZ3L2UV0rwqZKYHbd6gXW6OUcd1mO3FNAjdR/6DkP4jKCatws8Q
         gExAjmzunpHm9uXtNwMmg5EVaI17/LnD5rH6mcC6aLooei80ATkfeEwYgip4ypiEY2Hb
         Rn1A==
X-Gm-Message-State: APjAAAWtTk3Rd0qeBFQC4Um4/DneksKGIRrFK8JcgcjBPLGyfDzbp+Fq
        rBWgtBWaR0580LsHa5Ub6y39+CNUN/i9GQ2L8042VL3F
X-Google-Smtp-Source: APXvYqywg/+XVmRsSeS7kWLXLBEX4Orxlc3VLLe5WVqQ0Lr9T9pMgIU/TRgvPXgnV0wgyB2mj0GNK24mqWr7cBv//d0=
X-Received: by 2002:a67:d011:: with SMTP id r17mr5179813vsi.96.1553257785506;
 Fri, 22 Mar 2019 05:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190217132441.15139-1-marek.vasut@gmail.com> <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
 <95d1076c-5490-3803-f394-9a0928c2cccb@gmail.com> <20190322121822.GA26257@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190322121822.GA26257@e107981-ln.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Mar 2019 13:29:33 +0100
Message-ID: <CAMuHMdVt9S8ECq=FFHHLRDF4ozQc5E-kEHLZsCZaWTTi2TeC=g@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in resume_noirq
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Marek,

On Fri, Mar 22, 2019 at 1:18 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Mar 22, 2019 at 01:09:13PM +0100, Marek Vasut wrote:
> > On 3/22/19 12:31 PM, Lorenzo Pieralisi wrote:
> > > On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
> > >> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> > >>
> > >> Reestablish the PCIe link very early in the resume process in case it
> > >> went down to prevent PCI accesses from hanging the bus. Such accesses
> > >> can happen early in the PCI resume process, in the resume_noirq, thus
> > >> the link must be reestablished in the resume_noirq callback of the
> > >> driver.
> > >
> > > This looks like a fix (most likely fixing initial S2R support, please
> > > help me chase the commit ID), should we consider it for stable kernels ?
> > >
> > > Without it I understand S2R is actually broken on platforms with this
> > > host bridge.
> > I don't think this ever worked, so it's hard to find a Fixes: commit for
> > this.
>
> If we want to send it to stable kernels we have to select which versions
> we are covering. I think the only options for a Fixes: tag are either
> the initial S2R support commit for the platforms this driver runs on
> or the initial driver commit that harks back to v3.16 AFAICS.

This only started to become an issue when support for arm64 platforms
was added, where PSCI may power down the SoC, right?

Hence:
Fixes: e015f88c368da1e6 ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
