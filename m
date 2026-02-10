Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6FB67E;
	Tue, 10 Feb 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736782; cv=none; b=mdRSK+JEequm2JLd228BHv7tGNTT4YVtZissmyQTmGWQ3+z3fBgd1ohlJ+3F/XotzxY6gCDLGfG5ytKxsKsAuMYAMcuWbD2lqW8YLuSRQW9vmW6UP8AhWOxAv8I/3/Z8/tgqtHCbT0qxIZyNku1rOp9bWnwcNhsQzz4FTrypyms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736782; c=relaxed/simple;
	bh=WYsnuOrjtH9iGrSXCZu7ckcgJbP6NETCClfsTMPN5JU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ARoIhlfst7MG1vBdakUFPN82x8DWPZMSAeagBimlpMsd1kWHpxuoBkHbTiODlFarkkvASzX5AGfduI/wuSm/0hI+UqPndFrTPR3LXiT4Rbr9UMPzquU4skd6UYprh6PU+ufNS17cgMyMmqpxzmdA8zRrDRJjfOTbsr7CTiqctDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N295xSuw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N295xSuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770736781; x=1802272781;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WYsnuOrjtH9iGrSXCZu7ckcgJbP6NETCClfsTMPN5JU=;
  b=N295xSuwu5T+eLVjNNwD3sZSuTEkoDDOT6ZsUp/OYyEoqaj++uPG1+D4
   0Xpgg82xAedh6wFO8hbYv4NQvf/F7rQKEhJqc0Cmxy6AVTduDRk/0uc27
   X4FXPQNFxFn2npfAmj3YUzDcbMeIMIdrGaIJheMlWGLkumJaezb8ye5Kw
   q7LsIGDqmKaeit7v/pM5cYdgUix6NNHMnK27RiYJPnhieePunanApgsvq
   Mb5kw9liCcdgOxJVlWg9yrB+lyjY5/ZTPx/K9Qj/8fWOItdXKBVL/nc8t
   kEXuTYMcFa9dQQ3j7dSzxczPYx0sSpANyx/9Iyrc+XN5VZslwWzHQDBKh
   g==;
X-CSE-ConnectionGUID: WbjI1ru9SuSJmFP1eIuOPA==
X-CSE-MsgGUID: dV0ht1F5SoqK0fkOWodMwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59433144"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="59433144"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:19:40 -0800
X-CSE-ConnectionGUID: 9OUCX4GfS6OGbEFGD4/ToA==
X-CSE-MsgGUID: NoIdeoHySFC1zqx4x1Ovxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216116394"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.63])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:19:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Feb 2026 17:19:35 +0200 (EET)
To: Kai-Heng Feng <kaihengf@nvidia.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Validate window resource type in
 pbus_select_window_for_type()
In-Reply-To: <20260210142058.82701-1-kaihengf@nvidia.com>
Message-ID: <e6641952-ecc2-3f91-1ba8-e1b2c01cf624@linux.intel.com>
References: <20260210142058.82701-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1452726660-1770736775=:992"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1452726660-1770736775=:992
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Feb 2026, Kai-Heng Feng wrote:

> Afer commit ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during
> IO window sizing") and commit ae88d0b9c57f ("PCI: Use
> pbus_select_window_for_type() during mem window sizing"), many bridge
> window can't get resource assigned:
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: can't assign; no space
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: failed to assign
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: can't assign; no space
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: failed to assign
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: can't assign; no space
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: failed to assign
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: can't assign; no space
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x200800=
00]: failed to assign
>=20
> Those commits replace find_bus_resource_of_type() with
> pbus_select_window_for_type(), and the latter lacks resource type
> validation.
>=20
> This commit adds the resource type validation back to
> pbus_select_window_for_type() to match the original behavior.
>=20
> Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221072
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  drivers/pci/setup-bus.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e680f75a5b5e..1b5185697011 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -224,14 +224,21 @@ static struct resource *pbus_select_window_for_type=
(struct pci_bus *bus,
> =20
>  =09switch (iores_type) {
>  =09case IORESOURCE_IO:
> -=09=09return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +=09=09win =3D pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +=09=09if (win && (win->flags & IORESOURCE_IO))
> +=09=09=09return win;
> +=09=09return NULL;
> =20
>  =09case IORESOURCE_MEM:
>  =09=09mmio =3D pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
>  =09=09mmio_pref =3D pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WIND=
OW);
> =20
> -=09=09if (!(type & IORESOURCE_PREFETCH) ||
> -=09=09    !(mmio_pref->flags & IORESOURCE_MEM))
> +=09=09if (mmio && !(mmio->flags & IORESOURCE_MEM))
> +=09=09=09mmio =3D NULL;
> +=09=09if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
> +=09=09=09mmio_pref =3D NULL;
> +
> +=09=09if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
>  =09=09=09return mmio;
> =20
>  =09=09if ((type & IORESOURCE_MEM_64) ||

Thanks for fixing this,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1452726660-1770736775=:992--
