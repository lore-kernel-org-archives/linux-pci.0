Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356993E3164
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843610; cv=pass; b=j9TUUkH23JKIPppDBC52+w9BDpF3eYBckY2JYyR15JsIDUNZj4SRbmvizUmZgT4L8QkemaOLNZUNbBOUIyZ2WSIBU1Lx8vpPAN9u1E3Uj6loRKWcbxEkw8l+wg7ks0frs100pTTMkW9FrYWdfhzS4rQjRuOKyIg8c9lMY5sfAlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843610; c=relaxed/simple;
	bh=xvn/2D2X78UvrqfCXlqh5WzmnEeMyqH7byZYfOfrvwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKFyiNJHIaLFMqCk2abaPTzt0he0tuerMmHaWil6nraNCXCqRXbNWlYUuK4qIIipuyY91YTSfzUX+ubTt6RZz5OqMaV+ukXnOwFxgiGUgAgtLn23fhSrXQqQ8SoKOQTPXzltKJDdHemugzSMEgilL/CD9T89bM0Kxqb3ePOF8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=s18zhJCI; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="s18zhJCI"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a016799d2cso28730576d6.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 10:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775843606; cv=none;
        d=google.com; s=arc-20240605;
        b=IlJAHpbmyVdg7eQkaiAi1zDW+avtWsi4mAzrszqle9aYTPAnTS/59isEUkoekEEilT
         fMGRDdfDtkmUshZwppPB7vXGOEORwTTB070ViHlSLFyekG4iIGq8sjsmH++JjDNgSJWr
         eICwfEVEFNdhFnrREgZB+WAU4PtJjjxAfG83S6kvRmj7HTgf6NjcgIvRn+Q8x/u7KAu1
         z7BvAOSKnrZyRZDaE4FJywoJJEYT2PTi6RLcgbdSrbpA6kSDhfg5adBxycdxrRp8TSGq
         mcVbv36zWPlgdnZVoTOK0U9Gkxp2GrW433oNGb2jQXNbB3lxxrIL4DOtA5KsVN4vfwPO
         0zTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hl5xKOuFFhafw6wEcq/usOHKXuFNfkm/WFnlhz3i0tw=;
        fh=vUQDxDnB4ySgPRF470iwOaZOqOi4hHdTxXgEq8j6N3Q=;
        b=DitiP8bU1zj8QA5FaX0VJSxXBQF4hyRBX5wd8p8fNZ4R0wxjhh48NoyqG82s56E9w7
         Jgr+MmhmDDqv5uaxfC4+w1QGlIo3cAyVRxCGzLRv59w4Pof1fX105nf95IEPnTKjGpfu
         N5hzhio1cySkSE6NauGvvx7IpbZ2hd6dwWOyNpNIW17vCkJRUnDXTllsJJBckU4/JVRM
         3HKWAVBu0ZcYxIefCOYI3erZ09REWoCE18BxZyPSGFN+ifQ4Qyv0CRPRZMUghkTamFQC
         97rpWrL1rKu6AGVbD26YimGyI7+ike1xcA/ty9wTB6lRgAENEESHQSXivrUdim2+vfi6
         4Qzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775843606; x=1776448406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl5xKOuFFhafw6wEcq/usOHKXuFNfkm/WFnlhz3i0tw=;
        b=s18zhJCILcdtmUc+jNJ+qQzZnPzlhlf0FA7uhy19XTz8unjMgPXEOmX6M0omhbJiQ8
         XqBZ2qV22CUmWD+0YVT0/0WWO8kESq3Gnx+qIZ/KKctwqZ2SFcGqF7kjGrImmctnzbaz
         e99j1qzb12zF2GiQYzAyDeefy3ejr3zoGPKj+dGeZNJsM6mbCU1gvsxkWJJE0523lzPO
         R7t6WLNqxMyJHSu0Raotdv2iug6xs/YWRUwV16WbxV9UBTrfFZ+Jr5Y57Z30AIrJaYK3
         lri6y0PEj8KD3Y+iwnUokeNaQYspqKO5fTeoMsTqxEawoVED8GsmHt9xbsp7kyJYEk3M
         PReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775843606; x=1776448406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hl5xKOuFFhafw6wEcq/usOHKXuFNfkm/WFnlhz3i0tw=;
        b=slzIXudBDQJtZTrCh8VV6wS8lhBPLf2q6taxRn+rNfNXRjOHU9WqEhIZQ+C0C/ed5g
         Gkt7uI+IuVvWLzt3UqPt5LlK/tTg4BimkLK7WaSpMaRGA/G1qu++0618i4HgO9Y7kNIU
         ACO0xywP6hGpPdDb9nhpfCwqRdQPlV1dp4ftCJaPtrnQMOJuKOIm91mX+jsFHKKlUdL0
         lea8ZBa8R9pM2fRQqXvycbRcGGN5vpGnwOItX06j3noRSvJ4+QQiiDO/+OEla+7ew4Cz
         CcGnz6skQQrSoROKKb2+E6SxIngiUPBMjFkAIYJkKXFnjg8jhIWNd8JL+/NTnwpIGKmA
         hPCw==
