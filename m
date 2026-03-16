Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8C38F949;
	Mon, 16 Mar 2026 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656936; cv=none; b=dfxmf/dL9ELA4Sde31+4d6TtcGDV4OOwwMTstWTcn187PWF6v11Ah72fYx0dB4eg2/Pqno+zYYFgMZQ1hACrY2TIi8OG9PrMT35ZInQiMIaAJpl8+m5wDbVULE4Cy7fR2La9/+pN/UwGuMFSxgCrCgxtOBqn3tX1lW4pDlRgDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656936; c=relaxed/simple;
	bh=nynCufnIHng4XOV1mZMK4zlgt0LF+8F3FuZTUB4Hid8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z5ZPixHIYDWqjQ+lLz0Y99/GzYXWi+K981Q0Jn3Q3htssdo/7K62WETmrcj63s3Q8FWb8jM4L19BEkZHpNUtBu3MxySyBnCN29p/iU5AtB8tpRtV8/nygFyK2G1MKzp40imsJqQOxyxHf7wSxvpP4mBb7XffYG92bfiTgMdBKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ya//ssED; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ya//ssED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656934; x=1805192934;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nynCufnIHng4XOV1mZMK4zlgt0LF+8F3FuZTUB4Hid8=;
  b=Ya//ssEDv8yCabMIo/ghZM11LKHpZW5FhwKBbA7xHe0vvrVWeQxukZ2T
   /b5Ou8RwSJiyi780WH8C22G9JMLYlNCRmo/MiqeQLWqrhtMS8bTiQBxX1
   hrK0hsRdPEZhVwrIGo/vSZTouB6wjJaVaeNH8ggF0rvzotJit6C+2cm31
   m7F4e1Kly2/ff8idyPsZSe3idE8dfkwtJesmjxZOfvcaOfXt0UojSEPU0
   7J8I3slYgu8kFUj5BbcOIfOhej3oh/NtsN5/dLCNA88RjwjkwBrCrVuCW
   D6t1BHqofCHivvY7b+lQ3B9rWT2jWIRLP+RCqTRnMpoYSj0oi2cvVnkgU
   Q==;
X-CSE-ConnectionGUID: 7r+4UxeqQBme0QY/aGQPew==
X-CSE-MsgGUID: f269FOgiTwyIo1+DmeQwVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74585703"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74585703"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:28:53 -0700
X-CSE-ConnectionGUID: 0xdbwNS5Rt+Kk1Y+/YT3zw==
X-CSE-MsgGUID: mFWSIkg7TWCxiIuxoSiVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226336749"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.253])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:28:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Mar 2026 12:28:46 +0200 (EET)
To: Shawn Jin <shawn.jin@asteralabs.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit
 addresses after Secondary Bus Reset recovery
In-Reply-To: <LV8P221MB147282D317C952564A739B369945A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Message-ID: <2a53776e-1e5e-74b0-1079-1ac8163efccd@linux.intel.com>
References: <LV8P221MB1472A24B9975F7C8E8D6BF929947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <20260311231943.GA1086074@bhelgaas> <LV8P221MB147241DCED82480888F8D73D9947A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <LV8P221MB14726A1B6959675557ED1AC29944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
 <a128f2d6-4311-a9a3-5e10-267f46db709e@linux.intel.com> <LV8P221MB14722013ED06CFDD3AFF161E9944A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM> <885ad11d-cf87-d926-41c1-65ad16968bc8@linux.intel.com>
 <LV8P221MB147282D317C952564A739B369945A@LV8P221MB1472.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1533281898-1773656548=:1005"
Content-ID: <ebff200b-13e0-483d-33bf-ac521e20022e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1533281898-1773656548=:1005
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <991cf6b0-5af2-7ddb-62e7-86a27d53c269@linux.intel.com>

On Fri, 13 Mar 2026, Shawn Jin wrote:

> Hi Ilpo and Bjorn,
>=20
> A quick update on the test result with the kernel 6.19.6-1-default in ope=
nSUSE Tumbleweed.
>=20
> Summary:
> 1. With PCI realloc off, the bridge windows were reassigned as before, th=
e ending addresses look normal, all ending with 0xffff.
> 2. With PCI realloc on, the non-pref window ending address is still incor=
rect: 0xe1a55554. But the pref window looks right.
> [  482.943430] [   T1435] pci 0000:99:01.0: bridge window [mem 0x13400000=
0000-0x1347ffffffff 64bit pref]: assigned
> [  482.943431] [   T1435] pci 0000:99:01.0: bridge window [mem 0xe1a00000=
-0xe1a55554]: assigned

Was this window initially zero sized? That would explain why align becomes=
=20
zero.

