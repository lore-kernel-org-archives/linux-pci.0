Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:46758 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757363Ab2CBSRg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2012 13:17:36 -0500
Date: Fri, 2 Mar 2012 10:04:50 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Disable wakeup during shutdown for devices
 not enabled to wake up
Message-ID: <20120302100450.5752ff2f@jbarnes-desktop>
In-Reply-To: <20120302093712.6cd513a3@jbarnes-desktop>
References: <201202070050.35931.rjw@sisk.pl>
	<20120302144427.GD31240@electric-eye.fr.zoreil.com>
	<20120302093712.6cd513a3@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/XJZ=nW/3ffyBPy4+dp+g_dE"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/XJZ=nW/3ffyBPy4+dp+g_dE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Mar 2012 09:37:12 -0800
Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> > The device driver can monitor .runtime_{suspend / resume} activity
> > and take appropriate action in .shutdown(). Sameer Nanda has sent
> > such a patch (see below). I am not sure this is the adequate fix:
> > 1. the driver ought essentially to perform the hardware part of a
> >    .runtime_resume() on its own behalf. Mildly engaging.
> > 2. by the same line as above, could it make more sense to call
> >    pm_runtime_resume() in driver/base/core.c::device_shutdown ?
>=20
> I thought there would be a more elegant way of increasing the device
> use count on entering .shutdown, either from the wifi core or at the
> driver level, so you don't have to track things with a separate flag.
>=20
> Rafael?

s/wifi/net of course.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/XJZ=nW/3ffyBPy4+dp+g_dE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUQvCAAoJEIEoDkX4Qk9hiQUP/2ZFsPscQHShg6VlWjQ7232t
UURE1BTtei+jF1GGjoHdAQ47Az35n4BuzBUStuuNSZWKqPDv2tG6ceK86gKnxoEs
fcvCfieuFrwHsWz8nglC6eP1+hvIDeZgPSNjw9nLRnNQUOYkxzcKIzbBsesJ/Cxw
aWaTWxMAgT1OVudPojQxDfVlNwPmWbhrK637gEgISJhTRHBM01er8DIP9hXXgG79
bhD9C6QQHY5VKylTCVIhBsADPDljVmjd56+6rE+8LyBfwXc8YoYIAVgbnZub4I5Q
0yuxg/WEHabhjFJWv8iPuNzDIpPdPuI1n+tvDA0P7w6dBWLp6MAV3XW9t0KytKbR
ZzT23rJRlIXbX0UrLRU0CioAP2KGCo6w7qsLyK4uan+ytPYpAePig/ZgVXyQTuTj
oLl8PjOeHxvCxazaIbt/YnWZQJKbVHtxsVod9grlIwLh8XqKHLEOtqtGxJdT0qDw
x9DjqYplcmyf3xKTfovY1kMAMtEkTBqbpZv+0pwUOrkje9t4gd8QMGvKd8QzSb2k
bSw/zfY3ssEj4bFYcA+u+olGYnlWxdvxB39pXO78vDE0t6EavHstmkTtmvpEJazi
+KdogM506P0Fz6Y+Be3tj38gILqUo/YbcT0OAVYVjFgiAo5EoO7fdUUcFPezh3oc
4Nj6gXjVPg5YFFB10WhV
=tajG
-----END PGP SIGNATURE-----

--Sig_/XJZ=nW/3ffyBPy4+dp+g_dE--
