Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2A41B358;
	Wed,  8 Jul 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519527; cv=none; b=ewOGXj6pWaYNu8sMuv+1vhBBgl+wZiajN7f95L/zxBBWG9EC3Qu0nM0GqpgRqAsMKU+M23BG0LwVFN4d1+RtE63YV2nP8bqTEMG0IIpZDvo+s8GBKFRkKgcUt6FAR9CVGb5LHafr4ssgmCI0VivHdSxSI5yqYwXyJXgBHP36B0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519527; c=relaxed/simple;
	bh=sF/vtIzYIqe3aumg9sXiAS+jh+O/Zb09pjwdXWv0Mwk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rQgqK6w3jSJso/cZIKlXc2t0COeTlgUlJTIWnn9HIXTdJ/N7KTnYNGaiIJaErPH4LxpQZhD7nbijtxKaMn1xam/nKYDCN9DRLd9Jw5rxBff9vg2+nfh5m1N/xiXVIXTx8qhXVgjeP+TKPNu3NUPuRLVggTacUdnevi6ijnUiTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMgPro54; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMgPro54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783519526; x=1815055526;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=sF/vtIzYIqe3aumg9sXiAS+jh+O/Zb09pjwdXWv0Mwk=;
  b=SMgPro543CAU0T6F1MMKJAaFnI3JUN1uakOhiUcLIcdPJ9+r0aO/9QzX
   RI4ciims6SQ/97eZu+Iti/q7DXK4sUY+xC7Vvs8ayX2qYVjhaagqZdrQf
   ndRPteuvLJed//G/LpmzYWnz1qNCYZseNREK+41S5n4jN9R+wm5WKJUN4
   Wx5ZXjXiis8W3JgFhqYK5tNv6sG8Va2DjhaqocWhClgoB2U/GFpg+ojm/
   4WF0QBNlSGP0Y3vvjlMoeW7z2i2mednZZmhMCONhp2VWVcn87P3BTRg2m
   caV2ENKKWHY9xmT7lYzRKOhpkjKIJcxS7pHe4g7UHPJABLKThr/jwPASo
   A==;
X-CSE-ConnectionGUID: JQxrIMjWRK+Fvh0QZVg52w==
X-CSE-MsgGUID: KNq7T46OT5CZX4eL59hLIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109727077"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="109727077"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:05:24 -0700
X-CSE-ConnectionGUID: jdRc+tlKSvyfmucQHCu8ow==
X-CSE-MsgGUID: 5ZRcRHqsTPGFAvBusMuFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258165398"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.169])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:05:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Jul 2026 17:05:18 +0300 (EEST)
To: Eric Auger <eauger@redhat.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional
 sizes
In-Reply-To: <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
Message-ID: <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com> <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com> <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com>
 <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-501839824-1783516694=:1682"
Content-ID: <cfd0d777-01dd-6b6e-bd2c-bd76e99e6ef6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-501839824-1783516694=:1682
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <243e9142-5b7c-bfa6-4cea-4fd1da4d38a9@linux.intel.com>

On Wed, 8 Jul 2026, Eric Auger wrote:
> On 7/7/26 6:12 PM, Ilpo J=E4rvinen wrote:
> > On Tue, 7 Jul 2026, Eric Auger wrote:
> >=20
> >> Hi Ilpo,
> >>
> >> On 12/19/25 6:40 PM, Ilpo J=E4rvinen wrote:
> >>> The resource loop in pbus_size_mem() handles optional resources that
> >>> are either fully optional (SRIOV and disabled Expansion ROMs) or brid=
ge
> >>> windows that may be optional only for a part. The logic is little
> >>> inconsistent when it comes to a bridge window that has only optional
> >>> children resources as it would be more natural to treat it similar to
> >>> any fully optional resource. As resource size should be zero in that
> >>> case, it shouldn't cause any bugs but it still seems useful to addres=
s
> >>> the inconsistency.
> >>>
> >>> Place the optional size related code of pbus_size_mem() into
> >>> pbus_mem_size_optional() and add check into pci_resource_is_optional(=
)
> >>> for entirely optional bridge windows. Reorder the logic inside
> >>> pbus_mem_size_optional() such that fully optional resources are handl=
ed
> >>> the same irrespective to whether the resource is a bridge window or
> >>> not.
> >>
> >> This patch seems to introduce a regression when trying to hotplug a
> >> virtio-net-pci device behind a XIO3130 downstream port in the followin=
g
> >> hierarchy.
> >>
> >> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu=
 vmm.
