Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91F3B47FF;
	Mon, 21 Sep 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996147; cv=none; b=FHE6hhGDUBkz48W6SvcyWnizKHu2bbWOPVnNiSMZYA9dqNCi0RGtz8sw01JDNjOEySSZ9GYGbaLKVeVqRbsP4HTpERTvPyEj/qzDrHGXP943osvL+zEBOXhUsysllhEp7/HGMA+ugZ7Bl8YS725wh3ncnqmxofe2ytdgk6ELEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996147; c=relaxed/simple;
	bh=iLgseTPsPpKsXTFPmfa4IyrpdTtbx0Dq6np9x+weJs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/mxPCWfozpUejfuqI0AtHr5+1+h7xN5xT+yFZV8/8/xg40LVHrxz5zbmPbru3L/S1u138ddtQHBfKGE/PcbmC8mra9EjkdAh4NaKOz9sykMe0fjUDPn8UpUrjBUlwqcouXHVq9YjJg5PToNYgXEb4ayGYJfmcwB+mhEjJRHAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=hF4AAInx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="hF4AAInx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789996120;
	bh=Q3DyB+NGw+9JvjJpyqPnaRX8BQWBsWV2/fUz4fZ0JzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hF4AAInxfCog6b0R2jfBsu5AcZxeld1cJg2tAh7nQbbp2UPJfvXIol+4u/zxOsuTq
	 G2Btw97N8TFPPg3p8lcAXVlX4Ws1RT/wTLMHt7ijYNLo5DV97Y1WZVJRZd11TiA6Wv
	 eP3mQk/yh2FBTrMBhvnynVkS3f0CuTA9LhCg6R2lG5kew8fziK3dja/SLdtNMby7sG
	 DMq29UpYeDpCD91u/HQK8g9veOrikvI9D39wLqG3kWEjuJTX6bNtNxTvbzSmKAb7rp
	 aXtPEqNABH51INgehXpfu+EZHlKHE5rOiJ7tUzSblRG0SVeXliGEjBi7vaJqqqRUQt
	 wXb7KsjGKQhyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hpNp60jf6z4w1l;
	Mon, 21 Sep 2026 23:08:29 +1000 (AEST)
Message-ID: <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
Date: Mon, 21 Sep 2026 14:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org> <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com> <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi both,

On 16/09/2026 15:19, Christian König wrote:
> On 9/15/26 16:22, Matt Evans wrote:
>> Hi Christian,
>>
>> On 15/09/2026 12:13, Christian König wrote:
>>> On 9/15/26 09:20, Leon Romanovsky wrote:
>>>> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>>>>> Hi Leon,
>>>>>
>>>>> On 14/09/2026 12:54, Leon Romanovsky wrote:
>>>>>> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
>>>>>>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
>>>>>>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
>>>>>>>>> Expand the VFIO DMABUF revocation state to three states:
>>>>>>>>> Not revoked, temporarily revoked, and permanently revoked.
>>>>>>>>
>>>>>>>> The thing is that "temporarily revoked" is actually the standard
>>>>>>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
>>>>>>>> for VFIO.
>>>>>>>
>>>>>>> I think temporarily revokes here means it is revoked from a dmabuf
>>>>>>> perspective
>>>>>>
>>>>>> My guess is that this is more of a "change owner" operation than a
>>>>>> revoke operation.
>>>>>>
>>>>>> The main issue here is that we have to guess the semantics instead of
>>>>>> having a properly named and documented operation.
>>>>>
>>>>> Apologies if the cover letter for the series and patch commit message (which
>>>>> cover this) are unclear about the motivations and semantics.  On the commit
>>>>> message, can you suggest clarifications:
>>>>>
>>>>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>>>>> ranges previously delegated to a subordinate client process: by
>>>>> revoking, the driver process can ensure that the loaned resources are
>>>>> made inaccessible when the client is deemed "done".  The original
>>>>> DMABUF is defunct, and BAR resources can then be safely re-exported
>>>>> for use by new clients."
>>>>>
>>>>> Given what I'll explain below, do give suggestions please.  There is more
>>>>> context in the cover letter (the volume of which I didn't think appropriate
>>>>> for the commit message).
>>>>
>>>> 1. Do not mix "driver" and "client" in the same description. For a
>>>> non-native English speaker, "driver" has a very specific meaning in the
>>>> context of the Linux kernel.
>>>
>>> In the context of DMA-buf it has also proven vital to clearly use the terms importer and exporter to describe the different roles a driver can have.
>>>
>>> I can't count how often there was confusion because people (me included) just used "driver" and it wasn't clear which role was meant.
>>
>> :)  I see where the quote can be clearer.  FWIW the "driver process" was
>> referring to a userspace driver (which is a legitimate use of the D-word
>> with VFIO, but still).  I'll clarify that, and will indicate this
>> mechanism is used by userspace to influence the VFIO _exporter_ behaviour.
>>
>>>> 2. Explain the lifecycle in the commit message, and why "revoke", which
>>>> is effectively what the importer does, is not sufficient.
>>>>
>>>> 3. The more you put in the cover letter, the less likely people are to
>>>> read it.
>>>>
>>>> 4. Commit messages should describe the patches themselves, since they
>>>> are what remains visible in the git log, unlike the cover letter.
>>>>
>>>> 5. I would call what you describe as "temporarily revoke" is actually "reclaim".