> Details:
> Focused topology:
> -[0000:94]---01.0-[95-9e]----00.0-[96-9e]----01.0-[98-9c]----00.0-[99-9c]=
--+-00.0-[9a]--
>                                                                          =
  +-01.0-[9b]----00.0  Device 1e3e:0002
>                                                                          =
  \-02.0-[9c]--
> Test 1: realloc OFF
> // Cold boot
> [    2.132565] [      T1] pci 0000:99:00.0: PCI bridge to [bus 9a]
> [    2.133202] [      T1] pci 0000:99:01.0: PCI bridge to [bus 9b]
> [    2.133413] [      T1] pci 0000:99:01.0:   bridge window [mem 0xe96000=
00-0xe96fffff]
> [    2.133555] [      T1] pci 0000:99:01.0:   bridge window [mem 0x13b000=
000000-0x13b7ffffffff 64bit pref]
> [    2.133827] [      T1] pci 0000:99:02.0: PCI bridge to [bus 9c]
> [    2.134453] [      T1] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
> [    2.134565] [      T1] pci 0000:98:00.0:   bridge window [mem 0xe96000=
00-0xe96fffff]
> [    2.134647] [      T1] pci 0000:98:00.0:   bridge window [mem 0x13b000=
000000-0x13b7ffffffff 64bit pref]
> [    2.134809] [      T1] pci 0000:96:01.0: PCI bridge to [bus 98-9c]
> [    2.134830] [      T1] pci 0000:96:01.0:   bridge window [mem 0xe96000=
00-0xe96fffff]
> [    2.134845] [      T1] pci 0000:96:01.0:   bridge window [mem 0x13b000=
000000-0x13b7ffffffff 64bit pref]
> // after SBR
> [  202.341320] [   T1430] pci 0000:99:01.0: PCI bridge to [bus 9b]
> [  202.341539] [   T1430] pci 0000:99:01.0:   bridge window [mem 0xe96000=
00-0xe96fffff]
> [  202.341680] [   T1430] pci 0000:99:01.0:   bridge window [mem 0x13b000=
000000-0x13b7ffffffff 64bit pref]
> [  202.341950] [   T1430] pci 0000:99:02.0: PCI bridge to [bus 9c]
> [  202.342573] [   T1430] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
> [  202.342685] [   T1430] pci 0000:98:00.0:   bridge window [mem 0xe96000=
00-0xe96fffff]
> [  202.342766] [   T1430] pci 0000:98:00.0:   bridge window [mem 0x13b000=
000000-0x13b7ffffffff 64bit pref]
> [  202.342929] [   T1430] pcieport 0000:96:01.0: PCI bridge to [bus 98-9c=
]
> [  202.342951] [   T1430] pcieport 0000:96:01.0:   bridge window [mem 0xe=
9600000-0xe96fffff]
> [  202.342964] [   T1430] pcieport 0000:96:01.0:   bridge window [mem 0x1=
3b000000000-0x13b7ffffffff 64bit pref]
>=20
> // although the bridges don't have IO windows, the dbg message showing th=
e window extension may be a bit worrisome.
> [  202.340536] [   T1430] pci 0000:99:00.0: bridge window [io  size 0x000=
0 disabled] extended by 0x0000000000000555
> [  202.340538] [   T1430] pci 0000:99:01.0: bridge window [io  size 0x000=
0 disabled] extended by 0x0000000000000555
> [  202.340538] [   T1430] pci 0000:99:02.0: bridge window [io  size 0x000=
0 disabled] extended by 0x0000000000000555

This again is thanks to align being 0 because resource_size() =3D=3D 0 so=
=20
ALIGN_DOWN_IF_NONZERO() doesn't do anything useful.

I wonder if it would make sense to handle the minimum alignment of bridge=
=20
windows properly in pci_resource_alignment(). It currently can return 0=20
for bridge windows but we've well-defined alignment lower bounds for those=
=20
which I think could be applied right there at source instead of having=20
the callers have to worry about getting the alignment lower bounding=20
right.

--=20
 i.

