Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B12FE56A
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847535; cv=none; b=j8aN6eEIYzbYNBc4p3tf/TgOm/XfEwYOmHFYGJVRdSgXO6GQQwG7gsMlJwK/jGni37H/Y2FYmMqvj796g1e1My/rl8ewvu6qphfLYqi9cWFShZ0oRuux48GDzHnEw1NxobsexCLoIUHtXoJVJd/ybfjHODcWU0lTeyqDLP534Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847535; c=relaxed/simple;
	bh=pxXFSj/ujtA3WZ6H7URx4fHCg/LutJ5JDNuYH/7W9GE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfdfzonxK0u0GgiLirW37VxeHEOyxY/I7kwspulXAeXqQGYTiUACxVYr2dey8NW+y6Q4Llvt+JA/MYohSb3HkQaYB5h25ZgAieY3/mcI5yeKqdqwozoDNR9YJEFLiZwhwppDXQzyrGiiuUF+gaEztDDz79ac1FTzYuCMMBEE8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=d+aNelL8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="d+aNelL8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a6cf8242so17447061cf.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1775847531; x=1776452331; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxXFSj/ujtA3WZ6H7URx4fHCg/LutJ5JDNuYH/7W9GE=;
        b=d+aNelL86+3d5QHt+twQgf2jmjsCuGZaFA8Rbhezz4LKwfOJuoVPosnnK3nHbsxfpG
         q/ONUV0mrLUPenkBfAoUhZx8tmv/V52KOhodhC5dVT3n1iXSsp1u4eTsBacCybKtdlP9
         Z3wP5UpXJ/Jt334tEEO2jBE5A/GAaJGZIdtQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847531; x=1776452331;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxXFSj/ujtA3WZ6H7URx4fHCg/LutJ5JDNuYH/7W9GE=;
        b=D0kqUM/Af7L0WGJlJXK3rLT8piuVg0Lecbcoimfw0uwE9qRGlFNkaC0PRHdP2UEpv2
         94PI313BsiYibh8knFDEnub8C9Uts1vfDgz8ACplwOXh+ecjry+CupZTH4NPj7eJy8ph
         sthQ+Ld3NUmaEFtlb1xSslEW8bpoLnyz4b+j+7kiHLDu9ZHX6lgtPLBtrKqdnhaceoxn
         bDZ73J6xryZwtOEko5LIgA4LIprzW0Z3Mz2d5NTZKVNQZIdiQbinxJiauYR7CNbQlbhW
         0KORLQNit8b/FtGuA8xfOgcbXQ0oT3omv2BKoOxCepwyGOPyOfwb50QEPEm/xs0P52nw
         RypQ==
X-Gm-Message-State: AOJu0YwubhnFwuwQw/P1OlAb0X7myy1BIiPql5zURvYx/XAPHarAnq4M
	kBlYg9jBH4iizS/Ga/23AO9csgxi/9IRNBtPdYwsP8bNZw9Oowch4tvDMcQVYK3D1BqmGgiTBiK
	9oqxVCKIO
X-Gm-Gg: AeBDiettQp5Fbs6106oH2A7q5trzZWKu9lyArS5sahGJHvPgye+2mQRDidb8pg3Y4dY
	2RmWjgbLMrPuqyY+wCPnjX6HOlW4Q0mIJE93dYJFP8DM3XpSpjdnotQ0HUgeG8pGWHjZ7mIqUdg
	GEiQWi8g67d/1Elv5qAVqz3KhVhhw1I8v/XJgpzVy9kYI+BdGf14atLv3Mjy8d87M7hFJ10Z4LT
	Y1pEfggqohXN3eKJTX80oBgjN5i65GWRutOfr2fXhnzBOxKyum8P86QCXa6yGoLkG5/+YQ17GyX
	zplYZxRZZk9D9/bU/7hUGeYjhPVi6Y8RUXD2JzJCLiBFpXBcF2XGzFAdbU3MBrwOHi2kK7Y4wuA
	8kIsychH3slzyA0sq23CzbGyCajZtA31OY8T1TKaGmu5BomKna3NKpsAa1JVjDCHJnHEeSZKZDJ
	ovKBRD0cMt9psK1Q1mMIigJ4Y=
