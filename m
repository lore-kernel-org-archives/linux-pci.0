Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54984 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbaKRQb5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 11:31:57 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so2468660wiv.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 08:31:56 -0800 (PST)
Date: Tue, 18 Nov 2014 17:31:54 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Kevin Hilman <khilman@linaro.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH] PCI: fixup __pci_read_base() after refactoring
Message-ID: <20141118163153.GA30151@ulmo>
References: <20141118105542.457d7863@free-electrons.com>
 <1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
In-Reply-To: <1416310271-4423-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 12:31:11PM +0100, Thomas Petazzoni wrote:
> In commit 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while
> sizing BARs"), Myron Stowe refactored the code of __pci_read_base() in
> order to reduce the amount of time spent with decoding disabled.
>=20
> However, contrary to what was said in the commit log, the commit does
> introduce some functional change: the pci_size() function that used to
> be called *before* the BAR size check is done is now called *after*
> the BAR size check is done.
>=20
> This causes some failures on certain platforms (namely ARM Marvell EBU
> platforms, equipped for example with a PCIe SATA card, or a PCIe USB3
> XHCI controller):
>=20
> pci 0000:03:00.0: reg 0x10: can't handle BAR larger than 4GB (size 0xffff=
fffffff00000)
>=20
> This problem didn't exist before this commit, due to pci_size() being
> called before doing the PCI BAR size check. Therefore, this commit
> fixes the problem by restoring the initial order of the operation, by
> calling pci_size() before doing the PCI BAR size check.
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 7ea945f0bb49 ("PCI: Shrink decoding-disabled window while sizing B=
ARs")
> ---
> Note: this fix has been tested to work correctly for me, and the PCI
> messages I get are now identical to the ones I was getting with
> 3.18-rc5. However, please review my patch carefully, as I must admit I
> do not fully understand all the implications of the change as well as
> the code in __pci_read_base().
>=20
> Applies on top of pci/next
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/probe.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

I started seeing this same issue on Tegra today and I can confirm that
this patch fixes this regression:

Tested-by: Thierry Reding <treding@nvidia.com>

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUa3R5AAoJEN0jrNd/PrOhLGkP/38KE0YJG7BY+VfAVQ6hnmV3
jT6yXsZj8WMBKAq1KuIg5aagKjzroEkaZi1eXx+bVBjMtZbrILG2+qJZkM6XnrLp
LA9HO8apOPbQ/uabQpLKxN8mtLBPWc/C1K3XOr7wbGuEMkPys3yVEE8a7ZXo37rs
yISk28VVsmf+PcMaOaFo3VET2OW316gMcfub9+SQmq/m3EPLgfcAUQmpw4ei912A
RYWYD42QAuhHchI7T9B+8UUe/MfZVFwSVPqS/2nIB4eLPIy9bEhOCsZs2P78G1yU
S8nIoJ3TSLEizCDk/CjhQA1fmFTFWeR0VSPgrt/kmi1lte0aOVhIQ/CJMnzNRAdt
FLNeY5hUTVWu4GhE2nd48geOaKRZzZSca9RLTskMOkNCa6uZbcmqZ7Je0PtJ9apQ
diSjFSeqq9hIaqT8KqUM1xcBgeYgKaKzijOmeabiLhViXujnKrsbI8nHTh5j3zcL
FwGh6JVIO0uoXZsCYmzd/wDa1X6daVDqwtLr3pBUjvtRr5zCTqlfoMwmBYRZOftW
Bd5aoFgxXlY97MiVKEWwkao8ERhd++boiKps0v1SOIEXJfRN5FDDFP5XdspPYGh7
JO55A0IcxJBhkGwiA2gfSJRzhlqnXaNgVpAfsCT4d2mlBA7q6IoN6QTmujRksx/w
+fF/wcw/f0WEzB07iibq
=T6wg
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
