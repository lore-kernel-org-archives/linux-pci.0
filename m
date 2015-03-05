Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150305163822.GA3048@google.com>
References: <1424214840-26498-1-git-send-email-fkan@apm.com>
	<20150227002151.GG25765@google.com>
	<20150305163822.GA3048@google.com>
Date: Thu, 5 Mar 2015 08:53:38 -0800
Message-ID: <CAL85gmABrzMGfnxP=xgOi=cwxXoEo0=WFYE_XOzpyjtntURO-A@mail.gmail.com>
Subject: Re: [PATCH] pci: host: xgene: fix incorrectly returned address by map_bus
From: Feng Kan <fkan@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: patches <patches@apm.com>, linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Mark Salter <msalter@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please take Mark's patch if you think it is better.



On Thu, Mar 5, 2015 at 8:38 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Mark]
>
> On Thu, Feb 26, 2015 at 06:21:51PM -0600, Bjorn Helgaas wrote:
>> On Tue, Feb 17, 2015 at 03:14:00PM -0800, Feng Kan wrote:
>> > The generic accessor functions for pci-xgene uses map_bus
>> > call that returns the base address but did not add the additional
>> > offset.
>> >
>> > Signed-off-by: Feng Kan <fkan@apm.com>
>> > ---
>> >  drivers/pci/host/pci-xgene.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
>> > index aab5547..ee082c0 100644
>> > --- a/drivers/pci/host/pci-xgene.c
>> > +++ b/drivers/pci/host/pci-xgene.c
>> > @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>> >     return false;
>> >  }
>> >
>> > -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>> > +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>> >                           int offset)
>> >  {
>> >     struct xgene_pcie_port *port = bus->sysdata;
>> > @@ -137,7 +137,7 @@ static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>> >             return NULL;
>> >
>> >     xgene_pcie_set_rtdid_reg(bus, devfn);
>> > -   return xgene_pcie_get_cfg_base(bus);
>> > +   return xgene_pcie_get_cfg_base(bus) + offset;
>>
>> Where's the locking here?  ECAM doesn't need locking because the
>> bus/dev/fn/offset is all encoded in the MMIO address.  But it looks
>> like X-Gene doesn't work that way and bus/dev/fn is in the RTDID register.
>>
>> So it seems like X-Gene needs locking that not everybody needs.  Are you
>> relying on higher-level locking somewhere?
>
> Ping, what's going on here?  I've gotten at least three patches for this
> offset issue, so we need to get it resolved.
>
> If there's no locking problem, I can just apply this and we'll be finished.
> Actually, I think Mark's patch is better, because it correctly returns NULL
> (failure) if xgene_pcie_get_cfg_base() fails.  So please review and ack
> that one or explain why this one is better.
>
> But if there *is* a locking problem, we should fix that, too.  That should
> be a separate patch, so I guess I can apply the one to fix the offset
> problem first, and we'll at least be no worse off with respect to locking
> than we are today.
>
> Please help me out.
>
> Bjorn
>
>> >  }
>> >
>> >  static struct pci_ops xgene_pcie_ops = {
>> > --
>> > 1.9.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
