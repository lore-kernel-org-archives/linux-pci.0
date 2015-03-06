Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:40814 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbbCFEM7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2015 23:12:59 -0500
Received: by oiba3 with SMTP id a3so15723429oib.7
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2015 20:12:59 -0800 (PST)
Date: Thu, 5 Mar 2015 22:12:43 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Feng Kan <fkan@apm.com>
Cc: patches <patches@apm.com>, linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by
 map_bus
Message-ID: <20150306041243.GA20077@google.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
 <20150227002151.GG25765@google.com>
 <20150305163822.GA3048@google.com>
 <CAL85gmABrzMGfnxP=xgOi=cwxXoEo0=WFYE_XOzpyjtntURO-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL85gmABrzMGfnxP=xgOi=cwxXoEo0=WFYE_XOzpyjtntURO-A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 05, 2015 at 08:53:38AM -0800, Feng Kan wrote:
> Please take Mark's patch if you think it is better.
> 
> 
> 
> On Thu, Mar 5, 2015 at 8:38 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Mark]
> >
> > On Thu, Feb 26, 2015 at 06:21:51PM -0600, Bjorn Helgaas wrote:
> >> On Tue, Feb 17, 2015 at 03:14:00PM -0800, Feng Kan wrote:
> >> > The generic accessor functions for pci-xgene uses map_bus
> >> > call that returns the base address but did not add the additional
> >> > offset.
> >> >
> >> > Signed-off-by: Feng Kan <fkan@apm.com>
> >> > ---
> >> >  drivers/pci/host/pci-xgene.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> >> > index aab5547..ee082c0 100644
> >> > --- a/drivers/pci/host/pci-xgene.c
> >> > +++ b/drivers/pci/host/pci-xgene.c
> >> > @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
> >> >     return false;
> >> >  }
> >> >
> >> > -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> >> > +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> >> >                           int offset)
> >> >  {
> >> >     struct xgene_pcie_port *port = bus->sysdata;
> >> > @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> >> >             return NULL;
> >> >
> >> >     xgene_pcie_set_rtdid_reg(bus, devfn);
> >> > -   return xgene_pcie_get_cfg_base(bus);
> >> > +   return xgene_pcie_get_cfg_base(bus) + offset;
> >>
> >> Where's the locking here?  ECAM doesn't need locking because the
> >> bus/dev/fn/offset is all encoded in the MMIO address.  But it looks
> >> like X-Gene doesn't work that way and bus/dev/fn is in the RTDID register.
> >>
> >> So it seems like X-Gene needs locking that not everybody needs.  Are you
> >> relying on higher-level locking somewhere?
> >
> > Ping, what's going on here?  I've gotten at least three patches for this
> > offset issue, so we need to get it resolved.
> >
> > If there's no locking problem, I can just apply this and we'll be finished.
> > Actually, I think Mark's patch is better, because it correctly returns NULL
> > (failure) if xgene_pcie_get_cfg_base() fails.  So please review and ack
> > that one or explain why this one is better.

Huh, I could swear I saw a failure path in xgene_pcie_get_cfg_base().  But
I don't see a way it can fail, so I don't think it matters which way we fix
this.

Bjorn
