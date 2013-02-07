Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50046 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161052Ab3BGSoZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 13:44:25 -0500
Date: Thu, 7 Feb 2013 19:43:28 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207184328.GA2931@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org>
 <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
 <20130207112459.5f382ad4@skate>
 <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
 <20130207170020.289bac08@skate>
 <CAErSpo797rhH=xt2x7eqdu7Vwf43FXoXQVcypvHM8-54LRC0wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <CAErSpo797rhH=xt2x7eqdu7Vwf43FXoXQVcypvHM8-54LRC0wQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2013 at 11:08:45AM -0700, Bjorn Helgaas wrote:
> On Thu, Feb 7, 2013 at 9:00 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Dear Bjorn Helgaas,
> >
> > On Thu, 7 Feb 2013 08:46:06 -0700, Bjorn Helgaas wrote:
> >
> >> Can you post the entire dmesg log, ideally with CONFIG_PCI_DEBUG=3Dy?
> >> That should have more information about the enumeration process,
> >> including what we think the XHCI BARs are and the apertures leading to
> >> them.
> >
> > Sure, see below.
> >
> >> The PCI core assumes that we know the host bridge apertures up front,
> >> and I'm not sure that is true on your platform, so maybe we'll need
> >> some changes to accommodate that.
> >
> > In this hardware, we need to set up the address decoding windows. So
> > there shouldn't be any access to a PCI device memory or I/O region
> > until the addresses have been assigned in the PCI-to-PCI bridge.
>=20
> I think this is the path where the crash happens (this is the same as
> the backtrace you included below):
>=20
>     mvebu_pcie_scan_bus
>       pci_scan_root_bus
>         pci_create_root_bus
>         pci_scan_child_bus
>         pci_bus_add_devices
>           pci_bus_add_device
>             pci_fixup_device(pci_fixup_final)
>               quirk_usb_early_handoff           # pci_fixup_final
>                 quirk_usb_handoff_xhci
>=20
> The problem is that we haven't assigned resources anywhere.  Normally
> this is done by pci_bus_assign_resources() or
> pci_assign_unassigned_bus_resources(), but I don't think there's
> anything in the path above that does this.
>=20
> This is not really a problem in your code; it's a generic PCI core
> problem.  pci_scan_root_bus() does everything including creating the
> root bus, scanning it, and adding the devices we find.  At the point
> where we add a device (pci_bus_add_device()), it should be ready for a
> driver to claim it -- all resource assignment should already be done.
>=20
> I don't think it's completely trivial to fix this in the PCI core yet
> (but we're moving in that direction) because we have some boot-time
> ordering issues, e.g., x86 scans the root buses before we know about
> the address space consumed by ACPI devices, so we can't just assign
> the resources when we scan the bus.
>=20
> I think the way you'll have to fix this in the meantime is to use
> pci_create_root_bus() directly so you can do things in this sequence:
>=20
>   pci_create_root_bus
>   pci_scan_child_bus
>   pci_bus_assign_resources
>   pci_bus_add_devices

The last two are already done by ARM's pci_common_init(). On Tegra I've
got by having a custom .scan_bus() implementation that does the first
two. Back when I used the pci_scan_root_bus() we were seeing some issues
with resource conflicts and such and there was a similar discussion at
that time.

Thomas, have you tried using the same .scan_bus() that I use on Tegra?
It should be easy to port it to Marvell, the only Tegra-specific bit is
how to get at the struct tegra_pcie.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRE/XQAAoJEN0jrNd/PrOh9/AP/3TM7KUZdEpIgr/vaNQ6uixL
j+uspg3i/ad6WI5gZjgOA/VjPm2KNhFmd8LgV47CuYnz5JQgeag4uwItxBCSInMX
TLqNKvrsiQeHRD8jpdPc66fQwtXiDLamHuBLBjdBGYo4RfunNZZNVVCcIqUZi1rR
qDsXUAgexXWVv0KtMML9qsM+sALLpbefJywxMMPbXJ6KFZGdsS29wJtpACl/YhIu
x5fcq3cuBoDdd9WHtx2jSpi5seudgcj1wsYrLdpMU3+/rsELohtyvn50xbmGyg00
ppKAjwzJuNyO3TK0QaH/HSYW76ryUsMAPpYo8TcExbk8mpVzWkmE7gDuhwA5husf
xEePg7a1GxHxHWX3vdEt+hZ3gNi2g7gaAR3Wd++BfYFHl4eRTiHk7yA/NetPRTvX
K1ydmngWO+5YWcyHSIdJ66S1NwwOQax2n9i62pPJK2movGte4rvoF5HYxEdxLpYs
PRZqFHa0HB+bmpMdBT3lc3J5dgfc9+DLa6vqOTcthruyPcTyj5In8rXGsJxUQ4Ny
vqeg3djQMrMjfbFhIPdHLScT1A0N3O3rxnaZdIku4vcQsr91s1DN9iFVdhMzFY9N
3BYonMdAhlTx+YRyku9afdLXUkM1U1FE6Ku+mfVKPD62MYmSS6h+87FdCo0y2sHf
nxmSMq3uskYgH5mU0RE9
=PzZT
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
