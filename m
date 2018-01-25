Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46196 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeAYOZ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 09:25:56 -0500
Date: Thu, 25 Jan 2018 15:25:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 4/7] PCI: tegra: Free resources on probe failure
Message-ID: <20180125142552.GF27888@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-5-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
In-Reply-To: <1515650888-9459-5-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2018 at 11:38:05AM +0530, Manikanta Maddireddy wrote:
> tegra_pcie_probe() can fail in multiple instances, this patch takes care
> of freeing the resources which are allocated before probe fail.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
> V3:
> * change 'if check' to 'legacy_phy is true' for tegra_pcie_phys_put_legac=
y()
> * commit log correction
> V4:
> * no change in this patch
> V5:
> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
> rebased on linux-next
> V6:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 99 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 79 insertions(+), 20 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpp6PAACgkQ3SOs138+
s6HV0Q/8DhL7ecy4s5p4GPjEj7JU0VpMVn5sytnDdTlIMi5PHcNhT/z8P/ihKRpC
oh3jMVQLsWiADtAvZHD8gMvhdK4m9kK7SNkDkDxxp/aWG3jFgn0aSuQMchQJ6wkj
PY1w6AeHv44dfSkFK3oXektXlcTAZwiGjuhQLPpMgua2HZi2ou/bct5SKp68Yo41
A5tC+CUfrY3cpKsH2rkN+ctznOgkZpovigXaInYj9pIUfDakgqLynVEVy4WaMCr1
m/eDmisgo4Dgaq+ODFKrfNU54CH6PDHXS8Z+Juf/fZjDAL2jUhYt7S4KxTPX9zE4
RNRc5V8Iu9eerX9tA3K+Mf2IDyXp72Op1cxGDJV2ihvQcFMGsyJMbO1dOHvmzWG9
ptNhPqBYs4J45Wn3ovClAyuvD7fD6IgdjGVyRQp7Naewn/rHpj/yYvh+s3WEldQo
Wo5rvU8KuJjTDLsc240C9i2BnlQaKKvbFao2Egbt5e5FJ8P2VNSINT5GOE7p5Oi8
g8SmSOO9BMZu/bGbtqgXfwf220TVn9Xg/TD7YZL0wDJoA1hWMAbYiathgJ+MF1wV
ZZRpVKY8M6zy+RdbImoy7UgtOPviZAxPlaXAGvgabkESs6QkHt1CLWKN3z8SYWXU
5oEzWlTLdUkNtlmjB9RQUzSvV/247tW9ZDFubhFLHq/AgWM9koI=
=0Jk2
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
