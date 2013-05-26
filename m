Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:54694 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295Ab3EZARH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 20:17:07 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so5567711pbc.30
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2013 17:17:06 -0700 (PDT)
Date: Sun, 26 May 2013 08:16:59 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liu Jiang <liuj97@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: add 0x prefix when printing the BAR registers
 position in __pci_read_base
Message-ID: <20130526001659.GA5937@pek-khao-d1.corp.ad.wrs.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
 <1369481787-21500-2-git-send-email-haokexin@gmail.com>
 <51A0E716.9050405@gmail.com>
 <CAErSpo6jT-o9O5VFFzjyw8Z79m31fYzBJjGBeZ8Y2X83Vndn2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <CAErSpo6jT-o9O5VFFzjyw8Z79m31fYzBJjGBeZ8Y2X83Vndn2g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2013 at 05:47:28PM -0600, Bjorn Helgaas wrote:
> On Sat, May 25, 2013 at 10:30 AM, Liu Jiang <liuj97@gmail.com> wrote:
> > On 05/25/2013 07:36 PM, Kevin Hao wrote:
> >>
> >> We print the BAR registers position in hexadecimal format, so it
> >> is more readable if 0x prefix is added. Also fix the following
> >> checkpatch warning:
> >>    WARNING: Prefer dev_dbg(... to dev_printk(KERN_DEBUG, ...
> >>
> >> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> >> ---
> >> v2: A new patch introduced in v2.
> >>
> >>   drivers/pci/probe.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 70f10fa..2505d5e 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -278,9 +278,9 @@ out:
> >>                 pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> >>         if (bar_too_big)
> >> -               dev_err(&dev->dev, "reg %x: can't handle 64-bit BAR\n",
> >> pos);
> >> +               dev_err(&dev->dev, "reg 0x%x: can't handle 64-bit BAR\=
n",
> >> pos);
> >>         if (res->flags && !bar_disabled)
> >> -               dev_printk(KERN_DEBUG, &dev->dev, "reg %x: %pR\n", pos,
> >> res);
> >> +               dev_dbg(&dev->dev, "reg 0x%x: %pR\n", pos, res);
> >
> > Hi Kevin,
> >     dev_printk(KERN_DEBUG) -> dev_dbg() is not an equivalent change, it
> > depends
> > on CONFIG_DEBUG and CONFIG_DYNAMIC_DEBUG.
>=20
> I did keep the "dev_printk" here for that reason.  I don't want that
> information to be missing from dmesg.

Obviously I neglected this difference. :-(
Thanks for the reminder and fix Jiang and Bjorn.

Thanks,
Kevin

>=20
> >
> >
> >>         return (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
> >>   }
> >
> >

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRoVR7AAoJEJNY7TDerrFxD+IH/Rq19mJhnhCcFfLTXl8vCODF
05q7kEzWDUL9VzgB5dNb8ozqSfnm+CWl25Gz065CFUfiRWOY2inLnYuE3D2BeE/k
o96fRa0ZDTFZ+LYcX6AMWC5hviNK0nERdIXg+QCG8fzzBaeocWi7xHkj0nqcKkLv
YokSTvdwgqQCt0BD5YAY1ovwm7Xyk3kEApFLLpu2yHHmHdcLr7sW40y+voXsTOgd
3+n/+IhzKXa27o04orthgwQs4cPFegAHeY3vFvrRH4DXRfSYXF44WRLh3QT067Dt
0T/DHI3oxvZmPIrUJrh2CchgZpUA06+oRXa1kavyeR7KaH5IZfcqz5nFOfZiuvg=
=WMam
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
