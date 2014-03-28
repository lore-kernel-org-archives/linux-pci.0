Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:51338 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaC1Q2k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 12:28:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] Versatile PCI DT support
Date: Fri, 28 Mar 2014 17:28:35 +0100
Message-ID: <5650118.DZNeEh1F94@wuerfel>
In-Reply-To: <20140328162137.GA17163@e106497-lin.cambridge.arm.com>
References: <1395960398-4238-1-git-send-email-robherring2@gmail.com> <CAL_JsqLh3i56Vp9UGELTr-eq8mQ87BAMYzFnC+6G_vDKR6awug@mail.gmail.com> <20140328162137.GA17163@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 28 March 2014 16:21:38 Liviu Dudau wrote:
> On Fri, Mar 28, 2014 at 03:20:20PM +0000, Rob Herring wrote:
> > On Fri, Mar 28, 2014 at 9:57 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > PCI core? It knows nothing of the Versatile registers. Versatile core code? Maybe.
> > 
> > These are all standard config space registers based on the offsets and
> > documentation. The only thing that I think might make this Versatile
> > specific is a host bridge having its own config space at all is
> > optional.
> 
> Sorry, got confused by your CSR_OFFSET macro into thinking it's Versatile specific (I
> still cannot get hold of the SP810 manual, sigh). Why don't you use PCI_COMMAND ?

While it's not uncommon to have PCI host controllers use a similar
layout for their own registers as the normal config space, I believe
this is not standardized anywhere. It may be better not to pretend
that this is a standard register.

> For PCIe the spec is a bit more forgiving is you use ECAM, although it doesn't
> explicitly allow writes to the config space of the host bridge. From PCI Express
> Base spec, rev 3.0:
> 
> 	7.2.2.1. Host Bridge Requirements 
> 	For those systems that implement the ECAM, the PCI Express Host Bridge is
> 	required to translate the memory-mapped PCI Express Configuration Space
> 	accesses from the host processor to PCI Express configuration transactions.
> 	The use of Host Bridge PCI class code is Reserved for backwards compatibility;
> 	host Bridge Configuration Space is opaque to standard PCI Express software
> 	and may be implemented in an implementation specific manner that is compatible
> 	with PCI Host Bridge Type 0 Configuration Space.  A PCI Express Host Bridge is
> 	not required to signal errors through a Root Complex Event Collector.  This
> 	support is optional for PCI Express Host Bridges. 
> 
> So it looks like you need to do those in the host bridge probe function, rather than
> in a generic way.

Right. FWIW, the reason why these have a normal register layout seems to be
that the same hardware is used for host controller and endpoint devices.

	Arnd
