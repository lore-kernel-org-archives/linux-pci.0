Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE43DA5D4
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870539; cv=none; b=kCrm68CviagXkW190uWw7rCmqQys/TO1Y1dhd2c10YIWZJ7YLzT51wqfV3FlmaLbxE+ObCPRP29dFm1TFQWx/UPASNuCv3Uedj1qsOz5XCZ/eIw/zuKiFhFkzsZgo6uJ2oyZTrLAktXtE1gMa0F+y0Pe2AWC5/fxBqgO1UsfYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870539; c=relaxed/simple;
	bh=dnKKV4k9imrwOYYrkrG7utWup+ZEdJNlE4/zhl36kBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs/dxGn4cz7xAFX7OD6HdhSkGZMgEj/tpKeQkX6LVqXi8FYPI0b5c8uMOrGki4V/aXLUNQwk1UgNSbeVYbZ+sjM9vXWfffvz5ZtR1lRCPcnkgec/vo5uWCIju5+JjZ5JuGGyLTPAnubrKYmzo7cisl+QxU3usLTtBHLpRwsZUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq698nOU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq698nOU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-452169ae568so7389635f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870536; x=1780475336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXP90BLkmwM022fcUvwY7xPlmUwoYsB+/2erQUJ8WqM=;
        b=Hq698nOUn4wUZTU18JpCC2UeibTPT3RxLM11uHaERs5WIG4PXnTt7IFoKvxGKOfO2s
         rUIBjxBYd8QjS18JjHhqBAZ9cohwcCNPxgF7tare23DAQX1t8OoVZ21lyFkNBUgbanK1
         DDHx+Zs5vNTHU+KwTKWgjUXittWyo//W64HFduvlrUMr1OZeFNadh7Wpnz95NLYxKJMy
         zXGdMkzOhsbzRUZA+W5fmYl5izkAFj7ywlGylCy6e8DqLf2vTcy3crbNN3zlwdsY3pb4
         1GyadCEIQbENK7HaZjyrj+XxRtLprmxbcePVkAkQE03rml9oT+HvVcKtHXPrZE9SARBX
         wr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870536; x=1780475336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXP90BLkmwM022fcUvwY7xPlmUwoYsB+/2erQUJ8WqM=;
        b=JI8qbgZiFCb13NkK/eBynSu7p9UhSgoMnvXXtPuz7WCqWBXrfE7hYtQCJ3Xz/99uyr
         nruGTW+Bq9Gvsw4OKuRSLr9EoGMk/+qE6vjBVOWrdchLvyUx4VASkLa+SoEw/4JWvPdp
         kLtvcJBEb8xJKJcMdtP57rVIkIUfCn+MgbALn29yzZA4iAaM2n4OVIs7PDuM1A7mcPGT
         7frBzt6hAxD8cqRUIgT8D9R8eirVT7VFvq5tWdMCkI2Yg4qkBFFvOqO6tcqCHmsO0eJd
         IerkS/BSDSHa9+xgAQ708/lzmrn67ft8Obh7NXJIh6UxQLNIHG8/u98H0hp7Mj3lnN++
         sLWw==
X-Forwarded-Encrypted: i=1; AFNElJ9VeiBwcketN+PaLs279esW+AxaGMLXTSd8aJu+u+/AOqNVWJoFmn6YVYsU+kfDMJ3rUpk3+v6jQAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki2k3jt6LiaFREK5zkCaMLBJ4LMt9DlT4G0U27EGw7m6qT2sM
	PIvE6bhU/iCDN8J12iPnSshSWpuFKHk28GlZc+PJ0DBlVtitC0Av6mnG
X-Gm-Gg: Acq92OFh+q9O4//p6RbR4AGhgyz0Cmbpt4ZjL5Iu3iKmy9Z5zDaTLcbcZ2QkVYLZD8N
	esu0extBUkkwbRf+HyPu+SLuuI5WEOrpby3wPh0w/54uR5X6r36tadmA8RtXaAdkqfmo4DEG1sJ
	flNDcC6Laro5rqr0aQQztfyQ2yoyaGJw+2XjRYsjMsCPOyLaI5EDZN7eI2Yyu1IVgaGlim8tYGP
	bbDYKUmD/l9bxaj30EKpXkdcsvkWZxSNskHyyKnDjhN8IlVSbw+etpyooTY/K9fL1XpHCguz0J0
	7cPyIHfN4HSj2OkiBwp1vhLlDFurXygEwGvt6nIHUVlilLwxsj+jdKWTiyOC+csI7laawJOSQje
	jmrSGSgGPOIKJYBCfw89mJOG7XyYXPv0pUd9NOFkPrb9Am+mx6njgrzqVAnZuxuwMnw3fWRMie6
	sUHd4j30xY5MW8z/siv5DGH0B7CoRYqzfm8GowfN3kayPRSICBbIWvoWQcG7tT65/8dIt1OxpfM
	so83hSapA81ew==
