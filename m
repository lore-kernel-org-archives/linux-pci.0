Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC640DFA1;
	Thu, 12 Mar 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337717; cv=none; b=NrwVEMiDHjtmOBFrZfJNydgqQfgAj71L46spqegVt3fb5RHDlwao+o8kpwEUHynSFkp2FcyoGagpqK3LlLJVcManollGJFuylKBWKtBjfzyT8Sg0Rk+n63xIUaK3HjiS7qMWlJqFkzsBo2yh8HEnkrhimd2u/nQ5qLbyZMfvGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337717; c=relaxed/simple;
	bh=vNeY9BEzB31wHirti/RD7g2xdCn37mumjwW9SQRT6aI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MingSZMPy2sQAtfNQiUwFBGoxA/PtdjVLyKM+X5l00ChPhN9NAiIpl0qhbVzVBSvz8nT9kedJMGIg08VoqRYe7FA+wz0UjLYhzsGA1d/mOkFiBNiuHrTgv+JI7t6YwhAcS4oAnOLMJ/AerJs1tV2C1kt2qrB+5OtnHAisvbf0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3ZRq9Td; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3ZRq9Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773337715; x=1804873715;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vNeY9BEzB31wHirti/RD7g2xdCn37mumjwW9SQRT6aI=;
  b=Z3ZRq9TdkkJ43OXH4KMIXLbpNJ+W1VjVohdyvTUnzybM80GW+4l6Xzcf
   2GmBCl2Xtgi6UoQCJ3rMXZtE5i5w2wjtnW3t9lOVhFFqZW/GasIFaPvV2
   FpPhzo8EoT05cU8qp8+12ovpeY1Aj/fmcZyRgnvgPipkKe4S/OJS1qLnT
   NvagVnkOaCmmxomaRYDyLYN4q3KDybSv5tFxMbxoGzVsCDKV8EY6yhi9z
   JJSvIKIMN0ZZP2DJgo1GTbdALHuw3+WqyAyfVS1eoz6fdyO1JVUHkZlGK
   CSiexr4o3VPg1fc+WjfLegRRATvLRRiT0lY6HH2zG4kYW4EkJkc7IZzHB
   Q==;
X-CSE-ConnectionGUID: yf/GjF1qQT2AusPJljTUqw==
X-CSE-MsgGUID: wabCfbFJQH2OatJt1iYF7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74141652"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74141652"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:48:34 -0700
X-CSE-ConnectionGUID: tG/VLZkgQOqwmFCtqjSf+Q==
X-CSE-MsgGUID: KsVb5T+/SlypBAevussNrA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:48:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Mar 2026 19:48:28 +0200 (EET)
To: Shawn Jin <shawn.jin@asteralabs.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
In-Reply-To: <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Message-ID: <885ad11d-cf87-d926-41c1-65ad16968bc8@linux.intel.com>
References: <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <20260311231943.GA1086074@bhelgaas> <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com> <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2033597033-1773337708=:1070"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2033597033-1773337708=:1070
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Mar 2026, Shawn Jin wrote:

> Hi Ilpo,
>=20
> Thanks for looking into the issue. Just a quick question. So the patch=20
> you linked and the patch you attached is for the latest kernel, not 6.8.=
=20
> Right? I'll try to install the latest kernel first and rerun my test and=
=20
> keep you updated.

Yes, they are for the latest trees but I can look into backporting them if=
=20
needed.

--
 i.

> ________________________________________
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, March 12, 2026 6:24 AM
> To: Shawn Jin <shawn.jin@asteralabs.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.co=
m>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@=
vger.kernel.org <linux-pci@vger.kernel.org>
> Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery
>=20
> [EXTERNAL EMAIL]
>=20
> Hi,
> First of all, many of the changes related to this additional resource
> distribution do not really make sense to me.
>=20
> There's one fix that tries to rectify to most gross wrongness in the
> adjustment itself because it caused a regression (not yet applied):
>=20
> https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@li=
nux.intel.com/
>=20
> It probably doesn't address the bug you see here though it may hide it.
>=20
> > [  796.604869] pcieport 0000:96:01.0: distributing available resources
> > [  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001fff=
ff] extended by 0x0000000000100000
> > [  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags 0x=
0] extended by 0x0000000000055555
> > [  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001fff=
ff] shrunken by 0x00000000000aaaac
> > [  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffff=
ffff 64bit pref] shrunken by 0x0000000000000001
> > [  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags 0x=
0] extended by 0x0000000000055555
>=20
> Note how it's not just -1 that seems wrong, the other numbers too seem
> non-round (to 1M) as well.
>=20
> There seems to be a number of problems with this entire algorithm.
> I think the -1 comes from remove_dev_resource() that is called for a
> resource which does have !res->flags (+ res->start=3Dres->end=3D0 ->
> resource_size(res) =3D=3D 1).
>=20
> So could you please try the patch below.
>=20
> Not that the fix makes everything okay IMO but perhaps it addresses this
> particular case. It's not even clear to me how some of the cases with not
> valid bridge windows should be dealt with while distributing the
> additional memory between the bridges.
>=20
> The 55555 cases probably come from align =3D=3D 0 which makes
> ALIGN_DOWN_IF_NONZERO() to produce non-aligning sizes. The fix patch belo=
w
> might address it.
>=20
> I don't (yet) understand how that aaaac came to be, I suppose it somehow
> relates to this doing something unexpected so if you want to check that
> out, it would be helpful:
>                 align =3D pci_resource_alignment(bridge, res);
>                 if (!resource_assigned(res) && align)
>                         available[i].start =3D min(ALIGN(available[i].sta=
rt, align),
>                                                  available[i].end + 1);
>=20
> Another option is remove_dev_resource() doing something that leads to it.
>=20
> It might be worth adding debug traps for available[i] getting non-1M
> aligned but it's not very clear to me how and where.
>=20
> From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.int=
el.com>
> Date: Thu, 12 Mar 2026 14:59:43 +0200
> Subject: [PATCH 1/1] PCI: Skip not valid bridge windows while distributin=
g
>  resources
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> pci_bus_distribute_available_resources() distributes available
> resources between downstream bridges, however, it does not take
> into account cases where a bridge window is not valid.
>=20
> Skip touching bridge windows that are not valid.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 61f769aaa2f6..4fcb5e0c44b4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1868,6 +1868,9 @@ static void remove_dev_resource(struct resource *av=
ail, struct pci_dev *dev,
>  {
>         resource_size_t size, align, tmp;
>=20
> +       if (!res->flags)
> +               return;
> +
>         size =3D resource_size(res);
>         if (!size)
>                 return;
> @@ -1922,6 +1925,8 @@ static void pci_bus_distribute_available_resources(=
struct pci_bus *bus,
>                 available[i] =3D available_in[i];
> +               if (!res->flags)
> +                       continue;
>                 /*
>                  * The alignment of this bridge is yet to be considered,
>                  * hence it must be done now before extending its bridge
> @@ -1993,6 +1998,8 @@ static void pci_bus_distribute_available_resources(=
struct pci_bus *bus,
>                 for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
>                         res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCES =
+ i);
>=20
> +                       if (!res->flags)
> +                               continue;
>                         /*
>                          * Make sure the split resource space is properly
>                          * aligned for bridge windows (align it down to
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> --
> 2.39.5
>=20
--8323328-2033597033-1773337708=:1070--