X-Received: by 2002:a05:622a:241:b0:50d:857d:7ad5 with SMTP id d75a77b69052e-50dd5c4345emr68716771cf.59.1775847530902;
        Fri, 10 Apr 2026 11:58:50 -0700 (PDT)
Received: from [192.168.153.215] ([73.29.38.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd90087f3sm21231321cf.8.2026.04.10.11.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:58:50 -0700 (PDT)
Message-ID: <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org>
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during
 rebar expansion
From: Cristian Cocos <cristi@ieee.org>
To: Geramy Loveless <gloveless@jqluv.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>
Date: Fri, 10 Apr 2026 14:58:50 -0400
In-Reply-To: <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
	 <20260410052918.5556-2-gloveless@jqluv.com>
	 <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
	 <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

My experience with=C2=A0my 9060XT Thunderbolt eGPU is that the current
amdgpu driver is full of bugs, and this *specifically* in a Thunderbolt
eGPU configuration. I have attempted to document some of these bugs
here:
https://pcforum.amd.com/s/question/0D5Pd00001S3Av9KAF/linux-9060xt-egpuover=
thunderbolt-bugs-galore

Apologies for posting this here, as most of these may not be relevant
to ReBAR, yet an AMD representative may still benefit from this
multiple bug report.

C

On Fri, 2026-04-10 at 10:53 -0700, Geramy Loveless wrote:
> =C2=A0I'm going to loop in Christian Koenig over at AMD he has been
> working
> with me on resolving or attempting to figure out whats going on with
> my gfx1201 connected to a tb5 dock to the host.
> I am currently having problems with the GPU basically loosing MMIO
> and
> crashing randomly. This recent patch change I believe helped but its
> really hard to say at this point.
> Without this patch of course the bar size would be 256MB and cause
> huge performance problems or feature loss. I am able to load up AI
> models and run workloads at nearly 100% gpu usage, i'm seeing 205W
> power draw out of the maximum 300W. But after sustained load I still
> get a crash.
>=20
> Maybe you would have an idea as to what is causing that crash or
> where
> I should be looking to find the cause?
> Here are some relevant logs, from what I can tell something is going
> on with MMIO, but the config bar as i understand it is still alive.
> This let me to believe maybe the router was getting put into suspend
> mode which wouldnt make sense for a GPU that is active and busy
> because the pcie tunnel would be active.
>=20
> Any advice or tips would be helpful thank you for the suggestions I
> will get started on writing the patch based on those recommendations.
>=20
> ## SMU Firmware Version
>=20
> ```
> smu driver if version =3D 0x0000002e
> smu fw if version =3D 0x00000032
> smu fw program =3D 0
> smu fw version =3D 0x00684b00 (104.75.0)
> ```
>=20
> Note: Driver interface version (0x2e / 46) does not match firmware
> interface version (0x32 / 50).
>=20
> ## PCI Topology
>=20
> ```
> 65:00.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84)
> 66:00.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 NHI
> 66:01.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 empty
> hotplug port
> 66:02.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 USB
> 66:03.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 dock
> 93:00.0 PCI bridge: Intel Barlow Ridge Hub 80G (rev 85) =E2=86=92 dock sw=
itch
> 94:00.0 PCI bridge: Intel Barlow Ridge Hub 80G (rev 85) =E2=86=92 downstr=
eam
> 95:00.0 PCI bridge: AMD Navi 10 XL Upstream Port (rev 24)
> 96:00.0 PCI bridge: AMD Navi 10 XL Downstream Port (rev 24)
> 97:00.0 VGA: AMD [1002:7551] (rev c0) =E2=86=90 GPU
> 97:00.1 Audio: AMD [1002:ab40]
> ```
>=20
> ## Workload
>=20
> GPU compute via llama.cpp (ROCm/HIP backend), running
> Qwen3.5-35B-A3B-Q4_K_M.gguf model (20.49 GiB, fully offloaded to
> VRAM). Flash attention enabled, 128K context, 32 threads.
>=20
> ## Crash Timeline
>=20
> All timestamps from `dmesg -T`, kernel boot-relative times in
> brackets.
>=20
> ### GPU initialization (successful)
>=20
> ```
> [603.644s] GPU probe: IP DISCOVERY 0x1002:0x7551
> [603.653s] Detected IP block: smu_v14_0_0, gfx_v12_0_0
> [603.771s] Detected VRAM RAM=3D32624M, BAR=3D32768M, RAM width 256bits
> GDDR6
> [604.014s] SMU driver IF 0x2e, FW IF 0x32, FW version 104.75.0
> [604.049s] SMU is initialized successfully!
> [604.119s] Runtime PM manually disabled (amdgpu.runpm=3D0)
> [604.119s] Initialized amdgpu 3.64.0 for 0000:97:00.0
> ```
>=20
> ### SMU stops responding [T+4238s after init, ~70 minutes]
>=20
> ```
> [4841.828s] SMU: No response msg_reg: 12 resp_reg: 0
> [4841.828s] [smu_v14_0_2_get_power_profile_mode] Failed to get
> activity monitor!
> [4849.393s] SMU: No response msg_reg: 12 resp_reg: 0
> [4849.393s] Failed to export SMU metrics table!
> ```
>=20
> 15 consecutive `SMU: No response` messages logged between [4841s] and
> [4948s], approximately every 7-8 seconds. All with `msg_reg: 12
> resp_reg: 0`. Failed operations include:
> - `smu_v14_0_2_get_power_profile_mode` =E2=80=94 Failed to get activity
> monitor
> - `Failed to export SMU metrics table`
> - `Failed to get current clock freq`
>=20
> ### Page faults begin [T+4349s after init, ~111s after first SMU
> failure]
>=20
> ```
> [4948.927s] [gfxhub] page fault (src_id:0 ring:40 vmid:9 pasid:108)
> Process llama-cli pid 35632
> GCVM_L2_PROTECTION_FAULT_STATUS: 0x00941051
> Faulty UTCL2 client ID: TCP (0x8)
> PERMISSION_FAULTS: 0x5
> WALKER_ERROR: 0x0
> MAPPING_ERROR: 0x0
> RW: 0x1 (write)
> ```
>=20
> 10 page faults logged at [4948s], all from TCP (Texture Cache Pipe),
> all PERMISSION_FAULTS=3D0x5, WALKER_ERROR=3D0x0, MAPPING_ERROR=3D0x0. 7
> unique faulting addresses:
> - 0x000072ce90828000
> - 0x000072ce90a88000
> - 0x000072ce90a89000
> - 0x000072ce90cde000
> - 0x000072ce90ce1000
> - 0x000072ce90f51000
> - 0x000072ce90f52000
>=20
> ### MES failure and GPU reset [T+4349s]
>=20
> ```
> [4952.809s] MES(0) failed to respond to msg=3DREMOVE_QUEUE
> [4952.809s] failed to remove hardware queue from MES, doorbell=3D0x1806
> [4952.809s] MES might be in unrecoverable state, issue a GPU reset
> [4952.809s] Failed to evict queue 4
> [4952.809s] Failed to evict process queues
> [4952.809s] GPU reset begin!. Source: 3
> ```
>=20
> ### GPU reset fails
>=20
> ```
> [4953.121s] Failed to evict queue 4
> [4953.121s] Failed to suspend process pid 28552
> [4953.121s] remove_all_kfd_queues_mes: Failed to remove queue 3 for
> dev 62536
> ```
>=20
> 6 MES(1) REMOVE_QUEUE failures, each timing out after ~2.5 seconds:
> ```
> [4955.720s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> [4958.283s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> [4960.847s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> [4963.411s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> [4965.976s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> [4968.540s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 fail=
ed to
> unmap legacy queue
> ```
>=20
> ### PSP suspend fails
>=20
> ```
> [4971.164s] psp gfx command LOAD_IP_FW(0x6) failed and response
> status is (0x0)
> [4971.164s] Failed to terminate ras ta
> [4971.164s] suspend of IP block <psp> failed -22
> ```
>=20
> ### Suspend unwind fails =E2=80=94 SMU not ready
>=20
> ```
> [4971.164s] SMU is resuming...
> [4971.164s] SMC is not ready
> [4971.164s] SMC engine is not correctly up!
> [4971.164s] resume of IP block <smu> failed -5
> [4971.164s] amdgpu_device_ip_resume_phase2 failed during unwind: -5
> [4971.164s] GPU pre asic reset failed with err, -22 for drm dev,
> 0000:97:00.0
> ```
>=20
> ### MODE1 reset =E2=80=94 SMU still dead
>=20
> ```
> [4971.164s] MODE1 reset
> [4971.164s] GPU mode1 reset
> [4971.164s] GPU smu mode1 reset
> [4972.193s] GPU reset succeeded, trying to resume
> [4972.193s] VRAM is lost due to GPU reset!
> [4972.193s] SMU is resuming...
> [4972.193s] SMC is not ready
> [4972.193s] SMC engine is not correctly up!
> [4972.193s] resume of IP block <smu> failed -5
> [4972.193s] GPU reset end with ret =3D -5
> ```
>=20
>=20
>=20
>=20
> On Fri, Apr 10, 2026 at 3:09=E2=80=AFAM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >=20
> > On Thu, 9 Apr 2026, Geramy Loveless wrote:
> >=20
> > > When pbus_reassign_bridge_resources() walks up the bridge
> > > hierarchy
> > > to expand a window (e.g. for resizable BAR), it refuses to
> > > release
> > > any bridge window that has children.=C2=A0 This prevents BAR resize o=
n
> > > devices behind multi-port PCIe switches (such as Thunderbolt
> > > docks)
> > > where empty sibling downstream ports hold small reservations that
> > > block the parent bridge window from being freed and re-sized.
> > >=20
> > > Add pci_bus_subtree_empty() to check whether a bus subtree
> > > contains
> > > any assigned device BARs, and pci_bus_release_empty_bridges() to
> > > release bridge window resources of empty sibling bridges, saving
> > > them to the rollback list so failures can be properly unwound.
> > >=20
> > > In pbus_reassign_bridge_resources(), call
> > > pci_bus_release_empty_bridges()
> > > before checking res->child, so empty sibling windows are cleared
> > > first
> > > and the parent window can then be released and grown.
> > >=20
> > > Uses PCI bus/device iterators rather than walking the raw
> > > resource
> > > tree, which avoids issues with stale sibling pointers after
> > > resource
> > > release.
> >=20
> > This paragraph can be dropped. And it's not exactly correct either
> > as
> > the pointers are only stale for resource entries that reside
> > outside of
> > the resource tree (after they've been released in a specific way)
> > so if
> > you start from a resource tree entry, you should never encounter a
> > stale
> > pointer.
> >=20
> > > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > > ---
> > > =C2=A0drivers/pci/setup-bus.c | 99
> > > ++++++++++++++++++++++++++++++++++++++++-
> > > =C2=A01 file changed, 97 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 4cf120ebe5a..7a182cd7e4d 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -2292,6 +2292,94 @@ void
> > > pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> > >=20
> > > +/*
> > > + * pci_bus_subtree_empty - Check whether a bus subtree has any
> > > assigned
> > > + * non-bridge device resources.
> > > + * @bus: PCI bus to check
> > > + *
> > > + * Returns true if no device on @bus or its descendant buses has
> > > any
> > > + * assigned BARs (bridge window resources are not considered).
> > > + */
> > > +static bool pci_bus_subtree_empty(struct pci_bus *bus)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *dev;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(dev, &bus->devices, bus=
_list) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct resource *r;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int i;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_dev_for_each_resource(dev, r, i) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i >=3D PCI_BRIDG=
E_RESOURCES)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (resource_assigne=
d(r))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (dev->subordinate &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !pci_bus_subtree_empty(dev->subordinate))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > +}
> > > +
> > > +/*
> > > + * pci_bus_release_empty_bridges - Release bridge window
> > > resources of
> > > + * empty sibling bridges so the parent window can be freed and
> > > re-sized.
> > > + * @bus: PCI bus whose child bridges to scan
> > > + * @b_win: Parent bridge window resource; only children of this
> > > window
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are released
> > > + * @saved: List to save released resources for rollback
> > > + *
> > > + * For each PCI-to-PCI bridge on @bus whose subtree is empty (no
> > > assigned
> > > + * device BARs), releases bridge window resources that are
> > > children of
> > > + * @b_win, saving them for rollback via @saved.
> > > + *
> > > + * Returns 0 on success, negative errno on failure.
> > > + */
> > > +static int pci_bus_release_empty_bridges(struct pci_bus *bus,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct resource *b_win,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct list_head *saved)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *dev;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(dev, &bus->devices, bus=
_list) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct resource *r;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int i;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!dev->subordinate)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if ((dev->class >> 8) !=3D PCI_CLASS_BRIDGE_PCI)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> >=20
> > I suppose dev->subordinate check is enough for what we're doing so
> > this
> > looks redundant.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!pci_bus_subtree_empty(dev->subordinate))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pci_dev_for_each_resource(dev, r, i) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pci_resource_is=
_bridge_win(i))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!resource_assign=
ed(r))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r->parent !=3D b=
_win)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_dev_res_=
add_to_list(saved, dev,
> > > r, 0, 0);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_child_resour=
ces(r);
> >=20
> > Unfortunately you cannot call this low-level function because it
> > recursively frees child resources which means you won't be able to
> > rollback them as they were not added to the saved list.
> >=20
> > I think the release algorithm should basically do this:
> >=20
> > - Recurse to the subordinate buses
> > - Loop through bridge window resources of this bus
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Skip resources that are no=
t assigned or are not parented
> > by b_win
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If the resource still has =
childs, leave the resource
> > alone
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (+ log it for ea=
sier troubleshooting these cases; any
> > failure
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 will also cascade to upstream so it may be possible to
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 shortcut something but it will also make the algorithm
> > more
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 complicated)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Save and free the resource
> >=20
> > It might be better to move some of the code from
> > pbus_reassign_bridge_resources() here as there's overlap with the
> > sketched
> > algorithm (but I'm not sure until I see the updated version but
> > keep this
> > in mind).
> >=20
> > Doing pci_bus_subtree_empty() before any removal is fine with me,
> > but I
> > see it just an optimization.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_release_resource=
(dev, i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +
> > > =C2=A0/*
> > > =C2=A0 * Walk to the root bus, find the bridge window relevant for
> > > @res and
> > > =C2=A0 * release it when possible. If the bridge window contains
> > > assigned
> > > @@ -2316,7 +2404,14 @@ static int
> > > pbus_reassign_bridge_resources(struct pci_bus *bus, struct
> > > resource *
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 i =3D pci_resource_num(bridge, res);
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Ignore BARs which are still in use */
> >=20
> > I don't know why you removed this comment (I admit though "BARs"
> > could
> > have been worded better as it's bridge windows we're dealing here).
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Release empty sibling bridge windows first */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (bridge->subordinate) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_bus_rele=
ase_empty_bridges(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bridge->subordinate, res,
> > > saved);
> >=20
> > First arg fits to the previous line.
> >=20
> > Align the second line to (.
> >=20
> > But consider also rearranging code as I mentioned above.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >=20
> > Consider proceeding with the resize even if something failed as
> > there are
> > cases where the bridge windows are large enough (admittedly, you
> > seem to
> > only bail out in case of alloc error).
> >=20
> > In to the same vein, there seems to be one existing goto restore
> > (that was
> > added by me), which could also probably do continue instead (but
> > changing
> > it would be worth another patch).
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!res->child) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pci_dev_r=
es_add_to_list(saved,
> > > bridge, res, 0, 0);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > @@ -2327,7 +2422,7 @@ static int
> > > pbus_reassign_bridge_resources(struct pci_bus *bus, struct
> > > resource *
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *res_n=
ame =3D
> > > pci_resource_name(bridge, i);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_warn(bridge,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s %pR: was not released (still
> > > contains assigned resources)\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s %pR: not released, active
> > > children present\n",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res_name, res);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > >=20
> > >=20
> >=20
> > --
> > =C2=A0i.
