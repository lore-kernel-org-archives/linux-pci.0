Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:45471 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753926Ab1KWWqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2011 17:46:08 -0500
Date: Wed, 23 Nov 2011 14:47:35 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Tejun Heo <tj@kernel.org>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: Crash with sata_sil24 driver
Message-ID: <20111123144735.64dc9f05@jbarnes-desktop>
In-Reply-To: <20111123162937.GF25780@google.com>
References: <CAHM4w1kc+5aYWH-09BPTXZdo8+iguFjORKs7mMhG7hea2UU8yQ@mail.gmail.com>
	<CAHM4w1nZ7GgutiuDiTCKu9wUuphn8qOiWgmCYVXXvwW1q8CgoA@mail.gmail.com>
	<20111122150613.GA322@google.com>
	<CAHM4w1nsNTQmAL-0d76O9cYXjNbiq-0f60Y3emWO2yf7HyFWDg@mail.gmail.com>
	<20111123162937.GF25780@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/sp5Z2wuOEZ3yjaNUeOKh6uo"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/sp5Z2wuOEZ3yjaNUeOKh6uo
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Nov 2011 08:29:37 -0800
Tejun Heo <tj@kernel.org> wrote:

> (cc'ing Russell, hello)
>=20
> The original thread can be read from
>=20
>   http://thread.gmane.org/gmane.linux.usb.general/54878/
>=20
> On Wed, Nov 23, 2011 at 10:49:00AM +0530, Pratyush Anand wrote:
> > Hello Tejun,
> >=20
> >=20
> > On Tue, Nov 22, 2011 at 8:36 PM, Tejun Heo <tj@kernel.org> wrote:
> > > Hello,
> > >
> > > (cc'ing Jesse)
> > >
> > > On Tue, Nov 22, 2011 at 04:40:40PM +0530, Pratyush Anand wrote:
> > >> > I am using various PCIe card based on Silicon Image 3124/3132 to
> > >> > test my PCIe host. This card is working with most of my host contr=
oler.
> > >> > I use sata_sil24 driver to enable the card, with one modification =
of
> > >> > commenting line [pcie_set_readrq(pdev, 4096);]
> > >> >
> > >> > I had sent a patch for it , which is still unanswered.
> > >> > http://comments.gmane.org/gmane.linux.kernel.pci/10300
> > >
> > > Yeah, that's something lifted from proprietary driver and it's
> > > likely to be wrong. =A0Jesse, is there a way to find out the safe
> > > maximum value for readrq? =A0I'm a bit reluctant to drop it as pcie
> > > variants of these chips are bottlenecked on the host bus pretty badly.
> > >
> > >> > Anyway, this mail is regarding another issue.
> > >> >
> > >> > I am still having problem when I use above driver (with above patc=
h),
> > >> > in following
> > >> > situation.
> > >> >
> > >> > My SOC is having cortex-a9 dual core. When I work with CPU freq 500
> > >> > MHz, it works
> > >> > well. But with 600 MHz it crashes. Crash log is at the end of mail.
> > >> >
> > >> > I did further debugging. I found that if I put some delay after
> > >> > calling of sil24_init_controller(host); in function sil24_init_one=
, it
> > >> > works well.
> > >> >
> > >> > My question is.
> > >> > does sil24_init_controller insure perfact initilization?
> > >> > or we missing to check some status register which might be needed
> > >> > before ata_host_activate.
> > >> > ------------------------------------------------------------------=
---
> > >> > Modules linked in:
> > >> > CPU: 0 =A0 =A0Not tainted =A0(2.6.37-lsp-3.2.2-rc-dirty #7)
> > >> > PC is at sil24_scr_read+0x38/0x50
> > >> > LR is at sil24_port_base+0x14/0x2c
> > >> > pc : [<80255e10>] =A0 =A0lr : [<80255d44>] =A0 =A0psr: 80000013
> > >
> > > Hmm... this is weird. =A0All init happens in the same thread. =A0Ther=
e's
> > > no race condition involved here. =A0I'm not too familiar with arm. =
=A0Can
> > > you please track down what is causing the crash? =A0ie. is it memory
> > > access to kernel data structure or io region?
> >=20
> > It  is accessing SATA Controller registers rather kerenl data struct
> > at the time of crash.
> > It crashes when it tries to read SCR_CONTROL register.
> > Its really strage that same register become accesible if a delay of 10u=
s is
> > put after sil24_init_controller.
>=20
> Weird, that basically means that somehow pci_iomap() isn't
> synchronous.  ie. you need to way some time after pci_iomap() before
> being able to access the mapped address.  Seems like arch / pci
> weirdness.  Jesse, Russell, any ideas?

As Russel said, pci_iomap shouldn't be async.  But maybe something else
in the init function is doing a chip reset or causing the chip to go
off into the weeds for a short time?  That's generally the cause of
target timeouts for PCI devices.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/sp5Z2wuOEZ3yjaNUeOKh6uo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOzXgHAAoJEIEoDkX4Qk9hzDsQAMJZAWJlf86u+oEguwMB7fDq
Uvli/yxYE/mbzJoeBxnEbXlCstJP/rqvPctHjG+tsaIwRSvPshnAE8S94xfIn/RW
BWdeU3TowVb0Y6aYO/5B9azrnSy17DjBKLOc9bkQSGoHyI0pE6z+/x+6I6vLBhJX
qpvvC/h3iYGvNhlfHpjI2x4qPbCtEGjrFTKHQuNHJDnKA4TyQ1xxQLw8U/tHFo8H
iS66phni1m7l5Rcu8Q0SH0UEx3B1iZtIoQ9TeQrgFIyLKlzEHOaJv+BiyrkZ2DeE
07y5SrYRH66m20cMxJ2Ruv7YA5/ixajJEuzmTDFqYQPAr96+Wib+dt0QXcB61XND
60GKHNawl7nBHtpCNcj1OQ5sAiHBVcD1sxP1s5MuKKyOEvA32hP+gCcL0Uwc/nWY
EDT+/sNdhKzwfOU061W7gF5TULCOCHmiuztEYFN2dYb9zL08wa2H9nVbYqFiVdz1
pGbwxOGAWz58ZCjXpWd8RAfNxbRf5e/FcDCvjl0DcYg1ADr4EkLPHDf3NN3gSdwo
MVEzEJu/Jwb9yzQk7K2IE6qMBqIlTXbOXQiHdouyChE42nchkgUBm0WyDKzyuFbc
GX/+yggsHsTQAjJg/Ax0aKxFcan8w3cb7PkTBq4Kmev4kBBNlyZJLmEai1wVbOKI
2AJee/E1D25mmLGoUtiu
=nTtA
-----END PGP SIGNATURE-----

--Sig_/sp5Z2wuOEZ3yjaNUeOKh6uo--
