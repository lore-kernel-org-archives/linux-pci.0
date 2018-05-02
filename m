Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 2 May 2018 12:23:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Subject: Re: LS1043A : "synchronous abort" at boot due to PCI config read
Message-ID: <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
References: <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
 <5AE317AB.4020404@kontron.com>
 <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
 <5AE75809.30701@kontron.com> <5AE9B5BB.2080003@kontron.com>
 <20180502132501.GE11698@bhelgaas-glaptop.roam.corp.google.com>
 <5AE9C1AB.8020403@kontron.com>
MIME-Version: 1.0
In-Reply-To: <5AE9C1AB.8020403@kontron.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2018 at 01:48:27PM +0000, Gilles Buloz wrote:
> Le 02/05/2018 15:26, Bjorn Helgaas a =E9crit :
> > On Wed, May 02, 2018 at 12:57:31PM +0000, Gilles Buloz wrote:
> >> Hi Bjorn,
> >> See attached patch (tested ok this morning)
> > This looks good.  Minor comments below.
> >
> > I can fix minor things myself, but I do need a signed-off-by from you
> > before applying (see
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst)
> >
> > Please add a changelog, too, and include the patch inline (as opposed
> > to as an attachment) if possible.
> >
> >> --- include/linux/pci.h.orig	2018-03-26 16:51:18.050000000 +0000
> >> +++ include/linux/pci.h	2018-04-30 18:29:14.140000000 +0000
> >> @@ -193,6 +193,7 @@
> >>   enum pci_bus_flags {
> >>   	PCI_BUS_FLAGS_NO_MSI   =3D (__force pci_bus_flags_t) 1,
> >>   	PCI_BUS_FLAGS_NO_MMRBC =3D (__force pci_bus_flags_t) 2,
> >> +	PCI_BUS_FLAGS_NO_EXTCFG =3D (__force pci_bus_flags_t) 4,
> > Best if you can rebase this to v4.17-rc1.
> >
> >>   };
> >>   =

> >>   /* These values come from the PCI Express Spec */
> >> --- drivers/pci/probe.c.orig	2018-01-22 09:29:52.000000000 +0000
> >> +++ drivers/pci/probe.c	2018-05-02 13:44:35.530000000 +0000
> >> @@ -664,6 +664,23 @@
> >>   	}
> >>   }
> >>   =

> >> +static bool pci_bridge_child_bus_ext_cfg_accessible(struct pci_dev *b=
ridge)
> >> +{
> >> +	int pos;
> >> +	u32 status;
> >> +
> >> +	if (!pci_is_pcie(bridge) || /* PCI/PCI bridge */
> >> +	    (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_PCIE_BRIDGE) || /* PC=
Ie/PCI bridge in forward mode */
> >> +	    (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE)) {  /* PC=
Ie/PCI bridge in reverse mode */
> >> +		pos =3D pci_find_capability(bridge, PCI_CAP_ID_PCIX);
> >> +		if (pos)
> >> +			pci_read_config_dword(bridge, pos + PCI_X_STATUS, &status);
> >> +		return pos && (status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ)=
);
> >> +	}
> > Please arrange this so everything fits in 80 columns.
> >
> > If you can split it into several simpler "if" statements rather
> > than one with a complicated expression, that would also be good.
> >
> >> +
> >> +	return true;
> >> +}
> >> +
> >>   static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
> >>   					   struct pci_dev *bridge, int busnr)
> >>   {
> >> @@ -725,6 +742,19 @@
> >>   	/* Create legacy_io and legacy_mem files for this bus */
> >>   	pci_create_legacy_files(child);
> >>   =

> >> +	/*
> >> +	 * if bus_flags inherited from parent bus do not already report lack=
 of extended config
> >> +	 * space support, check if supported by child bus by checking its pa=
rent bridge
> >> +	 */
> > Wrap to fit in 80 columns.
> >
> >> +	if (bridge && !(child->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)) {
> > The double negative makes this a little bit hard to read.  Maybe it
> > could be improved by reversing the sense of something?
> >
> >> +		if (!pci_bridge_child_bus_ext_cfg_accessible(bridge)) {
> >> +			child->bus_flags |=3D PCI_BUS_FLAGS_NO_EXTCFG;
> >> +			dev_info(&child->dev, "extended config space not accessible due to=
 parent bridge\n");
> > In v4.17-rc1, there's a pci_info() that should work here (instead of
> > dev_info()).
> >
> >> +		}
> >> +	} else {
> >> +		dev_info(&child->dev, "extended config space not accessible due to =
parent bus\n");
> >> +	}
> >> +
> >>   	return child;
> >>   }
> >>   =

> >> @@ -1084,6 +1114,9 @@
> >>   	u32 status;
> >>   	u16 class;
> >>   =

> >> +	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
> >> +		return PCI_CFG_SPACE_SIZE;
> >> +
> >>   	class =3D dev->class >> 8;
> >>   	if (class =3D=3D PCI_CLASS_BRIDGE_HOST)
> >>   		return pci_cfg_space_size_ext(dev);
> > .
> >
> OK I'm going to learn about signing (sorry this is my first
> "official" patch).

Great, welcome!  The signoff is no big deal -- it's just plain text
(no crypto signature or anything) and it's basically just an assertion
that you wrote it and have the right to contribute it.

> I'll download kernel v4.17-rc1 and write the patch for it; however I
> hope I'll be able to test it on my platform without the freescale
> addons I have on 4.1.35, because I don't want to send an untested
> patch.

Don't worry too much about the 4.1 vs 4.17 issue.  If you tested it
on 4.1.35 that should be fine.

> For "if (bridge && !(child->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG))",
> I don't understand what you mean with "double negative", as I only
> have one "!"

The "!" and the "NO" part of "NO_EXTCFG" is what I meant.  E.g., maybe
the flag could be something like "COMPAT_CFG_ONLY" so there's no
negation in the test at all.

> Do you think it's worth keeping the two dev_info() ? The code would
> be smaller without; however this may help to have it for debug.
> Maybe use _dbg instead of _info ?

Probably one pci_info() is enough as a clue that extended config space =

isn't available below this point in the hierarchy.

I personally don't like the _dbg() version because it's so complicated
to figure out when the output is enabled.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
