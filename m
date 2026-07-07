Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338B370AC2;
	Tue,  7 Jul 2026 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440776; cv=none; b=Vab5FWUQKnemiXBpfoloSaE+maWQj0ng8j1hIRzJTATLVFi/r1zREvJRe8G6YO17vJKOlziqj2/2MTkg65Om2jaCwAgBvsYGXEbWMTF2Jdos/AB7lU8m/uoOJUVRvoeYeV7WfNi9sEFk5Xs6bho4hw9VLKrpjnkoChFlOVy+X70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440776; c=relaxed/simple;
	bh=rCI5T1lg6K8gQzyWs+CH5Ewd4sdfjDSdVIXMTKYrJkI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iRTG0wDXu4efnL6FBv5lJB1nvU/h01EKb6BPjwCCM0SJyGrHNTDqFYDrqxVyZEJwnXOHtfjIKp5YYJRY4NpBLNaxBWQWQr1XTU4R3FCpV5/Wk8LpqrxAQVno/hxJiY0P6zoW7abnAurqA7VY9OTDVgJenQjixCMokjFZbajoxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFSBidyj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFSBidyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783440773; x=1814976773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rCI5T1lg6K8gQzyWs+CH5Ewd4sdfjDSdVIXMTKYrJkI=;
  b=OFSBidyjeIKj4apjNREU1sz4ewAR5QPFLN4LVpSxp6BxQy9kuCjBIiT1
   qHI31vnpEQcCRNB7CkIVXUq7KrhE5CYqYM7xxpc0sBbO9Zc0ldcBaHZLS
   A4a5HuJz6XhvwxTsdWsDOZHVYr8S/8qDnNxpRi1rxoPFdA7+/lWq1lsLA
   pfD9ACX0YeEil15LDKG9FB/AozwotvM/8HfPeXsXffnHq9aDpEn6+x3fV
   CRpF4obEDixZ1ofYXy3rlRyZGdsMMhsWktpp45CJQDkEpcEEraS0V98wn
   auVmW4wzAVE9EtH0dWex6OQiYOgheHr/JIfLIJuuG2WdpWTg1TRj83yxM
   Q==;
X-CSE-ConnectionGUID: Vw0jTN38S2GF61ehcRwVQA==
X-CSE-MsgGUID: f+WEHSP2TpOecvcaeQQKrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="101639098"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="101639098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:12:52 -0700
X-CSE-ConnectionGUID: uSHjhmkhSa2jthoz+uOf1g==
X-CSE-MsgGUID: uLODKJN6Seyvs6Inggb2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249602157"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.226])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 09:12:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Jul 2026 19:12:47 +0300 (EEST)
To: Eric Auger <eauger@redhat.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional
 sizes
In-Reply-To: <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com>
Message-ID: <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com> <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1607474657-1783440767=:1152"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1607474657-1783440767=:1152
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Jul 2026, Eric Auger wrote:

> Hi Ilpo,
>=20
> On 12/19/25 6:40 PM, Ilpo J=C3=A4rvinen wrote:
> > The resource loop in pbus_size_mem() handles optional resources that
> > are either fully optional (SRIOV and disabled Expansion ROMs) or bridge
> > windows that may be optional only for a part. The logic is little
> > inconsistent when it comes to a bridge window that has only optional
> > children resources as it would be more natural to treat it similar to
> > any fully optional resource. As resource size should be zero in that
> > case, it shouldn't cause any bugs but it still seems useful to address
> > the inconsistency.
> >=20
> > Place the optional size related code of pbus_size_mem() into
> > pbus_mem_size_optional() and add check into pci_resource_is_optional()
> > for entirely optional bridge windows. Reorder the logic inside
> > pbus_mem_size_optional() such that fully optional resources are handled
> > the same irrespective to whether the resource is a bridge window or
> > not.
>=20
> This patch seems to introduce a regression when trying to hotplug a
> virtio-net-pci device behind a XIO3130 downstream port in the following
> hierarchy.
>=20
> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qemu vm=
m.
>=20
>=20
>=20
> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> =09Subsystem: Red Hat, Inc. Device 1100
>=20
> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
>    Subsystem: Red Hat, Inc. Device 0000
>    Kernel driver in use: pcieport
>=20
>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Switch
>=20
> =09(Upstream) (rev 02)
> =09Kernel driver in use: pcieport
>=20
> =09|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
> =09=09Switch (Downstream) (rev 01)
> =09=09Kernel driver in use: pcieport

