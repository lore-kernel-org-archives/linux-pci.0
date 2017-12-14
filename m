Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:41172 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdLNQAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 11:00:51 -0500
Date: Thu, 14 Dec 2017 17:00:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com
Subject: Re: [PATCH V3 10/12] PCI: tegra: Add SW fixup for RAW violations
Message-ID: <20171214160047.GK13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-11-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
In-Reply-To: <1509371843-22931-11-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 07:27:21PM +0530, Manikanta Maddireddy wrote:
> The logic which blocks read requests till AFI gets ACK for all outstanding
> MC writes does not behave correctly when number of outstanding write
> becomes more than 32.
>=20
> SW fixup to prevent this issue is to limit outstanding posted writes and
> tweak updateFC timer threshold.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V3:
> * changed soc parameter name
> V2:
> * no change in this patch
>=20
>  drivers/pci/host/pci-tegra.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyoC8ACgkQ3SOs138+
s6EYeA/+KQIkffd4XNOpy3F1b750xtDvI09BFE3LB2g03gbceIPmfMEy8UBNz+Hs
4RjRN/ZwuYMme3WFk3Nv7ntV79f0/4447rBk6mlLOfDAMVLgmR6IRRz4JVAjbyhF
NG2JBqAGvSe31DiuLIaMLeJlbiFGWq5fdC9XAg6ykgtrhPK6+UkuNgUltu4q1ufz
qu6PCOKlTuKpm6MxQcm3gFXRuCS/oHguuEVOyJSBuKrcBMbjnP44ks+nW4yRqHdS
4ERtDCOH6Vc1UbK1x+Hp3Ebi2wQ0I/d5tn7oI++b3obXJzQUtTytFJIuPeAi8xFg
VtunrL7iL4GEbNjO7IYh6NrK0GWaGYy2Q/U/t2/pIR3e/osMAviiIoD8HZiQx4/8
o4ILObyfYoUGaUh08OcCKkrsyCndNckSTAJ5VaJe5VLps6OoislRYXVrW3vZsIHs
ciIipfcgT2DzlBJJZNF0CC+DLyQo6Trll+kZr4Sk8fwxeuigkJbGHhXEsqwB6Cwl
H6YOqnHIzK6Ad56zpVxsrp0muYEfnPJvwjFZhjFDy7zp52A+aDYBno312igVxK+N
PgN9tAf6nNL19DJ3p9Gt9bgjO+kUhkAEE8SCCRYxhFaww9W3M4VdbyB3N+u5qwFO
UoEJrOWkgW6cUbT1TSc3f1Y8nBlOUEzoLFU3ucb2EZ+CHcuDurY=
=z/uE
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--
