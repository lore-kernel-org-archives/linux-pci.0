Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108E3AE1A8
	for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075785; cv=none; b=sUmMnekryO3w8soj6nGgfyo6+1thbnL+rkcU3I4/FqP6x0ymo7bAM6ypOI8btB5b66sSQGuah9nG6cK+XbZxiKgnM8VaZHfJRx9NcAqJoXOFFpJ9EB37vThY2uPhkJ1mVmSB8Fykp/faWRzuu9BF1uTPdwBOFO/f6fbNwtuxN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075785; c=relaxed/simple;
	bh=ogwRpu0Eo//vWBMhvJ2k0elopZSZSmZeRbxPPtzbJHM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=THpKuJueL92zKX1A0uTeZTGQ+f1GEbYmsXTcvBv7WAjC5sieUm4E+bFu+NUX8HWQHH3eUpZw1InHVvYY/RAumS82pnnr3vOw81pVU7blXW6QC/IlSjHulWK3q0Kl5oTH1r2N28VZsXlavCYfCTtr+tviFeiUulS5cR7eQCunfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRrFMRXW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRrFMRXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776075783; x=1807611783;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ogwRpu0Eo//vWBMhvJ2k0elopZSZSmZeRbxPPtzbJHM=;
  b=mRrFMRXW7IdN73HUr4fg3NnFWRMOhWAbiQgpZNLoFwHCkdEcG/gq79DN
   yZOdZv/0NCnyp35r8mT/PMXDH9C1li1HuXKwGUbZqec/5toMa3FeNkN22
   1ec8MhIutTEd39FrVR62bRWR6FgMecAAY4Vq9XIUKhgO99topRSoHDrBe
   Wy5Lno3NEJsCCop+J8khRIlbQtjz5vFlqvJT10mzaWp7w7oHtfdbMKM75
   I0PRLOC7wgjZzjUmg6qKEw7ihGZeLANMPrEsNhLDDY3+0JGJk26CGuJF4
   sV5CSj4G0IQHsqf63iB5ZCDS+g7yAqTIdLbDHYHFCyjGTuzD79jziPsxY
   g==;
X-CSE-ConnectionGUID: krUDlqiXSIeHkJ3y8ZifxQ==
X-CSE-MsgGUID: CPjVdaFiSlKMgff3HPqdqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="77076876"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="77076876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:23:02 -0700
X-CSE-ConnectionGUID: WCZqVdyoRvykj8MqurICXA==
X-CSE-MsgGUID: UfQuY95oSneQXCFfpFmdBA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:22:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 13:22:54 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: linux-pci@vger.kernel.org, Cristian Cocos <cristi@ieee.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] PCI: release empty sibling bridge resources during window
 resize
In-Reply-To: <20260410191037.782121-1-gloveless@jqluv.com>
Message-ID: <f8c3aa99-ab27-e316-8449-27b0049893a9@linux.intel.com>
References: <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org> <20260410191037.782121-1-gloveless@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-991176471-1776073353=:962"
Content-ID: <54d984ff-7230-2655-46aa-9f6d5ba305ee@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-991176471-1776073353=:962
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4c3f9a63-cd84-d14b-3a9d-1d3681fef7d6@linux.intel.com>

On Fri, 10 Apr 2026, Geramy Loveless wrote:

