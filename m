Return-Path: <SRS0=yVq1=HQ=redhat.com=dledford@kernel.org>
Return-Path: <SRS0=yVq1=HQ=redhat.com=dledford@kernel.org>
Message-ID: <1524853107.11756.70.camel@redhat.com>
Subject: Re: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
From: Doug Ledford <dledford@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Frederick Lawler <fred@fredlawl.com>
Cc: bhelgaas@google.com, mike.marciniszyn@intel.com,
	dennis.dalessandro@intel.com, jgg@mellanox.com, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org
Date: Fri, 27 Apr 2018 14:18:27 -0400
In-Reply-To: <20180427175850.GC8199@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417002825.2737-1-fred@fredlawl.com>
	 <20180427175850.GC8199@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-K+GlL5kgEkcHcr30Pc+H"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


--=-K+GlL5kgEkcHcr30Pc+H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-04-27 at 12:58 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 16, 2018 at 07:28:23PM -0500, Frederick Lawler wrote:
> > The IB/hfi1 driver uses custom macros to configure the target link spee=
d. Some=20
> > macros were previously replaced, but not fully. This patch series addre=
sses the
> > configuration inconsistencies by adding PCI_EXP_LNKCTL2_TLS* macros to =
PCI,
> > and then use them in the following IB/hfi1 patch.
> >=20
> > V3:=20
> > 	* PCI: Add PCI_EXP_LNKCTL2_TLS_* macros
> > 	* Drop patch to use extract_speed() in do_pcie_gen3_transition()
> > V2:
> > 	* s/LINK/LNK
> >=20
> > Frederick Lawler (2):
> >   PCI: Add PCI_EXP_LNKCTL2_TLS* macros
> >   IB/hfi1: Replace custom hfi1 macros with PCIe macros
> >=20
> >  drivers/infiniband/hw/hfi1/pcie.c | 24 ++++++++----------------
> >  include/uapi/linux/pci_regs.h     |  5 +++++
> >  2 files changed, 13 insertions(+), 16 deletions(-)
>=20
> I applied these, with Michael's reviewed-by on the second, to
> pci/misc for v4.18, thanks!
>=20
> Ideally we could pull some of this link speed management code into the
> PCI core someday, but I think these patches are useful as-is.
>=20
> Oh, I did s/PCI_EXP_LNKCTL2_TLS_2_5GB/PCI_EXP_LNKCTL2_TLS_2_5GT/
> because the link speeds are actually defined in terms of GT/s, not
> GB/s.

Thanks :-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-K+GlL5kgEkcHcr30Pc+H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlrjaXMACgkQuCajMw5X
L93HTRAAjlD8zxx05Rb0uuNK4Tbsks2Dpr8g1EqukysWGcWR8sBwR0BV6746v/x2
b42kdD8Y+cSrZGvgWrJcVqQqKjYsuaFE3lC4H3WY3Q7LuYtZ+x0mAiuh4x6wUvL/
AIfno2tWqK69AYDlw23QVgNC2EvrZsOfB2ZY5ItJjguHFzd+jEW2Oyyzgg8edDyJ
hjqk314X1w8kQE+HjCcowXpxjBAkPUxxB07VzsySlspUlMUZ97hzQcYP4gmWG2QH
IRmTvH56kky2Nr/thBistZP/dq0ImlljyDFaOn6KXSgH/MSkq7Z0Xw0ZezYViaY0
sbUkipB87r2mQulOojxkviDrcumECLmHw8MA4r1EtCfTYm3sm1T0maYxhweXLd9x
3HLLzGMH4mGYy5L4c7PbXbB1852GjJ/L0qkzoDWvs1MJlmnPLKieI2HN8zGNkMth
QYNKXwcFNCDADrj9a0oSNJzc50Hw8fffe2LGvIrDdqTQmkPwSKtrFNz0roiBW7Rk
lvotRWOHhY8Ad6fbidG15TzTsI9zwxNFHkTk7Ech6ORvm7HryGNoBesUESjPrccd
cZww9g2IYfEgD6UJ1SCznxxxBAMmVZjASuIIXquiD9Tygg3CZfunIpOKYfkzTgyJ
pu0NtFijJ1q7cn5anNW16mqeu44yBFHREZ4SCQY4mQrXn8jewbE=
=CvSQ
-----END PGP SIGNATURE-----

--=-K+GlL5kgEkcHcr30Pc+H--
