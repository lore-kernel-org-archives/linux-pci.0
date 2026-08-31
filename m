Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB7443E56
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198586; cv=none; b=EugkZJKV/971PFM6trEy8oQrPt5ysfPHe+SHa+/7KmHy75nfu1pBrubO6u1F9yhVMHIoAYF5E+9bEqkGugqLs628QUYusYJD/c9PGrv/vmUxJz1YXFu8AYdLgCVNIecRLiM7n4mrMU6ukwQ8WsagHUGbwwQqwLC0hgwQaVXAz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198586; c=relaxed/simple;
	bh=OBU/eg/X2S5EdWEkGdwBGyBJnN778iYUKBmsqNShC3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNwcneEnhmpuy0Esaurb8BjFw9DsBHeN1XR7spW7+b36a/zSNVPdKCo7PSAU7fvu3KymvOoSjjr6pfV27m3GfewgxWxGXGYj+l19AsP/AnzlmXi36voXWYZX+lycEORTsz0NrQJdjjf3gi8RMWx4s+KEw71CMGsuWz4xfDT5dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=IVNEgiZ0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="IVNEgiZ0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a5aad413so33139a91.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1788198583; x=1788803383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=botxbzxQfwMmll4N9lg7UoUIORlQsETodCVKSlD1n0k=;
        b=IVNEgiZ00ZENaPx0QvNtM1Y3Oi1hginE89rqwaGiVwC+bdBgMOvrqHGiBKIfPT8B8+
         mJSl7oDkqkFnvzYHhsQOyIYRr20S0BbSC9AWBiVoxB424wCWfej0X0gHG/24xwTqZ2eL
         Tazcvdg809+Hgwt8aeJ2Und2nXBYAjHbRGUekv94qyGiVSMOLrcd8BEUp3FVxPhe4Su4
         qkOqWvrKfSefv4qOiOS26/5Jmr9C82h9I2nSVlAxKVPqAK3Up30mC90UBF+QL7XlQYrk
         dH6yMIer/heWmikeOIEYgrwWrMw8ADvYT6Q8fJPA+EMoCcqRwYARm70fJOuruDyQPqfx
         hCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198583; x=1788803383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=botxbzxQfwMmll4N9lg7UoUIORlQsETodCVKSlD1n0k=;
        b=jmb76mXFmfKpHsVyaTKPDMHQi72j3It4wcnURyboJIarbxd/ovlVwXlwAdWRLDjkGz
         9EOBRnpT7YaNHkhfueBndIjU8d3jh4LrRD4bh1A+sclJuep5bnlQR3MbmpeUVSJJogOL
         NwGdh3Uat9ALaTpnj/ddFgkloLmkm3+f3zvTnQvuDszI7E4NxoKfBdJ6HXnqM2THPy9w
         qparF2+7NZyVeFdoZBr8NxAp793zruT8+DWwufAqxIyUMjznomonT7qFC9QWwGvquJow
         ZK+mJMh69jweYbYLdfTdBfXpf/NuNdWCvlqWqGNxoqbfi+x0AZ/yKiMqlyWqFDq8oGvz
         AqFw==
X-Forwarded-Encrypted: i=1; AKwUvBytJzLpatkO4NhgdCPv+iVHbMvW9gWybxIJfli5JwUrrHQAhQwCSOd7HzXA3MS/I3tvunq0Ws9CFxA=@vger.kernel.org
X-Gm-Message-State: AFuF++ln7D+WNumpKXVRBbVbCmFnvQuHmimUaae3WouEsXZoNzZCBECx
	SuTdTD9ASKOfSnvrozM1omqoLE2Q8f4ojS072W1PAoYZeRnch6mwc+rX0L0Wqy+RIx6GC5yXBjm
	RdzOP+PE=
