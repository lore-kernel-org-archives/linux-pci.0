Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA643E087
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198025; cv=none; b=ZpY1ovsFFq1xIhJn/WtEG5zVA4xmnanfoXcPFSWPqDrz5iNP18TeqAkVEVQl6Z3P/B1Z+4NtA7UTPmHUhUm+z4p8+Xl7NyqysCpWzhGc6NO0KPULqzKfjy652NCZINRmnxIEUyyr2T2/QncThFi9//kQdIQHEidCFrzmoqpvD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198025; c=relaxed/simple;
	bh=q0S22LkvaJaxGtVrf1IFUhhtg+iE2yCPiD6sOHM/btU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4U9Rt7a6WDqnNAmovKd1oGNWaUKtChJgwRa3kEA/cSypRuP/xow5UzZoHrMUC9PTttsM0b6DWECLFctJVC6wwgfPgHL7sGcF/z8JsQ6q13q9NnSSLuzwYw1nZyURvv6/i2pzYUU2tcLzavoizIOtRWjXG/qQW6ixHJTBmsbFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=ye509PIF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="ye509PIF"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so22435a12.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1788198023; x=1788802823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjaxOHCPvPzW43GNi0GeYzSiLY3JZN8VKBHl2ac4GZc=;
        b=ye509PIFh9M+1tN74twKd8ML9t811DeRDm4aFy8WPu/4tv9u09FZ5BW265pg9kcmD2
         UT7aYIs3ZCfZHw2Ldj23p+U3+LG8l1+2rSVY4/DOtx3WJmPg80fn+gDE9ioQ02lui3kL
         cDjKE50h5Y4nIG7tV8ro6TKcAss6VFON1y/bNLhSxLptnWQmdNEzjNjKjEaRJE2o3/qU
         NlImr6TjpTX3K3csaKZhqT+LkASxgiD+ANEjtaGMpvNHQvxRCGeRFUqvUObaVp2atsYX
         X9OYVLADjmFCbq7GjFmxdQmEXM6qClC+opKBbjPkS3V1F+gFsou4DRZpKMGJ/Fov6RJp
         IDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198023; x=1788802823;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjaxOHCPvPzW43GNi0GeYzSiLY3JZN8VKBHl2ac4GZc=;
        b=o3l70805dIW2lyZqMoG5BsefiYo8NmDJSosbacTiS3hQqcS+5p2ELk9HaRGua4Wz/h
         Emji/atUJSvW9MSohsu/z/9HJx3Ks4YzdwxoBcwiW09H+k3yFXjENaX/JMWuz6BhJ/q6
         ahypRBK2XP1cv4T4ETzKhLaCI6i0halRFmCW4sOJE0kXFD80hfqhoLFkJsBn9R7anWhk
         sXsqaNOszNwgRh3sgrLZtA4ZCtNpuE5P5aZ0AAf+MnNzO8BuiBmJbOQjOogDLx57qLPu
         fAgPbOHWOmbYl8GOjN/FcL+edfFfa+w565c4MZFxETuFQJiq7QbCmfRh0ZG5X5P/R/L1
         EczA==
X-Forwarded-Encrypted: i=1; AKwUvBwtw1KTo9lum79v2FNhGNSGoghrHSVKvKoi6s0iNN8RiXvqlxqVfO3/u8C5IbdsWVhuzztcrlEe94M=@vger.kernel.org
X-Gm-Message-State: AFuF++lBXn94+dtK9Rba/K24oJ2t9GJVjyq1bURlFC9GP2KjCXIJtsEH
	OeVkV2P30gOToNlJvg45/zfED4PaIAcAE0XWXMA/XV+dW6h0VFGoNNeAXuZo1hhi7+fCqhEwIaa
	UjU/hzjuRm//q
