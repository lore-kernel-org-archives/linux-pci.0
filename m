Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B52D7DC8;
	Mon, 14 Sep 2026 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385901; cv=none; b=ra4lpdiGNO9KimusCXMDV8snAw6KexCEqShoVV3v3VBZeCTLE52E8HpauinWTrNHg/3ED9NP2GNug3irGnibjzJZuyhqPBVYKE5qWYBgaT43HaQ2XAIr+acZcyZkCxPlLwYVhcaZHzCfoOs8gDaH3ls2J9phy+Swm4hFXp7aIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385901; c=relaxed/simple;
	bh=hrCvZVfCyV1nyywTmaouy6LCKOqYrLAXczO+EyRBcwU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fNrA8O94FemticJ47rfW8ejWbhB3Ci5gtUpEWXso3NwEI/QWiBvIwGf+le5SAwoqauTivtWhFjo/FgMU9/7uo4sRFmScKcNWpcyV1BJaiRkUpe7rJV1QxbrY1zi7quWjtQpm4Cpm1MuL9F0IRMh6yFBKsZBkRlpPK5qH4ZWUuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/phvZvA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/phvZvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789385900; x=1820921900;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=hrCvZVfCyV1nyywTmaouy6LCKOqYrLAXczO+EyRBcwU=;
  b=Q/phvZvA163GMJ7c8gAam1C+BMkSTSNl3KQg0R3KmGSkmRa4hdQhJ4Jn
   WYVQoL7L1mgrW8GfKgKtmFS/cVe8d9cuGCQKiikavoAxNlaCBQiR8Xki9
   CaUlHBLox9xWZN1WgPW+GU0PQhOZBcMJG5OB3WcZTSYqngGculcGlaANV
   1r7TLccWr2AtiVYJ0HlzuzCL4NJZaspDr+rBNugou+U9RwVC1QTHsxaTy
   ej2YrZt6Tinu/YmcUHOyCtDa8GS/MDWidtVYP3aFKJq/m9EisqzYS4KgV
   wSDZQ8vveZxT3kJnM+lrlf5jpCqBPVo0jv39WNWMmtv7D9hx5nbQ3x/yr
   g==;
X-CSE-ConnectionGUID: 3IcaQvC0QWqBEaUrmEiYjQ==
X-CSE-MsgGUID: 43rsAGfeR0OHZYUE41JAAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93560320"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93560320"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 04:38:19 -0700
X-CSE-ConnectionGUID: RPRUl3hBQsujMOvZ+8QwrA==
X-CSE-MsgGUID: XTbV4ZRfT5iQ+SFkkkT45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="272115260"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 04:38:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 14 Sep 2026 14:38:11 +0300 (EEST)
To: Ard Biesheuvel <ardb@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>
cc: Ard Biesheuvel <ardb+git@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in
 prefetchable windows
In-Reply-To: <48bb0fb6-10dc-46a7-84f6-3464d7c7bdfe@app.fastmail.com>
Message-ID: <d2a561a9-e175-e102-3fa2-0be02342774a@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com> <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com> <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com> <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
 <48bb0fb6-10dc-46a7-84f6-3464d7c7bdfe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1906753989-1789380576=:1193"
Content-ID: <fd4710f3-eced-1eba-c0c3-1c69a4914aa7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1906753989-1789380576=:1193
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d1ecb2b1-10f4-285a-9a64-1f4ee4b584e1@linux.intel.com>