X-Gm-Message-State: AOJu0YwlQyXzHaLTAq8Eag/fDb/tQcgMretf3oFUOSva4cZScpxpC4ag
	rMxgbCUmoDoSXVDLZltIqE6Pv4bBbfBAEZmcr5QSuUkdJhcZfRj4/ii+KKGX9UCuxqDREffSHwr
	UAjl+o8QI0y907pIkadWBqthgCFn7KONI5lgLqDWLdg==
X-Gm-Gg: AeBDietHLzcsWxJcqJV+nsoxsyhOMv6EyR3Shl7YHaJaMpe7M+cpf35AOIVZwHzt+An
	26tHPwwFVIrBuULU4MkMSgatVdtY61LLhzBRmNM2C0L68f7vWI9T2qCDDDA/hqsyimcocNnwF9G
	0zCajzgjTXpQNn67Cwtbb7LgNnJssSZhC9UMpDkpqMSfgjWS5Z3Gec/TI2P2wCqneeVcggaohts
	HSsqfH/C5tpMwWetWVRCOy0ELnPSoioRlkLh8p+rQ/fyOcU1bchjuyJObZmgXWgyy0LWLlpxMp3
	F6Hw
X-Received: by 2002:a05:6214:4a03:b0:89a:666:ad2b with SMTP id
 6a1803df08f44-8ac8628d489mr68556556d6.27.1775843605835; Fri, 10 Apr 2026
 10:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
 <20260410052918.5556-2-gloveless@jqluv.com> <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
In-Reply-To: <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
From: Geramy Loveless <gloveless@jqluv.com>
Date: Fri, 10 Apr 2026 10:53:12 -0700
X-Gm-Features: AQROBzBOiyCqHqzRhkHVYr7Roen-LRmUaag8BeJJ_CbQCjGi1zxTXWJgpKRqWPo
Message-ID: <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during rebar expansion
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, cristi@ieee.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 I'm going to loop in Christian Koenig over at AMD he has been working
with me on resolving or attempting to figure out whats going on with
my gfx1201 connected to a tb5 dock to the host.
I am currently having problems with the GPU basically loosing MMIO and
crashing randomly. This recent patch change I believe helped but its
really hard to say at this point.
Without this patch of course the bar size would be 256MB and cause
huge performance problems or feature loss. I am able to load up AI
models and run workloads at nearly 100% gpu usage, i'm seeing 205W
power draw out of the maximum 300W. But after sustained load I still
get a crash.

Maybe you would have an idea as to what is causing that crash or where
I should be looking to find the cause?
Here are some relevant logs, from what I can tell something is going
on with MMIO, but the config bar as i understand it is still alive.
This let me to believe maybe the router was getting put into suspend
mode which wouldnt make sense for a GPU that is active and busy
because the pcie tunnel would be active.

Any advice or tips would be helpful thank you for the suggestions I
will get started on writing the patch based on those recommendations.

## SMU Firmware Version

```
smu driver if version =3D 0x0000002e
smu fw if version =3D 0x00000032
smu fw program =3D 0
smu fw version =3D 0x00684b00 (104.75.0)
```

Note: Driver interface version (0x2e / 46) does not match firmware
interface version (0x32 / 50).

## PCI Topology

