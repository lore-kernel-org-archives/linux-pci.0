Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45311 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964846AbeBMNvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 08:51:43 -0500
Date: Tue, 13 Feb 2018 14:51:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH V7 2/4] PCI: tegra: Add loadable kernel module support
Message-ID: <20180213135139.GA15842@ulmo>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
 <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
 <20180213130718.GE6764@ulmo>
 <eeab925c-3da4-38ae-2060-f77458abaaea@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <eeab925c-3da4-38ae-2060-f77458abaaea@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 06:48:49PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 13-Feb-18 6:37 PM, Thierry Reding wrote:
> > On Tue, Jan 30, 2018 at 10:54:09AM +0530, Manikanta Maddireddy wrote:
> >> Implement remove callback function for Tegra PCIe driver to add
> >> loadable kernel module support. Change PCI_TEGRA config to tristate to
> >> allow pci-tegra driver to be build as a module.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> Acked-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >> V2:
> >> * no change in this patch
> >> V3:
> >> * use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_=
init()
> >> V4:
> >> * no change in this patch
> >> V5:
> >> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> >> rebased on linux-next
> >> V6:
> >> * no change in this patch
> >> V7:
> >> * no change in this patch
> >>
> >>  drivers/pci/host/Kconfig     |  2 +-
> >>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
> >>  2 files changed, 32 insertions(+), 4 deletions(-)
> >=20
> > Trying to build this as a module I get a link failure because
> > irq_set_msi_desc() is not exported. I thought a patch to do that had
> > been part of an earlier version of this series. Has that not been merged
> > yet?
> >=20
> > Thierry
> >=20
> I got a review comment to use generic MSI model instead of deprecated API.
> source: https://patchwork.ozlabs.org/patch/841111/
>=20
> Also arm32 compilation will fail because of missing EXPORT of
> tegra_cpuidle_pcie_irqs_in_use()
> source: https://patchwork.ozlabs.org/patch/841119/
>=20
> I need to put some time to prepare patches for these two cases.
> Meanwhile I want to get the basic driver structure for LKM to be merged.
> I verified locally with these two symbols exported.

Okay, that's fine. However, you can't request these patches to be merged
if they will break builds. There are people that run automated builders
that will check random configurations, which is bound to eventually get
us a bug report about how this fails to build.

Perhaps in order to get loadable module support merged without these
issues you could omit the Kconfig change making this a tristate symbol.
That way we can get all the structural changes ready and you can work
on the necessary exports or MSI model patches so that we can eventually
flip the symbol to tristate.

By the way, if you do respin for the tristate change, do you mind taking
a look at the blank line changes for readability I mentioned earlier?

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqC7WgACgkQ3SOs138+
s6HeKA/5AfpqUtIa4iyaxxwRVq1sYrSM3mlt8KqhgZ39jshOSKqRl7X2pHAWtL0D
QgI6/UvdevGnBhPjegfpOF+M7UD9CGhbxejeZCaNqf1EMRqqYvOGsxQ6sCVUY4NS
olDdEW5Qk/mdNi0kEUTNkJf1UOzOv3SwqzasYmGlaC2kWKM0VCfN8GO2Cna3CFRi
Pqi20k7BCgcRuLdnnjpjIcytuzPsFzFL/ncF3opG6dyEHZruFKQj25kpJEJWeeu5
jooWLkF0F9svl7fjZ08JaVpuv0ilLEZR4kOJ0v+BTOEMBfmRDP1qs62qdsIhpBgg
d/8hfrrQXKQGQTaU8R+7HwLVPZFWC043Z25ELdds3xX2BWdjDBRWYGvBzkR3Ggzq
yvbf5otj+HuW0LPLOOg90mXZJxOR5hAPWdeXhhpQ41jOimrKU6p2RHjZlskpUOss
q3x3+06GVlxW/59LDARs/d5AtLeqjmd3QTK8Tmsu5l6DKYD1DM2pGebOvGnWfjME
WL+t2qDfQyG9axnAb7/GCbMpsr3VDN23t2gwsn9LHIRvyc9gCnKqzGIdIR8OJOVH
xzjXadFlQRvfCRnvZCKlyygD2OUzHGI/h4BL5Dii7KGhIJeDvCpQ/qJ6jmI2Lx1M
xj498mSCqYcQxw+mD09Qx7RH/7fTUfPctNSfSwwbWqyRX6f+eyA=
=+ltN
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
