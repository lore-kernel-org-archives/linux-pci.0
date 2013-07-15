Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:45704 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097Ab3GOQ1T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2013 12:27:19 -0400
Received: by mail-ee0-f52.google.com with SMTP id c50so7730013eek.39
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2013 09:27:18 -0700 (PDT)
Date: Mon, 15 Jul 2013 09:27:10 -0700
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <51E4167B.4000208@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 09:34:19AM -0600, Stephen Warren wrote:
> On 07/15/2013 05:52 AM, Thomas Petazzoni wrote:
> > Hello,
> >=20
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> >=20
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. This set of patches applies on top
> > of 3.11-rc1.
>=20
> Thomas, who is going to merge this series?
>=20
> I believe at least patches 1-8 (or perhaps just 1-5 plus 8; I /think/
> all the other patches are MVEBU-specific) are dependencies for the new
> Tegra PCIe driver which should be posted very soon for 3.12. As such,
> I'd like to see these dependencies merged into a standalone stable (100%
> non-rebasable) topic branch based on 3.11-rc1 so that the topic branch
> is available for merging into whichever tree takes the new Tegra PCIe
> driver (which I'm guessing will be the Tegra tree to reduce conflicts).
> So, whoever merges these patches is going to need to know to set up that
> topic branch.
>=20
> Thierry, please correct me if I'm wrong here.

We need at least patches 2, 4 and 8 for Tegra. There's still the option
of working around patch 8 by using the custom root bus scan function
that we have to use anyway, so I guess we could even trim the
requirement down to patches 2 and 4 if we really need.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR5CLdAAoJEN0jrNd/PrOhnL4P/0+RMDPpVLU6n7dtvowcpDA9
JfMX1G5/OEt0GSxbKjgbEFhMxlCmwvf79cC3SWnsK40TWNsF2jtTe5VITWuXN6iB
+1cRSpoMlb2p4Fn6B1pFBNmV5fb1DRvCahe2ZB8wyfZWCK1C5kNhz38hGmZyzOCr
+NVAjgrlBkUO/logM6rmdbh7daYMiUPyV7HRmkfxPbl+FunERto48PhNRx/4/M76
ohrI0Bul6uFVvRFT0yjsAyXpvtIiPMKJZU80YwrEnGSn0f8ZCQftP6qLwrVQGjax
idSB9OwDhOVk3OWSRYO0gF1G+xN+TegJ+Z7ZgZ+6jDpoVMP9JiX77+NAJgm4uH2/
Kgikyg/52WAqiu8l6xD5EPXX+4wCRa653BjSzJqut6B7hYuGwP09oI/+IpmQtkw8
vzqlaGlvW7G+wxY9Gg08gxCJIzpXMaZnw6cOLWDGlYzEx4V/6rUnjEDu/iSq2JTe
qYtahB+2hrv88xiHq3ezUTfpGL0Qs/Oa4J7gqENZiu5erTFfQ009JA/UVOx/ow9m
DQwFTN9Pi23M1QLNy6YnAGGGLGOQUx45NE6ck4D+5vfz3shu0JM6WXPGbGwObLZm
4r03f6ipIRLYq+FH3wYYpzJASbX+8+1iK5HrWOMB75Qfz9fcgQxD7h2n386BbWSm
I211lSxOS4u7eqs96WdJ
=OoaR
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
