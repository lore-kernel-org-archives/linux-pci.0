Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52124 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511AbcAMNyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Jan 2016 08:54:36 -0500
Date: Wed, 13 Jan 2016 14:54:26 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	aik@ozlabs.ru, linux-pci@vger.kernel.org,
	panto@antoniou-consulting.com, grant.likely@linaro.org,
	robherring2@gmail.com, bhelgaas@google.com, frowand.list@gmail.com
Subject: Re: [v7,49/50] drivers/of: Export OF changeset functions
Message-ID: <20160113135426.GA29030@katana>
References: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2015 at 12:12:49AM +1100, Gavin Shan wrote:
> The PowerNV PCI hotplug driver is going to use the OF changeset
> to manage the changed device sub-tree. This exports those OF
> changeset functions for that.
>=20
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Rob Herring <robh@kernel.org>

I needed something like this, too [1] and rebased my series on top of
this patch. So:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks,

   Wolfram

[1] https://lkml.org/lkml/2016/1/6/385


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWllcSAAoJEBQN5MwUoCm2rxoP/RfY0ZSyfXAqqmqLvmc5sXfh
ldr1hK/rwAr/wuyfcDwE6Fqyt+HUNIP3g0B4p1FTJ6oJL0/6WpJb7SA2ytE3w/xP
4ue9lFD+5g+KDvHnYm4I+ldiQj9E8I7vsgbcuiz+vZFwSRIhVMzJfziRZe2N48/X
gsmz6313CGP8nekHEX5htpPSAswuhTzRL+0iPwX3TKK3gjasVMJo6Te3vK/4TjC0
FNkm/2Vqea7Y4Ryucj7N3mbdeqT+DHB+x0MC1GtTYa3oXeN9zJuKoE7TanZXZkl7
8g+Uw24YQFlZyz59YQBDkfKx4PYzVpIbcB8IpdwfeVwowOgz4hCOZP3c8zO9ivE0
/8/QcV4ufPyDXO4nDoxxo6J8AGmCOGlCTpcNDGLOPyio/hcGjxCUm1QC5lt/+6/1
IkhZL+rJ+nys0/H3AqPBdZi7BjtldEKan7+m7vw6ZS/fcO/haCB3+nM1I61WnA8V
aBdFUKzXo/9gbyBNVr+A6QylLvxbn3WS0NtOOTayR3YGaqI0QUPcUslcf9snomT8
UVAr0OMG1IxRkt4gTTQrm3gMG9CTos32fBZr83uo99cwG1FxLHsO5pf2SjlqpJ6B
Og4eqS6qjYdWD960D+VoqAviSRpdPyL60OB8Flgv6sIiLi9FiN+Sxkio8OAvIIfu
2JZQqGuwmr7Kcb9zlVzG
=74ah
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