Hi Eric,

Thanks for the report.

I cannot get much done with the log snippets. The first line with=20
difference is a symptom of something that originates from outside of the=20
snippet.

Could you please take a log with dyndbg=3D"file drivers/pci/*.c +p" on the=
=20
kernel command line and also include a /proc/iomem dump. Like=20
you did now, preferrably take those from both working and failing case so=
=20
I can easily diff them.

--
 i.


> This produces the following trace
>=20
>=20
> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
> Endpoint
> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
> pref]
> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: can't assign; no space
> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: failed to assign
> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: can't assign; no space
> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: failed to assign
> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000]: can't assign; no space
> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000]: failed to assign
> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref]: can't assign; no space
> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref]: failed to assign
> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> can't assign; no space
> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> failed to assign
> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> assign; no space
> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
> assign
> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> can't assign; no space
> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> failed to assign
> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> assign; no space
> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
> assign
> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> [   29.611260] PCI: No. 2 try to assign unassigned res
> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: can't assign; no space
> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: failed to assign
> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: can't assign; no space
> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: failed to assign
> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000]: can't assign; no space
> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000]: failed to assign
> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref]: can't assign; no space
> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref]: failed to assign
> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> can't assign; no space
> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> failed to assign
> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> assign; no space
> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
> assign
> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> can't assign; no space
> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pref]:
> failed to assign
> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> assign; no space
> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed to
> assign
> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for legacy
> driver
>=20
> Previous to this commit hotplug was successful:
>=20
> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
> Slot(0-1): Button press: will power on in 5 sec
> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card present
> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 PCIe
> Endpoint
> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64bit
> pref]
> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00100000
> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: can't assign; no space
> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
> 0x00200000]: failed to assign
> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: can't assign; no space
> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00200000
> 64bit pref]: failed to assign
> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
> 0x10a00000-0x10afffff]: assigned
> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
> 0x10b00000-0x10bfffff 64bit pref]: assigned
> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
> 0x10a00000-0x10afffff]: failed to expand by 0x100000
> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
> 0x10a00000-0x10afffff]: failed to add optional 100000
> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64bit
> pref]: assigned
> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: assig=
ned
> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
> 0x10a00000-0x10afffff]
> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
> 0x10b00000-0x10bfffff 64bit pref]
> [   39.559629] PCI: No. 2 try to assign unassigned res
> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> can't assign; no space
> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000]:
> failed to assign
> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
> 0x10a00000-0x10afffff]
> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
> 0x10b00000-0x10bfffff 64bit pref]
> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0002)
> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
>=20
> Any clue?
>=20
> Thank you in advance
>=20
> Eric
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> >=20
> > Additional motivation for this are the upcoming changes that add
> > complexity to the optional sizing logic due to Resizable BAR awareness.
> > The extra logic would exceed any reasonable indentation level if the
> > optional sizing code is kept within the loop body.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------------
> >  1 file changed, 54 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 3d1d3cefcdba..3fcc7641c374 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct lis=
t_head *head,
> >  =09return dev_res ? dev_res->add_size : 0;
> >  }
> > =20
> > -static resource_size_t get_res_add_align(struct list_head *head,
> > -=09=09=09=09=09 struct resource *res)
> > -{
> > -=09struct pci_dev_resource *dev_res;
> > -
> > -=09dev_res =3D res_to_dev_res(head, res);
> > -=09return dev_res ? dev_res->min_align : 0;
> > -}
> > -
> >  static void restore_dev_resource(struct pci_dev_resource *dev_res)
> >  {
> >  =09struct resource *res =3D dev_res->res;
> > @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_dev =
*dev, int resno)
> >  =09=09return true;
> >  =09if (resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_ROM_=
ENABLE))
> >  =09=09return true;
> > +=09if (pci_resource_is_bridge_win(resno) && !resource_size(res))
> > +=09=09return true;
> > =20
> >  =09return false;
> >  }
> > @@ -1258,6 +1251,54 @@ static resource_size_t calculate_head_align(reso=
urce_size_t *aligns,
> >  =09return head_align;
> >  }
> > =20
> > +/*
> > + * pbus_size_mem_optional - Account optional resources in bridge windo=
w
> > + *
> > + * Account an optional resource or the optional part of the resource i=
n bridge
> > + * window size.
> > + *
> > + * Return: %true if the resource is entirely optional.
> > + */
> > +static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
> > +=09=09=09=09   resource_size_t align,
> > +=09=09=09=09   struct list_head *realloc_head,
> > +=09=09=09=09   resource_size_t *add_align,
> > +=09=09=09=09   resource_size_t *children_add_size)
> > +{
> > +=09struct resource *res =3D pci_resource_n(dev, resno);
> > +=09bool optional =3D pci_resource_is_optional(dev, resno);
> > +=09resource_size_t r_size =3D resource_size(res);
> > +=09struct pci_dev_resource *dev_res;
> > +
> > +=09if (!realloc_head)
> > +=09=09return false;
> > +
> > +=09if (!optional) {
> > +=09=09/*
> > +=09=09 * Only bridges have optional sizes in realloc_head at this
> > +=09=09 * point. As res_to_dev_res() walks the entire realloc_head
> > +=09=09 * list, skip calling it when known unnecessary.
> > +=09=09 */
> > +=09=09if (!pci_resource_is_bridge_win(resno))
> > +=09=09=09return false;
> > +
> > +=09=09dev_res =3D res_to_dev_res(realloc_head, res);
> > +=09=09if (dev_res) {
> > +=09=09=09*children_add_size +=3D dev_res->add_size;
> > +=09=09=09*add_align =3D max(*add_align, dev_res->min_align);
> > +=09=09}
> > +
> > +=09=09return false;
> > +=09}
> > +
> > +=09/* Put SRIOV requested res to the optional list */
> > +=09add_to_list(realloc_head, dev, res, 0, align);
> > +=09*children_add_size +=3D r_size;
> > +=09*add_align =3D max(align, *add_align);
> > +
> > +=09return true;
> > +}
> > +
> >  /**
> >   * pbus_size_mem() - Size the memory window of a given bus
> >   *
> > @@ -1284,7 +1325,6 @@ static void pbus_size_mem(struct pci_bus *bus, st=
ruct resource *b_res,
> >  =09resource_size_t aligns[28] =3D {}; /* Alignments from 1MB to 128TB =
*/
> >  =09int order, max_order;
> >  =09resource_size_t children_add_size =3D 0;
> > -=09resource_size_t children_add_align =3D 0;
> >  =09resource_size_t add_align =3D 0;
> > =20
> >  =09if (!b_res)
> > @@ -1311,7 +1351,6 @@ static void pbus_size_mem(struct pci_bus *bus, st=
ruct resource *b_res,
> >  =09=09=09if (b_res !=3D pbus_select_window(bus, r))
> >  =09=09=09=09continue;
> > =20
> > -=09=09=09r_size =3D resource_size(r);
> >  =09=09=09align =3D pci_resource_alignment(dev, r);
> >  =09=09=09/*
> >  =09=09=09 * aligns[0] is for 1MB (since bridge memory
> > @@ -1327,25 +1366,17 @@ static void pbus_size_mem(struct pci_bus *bus, =
struct resource *b_res,
> >  =09=09=09=09continue;
> >  =09=09=09}
> > =20
> > -=09=09=09/* Put SRIOV requested res to the optional list */
> > -=09=09=09if (realloc_head && pci_resource_is_optional(dev, i)) {
> > -=09=09=09=09add_align =3D max(align, add_align);
> > -=09=09=09=09add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
> > -=09=09=09=09children_add_size +=3D r_size;
> > +=09=09=09if (pbus_size_mem_optional(dev, i, align,
> > +=09=09=09=09=09=09   realloc_head, &add_align,
> > +=09=09=09=09=09=09   &children_add_size))
> >  =09=09=09=09continue;
> > -=09=09=09}
> > =20
> > +=09=09=09r_size =3D resource_size(r);
> >  =09=09=09size +=3D max(r_size, align);
> > =20
> >  =09=09=09aligns[order] +=3D align;
> >  =09=09=09if (order > max_order)
> >  =09=09=09=09max_order =3D order;
> > -
> > -=09=09=09if (realloc_head) {
> > -=09=09=09=09children_add_size +=3D get_res_add_size(realloc_head, r);
> > -=09=09=09=09children_add_align =3D get_res_add_align(realloc_head, r);
> > -=09=09=09=09add_align =3D max(add_align, children_add_align);
> > -=09=09=09}
> >  =09=09}
> >  =09}
> > =20
>=20
>=20

--=20
 i.

--8323328-1607474657-1783440767=:1152--
