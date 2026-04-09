Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE042749DC
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741211; cv=none; b=YzZt3L3coofhurXd1ErhQd0p8fu+dqB24XPOLSNHGmb/OkzwfALf5uGWpDbG1hjmO9Hl/m/zO+LTcJ8QdYJx2/x7z7fWPxD7GxhleKFFI1lIMC618AN3+s0u8WgMu8QDrsqXxMIgkx10gUyzuVD66FcpH9LhWLTHTzzchBnx+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741211; c=relaxed/simple;
	bh=LdDisOMGiGNWzGjHA1VjgRKrig7jD6aUWtcfv6Nfl2k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eEyLvAi3jQx7KnlLNmhUMLK7scW9FAP1XqwsOHx+F2cOgUuYfYXNBxAg8ypdeh1DgCUmbCeMRK5NcASMS223w2ZKtA7vDFM4SEneG6aWOs7ZR1R7xK0ZXp1OOTKtpcLfKKf1OuluHaO8Er3lteRqovIRtDIyyYE8cTvwdo08QXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0Ne5uNF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0Ne5uNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775741209; x=1807277209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LdDisOMGiGNWzGjHA1VjgRKrig7jD6aUWtcfv6Nfl2k=;
  b=n0Ne5uNF40byPj+dYv8aYHI9bXhcsN3oXvzyJBWqMLxPzVjDVWnuKP0L
   x5QINtkYc6Q9OgHhuXfCRb6XgeVUxIZbGG1jLVG0WnYSszkeXsgF8/eFP
   tEyYwKPC4o75xQX2xhOHyjCiV5sAnHfO6Ol9VxOn/CGy7xij7yKkNIqMM
   HQdbwa005BQfdEooOtd3ZnYX5x1vfCpz6Ko6LZdgqTBUyx5ubEkEFexbm
   F3pGZ1hqI7rutT2+X6tvSXYPJsNVBiJRcqsh5lk0p1FiqugzOKGLurfhg
   nyY3L10ToleqIQqGtBh/6pbo3MhjKm0kehqRGBgydolkyeBCQjqwTEuId
   Q==;
X-CSE-ConnectionGUID: owFwKTKEQp+yDH848Jyrsw==
X-CSE-MsgGUID: Fddk/FpsSyegNf8vN1Y/kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87442380"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87442380"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:26:48 -0700
X-CSE-ConnectionGUID: +a3KZ+yFSbCe/HWMzKtiNw==
X-CSE-MsgGUID: Ks5xYG8+TQORPQUJCt2meg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228700593"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.197])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 06:26:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Apr 2026 16:26:43 +0300 (EEST)
To: Geramy Loveless <gloveless@jqluv.com>
cc: linux-pci@vger.kernel.org, cristi@ieee.org
Subject: Re: [PATCH] PCI: release empty sibling resources during bridge window
 resize
In-Reply-To: <CAGpo2mcyLhY6muz9Zgg3zD=Ux-HT8RXeMvbUi27a+SX=VxCRPQ@mail.gmail.com>
Message-ID: <f2cf6508-e2e8-d567-66f3-51b094585434@linux.intel.com>
References: <CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com> <4203a8ea-25a3-72e1-c071-db371be045e1@linux.intel.com> <CAGpo2mcyLhY6muz9Zgg3zD=Ux-HT8RXeMvbUi27a+SX=VxCRPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1390774046-1775741203=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1390774046-1775741203=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Apr 2026, Geramy Loveless wrote:

> Perfect I=E2=80=99ll get started on these changes, while I=E2=80=99m here=
, does the other bug create
> a cascade of problems if fixed?=C2=A0

Hi,

I'm not sure what "other bug" refers to?

If you meant Cristian problem, he seemed to have empty bridge windows=20
which this approach should be able to solve without extra problems=20
expected.

If you refer to the resource entries having dangling resource tree=20
pointers (sibling, etc.), it's not a big problem when the resource entry=20
has been detached from the tree. It has some impact on whether=20
resource_assigned() can always be trusted so it would be nice to clear all=
=20
those links on removal (the current remove algorithm shortcuts the=20
subtree).

--=20
 i.

> On Thu, Apr 9, 2026 at 1:03=E2=80=AFAM Ilpo J=C3=A4rvinen <ilpo.jarvinen@=
linux.intel.com> wrote:
>       On Wed, 8 Apr 2026, Geramy Loveless wrote:
>=20
>       Thanks for the patch. The patch need some work but the general dire=
ction
>       looks acceptable.
>=20
>       FYI, your patch is misformatted, tabs got eaten, probably something=
 in
