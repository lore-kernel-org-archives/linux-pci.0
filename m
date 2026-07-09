Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB433B6D0;
	Thu,  9 Jul 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608616; cv=none; b=IXP1Hv2XI9ZiVG2TddT8JdEPQmrvdZEZIUanNYCAHIMUOG1+9wRgbELUN951G7XTlaEkDvIZvaNHQu8GyROPRGfAjN3KLGAR9TvHXA9yxPb+jPx2+cOMpsJVIuOI5nbABbOs/Zp2zy7ifqczd/cjzwTN3Dc89a4kwMb+vbaCR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608616; c=relaxed/simple;
	bh=Pg9xOQ1LWbf+sW6pfCeaqSoVfGMokJv6hSIQBwkQVcI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fqs/nDHvGiymlCM5UCvcz+Yff0SjmwNSQNLkAN8RA3v1hQniuR1Yuy+PMVH38PeQJY3v+eR8ktYTLPjAOPN7GigpCThi5k/osi/0jrHMT0+gSs+GKCkATqx2Q/0QCJiTKWFMS/w9Pq+DRlotST97cjzCo+Ew6JwJmTe5VhBCvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeCbzNkm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeCbzNkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783608614; x=1815144614;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Pg9xOQ1LWbf+sW6pfCeaqSoVfGMokJv6hSIQBwkQVcI=;
  b=SeCbzNkm9a9fmrONRZWHUICT/DvGC+2Z7QrFyL1Ysay+9K9pmB7BPMQw
   dcX3a+BoYOSeNncK/2KKkbCSHXlbvXcOUg92Qr+CuLbDfvnQVKuGZq9Gb
   HWONYx4YB15sCHpXNQon8ac4AV+sW+BFYb85x54jL7FOGc63CZ1eHuAZQ
   Ll040qu1lAfXFNG2hVtF0CFk/EYKhK4o+SL9MBZss4NHLp44iS4pS1NkH
   2lZQ8/tKz6TPjWojzvuE/84piU+Zoxt57kvgCFD9I02+MyQLUTNGF6/62
   FBKp1qPU9sK/M91wWG9dz6Kd9fADdWxrIz6ubxEbWcxq0M2V43racPTY+
   Q==;
X-CSE-ConnectionGUID: pFz2p/eeS16cIbLcI/Xa7g==
X-CSE-MsgGUID: /is+9NpkTum/vlUh31sS7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84265646"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84265646"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 07:50:13 -0700
X-CSE-ConnectionGUID: ORQYO3/IT2e8V9X7LSjQXg==
X-CSE-MsgGUID: MSG62UMpRaGRI4VPOGkswQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254722414"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.36])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 07:50:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Jul 2026 17:50:07 +0300 (EEST)
To: Eric Auger <eauger@redhat.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional
 sizes
In-Reply-To: <802e57d4-7a35-474b-a291-8a8f74b51a6b@redhat.com>
Message-ID: <fc981905-f6e0-fb9a-a905-9a65d01c8784@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com> <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com> <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com> <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
 <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com> <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com> <ef311b13-565b-aa2e-2f35-a94bc53d975a@linux.intel.com> <802e57d4-7a35-474b-a291-8a8f74b51a6b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1935247528-1783608607=:1261"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1935247528-1783608607=:1261
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Jul 2026, Eric Auger wrote:
> On 7/9/26 11:04 AM, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 8 Jul 2026, Eric Auger wrote:
> >> On 7/8/26 4:05 PM, Ilpo J=C3=A4rvinen wrote:
> >>> On Wed, 8 Jul 2026, Eric Auger wrote:
> >>>> On 7/7/26 6:12 PM, Ilpo J=C3=A4rvinen wrote:
> >>>>> On Tue, 7 Jul 2026, Eric Auger wrote:
> >>>>>
> >>>>>> Hi Ilpo,
> >>>>>>
> >>>>>> On 12/19/25 6:40 PM, Ilpo J=C3=A4rvinen wrote:
> >>>>>>> The resource loop in pbus_size_mem() handles optional resources t=
hat
> >>>>>>> are either fully optional (SRIOV and disabled Expansion ROMs) or =
bridge
> >>>>>>> windows that may be optional only for a part. The logic is little
> >>>>>>> inconsistent when it comes to a bridge window that has only optio=
nal
> >>>>>>> children resources as it would be more natural to treat it simila=
r to
> >>>>>>> any fully optional resource. As resource size should be zero in t=
hat
> >>>>>>> case, it shouldn't cause any bugs but it still seems useful to ad=
dress
> >>>>>>> the inconsistency.
> >>>>>>>
> >>>>>>> Place the optional size related code of pbus_size_mem() into
> >>>>>>> pbus_mem_size_optional() and add check into pci_resource_is_optio=
nal()
> >>>>>>> for entirely optional bridge windows. Reorder the logic inside
> >>>>>>> pbus_mem_size_optional() such that fully optional resources are h=
andled
> >>>>>>> the same irrespective to whether the resource is a bridge window =
or
> >>>>>>> not.
> >>>>>>
> >>>>>> This patch seems to introduce a regression when trying to hotplug =
a
> >>>>>> virtio-net-pci device behind a XIO3130 downstream port in the foll=
owing
> >>>>>> hierarchy.
> >>>>>>
> >>>>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest with =
qemu vmm.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> >>>>>> =09Subsystem: Red Hat, Inc. Device 1100
> >>>>>>
> >>>>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> >>>>>>    Subsystem: Red Hat, Inc. Device 0000
> >>>>>>    Kernel driver in use: pcieport
> >>>>>>
> >>>>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express Sw=
itch
> >>>>>>
> >>>>>> =09(Upstream) (rev 02)
> >>>>>> =09Kernel driver in use: pcieport
> >>>>>>
> >>>>>> =09|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
> >>>>>> =09=09Switch (Downstream) (rev 01)
> >>>>>> =09=09Kernel driver in use: pcieport
> >>>>>
> >>>>> Hi Eric,
> >>>>>
> >>>>> Thanks for the report.
> >>>>>
> >>>>> I cannot get much done with the log snippets. The first line with=
=20
> >>>>> difference is a symptom of something that originates from outside o=
f the=20
> >>>>> snippet.
> >>>>>
> >>>>> Could you please take a log with dyndbg=3D"file drivers/pci/*.c +p"=
 on the=20
