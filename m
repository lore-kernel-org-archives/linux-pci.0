Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF16413D6F;
	Fri, 10 Jul 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687393; cv=none; b=TPYPslGr6ljJ6GARaHPiKInPrc1sVUBjEHt6D5YIZleHrvuj0IC0I3/rQ5+IgBa4w9EFG2uoqAjT6KTYScdKvRHhpkc4zN3DScVzuV5jlfqQPdDMsgvpU1t3o0OOoQ0qUyWbI5kqrXi09Tkg0p0AkZP+KpojXrqZk+oga/xHjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687393; c=relaxed/simple;
	bh=x8+uqyejI3VQVIiTVa14VM0Dw15XuJSHdYV4DTg5lIs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QlfiLri6g9GTqdI7Eb5ZN7j36oeLOWP0n/tzesXwcU936XWr2UgnKriApfB5g09FfkgbY470gz0bFfhQYdExNXCUkEJqkf0NV5gu7anU/+AVwKOBnp11WeSAoviB501fIhz9H144QHIdxtDAe3J/9Ziqb6D7rPBqYJdVtkbhdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQVSxGq/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQVSxGq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783687391; x=1815223391;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x8+uqyejI3VQVIiTVa14VM0Dw15XuJSHdYV4DTg5lIs=;
  b=ZQVSxGq/nVqhZD80i38yRRt74puQOibmErwBovY1LH9mrgTIPxINzNTS
   kKu+YzKkXqSXh0wJHSOYXd/W3gI0NXtWXgcszJois8E6L/5z4uZiMpNAC
   o4V4Gsixy/W6D8Vz5wiWpvMEibPETl3xpx5xDjVia3j8Qfn7MrWjLP4UX
   16DG27gpkJFVA4kcrrFFszAXlATORabGah2PLXIITmebvXIdBVCRh64Rm
   6URhy4VoilR72EVylWWXRoCKauPOEmbpWmyPLxJc1HYELJEEz3fR7wE1E
   RpuQja0NIY+DGjN4pnaETULQripahUfeQAmrBfBX724AlSCeSnTMOWlEQ
   A==;
X-CSE-ConnectionGUID: Z7vc5k0SQIOPqzvjzJWJKw==
X-CSE-MsgGUID: +N+COKctRPCWgEDMO/781Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107182356"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107182356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:43:10 -0700
X-CSE-ConnectionGUID: mw+hXCtFQgud4b2R4ditTA==
X-CSE-MsgGUID: 5fWZNrN0T+OaDIP13Pm5rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258758128"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:43:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jul 2026 15:43:04 +0300 (EEST)
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Eric Auger <eauger@redhat.com>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH 13/23] PCI: Add pbus_mem_size_optional() to handle optional
 sizes
In-Reply-To: <fc981905-f6e0-fb9a-a905-9a65d01c8784@linux.intel.com>
Message-ID: <24d4df44-45e0-4275-5ea9-196fd0af556d@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com> <20251219174036.16738-14-ilpo.jarvinen@linux.intel.com> <f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com> <fbdc88d3-b6b4-8098-58c5-1fdb2f7b19d6@linux.intel.com> <04c3d618-c38e-46bd-8618-ed95657b6a60@redhat.com>
 <e2dfd270-a831-06f4-6ddf-c14eb9bce1f8@linux.intel.com> <313af044-b9b7-496d-8d1c-dba61c606592@redhat.com> <ef311b13-565b-aa2e-2f35-a94bc53d975a@linux.intel.com> <802e57d4-7a35-474b-a291-8a8f74b51a6b@redhat.com>
 <fc981905-f6e0-fb9a-a905-9a65d01c8784@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-562867528-1783687384=:1178"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-562867528-1783687384=:1178
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Jul 2026, Ilpo J=C3=A4rvinen wrote:

> On Thu, 9 Jul 2026, Eric Auger wrote:
> > On 7/9/26 11:04 AM, Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 8 Jul 2026, Eric Auger wrote:
> > >> On 7/8/26 4:05 PM, Ilpo J=C3=A4rvinen wrote:
> > >>> On Wed, 8 Jul 2026, Eric Auger wrote:
> > >>>> On 7/7/26 6:12 PM, Ilpo J=C3=A4rvinen wrote:
> > >>>>> On Tue, 7 Jul 2026, Eric Auger wrote:
> > >>>>>
> > >>>>>> Hi Ilpo,
> > >>>>>>
> > >>>>>> On 12/19/25 6:40 PM, Ilpo J=C3=A4rvinen wrote:
> > >>>>>>> The resource loop in pbus_size_mem() handles optional resources=
 that
> > >>>>>>> are either fully optional (SRIOV and disabled Expansion ROMs) o=
r bridge
> > >>>>>>> windows that may be optional only for a part. The logic is litt=
le
> > >>>>>>> inconsistent when it comes to a bridge window that has only opt=
ional
> > >>>>>>> children resources as it would be more natural to treat it simi=
lar to
> > >>>>>>> any fully optional resource. As resource size should be zero in=
 that
> > >>>>>>> case, it shouldn't cause any bugs but it still seems useful to =
address
> > >>>>>>> the inconsistency.
> > >>>>>>>
> > >>>>>>> Place the optional size related code of pbus_size_mem() into
> > >>>>>>> pbus_mem_size_optional() and add check into pci_resource_is_opt=
ional()
> > >>>>>>> for entirely optional bridge windows. Reorder the logic inside
> > >>>>>>> pbus_mem_size_optional() such that fully optional resources are=
 handled
> > >>>>>>> the same irrespective to whether the resource is a bridge windo=
w or
> > >>>>>>> not.
> > >>>>>>
> > >>>>>> This patch seems to introduce a regression when trying to hotplu=
g a
> > >>>>>> virtio-net-pci device behind a XIO3130 downstream port in the fo=
llowing
> > >>>>>> hierarchy.
> > >>>>>>
> > >>>>>> this happens with a v7.2-rc2 guest kernel, on an arm64 guest wit=
h qemu vmm.
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> 00:01.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> > >>>>>> =09Subsystem: Red Hat, Inc. Device 1100
> > >>>>>>
> > >>>>>> |_ 0a:00.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
> > >>>>>>    Subsystem: Red Hat, Inc. Device 0000
> > >>>>>>    Kernel driver in use: pcieport
> > >>>>>>
> > >>>>>>    |_ 0b:00.0 PCI bridge: Texas Instruments XIO3130 PCI Express =
Switch
> > >>>>>>
> > >>>>>> =09(Upstream) (rev 02)
> > >>>>>> =09Kernel driver in use: pcieport
> > >>>>>>
> > >>>>>> =09|_ 0c:02.0 PCI bridge: Texas Instruments XIO3130 PCI Express
> > >>>>>> =09=09Switch (Downstream) (rev 01)
> > >>>>>> =09=09Kernel driver in use: pcieport
> > >>>>>
> > >>>>> Hi Eric,
> > >>>>>
> > >>>>> Thanks for the report.
> > >>>>>
> > >>>>> I cannot get much done with the log snippets. The first line with=
=20
> > >>>>> difference is a symptom of something that originates from outside=
 of the=20
> > >>>>> snippet.
> > >>>>>
> > >>>>> Could you please take a log with dyndbg=3D"file drivers/pci/*.c +=
p" on the=20
> > >>>>> kernel command line and also include a /proc/iomem dump. Like=20
> > >>>>> you did now, preferrably take those from both working and failing=
 case so=20
