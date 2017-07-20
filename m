Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49850 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965897AbdGTXqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 19:46:24 -0400
Date: Fri, 21 Jul 2017 00:46:13 +0100
From: Ben Hutchings <ben@decadent.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci@vger.kernel.org
Message-ID: <20170720234613.GF18698@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Subject: [PATCH] PCI: designware: Fix dw_handle_msi_irq() on 64-bit BE configs
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit 1b497e6493c4 "PCI: dwc: Fix uninitialized variable in
dw_handle_msi_irq()" fixed one problem for 64-bit architectures but
left another.  The find_next_bit() function assumes native ordering of
bits within each word (unsigned long), so passing a pointer to a u32
variable will cause it to scan the following 32 bits on a 64-bit
big-endian configuration.  Alternately it could result in an alignment
fault on some architectures.

Copy the status to an unsigned long variable before using
find_next_bit().

Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in ...")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
This is compile-tested only.

Ben.

 drivers/pci/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-=
designware-host.c
index d29c020da082..511fc9188f98 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -57,6 +57,7 @@ static struct irq_chip dw_msi_irq_chip =3D {
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	u32 val;
+	unsigned long bits;
 	int i, pos, irq;
 	irqreturn_t ret =3D IRQ_NONE;
=20
@@ -65,11 +66,11 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 				    &val);
 		if (!val)
 			continue;
+		bits =3D val;
=20
 		ret =3D IRQ_HANDLED;
 		pos =3D 0;
-		while ((pos =3D find_next_bit((unsigned long *) &val, 32,
-					    pos)) !=3D 32) {
+		while ((pos =3D find_next_bit(&bits, 32, pos)) !=3D 32) {
 			irq =3D irq_find_mapping(pp->irq_domain, i * 32 + pos);
 			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
 					    4, 1 << pos);

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWXFAxee/yOyVhhEJAQp7Xw/+I2vML77tresOROOS7My/1bwEXu5MVzOu
lVHOBK6H5INpANp4hJNxprpO5msgWAguom8Fw3A6kRu+yVKugkwl5BiMAq+MX0ju
U8VC6gidt8w+C2kW2x64phRq2russys85Ur3kd0OKWhXnKcoHLbKsUc7pYY6orSG
yWx3OvKg9FzFz8ZZvLdreiINVHxnUpAMpQfs3t6hEiA5x1Pc9Ka25JjxJNRBGLKt
QKozxsDplHQ17nJnwkeFyi7d/3vJiv1cLjgcUWpHkf2stT42lrM/bSnqf7M2pPOm
EBjEw20SwVbaQcSTiq4q81ZIPHiLV3WaqX9WUdtmi8sPOBhjV/HIfJ0GYhudlt+g
PQNKjkFPbH3JbLTYNV4Ndc2myUEGCahBEmhnxur4kOGrdyodDihiTu/CCo0JW/p3
4aWQT5gn34PO4JoB/941szn1S/g5agQ2LFyR8RoDUjeK2xC095dsLO++8ffzSsd4
4s1I+WQ0Cw0IElwF8RrUU9arfRgTQc6JNKaC/GOgesQnLSQzfqZz3jZjyzgk7CUN
8+tpj7Gbm3MQR/J5I98GG45r6ByGXVi1vo3NGrVhlDxFvmVzh5j5x+tNHKyib9VM
e0qChunwTHPlKq/uK2v9ZDinHNITSH0mk7egQYVJ3+U5AOY6hLwrAIMi1ka2yR5Y
6evo8jpA2mA=
=Zsuj
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
