Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56427 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbaKRLgA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 06:36:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] asm-generic: Add msi.h
Date: Tue, 18 Nov 2014 12:33:11 +0100
Message-ID: <5216496.erm7FtUABJ@wuerfel>
In-Reply-To: <alpine.DEB.2.11.1411181149350.3909@nanos>
References: <alpine.DEB.2.11.1411181133080.3909@nanos> <1703620.E5bhVDQPHc@wuerfel> <alpine.DEB.2.11.1411181149350.3909@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 November 2014 11:59:39 Thomas Gleixner wrote:
> On Tue, 18 Nov 2014, Arnd Bergmann wrote:
> 
> > On Tuesday 18 November 2014 11:34:37 Thomas Gleixner wrote:
> > > To support MSI irq domains we want a generic data structure for
> > > allocation, but we need the option to provide an architecture specific
> > > version of it. So instead of playing #ifdef games in linux/msi.h we
> > > add a generic header file and let architectures decide whether to
> > > include it or to provide their own implementation and provide the
> > > required typedef.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > for merging the asm-generic file
> > 
> > > I know that typedefs are not really nice, but in this case there are no
> > > forward declarations required and it's the simplest solution.
> > 
> > I must be missing the obvious: what problem does the typedef solve
> > that you would have with just a struct?
> 
> It's not obvious. :)
> 
> The irqdomain stuff is pretty device tree centric, but the new stacked
> irqdomains are to be used by x86 as well. So we made some of the
> interfaces opaque, i.e. void *allocation_arg.
> 
> Now MSI is a bit differnet as it cannot be decribed by DT, so we want
> a proper generic data structure for it and of course we want to have a
> type for it.
> 
> Now x86 has a bit more convoluted requirements where we prefer for
> simplicity reasons to reuse the allocation data structure which we
> have alredy for the non MSI cases, so it can be handed down to the
> opaque interfaces as well.
> 
> So we have the generic:
>  
> struct msi_alloc_info {
>        ....
> };
> 
> and 
> 
> struct x86_alloc_info {
>        ...
> };
> 
> So we either can do in x86:
> 
> struct msi_alloc_info {
>        struct x86_alloc_info info;
> };
> 
> or use a typedef which maps x86_alloc_info to msi_alloc_info_t.
> 
> I think the typedef is more sane in that case.
> 

Ok, makes sense.

	Arnd
