Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:57742 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab3KZXFK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 18:05:10 -0500
From: Marek Vasut <marex@denx.de>
To: =?utf-8?q?Bj=C3=B8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: Kernel oops from pci_disable_msi
Date: Wed, 27 Nov 2013 00:05:05 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Eric Nelson <Eric.Nelson@boundarydevices.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <201311262219.49115.marex@denx.de> <cmu-lmtpd-17794-1385506605-2@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-17794-1385506605-2@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201311270005.05153.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,

> 26. nov. 2013 kl. 22:19 skrev Marek Vasut <marex@denx.de>:
> > Dear Bjørn Erik Nilsen,
> > [...]
> > 
> >>>> Thank you for your effort!
> >>>> I reproduced this kernel panic on Exynos platform with LAN card.
> >>>> And then, I tested your patch and checked this kernel panic is
> >>>> resolved.
> >>>> 
> >>>> Marek Vasut,
> >>>> Will you test Bjørn Erik Nilsen's patch with your i.MX platform?
> >>>> 
> >>>> Pratyush Anand,
> >>>> Would you confirm Bjørn Erik Nilsen's patch?
> >>>> 
> >>>> I will do more extensive testing.
> >>>> Thank you.
> >>> 
> >>> The patch does indeed fix the crash, but there are more subtle issues
> >>> lurking around. I noticed how irq numbers were constantly increasing
> >>> and I found at least one stupid mistake that I made.
> >>> 
> >>>> -             irq_set_msi_desc(irq + i, desc);
> >>>> +             irq_set_msi_desc_off(irq + i, i, desc);
> >>> 
> >>> That should be 'irq_set_msi_desc_off(irq, i, desc)'
> >>> 
> >>> (I'm really puzzled why this didn't cause other oops ...)
> >>> 
> >>> I also realized that teardown() is only called for the irq returned
> >>> from setup(), which kind of makes sense since the others are
> >>> destroyed() in the first call to teardown. This means we need to
> >>> iterate all irqs in the same fashion as we allocate in
> >>> setup/assign_irq. Basically unrolling what was done there.
> >>> 
> >>> I'm hacking on this solution now but it doesn't quite take me to where
> >>> I want at the moment, so it would be nice if someone with a better
> >>> understanding of the code could pitch in.
> >> 
> >> I gave it another shot and now it starts to look like something. At
> >> least I get consistent irq numbers and my system is very stable in
> >> general.
> >> 
> >> My new patch does exactly the opposite in teardown() of what is done in
> >> setup(), which in itself is a good sign.
> >> 
> >> --- pcie-designware.c.orig      2013-11-21 14:02:03.656007695 +0100
> >> +++ pcie-designware.c   2013-11-22 16:32:30.360954591 +0100
> >> @@ -242,11 +242,15 @@ static int assign_irq(int no_irqs, struc
> >> 
> >>        if (!irq)
> >>        
> >>                goto no_valid_irq;
> >> 
> >> +       /*
> >> +        * irq_domain_add_linear (called from dw_pcie_host_init)
> >> pre-allocates +        * descs so there is no need to call
> >> irq_alloc_descs here. +        */
> >> +
> >> 
> >>        i = 0;
> >>        while (i < no_irqs) {
> >>        
> >>                set_bit(pos0 + i, pp->msi_irq_in_use);
> >> 
> >> -               irq_alloc_descs((irq + i), (irq + i), 1, 0);
> >> -               irq_set_msi_desc(irq + i, desc);
> >> +               irq_set_msi_desc_off(irq, i, desc);
> > 
> > Why do you not allocate the descs anymore ?
> 
> Descs are allocated in irq_create_mapping, added in commit 904d0e788993
> 
> Oh, and I realize now that my comment in the patch regarding this is wrong.
> 
> […]
> 
> > Can you try using 'git send-email' for submitting subsequent patches
> > please?
> 
> I will eventually try using git send-mail for my next patch, which will
> correct the comment.

That'd be really helpful, thanks for spotting this btw ;-)
