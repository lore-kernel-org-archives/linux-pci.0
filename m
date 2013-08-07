Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:54968 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933040Ab3HGNhY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 09:37:24 -0400
Received: by mail-bk0-f54.google.com with SMTP id mz12so252138bkb.41
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2013 06:37:22 -0700 (PDT)
Date: Wed, 7 Aug 2013 15:37:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130807133719.GA26302@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
 <20130807111354.5e29a74c@skate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <20130807111354.5e29a74c@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 11:13:54AM +0200, Thomas Petazzoni wrote:
> Dear Thierry Reding,
>=20
> On Thu, 25 Jul 2013 09:53:03 -0700, Thierry Reding wrote:
>=20
> > I just noticed two minor issues, see below.
> >=20
> > > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/m=
ach/pci.h
> > [...]
> > > @@ -36,6 +36,8 @@ struct hw_pci {
> > >  					  resource_size_t start,
> > >  					  resource_size_t size,
> > >  					  resource_size_t align);
> > > +	void            (*add_bus)(struct pci_bus *bus);
> > > +	void            (*remove_bus)(struct pci_bus *bus);
> >=20
> > This hunk...
> >=20
> > > @@ -63,6 +65,8 @@ struct pci_sys_data {
> > >  					  resource_size_t start,
> > >  					  resource_size_t size,
> > >  					  resource_size_t align);
> > > +	void            (*add_bus)(struct pci_bus *bus);
> > > +	void            (*remove_bus)(struct pci_bus *bus);
> > >  	void		*private_data;	/* platform controller private data	*/
> > >  };
> >=20
> > and this one use inconsistent indentation (spaces instead of tabs).
>=20
> Hum, I must be missing something here. Looking at the patch you're
> quoting, and my code, I see one tab before 'void' in both cases, and
> spaces between 'void' and the (*function) in both cases.
>=20
> Am I missing something here?

Perhaps I should've said "alignment" instead of "indentation" to make it
more explicit. All other members use tabs to separate the data type and
the field name, while the lines that you add use spaces.

Thierry

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAk2PAAoJEN0jrNd/PrOh15oQAK0ELdpyw9tL7Xdf3kMIwwW+
Xss5cbeJYhRreul3pQ8uoFVMTYP23hYN3ieaBxq4gv6iu3B/pufJ+uZkOGB+Zq4g
hw1x9n+9+xK81O5Od4aTHUujeFk7z9VdhEo7AwvcQ9UbswK4zCw4qp89Zy4WdksF
enaLG8bDXLoJdHlvgcv3KIvGF5QHkYyp8bIXFic5u6owWR9iqtxjGR0g1myauMd8
8FfhBArdJyPwOdBNJYhgYSoeiH176asQprWL2kgpjpy+G79jjWutzfvHZJGpn2r5
4mpagFGj2kjYAsW1NlYXGxhe/2/nzpsBRkYd5/VVtr71AgYR1cPQEXf+0FW+1FpO
tdPJSzNcBFfeNdA628LI7H4nB99E6VBhp20AtJU4EtE6aHXLMbrlw7pxQ9/VSNpJ
gsyd2l5loaWXHTyQQaFSQs7Pk1yWelS/irvZwCpG2uMsFZJxCfT8W35T8GuH/i8k
0mFUmaeA/l01HSfDAQAerk+bJqh0IEc0xiVXOyLXPdSHevYITIG8QXKObX7fatl/
Ae4QI52ALbBSdVYL83JYyHx77ZHm+BE70b09NwMPhfhHX7CSnzLlQ5CH4p66i0u+
ob8IVpvxqmJegD74LgBC/rzbjdtXmjvjkG4Y3W5OjYtuXZTln32a1kjZoOMnL0Zk
tf7E9MgBH7jPBaiZMcl6
=BDCT
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
