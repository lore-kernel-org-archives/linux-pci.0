Return-Path: <lftan.linux@gmail.com>
Return-Path: <lftan.linux@gmail.com>
MIME-Version: 1.0
Sender: lftan.linux@gmail.com
In-Reply-To: <20160818201843.GI27353@localhost>
References: <1471250179-24198-1-git-send-email-lftan@altera.com> <20160818201843.GI27353@localhost>
From: Ley Foon Tan <lftan@altera.com>
Date: Fri, 19 Aug 2016 15:54:54 +0800
Message-ID: <CAFiDJ5_o9TuZirR8=2-HE6mcXhHcu3cskqMv9rufoY8G8R_mGQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: Retrain link in rootport mode only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 19, 2016 at 4:18 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Aug 15, 2016 at 04:36:19PM +0800, Ley Foon Tan wrote:
> > Altera PCIe IP can be configured as rootport or device and they might have
> > same vendor ID. It will cause the system hang issue if Altera PCIe is in
> > endpoint mode and work with other PCIe rootport that from other vendors.
> > So, add the rootport mode checking in link retrain fixup function.
> >
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > ---
> >  drivers/pci/host/pcie-altera.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> > index 58eef99..6477738 100644
> > --- a/drivers/pci/host/pcie-altera.c
> > +++ b/drivers/pci/host/pcie-altera.c
> > @@ -139,6 +139,9 @@ static void altera_pcie_retrain(struct pci_dev *dev)
> >       u16 linkcap, linkstat;
> >       struct altera_pcie *pcie = dev->bus->sysdata;
> >
> > +     if (!pci_is_root_bus(dev->bus))
> > +             return;
>
> It seems like it would be more direct to check for
> "pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT"?
Okay, will change in next version.

>
> >       if (!altera_pcie_link_is_up(pcie))
> >               return;
> >
> > --
> > 1.8.2.1
> >
