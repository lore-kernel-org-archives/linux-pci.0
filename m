Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53080 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773Ab2HQS3m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 14:29:42 -0400
Date: Fri, 17 Aug 2012 20:29:31 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: PCI Section mismatch error in linux-next.
Message-ID: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com>
 <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wro=
te:
> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irq=
s()
> > around after init) causes:
> >
> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from =
the
> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq=
()
> >
> > The MIPS implementation of pcibios_update_irq() is __init, so there is
> > conflict with the removal of __init from pci_fixup_irqs() and
> > pdev_fixup_irq().
> >
> > Can you guys either remove the patch from linux-next, or improve it to =
also
> > fix up any architecture implementations of pdev_update_irq()?
>=20
> Crap, there are lots of arches with this issue.  I'll fix it up.
> Thanks for pointing it out!

Oh wow... looks like I've opened a can of worms there. This requires
quite a lot of other functions to have their annotations removed as
well. Bjorn, how do you want to handle this?

Thierry

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLo2LAAoJEN0jrNd/PrOhb1IP/RdhIzUzNvyJ/Gtw7M0h2/5Q
Jkj9EMeo6UcEaAx98xWTGYtNihfIDfg2LlmGJU5Sgu6mEQqRdFD6WMfOByis0bLP
iS+w7cFA7K0qSdktxker+5+P8tYWIuh+oRXHSqNPvQXhm07XvM2BfYgHfWnvDLlK
VvFeXf+dnXCb8dZUA+uiXXc1GeQbT8UJnx8VPuPPV5tOk8WIKyKopH6EzXWDiLNf
uNrsr90DIv6O2p4qrfkcBiGpcbLaHWBOIJ3jwc6rbqfntL9c1DATZzW6Y0c5jBhh
gX8e9KMMX3OllB6/mWfnjOyBc6Ah9+ZQKFTZIWjcyw0LZPPPVApnURBsU0HPvudZ
wV3BDt22W+9Sq6ojiBr3EmFr8QK5XmpyevKQLBUsjTxVc1MNcPX+c+MgDSmvbZWd
rgw3CtBPcSFCeD8lCr5xHETJ/8ws2v6JpJrm8z9EQNkq572Hiqx2KFL35PxNbFGn
Wck0H+LnEGxr4RajQCDpnnzqTo+X7Xq9xuON/SxFrqUgAgBR1cEDGSM1nRyovXWe
RhD1FjwTKJbKQltQxaXNUAoGMM+B91Ootx7OIhkWd+bpUZ/Z0DN36AjpsehA4c2i
q8y75QpUyvq9cx4gOBO/jWOLj19ZI/DldaulA4dlixCeSM73poUO0C7dAp6wFZ3V
LpRU2groV73HhmaV959s
=Z87r
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
