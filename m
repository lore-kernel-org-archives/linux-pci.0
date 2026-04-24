Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C14343D75
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053536; cv=none; b=gq9SX2AK5T0dkuJ9Q6wOIE7ExNik5Af/qEbCKWjz9zAUfzzj80yMb20jpt5ei8V6DZr0r8BJSJ4DFUmKumBjuXpqwDATAYj907EYHyj9JZL5R/kEaQ5Zpm7+N/NKtd9ihDtVimjHwTJ2s8LciTRQYTHVd5Xxl2P0uHAJHX2lBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053536; c=relaxed/simple;
	bh=yoIkPFuHJu7jtSa1vxt6ZEUn2tbBC6h3Q8N4ETWe9/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEPt1pHmcDoc+r4/2FmvoWsc7vqXwDEqEFWqMhds93W0Js1PZflxv2bY/LuAVFNT/f2C+LFx6UdXel6QqjqMJ3fYY2UHQkyfNc0nByYKAWymTVt/Yz9Es8yqkmyeWuOSOnAkacdhngYk5ghYXfp8aXtknNpAXnyO679aJBeo+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=MuR2idGN; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="MuR2idGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1777053532;
	bh=yoIkPFuHJu7jtSa1vxt6ZEUn2tbBC6h3Q8N4ETWe9/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MuR2idGNfU6FG9sBIRxVl65Nz+RCNQRNTEadXnzlq6TiTmGjc8oEr2vZ/6JT13YIQ
	 Uz6Pk7mvXo/tAuL43QCVl/onbouLP1gIxDTEpZsj6UxW0D5q/qM2rbcf3sr/GafbOz
	 mYjrM61WvnQH6E3qur+PGOys4/gwaBZ83a+wV1v56lslnQelX2kZ/csinjiOdPheLf
	 RXk7J1FXVoBlrKizcBK2blMbgu9iAAqeY64fCMlX+ZrnC4P5sVWCFVjVL+3XSw0fS4
	 djRxiU4aM9ww6iGPcWP/pvS62aKrBddp53G20+CwqZrpQ3FxyHSpjb+//IpdHouBR1
	 Jb50yAlHubUhQ==
Message-ID: <eddf0632-81c5-49cb-b3a8-ef172d3ccb1c@lankhorst.se>
Date: Fri, 24 Apr 2026 19:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix resizable bar fails due to bridge memory region
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
References: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se>
 <ee594d2d-f5c8-271b-e883-9d43a47ad4ff@linux.intel.com>
 <92850c9a-808e-47b9-ae5f-fa10c4bda3ce@lankhorst.se>
 <990a7758-46eb-3fc8-2714-a2b117720241@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <990a7758-46eb-3fc8-2714-a2b117720241@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2026-04-24 kl. 19:42, skrev Ilpo Järvinen:
> On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
>> Den 2026-04-24 kl. 17:04, skrev Ilpo Järvinen:
>>> On Fri, 24 Apr 2026, Maarten Lankhorst wrote:
>>>
>>>> I encountered a problem that I have on my system, where I cannot resize
>>>> the bar because one of the bridges has a 
>>>
>>> You're missing words from here. But I can guess you've that extra BAR on 
>>> in-card the bridge.
>>>
>>>> If I take a look at the topology, the GPU shares the memory region with a bridge,
>>>>
>>>> +-[0000:64]-+-00.0-[65-68]----00.0-[66-68]--+-01.0-[67]----00.0
>>>>
>>>> The specific bridge likely causing a failure is:
>>>>
>>>> 65:00.0 PCI bridge: Intel Corporation Device e2ff (rev 01) (prog-if 00 [Normal decode])
>>>>         Flags: bus master, fast devsel, latency 0, IRQ 32, IOMMU group 1
>>>>         Memory at 382400000000 (64-bit, prefetchable) [size=8M]
>>>>         ....
>>>>
>>>> Which causes upstream bridge 64:00.0 initially to allocate the region
>>>> [38fe0000000-38ff0000000) for the GPU, and [382ff0000000..382ff07fffff]
>>>> for the bridge device.
>>>>
>>>> Bridge 64 is big enough for 1 BMG with a 32 GB bar and the second 8 MB allocation:
>>>> pci_bus 0000:64: resource 9 [mem 0x382000000000-0x382fffffffff window] (64GB window)
>>>>
>>>> The reason for failure is that bridge 65 has a 8 MB memory region assigned,
>>>
>>>> and previously it was ignored when reallocating.
>>>
>>> What does this mean? I don't think it was ever ignored while 
>>> reallocating??
>>>
>>> Note that kernel has become much more verbose in explaining why things 
>>> fail so perhaps the added message is confusing you (they won't appear in 
>>> the old kernels).
>>>
>>>> Failing case:
>>>> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
>>>> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: was not released (still contains assigned resources)
>>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
>>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
>>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
>>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
>>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
>>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
>>>> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
>>>> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
>>>> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
>>>> pcieport 0000:64:00.0:   bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]
>>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]
>>>> pcieport 0000:66:01.0: PCI bridge to [bus 67]
>>>> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
>>>> pcieport 0000:66:01.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]
>>>>
>>>> Working with the patch below:
>>>> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
>>>> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
>>>> pcieport 0000:65:00.0: BAR 0 [mem 0x382ff0000000-0x382ff07fffff 64bit pref]: releasing
>>>> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: releasing
>>>> pcieport 0000:64:00.0: bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]: assigned
>>>> pcieport 0000:65:00.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
>>>> pcieport 0000:65:00.0: BAR 0 [mem 0x382400000000-0x3824007fffff 64bit pref]: assigned
>>>> pcieport 0000:66:01.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
>>>> xe 0000:67:00.0: BAR 2 [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
>>>> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
>>>> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
>>>> pcieport 0000:64:00.0:   bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]
>>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
>>>> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
>>>> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
>>>> pcieport 0000:66:01.0: PCI bridge to [bus 67]
>>>> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
>>>> pcieport 0000:66:01.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
>>>> xe 0000:67:00.0: [drm] BAR2 resized to 16384MiB
>>>>
>>>>
>>>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>>>> ---
>>>> I'm not 100% this is the correct fix, I don't know why the bridge itself has
>>>> a memory region, why the kernel allocates it and when it's supposed to
>>>> be used. Not a PCI expert. :-)
>>>
>>> I don't know why it is there either. Nothing in the portdrv really uses it 
>>> for anything. There is patchset somewhere lying around which adds a quirk 
>>> that releases the "extra" BAR.
>>
>> Thank you, I've taken a look at that patch series. It looks like patch 1/2
>> would help a lot.
> 
> I should one day find time to finish that series, Bjorn didn't like how 
> the code didn't "disable" BAR.
> 
> I did some (unset) work towards placing the BARs outside the bridge 
> window but my algorithm was quite basic (just found min & max window
> addresses and put BAR outside of that range but then I thought maybe I 
> should add the possiblity for placing the BAR into the gap in the middle to
> allow placement of a large BAR in cases where 32-bit mmio blocks low-end + 
> 64-bit mmio range blocking the top of the address space.
> 
>> I'm wondering if it will completely fix the issue, it is still possible
>> that in the same config I have 2 identical cards, where resizing might
>> work, but when GPU1's VRAM BAR is already bound, it might be unable
>> to resize GPU2's VRAM BAR for the same reason as this patch.
> 
> It is always possible to find cases where a sibling pins the shared bridge 
> window in place.
> 
>> What would be the best way to handle this case?
> 
> The best way is to size them into the largest possible sizes right from 
> the beginning. But when doing that, nothing must break (introducing 
> regressions is not okay) so it kernel must be able to graciously fallback 
> to smaller sizes when there isn't enough space available for the largest 
> size.
> 
> What makes it complicated is that sizing and assignment are done very much 
> separately, so retrying with a smaller size is complicated. I'm working 
> toward this kind of solution but there are various things that have to be 
> fixed first.

How feasible would it be to add a quirk to resize the bar (or reserve enough
space for max) very early before any allocations are done?

I doubt any user of resizable bar is going to hotplug their GPU's.

Kind regards,
~Maarten Lankhorst