> >>
> >>
> >>
> >> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> >> =09Subsystem: Red Hat, Inc. Device 1100
> >>
> >> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> >>    Subsystem: Red Hat, Inc. Device 0000
> >>    Kernel driver in use: pcieport
> >>
> >>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
> >>
> >> =09(Upstream) (rev 02)
> >> =09Kernel driver in use: pcieport
> >>
> >> =09|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
> >> =09=09Switch (Downstream) (rev 01)
> >> =09=09Kernel driver in use: pcieport
> >=20
> > Hi Eric,
> >=20
> > Thanks for the report.
> >=20
> > I cannot get much done with the log snippets. The first line with=20
> > difference is a symptom of something that originates from outside of th=
e=20
> > snippet.
> >=20
> > Could you please take a log with dyndbg=3D"file drivers/pci/*.c +p" on =
the=20
> > kernel command line and also include a /proc/iomem dump. Like=20
> > you did now, preferrably take those from both working and failing case =
so=20
> > I can easily diff them.
> >=20
> > --
> >  i.
> >=20
> >=20
> >> This produces the following trace
> >>
> >>
> >> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
> >> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PC=
Ie
> >> Endpoint
> >> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bi=
t
> >> pref]
> >> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
> >> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: can't assign; no space
> >> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: failed to assign
> >> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: can't assign; no space
> >> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: failed to assign
> >> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000]: can't assign; no space
> >> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000]: failed to assign
> >> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref]: can't assign; no space
> >> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref]: failed to assign
> >> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> can't assign; no space
> >> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> failed to assign
> >> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >> assign; no space
> >> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed t=
o
> >> assign
> >> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> can't assign; no space
> >> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> failed to assign
> >> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >> assign; no space
> >> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed t=
o
> >> assign
> >> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >> [   29.611260] PCI: No. 2 try to assign unassigned res
> >> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: can't assign; no space
> >> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: failed to assign
> >> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: can't assign; no space
> >> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: failed to assign
> >> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000]: can't assign; no space
> >> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000]: failed to assign
> >> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref]: can't assign; no space
> >> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref]: failed to assign
> >> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> can't assign; no space
> >> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> failed to assign
> >> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >> assign; no space
> >> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed t=
o
> >> assign
> >> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> can't assign; no space
> >> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref=
]:
> >> failed to assign
> >> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >> assign; no space
> >> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed t=
o
> >> assign
> >> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
> >> driver
> >>
> >> Previous to this commit hotplug was successful:
> >>
> >> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
> >> Slot(0-1): Button press: will power on in 5 sec
> >> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
> >> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PC=
Ie
> >> Endpoint
> >> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bi=
t
> >> pref]
> >> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
> >> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x001000=
00
> >> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: can't assign; no space
> >> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
> >> 0x00200000]: failed to assign
> >> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: can't assign; no space
> >> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x002000=
00
> >> 64bit pref]: failed to assign
> >> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10a00000-0x10afffff]: assigned
> >> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10b00000-0x10bfffff 64bit pref]: assigned
> >> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10a00000-0x10afffff]: failed to expand by 0x100000
> >> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10a00000-0x10afffff]: failed to add optional 100000
> >> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
> >> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
> >> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
> >> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bi=
t
> >> pref]: assigned
> >> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: as=
signed
> >> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
> >> 0x10a00000-0x10afffff]
> >> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
> >> 0x10b00000-0x10bfffff 64bit pref]
> >> [   39.559629] PCI: No. 2 try to assign unassigned res
> >> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> can't assign; no space
> >> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> >> failed to assign
> >> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
> >> 0x10a00000-0x10afffff]
> >> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
> >> 0x10b00000-0x10bfffff 64bit pref]
> >> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
> >> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
> >>
> >> Any clue?
> >>
> >> Thank you in advance
> >>
> >> Eric
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>>
> >>> Additional motivation for this are the upcoming changes that add
> >>> complexity to the optional sizing logic due to Resizable BAR awarenes=
s.
> >>> The extra logic would exceed any reasonable indentation level if the
> >>> optional sizing code is kept within the loop body.
> >>>
> >>> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> >>> ---
> >>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++----------=
--
> >>>  1 file changed, 54 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >>> index 3d1d3cefcdba..3fcc7641c374 100644
> >>> --- a/drivers/pci/setup-bus.c
> >>> +++ b/drivers/pci/setup-bus.c
> >>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct l=
ist_head *head,
> >>>  =09return dev_res ? dev_res->add_size : 0;
> >>>  }
> >>> =20
> >>> -static resource_size_t get_res_add_align(struct list_head *head,
> >>> -=09=09=09=09=09 struct resource *res)
> >>> -{
> >>> -=09struct pci_dev_resource *dev_res;
> >>> -
> >>> -=09dev_res =3D res_to_dev_res(head, res);
> >>> -=09return dev_res ? dev_res->min_align : 0;
> >>> -}
> >>> -
> >>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
> >>>  {
> >>>  =09struct resource *res =3D dev_res->res;
> >>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_de=
v *dev, int resno)
> >>>  =09=09return true;
> >>>  =09if (resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_RO=
M_ENABLE))
> >>>  =09=09return true;
> >>> +=09if (pci_resource_is_bridge_win(resno) && !resource_size(res))
> adding
>=20
> && !dev->is_hotplug_bridge makes the hotplug successful.
>=20
>=20
> My understanding is that otherwise the hotplug bridge window is
> considered as optional and no memoy window is allocated to assign chid
> device's BARS
>=20
> Please let me know if that makes sense. In the positive I can send a patc=
h.

