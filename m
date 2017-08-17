Return-Path: <SRS0=lEde=7T=imgtec.com=Paul.Burton@kernel.org>
Return-Path: <SRS0=lEde=7T=imgtec.com=Paul.Burton@kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 0/8] PCI: INTx interrupt fixes & cleanup
Date: Thu, 17 Aug 2017 15:38:31 -0700
Message-ID: <19026645.XfjebMKqMa@np-p-burton>
In-Reply-To: <20170815213315.GM32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com> <20170815213315.GM32525@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2409878.PqcINdASTO";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--nextPart2409878.PqcINdASTO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bjorn,

On Tuesday, 15 August 2017 14:33:15 PDT Bjorn Helgaas wrote:
> On Tue, Aug 15, 2017 at 12:02:15PM -0700, Paul Burton wrote:
> > This series fixes our handling of the PCI INTD interrupts in both Xilinx
> > PCIe controller drivers, and cleans up a wasted IRQ domain entry in the
> > Altera PCIe controller driver. It also adds a common PCI_INTX_NUM
> > definition which all relevant drivers under drivers/pci/host/ are
> > adjusted to make use of.
> > 
> > - Patch 1 moves enum pci_interrupt_pin to somewhere we can use it from
> > 
> >   PCI host code.
> > 
> > - Patch 2 introduces a helper function to translate 1-4 INTx ranges into
> > 
> >   the 0-3 range, by using it as a struct irq_domain's xlate callback.
> > 
> > - Patches 3 adjusts the Altera driver to avoid wasting an IRQ domain
> > 
> >   entry.
> > 
> > - Patches 4 & 5 fix the INTD interrupt for Xilinx PCIe drivers.
> > 
> > - Patches 6-8 make use of PCI_NUM_INTX to replace custom definitions or
> > 
> >   magic numbers in drivers.
> > 
> > The series versioning is continuing on from that of my "PCI: xilinx:
> > Fixes, optimisation & MIPS support" series which some of the earlier
> > patches were originally a part of, in order to prevent individual
> > patches from jumping backwards in versioning.
> > 
> > Applies atop v4.13-rc5.
> > 
> > Paul Burton (8):
> >   PCI: Move enum pci_interrupt_pin to linux/pci.h
> >   PCI: Introduce pci_irqd_intx_xlate()
> >   PCI: altera: Use size=4 IRQ domain for legacy INTx
> >   PCI: xilinx: Translate INTx range to hwirqs 0-3
> >   PCI: xilinx-nwl: Translate INTx range to hwirqs 0-3
> >   PCI: aardvark: Use PCI_NUM_INTX
> >   PCI: ftpci100: Use PCI_NUM_INTX
> >   PCI: rockchip: Use PCI_NUM_INTX
> >  
> >  drivers/pci/host/pci-aardvark.c    |  5 ++--
> >  drivers/pci/host/pci-ftpci100.c    |  2 +-
> >  drivers/pci/host/pcie-altera.c     |  9 +++----
> >  drivers/pci/host/pcie-rockchip.c   |  2 +-
> >  drivers/pci/host/pcie-xilinx-nwl.c |  9 +++----
> >  drivers/pci/host/pcie-xilinx.c     |  7 ++---
> >  include/linux/pci-epf.h            |  9 +------
> >  include/linux/pci.h                | 54
> >  ++++++++++++++++++++++++++++++++++++++ 8 files changed, 71
> >  insertions(+), 26 deletions(-)
> 
> Thanks for updating these, Paul.  I applied them on pci/irq-intx and the
> individual driver branches.  I added Thomas' reviewed-by for Aardvark, and
> I expect we'll get more for the others.

Great, thanks :)

> I found two more places we can use PCI_NUM_INTX; I'll post those in a
> minute.

Both look good to me - I'd only looked under drivers/pci/host/ so drivers/pci/
dwc/ had escaped my gaze.

> Thanks for all your work on this!

You're welcome, thanks for merging.

Paul
--nextPart2409878.PqcINdASTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmWGucACgkQgiDZ+mk8
HGV2ng//dQeWYa0228UEOEHRyZz0Xl0Svc/P/lq5DL05U1skP+X6NcrmthlGdWst
TR1HtVtgMsWwIpbdc3E3KscZr6jZuAol+oBf/aXQNr6JfXFYSTd/PbsunLfT4qXF
0tMEOVm1irTHQCU82ooNgz6Nof5GKlHBSk3SrKu0fxxzKh6H+B8T71WrxFky3NN3
P6NOa3iX2G+7ta82MH5CRVtJRQoRwcTuD6yiRwW5XhtmZzCELvwnB6XHX0YkDrgE
wlLI+kwTuphiYB6hVtPD/XFRqKTHSgFvbwlH4DoC/t39zrwXHI5gwyY9CtjxT3RK
inS0xpqD06VQTXxLb1mmY7GPnk+ikDvPdqM4ap303q/E+0CL5psHoEbhvpl6Y38B
dU+WqI9+TDMUS1goXS8q0aEIzsDTQdOo7yAVUL+U6uYUvMGJAJD9Rm8Ztn4yb41A
EoPSvi2fSXsBj4E+ArbKC2xM5fZkwW+aOC3Cdwv8m58TrpWSp9z2F5+4ojPm3DAv
/g45g2tXgJVKcJejyfMeAQo8d7Q++D5jayJGxmf6GVarsQFXfEgGluGY+HcP7lP3
O0USgbkk3osRrvdAVx2q0ADY9HDlVdiKPzWtIF2Hd5M95zanu0aNv2OUFUAhzfWQ
5H8usISvZiyEpsdvmMjG7HWj181en/p+1Kr5Saf38v43bdM4cHY=
=FIID
-----END PGP SIGNATURE-----

--nextPart2409878.PqcINdASTO--