X-Gm-Gg: AYBFou1Vt3orirzu+lkMwkWK3MrNv2oAsnPA74/U83e8kiOsN5pl6fhdIpwq+pFGln8
	igP1hSPjISKKOqFcl/uOHALOH+7g8lF0vZst6sS/Lz35qM0f7MOVcjY1adFuyDQZHSRPuZqsA6v
	LBGi/lCbzE3dOPYCvtXQRalGrAtbPZbe+145ydLPgqw6sUgJxB87n7hNLch9xlS+oUq6usGj91w
	sx+yHBunGp0vI3V6/5iv+Viye89LE/4NLvs1TyW+f7AqdVkSRdC7LvM2Bsj9lvano6y6EWPhYvh
	Os62HSltUTc6iSgR0LojMXCMCsidjr3P/s52szJGlSt0lXhV3cRJd95JVy1LA2pp14aDydzx3cI
	8UHgtjCmUN5gh73hlCu70XCFz9kvKMl2rdFiLBmGh3JfrVtCNh4pmHyjfDn63xsyzvPhANxhiD5
	CAvfbIyFsaEhAywsFJQYjN8OSg/sr1H8DFj0MSD5vMWhmBgRWQ91J796g4l4SdQBtKu2sEbna/7
	yPKn3tvf25nnv/GbEa+9zfWb/KW+s0MGPKQmIwyYLdpmF/Fy0mnw45uHg==
X-Received: by 2002:a17:90b:1a8a:b0:398:9bd1:3211 with SMTP id 98e67ed59e1d1-3989bd135cbmr26619288a91.18.1788198023095;
        Mon, 31 Aug 2026 10:40:23 -0700 (PDT)
Received: from ?IPV6:2601:201:8000:f750:8c16:d636:dd01:2749? ([2601:201:8000:f750:8c16:d636:dd01:2749])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm35876826eec.14.2026.08.31.10.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:40:22 -0700 (PDT)
Message-ID: <7771e88e-9cdf-4415-97ac-69d15c015d1e@jqluv.com>
Date: Mon, 31 Aug 2026 10:40:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <fba65262-5490-4d60-d06d-9badaafc7e17@linux.intel.com>
Content-Language: en-US
From: Geramy Loveless <gloveless@jqluv.com>
In-Reply-To: <fba65262-5490-4d60-d06d-9badaafc7e17@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/31/26 9:31 AM, Ilpo Järvinen wrote:
> On Fri, 28 Aug 2026, Geramy Loveless wrote:
>
>> Firmware typically sizes prefetchable bridge windows for the boot-time
>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
>> no room for a driver to grow a Resizable BAR afterwards: every window
>> from the leaf up to the root is sized for the small BAR, so
>> pci_resize_resource() fails with -ENOSPC. 
>>
>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
>> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
>> VRAM BAR) pushes the required window size past the large BAR's alignment. 
>> Because bridge windows round up to a power of two,
> Do they??? In which kernel version I must ask??
I'm sorry this was in reference to a prior patch I made, **ignore**
>
>> this forces a massive 
>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
>> wasting ~32 GiB per GPU).
> The largest I've seen is 32GB + half of that. And that's not with the 
> latest kernel.

This is in reference to when there are two R9700s on one switch basically.
As far as my understanding currently how it works is that when there are two GPUs they both have a BAR0, BAR2, and BAR5 the BAR5 goes onto the 32-bit window.
Bar 0 and 2 don't go onto the second window by default as they could overfill it of course, bar 0 would not fit period, and 2 might which is the case I took. 
This allows BAR 0 on (GPU 0) in leaf 0 on window 0 to align as a multiple of 32G like it I guess has to? This is how I understand it, so if R9700 has 32G on, bar0, leaf 0, window 0, and share the same window as GPU 1 then we have to pad the space between GPU0 BARs on window 0 by 32G, meaning BAR2 really is also using 32G, its not possible or at least right now its not possible to move BAR2 to the end of all the allocations it doesnt fit the standards? Keep in mind this is not my specialty here I am trying my best to understand and solve the issue at hand.

