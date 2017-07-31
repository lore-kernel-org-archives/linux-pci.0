Return-Path: <SRS0=FGaw=7C=imgtec.com=Paul.Burton@kernel.org>
Return-Path: <SRS0=FGaw=7C=imgtec.com=Paul.Burton@kernel.org>
From: Paul Burton <paul.burton@imgtec.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Michal Simek
	<michal.simek@xilinx.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann
	<soren.brinkmann@xilinx.com>, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] PCI: xilinx: Remove platform/architecture restrictions
Date: Mon, 31 Jul 2017 16:19:13 -0700
Message-ID: <16692965.isATtC65hJ@np-p-burton>
In-Reply-To: <20170731225822.GB19800@bhelgaas-glaptop.roam.corp.google.com>
References: <1500856777-23383-1-git-send-email-linux@roeck-us.net> <3882569.bb2rKKAOIY@np-p-burton> <20170731225822.GB19800@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4491371.A6Tbg42sac";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-pci.vger.kernel.org>

--nextPart4491371.A6Tbg42sac
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Bjorn,

On Monday, 31 July 2017 15:58:22 PDT Bjorn Helgaas wrote:
> On Mon, Jul 24, 2017 at 11:49:22AM +0100, Paul Burton wrote:
> > Hi Guenter & all,
> > 
> > On Monday, 24 July 2017 01:39:37 BST Guenter Roeck wrote:
> > > The MIPS Boston board configuration tries to enable CONFIG_PCIE_XILINX.
> > > That doesn't work since PCIE_XILINX depends on ARCH_ZYNQ || MICROBLAZE.
> > > Remove that restriction.
> > 
> > I'd prefer that this patch does not go in standalone. The intent for the
> > MIPS Boston board is that this driver is enabled for MIPS by this patch:
> > 
> > https://patchwork.kernel.org/patch/9794361/
> > 
> > But not until after earlier patches in that series fix issues with the
> > driver:
> > 
> > https://patchwork.kernel.org/patch/9794355/
> > https://patchwork.kernel.org/patch/9794357/
> > https://patchwork.kernel.org/patch/9794359/
> > 
> > That has been held up by disagreement about whether the driver should be
> > using 0-3 or 1-4 for hardware IRQ numbers, sadly, despite the driver
> > already being in tree & clearly broken, and my series not changing which
> > the driver uses...
>
> It's true that your v5 series only changes xilinx from using hwirq 0-3
> to 0-4 (with 0 being unused in both cases, and the addition of 4
> fixing the "INTD doesn't work" bug).

That isn't true - the xilinx-pcie driver already uses 1-4, and my change 
simply prevents it from hitting a WARN() in the IRQ code when doing so.

> However, I *would* like to see this issue cleaned up consistently
> across all our drivers.  I mooted a couple ideas in [1], but nobody
> seemed interested.  If I merged your series as-is, there would be even
> less interest.

I've been travelling & haven't had time to look at any reworks as of yet, but 
I do think the driver as-is is clearly broken & my fix is a pretty obvious 
one, even if you would like the driver(s) to improve further in future.

Thanks,
    Paul

> [1]
> http://lkml.kernel.org/r/20170712221455.GJ14614@bhelgaas-glaptop.roam.corp.
> google.com
> > In any case, I don't really mind if people would rather remove the
> > architecture restrictions than just add MIPS, but I'd prefer this doesn't
> > go in until the rest of my series since without at least patch 1 of my
> > seres this will lead to various WARN()s on Boston boards.
> > 
> > Thanks,
> > 
> >     Paul
> > > 
> > > Cc: Paul Burton <paul.burton@imgtec.com>
> > > Cc: James Hogan <james.hogan@imgtec.com>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > 
> > >  drivers/pci/host/Kconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > > index 89d61c2cbfaa..ed905a5401c3 100644
> > > --- a/drivers/pci/host/Kconfig
> > > +++ b/drivers/pci/host/Kconfig
> > > @@ -71,7 +71,6 @@ config PCI_HOST_GENERIC
> > > 
> > >  config PCIE_XILINX
> > >  
> > >  	bool "Xilinx AXI PCIe host bridge support"
> > > 
> > > -	depends on ARCH_ZYNQ || MICROBLAZE
> > > 
> > >  	help
> > >  	
> > >  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
> > >  	  Host Bridge driver.


--nextPart4491371.A6Tbg42sac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAll/uvEACgkQgiDZ+mk8
HGWGCBAAoabl4urUSAghY4naQng1+KjTXYiAQiXFQgpGtijl/YNpcdGHJlffMhRQ
14YLyUQ61rrV9FW4II8sDpoUGo5j9wv2GOzG7CIoEPEMvrmFqfH1JA/tV/dhDcvt
DxVh8uYXsvwRjOOxrzLB0mb/yZUsVegphI7sMGs7R8qBzsbpyYptTonRqieOcWrW
tQ2rzEpYEKNWQHooecTdfEjhKqI0t3/sTs5XyCIFCjJdpthwEcucacW4YDa2kPj0
kNElfZ3G83NiRgJ7b7cy1FHc1hKcNt3E5kdKx4SGrk0vACyvSOJ9WWcBkmL7aJP4
ahWpk2nXmPMRhe3vBsNfjPkTj74wfbMjTXKbDd21ipg8xE0pZXgNyjB7MhvU+/jF
5osYlHZBO8PvXMDE0+wPsD4+R64gz9PVUa4JrWVFv+IlW6rYYl7cqSvR3LuOWxaN
vVdOOrSBCjPvft3FjxCajASx29Jjc9sIRvbk6KW5gYUfFJwC9lsUeOa7DpPNE/9w
mvt76n7pS+0bs8hERz6RzGpWkVVLw8ZOOwGyXF110zYcVpqHwAnvbf/HTYwcrROc
NbOIxWh+pTrsTF7RgSuM7O8mIFI+uKTDFOguy3gvNAd/E6Pm4UhXxLDBHnYvgGOH
iSdLL33rc+Vu6AsDht4cOro8QPtDS0tzmHHD41qcjAf425DuABw=
=J1FC
-----END PGP SIGNATURE-----

--nextPart4491371.A6Tbg42sac--
