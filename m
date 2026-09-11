Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4240F8D8;
	Fri, 11 Sep 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118853; cv=none; b=FMRkTmWn1D7I+b9F0N4659ATauppwFRRviEfFKBlTi2HV4jGjsveCQNxQ5dRfj0E7YhjI2DNQH4gJa1VkWlVKOQjDsI8/WYMPGKlDcXDUj/JvdpODZ9lcpfLPWay1hBvJ3PJcLOvwyhaxgjKPy16DoWJnnXbMYQmXpQexb5OCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118853; c=relaxed/simple;
	bh=8K+BGYFG3ud53t1n0NdJiEzeFfQGaZzpWgnI21xdFbw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ra/pfQ8KT7d2oRrKWsGOtFpz/0DB6NoxRe9W/UMigCutkHyY3JZbYDoQRV6yd85mld7mLyrkvPnSy1iqPQA8C5s0OR2AdMhQEjNvVsKLr+DfY3ZqPmAsRniYD+pjCOoMjL6gu1zjhSNlc7EjTde9q/fm/pchEvKD/7IFDqng46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jswi0aed; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jswi0aed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789118851; x=1820654851;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8K+BGYFG3ud53t1n0NdJiEzeFfQGaZzpWgnI21xdFbw=;
  b=jswi0aedPL/hK+v67gmVd9++XjfK7RhjJjoi8KfSA42SfQ/tF+O7f2SY
   Zyto3MBCoDRY5nDG9r0btYKW8HidHAFN0lSw6B7oVsvpqaRAzjOhSD3aQ
   yPzXjXweKGw96t78CXFiTa8WpoTPypKapQMbJEWLEZVhu4V17ZwauBCN7
   1Caxn2RWoDUFfLKefs5gocL4KYXCZh5BYsfi+Cg2fDvtvcVeBZifjQlTr
   ctbYLVnIXcDIcLhH2T6iVNcTfK9awge/p06InyP+DW5E+8n9B65ZEnWV5
   dG3cJQXvtOwUixU6dhUHKz/5Ydc677iLzSDBYVEdDvzYdW2fqlwrGwfKk
   A==;
X-CSE-ConnectionGUID: DOWkKBBlQb+/l0roAyBLKQ==
X-CSE-MsgGUID: GI9Z/6MdTmKSPXRyhMlzfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89451615"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89451615"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:27:30 -0700
X-CSE-ConnectionGUID: eWtNITrFSMqsqxzBMWwPrQ==
X-CSE-MsgGUID: JhxQOYJBQMmet6UAxYoZXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="240221"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.158])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:27:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Sep 2026 12:27:25 +0300 (EEST)
To: Ard Biesheuvel <ardb@kernel.org>
cc: Ard Biesheuvel <ardb+git@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in
 prefetchable windows
In-Reply-To: <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
Message-ID: <2e392b1b-3cbe-5cf8-e190-b1c82d69562f@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com> <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com> <41345c53-fea4-4f98-8569-b3dc4e84cdcb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-30872173-1789117895=:1171"
Content-ID: <d5585a69-a9f9-cc9b-2706-c74342859f3b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-30872173-1789117895=:1171
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <662fec2e-5c55-858c-09ec-f9a543d6de19@linux.intel.com>

On Thu, 10 Sep 2026, Ard Biesheuvel wrote:

>=20
> On Thu, 10 Sep 2026, at 19:31, Ilpo J=E4rvinen wrote:
> > On Thu, 10 Sep 2026, Ard Biesheuvel wrote:
> >
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>=20
> >> The prefetchable vs. non-prefetchable distinction is a relic of
> >> conventional PCI, to denote from which regions PCI-PCI bridges were
> >> permitted to perform speculative readahead.
> >>=20
> >> For software compatibility reasons, PCI Express inherited the Type 1
> >> header and models PCIe root ports as PCI-PCI bridges. However, this
> >> readahead behavior does not exist in PCIe, and so this distinction has
> >> mostly become meaningless on the bridge level.
> >>=20
> >> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
> >> 'prefetchable' designation has been removed from the specification
> >> entirely, on the basis that it is obsolete, and is being abused to
> >> inform memory mapping attributes and other device/BAR level properties
> >> that it was never intended for.
> >>=20
> >> Given the limited range for non-prefetchable windows in the Type 1
> >> header, and the fact that the distinction no longer exists for PCIe,
> >> resource allocation performed by firmware may result in non-prefetchab=
le
> >> 64-bit BARs being allocated inside prefetchable bridge windows.
> >>=20
> >> Linux rejects such allocations ("can't claim; no compatible bridge
> >> window") when it encounters them, but will usually fail to produce an
> >> alternative allocation, given that firmware wouldn't have placed them
> >> there in the first place if there was sufficient space in the
> >> non-prefetchable window.
> >>=20
> >> So at the very least, let's not reject such allocations when they were
> >> made by the firmware.
> >>=20
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: "Ilpo J=E4rvinen" <ilpo.jarvinen@linux.intel.com>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >> Link: https://github.com/tianocore/edk2/issues/13104
> >>=20
> >>  drivers/pci/pci.c   | 3 ++-
> >>  include/linux/pci.h | 4 ++--
> >>  2 files changed, 4 insertions(+), 3 deletions(-)
> >>=20
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index b2879a6be5f8..e33eb9f3a139 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const st=
ruct pci_dev *dev,
> >>  =09=09=09 * not, the allocator made a mistake.
> >>  =09=09=09 */
> >>  =09=09=09if (r->flags & IORESOURCE_PREFETCH &&
> >> -=09=09=09    !(res->flags & IORESOURCE_PREFETCH))
> >> +=09=09=09    !(res->flags & IORESOURCE_PREFETCH) &&
> >> +=09=09=09    !pci_is_pcie(dev))
> >>  =09=09=09=09return NULL;
> >> =20
> >>  =09=09=09/*
> >
> > I was more thinking along the lines of always setting IORESOURCE_PREFET=
CH=20
> > for 64-bit BARs on PCIe devices but I've not had time to look at that/t=
est=20
> > how many things would break as a result. ...It would seem much simpler=
=20
> > solution to differentiate PCI from PCIe while keeping the existing logi=
c=20
> > without adding similar pci_is_pcie() checks everywhere.
> >
>=20
> I agree that the code changes would be much simpler.
>=20
> However, would this impact the PCI metadata observed by all consumers,
> including userspace,

Yes, it will impact userspace. But quoting you from above:

"is being abused to inform memory mapping attributes and other device/BAR=
=20
level properties that it was never intended for."

What does the userspace then do with the information? Does it qualify=20
under "it was never intended for"?

> and drivers that may expect a certain BAR layout,

??? Would that even be spec compliant??

> and/or base decisions about memory attributes on this?

The point is to consider them 64-bit window eligible so yes, kernel would=
=20
definitely be basing decision on that but that's intentional.

> In particular, I am concerned about non-prefetchable BARs that actually
> have side effects on read, being mapped with WC (or Normal-NC on arm64)
> semantics, where the interconnect may widen, combine or reorder accesses.

So on a more concrete terms, you're referring to the check in=20
proc_bus_pci_mmap()? And the one in __pci_resource_attr_is_visible() +=20
pci_dev_resource_wc_is_visible()? I suppose that wouldn't work then.

So if just setting IORESOURCE_PREFETCH is not workable, how about adding a=
=20
getter for res->flags which adds IORESOURCE_PREFETCH into the returned=20
flags if it's PCIe device and (in the end) use the raw value only in those=
=20
places that actually care about wc distinction. What I don't want to see=20
us adding that pci_is_pcie() everywhere.

--=20
 i.
--8323328-30872173-1789117895=:1171--