>
>> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
>>
>> 1. Reserve Headroom: 
>> Reserve prefetchable window headroom for the maximum size of each 
>> downstream Resizable BAR during the bridge sizing pass. The device BAR 
>> and hardware ReBAR are left at their boot size to prevent tearing down 
>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
> ... reorganizing ...
>
>> Fallback / Alignment logic:
>> If the 32-bit space is exhausted, small BARs remain in the prefetchable 
>> window. The alignment logic gracefully handles this by rounding the bridge 
>> window up to the next power of two (e.g., growing to 64 GiB to fit a 32 GiB 
>> BAR + BAR2) to maintain PCIe compatibility, ensuring sibling GPUs land in 
>> properly aligned slots.
>>
>> Reserving is safe by default: __assign_resources_sorted() satisfies all
>> required resources first. Use pci=no_rebar_reserve and pci=no_bar_demote 
>> to restore previous behaviours.
> And how does this fallback, if the largest size doesn't fit? What are the 
> failure modes?
So if the smaller bars under 16M don't fit in the 32-bit addressable space the fallback mode is to do as I said above to your prior comment, basically put.
Don't move the 2M BAR2 over to the 32-bit addressable space / window and instead fallback to aligning the prior window by the size of the GPUs memory space as I understand it, when you have gpu0 and gpu1 both requiring 32GB their address has to be a multiple of their allocation size? meaning we get 32G for BAR0 and 32G for BAR2 even though BAR2 only needs 2M because its not aligned to allow GPU1 to be on a aligned space?
>
> It's correct that the sizing decision should be done in pbus_size_mem() 
> but it must not result in breaking things which a naive approach like 
> this will surely do.
>
> Without proper fallbacks done, there will be too much breakage it's a 
> showstopper for a naive patch like this.
>
> Basically, what we'd want to do is try with the largest size, then reduce 
> it one step at a time (because it's 2^n -> 2^(n-1) even one step saves 
> quite much so one might not need to reduce that many steps). But also, in 
> some IOV enabled cases the oversubscription of the space is very 
> substantial and you'd still want to maximize the BAR sizes to what is 
> allowed by the available space.
>
> Fallback is hard to implement, because sizing and assignment are quite far 
> from each other codewise and there are no structures to carry information 
> over to the next retry phase.
>
>> 2. Pack Oversized Windows (BAR Demotion): 
>> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR 
>> to be assigned from the non-prefetchable window. By clearing the PREFETCH 
>> flag on small control BARs during enumeration, they are placed below 4 GiB. 
>> The prefetchable window is then cleanly sized to the large BAR alone.
>>
>> Why this is safe for 32-bit (< 4G) MMIO space:
>> To prevent exhausting legacy < 4G space, demotion is strictly bounded. It 
>> only triggers beside a massive prefetchable BAR (>= 64 MiB), and the demoted 
>> BAR is strictly capped at 16 MiB (PCI_BAR_PACK_CAP). Even on an 8x GPU 
>> system, this consumes at most 128 MiB of < 4G space.  
> I'm not entirely sure I agree with this, at least it shouldn't be the 
> default configuration.
That's okay I believe, it probably is not the default case anyhow.
>
> This would also break setups where the GPU has large BARs that do not 
> share the alignment.
>
> It might be workable as very targetted instruction to put a particular BAR 
> into non-prefetchable window. For that, one needs to write a parser for 
> giving them on cmdline though but that might end up being generally 
> useful for avoiding some hotplug cannot-predict-the-future problems 
> (the current memsize controls are too coarse-grained to be useful in many 
> hotplug scenarios).
>
>
> A somewhat related problem currently is that more and more devices are 
> taking the liberty of not setting PREFETCH because recent PCIe spec made 
> the bridge window difference be 32/64-bit based. This results in very 
> suboptimal placement for such BARs.
>
>
> BTW, why you're not sending the patches as a proper series but merging 
> them into a single email??? It makes things harder for the reviewers. :-(

Yes that was an accident actually, I was using command line tools to build the patch file and had done that by accident.
Technically these patches where fully related but my tree is split in the fixes, I had to rebase it this is why I submitted multiple versions.
I do have a new version which resolves a few problems / use cases I appreciate you taking the time to review this work.

>
>
> Also, I note you sent multiple versions within a day. Please give some 
> time for commenting the first version. You should also list the changes 
> you've made in each version (the patch history).
I had noticed my first patch was split and realized how difficult that would of been to review. So I resubmitted the patch as one instead of two because they both technically depend on each other and thats not how it would get merged anyways because then the window compression feature would be missing, ie. not a huge fan of resource waste. Then I submitted another one generalizing the patch a bit more so it fit use cases without breaking other machines. I will in the future try to do patch submission better and appreciate your patience, I will also make sure follow-up patch versions are summarizing the changes made between the prior one and next one, thank you!
>