Please try to remember to increment the version counter whenever=20
resubmitting the patch (if there's even a slightest change to the patch).
This should have been v3 I think.

> pbus_reassign_bridge_resources() refuses to release bridge windows that
> have child resources.  On multi-port PCIe switches (e.g. Thunderbolt
> docks), empty sibling downstream ports hold small reservations that
> prevent the parent window from being freed and re-sized for rebar.
>=20
> Add a bottom-up recursive release that saves and frees each empty bridge
> window individually, so the parent window can then be released and grown.

As this starts to get close being ready, put the parts of the log here=20
which show the pinning problem so it's easier to find this with search=20
engine. Only include relevant parts (things like timestamps and totally=20
unrelated lines can be cut out).

If it seems reasonable in length, consider adding also the post change=20
log.
=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---

Please start adding version history of the patch here (what was changed=20
compared with the previous version).

>  drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5ad..0c1fb654c9cc 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2292,6 +2292,60 @@ void pci_assign_unassigned_bridge_resources(struct=
 pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> =20
> +/*
> + * pci_bus_release_empty_bridge_resources - Bottom-up release of bridge
> + * window resources in empty subtrees.

This is summary, so I'd change "bridge window resources" to just "bridge=20
windows"

> + * @bus: PCI bus whose child bridges to process
> + * @b_win: Ancestor bridge window; only children of this resource are re=
leased
> + * @saved: List to save released resources for rollback
> + *
> + * Recurses depth-first into subordinate buses, then releases bridge win=
dows

=2E.. that are (grand)parented by @b_win

> + * on the way back up.  Each resource is individually saved before relea=
se so

individually saved -> stored into @saved

Nit, one whitespace is enough.

> + * the entire operation can be rolled back.
> + */
> +static void pci_bus_release_empty_bridge_resources(struct pci_bus *bus,
> +=09=09=09=09=09=09   struct resource *b_win,
> +=09=09=09=09=09=09   struct list_head *saved)
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
> +=09=09/* Recurse first =E2=80=94 release deepest resources before parent=
s */
> +=09=09pci_bus_release_empty_bridge_resources(dev->subordinate,
> +=09=09=09=09=09=09      b_win, saved);
> +
> +=09=09pci_dev_for_each_resource(dev, r, i) {
> +=09=09=09if (!pci_resource_is_bridge_win(i))
> +=09=09=09=09continue;
> +
> +=09=09=09if (!resource_assigned(r))
> +=09=09=09=09continue;
> +
> +=09=09=09if (r->parent !=3D b_win)

This has to also walk upstream as in nested topologies, b_win is not=20
necessarily the immediate parent.

When converting to the suggested iteration form (see below), r itself can=
=20
be b_win too but it's relatively easy to handle once you convert this into=
=20
a while loop.

> +=09=09=09=09continue;
> +


> +=09=09=09if (r->child) {
> +=09=09=09=09const char *res_name =3D pci_resource_name(dev, i);
> +
> +=09=09=09=09pci_info(dev, "%s %pR: not released, children still present\=
n",
> +=09=09=09=09=09 res_name, r);
> +=09=09=09=09continue;
> +=09=09=09}
> +
> +=09=09=09if (pci_dev_res_add_to_list(saved, dev, r, 0, 0))
> +=09=09=09=09continue;
> +
> +=09=09=09pci_release_resource(dev, i);

These three things are effectively what the caller does right after=20
calling this function so the current way to iterate duplicates the=20
release to two places. This is what I meant when I said you may want to=20
restructure things a bit.

I think this structure would allow you to remove the caller side release=20
entirely:

=09list_for_each_entry(dev, &bus->devices, bus_list) {
=09=09... recursion ...
=09}

=09pci_bus_for_each_resource(bus, ...) {
=09=09...checks and release here...
=09}

I suspect you don't even need to check pci_resource_is_bridge_win() when=20
iterating over them as bus resources.

> +=09=09}
> +=09}
> +}
> +
>  /*
>   * Walk to the root bus, find the bridge window relevant for @res and
>   * release it when possible. If the bridge window contains assigned
> @@ -2316,7 +2370,12 @@ static int pbus_reassign_bridge_resources(struct p=
ci_bus *bus, struct resource *
> =20
>  =09=09i =3D pci_resource_num(bridge, res);
> =20
> -=09=09/* Ignore BARs which are still in use */
> +=09=09/* Release empty sibling bridge windows bottom-up */
> +=09=09if (bridge->subordinate)
> +=09=09=09pci_bus_release_empty_bridge_resources(
> +=09=09=09=09bridge->subordinate, res, saved);

If you call is pbus_... it is a bit shorter and you can fit the first arg=
=20
on the first line.

Use braces with multi-line constructs.

> +
> +=09=09/* Ignore bridge windows which are still in use */
>  =09=09if (!res->child) {
>  =09=09=09ret =3D pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
>  =09=09=09if (ret)
> @@ -2327,7 +2386,7 @@ static int pbus_reassign_bridge_resources(struct pc=
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
--8323328-991176471-1776073353=:962--
