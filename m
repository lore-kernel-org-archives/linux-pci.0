Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06D342510
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815751; cv=none; b=ANT4k3HGZDGAMbUk9LOYEGp7jbeAHdbjj/QMkkR1ZGrnaIKEb/gJtGCA7Ozwt0jgpg01ZeoPukNd/mFLrc4noraV6cPwcEdxMT1uNREDPvJ6/KBKAUPvDggghXuwCsx8PkexQdAECRYEM3UD2s4C4vT3LT2sRqdfHI6BRMdukHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815751; c=relaxed/simple;
	bh=b7pY61ZvOSbQtCy8Bvp7KRnn/GfSyA5IPs1slpsXUFU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bKwXYLl7omSL+232hy89+4/90RBdtbtHsM04jO06IdnN8xVwhDcYkvnVuthVv7+R9QU22Im/NGcJS8UoL0YABjrbB/YHvyGFZvAcarLEiPRGuq3TdjY/DBz3YXjo+x6U23x0WpzCxE/+2XLKXayl3O1aMCosul0Cl5P37rsXmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkMKkJmw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkMKkJmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775815749; x=1807351749;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=b7pY61ZvOSbQtCy8Bvp7KRnn/GfSyA5IPs1slpsXUFU=;
  b=hkMKkJmwwEGSuUoCRgqSMCM7cQcPg/neayZo3IrvpUWRQZKW7di5npA/
   y2l3unatsEUagI8todjBlC0ZdMTwckm7kSr/ALL0VN2u682PnbEXU8AkL
   Hg7JZLRH0cqbAf4dqx2JzfJc+1yfdbP+IL3s5Lk7yqXxJtsb75c45Rj7Q
   nlbKSLzd/SKrND+XUSXKAJbtS/Qc77dI5SHxMQOzDq9qhjxW4R/shF7KM
   BVV43uHrPTf96BiuUl8dwaavD/zaicINpfIeEBNzG/mqKxvIrK3/uxPWC
   XgcJaLa67Q2rpVDeDw3qIr8Dl0hMjWfMM+dobdqJhG5DTlEL7Cvztj2ho
   w==;
X-CSE-ConnectionGUID: 8c6GPryFQBuTBvYX2zNT4g==
X-CSE-MsgGUID: UirCBcR3RxqwgwMXKp8Uig==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87461878"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87461878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:09:08 -0700
X-CSE-ConnectionGUID: z6MNtYYxQu2sG9blz5X8lg==
X-CSE-MsgGUID: jNrmVPPRSSmtN1wpgx0Y+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228207051"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:09:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 13:09:00 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: linux-pci@vger.kernel.org, cristi@ieee.org
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during
 rebar expansion
In-Reply-To: <20260410052918.5556-2-gloveless@jqluv.com>
Message-ID: <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org> <20260410052918.5556-2-gloveless@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1033624320-1775815741=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1033624320-1775815741=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Apr 2026, Geramy Loveless wrote:

> When pbus_reassign_bridge_resources() walks up the bridge hierarchy
> to expand a window (e.g. for resizable BAR), it refuses to release
> any bridge window that has children.  This prevents BAR resize on
> devices behind multi-port PCIe switches (such as Thunderbolt docks)
> where empty sibling downstream ports hold small reservations that
> block the parent bridge window from being freed and re-sized.
>=20
> Add pci_bus_subtree_empty() to check whether a bus subtree contains
> any assigned device BARs, and pci_bus_release_empty_bridges() to
> release bridge window resources of empty sibling bridges, saving
> them to the rollback list so failures can be properly unwound.
>=20
> In pbus_reassign_bridge_resources(), call pci_bus_release_empty_bridges()
> before checking res->child, so empty sibling windows are cleared first
> and the parent window can then be released and grown.
>=20
> Uses PCI bus/device iterators rather than walking the raw resource
> tree, which avoids issues with stale sibling pointers after resource
> release.