X-Received: by 2002:a05:6000:4b07:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-45eb3689049mr34779824f8f.8.1779870536122;
        Wed, 27 May 2026 01:28:56 -0700 (PDT)
Received: from orome (p200300e41f1bda00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:da00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c27e7sm4474850f8f.35.2026.05.27.01.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:28:54 -0700 (PDT)
Date: Wed, 27 May 2026 10:28:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Message-ID: <ahanoZgDwq3v6x8M@orome>
References: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
 <20260526-tegra264-pcie-v5-2-84a813b979d7@nvidia.com>
 <ahV_r6NJWnmJptT2@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y57fabq4zbjqmwuy"
Content-Disposition: inline
In-Reply-To: <ahV_r6NJWnmJptT2@wunner.de>


--y57fabq4zbjqmwuy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
MIME-Version: 1.0

On Tue, May 26, 2026 at 01:10:39PM +0200, Lukas Wunner wrote:
> On Tue, May 26, 2026 at 10:53:11AM +0200, Thierry Reding wrote:
> > Instead of defining the wait values for each driver, use common values
> > defined in the core pci.h header file. Note that most drivers don't use
> > the millisecond waits, but rather usleep_range(), so add these commonly
> > used values to the header so that all drivers can use them.
>=20
> Hm, why not just replace usleep_range() with msleep() and use the existing
> macro instead of defining new ones?

I'm trying to somewhat unify the implementations across drivers without
changing behaviour. I don't have a way of testing any of these drivers,
so keeping the existing implementation and just switching out the symbol
seemed like a good compromise.

> > +++ b/drivers/pci/pci.h
> > @@ -63,6 +63,8 @@ struct pcie_tlp_log;
> >  /* Parameters for the waiting for link up routine */
> >  #define PCIE_LINK_WAIT_MAX_RETRIES	10
> >  #define PCIE_LINK_WAIT_SLEEP_MS		90
> > +#define PCIE_LINK_WAIT_US_MIN		90000
> > +#define PCIE_LINK_WAIT_US_MAX		100000
>=20
> If you absolutely positively want to add a new macro, consider
> 90 * USEC_PER_MSEC instead of 90000.

That seems rather useless to me. We have a _US infix in those symbolic
names, so it's obvious what the unit is, so nobody should be confused as
to the purpose of these. I suppose if you want to make sure it
correlates to the SLEEP_MS variant we could maybe do:

  #define PCIE_LINK_WAIT_US_MIN (PCIE_LINK_WAIT_SLEEP_MS * USEC_PER_MSEC)

Then again, I count 2 drivers (in linux-next) that use the existing
PCIE_LINK_WAIT_SLEEP_MS, one of which multiplies by MILLI to get at the
US version (so it could easily be converted to the US_MIN version). Only
pcie-designware.c uses msleep() with PCIE_LINK_WAIT_SLEEP_MS, so it is
clearly the outlier.

Maybe I should just go all the way and drop the SLEEP_MS symbol and
replace usage by the US versions?

> Moreover, consider using fsleep() instead of adding an additional MAX
> macro.

This would then be changing behaviour again for all the drivers.

Thierry

--y57fabq4zbjqmwuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoWq0EACgkQ3SOs138+
s6HatRAAg8da90RqnHjyUFhXOqP7Cjo9/fYMdwG9qKAW71wcGfZM2pK1xmC/LV0g
MIyhmSbMyevnALrOnbkobpjgl5QbrSNXE2CqxEKR49UlV0o2lATFB+EJlmtPiSN3
7Q464BWjHaibyl6UU5/FV9VDV0pJK5JQfH/x6I+G27E+XQqzMerQeYuq/Gl3ZLQf
1VZqhztZQ7U/GQBX2g+8FO06udWT0JDk5eNXwrqjg11zIG1C5rXkam1kmgXKYB4w
YDg5TN7DAqnWeSyE0j6DYVXNImRv3X+MvVW5fH09eJ5yE5m8KXdr26kDKTQ+n931
TTuyEB+mDL+FjI8JRMSU7nHPs3T16m4CtADOSx5UItd3EnHi/gIJMkmsbdo7P5yq
LNYGdCameYwMq2r7NO65c9R6H7ARCA81z8frzhj8cT9LyNmwwpLwPnc77oBArl/o
DsdZknA8CG5mHmZOvtcQkTfrdKTJQVolANFj8ARi1pg5p30uGNORSnDrsHSyCygR
8oZSWZr5pKs+aYMYk5c2HgNUQ2IHgEaFkTjdBVpOCTzTXX665DNQH+vANxV91jmx
oM5yyVFbEhPq2SdXpSuXAhDqjqLFWckgdB2NFdQ+A0qvjkUzyHqNsYBirxrtU4Cn
DGjDBzWzYCnn4KcL8eLVcYxybJBsBD+JwfOUv/k3QCFRDwtoqt8=
=BbZl
-----END PGP SIGNATURE-----

--y57fabq4zbjqmwuy--
