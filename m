Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9A39B4A6
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458880; cv=none; b=TW+lg2Z6Qt9IzK/vBrD7/l1aoOp6zzuXojYb5epReZXDiO5HWoVfsPlaRIaiipaq5XTjJHkd2JIMCOvUuBMa4ylKbwllWrWqHfHKa7Gd3blXn+wjWkOoNQSFw81X4WrAkj9AGuJOyHfH8bY2E5qyuLEBKw56thvklwx/pV6n6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458880; c=relaxed/simple;
	bh=e9NkbKCzkNP4G7jvLwasOvurNANukm/JUadhuTmUFho=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H7E3rC/ZIOtU4zb0T+HYhlUhAWqFpmha4LEEv4XkvbxXWQ4LFonqxYZuQ7C5WdyvQetWrW/Vdqi/QzrDgHm1ecFjGYvNPyI927NAwClGex93IxcZmVbDloWxw+akDBvdEmxLT3rTnxUW3S3Iw6dbY0qpuD45ybwLfBC4gxAZFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SE4ymJhz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SE4ymJhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777458878; x=1808994878;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=e9NkbKCzkNP4G7jvLwasOvurNANukm/JUadhuTmUFho=;
  b=SE4ymJhzsA+KEQRIqYIULWjnfP2j3HjdfirHY5/hF66GcvfrAU4KHjbW
   19+vKY2AN6kOiDV/tIp/zQ7U8DlNX1VYPf3WBgC3H3MzEQu01JfKKMjCw
   pdD2P9cD8GmtSrNfAaH43KssHGZKSxtDn9Gl4BJ6IYTiNXDaqVd5mgGwI
   SaxusxqueHGgFs9wzCvprM24k2LLh5kMDMKsT4Cztlxjr3l0tKyDinwHv
   zkDkLlx+lfs8AuPdN6omzLIJQlg5ZKGfP+kJDUj0BMfo2JT1KRiDH4Q8o
   RLMiAc181AN6GV/drG6xuSshqVbyWKXschNp4TqLV+KrQltDMq3rCvhSj
   g==;
X-CSE-ConnectionGUID: rBtrRs/OQl2GXYY1VYpx3Q==
X-CSE-MsgGUID: JfqZAm4NSTmqpJYndmiLSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77413969"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="77413969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:34:38 -0700
X-CSE-ConnectionGUID: If0y8vxtREqklJFhCnoA2w==
X-CSE-MsgGUID: t8J7k2KVSsKb/B6DDlF9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233200201"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 03:34:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Apr 2026 13:34:19 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: Cristian Cocos <cristi@ieee.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] PCI: release empty sibling bridge windows
 during window resize
In-Reply-To: <20260428225532.3108047-1-gloveless@jqluv.com>
Message-ID: <c762ef52-11f8-cf82-7e0e-32323c59c6e6@linux.intel.com>
References: <20260428225532.3108047-1-gloveless@jqluv.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1052843889-1777458859=:966"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1052843889-1777458859=:966
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Apr 2026, Geramy Loveless wrote:

> pbus_reassign_bridge_resources() refuses to release bridge windows that
> have child resources. On multi-port PCIe switches (e.g. Thunderbolt
> docks), empty sibling downstream ports hold small reservations that
> prevent the parent window from being freed and re-sized for rebar.
>=20
> Walk descendants of the target window depth-first, saving and freeing
> each empty bridge window so the parent can then be released and grown.
>=20
> Without this change, attempts to grow a window deep below a switch
> fabric leave nested empty windows pinning the ancestor:
>=20
>   pcieport 0000:65:00.0: bridge window [mem 0x8880000000-0x98800fffff
>     64bit pref]: not released, active children present
>   pcieport 0000:00:03.2: bridge window [mem 0x8880000000-0x98800fffff
>     64bit pref]: not released, active children present
>=20
> With the bottom-up walk and upstream ancestry check, the chain unwinds
> and the rebar succeeds:
>=20
>   pcieport 0000:96:00.0: bridge window [...]: releasing
>   pcieport 0000:95:00.0: bridge window [...]: releasing
>   pcieport 0000:94:00.0: bridge window [...]: releasing
>   pcieport 0000:65:00.0: bridge window [...]: releasing
>   amdgpu 0000:97:00.0: BAR 0 [mem 0x9000000000-0x97ffffffff 64bit pref]:
>     assigned
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
> RESEND: my earlier v3 (Message-ID 20260428225146.3104063-1-gloveless@jqlu=
v.com)
> was sent with stale code =E2=80=94 the diff was byte-identical to v2 beca=
use the
> v3 edits weren't staged before commit --amend. This resend contains the
> actual v3 content described below. Apologies for the noise.

Hi,

I already came to that conclusion before seeing this... It happens, no=20
worries. :-)