On Fri, 11 Sep 2026, Ard Biesheuvel wrote:
> On Fri, 11 Sep 2026, at 11:27, Ilpo J=E4rvinen wrote:
> > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
> >> On Thu, 10 Sep 2026, at 19:31, Ilpo J=E4rvinen wrote:
> >> > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
> >> >
> >> >> From: Ard Biesheuvel <ardb@kernel.org>
> >> >>=20
> >> >> The prefetchable vs. non-prefetchable distinction is a relic of
> >> >> conventional PCI, to denote from which regions PCI-PCI bridges were
> >> >> permitted to perform speculative readahead.
> >> >>=20
> >> >> For software compatibility reasons, PCI Express inherited the Type =
1
> >> >> header and models PCIe root ports as PCI-PCI bridges. However, this
> >> >> readahead behavior does not exist in PCIe, and so this distinction =
has
> >> >> mostly become meaningless on the bridge level.
> >> >>=20
> >> >> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
> >> >> 'prefetchable' designation has been removed from the specification
> >> >> entirely, on the basis that it is obsolete, and is being abused to
> >> >> inform memory mapping attributes and other device/BAR level propert=
ies
> >> >> that it was never intended for.
> >> >>=20
> >> >> Given the limited range for non-prefetchable windows in the Type 1
> >> >> header, and the fact that the distinction no longer exists for PCIe=
,
> >> >> resource allocation performed by firmware may result in non-prefetc=
hable
> >> >> 64-bit BARs being allocated inside prefetchable bridge windows.
> >> >>=20
> >> >> Linux rejects such allocations ("can't claim; no compatible bridge
> >> >> window") when it encounters them, but will usually fail to produce =
an
> >> >> alternative allocation, given that firmware wouldn't have placed th=
em
> >> >> there in the first place if there was sufficient space in the
> >> >> non-prefetchable window.
> >> >>=20
> >> >> So at the very least, let's not reject such allocations when they w=
ere
> >> >> made by the firmware.
> >> >>=20
> >> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> >> Cc: "Ilpo J=E4rvinen" <ilpo.jarvinen@linux.intel.com>
> >> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> >> ---
> >> >> Link: https://github.com/tianocore/edk2/issues/13104
> >> >>=20
> >> >>  drivers/pci/pci.c   | 3 ++-
> >> >>  include/linux/pci.h | 4 ++--
> >> >>  2 files changed, 4 insertions(+), 3 deletions(-)
> >> >>=20
> >> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> >> index b2879a6be5f8..e33eb9f3a139 100644
> >> >> --- a/drivers/pci/pci.c
> >> >> +++ b/drivers/pci/pci.c
> >> >> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const=
 struct pci_dev *dev,
> >> >>  =09=09=09 * not, the allocator made a mistake.
> >> >>  =09=09=09 */
> >> >>  =09=09=09if (r->flags & IORESOURCE_PREFETCH &&
> >> >> -=09=09=09    !(res->flags & IORESOURCE_PREFETCH))
> >> >> +=09=09=09    !(res->flags & IORESOURCE_PREFETCH) &&
> >> >> +=09=09=09    !pci_is_pcie(dev))
> >> >>  =09=09=09=09return NULL;
> >> >> =20
> >> >>  =09=09=09/*
> >> >
> >> > I was more thinking along the lines of always setting IORESOURCE_PRE=
FETCH=20
> >> > for 64-bit BARs on PCIe devices but I've not had time to look at tha=
t/test=20
> >> > how many things would break as a result. ...It would seem much simpl=
er=20
> >> > solution to differentiate PCI from PCIe while keeping the existing l=
ogic=20
> >> > without adding similar pci_is_pcie() checks everywhere.
> >> >
> >>=20
> >> I agree that the code changes would be much simpler.
> >>=20
> >> However, would this impact the PCI metadata observed by all consumers,
> >> including userspace,
> >
> > Yes, it will impact userspace. But quoting you from above:
> >
> > "is being abused to inform memory mapping attributes and other device/B=
AR=20
> > level properties that it was never intended for."
> >
> > What does the userspace then do with the information? Does it qualify=
=20
> > under "it was never intended for"?
> >
>=20
> Perhaps, but that does not mean we are allowed to break it now.
>=20
> More specifically, would the output of 'lspci' change as a result?

I'm not sure and I'm under impression there are multiple ways lspci can=20
derive its information.

> >> and drivers that may expect a certain BAR layout,
> >
> > ??? Would that even be spec compliant??
>=20
> Again, maybe not, but if something that works fine today stops
> working because the PCI subsystem started lying to the driver about
> how the PCIe device describes itself, we'll be on the hook to fix it.

Understood.

So I suppose you're not wanting to do this for the actual placement=20
algorithm then because of the same risk but only cover the case where FW=20
placed 64-bit non-pref BAR into prefetchable window like this patch=20
currently does?

=2E..And limiting to that case only likely implies remove + rescan cycle ma=
y=20
fail because resources can no longer be placed into the same windows=20
which will surprise user (arguably, not the most common use case but=20
definitely surprising for the user if the kernel cannot place the=20
resources the same way they were after boot =3D> another way to get problem=
=20
reports).

(Unrelated to this change, I'm going to open that BAR placement can of=20
worms myself in a week or two because of resource placement changes I'm=20
preparing. And I already hit one such problem where a particular BAR=20
address results in probe failure I'll probably have to quirk around. And=20
I didn't even have to move things into another window to trigger that.)

> >> and/or base decisions about memory attributes on this?
> >
> > The point is to consider them 64-bit window eligible so yes, kernel wou=
ld=20
> > definitely be basing decision on that but that's intentional.
>=20
> That would mean that a driver may decide to use ioremap_wc() rather than
> ioremap() to map a non-prefetchable BAR that we decided to misrepresent
> as a prefetchable one. Even if the (pseudo-)PCI-PCI bridge will not do
> any readahead, the CPU or interconnect may behave very differently as a
> result, and touch BAR regions that the driver never accessed explicitly.
>=20
> >> In particular, I am concerned about non-prefetchable BARs that actuall=
y
> >> have side effects on read, being mapped with WC (or Normal-NC on arm64=
)
> >> semantics, where the interconnect may widen, combine or reorder access=
es.
> >
> > So on a more concrete terms, you're referring to the check in=20
> > proc_bus_pci_mmap()? And the one in __pci_resource_attr_is_visible() +=
=20
> > pci_dev_resource_wc_is_visible()? I suppose that wouldn't work then.
>=20
> No, I am referring to the hundreds of ioremap() and ioremap_wc() calls
> under drivers. Maybe none of them are affected but who knows.

I'm left to wonder how many of those are based on a IORESOURCE_PREFETCH=20
check, I strongly suspect none. Somehow I feel I'm the only one running=20
git grep and I fail to locate any examples of the problem you mention. No=
=20
offense meant, I just feel we're dicussion code that is hypothetical and=20
doesn't exist for real, and definitely not on large scale.

That being said, I don't have problem in accepting adding=20
IORESOURCE_PREFETCH to all PCIe resources was not a good idea so there's=20
no point in continuing discussion towards this direction.

> > So if just setting IORESOURCE_PREFETCH is not workable, how about addin=
g a=20
> > getter for res->flags which adds IORESOURCE_PREFETCH into the returned=
=20
> > flags if it's PCIe device and (in the end) use the raw value only in th=
ose=20
> > places that actually care about wc distinction. What I don't want to se=
e=20
> > us adding that pci_is_pcie() everywhere.
>=20
> Maybe add another IORESOURCE_PREFETCH_xxx flag that indicates that the
> resource may be placed in a prefetchable bridge window? We'd only have
> to set it in a single place (when probing the BAR), and we can add
> support for it piecemeal in the validation and allocation logic.

Unfortunately, I've earlier discovered there's no "single place" unless=20
we add some gross res->flags fixup hack into PCI core. See e.g., the=20
commit bdb32359eab9 ("sparc/PCI: Correct 64-bit non-pref -> pref BAR=20
resources"), which we could hopefully revert after your change! So I'm=20
afraid if you go to the new flag approach, besides drivers/pci/ you'd have=
=20
to hunt down these from under arch/, and likely miss a few in the process.

Also, res->flags is currently full (for 32-bit) so you'd need to make the=
=20
field (and therefore struct resource) larger.

So I still suggest having a flags getter for this purpose would be better.
In the complete solution covering also resource fitting and assignment=20
algorithm, the main complication with that approach comes from the few=20
cases that don't have the struct pci_dev readily available. Some can=20
easily be handled by passing it as a param but there might be cases that=20
are given pci_bus as parameter that could be somewhat trickier if there is=
=20
no resource nor pci_dev (in case of a root bus), but I'm not immediately=20
sure if there are actually any cases for real that fall into the latter=20
category.


--=20
 i.
--8323328-1906753989-1789380576=:1193--