I don't think that is the correct solution.


These bridges, have both non-prefetchable and prefetchable windows, but=20
the initial setup only sets the non-prefetchable one to 2M (and nothing=20
more would fit to the associated root bus resource). There's only a single=
=20
root bus resource that is 2M + a bit more (to fit that BAR0).

Now, when sizing the bridge windows, the kernel sizing algorithm just uses=
=20
the default 2M hotplug reservation to both of those windows as there are=20
not yet any real devices underneath (the default hp reservation is=20
controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline parameters).=
=20
Thus, to fit everything, the root bus resource should be 4M + a bit more=20
for BAR0.

However, it looks to me there's also a 4M add_size miscalculation (the=20
downstream bridge window is only 2M per each type):

[    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
[    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] =
to [bus 0b-0d] add_size 400000 add_align 100000

It's almost as if both of the child windows would be summed into it, not=20
just the one with the correct type. Maybe this is caused by the=20
pci_is_root_bus() thing in pbus_select_window_for_type() (which I don't=20
like but cannot currently really get rid of either) and=20
find_bus_resource_of_type() messing things up.

There's an attempt in the patch below to address that problem.


But, even if the sizing would calculate 2M there, 2M + 2M windows are not=
=20
going to fit. This works what looks like by chance in the older kernel,=20
which (illogically) picks 1M required size for the both window (probably=20
that comes from min alignment) which magically just happens to fit to the=
=20
~2M root bus resource.

So to solve that issue, you could try with hpmemsize=3D1M on the kernel's=
=20
cmndline to see if it elimnates those failures together with the patch=20
below.

Why the system setup doesn't create large enough root bus resource for it=
=20
is way beyond my qemu and/or aarch64 knowledge and it seems to be where=20
the problem kind of originates from.


--
[PATCH 1/1] PCI: Fix mem resource type matching

pbus_select_window_for_type() handles root bus differently by calling
find_bus_resource_of_type() with different sets of flags to handle
memory window type fallbacks.

The first case is intended to match only exactly, but if type is
IORESOURCE_MEM, the check in find_bus_resource_of_type() will not
include IORESOURCE_MEM_64 in the mask. As a result, wrong resource
may be selected even if a more precise match is available.

Similarly for the other case with IORESOURCE_PREFETCH.

Separate mask handling from the type of the particular resource to
ensure the matching progresses from finer-grained matches towards more
allowing matches.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..912a30211505 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -209,17 +209,21 @@ static struct resource *pbus_select_window_for_type(s=
truct pci_bus *bus,
 =09=09return NULL;
=20
 =09if (pci_is_root_bus(bus)) {
-=09=09win =3D find_bus_resource_of_type(bus, type, type);
+=09=09unsigned long mask =3D PCI_RES_TYPE_MASK;
+
+=09=09win =3D find_bus_resource_of_type(bus, mask, type);
 =09=09if (win)
 =09=09=09return win;
=20
 =09=09type &=3D ~IORESOURCE_MEM_64;
-=09=09win =3D find_bus_resource_of_type(bus, type, type);
+=09=09mask &=3D ~IORESOURCE_MEM_64;
+=09=09win =3D find_bus_resource_of_type(bus, mask, type);
 =09=09if (win)
 =09=09=09return win;
=20
 =09=09type &=3D ~IORESOURCE_PREFETCH;
-=09=09return find_bus_resource_of_type(bus, type, type);
+=09=09mask &=3D ~IORESOURCE_PREFETCH;
+=09=09return find_bus_resource_of_type(bus, mask, type);
 =09}
=20
 =09switch (iores_type) {

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.47.3

--8323328-501839824-1783516694=:1682--
