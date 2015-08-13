Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:51615 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbHMAtx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 20:49:53 -0400
Date: Thu, 13 Aug 2015 10:49:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci <linux-pci@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Michal Marek <mmarek@suse.cz>
Subject: Re: linux-next: Tree for Aug 12 (include/linux/pci.h)
Message-ID: <20150813104951.62b1e078@canb.auug.org.au>
In-Reply-To: <55CBE1E7.60904@infradead.org>
References: <20150812233914.451d1fcf@canb.auug.org.au>
	<55CB8AF0.4060905@infradead.org>
	<20150813075322.064035f8@canb.auug.org.au>
	<55CBCF96.7060102@intel.com>
	<55CBE1E7.60904@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Randy,

On Wed, 12 Aug 2015 17:16:39 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 08/12/15 15:58, Tadeusz Struk wrote:
> > Hi,
> > On 08/12/2015 02:53 PM, Stephen Rothwell wrote:
> >> On Wed, 12 Aug 2015 11:05:36 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >>>>
> >>>> on i386 or x86_64:
> >>>>
> >>>> Many (repeated) errors like this one:
> >>>>
> >>>> ../include/linux/pci.h:390:12: error: âstruct pci_devâ has no member named âphysfnâ
> >>>>
> >>>> when CONFIG_PCI_ATS is not enabled.
> >> Maybe caused by commit
> >>
> >>   dd0f368398ea ("crypto: qat - Add qat dh895xcc VF driver")
> >>
> >> from the crypto tree Which adds a
> >>
> >>   select PCI_IOV
> >>
> >> to drivers/crypto/qat/Kconfig without the necessary
> >>
> >>   select PCI
> >>
> >> but PCI_IOV selects PCI_ATS, so I am not sure what happened here.  I am
> >> assuming that your config has PCI_IOV enabled?  What about PCI?
> > 
> > There is a patch submitted, but not yet applied
> > https://patchwork.kernel.org/patch/6994171/
> > maybe it will help?
> 
> Yes, that works for me.  Thanks.

Thanks for doing that.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
