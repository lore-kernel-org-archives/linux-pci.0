Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Feb 2018 05:44:32 -0500
Date: Tue, 6 Feb 2018 11:44:27 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: linux-pci@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ian Ray <ian.ray@ge.com>, Nandor Han <nandor.han@ge.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [v2] PCI: dwc: fix enumeration end when reaching root subordinate
Message-ID: <20180206104427.bqonr2f7zm5whibq@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkjnczvd7igqg2os"
In-Reply-To: <1516008968-26285-1-git-send-email-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--dkjnczvd7igqg2os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch fixes network support for GE Healthcare B850v3, which has
two network cards attached to a PCIe switch and is

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--dkjnczvd7igqg2os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp5hwYACgkQ2O7X88g7
+po4EQ/9GpcSyPnlyP6a0BFbPZMG9j0K06rRgPZJHJ42cvPHtYqK4WihbrGQqfxE
Ra05LGxyjkSP18n7hfyVwJYcuEnAwua/Vvc6F0aypJ7nenZThLt56t3CUzoj1NES
gyh/w3pdEDjKaZPERs3aFg3QryncXnuGCRgw1HPpmYxPtIF9tNpl+QWO9K2hTRO9
B5erSMy/7FE2YxFijqrfFe3D5gduxaOOogZQZkU4W0CquNfavmVuYlq1Y4D3QEk8
QSwUAv45e7dcLtrV4zqPTPCFJK3RGM9wDYxHJF5tOLEK1oANpMRl1Ny9XFA7r671
n9nIQ0yicmwn+5GyC7AC35c9BCTjccW1hpChrV5I8sY0vTWlZ7t9YM2MhS6INeaB
WzOmFaQkUu7SwESXPZR+3twkvKdhnrvXG6tcWm6AhT5EXEzGC+nXayy5FQogIHOn
RlqsktDFTtrbNNdkjrYBtifeOnD82MVy/VzqJU/EvWIKdK5wyjXCLh0yEjIyMf1V
053B1u2js6txusiPqEqOKglbUurj5C2z0zTojn8yTr5TEsO5dVjW9h1fq7Ed1Jse
W95WzUN3pMBDUe6XVzQfG9UpIntgoTzxwuLVaxNX30XcTurmN5+cR9q8tdLYJtEN
dk2MMJSBFN8LozZUPQ2MDbCkYcwkVJdBzAdiVBa5rPiQYur+0O0=
=HPWt
-----END PGP SIGNATURE-----

--dkjnczvd7igqg2os--
