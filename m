Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60392 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754204Ab3I1C2m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 22:28:42 -0400
Message-ID: <1380335308.4430.109.camel@deadeye.wl.decadent.org.uk>
Subject: Re: [PATCH 2/2] PCI: Warn if power_state != PCI_D0 when write MSI
 message
From: Ben Hutchings <ben@decadent.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Date: Sat, 28 Sep 2013 03:28:28 +0100
In-Reply-To: <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com>
References: <1378974012-13364-1-git-send-email-wangyijing@huawei.com>
	 <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lO12aQ5AQPcY9DAf35SN"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-lO12aQ5AQPcY9DAf35SN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-09-27 at 15:03 -0600, Bjorn Helgaas wrote:
> [+cc Ben]
>=20
> On Thu, Sep 12, 2013 at 2:20 AM, Yijing Wang <wangyijing@huawei.com> wrot=
e:
> > When we setup MSI, if device power state is not equal to PCI_D0,
> > system will silently ignore writing MSI message, but pci_enable_msi()
> > still return 0 which seems setup successfully. So we should warn here
> > to help diagnose this issue.
> >
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> > ---
> >  drivers/pci/msi.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index aca7578..25ed59d 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -291,6 +291,8 @@ void __write_msi_msg(struct msi_desc *entry, struct=
 msi_msg *msg)
> >  {
> >         if (entry->dev->current_state !=3D PCI_D0) {
> >                 /* Don't touch the hardware now */
> > +               dev_warn(&entry->dev->dev,
> > +                       "current_state !=3D PCI_D0, ignore writing MSI =
message!\n");
>=20
> Is there a real problem here?  If there is a real problem, a printk
> doesn't help fix it.  If there's no problem, I don't see the point of
> this printk.
>=20
> I would expect that if the device is not in D0, we should remember the
> hardware updates that need to be made, and if the device returns to
> D0, we should apply the updates then.  If that's the case this is not
> an error and we shouldn't warn about it.
[...]

During system suspend all IRQ affinities are changed to the boot CPU as
other CPUs are disabled, and then I think they are reverted during
system resume.  This certainly used to be done while most devices were
suspended.  That's why we have to check for the device power state here.
If suspend/resume is still done in the same order then we shouldn't log
a warning about this.

Yijing, why not add a check for this in pci_enable_msi() itself if you
think it's that important to warn about?

Ben.

--=20
Ben Hutchings
Humans are not rational beings; they are rationalising beings.

--=-lO12aQ5AQPcY9DAf35SN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUkY+zOe/yOyVhhEJAQrzXBAAyYJgW7ZGtOl8Rgm2DquPWM6wMYJhKdA/
Z4eqmeSw4GbIee59XKn1A5Is86NTB5Z77Z0ynkA7k33tOr/dzne7XpAozhqEW0aH
ibVlEyjMs7veqeew7GF4c5WXaW9PPrY5LGpt5N6GITXFQ0saptwvHK3TFFGj/1Cb
692yzgCnqhG8OXKXFXVsNk7OGwhzl5NCSgjU3t0jO0JTzJxtIJh67D3rWHeFds9j
psOpkVQV9xxv5B/3xBLt1qfPT9htKkdN9HELqO0FAJnE+K+BqkpeGeMVkRMbXaQh
ubCQWoq2jnvFH7fkLf0p/4FByivYaLy4gXBIQjH3YnDvoTeQ6DBYO4TAB7ib3jEy
B7ZRKdgLHuyR+MsfmlyjJ4BoOjOqTFNGlmqmko+Bu6WOEgqlm5fr+91Gay517ht4
VhrApbhaP8DX05/Wd9Bmy6eIuCkpb/pXF1RJXcNJoiImqQsmhfbLqUk9cPGqd6oE
geVGHnCJ/3uUNfg51XNwLMo+z3BsYmAMYqEOV74aOrauRmtYG1Ltlsjc5l+eratc
BnTZSGNqQU693N6qLFZPpdYkXoOznhvcCmd4kF0vxTKU4ecbEAUuG5rGfk4ljPyh
+DvARiHN5XPaVvXJ3ll61zcDpR2xHCeXNh1D9BhEpu6yGaXLaKUH9bKOgSq4CpqC
6XJmO9QdKY4=
=ZJMl
-----END PGP SIGNATURE-----

--=-lO12aQ5AQPcY9DAf35SN--
