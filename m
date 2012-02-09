Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35315 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099Ab2BIIHY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2012 03:07:24 -0500
Date: Thu, 9 Feb 2012 10:07:18 +0200
From: Felipe Balbi <balbi@ti.com>
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "balbi@ti.com" <balbi@ti.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <20120209080718.GQ1121@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
 <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677FC6@US01WXMBX1.internal.synopsys.com>
 <20120208061452.GF3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5678673@US01WXMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nHJAUhyIZkPvF01C"
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE801D5678673@US01WXMBX1.internal.synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--nHJAUhyIZkPvF01C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2012 at 12:43:51PM -0800, Paul Zimmerman wrote:
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Tuesday, February 07, 2012 10:15 PM
> >=20
> > On Tue, Feb 07, 2012 at 02:19:49PM -0800, Paul Zimmerman wrote:
> > > >
> > > > OK, I will poke around and see if I can find an existing driver to =
use as
> > > > an example.
> > >
> > > Hi Felipe,
> > >
> > > Can you explain a little about how the runtime_pm stuff will work in
> > > the DWC3 driver, disregarding the HAPS platform for now.
> > >
> > > For example, if the device is a PCI device, won't the PM ops need to
> > > be part of the struct pci_driver in the dwc3-pci module?
> > >
> > > If so, how will they be able to communicate with the routines in the
> > > dwc3 module? Or if not, how will that work exactly?
> >=20
> > Ok, the way it works is that the e.g. PCI device is a parent device to
> > the DWC3. So, in fact, you will end up with two pm ops: one that only
> > knows about DWC3 and one that only knows about PCI.
> >=20
> > The pm core guarantees that parent's e.g. runtime_suspend(), will only
> > be called after all children (in this case, only one) are suspended.
> > Likewise for resume.
> >=20
> > So, what we need to do is to make one pm ops that knows everything the
> > power management features on DWC3 and another which knows about PCI,
> > then hook them up properly and whenever pm usage counter reaches zero,
> > dwc3's runtime_suspend() is called, then after that dwc3-pci's
> > runtime_suspend() will be called.
>=20
> Thank you! That was the piece of the puzzle that was missing. OK,
> I'll take a crack at implementing the pm ops for dwc3 and dwc3-pci.

no problem ;-) There's very good documentation under
Documentation/power/ and the folks at linux-pm@vger are very helpful too
;-)

> > Just keep in mind that glue layer also needs to keep track of its own
> > usage counters, what I mean by that, is that on dwc3-pci probe you
> > should probably call pm_runtime_get_sync() and right before returning
> > from probe, you call pm_runtime_put(). This will make sure that the PCIe
> > device is powered up when you need and can be autosuspended when you
> > don't need it anymore.
>=20
> I see that Alan had a correction to this part in a later email.

Indeed, I was not aware of the PCI differences :-) I will take care of
that on the dwc3-omap.c though ;-)

thanks

--=20
balbi

--nHJAUhyIZkPvF01C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM361AAoJEIaOsuA1yqRE4BoP/jwNNQHP3Xwf6n5uLOh9sxHM
X0d2N7mB6VTBc+RM+vsXRPaMDIYZdkNXnjW7SxXD7Hoz8HZADw1gdyAm2wGreJjz
CO6AX7rpyrYCiiYpUyY3WzD1ZnZBIDz4votk2tlpNvPtEwblQdDUxxZ22mTTQmfM
bWMvGgsh/XE6OhPRZDqILPd7/0bNuJPJiQkcBXH8C3LPRjI8Pl00Nay+SAr1oGIZ
ZmZn8uc4LUIofyvfUNarp7GCdx82+9sHZakzdR7FzJHJ+rUQzkGoFYfzHrx5JLmQ
vXN8XiGAp/sS1C2zgvaJrkerPyCp3CvMPUdPUp+CVz4tuaLKaEo35590ZcQ7MbQe
K4NkZg8iC4VFYTXf/Ave2d8l614VI1xKYVnqNz4WOxJc7HuxwF2Kkl0apMRpuOYd
uXuvpHDAujsAc/Bw7+BKA6VFVww36cRZqOcNbUeitmsiaUkYC0GWmZE/tqTkTKIx
OSzYGH4td5YP6ChyfdjSYIepGi6yUd9I1KiKpp8GAHyP/HdDovL8e0N/6nC1ev4w
JVht/VBELrhSmsOtINU781hybcGA2b0wkQ2xLutK5DOoh1aoLUK8slZfQIh9/0gq
VIBa6m34S0vubQaxYnYYbkg4D7nwhgO4I168JxPUNg3g2bfa3B6Ueq6WhLnJIi6X
Bh4epkDoRvNBNN+W2GVS
=p8T0
-----END PGP SIGNATURE-----

--nHJAUhyIZkPvF01C--