> >>>>> kernel command line and also include a /proc/iomem dump. Like=20
> >>>>> you did now, preferrably take those from both working and failing c=
ase so=20
> >>>>> I can easily diff them.
> >>>>>
> >>>>> --
> >>>>>  i.
> >>>>>
> >>>>>
> >>>>>> This produces the following trace
> >>>>>>
> >>>>>>
> >>>>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card pres=
ent
> >>>>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >>>>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x02000=
0 PCIe
> >>>>>> Endpoint
> >>>>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >>>>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff =
64bit
> >>>>>> pref]
> >>>>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
> >>>>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: can't assign; no space
> >>>>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: failed to assign
> >>>>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: can't assign; no space
> >>>>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: failed to assign
> >>>>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000]: can't assign; no space
> >>>>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000]: failed to assign
> >>>>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref]: can't assign; no space
> >>>>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref]: failed to assign
> >>>>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> can't assign; no space
> >>>>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> failed to assign
> >>>>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can'=
t
> >>>>>> assign; no space
> >>>>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fail=
ed to
> >>>>>> assign
> >>>>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> can't assign; no space
> >>>>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> failed to assign
> >>>>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can'=
t
> >>>>>> assign; no space
> >>>>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fail=
ed to
> >>>>>> assign
> >>>>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>>>> [   29.611260] PCI: No. 2 try to assign unassigned res
> >>>>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: can't assign; no space
> >>>>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: failed to assign
> >>>>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: can't assign; no space
> >>>>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: failed to assign
> >>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000]: can't assign; no space
> >>>>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000]: failed to assign
> >>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref]: can't assign; no space
> >>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref]: failed to assign
> >>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> can't assign; no space
> >>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> failed to assign
> >>>>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can'=
t
> >>>>>> assign; no space
> >>>>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fail=
ed to
> >>>>>> assign
> >>>>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> can't assign; no space
> >>>>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bit =
pref]:
> >>>>>> failed to assign
> >>>>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: can'=
t
> >>>>>> assign; no space
> >>>>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fail=
ed to
> >>>>>> assign
> >>>>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >>>>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for le=
gacy
> >>>>>> driver
> >>>>>>
> >>>>>> Previous to this commit hotplug was successful:
> >>>>>>
> >>>>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
> >>>>>> Slot(0-1): Button press: will power on in 5 sec
> >>>>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card pres=
ent
> >>>>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> >>>>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x02000=
0 PCIe
> >>>>>> Endpoint
> >>>>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000fff]
> >>>>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003fff =
64bit
> >>>>>> pref]
> >>>>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
> >>>>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
100000
> >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> >>>>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: can't assign; no space
> >>>>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
> >>>>>> 0x00200000]: failed to assign
> >>>>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: can't assign; no space
> >>>>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x00=
200000
> >>>>>> 64bit pref]: failed to assign
> >>>>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10a00000-0x10afffff]: assigned
> >>>>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
> >>>>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
> >>>>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10a00000-0x10afffff]: failed to add optional 100000
> >>>>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
> >>>>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
> >>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
> >>>>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03fff =
64bit
> >>>>>> pref]: assigned
> >>>>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00fff]=
: assigned
> >>>>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
> >>>>>> 0x10a00000-0x10afffff]
> >>>>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
> >>>>>> 0x10b00000-0x10bfffff 64bit pref]
> >>>>>> [   39.559629] PCI: No. 2 try to assign unassigned res
> >>>>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> can't assign; no space
> >>>>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x10=
00]:
> >>>>>> failed to assign
> >>>>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> >>>>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
> >>>>>> 0x10a00000-0x10afffff]
> >>>>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
> >>>>>> 0x10b00000-0x10bfffff 64bit pref]
> >>>>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> >>>>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 -> 0=
002)
> >>>>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
> >>>>>>
> >>>>>> Any clue?
> >>>>>>
> >>>>>> Thank you in advance
> >>>>>>
> >>>>>> Eric
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Additional motivation for this are the upcoming changes that add
> >>>>>>> complexity to the optional sizing logic due to Resizable BAR awar=
eness.
> >>>>>>> The extra logic would exceed any reasonable indentation level if =
the
> >>>>>>> optional sizing code is kept within the loop body.
> >>>>>>>
> >>>>>>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >>>>>>> ---
> >>>>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++------=
------
> >>>>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> >>>>>>> index 3d1d3cefcdba..3fcc7641c374 100644
> >>>>>>> --- a/drivers/pci/setup-bus.c
> >>>>>>> +++ b/drivers/pci/setup-bus.c
> >>>>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(stru=
ct list_head *head,
> >>>>>>>  =09return dev_res ? dev_res->add_size : 0;
> >>>>>>>  }
> >>>>>>> =20
> >>>>>>> -static resource_size_t get_res_add_align(struct list_head *head,
> >>>>>>> -=09=09=09=09=09 struct resource *res)
> >>>>>>> -{
> >>>>>>> -=09struct pci_dev_resource *dev_res;
> >>>>>>> -
> >>>>>>> -=09dev_res =3D res_to_dev_res(head, res);
> >>>>>>> -=09return dev_res ? dev_res->min_align : 0;
> >>>>>>> -}
> >>>>>>> -
> >>>>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_re=
s)
> >>>>>>>  {
> >>>>>>>  =09struct resource *res =3D dev_res->res;
> >>>>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct pc=
i_dev *dev, int resno)
> >>>>>>>  =09=09return true;
> >>>>>>>  =09if (resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOURC=
E_ROM_ENABLE))
> >>>>>>>  =09=09return true;
> >>>>>>> +=09if (pci_resource_is_bridge_win(resno) && !resource_size(res))
> >>>> adding
> >>>>
> >>>> && !dev->is_hotplug_bridge makes the hotplug successful.
> >>>>
> >>>>
> >>>> My understanding is that otherwise the hotplug bridge window is
> >>>> considered as optional and no memoy window is allocated to assign ch=
id
> >>>> device's BARS
> >>>>
> >>>> Please let me know if that makes sense. In the positive I can send a=
 patch.