> > >>>>> I can easily diff them.
> > >>>>>
> > >>>>> --
> > >>>>>  i.
> > >>>>>
> > >>>>>
> > >>>>>> This produces the following trace
> > >>>>>>
> > >>>>>>
> > >>>>>> [   28.557947] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card pr=
esent
> > >>>>>> [   28.557949] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> > >>>>>> [   29.605376] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020=
000 PCIe
> > >>>>>> Endpoint
> > >>>>>> [   29.605724] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000ff=
f]
> > >>>>>> [   29.605765] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003ff=
f 64bit
> > >>>>>> pref]
> > >>>>>> [   29.605816] pci 0000:0d:00.0: enabling Extended Tags
> > >>>>>> [   29.606994] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   29.606998] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   29.607003] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: can't assign; no space
> > >>>>>> [   29.607005] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: failed to assign
> > >>>>>> [   29.607007] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: can't assign; no space
> > >>>>>> [   29.607008] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: failed to assign
> > >>>>>> [   29.607010] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.607012] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   29.607014] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000]: can't assign; no space
> > >>>>>> [   29.607016] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000]: failed to assign
> > >>>>>> [   29.607018] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref]: can't assign; no space
> > >>>>>> [   29.607019] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref]: failed to assign
> > >>>>>> [   29.607021] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.607022] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   29.607025] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.607026] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> failed to assign
> > >>>>>> [   29.607027] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: ca=
n't
> > >>>>>> assign; no space
> > >>>>>> [   29.607028] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fa=
iled to
> > >>>>>> assign
> > >>>>>> [   29.607029] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.607030] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> failed to assign
> > >>>>>> [   29.607031] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: ca=
n't
> > >>>>>> assign; no space
> > >>>>>> [   29.607032] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fa=
iled to
> > >>>>>> assign
> > >>>>>> [   29.607033] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> > >>>>>> [   29.611260] PCI: No. 2 try to assign unassigned res
> > >>>>>> [   29.611269] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   29.611272] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   29.611276] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: can't assign; no space
> > >>>>>> [   29.611277] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: failed to assign
> > >>>>>> [   29.611278] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: can't assign; no space
> > >>>>>> [   29.611279] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: failed to assign
> > >>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.611280] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   29.611281] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000]: can't assign; no space
> > >>>>>> [   29.611282] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000]: failed to assign
> > >>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref]: can't assign; no space
> > >>>>>> [   29.611283] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref]: failed to assign
> > >>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.611284] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.611286] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> failed to assign
> > >>>>>> [   29.611287] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: ca=
n't
> > >>>>>> assign; no space
> > >>>>>> [   29.611288] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fa=
iled to
> > >>>>>> assign
> > >>>>>> [   29.611288] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> can't assign; no space
> > >>>>>> [   29.611289] pci 0000:0d:00.0: BAR 4 [mem size 0x00004000 64bi=
t pref]:
> > >>>>>> failed to assign
> > >>>>>> [   29.611289] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: ca=
n't
> > >>>>>> assign; no space
> > >>>>>> [   29.611290] pci 0000:0d:00.0: BAR 1 [mem size 0x00001000]: fa=
iled to
> > >>>>>> assign
> > >>>>>> [   29.611291] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> > >>>>>> [   29.616141] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> > >>>>>> [   29.616378] virtio-pci 0000:0d:00.0: virtio_pci: leaving for =
legacy
> > >>>>>> driver
> > >>>>>>
> > >>>>>> Previous to this commit hotplug was successful:
> > >>>>>>
> > >>>>>> vm-rhel10 login: [   38.385692] pcieport 0000:0c:02.0: pciehp:
> > >>>>>> Slot(0-1): Button press: will power on in 5 sec
> > >>>>>> [   38.385798] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Card pr=
esent
> > >>>>>> [   38.385799] pcieport 0000:0c:02.0: pciehp: Slot(0-1): Link Up
> > >>>>>> [   39.553709] pci 0000:0d:00.0: [1af4:1041] type 00 class 0x020=
000 PCIe
> > >>>>>> Endpoint
> > >>>>>> [   39.554018] pci 0000:0d:00.0: BAR 1 [mem 0x00000000-0x00000ff=
f]
> > >>>>>> [   39.554042] pci 0000:0d:00.0: BAR 4 [mem 0x00000000-0x00003ff=
f 64bit
> > >>>>>> pref]
> > >>>>>> [   39.554099] pci 0000:0d:00.0: enabling Extended Tags
> > >>>>>> [   39.555202] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00100000
> > >>>>>> 64bit pref] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   39.555206] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00100000] to [bus 0d] add_size 100000 add_align 100000
> > >>>>>> [   39.555212] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: can't assign; no space
> > >>>>>> [   39.555213] pcieport 0000:0c:02.0: bridge window [mem size
> > >>>>>> 0x00200000]: failed to assign
> > >>>>>> [   39.555215] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: can't assign; no space
> > >>>>>> [   39.555216] pcieport 0000:0c:02.0: bridge window [mem size 0x=
00200000
> > >>>>>> 64bit pref]: failed to assign
> > >>>>>> [   39.555218] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   39.555219] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   39.555222] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10a00000-0x10afffff]: assigned
> > >>>>>> [   39.555224] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10b00000-0x10bfffff 64bit pref]: assigned
> > >>>>>> [   39.555225] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   39.555227] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   39.555228] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10a00000-0x10afffff]: failed to expand by 0x100000
> > >>>>>> [   39.555230] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10a00000-0x10afffff]: failed to add optional 100000
> > >>>>>> [   39.555232] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to expand by 0x100000
> > >>>>>> [   39.555234] pcieport 0000:0c:02.0: bridge window [mem
> > >>>>>> 0x10b00000-0x10bfffff 64bit pref]: failed to add optional 100000
> > >>>>>> [   39.555236] pci 0000:0d:00.0: BAR 4 [mem 0x10b00000-0x10b03ff=
f 64bit
> > >>>>>> pref]: assigned
> > >>>>>> [   39.555290] pci 0000:0d:00.0: BAR 1 [mem 0x10a00000-0x10a00ff=
f]: assigned
> > >>>>>> [   39.555305] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> > >>>>>> [   39.556804] pcieport 0000:0c:02.0:   bridge window [mem
> > >>>>>> 0x10a00000-0x10afffff]
> > >>>>>> [   39.557730] pcieport 0000:0c:02.0:   bridge window [mem
> > >>>>>> 0x10b00000-0x10bfffff 64bit pref]
> > >>>>>> [   39.559629] PCI: No. 2 try to assign unassigned res
> > >>>>>> [   39.559636] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   39.559638] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   39.559640] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> can't assign; no space
> > >>>>>> [   39.559642] pcieport 0000:0c:02.0: bridge window [io  size 0x=
1000]:
> > >>>>>> failed to assign
> > >>>>>> [   39.559644] pcieport 0000:0c:02.0: PCI bridge to [bus 0d]
> > >>>>>> [   39.561078] pcieport 0000:0c:02.0:   bridge window [mem
> > >>>>>> 0x10a00000-0x10afffff]
> > >>>>>> [   39.562011] pcieport 0000:0c:02.0:   bridge window [mem
> > >>>>>> 0x10b00000-0x10bfffff 64bit pref]
> > >>>>>> [   39.564500] ACPI: \_SB_.L0A2: Enabled at IRQ 37
> > >>>>>> [   39.564541] virtio-pci 0000:0d:00.0: enabling device (0000 ->=
 0002)