```
65:00.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84)
66:00.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 NHI
66:01.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 empty ho=
tplug port
66:02.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 USB
66:03.0 PCI bridge: Intel Barlow Ridge Host 80G (rev 84) =E2=86=92 dock
93:00.0 PCI bridge: Intel Barlow Ridge Hub 80G (rev 85) =E2=86=92 dock swit=
ch
94:00.0 PCI bridge: Intel Barlow Ridge Hub 80G (rev 85) =E2=86=92 downstrea=
m
95:00.0 PCI bridge: AMD Navi 10 XL Upstream Port (rev 24)
96:00.0 PCI bridge: AMD Navi 10 XL Downstream Port (rev 24)
97:00.0 VGA: AMD [1002:7551] (rev c0) =E2=86=90 GPU
97:00.1 Audio: AMD [1002:ab40]
```

## Workload

GPU compute via llama.cpp (ROCm/HIP backend), running
Qwen3.5-35B-A3B-Q4_K_M.gguf model (20.49 GiB, fully offloaded to
VRAM). Flash attention enabled, 128K context, 32 threads.

## Crash Timeline

All timestamps from `dmesg -T`, kernel boot-relative times in brackets.

### GPU initialization (successful)

```
[603.644s] GPU probe: IP DISCOVERY 0x1002:0x7551
[603.653s] Detected IP block: smu_v14_0_0, gfx_v12_0_0
[603.771s] Detected VRAM RAM=3D32624M, BAR=3D32768M, RAM width 256bits GDDR=
6
[604.014s] SMU driver IF 0x2e, FW IF 0x32, FW version 104.75.0
[604.049s] SMU is initialized successfully!
[604.119s] Runtime PM manually disabled (amdgpu.runpm=3D0)
[604.119s] Initialized amdgpu 3.64.0 for 0000:97:00.0
```

### SMU stops responding [T+4238s after init, ~70 minutes]

```
[4841.828s] SMU: No response msg_reg: 12 resp_reg: 0
[4841.828s] [smu_v14_0_2_get_power_profile_mode] Failed to get activity mon=
itor!
[4849.393s] SMU: No response msg_reg: 12 resp_reg: 0
[4849.393s] Failed to export SMU metrics table!
```

15 consecutive `SMU: No response` messages logged between [4841s] and
[4948s], approximately every 7-8 seconds. All with `msg_reg: 12
resp_reg: 0`. Failed operations include:
- `smu_v14_0_2_get_power_profile_mode` =E2=80=94 Failed to get activity mon=
itor
- `Failed to export SMU metrics table`
- `Failed to get current clock freq`

### Page faults begin [T+4349s after init, ~111s after first SMU failure]

```
[4948.927s] [gfxhub] page fault (src_id:0 ring:40 vmid:9 pasid:108)
Process llama-cli pid 35632
GCVM_L2_PROTECTION_FAULT_STATUS: 0x00941051
Faulty UTCL2 client ID: TCP (0x8)
PERMISSION_FAULTS: 0x5
WALKER_ERROR: 0x0
MAPPING_ERROR: 0x0
RW: 0x1 (write)
```

10 page faults logged at [4948s], all from TCP (Texture Cache Pipe),
all PERMISSION_FAULTS=3D0x5, WALKER_ERROR=3D0x0, MAPPING_ERROR=3D0x0. 7
unique faulting addresses:
- 0x000072ce90828000
- 0x000072ce90a88000
- 0x000072ce90a89000
- 0x000072ce90cde000
- 0x000072ce90ce1000
- 0x000072ce90f51000
- 0x000072ce90f52000

### MES failure and GPU reset [T+4349s]

```
[4952.809s] MES(0) failed to respond to msg=3DREMOVE_QUEUE
[4952.809s] failed to remove hardware queue from MES, doorbell=3D0x1806
[4952.809s] MES might be in unrecoverable state, issue a GPU reset
[4952.809s] Failed to evict queue 4
[4952.809s] Failed to evict process queues
[4952.809s] GPU reset begin!. Source: 3
```

### GPU reset fails

```
[4953.121s] Failed to evict queue 4
[4953.121s] Failed to suspend process pid 28552
[4953.121s] remove_all_kfd_queues_mes: Failed to remove queue 3 for dev 625=
36
```

6 MES(1) REMOVE_QUEUE failures, each timing out after ~2.5 seconds:
```
[4955.720s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
[4958.283s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
[4960.847s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
[4963.411s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
[4965.976s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
[4968.540s] MES(1) failed to respond to msg=3DREMOVE_QUEUE =E2=86=92 failed=
 to
unmap legacy queue
```

