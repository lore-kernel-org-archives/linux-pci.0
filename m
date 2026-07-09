Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9C3FE65D;
	Thu,  9 Jul 2026 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587864; cv=none; b=AIEd+eDZpKGZituoW210TpuJk2QeLJxekSXG4Dk4aUZVDdQXY49PQNZ6/tnHjP1e+bDLI0LjsTJLeiZuqCr+P/iZA2T60DuQMyW/Ob4SeeiaOXV48cGAohLQ0BOhR9q/fzIjNoDmQYupgopp/SKUAwyXZ9kQZAZnLHWHxHYA6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587864; c=relaxed/simple;
	bh=+s9G4L8GOq7nuh9DAyW2suIfyaVtSElsEIJ1v5WY2q4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uH88l5VQSV1HNsOv2Q4Wu8H6hQnjjJLQ7QYbPNzRQLJk/wWHEnndipUwgFAQ/MZWDnZoc8j4wRquUXoBwyO621yCutGWP4zSgRQ3xu8UacHns8MSW6XA+yOjA7PXReH89+SjLJmDOHfwsTJXSZyPQDFju07M9/En0YmHDfedE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhgPdYCy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhgPdYCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783587863; x=1815123863;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+s9G4L8GOq7nuh9DAyW2suIfyaVtSElsEIJ1v5WY2q4=;
  b=mhgPdYCylNhhSLHBAZIAQuDN3UdZ2B4oSchI5fjCLmTbR6zLfhduEt8+
   G3OHwgKf4EnnFERFMtoW+pRfGDqYh+ecOLj0Lm3YslNatWNiYtUTSG/v7
   qqn3hDFKmEymO3qlj68kyiRmcrEXLCxYvwWubKBQY/VT7pxO8hcxX95zW
   sXZh94Qx8dILc4IPb0vOcs7UdnjcNpCpUu3uJ2wfzH+PNnkxOE34QmeWx
   HKWdbekgFAo4aXCHPFtjj1d//FaTO9+N6U5HFBrL6W/2PS18rmKvlvw4J
   n/E+0/apwjnXTOfqjU5JvWBAZe9+x7nvjjOYSihnx56/ytMoh9z4GxVoC
   g==;
X-CSE-ConnectionGUID: Fwh864JUTUeJ8tcHOHwDhw==
X-CSE-MsgGUID: EQ8+O2iRT8ui8VPeUQsqTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84281696"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84281696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:04:22 -0700
X-CSE-ConnectionGUID: ym8NmuWoQ4CHYPcvwHbQsA==
X-CSE-MsgGUID: s5CZyK3UTXS63KDXn2Oe5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="284637086"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 02:04:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Jul 2026 12:04:14 +0300 (EEST)
To: Eric Auger <eauger@redhat.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional
 sizes