> >>>
> >>> I don't think that is the correct solution.
> >>>
> >>>
> >>> These bridges, have both non-prefetchable and prefetchable windows, b=
ut=20
> >>> the initial setup only sets the non-prefetchable one to 2M (and nothi=
ng=20
> >>> more would fit to the associated root bus resource). There's only a s=
ingle=20
> >>> root bus resource that is 2M + a bit more (to fit that BAR0).
> >>>
> >>> Now, when sizing the bridge windows, the kernel sizing algorithm just=
 uses=20
> >>> the default 2M hotplug reservation to both of those windows as there =
are=20
> >>> not yet any real devices underneath (the default hp reservation is=20
> >>> controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline paramet=
ers).=20
> >>> Thus, to fit everything, the root bus resource should be 4M + a bit m=
ore=20
> >>> for BAR0.
> >>>
> >>> However, it looks to me there's also a 4M add_size miscalculation (th=
e=20
> >>> downstream bridge window is only 2M per each type):
> >>>
> >>> [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000f=
ffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
> >>> [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000f=
ffff] to [bus 0b-0d] add_size 400000 add_align 100000
> >>
> >> Hum even with the patch below I still get:
> >>
> >> [    0.047253] pci 0000:0a:00.0: bridge window [mem
> >> 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
> >> add_align 100000
> >> [    0.047254] pci 0000:0a:00.0: bridge window [mem
> >> 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
>=20
> If I comment the continue in the block hereafter in pbus_size_mem() it
> works.

Many changes may appear working, but that doesn't necessarily make them=20
correct. The behavior with the older "working" kernel included that pulled=
=20
mandatory 1M sizes out of thin air and just happened to succeed with those=
=20
sizes to let your hotplug scenario to "work". It's still just numbers=20
pulled out of thin air (not derived from downstream resource sizes).

> if (pbus_size_mem_optional(dev, i, align,
>                            realloc_head, &add_align,
>                            &children_add_size)) {
>                                 //continue;
> }
>=20
> Given r_size =3D=3D 0, this allows to set aligns[order] +=3D align;
>=20
> isn't it requested for the parent bridges (the Root Port and Switch
> Upstream port) to see the downstream alignment requirements and map them
> out on boot?

It needs to be flexible. When not everything fits some things are more=20
important than others (aka. optional). On of such things is hotplug=20
reservation. If you'd change that behavior of the algorithm, be my guest=20
to fix all the brokenness that will ensue. ;-)

This here is the sizing algorithm. The actual assignments are done in a=20
different phase, and they try first with optional parts included but if=20
that fails, the algorithm falls back to first allocation all mandatory=20
resources, and then as many optional ones as it can.

(It seems I need to figure out why my debug patch does appear to be doing=
=20
anything tomorrow.)

--=20
 i.

--8323328-1935247528-1783608607=:1261--