This paragraph can be dropped. And it's not exactly correct either as=20
the pointers are only stale for resource entries that reside outside of=20
the resource tree (after they've been released in a specific way) so if=20
you start from a resource tree entry, you should never encounter a stale=20
pointer.

> Suggested-by: Ilpo J=C3=A4rvinen=C2=A0<ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
>  drivers/pci/setup-bus.c | 99 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5a..7a182cd7e4d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2292,6 +2292,94 @@ void pci_assign_unassigned_bridge_resources(struct=
 pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> =20
> +/*
> + * pci_bus_subtree_empty - Check whether a bus subtree has any assigned
> + * non-bridge device resources.
> + * @bus: PCI bus to check
> + *
> + * Returns true if no device on @bus or its descendant buses has any
> + * assigned BARs (bridge window resources are not considered).
> + */
> +static bool pci_bus_subtree_empty(struct pci_bus *bus)
> +{
> +=09struct pci_dev *dev;
> +
> +=09list_for_each_entry(dev, &bus->devices, bus_list) {
> +=09=09struct resource *r;
> +=09=09unsigned int i;
> +
> +=09=09pci_dev_for_each_resource(dev, r, i) {
> +=09=09=09if (i >=3D PCI_BRIDGE_RESOURCES)
> +=09=09=09=09break;
> +=09=09=09if (resource_assigned(r))
> +=09=09=09=09return false;
> +=09=09}
> +
> +=09=09if (dev->subordinate &&
> +=09=09    !pci_bus_subtree_empty(dev->subordinate))
> +=09=09=09return false;
> +=09}
> +
> +=09return true;
> +}
> +
> +/*
> + * pci_bus_release_empty_bridges - Release bridge window resources of
> + * empty sibling bridges so the parent window can be freed and re-sized.
> + * @bus: PCI bus whose child bridges to scan
> + * @b_win: Parent bridge window resource; only children of this window
> + *         are released
> + * @saved: List to save released resources for rollback
> + *
> + * For each PCI-to-PCI bridge on @bus whose subtree is empty (no assigne=
d
> + * device BARs), releases bridge window resources that are children of
> + * @b_win, saving them for rollback via @saved.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +static int pci_bus_release_empty_bridges(struct pci_bus *bus,
> +=09=09=09=09=09 struct resource *b_win,
> +=09=09=09=09=09 struct list_head *saved)
> +{
> +=09struct pci_dev *dev;
> +
> +=09list_for_each_entry(dev, &bus->devices, bus_list) {
> +=09=09struct resource *r;
> +=09=09unsigned int i;
> +
> +=09=09if (!dev->subordinate)
> +=09=09=09continue;
> +
> +=09=09if ((dev->class >> 8) !=3D PCI_CLASS_BRIDGE_PCI)
> +=09=09=09continue;

I suppose dev->subordinate check is enough for what we're doing so this=20
looks redundant.

> +
> +=09=09if (!pci_bus_subtree_empty(dev->subordinate))
> +=09=09=09continue;
> +
> +=09=09pci_dev_for_each_resource(dev, r, i) {
> +=09=09=09int ret;
> +
> +=09=09=09if (!pci_resource_is_bridge_win(i))
> +=09=09=09=09continue;
> +
> +=09=09=09if (!resource_assigned(r))
> +=09=09=09=09continue;
> +
> +=09=09=09if (r->parent !=3D b_win)
> +=09=09=09=09continue;
> +
> +=09=09=09ret =3D pci_dev_res_add_to_list(saved, dev, r, 0, 0);
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> +
> +=09=09=09release_child_resources(r);

Unfortunately you cannot call this low-level function because it=20
recursively frees child resources which means you won't be able to=20
rollback them as they were not added to the saved list.

I think the release algorithm should basically do this:

- Recurse to the subordinate buses
- Loop through bridge window resources of this bus
=09- Skip resources that are not assigned or are not parented by b_win
=09- If the resource still has childs, leave the resource alone
=09  (+ log it for easier troubleshooting these cases; any failure
=09     will also cascade to upstream so it may be possible to=20
=09     shortcut something but it will also make the algorithm more
=09     complicated)
=09- Save and free the resource

It might be better to move some of the code from=20
pbus_reassign_bridge_resources() here as there's overlap with the sketched=
=20
algorithm (but I'm not sure until I see the updated version but keep this=
=20
in mind).

Doing pci_bus_subtree_empty() before any removal is fine with me, but I=20
see it just an optimization.

> +=09=09=09pci_release_resource(dev, i);
> +=09=09}
> +=09}
> +
> +=09return 0;
> +}
> +
>  /*
>   * Walk to the root bus, find the bridge window relevant for @res and
>   * release it when possible. If the bridge window contains assigned
> @@ -2316,7 +2404,14 @@ static int pbus_reassign_bridge_resources(struct p=
ci_bus *bus, struct resource *
> =20
>  =09=09i =3D pci_resource_num(bridge, res);
> =20
> -=09=09/* Ignore BARs which are still in use */

I don't know why you removed this comment (I admit though "BARs" could=20
have been worded better as it's bridge windows we're dealing here).

> +=09=09/* Release empty sibling bridge windows first */
> +=09=09if (bridge->subordinate) {
> +=09=09=09ret =3D pci_bus_release_empty_bridges(
> +=09=09=09=09=09bridge->subordinate, res, saved);

First arg fits to the previous line.

Align the second line to (.

But consider also rearranging code as I mentioned above.

> +=09=09=09if (ret)
> +=09=09=09=09return ret;

Consider proceeding with the resize even if something failed as there are=
=20
cases where the bridge windows are large enough (admittedly, you seem to=20
only bail out in case of alloc error).

In to the same vein, there seems to be one existing goto restore (that was=
=20
added by me), which could also probably do continue instead (but changing=
=20
it would be worth another patch).

> +=09=09}
> +
>  =09=09if (!res->child) {
>  =09=09=09ret =3D pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
>  =09=09=09if (ret)
> @@ -2327,7 +2422,7 @@ static int pbus_reassign_bridge_resources(struct pc=
i_bus *bus, struct resource *
>  =09=09=09const char *res_name =3D pci_resource_name(bridge, i);
> =20
>  =09=09=09pci_warn(bridge,
> -=09=09=09=09 "%s %pR: was not released (still contains assigned resource=
s)\n",
> +=09=09=09=09 "%s %pR: not released, active children present\n",
>  =09=09=09=09 res_name, res);
>  =09=09}
> =20
>=20

--=20
 i.

--8323328-1033624320-1775815741=:1195--