In-Reply-To: <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com>
Message-ID: <ef311b13-565b-aa2e-2f35-a94bc53d975a@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com> <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com> <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com> <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
 <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com> <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-308014175-1783587854=:1261"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-308014175-1783587854=:1261
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Jul 2026, Eric Auger wrote:
> On 7/8/26 4:05 PM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 8 Jul 2026, Eric Auger wrote:
> >> On 7/7/26 6:12 PM, Ilpo J=C3=A4rvinen wrote:
> >>> On Tue, 7 Jul 2026, Eric Auger wrote:
> >>>
> >>>> Hi Ilpo,
> >>>>
> >>>> On 12/19/25 6:40 PM, Ilpo J=C3=A4rvinen wrote:
> >>>>> The resource loop in pbus_size_mem() handles optional resources tha=
t
> >>>>> are either fully optional (SRIOV and disabled Expansion ROMs) or br=
idge
> >>>>> windows that may be optional only for a part. The logic is little
> >>>>> inconsistent when it comes to a bridge window that has only optiona=
l
> >>>>> children resources as it would be more natural to treat it similar =
to
> >>>>> any fully optional resource. As resource size should be zero in tha=
t
> >>>>> case, it shouldn't cause any bugs but it still seems useful to addr=
ess
> >>>>> the inconsistency.
> >>>>>
> >>>>> Place the optional size related code of pbus_size_mem() into
> >>>>> pbus_mem_size_optional() and add check into pci_resource_is_optiona=
l()
> >>>>> for entirely optional bridge windows. Reorder the logic inside
> >>>>> pbus_mem_size_optional() such that fully optional resources are han=
dled
> >>>>> the same irrespective to whether the resource is a bridge window or
> >>>>> not.
> >>>>
> >>>> This patch seems to introduce a regression when trying to hotplug a
> >>>> virtio-net-pci device behind a XIO3130 downstream port in the follow=
ing
> >>>> hierarchy.
> >>>>
> >>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with qe=
mu vmm.
> >>>>
> >>>>
> >>>>
> >>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> >>>> =09Subsystem: Red Hat, Inc. Device 1100
> >>>>
> >>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> >>>>    Subsystem: Red Hat, Inc. Device 0000
> >>>>    Kernel driver in use: pcieport
> >>>>
> >>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Swit=
ch
> >>>>
> >>>> =09(Upstream) (rev 02)
> >>>> =09Kernel driver in use: pcieport
> >>>>
> >>>> =09|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
> >>>> =09=09Switch (Downstream) (rev 01)
> >>>> =09=09Kernel driver in use: pcieport
> >>>
> >>> Hi Eric,
> >>>
> >>> Thanks for the report.
> >>>
> >>> I cannot get much done with the log snippets. The first line with=20
> >>> difference is a symptom of something that originates from outside of =
the=20
> >>> snippet.
> >>>
> >>> Could you please take a log with dyndbg=3D"file drivers/pci/*.c +p" o=
n the=20
> >>> kernel command line and also include a /proc/iomem dump. Like=20
> >>> you did now, preferrably take those from both working and failing cas=
e so=20
> >>> I can easily diff them.
> >>>
> >>> --
> >>>  i.
> >>>
> >>>
> >>>> This produces the following trace
> >>>>
> >>>>
> >>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card presen=
t
> >>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 =
PCIe
> >>>> Endpoint
> >>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64=
bit
> >>>> pref]
> >>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
> >>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: can't assign; no space
> >>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: failed to assign
> >>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: can't assign; no space
> >>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: failed to assign
> >>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000]: can't assign; no space
> >>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000]: failed to assign
> >>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref]: can't assign; no space
> >>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref]: failed to assign
> >>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> can't assign; no space
> >>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> failed to assign
> >>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >>>> assign; no space
> >>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed=
 to
> >>>> assign
> >>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> can't assign; no space
> >>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> failed to assign
> >>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >>>> assign; no space
> >>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed=
 to
> >>>> assign
> >>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>> [   29.611260] PCI: No. 2 try to assign unassigned res
> >>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: can't assign; no space
> >>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: failed to assign
> >>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: can't assign; no space
> >>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: failed to assign
> >>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000]: can't assign; no space
> >>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000]: failed to assign
> >>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref]: can't assign; no space
> >>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref]: failed to assign
> >>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> can't assign; no space
> >>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> failed to assign
> >>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >>>> assign; no space
> >>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed=
 to
> >>>> assign
> >>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> can't assign; no space
> >>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit pr=
ef]:
> >>>> failed to assign
> >>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can't
> >>>> assign; no space
> >>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: failed=
 to
