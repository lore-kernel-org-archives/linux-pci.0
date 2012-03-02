Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:60166 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750885Ab2CBRhR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2012 12:37:17 -0500
Date: Fri, 2 Mar 2012 09:37:12 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Disable wakeup during shutdown for devices
 not enabled to wake up
Message-ID: <20120302093712.6cd513a3@jbarnes-desktop>
In-Reply-To: <20120302144427.GD31240@electric-eye.fr.zoreil.com>
References: <201202070050.35931.rjw@sisk.pl>
	<20120302144427.GD31240@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Ez4uIigBLreH/xSB1izBxRr"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/Ez4uIigBLreH/xSB1izBxRr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Mar 2012 15:44:27 +0100
Francois Romieu <romieu@fr.zoreil.com> wrote:

> Rafael J. Wysocki <rjw@sisk.pl> :
> [...]
> > If a PCI device is enabled to generate wakeup signals (PME) when put
> > into a low-power state by runtime PM, it will be still enabled to
> > generate those signals after the system shutdown, unless its driver's
> > .shutdown() callback takes care of the wakeup signals generation
> > setting.  Moreover, there are devices that are not enabled to wake
> > up the system and that are configured by runtime PM to generate
> > wakeup signals so that (runtime) remote wakeup works with them.
> > Those devices should be reconfigured during system shutdown so that
> > they don't generate wakeup signals, but at least some drivers don't
> > do that.  However, that very well may be done by the PCI core so
> > that drivers don't have to worry about it.  For this reason, modify
> > pci_device_shutdown() to disable the generation of wakeup events for
> > devices not supposed to wake up the system.
>=20
> On a tangent side, if register writes are ignored by the PCI device
> after its .runtime_suspend() handler has been called, whose
> responsibility is it to bring back the device in a state from where
> the .shutdown() callback can operate ?
>=20
> The r8169 driver exhibits this problem. Its .runtime_xyz() callbacks
> are called on link activity. Thus, after a link loss - or no link at
> all - .runtime_suspend() and an ineffective .shutdown(), the device is
> brought back up as soon as the link recovers.
>=20
> The device driver can monitor .runtime_{suspend / resume} activity
> and take appropriate action in .shutdown(). Sameer Nanda has sent
> such a patch (see below). I am not sure this is the adequate fix:
> 1. the driver ought essentially to perform the hardware part of a
>    .runtime_resume() on its own behalf. Mildly engaging.
> 2. by the same line as above, could it make more sense to call
>    pm_runtime_resume() in driver/base/core.c::device_shutdown ?

I thought there would be a more elegant way of increasing the device
use count on entering .shutdown, either from the wifi core or at the
driver level, so you don't have to track things with a separate flag.

Rafael?

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/Ez4uIigBLreH/xSB1izBxRr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUQVIAAoJEIEoDkX4Qk9hHC4P/j88hNKYXoG/EcRHVsgzqigU
pxuUXLANnlAYai+2PIw8UyfC/xV8LanJsJbqsOCqP0QUAaoHE7WDr4Q8ZsGIE1B9
LTi9u+HLA2YpC5KNb6eZtevM7JSPe4LyDN58mxgn/bKCk6c/KvnIoSkOH1GznUBD
k10euyJSG/rMaWJfULDhmXgp8m4ESSw5J/PoibAgB+OtdRt6kdu13cuALL0/517P
tMWpagTlFGfWj8SYoe5/FgooRrVPcjjHIsmeWKojnOArIzMDr7qeA4L8Ap+E56aj
GeXGy14jh2I3t9YK7hapWTmY71bPB8ils+zQmqezfItkbxDnaiw3qY0P4X/FahZG
vfpYY/Z5adE/OLXJROJk17Ah/Ft/tgFttHZfu5Y9kPuFFuGtTLuxn62GPPTBcYgQ
qqfgjs7eAg4i2pMTwdUEemBrHAOs2SFKyxYvlk26QKUXYmVtURg75wwmvMXr+MAi
KAs2ObD6JbVCYHuU3kJ2n/Lzc5rthkzINwbAYmFZZcXRrBaYzFQ8tMGemfr81DJx
NKtdyi31zhvFHMLI2JZS1cl4hoYxFKrb/atlyREZ7Xoo4UkVb8mfSex3rZSpx5SP
sL4BP5A8MXnxdgxCasNIouxSvfmaskaUPvKneSsOJF5mScgFMW4YONwemQf7fq+k
uZEXKliN3SGdDfc3dgge
=+5gl
-----END PGP SIGNATURE-----

--Sig_/Ez4uIigBLreH/xSB1izBxRr--