> > >>>>>> [   39.572231] virtio_net virtio2 enp13s0: renamed from eth0
> > >>>>>>
> > >>>>>> Any clue?
> > >>>>>>
> > >>>>>> Thank you in advance
> > >>>>>>
> > >>>>>> Eric
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>>
> > >>>>>>> Additional motivation for this are the upcoming changes that ad=
d
> > >>>>>>> complexity to the optional sizing logic due to Resizable BAR aw=
areness.
> > >>>>>>> The extra logic would exceed any reasonable indentation level i=
f the
> > >>>>>>> optional sizing code is kept within the loop body.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.co=
m>
> > >>>>>>> ---
> > >>>>>>>  drivers/pci/setup-bus.c | 77 +++++++++++++++++++++++++++++----=
--------
> > >>>>>>>  1 file changed, 54 insertions(+), 23 deletions(-)
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > >>>>>>> index 3d1d3cefcdba..3fcc7641c374 100644
> > >>>>>>> --- a/drivers/pci/setup-bus.c
> > >>>>>>> +++ b/drivers/pci/setup-bus.c
> > >>>>>>> @@ -125,15 +125,6 @@ static resource_size_t get_res_add_size(st=
ruct list_head *head,
> > >>>>>>>  =09return dev_res ? dev_res->add_size : 0;
> > >>>>>>>  }
> > >>>>>>> =20
> > >>>>>>> -static resource_size_t get_res_add_align(struct list_head *hea=
d,
> > >>>>>>> -=09=09=09=09=09 struct resource *res)
> > >>>>>>> -{
> > >>>>>>> -=09struct pci_dev_resource *dev_res;
> > >>>>>>> -
> > >>>>>>> -=09dev_res =3D res_to_dev_res(head, res);
> > >>>>>>> -=09return dev_res ? dev_res->min_align : 0;
> > >>>>>>> -}
> > >>>>>>> -
> > >>>>>>>  static void restore_dev_resource(struct pci_dev_resource *dev_=
res)
> > >>>>>>>  {
> > >>>>>>>  =09struct resource *res =3D dev_res->res;
> > >>>>>>> @@ -386,6 +377,8 @@ bool pci_resource_is_optional(const struct =
pci_dev *dev, int resno)
> > >>>>>>>  =09=09return true;
> > >>>>>>>  =09if (resno =3D=3D PCI_ROM_RESOURCE && !(res->flags & IORESOU=
RCE_ROM_ENABLE))
> > >>>>>>>  =09=09return true;
> > >>>>>>> +=09if (pci_resource_is_bridge_win(resno) && !resource_size(res=
))
> > >>>> adding
> > >>>>
> > >>>> && !dev->is_hotplug_bridge makes the hotplug successful.
> > >>>>
> > >>>>
> > >>>> My understanding is that otherwise the hotplug bridge window is
> > >>>> considered as optional and no memoy window is allocated to assign =
chid
> > >>>> device's BARS
> > >>>>
> > >>>> Please let me know if that makes sense. In the positive I can send=
 a patch.
> > >>>
> > >>> I don't think that is the correct solution.
> > >>>
> > >>>
> > >>> These bridges, have both non-prefetchable and prefetchable windows,=
 but=20
> > >>> the initial setup only sets the non-prefetchable one to 2M (and not=
hing=20
> > >>> more would fit to the associated root bus resource). There's only a=
 single=20
> > >>> root bus resource that is 2M + a bit more (to fit that BAR0).
> > >>>
> > >>> Now, when sizing the bridge windows, the kernel sizing algorithm ju=
st uses=20
> > >>> the default 2M hotplug reservation to both of those windows as ther=
e are=20
> > >>> not yet any real devices underneath (the default hp reservation is=
=20
> > >>> controllable with hpmmiosize/hpmmioprefsize/hpmemsize cmdline param=
eters).=20
> > >>> Thus, to fit everything, the root bus resource should be 4M + a bit=
 more=20
> > >>> for BAR0.
> > >>>
> > >>> However, it looks to me there's also a 4M add_size miscalculation (=
the=20
> > >>> downstream bridge window is only 2M per each type):
> > >>>
> > >>> [    0.048078] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x00=
0fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
> > >>> [    0.048079] pci 0000:0a:00.0: bridge window [mem 0x00100000-0x00=
0fffff] to [bus 0b-0d] add_size 400000 add_align 100000
> > >>
> > >> Hum even with the patch below I still get:
> > >>
> > >> [    0.047253] pci 0000:0a:00.0: bridge window [mem
> > >> 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000
> > >> add_align 100000
> > >> [    0.047254] pci 0000:0a:00.0: bridge window [mem
> > >> 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 1000=
00
> >=20
> > If I comment the continue in the block hereafter in pbus_size_mem() it
> > works.
>=20
> Many changes may appear working, but that doesn't necessarily make them=
=20
> correct. The behavior with the older "working" kernel included that pulle=
d=20
> mandatory 1M sizes out of thin air and just happened to succeed with thos=
e=20
> sizes to let your hotplug scenario to "work". It's still just numbers=20
> pulled out of thin air (not derived from downstream resource sizes).
>=20
> > if (pbus_size_mem_optional(dev, i, align,
> >                            realloc_head, &add_align,
> >                            &children_add_size)) {
> >                                 //continue;
> > }
> >=20
> > Given r_size =3D=3D 0, this allows to set aligns[order] +=3D align;
> >=20
> > isn't it requested for the parent bridges (the Root Port and Switch
> > Upstream port) to see the downstream alignment requirements and map the=
m
> > out on boot?
>=20
> It needs to be flexible. When not everything fits some things are more=20
> important than others (aka. optional). On of such things is hotplug=20
> reservation. If you'd change that behavior of the algorithm, be my guest=
=20
> to fix all the brokenness that will ensue. ;-)
>=20
> This here is the sizing algorithm. The actual assignments are done in a=
=20
> different phase, and they try first with optional parts included but if=
=20
> that fails, the algorithm falls back to first allocation all mandatory=20
> resources, and then as many optional ones as it can.
>=20
> (It seems I need to figure out why my debug patch does appear to be doing=
=20
> anything tomorrow.)