> >>>> assign
> >>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for lega=
cy
> >>>> driver
> >>>>
> >>>> Previous to this commit hotplug was successful:
> >>>>
> >>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
> >>>> Slot(0-1): Button press: will power on in 5 sec
> >>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card presen=
t
> >>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020000 =
PCIe
> >>>> Endpoint
> >>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff 64=
bit
> >>>> pref]
> >>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
> >>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x0010=
0000
> >>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: can't assign; no space
> >>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
> >>>> 0x00200000]: failed to assign
> >>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: can't assign; no space
> >>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x0020=
0000
> >>>> 64bit pref]: failed to assign
> >>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10a00000-0x10afffff]: assigned
> >>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
> >>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
> >>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10a00000-0x10afffff]: failed to add optional 100000
> >>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
> >>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
> >>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
> >>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff 64=
bit
> >>>> pref]: assigned
> >>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]: =
assigned
> >>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
> >>>> 0x10a00000-0x10afffff]
> >>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
> >>>> 0x10b00000-0x10bfffff 64bit pref]
> >>>> [   39.559629] PCI: No. 2 try to assign unassigned res
> >>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> can't assign; no space
> >>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x1000=
]:
> >>>> failed to assign
> >>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
> >>>> 0x10a00000-0x10afffff]
> >>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
> >>>> 0x10b00000-0x10bfffff 64bit pref]
> >>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 000=
2)
> >>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
> >>>>
> >>>> Any clue?
> >>>>
> >>>> Thank you in advance
> >>>>
> >>>> Eric
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> Additional motivation for this are the upcoming changes that add
> >>>>> complexity to the optional sizing logic due to Resizable BAR awaren=
ess.
> >>>>> The extra logic would exceed any reasonable indentation level if th=
e
> >>>>> optional sizing code is kept within the loop body.
> >>>>>
> >>>>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >>>>> ---
> >>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++--------=
----
> >>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >>>>> index 3d1d3cefcdba..3fcc7641c374 100644
> >>>>> --- a/drivers/pci/setup-bus.c
> >>>>> +++ b/drivers/pci/setup-bus.c
> >>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(struct=
 list_head *head,
> >>>>>  =09return dev_res ? dev_res->add_size : 0;
> >>>>>  }
> >>>>> =20
> >>>>> -static resource_size_t get_res_add_align(struct list_head *head,
> >>>>> -=09=09=09=09=09 struct resource *res)
> >>>>> -{
> >>>>> -=09struct pci_dev_resource *dev_res;
> >>>>> -
> >>>>> -=09dev_res =3D res_to_dev_res(head, res);
> >>>>> -=09return dev_res ? dev_res->min_align : 0;
> >>>>> -}
> >>>>> -
> >>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_res)
> >>>>>  {
> >>>>>  =09struct resource *res =3D dev_res->res;
> >>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pci_=
dev *dev, int resno)
> >>>>>  =09=09return true;
> >>>>>  =09if (resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOURCE_=
ROM_ENABLE))
> >>>>>  =09=09return true;
> >>>>> +=09if (pci_resource_is_bridge_win(resno) && !resource_size(res))
> >> adding
> >>
> >> && !dev->is_hotplug_bridge makes the hotplug successful.
> >>
> >>
> >> My understanding is that otherwise the hotplug bridge window is
> >> considered as optional and no memoy window is allocated to assign chid
> >> device's BARS
> >>
> >> Please let me know if that makes sense. In the positive I can send a p=
atch.
> >=20
> > I don't think that is the correct solution.
> >=20
> >=20
> > These bridges, have both non-prefetchable and prefetchable windows, but=
=20
> > the initial setup only sets the non-prefetchable one to 2M (and nothing=
=20
> > more would fit to the associated root bus resource). There's only a sin=
gle=20
> > root bus resource that is 2M + a bit more (to fit that BAR0).
> >=20
> > Now, when sizing the bridge windows, the kernel sizing algorithm just u=
ses=20
> > the default 2M hotplug reservation to both of those windows as there ar=
e=20
> > not yet any real devices underneath (the default hp reservation is=20
> > controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline parameter=
s).=20
> > Thus, to fit everything, the root bus resource should be 4M + a bit mor=
e=20
> > for BAR0.
> >=20
> > However, it looks to me there's also a 4M add_size miscalculation (the=
=20
> > downstream bridge window is only 2M per each type):
> >=20
> > [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fff=
ff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
> > [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fff=
ff] to [bus 0b-0d] add_size 400000 add_align 100000
>=20
> Hum even with the patch below I still get:
>=20
> [    0.047253] pci 0000:0a:00.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
> add_align 100000
> [    0.047254] pci 0000:0a:00.0: bridge window [mem
> 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000

Okay, I'll then have to do a debug patch to know what the loop adds into=20
it. I'll try to get it done today.

Thanks anyway for testing.

--=20
 i.

> > It's almost as if both of the child windows would be summed into it, no=
t=20
> > just the one with the correct type. Maybe this is caused by the=20
> > pci_is_root_bus() thing in pbus_select_window_for_type() (which I don't=
=20
> > like but cannot currently really get rid of either) and=20
> > find_bus_resource_of_type() messing things up.
> >=20
> > There's an attempt in the patch below to address that problem.
> >=20
> >=20
> > But, even if the sizing would calculate 2M there, 2M + 2M windows are n=
ot=20
> > going to fit. This works what looks like by chance in the older kernel,=
=20
> > which (illogically) picks 1M required size for the both window (probabl=
y=20
> > that comes from min alignment) which magically just happens to fit to t=
he=20
> > ~2M root bus resource.
> >=20
> > So to solve that issue, you could try with hpmemsize=3D1M on the kernel=
's=20
> > cmndline to see if it elimnates those failures together with the patch=
=20
> > below.
> Unfortunately it doens't (combination of this fix + hpmemsize=3D1M)
> >=20
> > Why the system setup doesn't create large enough root bus resource for =
it=20
> > is way beyond my qemu and/or aarch64 knowledge and it seems to be where=
=20
> > the problem kind of originates from.
>=20
> OK I need more time to investigate. I will come back to you.
>=20
> Thanks
>=20
> Eric
> >=20
> >=20
> > --
> > [PATCH 1/1] PCI: Fix mem resource type matching
> >=20
> > pbus_select_window_for_type() handles root bus differently by calling
> > find_bus_resource_of_type() with different sets of flags to handle
> > memory window type fallbacks.
> >=20
> > The first case is intended to match only exactly, but if type is
> > IORESOURCE_MEM, the check in find_bus_resource_of_type() will not
> > include IORESOURCE_MEM_64 in the mask. As a result, wrong resource
> > may be selected even if a more precise match is available.
> >=20
> > Similarly for the other case with IORESOURCE_PREFETCH.
> >=20
> > Separate mask handling from the type of the particular resource to
> > ensure the matching progresses from finer-grained matches towards more
> > allowing matches.
> >=20
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index c0a949f2c995..912a30211505 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -209,17 +209,21 @@ static struct resource *pbus_select_window_for_ty=
pe(struct pci_bus *bus,
> >  =09=09return NULL;
> > =20
> >  =09if (pci_is_root_bus(bus)) {
> > -=09=09win =3D find_bus_resource_of_type(bus, type, type);
> > +=09=09unsigned long mask =3D PCI_RES_TYPE_MASK;
> > +
> > +=09=09win =3D find_bus_resource_of_type(bus, mask, type);
> >  =09=09if (win)
> >  =09=09=09return win;
> > =20
> >  =09=09type &=3D ~IORESOURCE_MEM_64;
> > -=09=09win =3D find_bus_resource_of_type(bus, type, type);
> > +=09=09mask &=3D ~IORESOURCE_MEM_64;
> > +=09=09win =3D find_bus_resource_of_type(bus, mask, type);
> >  =09=09if (win)
> >  =09=09=09return win;
> > =20
> >  =09=09type &=3D ~IORESOURCE_PREFETCH;
> > -=09=09return find_bus_resource_of_type(bus, type, type);
> > +=09=09mask &=3D ~IORESOURCE_PREFETCH;
> > +=09=09return find_bus_resource_of_type(bus, mask, type);
> >  =09}
> > =20
> >  =09switch (iores_type) {
> >=20
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
>=20
--8323328-308014175-1783587854=:1261--