Leon, please see *** below.

>>>
>>> +1
>>
>> I don't follow here, sorry.  Would you please elaborate?
>>
>> Currently VFIO uses the priv->revoked flag to track whether
>> it-the-exporter had previously done dma_buf_invalidate_mappings() on a
>> buffer and is now causing all .attach requests to fail.  Do you mean
>> that (even without this series) you want to call that concept
>> priv->reclaimed instead?
> 
> That sounds like a permanent revoke. 

Not quite; the priv->revoked flag tracks temporary periods of
inaccessibility.  An example is VFIO resetting a function; the BAR
mappings as seen by the CPU and DMABUFs made from the BARs are all made
inaccessible before the reset, and made accessible again after the reset.

>> Or do you mean that you don't like the words "temporary"/"permanent" and
>> are looking for another name for a temporarily unavailable buffer?  (If
>> so, I find "not revoked", "reclaimed", "revoked" much less clear than
>> not/temp/perm revoked, as such names give no hint as to what to expect.
>> But I may have misunderstood what you're getting at.)
> 
> Yeah it's pretty much the naming I would clarify.
> 
> The original idea of notifying the importer that it need to re-create the mapping was resource reclaim.

I feel the (existing) VFIO function reset sequenece is a counterexample,
as the resource isn't being reclaimed/repurposed but users are "held
off" for a period of time across the reset.  (It's then the same
resource that a later access can touch.)

> But when you have some IOCTL or sysfs or whatever to disable a DMA-buf permanently I would call that revoke.

I see where you're coming from now, thanks.

If we were to just call VFIO's "permanently inacessible" state _revoked_
and "temporarily inaccessible" _reclaimed_, then it doesn't help clarity
unfortunately.  Those words are ~synonymous and don't convey permanent
vs momentary.

***

Leon, would you please explain this comment #5?  Were you suggesting
that (even ignoring this patch!) you want to rename priv->revoked to
priv->reclaimed?  If so, why?  (For context, this patch's state =
TEMP_REVOKED is identical to the existing revoked = true.)

In short:  TEMP_${X} vs PERM_${X} most clearly highlights the
meaning/behaviour of the current + new state, regardless of whether
X=REVOKED or X=RECLAIMED.  Although I prefer to use the exisitng
"revoked" I'm not wed to it, but mixing both "reclaimed" & "revoked"
makes the distinction (and semantics, expectations of what can happen
next) much less clear.

> I'm still not 100% sure what a temporary revoke should be. If you have some IOCTL/sysfs/whatever to temporary say to importers "You can't use that resource" then that most likely won't fly.

This patch only provides an ioctl action to "make this inacessible
forever".  There is no direct userspace manipulation to/from the
temporarily-inacessible state, nor need for that.

The only things that lead to a temporary revoke (as a side effect) are
the preexisting VFIO reset ioctls etc.

State is an enum, but this isn't a complex FSM, just an extra "sticky"
state.  And to labour the point, the new temp/perm distinction is only
about VFIO's internal tracking of why it revoked the buffer using the
existing mechanisms (meaning, whether it permits un-revoke); it does not
change the importer.

>> From the importer side, there is no change from this patch: they might
>> observe an invalidate_mappings() and find attach() of a given buffer now
>> fails, same as before this patch.  This is only about guaranteeing the
>> impossibility of an importer ever being able to re-attach in future.
> 
> That sounds reasonable.
> 
> When a resource becomes unavailable you seriously need completely destroy it, re-create it and then import it again into other drivers which want to use it should it ever become available again.

Yep, quite.

Thanks,


Matt

PS: I should've rebased (eyeballed master and didn't spot the tiny
conflict), so no Sashiko review on v6; I want to resolve this for a v7 soon.

> 
> Regards,
> Christian.
> 
>>
>>
>> Thanks,
>>
>>
>> Matt
>>
>>
>> PS:  A hypothetical alternative way of doing what this patch is doing is
>> instead to have:
>>
>>  - existing priv->revoked
>>  - new 	    priv->revoked_flag_is_immutable
>>
>> Then, the ioctl triggers an invalidate_mappings() for a targeted DMABUF,
>> sets revoked = true, and revoked_flag_is_immutable = true.  The new flag
>> prevents a future vfio_pci_dma_buf_move(false) from clearing revoked.
>> For example, a reset doing `move(true); reset; move(false);` can make
>> all DMABUFs available to attach again, except for those marked
>> immutably-revoked.  (That is equivalent to this new "permanent" state.)
>>
>>
> 

