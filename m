Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50779 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab2HNFz4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 01:55:56 -0400
Date: Tue, 14 Aug 2012 07:55:42 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/10] resource: add PCI configuration space support
Message-ID: <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
In-Reply-To: <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 10:00:45PM -0700, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > This commit adds a new flag that allows marking resources as PCI
> > configuration space.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - new patch
> >
> >  include/linux/ioport.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index 589e0e7..3314843 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -102,7 +102,7 @@ struct resource {
> >
> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resource=
 */
> > -
> > +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration sp=
ace */
>=20
> What is the purpose of this?  It seems that you are marking regions
> that we call MMCONFIG on x86, or ECAM-type regions in the language of
> the PCIe spec.  I see that you set it in several places, but I don't
> see anything that ever looks for it.  Do you have plans to use it in
> the future?  If it really does correspond to MMCONFIG/ECAM, we should
> handle those regions consistently across all architectures.

The purpose is ultimately to obtain the MMCONFIG/ECAM resources assigned
to a PCI host controller. I've used this in the of_pci_parse_ranges()
and in the static board setup code to mark ranges as such. Perhaps
IORESOURCE_ECAM or IORESOURCE_MMCONFIG might have been better names. I
also just noticed that I'm not using this anywhere, but the plan was to
eventually use it with platform_get_resource(). However that doesn't
seem to work either because the lower bits of the flags aren't use for
comparison in that function.

Any other ideas how that could be handled? Basically what I need is a
way to mark a resource as an MMCONFIG/ECAM range so that it can be used
to program the PCI host controller accordingly. I don't know how these
are assigned on x86. I was under the impression that the MMCONFIG/ECAM
space was accessed through a single single address/data register pair.

On Tegra 20 this region can be anywhere in the upper 1 GiB of the 4 GiB
address space, while on Tegra 30 it can be anywhere in the lower 1 GiB,
so they can be freely assigned.

Thierry

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKeheAAoJEN0jrNd/PrOhEcAQAIFN7k1DjHENH+mEgHxbll8R
N53Uw5NbO7LDzvMdIOGThFDi6dLM8HV5qr7wHcCtubi+S2WE3aMa4nFyL3fbUNWc
9q/tVEpUd8/vronyeGerxKKEDq4UABq6FbfMKFxTKSrhzDs5ySyO50pjfbKO13Vm
xuW54fv5PcUK2VPyEoKnrqDxkWSMess4rU61HI9oEHMYiDvuvv48yFQJhBAg4mO8
UAxv2v/1TGdLGA2CoJVn2BI3K/19BrNqtcJjqlFANDW7gKCf1TeTnZ8Qnx23Ezxa
rxl94f6hek2VMQowiJ3xB4JGy+vDup9ViwZ17OfyelsrioTD7xa+sAlgpAgnC7b4
YoBlkFARDPFPM2jpys9C0xSSEb3a9ugBqCg8apsDPvggQg75h1IUNtYmhb1lJ0L4
T8VihxtsSfHPvXrD9lPdERH58belpdEzqdCoc4iNzrmmD+2D02vpuuhl38Q3iQ1S
EAnkVt0Me3AbJNEyK7TO+iVdB1J5jwfbaMHRAnNK8pioxj8XX4lY8Jlos70CZJNZ
CQ7BGIq/vIkVG/tHslHpv3CmqO8bpsQevUc4D2GIYScSnnYBWUQcRu+TNwCoRz2G
ml40FIi5huWoIYE87x6xmBG7Tmwb+QIyjv51L4/FSg1FyxTt5hpQHWp7C90oqYCz
7id+DhTJiQkzW17D+j2d
=7JD/
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
