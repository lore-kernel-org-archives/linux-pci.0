Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F61C10F06
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF12075E
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 14:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfC1O70 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:59:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38724 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1O7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 10:59:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id s2so10978259vsi.5;
        Thu, 28 Mar 2019 07:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4M4YDyunRsROoOZI3ZBVnoRZELo7poRl0NOZ0tJEWg=;
        b=O5QLv/HII//7oWMcyDMKupZS0vYp38J0CRmCxxw3zqFrOqbg2Clw+fHHmeAYBEfL+A
         V0mF8uWNWuEAUFBGlaBRpgHSaUjpCH9DIltMRuVbeftVwxfHOriBrcQ8VpSEPEKDuZXN
         /irjqT7YfBjCC/isxlWnb86JP/MprxVpxAIl61EMGdXlQ0sSilQuiXpKTE4ehZISOg6S
         KOnieO09eyJOzdJShVvltX8nK3AV33N6jQDHqk8kAoMiBcFfyA8R2QFhLk5xCQeI3a1Y
         DQKTtxUaZ7YM3kMJSYod2LSn9k8bIWSchK3ojmnGkFVqL4XdGbydRxQ33idyLDrd/8Ji
         7Ujg==
X-Gm-Message-State: APjAAAUlkPfZApNah/ZkysQwVluvQ29PX0slM/jB8FO9bIicR+e8KVL/
        OTH5U+YjkiRdSmN+uNewVNoBZagaB0r07JapT/o=
X-Google-Smtp-Source: APXvYqwg/BQSQOJ3gtUqHvmV6vhSKVqMZL76AXxcp4PhbXub54WHNv6KEJArsIrLb147I8qzV9EsVOuS5wrbWwbUGKQ=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr18631268vsn.96.1553785164184;
 Thu, 28 Mar 2019 07:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190325194319.12850-1-marek.vasut@gmail.com> <20190328141822.GA156243@google.com>
In-Reply-To: <20190328141822.GA156243@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Mar 2019 15:59:11 +0100
Message-ID: <CAMuHMdVsJ1MW40ABuieLq7F6=zG_btAHZUr82Z4_pPVem3h=jA@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in resume_noirq()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable <stable@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Mar 28, 2019 at 3:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Mar 25, 2019 at 08:43:19PM +0100, marek.vasut@gmail.com wrote:
> > From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> >
> > Reestablish the PCIe link very early in the resume process in case it
> > went down to prevent PCI accesses from hanging the bus. Such accesses
> > can happen early in the PCI resume process, as early as the
> > SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
> > driver resume_noirq() callback.
> >
> > Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
>
> I'm fine with the fix itself, but since e015f88c368d appeared more
> than two years ago in v4.5, the justification for merging this after
> the merge window is a little weak.

V1 of this fix was posted in November 2017, but IIRC, the series became
the target of some bike-shedding...

> Is there a more recent change that exposed this problem?  The usual
> situation is that we merged something during the v5.1 merge window
> that caused a regression, and we're now fixing that before v5.1 final.

There are several reasons most people couldn't even run suspend/resume
cycles on their systems:
  1. Early releases of the affected boards came with firmware revisions with
     non-functional PSCI system suspend,
  2. Preparing the PMIC for suspend required ugly assistance from i2cset
     in userspace, until the Linux driver learned to take care of that itself
     in v4.18/v4.19.

I guess the fix can survive postponing to v5.2, though...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
