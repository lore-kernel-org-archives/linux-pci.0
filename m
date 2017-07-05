Return-Path: <SRS0=XnOz=6I=sirena.org.uk=broonie@kernel.org>
Return-Path: <SRS0=XnOz=6I=sirena.org.uk=broonie@kernel.org>
Date: Wed, 5 Jul 2017 13:33:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Mason <slash.tmp@free.fr>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Message-ID: <20170705123304.extc5iswhwjepwyp@sirena.org.uk>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170703181128.GD4902@n2100.armlinux.org.uk>
 <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fkjptutfsxnlabm5"
In-Reply-To: <0cd65cda-9a3d-8c1b-1ee9-c48f63959140@free.fr>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
List-ID: <linux-pci.vger.kernel.org>


--fkjptutfsxnlabm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 01:59:55AM +0200, Mason wrote:

> Do larger SoC vendors have HW devs working closely with
> Linux devs, to avoid these design bloopers?

Yes, or just internal software teams in general - hardware designs tend
to be a lot more usable if there's good dialogue with users about what's
useful and what isn't.  It's going to happen at some point anyway when
people can't get the chip working well.

--fkjptutfsxnlabm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllc3H8ACgkQJNaLcl1U
h9BSogf8CecwiRAi+trNsmUK16kSJeNzOtmSxMAOgn7foREKBLBqlxu/k6ZcBOTh
axM1t1OdWTydkFfV+g0+qFX62Plbi2hrNRT7/F45WTtOaevKj4qmds7ca/A7a8Ej
jAOeL7QveC/bY0JPZ79+MK+tf/8GsGpcJGavypTJ84/c5qcwlBICV8GuP3Cn1oWy
scTTakHr874H1/j0tiDrz2IBtO2rI7LxAOaOJnfxUMjvBh5SpKUND9WKfr4Px9bI
1fHezYoNml2FWX89H1ImoLFV5U6mmsrJ7u57G4AO407YDm0sin6jxlRKaHG8/D7u
zU6DMZsIwouthZ+ECXW1hAaG+CREDQ==
=vJlJ
-----END PGP SIGNATURE-----

--fkjptutfsxnlabm5--
