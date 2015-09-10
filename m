Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33825 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbbIJNAT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 09:00:19 -0400
Date: Thu, 10 Sep 2015 15:00:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Global lock for PCI configuration accesses
Message-ID: <20150910130013.GD21542@ulmo.nvidia.com>
References: <20150909151126.GA1366@ulmo.nvidia.com>
 <CAErSpo5bAHywkbeBBOsGs3e5ih5rFpPuWBE-sA1pSuAxtNf_MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
In-Reply-To: <CAErSpo5bAHywkbeBBOsGs3e5ih5rFpPuWBE-sA1pSuAxtNf_MQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 12:27:38PM -0500, Bjorn Helgaas wrote:
> Hi Thierry,
>=20
> On Wed, Sep 9, 2015 at 10:11 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > Hi,
> >
> > There's currently an issue with PCI configuration space accesses on
> > Tegra. The PCI host controller driver's ->map_bus() implementation
> > remaps I/O memory on-demand to avoid potentially wasting 256 MiB of
> > virtual address space. The reason why this is done is because the
> > mapping isn't compatible with ECAM and the extended register number
> > is encoded in the uppermost 4 bits. This means that if we want to
> > address the configuration space for a single bus we already need to
> > map 256 MiB of memory, even if only 1 MiB is really used.
> >
> > tegra_pcie_bus_alloc() is therefore used to stitch together a 1 MiB
> > block of virtual addresses per bus made up of 16 64 KiB chunks each
> > so that only what's really needed is mapped.
> >
> > That function gets called the first time a PCI configuration access
> > is performed on a bus. The code calls functions that may sleep, and
> > that causes problems because the PCI configuration space accessors
> > are called with the global pci_lock held. This works in practice
> > but it blows up when lockdep is enabled.
> >
> > I remember coding up a fix for this using the ARM/PCI ->add_bus()
> > callbacks at one point and then forgetting about it. When I wanted
> > to revive that patch a little while ago I noticed that ->add_bus()
> > is now gone.
>=20
> Removed by 6cf00af0ae15 ("ARM/PCI: Remove unused pcibios_add_bus() and
> pcibios_remove_bus()"), I think.  That only removed the ARM
> implementation; the hook itself is still called, but on every arch
> except x86 and ia64, we use the default no-op implementation.  You
> could add it back, I guess.  It was removed because the MSI-related
> stuff that used to be in the ARM version is now done in a more generic
> way (see 49dcc01a9ff2 ("ARM/PCI: Save MSI controller in
> pci_sys_data")).
>=20
> > What I'm asking myself now is how to fix this. I suppose it'd be
> > possible to bring back ->add_bus(), though I suspect there were good
> > reasons to remove it (portability?).
>=20
> > Another possible fix would be
> > to get rid of the spinlock protecting these accesses. It seems to me
> > like it's not really necessary in the majority of cases. For drivers
> > that do a simple readl() or writel() on some memory-mapped I/O the
> > lock doesn't protect anything.
>=20
> I've wondered about removing pci_lock, too.  It seems like it could be
> removed in principle, but it would be a lot of work to audit
> everything.  Probably more work than you want to do just to fix Tegra
> :)

Thinking more about this, I'm not sure removing the lock would improve
the situation much. It seems like everything assumes that accesses to
PCI configuration space can be done in interrupt context, so what we do
on Tegra wouldn't be valid anyway.

I'm not sure if that's a reasonable assumption though. If it isn't then
removing the lock (or pushing it down into drivers as necessary) might
be the right thing to do.

> > Then again, there are a lot of pci_ops implementations in the tree,
> > and simply removing the global lock seems like it'd have a good chance
> > of breaking things for somebody.
> >
> > So short of auditing all pci_ops implementations and pushing the lock
> > down into drivers, does anyone have any good ideas on how to fix this?
>=20
> The 32-bit version of pci_mmcfg_read() uses fixmap to map the page it
> needs on-demand.  Could you do something similar, i.e., allocate the
> virtual space (which I assume is the part that might sleep), then
> redirect the virt-to-phys mapping while holding the lock?

I hadn't known about fixmap yet, but unfortunately I don't think that
would work in this case. In particular we'd need to map 256 MiB in order
to address the configuration space of a single device. Well, if we do
the mapping directly in the configuration space accessor we could map
a single 64 KiB chunk at a time, depending upon which register is being
accesses. That's still quite a lot of code that would be running for
every single configuration space access.

Moreover this is really only a problem that happens during enumeration.
After enumeration completes the configuration space address ranges for
each bus will have been allocated and subsequent accesses would no
longer execute the slow paths.

Given that and the assumption that PCI configuration space might be
accessed from interrupt context it seems like a more suitable option to
add back in some way of calling into the driver everytime a new bus gets
created. I guess we could even reuse ->map_bus(), but it might be better
to add a ->add_bus() to struct pci_ops to more clearly separate the slow
=66rom the fast path.

Any objections to adding ->add_bus() to struct pci_ops? That does have
the benefit of being more portable than adding back the pcibios hooks
that were previously removed.

Thierry

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV8X7bAAoJEN0jrNd/PrOhok4P/R6y37WPfluM5+ALsli1fGJG
tKyukXQ3l7XGKfUfHm54Qgi0W7c51EcpoF473yyVdyb1RdXc8NJSAhIYPawFztQb
lcG+AMozF1dXqFWdLf2GWIyxfoJqSyf5ITFG8vgQpgcur/4JcpsLBa353DMU9FN/
OFPx4HfKhj5sxtCPsxIC+d/yGgRpEjKZGtA4NnkulIsq8N3zdEOdTUJHFLo/ptpe
CdJkxqA09jAMjhdeGeNg9odeGfuAj3wkUvxOI38vYZ9fvJcNHWRHTomVF1YqQdoH
FVzjQKOGRooCUeITQ6dpCMbZCPaE2+iN+kLyC63IeDWzO5CAY7SMziHDGLFu7lRA
e0rQGLcIIxEYHbwGi/D8qW/8ZQGR63M/W7TiSJYP3fo18/xmT+56SV7ehFPISv1q
fTGvPYCAySk6T+ONdU72fX67Zi2jdXpIm+4vid8MHftd6Uy0z7vTrTIWxWrwsAXE
LCqUtycZpISCjhqrEwHYnlylqXFZqXzXlT7IGEn6ulpv0TJRbKoEZNy2houekn1W
SUF5ZdSyoEmYgZKU3CXsFkiWta+fBleHG1ltE3c3kGwMAfqKNVjP4GGpNuG/lwqE
3bSBkwkEKDFTwya7ZdN736I8YdKq2epTbqUdGG69LEI6pGFqs3K5bJtcQwZ49BAs
cVh4lUjMQbui6stRYRWV
=FSOH
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