> Test 2: realloc ON
> // code boot
> [    2.146003] [      T1] pci_bus 0000:96: resource 1 [mem 0xe1800000-0xe=
1dfffff]
> [    2.146004] [      T1] pci_bus 0000:96: resource 2 [mem 0x134000000000=
-0x1348004fffff 64bit pref]
> [    2.146007] [      T1] pci_bus 0000:98: resource 0 [io  size 0x1000]
> [    2.146008] [      T1] pci_bus 0000:98: resource 1 [mem 0xe1a00000-0xe=
1bfffff]
> [    2.146009] [      T1] pci_bus 0000:98: resource 2 [mem 0x134000000000=
-0x1347ffffffff 64bit pref]
> [    2.146010] [      T1] pci_bus 0000:99: resource 1 [mem 0xe1a00000-0xe=
1afffff]
> [    2.146011] [      T1] pci_bus 0000:99: resource 2 [mem 0x134000000000=
-0x1347ffffffff 64bit pref]
> [    2.146012] [      T1] pci_bus 0000:9b: resource 1 [mem 0xe1a00000-0xe=
1afffff]
> [    2.146013] [      T1] pci_bus 0000:9b: resource 2 [mem 0x134000000000=
-0x1347ffffffff 64bit pref]
>=20
> // after SBR
> // USP 98:00.0's windows still look correct
> [  482.943427] [   T1435] pci 0000:98:00.0: bridge window [mem 0x13400000=
0000-0x1347ffffffff 64bit pref]: assigned
> [  482.943429] [   T1435] pci 0000:98:00.0: bridge window [mem 0xe1a00000=
-0xe1bfffff]: assigned
> // DSP 99:01.0 pref window is good
> [  482.943430] [   T1435] pci 0000:99:01.0: bridge window [mem 0x13400000=
0000-0x1347ffffffff 64bit pref]: assigned
> // DSP 99:01.0 non-pref window ending addr is wrong: 0xe1a55554
> [  482.943431] [   T1435] pci 0000:99:01.0: bridge window [mem 0xe1a00000=
-0xe1a55554]: assigned
> [  482.943432] [   T1435] pci 0000:99:00.0: PCI bridge to [bus 9a]
> [  482.944063] [   T1435] pci 0000:9b:00.0: BAR 0 [mem 0x134000000000-0x1=
347ffffffff 64bit pref]: assigned
> [  482.944164] [   T1435] pci 0000:9b:00.0: BAR 2 [mem 0xe1a00000-0xe1a3f=
fff]: assigned
> [  482.944202] [   T1435] pci 0000:99:01.0: PCI bridge to [bus 9b]
> [  482.944424] [   T1435] pci 0000:99:01.0:   bridge window [mem 0xe1a000=
00-0xe1a55554]
> [  482.944565] [   T1435] pci 0000:99:01.0:   bridge window [mem 0x134000=
000000-0x1347ffffffff 64bit pref]
> [  482.944837] [   T1435] pci 0000:99:02.0: PCI bridge to [bus 9c]
> [  482.945463] [   T1435] pci 0000:98:00.0: PCI bridge to [bus 99-9c]
> [  482.945575] [   T1435] pci 0000:98:00.0:   bridge window [mem 0xe1a000=
00-0xe1bfffff]
> [  482.945657] [   T1435] pci 0000:98:00.0:   bridge window [mem 0x134000=
000000-0x1347ffffffff 64bit pref]
> [  482.945820] [   T1435] pcieport 0000:96:01.0: PCI bridge to [bus 98-9c=
]
> [  482.945842] [   T1435] pcieport 0000:96:01.0:   bridge window [mem 0xe=
1a00000-0xe1bfffff]
> [  482.945856] [   T1435] pcieport 0000:96:01.0:   bridge window [mem 0x1=
34000000000-0x1347ffffffff 64bit pref]
> [  482.945883] [   T1435] PCI: No. 2 try to assign unassigned res
> [  482.945885] [   T1435] pci 0000:99:00.0: disabling bridge window [mem =
size 0x00000000 64bit pref disabled] to [bus 9a] (unused)
> // DSP 99:00.0 doesn't have any EP attached. But the mem size 0x55555 loo=
ks very suspicious.
> [  482.945886] [   T1435] pci 0000:99:00.0: disabling bridge window [mem =
size 0x00055555 disabled] to [bus 9a] (unused)
> [  482.945887] [   T1435] pci 0000:99:02.0: disabling bridge window [mem =
size 0x00000000 64bit pref disabled] to [bus 9c] (unused)
> // Same for DSP 99:02.0
> [  482.945888] [   T1435] pci 0000:99:02.0: disabling bridge window [mem =
size 0x00055555 disabled] to [bus 9c] (unused)
>=20
> Hope the above info gives you some hints.
>
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, March 12, 2026 10:48 AM
> To: Shawn Jin <shawn.jin@asteralabs.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.co=
m>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pci@=
vger.kernel.org <linux-pci@vger.kernel.org>
> Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limit =
addresses after Secondary Bus Reset recovery
>=20
> [EXTERNAL EMAIL]
>=20
> On Thu, 12 Mar 2026, Shawn Jin wrote:
>=20
> > Hi Ilpo,
> >
> > Thanks for looking into the issue. Just a quick question. So the patch
> > you linked and the patch you attached is for the latest kernel, not 6.8=
=2E
> > Right? I'll try to install the latest kernel first and rerun my test an=
d
> > keep you updated.
>=20
> Yes, they are for the latest trees but I can look into backporting them i=
f
> needed.
>=20
> --
>  i.
>=20
> > ________________________________________
> > From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Thursday, March 12, 2026 6:24 AM
> > To: Shawn Jin <shawn.jin@asteralabs.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.=
com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-pc=
i@vger.kernel.org <linux-pci@vger.kernel.org>
> > Subject: Re: [BUG] PCIe bridge resource allocation creates invalid limi=
t addresses after Secondary Bus Reset recovery
> >
> > [EXTERNAL EMAIL]
> >
> > Hi,
> > First of all, many of the changes related to this additional resource
> > distribution do not really make sense to me.
> >
> > There's one fix that tries to rectify to most gross wrongness in the
> > adjustment itself because it caused a regression (not yet applied):
> >
> > https://lore.kernel.org/linux-pci/20260219153951.68869-1-ilpo.jarvinen@=
linux.intel.com/
> >
> > It probably doesn't address the bug you see here though it may hide it.
> >
> > > [  796.604869] pcieport 0000:96:01.0: distributing available resource=
s
> > > [  796.604872] pci 0000:98:00.0: bridge window [mem 0x00100000-0x001f=
ffff] extended by 0x0000000000100000
> > > [  796.604876] pci 0000:99:00.0: bridge window [??? 0x00000000 flags =
0x0] extended by 0x0000000000055555
> > > [  796.604880] pci 0000:99:01.0: bridge window [mem 0x00100000-0x001f=
ffff] shrunken by 0x00000000000aaaac
> > > [  796.604883] pci 0000:99:01.0: bridge window [mem 0x800000000-0xfff=
ffffff 64bit pref] shrunken by 0x0000000000000001
> > > [  796.604886] pci 0000:99:02.0: bridge window [??? 0x00000000 flags =
0x0] extended by 0x0000000000055555
> >
> > Note how it's not just -1 that seems wrong, the other numbers too seem
> > non-round (to 1M) as well.
> >
> > There seems to be a number of problems with this entire algorithm.
> > I think the -1 comes from remove_dev_resource() that is called for a
> > resource which does have !res->flags (+ res->start=3Dres->end=3D0 ->
> > resource_size(res) =3D=3D 1).
> >
> > So could you please try the patch below.
> >
> > Not that the fix makes everything okay IMO but perhaps it addresses thi=
s
> > particular case. It's not even clear to me how some of the cases with n=
ot
> > valid bridge windows should be dealt with while distributing the
> > additional memory between the bridges.
> >
> > The 55555 cases probably come from align =3D=3D 0 which makes
> > ALIGN_DOWN_IF_NONZERO() to produce non-aligning sizes. The fix patch be=
low
> > might address it.
> >
> > I don't (yet) understand how that aaaac came to be, I suppose it someho=
w
> > relates to this doing something unexpected so if you want to check that
> > out, it would be helpful:
> >                 align =3D pci_resource_alignment(bridge, res);
> >                 if (!resource_assigned(res) && align)
> >                         available[i].start =3D min(ALIGN(available[i].s=
tart, align),
> >                                                  available[i].end + 1);
> >
> > Another option is remove_dev_resource() doing something that leads to i=
t.
> >
> > It might be worth adding debug traps for available[i] getting non-1M
> > aligned but it's not very clear to me how and where.
> >
> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.i=
ntel.com>
> > Date: Thu, 12 Mar 2026 14:59:43 +0200
> > Subject: [PATCH 1/1] PCI: Skip not valid bridge windows while distribut=
ing
> >  resources
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > pci_bus_distribute_available_resources() distributes available
> > resources between downstream bridges, however, it does not take
> > into account cases where a bridge window is not valid.
> >
> > Skip touching bridge windows that are not valid.
> >
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 61f769aaa2f6..4fcb5e0c44b4 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1868,6 +1868,9 @@ static void remove_dev_resource(struct resource *=
avail, struct pci_dev *dev,
> >  {
> >         resource_size_t size, align, tmp;
> >
> > +       if (!res->flags)
> > +               return;
> > +
> >         size =3D resource_size(res);
> >         if (!size)
> >                 return;
> > @@ -1922,6 +1925,8 @@ static void pci_bus_distribute_available_resource=
s(struct pci_bus *bus,
> >                 available[i] =3D available_in[i];
> > +               if (!res->flags)
> > +                       continue;
> >                 /*
> >                  * The alignment of this bridge is yet to be considered=
,
> >                  * hence it must be done now before extending its bridg=
e
> > @@ -1993,6 +1998,8 @@ static void pci_bus_distribute_available_resource=
s(struct pci_bus *bus,
> >                 for (i =3D 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> >                         res =3D pci_resource_n(dev, PCI_BRIDGE_RESOURCE=
S + i);
> >
> > +                       if (!res->flags)
> > +                               continue;
> >                         /*
> >                          * Make sure the split resource space is proper=
ly
> >                          * aligned for bridge windows (align it down to
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > --
> > 2.39.5
> >
>=20
--8323328-1533281898-1773656548=:1005--
