Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59945 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025Ab2HNSB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 14:01:58 -0400
Date: Tue, 14 Aug 2012 20:01:42 +0200
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
Message-ID: <20120814180142.GA9430@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-6-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo4qg45brVRwEbw3=R04VsbnvUowSMWcT+M6VoAxbf3Cqg@mail.gmail.com>
 <20120814055542.GB16181@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <CAErSpo6LYpkC5wop53S1r1z3ov4+w4soqrQARzbbouVs1trzUg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2012 at 10:38:08AM -0700, Bjorn Helgaas wrote:
> On Mon, Aug 13, 2012 at 10:55 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Mon, Aug 13, 2012 at 10:00:45PM -0700, Bjorn Helgaas wrote:
> >> On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > This commit adds a new flag that allows marking resources as PCI
> >> > configuration space.
> >> >
> >> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> >> > ---
> >> > Changes in v3:
> >> > - new patch
> >> >
> >> >  include/linux/ioport.h | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> >> > index 589e0e7..3314843 100644
> >> > --- a/include/linux/ioport.h
> >> > +++ b/include/linux/ioport.h
> >> > @@ -102,7 +102,7 @@ struct resource {
> >> >
> >> >  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> >> >  #define IORESOURCE_PCI_FIXED           (1<<4)  /* Do not move resou=
rce */
> >> > -
> >> > +#define IORESOURCE_PCI_CS              (1<<5)  /* PCI configuration=
 space */
> >>
> >> What is the purpose of this?  It seems that you are marking regions
> >> that we call MMCONFIG on x86, or ECAM-type regions in the language of
> >> the PCIe spec.  I see that you set it in several places, but I don't
> >> see anything that ever looks for it.  Do you have plans to use it in
> >> the future?  If it really does correspond to MMCONFIG/ECAM, we should
> >> handle those regions consistently across all architectures.
> >
> > The purpose is ultimately to obtain the MMCONFIG/ECAM resources assigned
> > to a PCI host controller. I've used this in the of_pci_parse_ranges()
> > and in the static board setup code to mark ranges as such. Perhaps
> > IORESOURCE_ECAM or IORESOURCE_MMCONFIG might have been better names. I
> > also just noticed that I'm not using this anywhere, but the plan was to
> > eventually use it with platform_get_resource(). However that doesn't
> > seem to work either because the lower bits of the flags aren't use for
> > comparison in that function.
> >
> > Any other ideas how that could be handled? Basically what I need is a
> > way to mark a resource as an MMCONFIG/ECAM range so that it can be used
> > to program the PCI host controller accordingly. I don't know how these
> > are assigned on x86. I was under the impression that the MMCONFIG/ECAM
> > space was accessed through a single single address/data register pair.
>=20
> The legacy config access mechanism (CF8h/CFCh registers described in
> PCI 3.0 spec sec 3.2.2.3.2) is a single address/data pair, but this is
> mostly x86-specific.  The ECAM mechanism (described in the PCIe 3.0
> spec sec 7.2.2) is not a single address/data pair; instead, each byte
> of config space is directly mapped into the host's MMIO space.
>=20
> Here's what we do on x86 (omitting some historical grunge that
> complicates things):
>=20
>   - Discover the host bridge via a PNP0A08 device in the ACPI namespace.
>   - Discover the bus number range behind the bridge using a _CRS
> method in the PNP0A08 device.
>   - Discover the ECAM space for those buses via a _CBA method in the
> PNP0A08 device.
>   - Tell the config accessors (struct pci_ops) that the ECAM space for
> buses A-B is at address X.
>   - Enumerate the devices behind the host bridge by calling
> pci_scan_root_bus(), passing the config accessors.
>=20
> It sounds like you want a way to parse the resources at one point,
> saving them and marking the ECAM region, then at a later point, look
> up the ECAM from a saved list.  We don't do that on x86 because the
> config accessors keep an internal list of the ECAM area for each bus.
>=20
> We do of course want to put this ECAM space in the IORESOURCE_MEM tree
> because it consumes address space and we have to make sure we don't
> put anything else on top of it.  But we don't have any reason to
> describe the MMIO -> config space function in that tree.  From the
> point of view of the rest of the system, it's just MMIO space that's
> consumed by the PCI host bridge, just like any other device-specific
> MMIO area.

What I currently do is pass the ECAM space as a resource to the PCI host
bridge platform device. Regular and extended configuration spaces are
given by the third and fourth resources, respectively. If I understand
correctly, you're saying that nothing beyond that needs to be encoded.
In other words it is enough for the PCI host bridge driver to know where
to take the data from.

I'll have to see what this means for the DT binding. There are other
issues that I need to think about, like for example how to pass the ECAM
space from the PCI host controller to each of the two bridges via the
ranges property. This no longer makes sense in the current form, as the
ECAM covers the configuration spaces for devices of both bridges and
cannot really be split among them.

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKpKGAAoJEN0jrNd/PrOhUQsQAL0f9w9cA1RJjqCvQiu4hUnN
IF49DsuA2YM2O8FTZzvT12ziO3/QYyqDuPaq9UQEJwfoqBEnpeG6mG0Pb7sKAFhi
y6m6dA3AcXurrvfLsTYuZy+kj3aLWcBRxe1Zm1bA5Q769juAWQoKJ4nVpKzdZhtr
OFGIbbOC2cb4Q+ljmw/HjhKL0qSeOFW+VkE4mlAhxjBkf5Wz4BuedVJhJb/QiTP1
nGXdr3M0pq1myLfuasRT28kOGWOus0sM4AYBZnYQMAnTanKn3WjFl3xWbh1ag0w4
6e4ZPZpRHrILjPcSWWkbD7fJSCyFAd/CCIuaOKAj/ImDNiJguwZriffWIjrYcwSt
kk04VrzawY+YYZl25PgMgE0TSiaq65adyvX+8a66vPU6MyPMYIhq1zVWgN2FrcQJ
HmK62YgTipWLi/xW/RZ6lZHvsR8voitBrk8hr7RSRrzjL2NAT/3qYLkMr1PjTEmq
+/FrTzYLqYEJCiGHr5rqLJJz+mKXi3Y7eMV46uTClkBfG5s1gslZNLIHqERhylzR
iDqAEMN/C2S7/xN4T+kYXA4JvpsdyQmOzQmYaQyOkN2O/740ieklZAWT25k1vFmR
1rqOQojFCm/ZPaiPV/0V4UcPrFlVodIs12CZxV+MfkzZ9LgXmjxxhfRYpRW/FVcH
3HQemIta9nevWYybrf3x
=EU2E
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
