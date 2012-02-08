Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:38747 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751503Ab2BHGPA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2012 01:15:00 -0500
Date: Wed, 8 Feb 2012 08:14:54 +0200
From: Felipe Balbi <balbi@ti.com>
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "balbi@ti.com" <balbi@ti.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <20120208061452.GF3707@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
 <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677FC6@US01WXMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OtZJUqNUNrB9XA/T"
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE801D5677FC6@US01WXMBX1.internal.synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--OtZJUqNUNrB9XA/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, Feb 07, 2012 at 02:19:49PM -0800, Paul Zimmerman wrote:
> > -----Original Message-----
> > From: Paul Zimmerman
> > Sent: Tuesday, February 07, 2012 1:16 PM
> >=20
> > OK, I will poke around and see if I can find an existing driver to use =
as
> > an example.
>=20
> Hi Felipe,
>=20
> Can you explain a little about how the runtime_pm stuff will work in
> the DWC3 driver, disregarding the HAPS platform for now.
>=20
> For example, if the device is a PCI device, won't the PM ops need to
> be part of the struct pci_driver in the dwc3-pci module?
>=20
> If so, how will they be able to communicate with the routines in the
> dwc3 module? Or if not, how will that work exactly?

Ok, the way it works is that the e.g. PCI device is a parent device to
the DWC3. So, in fact, you will end up with two pm ops: one that only
knows about DWC3 and one that only knows about PCI.

The pm core guarantees that parent's e.g. runtime_suspend(), will only
be called after all children (in this case, only one) are suspended.
Likewise for resume.

So, what we need to do is to make one pm ops that knows everything the
power management features on DWC3 and another which knows about PCI,
then hook them up properly and whenever pm usage counter reaches zero,
dwc3's runtime_suspend() is called, then after that dwc3-pci's
runtime_suspend() will be called.

Just keep in mind that glue layer also needs to keep track of its own
usage counters, what I mean by that, is that on dwc3-pci probe you
should probably call pm_runtime_get_sync() and right before returning
=66rom probe, you call pm_runtime_put(). This will make sure that the PCIe
device is powered up when you need and can be autosuspended when you
don't need it anymore.

--=20
balbi

--OtZJUqNUNrB9XA/T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMhLcAAoJEIaOsuA1yqRE6jQP/3bFrXcP6ZKeiIq48ILGPsCh
EfRynknYJ6hJLvodUzPxUMbXxMS5KV2iqPSLhKxQw2W1FYTqWjpg4SVEgDOfx8y3
f1KbgFkNCmOhSoE67DdXHOKbIQre3kz2MIgaNQNM5/8NS+5gzyxCfxRxsoXEx4T3
xvqyyRTFwNSV5URAU2wBt1KDNOlr5AWHPtzPj6PxJiXuWfexg9ViUNUWzLAK9nJ0
qR2ZChhefQ2VvRtxegRh8buW6s9/JwfDJCbLYkaMtMXOcvVs5k8VFAkKO+hDzV3q
yVxCJKkJ3VdMWNXZkxoiWuZlRF1xbc/AgV3GSKB7AqZk8vKvT2bkECJJR2acOG4z
KNENVBeTt8ugqjZUVxeuRI+vaNKE6sJIPEGFSzZUksM5lgCknhoHbIL+WzTH1NWS
qIyx/ViFPzUF4PJaOPs4w7us8+bisiNDtXbE3YS2szino+N1xRU3PX6v3mVKRBm8
S2zfoNnfApWw1rQKpgm0ShDskTo7pJF1+pBRLRr6O/fKb/pSiT7U/RpSfgFQwAPA
xHCR/ZJesY6HQgM8VlbzqpqetJ57eDm0UYS2DQ7KbWJYsLG3TURHfLAxY/4HG1Hf
f+qlyBnAguqmbALKmr3peCzy5z6uAmgQs8vtvtMmL4CIO6IDAfQWYiqyD76X9T2E
DAihKSViP72Q616YafDo
=37bp
-----END PGP SIGNATURE-----

--OtZJUqNUNrB9XA/T--
