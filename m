Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62241 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbaBFK0e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 05:26:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Anup Patel <anup@brainfault.org>
Cc: Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, mohit.kumar@st.com,
	bhelgaas@google.com
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
Date: Thu, 06 Feb 2014 11:26:15 +0100
Message-ID: <2629498.fOknbqpyEP@wuerfel>
In-Reply-To: <CAAhSdy0X56UcMrp0bsH0na=GBkND=jqZVqbHxKsBampr8YM3cA@mail.gmail.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com> <1391532784-1953-3-git-send-email-will.deacon@arm.com> <CAAhSdy0X56UcMrp0bsH0na=GBkND=jqZVqbHxKsBampr8YM3cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 06 February 2014 14:24:03 Anup Patel wrote:
> > diff --git a/Documentation/devicetree/bindings/pci/linux,pci-virt.txt b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
> > new file mode 100644
> > index 000000000000..54668a283498
> > +- compatible     : Must be "linux,pci-virt"
> > +
> > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > +                   at least a definition of the Configuration Space plus
> > +                   one or both of IO and Memory Space.
> > +
> > +- #address-cells : Must be 3
> > +
> > +- #size-cells    : Must be 2
> > +
> > +Configuration Space is assumed to be memory-mapped (as opposed to being
> 
> It would be great to have a flag to specify whether Configuration Space is over
> ioports or memory mapped.
> 

I haven't seen config space access through ioport for a long
time on non-x86. Do you have reason to believe that we will need
that?

	Arnd