>       tha way you send the email does that.
>=20
>       Please Cc also Cristian Cocos <cristi@ieee.org> on further submissi=
ons.
>=20
>       > When pci_resize_resource() walks up the bridge hierarchy via
>       > pbus_reassign_bridge_resources(), bridge windows with any child
>       > resources are refused release. This prevents BAR resize on device=
s
>       > behind multi-port PCIe switches (such as Thunderbolt docks) where
>       > empty sibling downstream ports hold small reservations that block=
 the
>       > parent bridge window from being freed and re-sized.
>       >
>       > Add pci_bus_release_bridge_resources_safe() which verifies that a
>       > resource subtree contains no active children before releasing it,
>       > and use it in pbus_reassign_bridge_resources() to clear empty sib=
ling
>       > reservations so the bridge window can grow.
>       >
>       > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
>=20
>       You may want to add Suggested-by tag.
>=20
>       > ---
>       > drivers/pci/setup-bus.c | 30 +++++++++++++++++++++++++++---
>       > 1 file changed, 27 insertions(+), 3 deletions(-)
>       >
>       > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>       > index 4cf120ebe..9a3a23819 100644
>       > --- a/drivers/pci/setup-bus.c
>       > +++ b/drivers/pci/setup-bus.c
>       > @@ -2297,6 +2297,30 @@
>       > EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>       > * release it when possible. If the bridge window contains assigne=
d
>       > * resources, it cannot be released.
>       > */
>       > +
>       > +/*
>       > + * Release child resources from a bridge window so it can be fre=
ed and
>       > + * re-sized, but only if the entire subtree is empty (no active =
device
>       > + * resources underneath). Walks the resource tree recursively to
>       handle
>       > + * arbitrarily deep bridge hierarchies. Returns true if the reso=
urces
>       > + * were released or the window was already empty.
>       > + */
>       > +static bool pci_bus_release_bridge_resources_safe(struct pci_bus=
 *bus,
>       > + struct resource *res)
>       > +{
>       > + struct resource *child;
>       > +
>       > + for (child =3D res->child; child; child =3D child->sibling) {
>       > + if (child->child &&
>       > + !pci_bus_release_bridge_resources_safe(bus, child))
>       > + return false;
>=20
>       This should walk bus devices and device resources using PCI side
>       iterators (not using the low-level resource list). This does not lo=
ok
>       safe iteration anyway because the code is also removing entries fro=
m the
>       resource tree (it only works because resource code leaves stale sib=
ling
>       pointers which should be corrected one day).
>=20
>       PCI side should be enough to capture all resources, and that way yo=
u
>       still have access to all PCI side structs.
>=20
>       Perhaps sanity checking ! ->child at the end wouldn't hurt but it t=
he
>       release should be doable.
>=20
>       You should also pass the saved list and store any released resource=
s so
>       you can properly rollback in case of a failure (I think the rollbac=
k
>       code will already just-work as long as you add the entries there).
>=20
>       > + }
>       > +
>       > + if (res->child)
>       > + pci_bus_release_bridge_resources(bus, res, whole_subtree);
>=20
>       I think this could pass non-bridge window resources which looks wro=
ng but
>       you need to rewrite the algorithm in this function anyway.
>=20
>       > + return true;
>       > +}
>       > +
>       > static int pbus_reassign_bridge_resources(struct pci_bus *bus, st=
ruct
>       > resource *res,
>       > struct list_head *saved)
>       > {
>       > @@ -2316,8 +2340,8 @@ static int pbus_reassign_bridge_resources(s=
truct
>       > pci_bus *bus, struct resource *
>       > i =3D pci_resource_num(bridge, res);
>       > - /* Ignore BARs which are still in use */
>       > - if (!res->child) {
>       > + if (!res->child ||
>       > + pci_bus_release_bridge_resources_safe(bridge->subordinate, res)=
) {
>=20
>       Just call this release always before checking !res->child.
>=20
>       You need to check bridge->subordinate before calling it.
>=20
>       > ret =3D pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
>       > if (ret)
>       > return ret;
>       > @@ -2327,7 +2351,7 @@ static int pbus_reassign_bridge_resources(s=
truct
>       > pci_bus *bus, struct resource *
>       > const char *res_name =3D pci_resource_name(bridge, i);
>       > pci_warn(bridge,
>       > - "%s %pR: was not released (still contains assigned resources)\n=
",
>       > + "%s %pR: not released, active children present\n",
>       > res_name, res);
>       > }
>       >
>=20
>       --
>       =C2=A0i.
>=20
>=20
>=20
--8323328-1390774046-1775741203=:968--
