Return-Path: <SRS0=qyTT=4C=intel.com=jeffrey.t.kirsher@kernel.org>
Return-Path: <SRS0=qyTT=4C=intel.com=jeffrey.t.kirsher@kernel.org>
Message-ID: <1493244625.2124.6.camel@intel.com>
Subject: Re: [PATCH 5/7] IB/hfi1: use pcie_flr instead of duplicating it
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Byczkowski, Jakub" <jakub.byczkowski@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Benedetto, Salvatore" <salvatore.benedetto@intel.com>, "Marciniszyn, Mike"
 <mike.marciniszyn@intel.com>, "Dalessandro, Dennis"
 <dennis.dalessandro@intel.com>, Derek Chickles
 <derek.chickles@caviumnetworks.com>, Satanand Burla
 <satananda.burla@caviumnetworks.com>, Felix Manlunas
 <felix.manlunas@caviumnetworks.com>, Raghu Vatsavayi
 <raghu.vatsavayi@caviumnetworks.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, qat-linux <qat-linux@intel.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 26 Apr 2017 15:10:25 -0700
In-Reply-To: <20170425193955.GC29024@bhelgaas-glaptop.roam.corp.google.com>
References: <20170414191131.14286-1-hch@lst.de>
	 <20170414191131.14286-6-hch@lst.de>
	 <A33E225544E47D4DB5713032774B132783960382@irsmsx105.ger.corp.intel.com>
	 <20170424143507.GA28812@lst.de>
	 <20170425193955.GC29024@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jIG6ReGmICyr8JtIFsUq"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


--=-jIG6ReGmICyr8JtIFsUq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-04-25 at 14:39 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 24, 2017 at 04:35:07PM +0200, Christoph Hellwig wrote:
> > On Mon, Apr 24, 2017 at 02:16:31PM +0000, Byczkowski, Jakub wrote:
> > > Tested-by: Jakub Byczkowski <jakub.byczkowski@intel.com>
> >=20
> > Are you (and Doug) ok with queueing this up in the PCI tree?
>=20
> Applied this with Jakub's tested-by and Doug's ack to pci/virtualization
> for v4.12.
>=20
> This still leaves these:
>=20
> =C2=A0 [PATCH 4/7] ixgbe: use pcie_flr instead of duplicating it
> =C2=A0 [PATCH 6/7] crypto: qat: use pcie_flr instead of duplicating it
> =C2=A0 [PATCH 7/7] liquidio: use pcie_flr instead of duplicating it
>=20
> I haven't seen any response to 4 and 6.=C2=A0 Felix reported an unused
> variable in 7.=C2=A0 Let me know if you'd like me to do anything with
> these.

Just provided my ACK for ixgbe patch.
--=-jIG6ReGmICyr8JtIFsUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJZARrRAAoJEOVv75VaS+3OlRoQAI8Y9SG9qJ9Z8GcmZX02HTc7
XngO312dcy+PZU1gLFqOXrBXjoXf0cWmvwNSHCzLFOvm5DI7qCpQ701yweewHWLC
D6x3JoeAeHJTCAvi2wSopOxMt7XZA4gJZSbvlvF+qlPt7D3qwq/AFOEMNasjR2qd
QOpJDvksHvIPMEW26oXqQuXpy+uIsEcEwzt8F1HgXg/EWP1KRRCCOd6aWR7Qa3yx
8ZMH9cCpT/C00hkK66XoUsAODF8P9aMLyZeuID6r+xqAYoG8ySSzilyt1DBUcZzM
/AUSxWhRM1rgg1/mxXVyzXU7ectAKv3gTjOWD9dgFzWyhQGqqhcyYWq1+WAy83gl
Ttu/aTV65BksmEA+l+QfYa5M+IH+xKPEOztxkeBk66V4nAFjXsvG5gcosAA8e8I3
W2wMLwaJuvIuSfUo1aol2oNp+UwDNIbToYTr+2Ah9KeH1uU+QW9ThPUkbxBOtJjh
LhYtVP41kbXhfuPKUUApW9f0uTNegC6TDXAkwmjyDyeAm9qJ0iOnBhBzx1WquzFA
VQx983bwWAXgiY36qh1KlKpuq4wRrkI2wFGavVbWz1qqthXQ+Q6tM4dHOLfRCIKs
T15dhdfQQX9yjulTSsQzmbRG1O/gvwHRIxfb8duD6UBnMi0FGRTTkzyuQTndNr6P
XUITPPdTnamXn1nAp/kr
=QB8C
-----END PGP SIGNATURE-----

--=-jIG6ReGmICyr8JtIFsUq--
