Return-Path: <flyos@mailoo.org>
Return-Path: <flyos@mailoo.org>
From: Pierre de Villemereuil <flyos@mailoo.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Date: Sat, 15 Oct 2016 10:46:44 +1300
Message-ID: <18007487.pN64mJfts8@flyosflip>
In-Reply-To: <Pine.LNX.4.44L0.1610131709160.1822-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1610131709160.1822-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi!

I've managed to build the patched kernel on OBS, install the package=20
and boot! \o/

And I can confirm that the patch indeed fix the issue!

The kernel was booted without the usb.autosuspend=3D-1 option, of=20
course.

Thank you guys!

Cheers,
Pierre.

Le jeudi 13 octobre 2016, 17:11:46 NZDT Alan Stern a =C3=A9crit :
> On Fri, 14 Oct 2016, Pierre de Villemereuil wrote:
> > Hi!
> >=20
> > I've branched the kernel package on the OpenSUSE Build Server,=20
I'll
> > try to apply the patch there (this ought to be cleanest method).
> >=20
> > Starting from the root of the kernel tarball, the patch should=20
be
> > applied to drivers/pci/pci.c, am I right?
>=20
> You just cd to the top directory of the kernel source, and do
>=20
> 	patch -p1 <filename
>=20
> where "filename" is the contents of the email message containing=20
the
> patch.  Or if you want, since the patch is so small, you can=20
simply
> edit the file by hand to add in the new lines.
>=20
> Alan Stern