### PSP suspend fails

```
[4971.164s] psp gfx command LOAD_IP_FW(0x6) failed and response status is (=
0x0)
[4971.164s] Failed to terminate ras ta
[4971.164s] suspend of IP block <psp> failed -22
```

### Suspend unwind fails =E2=80=94 SMU not ready

```
[4971.164s] SMU is resuming...
[4971.164s] SMC is not ready
[4971.164s] SMC engine is not correctly up!
[4971.164s] resume of IP block <smu> failed -5
[4971.164s] amdgpu_device_ip_resume_phase2 failed during unwind: -5
[4971.164s] GPU pre asic reset failed with err, -22 for drm dev, 0000:97:00=
.0
```

### MODE1 reset =E2=80=94 SMU still dead

```
[4971.164s] MODE1 reset
[4971.164s] GPU mode1 reset
[4971.164s] GPU smu mode1 reset
[4972.193s] GPU reset succeeded, trying to resume
[4972.193s] VRAM is lost due to GPU reset!
[4972.193s] SMU is resuming...
[4972.193s] SMC is not ready
[4972.193s] SMC engine is not correctly up!
[4972.193s] resume of IP block <smu> failed -5
[4972.193s] GPU reset end with ret =3D -5
```




On Fri, Apr 10, 2026 at 3:09=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 9 Apr 2026, Geramy Loveless wrote:
>
> > When pbus_reassign_bridge_resources() walks up the bridge hierarchy
> > to expand a window (e.g. for resizable BAR), it refuses to release
> > any bridge window that has children.  This prevents BAR resize on
> > devices behind multi-port PCIe switches (such as Thunderbolt docks)
> > where empty sibling downstream ports hold small reservations that
> > block the parent bridge window from being freed and re-sized.
> >
> > Add pci_bus_subtree_empty() to check whether a bus subtree contains
> > any assigned device BARs, and pci_bus_release_empty_bridges() to
> > release bridge window resources of empty sibling bridges, saving
> > them to the rollback list so failures can be properly unwound.
> >
> > In pbus_reassign_bridge_resources(), call pci_bus_release_empty_bridges=
()
> > before checking res->child, so empty sibling windows are cleared first
> > and the parent window can then be released and grown.
> >
> > Uses PCI bus/device iterators rather than walking the raw resource
> > tree, which avoids issues with stale sibling pointers after resource
> > release.
>
> This paragraph can be dropped. And it's not exactly correct either as
> the pointers are only stale for resource entries that reside outside of
> the resource tree (after they've been released in a specific way) so if
> you start from a resource tree entry, you should never encounter a stale
> pointer.
>
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> > ---
> >  drivers/pci/setup-bus.c | 99 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 4cf120ebe5a..7a182cd7e4d 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2292,6 +2292,94 @@ void pci_assign_unassigned_bridge_resources(stru=
ct pci_dev *bridge)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
> >
> > +/*
> > + * pci_bus_subtree_empty - Check whether a bus subtree has any assigne=
d
> > + * non-bridge device resources.
> > + * @bus: PCI bus to check
> > + *
> > + * Returns true if no device on @bus or its descendant buses has any
> > + * assigned BARs (bridge window resources are not considered).
> > + */
> > +static bool pci_bus_subtree_empty(struct pci_bus *bus)
> > +{
> > +     struct pci_dev *dev;
> > +
> > +     list_for_each_entry(dev, &bus->devices, bus_list) {
> > +             struct resource *r;
> > +             unsigned int i;
> > +
> > +             pci_dev_for_each_resource(dev, r, i) {
> > +                     if (i >=3D PCI_BRIDGE_RESOURCES)
> > +                             break;
> > +                     if (resource_assigned(r))
> > +                             return false;
> > +             }
> > +
> > +             if (dev->subordinate &&
> > +                 !pci_bus_subtree_empty(dev->subordinate))
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * pci_bus_release_empty_bridges - Release bridge window resources of
> > + * empty sibling bridges so the parent window can be freed and re-size=
d.
> > + * @bus: PCI bus whose child bridges to scan
> > + * @b_win: Parent bridge window resource; only children of this window
> > + *         are released
> > + * @saved: List to save released resources for rollback
> > + *
> > + * For each PCI-to-PCI bridge on @bus whose subtree is empty (no assig=
ned
> > + * device BARs), releases bridge window resources that are children of
> > + * @b_win, saving them for rollback via @saved.
> > + *
> > + * Returns 0 on success, negative errno on failure.
> > + */
> > +static int pci_bus_release_empty_bridges(struct pci_bus *bus,
> > +                                      struct resource *b_win,
> > +                                      struct list_head *saved)
> > +{
> > +     struct pci_dev *dev;
> > +
> > +     list_for_each_entry(dev, &bus->devices, bus_list) {
> > +             struct resource *r;
> > +             unsigned int i;
> > +
> > +             if (!dev->subordinate)
> > +                     continue;
> > +
> > +             if ((dev->class >> 8) !=3D PCI_CLASS_BRIDGE_PCI)
> > +                     continue;
>
> I suppose dev->subordinate check is enough for what we're doing so this
> looks redundant.
>
> > +
> > +             if (!pci_bus_subtree_empty(dev->subordinate))
> > +                     continue;
> > +
> > +             pci_dev_for_each_resource(dev, r, i) {
> > +                     int ret;
> > +
> > +                     if (!pci_resource_is_bridge_win(i))
> > +                             continue;
> > +
> > +                     if (!resource_assigned(r))
> > +                             continue;
> > +
> > +                     if (r->parent !=3D b_win)
> > +                             continue;
> > +
> > +                     ret =3D pci_dev_res_add_to_list(saved, dev, r, 0,=
 0);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     release_child_resources(r);
>
> Unfortunately you cannot call this low-level function because it
> recursively frees child resources which means you won't be able to
> rollback them as they were not added to the saved list.
>
> I think the release algorithm should basically do this:
>
> - Recurse to the subordinate buses
> - Loop through bridge window resources of this bus
>         - Skip resources that are not assigned or are not parented by b_w=
in
>         - If the resource still has childs, leave the resource alone
>           (+ log it for easier troubleshooting these cases; any failure
>              will also cascade to upstream so it may be possible to
>              shortcut something but it will also make the algorithm more
>              complicated)
>         - Save and free the resource
>
> It might be better to move some of the code from
> pbus_reassign_bridge_resources() here as there's overlap with the sketche=
d
> algorithm (but I'm not sure until I see the updated version but keep this
> in mind).
>
> Doing pci_bus_subtree_empty() before any removal is fine with me, but I
> see it just an optimization.
>
> > +                     pci_release_resource(dev, i);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Walk to the root bus, find the bridge window relevant for @res and
> >   * release it when possible. If the bridge window contains assigned
> > @@ -2316,7 +2404,14 @@ static int pbus_reassign_bridge_resources(struct=
 pci_bus *bus, struct resource *
> >
> >               i =3D pci_resource_num(bridge, res);
> >
> > -             /* Ignore BARs which are still in use */
>
> I don't know why you removed this comment (I admit though "BARs" could
> have been worded better as it's bridge windows we're dealing here).
>
> > +             /* Release empty sibling bridge windows first */
> > +             if (bridge->subordinate) {
> > +                     ret =3D pci_bus_release_empty_bridges(
> > +                                     bridge->subordinate, res, saved);
>
> First arg fits to the previous line.
>
> Align the second line to (.
>
> But consider also rearranging code as I mentioned above.
>
> > +                     if (ret)
> > +                             return ret;
>
> Consider proceeding with the resize even if something failed as there are
> cases where the bridge windows are large enough (admittedly, you seem to
> only bail out in case of alloc error).
>
> In to the same vein, there seems to be one existing goto restore (that wa=
s
> added by me), which could also probably do continue instead (but changing
> it would be worth another patch).
>
> > +             }
> > +
> >               if (!res->child) {
> >                       ret =3D pci_dev_res_add_to_list(saved, bridge, re=
s, 0, 0);
> >                       if (ret)
> > @@ -2327,7 +2422,7 @@ static int pbus_reassign_bridge_resources(struct =
pci_bus *bus, struct resource *
> >                       const char *res_name =3D pci_resource_name(bridge=
, i);
> >
> >                       pci_warn(bridge,
> > -                              "%s %pR: was not released (still contain=
s assigned resources)\n",
> > +                              "%s %pR: not released, active children p=
resent\n",
> >                                res_name, res);
> >               }
> >
> >
>
> --
>  i.