> v3:
>  - Restructure helper: outer loop only recurses; inner iterates bus
>    resources via pci_bus_for_each_resource(). The release path is now
>    unified, so the caller-side block in pbus_reassign_bridge_resources()
>    is gone.
>  - Walk the resource tree upstream when checking ancestry of @b_win,
>    so descendants in nested topologies are also released (Ilpo).
>  - Drop pci_resource_is_bridge_win() filter; bus resources are
>    inherently bridge windows.
>  - Rename pci_bus_release_empty_bridge_resources() to
>    pbus_release_empty_bridge_resources().
>  - Drop misleading "Uses PCI bus/device iterators..." paragraph from
>    commit message.
>  - Kerneldoc tweaks per Ilpo's review.
>=20
> v2:
>  - Use PCI bus/device iterators instead of walking raw resource tree.
>  - Save released resources to rollback list.
>  - Filter via pci_resource_is_bridge_win() (now removed in v3).
>  - Call release before the !res->child check.
>  - Check bridge->subordinate before recursion.
> ---
>  drivers/pci/setup-bus.c | 78 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 61 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5a..b47dc1a2925 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2292,6 +2292,63 @@ void pci_assign_unassigned_bridge_resources(struct=
 pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> =20
> +/*
> + * pbus_release_empty_bridge_resources - Bottom-up release of bridge win=
dows
> + * in empty subtrees.
> + * @bus: PCI bus whose child bridges to process
> + * @b_win: Ancestor bridge window; only resources that are (grand)parent=
ed
> + *=09   by @b_win are released
> + * @saved: List to store released resources into for rollback
> + *
> + * Recurses depth-first into subordinate buses, then releases bridge win=
dows
> + * that are (grand)parented by @b_win on the way back up. Each resource =
is
> + * stored into @saved before release so the entire operation can be roll=
ed
> + * back.
> + */
> +static void pbus_release_empty_bridge_resources(struct pci_bus *bus,
> +=09=09=09=09=09=09struct resource *b_win,
> +=09=09=09=09=09=09struct list_head *saved)
> +{
> +=09struct pci_dev *dev;
> +=09struct resource *r;
> +=09unsigned int i;
> +
> +=09list_for_each_entry(dev, &bus->devices, bus_list) {
> +=09=09if (dev->subordinate)
> +=09=09=09pbus_release_empty_bridge_resources(dev->subordinate,
> +=09=09=09=09=09=09=09    b_win, saved);
> +=09}
> +
> +=09pci_bus_for_each_resource(bus, r, i) {

While looking into i vs idx (which should be the same thing), I realized
there's one bad bug here:

pci_bus_for_each_resource() also iterates over subtractive decode bridge=20
resources for which you cannot take pci_resource_num(bus->self, r)=20
because that's invalid memorywise (they're resource of another struct=20
pci_dev). And passing idx then to pci_release_resource() is also invalid=20
(it might actually "work" as the second bug might reverse the effects of=20
the first one but it's still really bad).

What we want here is to only consider resources local to this bridge=20
(bus->self) so we need to add:

=09=09if (i < PCI_BRIDGE_RESOURCE_NUM)
=09=09=09break;

BUT, it might be worth adding a new iterator that doesn't have this trap:

=09pci_bridge_for_each_window(bridge, r, ...)

=2E..There would be some use for it in the existing code as well so I've=20
been considering adding it anyway to eliminate the various loop forms=20
that do this same iteration.

> +=09=09struct resource *p;
> +=09=09unsigned int idx;
> +
> +=09=09if (!r || !resource_assigned(r))
> +=09=09=09continue;
> +
> +=09=09/* Walk upstream to confirm r descends from (or equals) b_win */
> +=09=09for (p =3D r; p && p !=3D b_win; p =3D p->parent)
> +=09=09=09;
> +=09=09if (!p)
> +=09=09=09continue;

Can you place this loop into a new function that returns bool. I believe=20
it will also make the code easier to follow as you don't need p and can=20
return immmediately on match. With a reasonable name, you don't need the=20
comment anymore as the naming explains what the code does.

I've need for the same check myself (in some other changes I'm=20
developing), in preparation for that, I suggest placing the function under=
=20
pbus_select_window() as they're kind of related.

> +
> +=09=09idx =3D pci_resource_num(bus->self, r);

This can be dropped.

You can use i (+ PCI_BRIDGE_RESOURCES) in pci_release_resource() call.


The general structure of the code seems fine now.

> +
> +=09=09if (r->child) {
> +=09=09=09const char *res_name =3D pci_resource_name(bus->self, idx);
> +
> +=09=09=09pci_info(bus->self, "%s %pR: not released, active children pres=
ent\n",
> +=09=09=09=09 res_name, r);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09if (pci_dev_res_add_to_list(saved, bus->self, r, 0, 0))
> +=09=09=09continue;
> +
> +=09=09pci_release_resource(bus->self, idx);
> +=09}
> +}
> +
>  /*
>   * Walk to the root bus, find the bridge window relevant for @res and
>   * release it when possible. If the bridge window contains assigned
> @@ -2305,7 +2362,6 @@ static int pbus_reassign_bridge_resources(struct pc=
i_bus *bus, struct resource *
>  =09struct pci_dev *bridge =3D NULL;
>  =09LIST_HEAD(added);
>  =09LIST_HEAD(failed);
> -=09unsigned int i;
>  =09int ret =3D 0;
> =20
>  =09while (!pci_is_root_bus(bus)) {
> @@ -2314,22 +2370,10 @@ static int pbus_reassign_bridge_resources(struct =
pci_bus *bus, struct resource *
>  =09=09if (!res)
>  =09=09=09break;
> =20
> -=09=09i =3D pci_resource_num(bridge, res);
> -
> -=09=09/* Ignore BARs which are still in use */
> -=09=09if (!res->child) {
> -=09=09=09ret =3D pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
> -=09=09=09if (ret)
> -=09=09=09=09return ret;
> -
> -=09=09=09pci_release_resource(bridge, i);
> -=09=09} else {
> -=09=09=09const char *res_name =3D pci_resource_name(bridge, i);
> -
> -=09=09=09pci_warn(bridge,
> -=09=09=09=09 "%s %pR: was not released (still contains assigned resource=
s)\n",
> -=09=09=09=09 res_name, res);
> -=09=09}
> +=09=09/* Release this bridge window and any empty descendants bottom-up =
*/
> +=09=09if (bridge->subordinate)
> +=09=09=09pbus_release_empty_bridge_resources(bridge->subordinate,
> +=09=09=09=09=09=09=09    res, saved);
> =20
>  =09=09bus =3D bus->parent;
>  =09}
>=20

--=20
 i.

--8323328-1052843889-1777458859=:966--