Hi again,

Apparently there was nothing wrong with it, just all resources in the=20
system I tested with were claimed earlier (by arch code, I suppose) so=20
there was nothing left to do for pbus_size_mem().

Here's the patch that should reveal what is calculated into each bridge=20
window. If there's an add_size 200000 row (or 100000 if you change the=20
reservation) without any "adding" entries it implies all memory is just=20
hp reservation.

It may print the same resource more than once in some cases but I didn't=20
want to spend my time on optimizing that part too much for a debug patch.

[DEBUG PATCH 1/1] PCI: Add debug print to show bridge window components

It's not always possible to know what going into final bridge window
size/add_size calculation. Thus, add a debug print to show all
resources processed by the size summing loop in pbus_size_mem().

NOT INTENDED FOR UPSTREAM IN CURRENT FORM.

Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..67410ee8eb82 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1215,7 +1215,8 @@ static resource_size_t calculate_head_align(resource_=
size_t *aligns,
  *
  * Return: %true if the resource is entirely optional.
  */
-static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
+static bool pbus_size_mem_optional(struct pci_bus *bus, struct resource *b=
_res,
+=09=09=09=09   struct pci_dev *dev, int resno,
 =09=09=09=09   resource_size_t align,
 =09=09=09=09   struct list_head *realloc_head,
 =09=09=09=09   resource_size_t *add_align,
@@ -1242,6 +1243,17 @@ static bool pbus_size_mem_optional(struct pci_dev *d=
ev, int resno,
 =09=09}
 =09}
=20
+=09if (bus->self) {
+=09=09const char *r_name =3D pci_resource_name(dev, resno);
+
+=09=09pci_dbg(bus->self, "%pR: adding %s: %s %pR size %llx + %llx align %l=
lx/%llx\n",
+=09=09=09b_res, pci_name(dev), r_name, res,
+=09=09=09(unsigned long long)r_size,
+=09=09=09(unsigned long long)(dev_res ? dev_res->add_size : 0),
+=09=09=09(unsigned long long)align,
+=09=09=09(unsigned long long)(dev_res ? dev_res->min_align : 0));
+=09}
+
 =09if (!optional)
 =09=09return false;
=20
@@ -1325,7 +1337,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct=
 resource *b_res,
 =09=09=09=09continue;
 =09=09=09}
=20
-=09=09=09if (pbus_size_mem_optional(dev, i, align,
+=09=09=09if (pbus_size_mem_optional(bus, b_res, dev, i, align,
 =09=09=09=09=09=09   realloc_head, &add_align,
 =09=09=09=09=09=09   &children_add_size))
 =09=09=09=09continue;
@@ -1333,6 +1345,13 @@ static void pbus_size_mem(struct pci_bus *bus, struc=
t resource *b_res,
 =09=09=09r_size =3D resource_size(r);
 =09=09=09size +=3D max(r_size, align);
=20
+=09=09=09if (bus->self) {
+=09=09=09=09pci_dbg(bus->self, "%pR: adding %s: %s %pR size %llx align %ll=
x\n",
+=09=09=09=09b_res, pci_name(dev), r_name, r,
+=09=09=09=09(unsigned long long)r_size,
+=09=09=09=09(unsigned long long)align);
+=09=09=09}
+
 =09=09=09/*
 =09=09=09 * If resource's size is larger than its alignment,
 =09=09=09 * some configurations result in an unwanted gap in

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.47.3

--8323328-562867528-1783687384=:1178--
