Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60905 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2INSze (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2012 14:55:34 -0400
Date: Fri, 14 Sep 2012 20:55:02 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
Message-ID: <20120914185502.GA14065@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo7v+i8i=mXCs7ZW8DtGTDN_4AEntwYLqGG8FcCzweySFg@mail.gmail.com>
 <20120815192814.GA12870@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6cjOzJegJqXzmk59DChExcbLK1sOhwyAyQL4FZkTN21A@mail.gmail.com>
 <504A1EA2.9030008@wwwdotorg.org>
 <20120907170024.GA16114@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Y4QXfahRkBoJ_jmKy6VAYqOzixTmCPkwSATfO+rzVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
In-Reply-To: <CAErSpo4Y4QXfahRkBoJ_jmKy6VAYqOzixTmCPkwSATfO+rzVxg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2012 at 10:22:28AM -0700, Bjorn Helgaas wrote:
> On Fri, Sep 7, 2012 at 10:00 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Fri, Sep 07, 2012 at 10:19:46AM -0600, Stephen Warren wrote:
> >> On 08/15/2012 01:42 PM, Bjorn Helgaas wrote:
> >> > On Wed, Aug 15, 2012 at 1:28 PM, Thierry Reding
> >> > <thierry.reding@avionic-design.de> wrote:
> >> >> On Wed, Aug 15, 2012 at 10:06:27AM -0700, Bjorn Helgaas wrote:
> >> >>> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> >> >>> <thierry.reding@avionic-design.de> wrote:
> >> >>>> When using deferred driver probing, PCI host controller drivers m=
ay
> >> >>>> actually require this function after the init stage.
> >> >>>>
> >> >>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >> >>>> ---
> >> >>>> Changes in v3:
> >> >>>> - none
> >> >>>>
> >> >>>> Changes in v2:
> >> >>>> - use __devinit annotations
> >> >>>
> >> >>> Your original patch removed __init completely.  Here you change it=
 to
> >> >>> __devinit.  That means we decide whether to discard the function b=
ased
> >> >>> on whether CONFIG_HOTPLUG is supported.  But I think your point is=
 not
> >> >>> about hotplug; it's merely that we should be able to scan a PCI bus
> >> >>> after init-time.  We ought to be able to do a late PCI scan even if
> >> >>> hotplug is not supported.
> >> >>>
> >> >>> Therefore, I'd be inclined to remove __init completely unless you =
have
> >> >>> another reason for preferring __devinit.
> >> >>
> >> >> I thought __devinit would resolve to nothing if HOTPLUG is defined =
and
> >> >> __init otherwise. That seemed more appropriate. However you are rig=
ht
> >> >> that it is useful to always have it available, so I'm fine with rem=
oving
> >> >> the annotations altogether. Do you want me to follow up with a patc=
h? Or
> >> >> can you just take the first version? I'm not sure if it still appli=
es.
> >> >
> >> > You're right about how __devinit works.  It's just that I don't think
> >> > hotplug is actually relevant here.  We're trying to make
> >> > pci_fixup_irqs() work after init, whether it's because of hotplug or
> >> > simply because the arch scans host bridges after init.
> >> >
> >> > I applied this to my "next" branch.  Thanks!
> >>
> >> Bjorn, I don't see this patch in next-20120907. Did it get dropped for
> >> some reason?
> >
> > Yes, it turns out that dropping the annotations causes lots of section
> > mismatches on other architectures. See here[0] for the details. I think
> > the solution to the issue would be to either remove HOTPLUG altogether
> > and drop __devinit and __devexit annotations or update all architectures
> > to fix these warnings. I think Bjorn and I settled on the latter because
> > it's obviously less intrusive. I've been busy building toolchains for
> > all the PCI architectures and I think I have all of them. I'll just need
> > some more time to build, find and fix any remaining section mismatches.
>=20
> Greg KH is actively removing CONFIG_HOTPLUG altogether -- see
> https://lkml.org/lkml/2012/9/4/489
>=20
> That will make __devinit resolve to nothing in all cases, and we'll
> eventually remove __devinit completely.  So we don't want to convert
> __init to __devinit; we have to remove the __init altogether.  I think
> that means we have to update all arches first to avoid the section
> mismatches.
>=20
> So I think Thierry is on the right track:
>   1) Change all arch pcibios_update_irq() implementations (and
> probably a few other things) to be non-__init
>   2) Change pci_fixup_irqs() to be non-__init

Okay this wasn't as much work as I had thought. It turns out that there
very few dependencies other than pcibios_update_irq(). Actually none at
all. In addition some of the architectures already had these annotated
with __devinit. Luckily those were the ones I wasn't able to build a
cross-compiler for. Note that I resolved to converting all annotations
=66rom __init to __devinit first. I'll try to find out what exactly Greg
is planning to do. If it turns out that the plan is to just remove the
__devinit incrementally I could just drop all of these. Otherwise maybe
a better option would be to leave them in and remove them all at once
when the HOTPLUG symbol is removed.

Furthermore it seems like almost all implementations are the same, so I
was going to include a patch that moves the common implementation to the
PCI core and make it a weak symbol so architectures would still have the
possibility to override it.

The only exception to this is 64-bit SPARC, which apparently doesn't do
anything in pcibios_update_irq(). I wonder if it would hurt to just use
the generic implementation anyway, which just sets a byte in the
configuration space. That should work regardless of architecture, right?

Unicore32 and ARM also output a debugging message and maybe it would be
okay to include that with the generic implementation as well. Do you
have any objections?

Thierry

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQU32GAAoJEN0jrNd/PrOhEW8P/RhEWcMJI/0qetpnRQ957pCi
wuT5F8tinimMA4ukhDqEg1OdDe/yPBFFQCDaVwuZDjL95ATa27tRH+5tEoTNTaRi
m+B4szXmjgPbN64vERfNwE5/63WIHoybVGqd8AwlP3MITwm1bQhvZ41Yt501QHC4
hIqfgjE97lX9Yh7pQv4RKnMD7B1JES8hNyV728TNU66XCIjqqx9U2o0k4haVdKFC
Z0KF2UhdZkeF/Cv2c67XY+giciOfvMD1auoIXHqODE643IliCJw6UuOPCpOAX0CP
vcpn3Dw9i2QCq3zcNqp2h5KAWwbPBSVneG3J+tn2gauDgGAhbIsv7L+jzlOKUI0S
JlnuQUHURXUJWLWUFQAtOAiR8KYs/EPnkBlEk+LQ1PUNKRiklJlPSX9ofjIKDC8R
Gek/gcjCjLzee9fSSqp3qfDpURNZuT79wIzWZmXMTbYh/NXph7iJVbdsuH5LHqWh
wpj/M0Hp2/rl5tA51qa/6v2L7eF9KyTYkHI/LwFGJVTtA29E91Z6wM99losM3k7K
GIujDDfc6Y0i+6rUGccu30AoVDatvkSwLbwQ95JabV3DskCHBiOTlcMTIKCBzRrJ
58mL/xi+N4l5fnx3zX4xepdzOmiTkyV43xpkT5IYn7y2SxSR+akIjuczmZ2K0DcY
3r4ON7bI15RQhq9EDJgt
=lRpg
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
