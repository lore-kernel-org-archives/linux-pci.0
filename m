Return-Path: <flyos@mailoo.org>
Return-Path: <flyos@mailoo.org>
From: Pierre de Villemereuil <flyos@mailoo.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Date: Fri, 14 Oct 2016 09:58:33 +1300
Message-ID: <1492262.TFAeDeKh1k@flyosflip>
In-Reply-To: <Pine.LNX.4.44L0.1610121420410.1376-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1610121420410.1376-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi!

I've branched the kernel package on the OpenSUSE Build Server, I'll=20
try to apply the patch there (this ought to be cleanest method).

Starting from the root of the kernel tarball, the patch should be=20
applied to drivers/pci/pci.c, am I right?

Cheers,
Pierre.


Le mercredi 12 octobre 2016, 14:23:35 NZDT Alan Stern a =C3=A9crit :
> On Wed, 12 Oct 2016, Pierre de Villemereuil wrote:
> > Hi!
> >=20
> > I'm sorry, I'm not savvy enough to know what to do with this (I=20
know
> > basics on how to code and compile, but I'm no dev). Could=20
someone
> > guide me through it?
> >=20
> > I gather this patch needs to be applied to some kernel module=20
code
> > which needs to be compiled and reloaded into my current kernel,
> > right?
>=20
> More likely you'll have to rebuild an entire new kernel, not just=20
a
> single module.
>=20
> Search the support site for the distribution you are using.  It=20
ought
> to contain reasonably thorough instructions on how to build and=20
install
> your own version of their kernel.
>=20
> Once you know how to do all that, I can tell you how the patch=20
should
> be applied -- that's the easy part.
>=20
> Alan Stern
