Return-Path: <SRS0=k+ii=L7=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=k+ii=L7=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
References: <20171215202935.157396.74423.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917144734.GF7239@e107981-ln.cambridge.arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Sep 2018 12:12:26 -0500
Message-ID: <CAErSpo5vuW=HQ9rS68WVRmr58x9WiT11a0xvb0sc66_LfDe4Fg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Remove redundant "valid device" check
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 9:47 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Dec 15, 2017 at 02:29:35PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > In rockchip_pcie_valid_device(), we do the exact same test twice:
> >
> >   if (bus->number == rockchip->root_bus_nr && dev > 0)
> >     return 0;
> >   if (bus->number == rockchip->root_bus_nr && dev > 0)
> >     return 0;
> >
> > We only need to do it once, so remove one of them.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/host/pcie-rockchip.c |    4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index 9051c6c8fea4..dd9c7ea69e0b 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
> > @@ -293,10 +293,6 @@ static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> >  static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
> >                                     struct pci_bus *bus, int dev)
> >  {
> > -     /* access only one slot on each root port */
> > -     if (bus->number == rockchip->root_bus_nr && dev > 0)
> > -             return 0;
> > -
> >       /*
> >        * do not read more than one device on the bus directly attached
> >        * to RC's downstream side.
> >
>
> Hi Bjorn,
>
> this patch slipped through the cracks but I do not think it is right.
>
> The point here is filtering both the host bridge access side (ie check
> for dev > 0) AND the RC downstream side, it is two different busses.
>
> Perhaps the check can be written in a more concise way (squash them in
> one single conditional) but I think the current logic is correct,
> AFAICS.
>
> I would drop it from the PCI patch queue.

Definitely should be dropped from patchwork.  I can't find a posting
that had the duplicate check in it, so I don't know what I was looking
at, but the initial commit (e77f847df54c) doesn't seem to have any
duplication there.

Bjorn
