Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58306 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2HBGP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 02:15:27 -0400
Date: Thu, 2 Aug 2012 08:15:20 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120802061520.GE12241@avionic-0098.adnet.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50180547.9040603@wwwdotorg.org>
 <20120801063545.GA26791@avionic-0098.adnet.avionic-design.de>
 <5019611A.2060804@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
In-Reply-To: <5019611A.2060804@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 11:02:18AM -0600, Stephen Warren wrote:
> On 08/01/2012 12:35 AM, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 10:18:15AM -0600, Stephen Warren wrote:
> >> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> >>> This patch series adds support for device tree based probing of
> >>> the PCIe controller found on Tegra SoCs.
> >>=20
> >> Thierry,
> >>=20
> >> I think one thing that would help here would be to split up this
> >> series into one per subsystem, and to get all the dependencies
> >> merged by the respective maintainers. Preferably, each subsystem
> >> would export a stable branch (perhaps consisting of just these
> >> patches) that I can then merge into the Tegra tree and use as a
> >> basis for the PCIe driver itself. Hopefully this approach will
> >> get more traction on all the non-Tegra changes. Does that sound
> >> like a good plan?
> >=20
> > I don't understand. The series is already split up into
> > per-subsystem patches. I just didn't want to post them separately
> > so everybody on Cc would be able to see the big picture and the
> > reason why the patch was required.
>=20
> There are separate patches that touch the different subsystems, but
> they're all scattered throughout the one series, rather than having e.g.:
>=20
> * a series for the PCI tree
> * a series for the ARM core tree
> * a series for the OF/DT tree
> * a series for the Tegra tree, which indicates it depends on all of those.
>=20
> I'm wondering if the reason you haven't seen much discussion/Acks from
> the maintainers of the non-Tegra trees is because this is a big scary
> series that touches a lot of stuff, and it's not necessarily clear for
> people unfamiliar with it why they're being CCd on it.

I see. If you think it'll help I can certainly split them up as you
suggested. I just thought it might be useful for everybody to know the
context. At least from my own experience I get annoyed when I'm Cc'ed
on a single patch in a larger series because it means I need to look
through other archives for the context.

Thierry

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGhr4AAoJEN0jrNd/PrOhFqUQALLI9VLkqzWzQ5avj/tRqAeZ
yMKtSh2Ia64d3I3pN5xb5/X0almyRtmo4gwdIyDFC01eAQS2laiOZhsx9HAM0gyW
Y6HeRjbI9/TThsWUMaSqrJufpGjJlOEd+W0kjNtrG1qi2uXyHw10u/locZW0NReE
MCgUdSyiBzEpO1NIm5acNctDJzfarsqW4PSa5vVNJu1bTuLwr0LE+nPaEtN40lmw
XGzSUTykrjXRHZmNRTFIOQ9bkIA5gF6LxjQGKUGSk54E3fCf4XZPqRJ2pUjjFSZF
sLGh+iSR+popPHHUEyjW4XEsmf6TYshPTmZPRj/hWHDoKsvozo8mgrQf/ePBDoRY
vnsHMG6JuulV/iFGxBvXUSDZFDNaRHjOH9/YpAeYxYP94tqjDv/kdNR5rd0rgyZa
E3TjIEv4Fe5ggr8EitMcd5vU4ZxDa0nzN6utoJljJVjQldS8grHVlmIEzot9+B1a
iJE9kfpPJN8amtcmN7q4duC0OiAx+ysfvsFUq0E466EMLS5ylhMAWFL6Sa2FuPy+
CGuXJ7gQvrZ0Kdq7PQl8tqy6E9GrIpJv4CMhLSxyCQIpcCjorxVrCospFrlTsFgV
t1l0/Cpg8SkMB5nW4dhBXxPWOH5bLHIEbIu0q08wAe6m74sf6bx1j5F7xxYYpy2I
1XpoDIvYmnN+aBpVnELi
=wTu1
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--