X-Gm-Gg: AYBFou1p0+3WmCwKCwBf/7BL9xw1SGuaJvwrHiX2gfnixCou4/EbTpMIL5/g+BDDwQ/
	QZ+B3sa6ITseJI0bP0tdJIyQTgNYfAeAHUZsLI6hLo7rmRrsKRJw7SMF/CDm5Csd0kPG0JA11nt
	8Vf7yc6wqM+BVZz9+TcskH/F3cbyEf/MoN1mk7MBfX6Lf76u1YX7KrPU0SuiXqrduBaZAxY7sse
	aRgeRaS62IvAxsZtr6z4K2b3n6tWCAggdGrCUwUe4ibIFily7FtwdIFh69YF0wlha9zCxfHdwC0
	num4LMKdZOaojMtNZ4aSATgUy7PVeSDCJx2Qlsb1A0AxR2UuGwcIc3YBzyyUOJYeSBwlNmy8RTd
	Ly1zMF8v3OCmW0ZM9GQ/SbARg++PDc1guM64Z0zAf5L9Tgt9qVWXWjqx6z8esuqHKeycWFRg3MA
	ed5sstpAqK3V+/z4Ltdtxx74KNL3LRxXgQsk3txZtKDmPcj7PT33/6BbbkRf3NUAoDjOQInhrhV
	l7zJ4NUmZ+g8A/9aPcwjQwvG8vftHWBO6CBFPkK95LDmqxBOTGwF8/KsQ==
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-396d0e20f0bmr37994056a91.6.1788198583342;
        Mon, 31 Aug 2026 10:49:43 -0700 (PDT)
Received: from ?IPV6:2601:201:8000:f750:8c16:d636:dd01:2749? ([2601:201:8000:f750:8c16:d636:dd01:2749])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa5517fsm34703607eec.31.2026.08.31.10.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:49:42 -0700 (PDT)
Message-ID: <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Date: Mon, 31 Aug 2026 10:49:41 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
Content-Language: en-US
From: Geramy Loveless <gloveless@jqluv.com>
In-Reply-To: <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/31/26 9:58 AM, Ilpo Järvinen wrote:
> On Mon, 31 Aug 2026, Christian König wrote:
>
>> On 8/28/26 23:37, Geramy Loveless wrote:
>>> Firmware typically sizes prefetchable bridge windows for the boot-time
>>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
>>> no room for a driver to grow a Resizable BAR afterwards: every window
>>> from the leaf up to the root is sized for the small BAR, so
>>> pci_resize_resource() fails with -ENOSPC. 
>>>
>>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
>>> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
>>> VRAM BAR) pushes the required window size past the large BAR's alignment. 
>>> Because bridge windows round up to a power of two, this forces a massive 
>>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
>>> wasting ~32 GiB per GPU).
>>>
>>> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
>>>
>>> 1. Reserve Headroom: 
>>> Reserve prefetchable window headroom for the maximum size of each 
>>> downstream Resizable BAR during the bridge sizing pass. The device BAR 
>>> and hardware ReBAR are left at their boot size to prevent tearing down 
>>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
>> Yeah that was suggested before but that is clearly not something you can 
>> do in common code.
>>
>> The ReBAR fields often doesn't reflect the actual needed space but 
>> rather the maximum the HW address logic can resolve.
>>
>> So what you end up with is allocating multiple TiB for a window which 
>> just needs few GiB, sometimes even completely overflowing the 64bit 
>> address space made available by the root complex.

Yeah I could imagine that would be bad, hence I tried to compact the 64-bit space as well. As far as I understand PCI/PCIe standards its making this patch difficult.
Christian I'm not sure if you could share these reference documents but that probably would be a better start for me to look at before I update the patch or make changes, also I need to wait for a review on the last patch I submitted too, so that leaves me with some time to review some standards if you know specifically where to look, if not thats fine too.

