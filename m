Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525504AB1A0;
	Thu, 10 Sep 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061489; cv=none; b=CzpefUkFt+BMZb+uZQk3UL0eqmffhmcezr78bsIuW/w1VxlkGeF6rUgSwthEaGpvXGTQUHa+/ArBChwnH2B3cPO/AWFlfWwBWvlDSrorrg9JFbLmNOGGLbeCY2w6xgfuCnJHwuNhs6B81i5/VAMZw9OTOXVGY5Q0hNepHgWSo8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061489; c=relaxed/simple;
	bh=bRmUphc7RmCTIfHBLbI5m/9UKIWC50UdYbOnhx8jN54=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qz7ZlapJ53YvNn9USpUlJ/Eno831wqHaPbWFAQ4LMev8ww9Dv/D/w1L8DXixhRQWFPJnUqMOIxpuitT+nZQtqPsjk9c527RcKDdQW72WO4LlUU06wdfQ12bd93nGOpLnOT3WqqOgwhpAC6O9EXgNjieeM9DWyh8s4LFrheCgvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TiWCjS8G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TiWCjS8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789061478; x=1820597478;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bRmUphc7RmCTIfHBLbI5m/9UKIWC50UdYbOnhx8jN54=;
  b=TiWCjS8GeRiBr5VzfKpI5R9Ukspzbq+zfadm/DP0xh6I9VqokeSb8zdW
   VIvBkKfOiOJQwMR4alcCvZl2VmD8KVKxRGHmk7W7npvP6pJgvwARLL4ss
   +nAz0m6OjExvbmuO7JC3elr0+s+E2Be5z/7z1fldW7eCP9gLXT0yg35G6
   mf+J1LdBmwEA2WWjE3dFBgn2qNRdjipJ1ejdqNhrZ6d0CkTew4oGOiYOW
   k9MLwy4hLgl5Aay4TiGqsoVR3BDug9NJdxL0yrsgKIVRtiVuW+QZVU4Zd
   XZqYbN0ku44glxpE41frj7ChARW8oH7p17lvRGuXJEI6kxZqfRz86UaPE
   A==;
X-CSE-ConnectionGUID: 6vzZ6PxhSZyJxJ1eB8vbwA==
X-CSE-MsgGUID: vbPA11FMTUusSxMIsYN1UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88664574"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="88664574"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 10:31:13 -0700
X-CSE-ConnectionGUID: nkWk0vOmS0OQ83ilvzAaNw==
X-CSE-MsgGUID: LG8dZ91ERFe6zRyTzQgyrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="268411727"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.221])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 10:31:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 10 Sep 2026 20:31:08 +0300 (EEST)
To: Ard Biesheuvel <ardb+git@google.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Ard Biesheuvel <ardb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: Tolerate non-prefetchable 64-bit BARs in
 prefetchable windows
In-Reply-To: <20260910143440.3865663-2-ardb+git@google.com>
Message-ID: <aa0e034d-fc68-69d6-8d27-8f30d138b9be@linux.intel.com>
References: <20260910143440.3865663-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1933240820-1789061468=:1174"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1933240820-1789061468=:1174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 10 Sep 2026, Ard Biesheuvel wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> The prefetchable vs. non-prefetchable distinction is a relic of
> conventional PCI, to denote from which regions PCI-PCI bridges were
> permitted to perform speculative readahead.
>=20
> For software compatibility reasons, PCI Express inherited the Type 1
> header and models PCIe root ports as PCI-PCI bridges. However, this
> readahead behavior does not exist in PCIe, and so this distinction has
> mostly become meaningless on the bridge level.
>=20
> As per the PCIe r6.3 ECN "Removing Prefetchable Terminology", the
> 'prefetchable' designation has been removed from the specification
> entirely, on the basis that it is obsolete, and is being abused to
> inform memory mapping attributes and other device/BAR level properties
> that it was never intended for.
>=20
> Given the limited range for non-prefetchable windows in the Type 1
> header, and the fact that the distinction no longer exists for PCIe,
> resource allocation performed by firmware may result in non-prefetchable
> 64-bit BARs being allocated inside prefetchable bridge windows.
>=20
> Linux rejects such allocations ("can't claim; no compatible bridge
> window") when it encounters them, but will usually fail to produce an
> alternative allocation, given that firmware wouldn't have placed them
> there in the first place if there was sufficient space in the
> non-prefetchable window.
>=20
> So at the very least, let's not reject such allocations when they were
> made by the firmware.
>=20
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Ilpo J=C3=A4rvinen" <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Link: https://github.com/tianocore/edk2/issues/13104
>=20
>  drivers/pci/pci.c   | 3 ++-
>  include/linux/pci.h | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..e33eb9f3a139 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -761,7 +761,8 @@ struct resource *pci_find_parent_resource(const struc=
t pci_dev *dev,
>  =09=09=09 * not, the allocator made a mistake.
>  =09=09=09 */
>  =09=09=09if (r->flags & IORESOURCE_PREFETCH &&
> -=09=09=09    !(res->flags & IORESOURCE_PREFETCH))
> +=09=09=09    !(res->flags & IORESOURCE_PREFETCH) &&
> +=09=09=09    !pci_is_pcie(dev))
>  =09=09=09=09return NULL;
> =20
>  =09=09=09/*

I was more thinking along the lines of always setting IORESOURCE_PREFETCH=
=20
for 64-bit BARs on PCIe devices but I've not had time to look at that/test=
=20
how many things would break as a result. ...It would seem much simpler=20
solution to differentiate PCI from PCIe while keeping the existing logic=20
without adding similar pci_is_pcie() checks everywhere.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..1cbb4b6c02c3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2684,7 +2684,7 @@ static inline void pci_vf_drivers_autoprobe(struct =
pci_dev *dev, bool probe) { }
>   * need to calculate PCIe capability offset from raw device for some
>   * reasons, please use pci_find_capability() instead.
>   */
> -static inline int pci_pcie_cap(struct pci_dev *dev)
> +static inline int pci_pcie_cap(const struct pci_dev *dev)
>  {
>  =09return dev->pcie_cap;
>  }
> @@ -2695,7 +2695,7 @@ static inline int pci_pcie_cap(struct pci_dev *dev)
>   *
>   * Returns: true if the PCI device is PCI Express capable, false otherwi=
se.
>   */
> -static inline bool pci_is_pcie(struct pci_dev *dev)
> +static inline bool pci_is_pcie(const struct pci_dev *dev)
>  {
>  =09return pci_pcie_cap(dev);
>  }
>=20

This const conversion should be done in a separate preparatory patch (if=20
needed in the end, though IMO it wouldn't hurt to have it as const=20
anyway even if it's not necessary for the 64-bit/pref change in the end).

--=20
 i.

--8323328-1933240820-1789061468=:1174--
