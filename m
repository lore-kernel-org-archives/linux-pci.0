Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322783845DC;
	Thu, 12 Mar 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321892; cv=none; b=fhsDbOAJuUFyaXq0flCKKurFBQ5M0iAd3LoGu9+MLmNBxNezKOmS0rpkiLYvh6pyoevfAWkzFLU78Z3+ISylNvH4OuER8DhFXWdm56zneCkED1l984ypnem2Yn/oIppaoFUo72AKVNkqnYbXLMlTcWlueAWZQLpLcnhybyp0Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321892; c=relaxed/simple;
	bh=QK+fgW1VLp/Imk+cJ4YNDn1nvmg37HIJ+4XHzeAbZbE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BDk1MJpPzVjm+N1YmKJ5YROQqGhta+MymiFQqXNYszdM2mHBYtrWBp7WKW4D5kBIjx4pQOaGBQCtZFVu1ErhHa2LsNW+JQVfn90ZNX1WIY+3jXJ5jvsO4odg0mHUo0eUCubxYnE1yaTIWZe8dTuNHkFLO4EJ+QWRFfqRYuM/H4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COfXnKuo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COfXnKuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773321889; x=1804857889;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QK+fgW1VLp/Imk+cJ4YNDn1nvmg37HIJ+4XHzeAbZbE=;
  b=COfXnKuoPQMpQVKjM2sMZZBbuSE/8djPw4B1kMG7vJ+5w9LtskEPcea3
   hBzORP4CecVFE7XnBXrmXnadnKnPRW8w20DCNGfo4eB/SKE2SLedZ8QUD
   s8i5fVIgKEolSIqHdoSU8lKp6Xn+BX46Cv+yWpZa7aAJP39dM3BK3atvO
   Ph4xnXmtVW2IH0l5ZW8aWRAmuiNe6QP/xL421F/6TPoYUzvQC8s+0oCgC
   u/Z2mLrmZ1w7xWI5ydHg5et0YqWYEmzvkx9Qt7dtlhsiuMpElC0aaIjfR
   Q594tIKpfOUxdoSOOyJ8PFCzO5pwx3MXlN9KHG9vphYIggsuJTf1qiA09
   w==;
X-CSE-ConnectionGUID: Ph3lN2WETpmqE3/HiYQ2XA==
X-CSE-MsgGUID: 3hHwJotIToyfPlLb77M4FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="78016544"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="78016544"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 06:24:33 -0700
X-CSE-ConnectionGUID: KQhJi9nTSbOjDaMph/MUuQ==
X-CSE-MsgGUID: eI1sKp4ETriwll7ozuWkQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="225271868"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 06:24:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Mar 2026 15:24:28 +0200 (EET)
To: Shawn Jin <shawn.jin@asteralabs.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
In-Reply-To: <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Message-ID: <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com>
References: <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <20260311231943.GA1086074@bhelgaas> <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-922834616-1773321868=:1070"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-922834616-1773321868=:1070
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Mar 2026, Shawn Jin wrote:

> After enabling more debugging messages for PCI subsystem, it shows the=20
> pref bridge window was shrunken by 1 at [  796.604883].=20
>=20
> Again, this is the kernel 6.8. I'll test 6.19 later using openSUSE=20
> Tumbleweed. This time the realloc was on.

Hi,

First of all, many of the changes related to this additional resource=20
distribution do not really make sense to me.

There's one fix that tries to rectify to most gross wrongness in the=20
adjustment itself because it caused a regression (not yet applied):

https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@linu=
x.intel.com/

It probably doesn't address the bug you see here though it may hide it.

> [  796.604869] pcieport 0000:96:01.0: distributing available resources
> [  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001fffff=
] extended by 0x0000000000100000
> [  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags 0x0]=
 extended by 0x0000000000055555
> [  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001fffff=
] shrunken by 0x00000000000aaaac
> [  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfffffff=
ff 64bit pref] shrunken by 0x0000000000000001
> [  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags 0x0]=
 extended by 0x0000000000055555

Note how it's not just -1 that seems wrong, the other numbers too seem=20
non-round (to 1M) as well.

There seems to be a number of problems with this entire algorithm.

I think the -1 comes from remove_dev_resource() that is called for a=20
resource which does have !res->flags (+ res->start=3Dres->end=3D0 ->=20
resource_size(res) =3D=3D 1).

So could you please try the patch below.

Not that the fix makes everything okay IMO but perhaps it addresses this=20
particular case. It's not even clear to me how some of the cases with not=
=20
valid bridge windows should be dealt with while distributing the=20
additional memory between the bridges.


The 55555 cases probably come from align =3D=3D 0 which makes=20
ALIGN_DOWN_IF_NONZERO() to produce non-aligning sizes. The fix patch below=
=20
might address it.

I don't (yet) understand how that aaaac came to be, I suppose it somehow=20
relates to this doing something unexpected so if you want to check that=20
out, it would be helpful:

=09=09align =3D pci_resource_alignment(bridge, res);
                if (!resource_assigned(res) && align)
                        available[i].start =3D min(ALIGN(available[i].start=
, align),
                                                 available[i].end + 1);

Another option is remove_dev_resource() doing something that leads to it.

It might be worth adding debug traps for available[i] getting non-1M=20
aligned but it's not very clear to me how and where.


From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.intel=
=2Ecom>
Date: Thu, 12 Mar 2026 14:59:43 +0200
Subject: [PATCH 1/1] PCI: Skip not valid bridge windows while distributing
 resources
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

pci_bus_distribute_available_resources() distributes available
resources between downstream bridges, however, it does not take
into account cases where a bridge window is not valid.

Skip touching bridge windows that are not valid.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 61f769aaa2f6..4fcb5e0c44b4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1868,6 +1868,9 @@ static void remove_dev_resource(struct resource *avai=
l, struct pci_dev *dev,
 {
 =09resource_size_t size, align, tmp;
=20
+=09if (!res->flags)
+=09=09return;
+
 =09size =3D resource_size(res);
 =09if (!size)
 =09=09return;
@@ -1922,6 +1925,8 @@ static void pci_bus_distribute_available_resources(st=
ruct pci_bus *bus,
=20
 =09=09available[i] =3D available_in[i];
=20
+=09=09if (!res->flags)
+=09=09=09continue;
 =09=09/*
 =09=09 * The alignment of this bridge is yet to be considered,
 =09=09 * hence it must be done now before extending its bridge
@@ -1993,6 +1998,8 @@ static void pci_bus_distribute_available_resources(st=
ruct pci_bus *bus,
 =09=09for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
 =09=09=09res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);
=20
+=09=09=09if (!res->flags)
+=09=09=09=09continue;
 =09=09=09/*
 =09=09=09 * Make sure the split resource space is properly
 =09=09=09 * aligned for bridge windows (align it down to

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
--=20
2.39.5

--8323328-922834616-1773321868=:1070--