> Yes. A naive approach to (only) go to the max ReBAR allows just doesn't 
> work well enough to be usable in general case.
I did not know the max would report above the amount is actually needed because of vendors decisions in the cards, that's interesting.
>
> A general algorithm to pick the largests fitting sizes for ReBARs is still 
> under works, a few steps away still, and more if I discover more 
> challenges I need address before I can take that final step.
So then I would assume instead of doing the "hack" i'm having to use I would change it to your new algorithm?
>
>>> 2. Pack Oversized Windows (BAR Demotion): 
>>> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
>>> to be assigned from the non-prefetchable window. By clearing the PREFETCH 
>>> flag on small control BARs during enumeration, they are placed below 4 GiB. 
>>> The prefetchable window is then cleanly sized to the large BAR alone.
>> Interesting hack, shouldn't really matter for AMD GPUs but that is 
>> something more on the heuristic side. 
>>
>> A perfectly valid trick which is done by BIOS implementations but what 
>> the Linux PCI subsystem still hasn't learned are back to back 
>> allocations, e.g. something like this:
>>
>> BAR0 32 GiB of GPU #1
>> BAR1 2	MiB of GPU #1
>>
>> BAR1 2	MiB of GPU #2
>> BAR0 32 GiB of GPU #2
This does work in practice actually, but it only works for 2 GPUs or so I thought, instead of doing that I opted it out to look for a real multi-purpose solution that fits more than my use case of one switch and two GPUs because I figured the chance of that getting implemented over a patch like this would be more likely.
> Assuming you're oversimplifying the layout above, this was added by the commit 
> 9036bd0efcb6 ("PCI: Align head space better").
>
> --
>  i.
>
>> BAR0 32 GiB of GPU #3
>> ...
>>
>> I strongly suggest to implement that one first and see if it helps with your use case.
>>
>> Regards,
>> Christian.
It does, but I didn't think it was upstream-able at that time, I am new to linux kernel patching so I am learning what is acceptable and what is not haha :)
Thanks for the honest review.
>>
>>> Why this is safe for 32-bit (< 4G) MMIO space:
>>> To prevent exhausting legacy < 4G space, demotion is strictly bounded. It 
>>> only triggers beside a massive prefetchable BAR (>= 64 MiB), and the demoted 
>>> BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU 
>>> system, this consumes at most 128 MiB of < 4G space. 
>>>
>>> Fallback / Alignment logic:
>>> If the 32-bit space is exhausted, small BARs remain in the prefetchable 
>>> window. The alignment logic gracefully handles this by rounding the bridge 
>>> window up to the next power of two (e.g., growing to 64 GiB to fit a 32 GiB 
>>> BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land in 
>>> properly aligned slots.
>>>
>>> Reserving is safe by default: __assign_resources_sorted() satisfies all
>>> required resources first. Use pci=no_rebar_reserve and pci=no_bar_demote 
>>> to restore previous behaviours.
>>>
>>> Testing Context:
>>> - ASUS K14PG-D24
>>> - 2x EPYC 9354
>>> - 8x Radeon AI PRO R9700 (Navi 48, 1002:7551)
>>> - Broadcom PEX890xx switches
>>> - Kernel base: 45c13f3f9e3b (tested with SEV-SNP passthrough=1)
>>>
>>> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
>>> ---
>>>  .../admin-guide/kernel-parameters.txt         |   8 ++
>>>  drivers/pci/pci.c                             |  10 ++
>>>  drivers/pci/pci.h                             |   1 +
>>>  drivers/pci/setup-bus.c                       | 118 ++++++++++++++++++
>>>  4 files changed, 137 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>> b/Documentation/admin-guide/kernel-parameters.txt
>>> index 37006fc3eac3..82d2b340fb98 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -5246,6 +5246,14 @@ Kernel parameters
>>>  		hpbussize=nn	The minimum amount of additional bus numbers
>>>  				reserved for buses below a hotplug bridge.
>>>  				Default is 1.
>>> +		no_rebar_reserve	Do not reserve prefetchable bridge-window
>>> +				space for the maximum size of downstream Resizable
>>> +				BARs. By default such space is reserved so a driver
>>> +				can grow a BAR later (e.g. GPU VRAM BAR) even behind
>>> +				fixed PCIe switch fabrics that firmware sized for the
>>> +				boot-time BAR; the device BAR is left at its boot size
>>> +				for the driver to resize and only bridge windows are
>>> +				enlarged. Use this to restore the old behaviour.
>>>  		realloc=	Enable/disable reallocating PCI bridge resources
>>>  				if allocations done by BIOS are too small to
>>>  				accommodate resources required by all child
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index b2879a6be5f8..c9901b15432a 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -120,6 +120,14 @@ unsigned long pci_hotplug_mmio_pref_size =
>>> DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>>>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>>>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>>>
>>> +/*
>>> + * Prefetchable bridge-window headroom is reserved for the maximum size of
>>> + * downstream Resizable BARs by default, so a driver can grow one later
>>> + * (e.g. amdgpu VRAM BAR) even behind fixed PCIe switch fabrics.
>>> + * pci=no_rebar_reserve disables this.
>>> + */
>>> +bool pci_rebar_no_reserve;
>>> +
>>>
>>>  /* PCIe MPS/MRRS strategy; can be overridden by kernel command-line
>>> param */
>>>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>>> @@ -6840,6 +6848,8 @@ static int __init pci_setup(char *str)
>>>  					simple_strtoul(str + 10, &str, 0);
>>>  				if (pci_hotplug_bus_size > 0xff)
>>>  					pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>>> +			} else if (!strncmp(str, "no_rebar_reserve", 16)) {
>>> +				pci_rebar_no_reserve = true;
>>>  			} else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>>>  				pcie_bus_config = PCIE_BUS_TUNE_OFF;
>>>  			} else if (!strncmp(str, "pcie_bus_safe", 13)) {
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index ba3c3fddddc2..6eddcb492425 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -409,6 +409,7 @@ extern unsigned long pci_hotplug_io_size;
>>>  extern unsigned long pci_hotplug_mmio_size;
>>>  extern unsigned long pci_hotplug_mmio_pref_size;
>>>  extern unsigned long pci_hotplug_bus_size;
>>> +extern bool pci_rebar_no_reserve;
>>>
>>>  static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
>>>  {
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index e8c94aa1d3c1..aa02b8454269 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/bug.h>
>>>  #include <linux/init.h>
>>>  #include <linux/kernel.h>
>>> +#include <linux/log2.h>
>>>  #include <linux/minmax.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pci.h>
>>> @@ -1258,6 +1259,53 @@ static bool pbus_size_mem_optional(struct pci_dev
>>> *dev, int resno,
>>>  	return true;
>>>  }
>>>
>>> +/*
>>> + * pci_rebar_reserve_size - prefetchable window headroom to reserve for
>>> a BAR
>>> + *
>>> + * Reserve enough prefetchable window space to later grow @resno of @dev to
>>> + * its maximum Resizable BAR size. This is done for every ReBAR-capable
>>> device
>>> + * by default (disable with pci=no_rebar_reserve). Only the optional
>>> (add_size)
>>> + * part of the enclosing window is inflated here; the device BAR
>>> resource and
>>> + * the hardware ReBAR are left at their boot size, so the driver still
>>> performs
>>> + * the actual resize into the reserved window. Reserving the window up
>>> front
>>> + * avoids -ENOSPC in pci_resize_resource() on fixed switch fabrics, where a
>>> + * window shared with a sibling's still-assigned BAR cannot be released and
>>> + * regrown at resize time.
>>> + *
>>> + * The reservation is strictly optional: __assign_resources_sorted()
>>> satisfies
>>> + * all required resources first and only then places add_size on leftover
>>> + * space, so reserving by default cannot make a required BAR or window
>>> fail.
>>> + *
>>> + * Return the extra bytes to reserve and raise *add_align to the BAR's
>>> + * alignment so the reserved space can actually hold the grown BAR.
>>> + */
>>> +static resource_size_t pci_rebar_reserve_size(struct pci_dev *dev, int
>>> resno,
>>> +					      resource_size_t *add_align)
>>> +{
>>> +	struct resource *res = pci_resource_n(dev, resno);
>>> +	resource_size_t max_size, cur_size;
>>> +	int max;
>>> +
>>> +	if (pci_rebar_no_reserve || resno >= PCI_STD_NUM_BARS)
>>> +		return 0;
>>> +
>>> +	if ((res->flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) !=
>>> +	    (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH))
>>> +		return 0;
>>> +
>>> +	max = pci_rebar_get_max_size(dev, resno);
>>> +	if (max < 0)
>>> +		return 0;
>>> +
>>> +	max_size = pci_rebar_size_to_bytes(max);
>>> +	cur_size = resource_size(res);
>>> +	if (max_size <= cur_size)
>>> +		return 0;
>>> +
>>> +	*add_align = max(*add_align, max_size);
>>> +	return max_size - cur_size;
>>> +}
>>> +
>>>  /**
>>>   * pbus_size_mem() - Size the memory window of a given bus
>>>   *
>>> @@ -1285,6 +1333,7 @@ static void pbus_size_mem(struct pci_bus *bus,
>>> struct resource *b_res,
>>>  	int order, max_order;
>>>  	resource_size_t children_add_size = 0;
>>>  	resource_size_t add_align = 0;
>>> +	resource_size_t rebar_align = 0;
>>>
>>>  	if (!b_res)
>>>  		return;
>>> @@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus,
>>> struct resource *b_res,
>>>  				aligns[order] += align;
>>>  			if (order > max_order)
>>>  				max_order = order;
>>> +
>>> +			size += pci_rebar_reserve_size(dev, i, &rebar_align);
>>>  		}
>>>  	}
>>>
>>>  	win_align = pci_min_window_alignment(bus, b_res->flags);
>>>  	min_align = calculate_head_align(aligns, max_order);
>>>  	min_align = max(min_align, win_align);
>>> +	min_align = max(min_align, rebar_align);
>>>  	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
>>>  				  0, win_align);
>>>
>>> +	/*
>>> +	 * A window that reserves ReBAR headroom is larger than its own
>>> +	 * alignment (e.g. 32 GiB BAR + doorbell => 33 GiB > 32 GiB). The
>>> +	 * parent only reserves alignment padding for a child window when
>>> +	 * its size <= its alignment, so round such a window's alignment up
>>> +	 * to a power of two >= its size; sibling 32 GiB BARs behind one
>>> +	 * switch then each land in a properly aligned slot.
>>> +	 */
>>> +	if (rebar_align && size0)
>>> +		min_align = max(min_align, roundup_pow_of_two(size0));
>>> +
>>>  	if (size0) {
>>>  		resource_set_range(b_res, min_align, size0);
>>>  		b_res->flags &= ~IORESOURCE_DISABLED;
>>> @@ -2179,6 +2242,52 @@ static void pci_prepare_next_assign_round(struct
>>> list_head *fail_head,
>>>   * Second and later try will clear small leaf bridge res.
>>>   * Will stop till to the max depth if can not find good one.
>>>   */
>>> +/*
>>> + * Release the 64-bit prefetchable BARs of resizable-BAR display
>>> devices so the
>>> + * windows enclosing them empty out and can be re-sized. The BAR *size*
>>> is left
>>> + * untouched (only released and re-placed), so the hardware ReBAR is never
>>> + * programmed here - the driver still owns the actual resize.
>>> + */
>>> +static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
>>> +{
>>> +	struct resource *r;
>>> +	unsigned int i;
>>> +
>>> +	if ((dev->class >> 16) != PCI_BASE_CLASS_DISPLAY)
>>> +		return 0;
>>> +	if (pci_rebar_get_max_size(dev, 0) <= pci_rebar_get_current_size(dev, 0))
>>> +		return 0;
>>> +	pci_dev_for_each_resource(dev, r, i) {
>>> +		if (i >= PCI_BRIDGE_RESOURCES)
>>> +			break;
>>> +		if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
>>> +		    (r->flags & IORESOURCE_PREFETCH))
>>> +			pci_release_resource(dev, i);
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Release the now-empty prefetchable bridge windows bottom-up so the
>>> sizing
>>> + * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to
>>> fit the
>>> + * BARs a driver will later grow.
>>> + */
>>> +static void pci_release_rebar_windows(struct pci_bus *bus)
>>> +{
>>> +	struct pci_dev *dev;
>>> +	struct resource *w;
>>> +
>>> +	list_for_each_entry(dev, &bus->devices, bus_list)
>>> +		if (dev->subordinate)
>>> +			pci_release_rebar_windows(dev->subordinate);
>>> +
>>> +	if (!bus->self)
>>> +		return;
>>> +	w = &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
>>> +	if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)
>>> +		pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
>>> +}
>>> +
>>>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>>  {
>>>  	LIST_HEAD(realloc_head);
>>> @@ -2190,6 +2299,15 @@ void
>>> pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>>  	int pci_try_num = 1;
>>>  	enum enable_type enable_local;
>>>
>>> +	/*
>>> +	 * Release resizable device BARs and their prefetchable windows so the
>>> +	 * sizing pass re-sizes those windows large enough
>>> (pci_rebar_pref_reserve)
>>> +	 * for the BARs a driver will later grow. Only released and re-placed
>>> - the
>>> +	 * BAR size is left untouched, so the hardware ReBAR is never programmed.
>>> +	 */
>>> +	pci_walk_bus(bus, pci_release_rebar_bars_cb, NULL);
>>> +	pci_release_rebar_windows(bus);
>>> +
>>>  	/* Don't realloc if asked to do so */
>>>  	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
>>>  	if (pci_realloc_enabled(enable_local)) {
>>>
>>> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
