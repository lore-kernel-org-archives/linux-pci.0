Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33570 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeCNMNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 08:13:18 -0400
Date: Wed, 14 Mar 2018 13:13:14 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: tegra: add MSI dependency
Message-ID: <20180314121314.GE8564@ulmo>
References: <20180313115218.2246372-1-arnd@arndb.de>
 <20180314114515.GC8564@ulmo>
 <CAK8P3a3Wr8FNRP4ZYDGk9OL+=0w--pzRX=R6ye_+6nCtnHGVjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
In-Reply-To: <CAK8P3a3Wr8FNRP4ZYDGk9OL+=0w--pzRX=R6ye_+6nCtnHGVjg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 01:06:11PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 14, 2018 at 12:45 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Tue, Mar 13, 2018 at 12:52:05PM +0100, Arnd Bergmann wrote:
> >> Building the tegra PCIe host driver without MSI results in a link
> >> failure:
> >>
> >> drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci=
_msi_unmask_irq'
> >> drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci=
_msi_mask_irq'
> >>
> >> This adds the same dependency that everyone else uses.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  drivers/pci/host/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> > I'm slightly concerned about the dependency. Not that I doubt its
> > correctness, but because it could mean that PCI_TEGRA is not visible in
> > the default configuration. The only reason why it is currently visible
> > is because PCI_MSI is selected by some symbols that also happen to be
> > enabled. However, what if at some point those symbols are disabled or
> > removed?
> >
> > Some architectures make sure that PCI_MSI is enabled by selecting it,
> > but that's risky, isn't it, because PCI_MSI is user-visible and could
> > therefore easily lead to conflicts.
> >
> > Enabling PCI_MSI in the arm64 defconfig would solve the issue and is
> > good enough for me. I've got a couple of changes to that defconfig in
> > the Tegra tree for v4.17-rc1, I can add a patch to enable PCI_MSI.
> >
> > Unless there are any objections.
>=20
> I looked at it again and found that this on ARM64, PCI_MSI is always
> selected indirectly by ARM_GIC&&PCI, so there is no problem.
>=20
> The build failure must have been on 32-bit ARM.

Okay, I had assumed that ARM_GIC_V2M (which selects PCI_MSI) was user-
visible and hence could be disabled. But it's not, and always enabled on
ARM64. On 32-bit we already explicitly enable PCI_MSI via the default
configurations.

I withdraw my concerns. I see that Lorenzo already applied the patch, so
just for the record:

Acked-by: Thierry Reding <treding@nvidia.com>

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpEdoACgkQ3SOs138+
s6F0yA//aupfcFSSBQFcQPwsoeUkqXMoTYfebuIV3TSMq/GUOv1zpfqf0duv9wkE
KEJ2avzAX6vcG7AFMi2QsottaskHko0fpNXN0a919lR1uCMxkrjDDtpwrDVyCQHN
Mmxy2wHqw2qjKCl0JmTOQf9QVVRiljYDt5vBSpsFpxUzXMzuipjKkfJsV6OrUnzl
+/oN1XrsNP0qs/6rShLgObFdkNXBo7MejihrHiLwbzB7z/XGZ2krLrGNquWBY3Ff
qt8CKiSSCDEzKtfzAMFP351z/W6KOrlHMhfBuiWCh0D32FqRfhx7mW+7Mpegqcp2
tA6aSNqg+bY705Snk179K6J2uwIcPEiHTETpic0vxbwwliX2+NnrUeF/rkgS6m0o
k9IDl7i1Hfi1/aqLNsgffsdpr1x+3K+fWCbcT/WbVR4h5Vaa/1AFC2rdusXmemFT
1ymE1/IKNn2iU6avwINcfGJBHO6lqS5J08/k4U5AKq52rrO8jQvP3302GABcu6cK
CLSEItLS8oB77h7RSCtPvyNDD6dFOXIRpGbpzQIF1A/dz0GdKgEYJg1rxj6N9pRg
X/q8P8jACEQyWNZVx/wNV6GTDEbdPsPKkohzegAJ3H/rZkrroEdW7IKBokOUf5E7
e5hKV5+w71g0RpFcTYLvKAqUCT9pN6brBTs4XDCgfgMxq20mgiM=
=+dWC
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
