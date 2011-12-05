Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 5 Dec 2011 11:05:31 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: David Fries <david@fries.net>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pci@vger.kernel.org
Subject: Re: [PATH] pci_has_legacy_pm_support add driver and device to WARN
Message-ID: <20111205110531.3da3c472@jbarnes-desktop>
In-Reply-To: <20111120212945.GA1781@spacedout.fries.net>
References: <20111120212945.GA1781@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/acptjY3yZS9DYd8OP7.1a/5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/acptjY3yZS9DYd8OP7.1a/5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Nov 2011 15:29:46 -0600
David Fries <david@fries.net> wrote:

> From: David Fries <David@Fries.net>
>=20
> Include the driver name and device in warning when a pci driver
> supports both legacy pm and new framework as just the stack trace
> gives no way to identify the driver.
>=20
> Signed-off-by: David Fries <David@Fries.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pci-driver.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 12d1e81..3623d65 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -604,7 +604,8 @@ static bool pci_has_legacy_pm_support(struct pci_dev =
*pci_dev)
>  	 * supported as well.  Drivers are supposed to support either the
>  	 * former, or the latter, but not both at the same time.
>  	 */
> -	WARN_ON(ret && drv->driver.pm);
> +	WARN(ret && drv->driver.pm, "driver %s device %04x:%04x\n",
> +		drv->name, pci_dev->vendor, pci_dev->device);
> =20
>  	return ret;
>  }

Applied to linux-next, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/acptjY3yZS9DYd8OP7.1a/5
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3RX8AAoJEIEoDkX4Qk9hx48P/iAeeGndVKhZVDKOImBmf7IU
kcetjfn5vHuTwok+CVzdg2IAXq2lBdNOKDblDrcWQBY2Ugp0utEeNyvMA3uWTs2M
A6o6V8BCzQ17BHhP9TH0EYx3z/9ClTQOyt0sOIzEABnPml8/JJtRUpK2c5nhVgTT
Kv8xVxs5trs431EDQeevJrvxDWjKHr4Gz3QAoVtGjSt7kh2vCzdPbcBzaztqRP6L
3gtUTO/jJxaeg6rTEvXf3+7SVcaZ6+CMupQRkDI3+zII91KLEEQ9cZehza+Xbzor
woDBCa0jm1q7tQIQvCww7OKxh+emSp43t5jlHFA32fmr1K+xaHMDOXwjxUaPM4zX
tvqrzjAZNgoq5alzowD7Ig2BiJSxtKz6u/HWk5HLR+IEtjPOYYiOdT+1I/Xsql3H
byzwlQ/xqhAZc2Ofyq6vnYarmJGjmgeiQxRG1yYPrjAA95GgpS8gJhTnzBebLC7j
VVkeIj+oDUylSMlDcUFutKJ5BNi3aO03Kp3CamLQ+N5emOZjvPaqCAr+wVwcI12r
NiQ6dmVQBAQB0YlwIljW0jEpbrUMJGoesfuVvculTzheqDT2ylzN7b6CCcVpesBv
ZDN1NG12Qt9YC8AQiWPHVO1cmJtWPUNehZ/86xKq+RpYLRsBfBky2lYs65C9fwZf
UrUhYkbFZmi15zXdxR/e
=Xl16
-----END PGP SIGNATURE-----

--Sig_/acptjY3yZS9DYd8OP7.1a/5--
