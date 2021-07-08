Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F9FC07E96
	for <linux-pci@archiver.kernel.org>; Thu,  8 Jul 2021 23:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF956144F
	for <linux-pci@archiver.kernel.org>; Thu,  8 Jul 2021 23:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGHXic (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Jul 2021 19:38:32 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60560 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGHXib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 19:38:31 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 46F0192009C; Fri,  9 Jul 2021 01:35:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 403EF92009B;
        Fri,  9 Jul 2021 01:35:47 +0200 (CEST)
Date:   Fri, 9 Jul 2021 01:35:47 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/PCI: Handle PIRQ routing tables with no router
 device given
In-Reply-To: <60E77EBF.2020605@gmail.com>
Message-ID: <alpine.DEB.2.21.2107090113210.6599@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2107061320570.1711@angie.orcam.me.uk> <60E726E2.2050104@gmail.com> <alpine.DEB.2.21.2107082226040.6599@angie.orcam.me.uk> <60E77EBF.2020605@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 9 Jul 2021, Nikolai Zhubr wrote:

> >   Have you tried contacting Nvidia about your ALI chipset?  Back in the day
> > I tried to avoid undocumented stuff and Intel was reasonably open about
> > most of their chipsets.
> 
> Well, being neither their customer nor a kernel developer, I'm not sure my
> request would be considered serious. Anyway, probably I'll give it a try a bit
> later when I have an opportunity to dismount this board for more comfortable
> testing.

 It never hurts asking.  At worst you'll be ignored, and at the second 
worst they'll say nay.  They may have lost it too.

> I was also going to try to modify its BIOS to remove some unwanted
> behaviour unrelated to IRQs, and it might happen that I also discover
> something about PCI handling along with (It is just 64k size, after all, and I
> have a 8086 debugger)

 Umm, the board may be old enough not to play any tricks with the BIOS, 
but mind that at reset x86 starts in the flat mode from 0xfffffff0 and the 
contents of ROM there may not be what you see at 0xf000:0xfff0 later on.

 I once worked on a project where I had an opportunity to access the BIOS 
at the reset vector (and poke at CPU registers, run, stop, single-step it, 
place hardware breakpoints, etc.) using GDB over JTAG with an Intel Atom 
board.  It was an interesting experience, but sadly most x86 hardware does 
not have the capability let alone a JTAG connector (called XDP or eXtended 
Debug Port in Intel-speak) to attach a probe to.

 You may try disassembling the PCI BIOS 2.1 service however.

  Maciej
