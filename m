Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758515AbeD0QOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Apr 2018 12:14:07 -0400
Message-ID: <1524845645.11756.56.camel@redhat.com>
Subject: Re: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
From: Doug Ledford <dledford@redhat.com>
To: Frederick Lawler <fred@fredlawl.com>, bhelgaas@google.com,
        mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        jgg@mellanox.com
Cc: linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Fri, 27 Apr 2018 12:14:05 -0400
In-Reply-To: <20180417002825.2737-1-fred@fredlawl.com>
References: <20180417002825.2737-1-fred@fredlawl.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IV0ITB1WZOn+rcw/pua5"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-IV0ITB1WZOn+rcw/pua5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-04-16 at 19:28 -0500, Frederick Lawler wrote:
> The IB/hfi1 driver uses custom macros to configure the target link speed.=
 Some=20
> macros were previously replaced, but not fully. This patch series address=
es the
> configuration inconsistencies by adding PCI_EXP_LNKCTL2_TLS* macros to PC=
I,
> and then use them in the following IB/hfi1 patch.
>=20
> V3:=20
> 	* PCI: Add PCI_EXP_LNKCTL2_TLS_* macros
> 	* Drop patch to use extract_speed() in do_pcie_gen3_transition()
> V2:
> 	* s/LINK/LNK
>=20
> Frederick Lawler (2):
>   PCI: Add PCI_EXP_LNKCTL2_TLS* macros
>   IB/hfi1: Replace custom hfi1 macros with PCIe macros
>=20
>  drivers/infiniband/hw/hfi1/pcie.c | 24 ++++++++----------------
>  include/uapi/linux/pci_regs.h     |  5 +++++
>  2 files changed, 13 insertions(+), 16 deletions(-)
>=20

Where do we stand on this series?  People talked about what the core
might be able to do, or how the driver might be able to do things a
little differently, but I didn't hear a clear conclusion on whether or
not to take this series as is (it seems to be a sensible cleanup and
possibly worthwhile even if we end up changing the hfi1 driver to do a
firmware updated followed by a device reset to get the same results).=20
And more importantly as far as I'm concerned, is this sitting on my
plate or on the PCI people's plate?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-IV0ITB1WZOn+rcw/pua5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlrjTE0ACgkQuCajMw5X
L920nQ/9HnvTulKU77y6S+x2oxlxENUxa1LVO5ZmThNjkE9BfROrB6W841dD28sJ
ep3EqG5Q/VCyMDlUXNeN4uN7jfNfrnqjlpHkgAC6HQs8k4OGwlapVSLom2L2VOj3
v9iBNmP0yoIeehrw1XSguJLJdUUIDF6WO7ec8S40LYgXGClCsISUO6wUn99THBI8
+AIj6aPY3K6jFZeYzvoDUiJEeSAyLM9uGWyY4GmrJxIWQsb6q/vkPhq3EeATUwdP
tF03gF/0s/4tfCNSg04ITv8O+gh9g8L9KHSN55ZQwPYNnMVuNXN9e3L2xKvwYkM+
l8Yr12tQRbGIFxSD1ws7LOLlfuFzFePM4DIl2VVbLXslDIIDmY3WGuZMSiYW7VLP
4qk2A8Oywh1fmRsaoXTY+mNi0Ex1DoD/v2yYFsJtMRfPDeanHcYUN18yvArePGgt
NLLM0l7iaSTtU98EzxgdUhZrnt4p6wM3Vd9ICm+YsDH+0U9Ean1gwKQGOQjn+NvH
m1ZsFr5s70DMi/4sycrKLw39Kq/MuVlMCEEZYC7aEjEIM9FHLbVN3HgDMtZi0DrH
7AT8M3+3LJ4W//mIU0mSqiQZac6ld5983Ayub4VkyzOn7ha+GMGjCELbtWdKueGG
TfT+tbB2ASSlcJKJOa6jrbzc60jj0HILU5SPLG3DhTXeiahIH7M=
=B8mw
-----END PGP SIGNATURE-----

--=-IV0ITB1WZOn+rcw/pua5--
