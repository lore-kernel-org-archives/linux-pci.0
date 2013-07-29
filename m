Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42772 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab3G2XXl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 19:23:41 -0400
Message-ID: <1375140189.2104.25.camel@jtkirshe-mobl>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver
 skip that
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To: Yinghai Lu <yinghai@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Date: Mon, 29 Jul 2013 16:23:09 -0700
In-Reply-To: <CAE9FiQWsaMuAPrx62rTGBokyV-O49NuX0tsaVzqKUcxuoEoPvA@mail.gmail.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
	 <1374937868-24437-2-git-send-email-yinghai@kernel.org>
	 <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com>
	 <51F6D161.1040106@redhat.com> <51F6D9A2.8020403@intel.com>
	 <51F6DF35.40909@redhat.com> <1375134764.2104.1.camel@jtkirshe-mobl>
	 <CAE9FiQWsaMuAPrx62rTGBokyV-O49NuX0tsaVzqKUcxuoEoPvA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-vytGsNxsLAdYtEganTnB"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-vytGsNxsLAdYtEganTnB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-07-29 at 16:14 -0700, Yinghai Lu wrote:
> On Mon, Jul 29, 2013 at 2:52 PM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
> > Can I apply this patch as a standalone? or will I need the entire 3
> > patch series?
>=20
> would be better if you can test those three on top of pci/for-linus branc=
h.
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=3Dfor-=
linus

I will have to do that, because I was only able to get patch 3 of the
series to apply to David Miller's net tree.

--=-vytGsNxsLAdYtEganTnB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAABCgAGBQJR9vldAAoJEOVv75VaS+3OUoIQAIDJ82CtzfhPEb6cw0by7Ohp
IV/6aYFc1KUABXDh+lFOxfwkFWGRGd9DAH0YOHti0svAl1n9C8mvlK7THxliMpM3
EhsfA045Ac56zF6GWv8YNNrmFH4luuMMbdvD1Zzr6p5rKE2GIIe0srUQdrhbs49V
WSfeNTMFIsVOATH9sy+cp0QbyRmGVI1QR/a9/Y7L+f59CmQTBo3n+Bbbifcn8Zce
NZDyfL+kCdk5QuLy4PXcUHMOP2232loJJtLM9ij+6WaZewtwrlyEEo1rh0oSLwPm
vNjkTPLLBxmaCF1JTIO+bwl7w9LqsjZEvpt5Qmb4Vrhk/QIfgQt5S5rNT5D11UzY
76b9R8hxmnvfiqfMYevwjkKLvDSYfXysrfC0Rl6LddGXKv8fgt/DoeeB/QCba6ZU
nTF4aG40WcVcyi0gL3q+dQo04Tt838rIA/VUVTeQANzKsutDHGGdBI4NdUCjLy6D
yYtsFjmYKSO2Lt3Mpb060DHr/ZjJAg60RSJ9Sc9Zx5yOH04TBTciRFE4KuGFtBRP
k/T/3qr0jK0+HRNUXJGPcizrgn6BpGckj/+0idaEUZ2IqipXt8pTBuFePssfO7Yg
zj9Lc/tP8bmxsNt8XBDh5ATVbSahqY43/TYDt1pFYxbl2Hdfepeyezz6yrwAvalo
NlzabosSZkTlFgRh4e6u
=4bWp
-----END PGP SIGNATURE-----

--=-vytGsNxsLAdYtEganTnB--

