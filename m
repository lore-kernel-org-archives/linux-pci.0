Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55716 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030274Ab3HIOSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:18:11 -0400
Received: by mail-bk0-f42.google.com with SMTP id my10so1115324bkb.29
        for <linux-pci@vger.kernel.org>; Fri, 09 Aug 2013 07:18:09 -0700 (PDT)
Date: Fri, 9 Aug 2013 16:18:07 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
Message-ID: <20130809141806.GA15973@ulmo>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376027346.32100.8.camel@pasglop>
 <20130809134427.GC25111@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <20130809134427.GC25111@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2013 at 09:44:27AM -0400, Jason Cooper wrote:
> On Fri, Aug 09, 2013 at 03:49:06PM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> > >=20
> > > +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> > > +int of_pci_msi_chip_add(struct msi_chip *chip);
> > > +void of_pci_msi_chip_remove(struct msi_chip *chip);
> > > +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> > > *of_node);
> > > +#else
> > > +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> > > -EINVAL; }
> > > +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> >=20
> > Missing a ; at the end of the above line... breaks the build of
> > CONFIG_PCI_MSI is not set.
> >=20
> > > +static inline struct msi_chip *
> > > +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return
> > > NULL };
> > > +#endif
> > > +
> > >  #endif
>=20
> Reproduced, fixed and builds clean !CONFIG_OF and !CONFIG_PCI_MSI with:
>=20
> ---------------->8----------------
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29631eb..9f69507 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -19,10 +19,11 @@ int of_pci_msi_chip_add(struct msi_chip *chip);
>  void of_pci_msi_chip_remove(struct msi_chip *chip);
>  struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_nod=
e);
>  #else
> -static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return -E=
INVAL; }
> -static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> +static inline int
> +of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; };
> +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { };
>  static inline struct msi_chip *
> -of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL =
};
> +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL;=
 };
>  #endif
> =20
>  #endif

So why do we need a semi-colon after a closing brace? I can understand
how the missing semi-colon after NULL would cause the compiler to flag
an error, but all the other changes look unnecessary to me.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBPoeAAoJEN0jrNd/PrOhB2IP/2BsgXh4lxSBAxAdoEkLexiW
nycd/tEmGsboWXNZOGLmpetzZFUdvbghneYiz7Z2OPZa3ackBcCvp6foM/ZC+2Ow
DA70QGt2xjCor+ofvizMLZbW81viaORUJOkib3PJp6IQ5ILD/Tg3BXm+dhD0XI4K
YxNfxTErgin1nU7dqx10uE/hFshahU38vcLljhHU4LaMKBePP8Jwl4qyboLFBSxA
FT10YvtBP7HrFjBIHPkG9R7Z74o7Ta9uLZCmvcVD2u6APC0il3nUNVujreiEWA37
U+2Q/rVkZkZa50+0diuoy3JPVUnN0KIlEhjSNmCn+8KeQ4LGYKRkmgGaRwHKLCAM
JiKG1gXIPdKAcMUxAR4bW73nYZh0Zsfb+mR5zpOpAlPLKIo66LRZ1lVILBjr4SOJ
uWMJybOJPCfPy4XSUUn5TpOI6wLkLDHSdC4qiRlk1ot1J511Ftl/WoQ0ekAhijG6
92qJtMC8fvMKrf/e6luCO3YqprANrEFZ9lUYeEE3RR2WxV018dpbAhYyqxMLA1cT
swMYWvT0X8qsf0SIp6x51tYQh5GTzq2ommcH+WEW3XypVjFoRsDjUhfp3O0GHBjj
nQ46wxi9eu+M4iCSEnzEHTkNNPaSjhghdwmloxR2lWZ07/ua1HsNMKbFr3gbBluN
ZhLrr26pQQGp8lhwH8gQ
=YITc
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
