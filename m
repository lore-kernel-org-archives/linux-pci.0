Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43350 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdLNOFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 09:05:08 -0500
Date: Thu, 14 Dec 2017 15:05:03 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: cyndis@kapsi.fi, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V4 2/7] PCI: tegra: Use bus->sysdata to store and get
 host private data
Message-ID: <20171214140503.GB13733@ulmo>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
In-Reply-To: <1512723493-865-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 02:28:08PM +0530, Manikanta Maddireddy wrote:
> Tegra host driver is using pci_find_host_bridge() to get private data,
> however pci_find_host_bridge() is causing module build failure because
> it is not exported. pci_find_host_bridge() can be avoided by using
> bus->sysdata to store and get private data.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * new patch in V4
>=20
>  drivers/pci/host/pci-tegra.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyhQ8ACgkQ3SOs138+
s6ElJhAAiEQCEKBp1Z0BYGO9V+vTORnsJ39ocNeUtwhcROH56OPJQLQBHKKRmXaf
Aqjd5tyHbhLuIAoXeyngrn6EfuhNHA1JfUOWDmKFauCYoP5ei9M0cJilXNTLxDGh
RjtcNM1AA9ajsmkIMeNYUs32OIkwNBvOaPjeiMWodKLvi9JFEZFRZbFAZnyKpnS2
coVFK2l0FSoUPCn2uSoeth6udbTkH7kGD2FYPZ3vPLpFBbl4lgZW+I+4UjnIG6Is
0Z6wU/ssElSg7zpDmVKWZi/A1llFYZbs72pmqKBpGEhm1440hKU1W5sdGfIY9T/K
eFDI/A/DwIuwP2Tn0olRiFw+8Rxm24lQaSnX4u4ZcgVJTWCig9u0py71lJ1MGw+y
GAdUPnLCFv6rQfAVNklmGkb2p/6lzwQvDOyVAAbWIwFyk2QKOU75rIBxnwL/o3v1
jE3nFQ4lyz+UxqYXlfnx709UoxIxSb/Vx23iG8LGPqxxBxczK6XnYYugyy8RQ6nw
6IslmGgu20QqBKLFZFHZFUGo46/wjB7tGrHQSbsHJNA8GkZbcdp0tKEgoRCizoCT
uPf0Appm+uMUKG2bKPBOL269J6NIhg6Xz/sSeKZkVbzYc327whyJVsWiyFUzk5Ai
QXlYMyyGk5b56Hdx8d55sEUSKA0JmgxTzuqF6ywu1nJBtyL7wu4=
=LwAw
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
