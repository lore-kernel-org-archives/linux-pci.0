Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:35770 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab3GYQxL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 12:53:11 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so772444bkc.23
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 09:53:09 -0700 (PDT)
Date: Thu, 25 Jul 2013 09:53:03 -0700
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
Message-ID: <20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 01:52:44PM +0200, Thomas Petazzoni wrote:
[...]

Hi Thomas,

I just noticed two minor issues, see below.

> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
[...]
> @@ -36,6 +36,8 @@ struct hw_pci {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);

This hunk...

> @@ -63,6 +65,8 @@ struct pci_sys_data {
>  					  resource_size_t start,
>  					  resource_size_t size,
>  					  resource_size_t align);
> +	void            (*add_bus)(struct pci_bus *bus);
> +	void            (*remove_bus)(struct pci_bus *bus);
>  	void		*private_data;	/* platform controller private data	*/
>  };

and this one use inconsistent indentation (spaces instead of tabs).

> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
[...]
> @@ -464,6 +478,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
>  		sys->align_resource = hw->align_resource;
> +		sys->add_bus        = hw->add_bus;
> +		sys->remove_bus     = hw->remove_bus;

And this one aligns the '=' sign, whereas none of the other assignments
do.

Might be nice to fix those up before sending them to Russell's patch
tracker.

Thierry

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR8VftAAoJEN0jrNd/PrOhqhcP/1E9ONIuqiClTNYr7VD0VmNr
TzM94l3pYe2EsAKXKCaDPpVJwbf+xj01Y1TVik3WawxJY7tiaF09g2XapDDnzuGq
7UkgSf/+CCY5m6AZlErdq+uzCjGFwFRw9nBGif27ZMmTAIBvZHTA7JQrEcw6oXnA
tUOBNXbKPGJ+g6N98wEaropcE+dvYotpKXs164dlolPoZ0M5WX01085NUIPpHMhb
pN5zYjtH44vMeVF5bvxzbEEZAWTYT2gLEyYP1pfyU7JFjKRKPPdMNOfM+9zuhLiJ
L75ryP0K9KFmE1oHOz+AUHzeBgD9HDUEPj3WmS6coNgB3EfZSEz+632ZR3i/37Wb
l6Se4cgKReXq1rO73ri4WaraYdmtG4hlI+4VvgEyVloKfaTzwXqlepA1cRSAD7AT
JC5e+fCH5me4lwFDczllYivaM3cRowFkWRPGiQHso7XPKMH/rZPWoW0RWEKCOHVq
SpW0KxyitKAL8o4fkkkI7+czOUMbSRYQTq8V0WHRdfK3SYvoKC6jXapeHciDuzTU
1SAgLL5ILxvsJvgTIfAaTOdTtav6ldSZa+YTnhVXnFKGd1luOrFIw32sCOZ5CC47
yeg3jJk4EwObXp6e+ZxLnn1+BOGJvoSAhJDdqAe1Dieay73baD1eQ2SNZP16zrPC
wKdtG+ps3EDDxeNVAela
=RiO5
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
