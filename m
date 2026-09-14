Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E0446066;
	Mon, 14 Sep 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388046; cv=none; b=U6TCtJlAsAEt5SA+cva1BEAdheTQnmqN5kiz3pkSHvj5Q56LyfPNIgWUoWKbAPcKy4V1AkAuVdUhwaXB35Gqqcr1OBPKhWV5fIxfrfVWDTztDIP+hlfdZ9FOX182y0XGUROc9voM5F9axDcWThPcxcs0nySkWTaS2EjYBFMQJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388046; c=relaxed/simple;
	bh=KQcD7ybHb9EH/g4an3ybWreK7NtJgH39BxZcqpEasco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9ooz3KsptR0/hqH+JicKanqr+fdV91c5ogNBVOCvF4RqXZyfHK0aYAmep9KClIdDwUT+Er6pXIlIowtLUhbRut3jPKXCFSEJcV9ubjjuKZd8FwfJeJUNJ6tzM47m3IG4w+YwvQ5ptX5ugY2B59QRaWMm2w380zOY6pu7V3Njlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=HvuVKhwL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HvuVKhwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789388026;
	bh=+Z+8q8Y7PKeF8cylK/vBWxaeMrcPKioUqaIkfs3jFUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HvuVKhwLt4XaqqjwXFMayGAETLjfAb0T6qgAsd5l5uEC3/JqEtlr0aAz4ivLNFa1Q
	 wN4+/9SSD79HoN4yRs7FCMbuuSiwFqdH4pID3QJLrsKxWaCKsTY+RqwN5RkdHhyq8E
	 OicCblvD2Wqp94izGrep+3isQFnBaj3srrSlFyTi+Jc/tdKV6zXSiZPmgVNgaJnThy
	 izhURc9OKgEWeGg+gE94ntmeKIgZhzOTeTGvvQHpyHMDS1kqe7PTTU8KxEMSwV5riN
	 Giu6X14a6b6Yy65cd7Meu40vCGmNDBbGgl1DGktAloM2QwFO65216KWYY/mySrSirz
	 JqVYXxt1c1C0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hk3w060kMz4wKF;
	Mon, 14 Sep 2026 22:13:36 +1000 (AEST)
Message-ID: <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
Date: Mon, 14 Sep 2026 13:13:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
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
Content-Language: en-GB
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260914115456.GY13683@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon,

On 14/09/2026 12:54, Leon Romanovsky wrote:
> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
>>>> Expand the VFIO DMABUF revocation state to three states:
>>>> Not revoked, temporarily revoked, and permanently revoked.
>>>
>>> The thing is that "temporarily revoked" is actually the standard
>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
>>> for VFIO.
>>
>> I think temporarily revokes here means it is revoked from a dmabuf
>> perspective
> 
> My guess is that this is more of a "change owner" operation than a
> revoke operation.
> 
> The main issue here is that we have to guess the semantics instead of
> having a properly named and documented operation. 

Apologies if the cover letter for the series and patch commit message 
(which cover this) are unclear about the motivations and semantics.  On 
the commit message, can you suggest clarifications:

"This is useful for lifecycle management, to reclaim VFIO PCI BAR
ranges previously delegated to a subordinate client process: by
revoking, the driver process can ensure that the loaned resources are
made inaccessible when the client is deemed "done".  The original
DMABUF is defunct, and BAR resources can then be safely re-exported
for use by new clients."

Given what I'll explain below, do give suggestions please.  There is 
more context in the cover letter (the volume of which I didn't think 
appropriate for the commit message).

> As Christian pointed
> out, the patches describe what they are doing well, but they do not
> explain why they are doing it.

His comment may be warranted on the other, new, patch for DMABUF name, 
but I don't think this applies here.

>> Just that VFIO can make it's internal dmabuf work again, there won't
>> be a notification to any importer or an expectation that something
>> like iommufd will re-establish mapping automatically.
>>
>> This is principally a kernel self protection mechanism where the
>> userspace was expected to have removed the dmabuf before issuing a
>> reset/etc. If they didn't then the kernel plonks it and userspace gets
>> a mess to clean up.
> 
> Revoke/invalidate means that the importer should stop accessing the
> buffer provided by the exporter. It does not specify what the exporter
> should do afterwards.
> 
> So I still think that "temporarily revoked" is closer to
> invalidate_mappings, with some additional dma-buf documentation to lose
> the expectation that the buffer will become available again.

You are right in indicating in your previous email that the "temporarily 
revoked" state is the old "revoked" state.

 From the DMABUF importer interactions, there's _still_ only "revoked or 
not revoked" state.  No changes there.

 From this VFIO exporter's perspective, the change is to add a "sticky" 
revoked state.

The thing (as per UAPI docs, again I hope there's no guessing needed) 
that the new third state gives is that a) userspace can explicitly 
request it via the new ioctl/feature, and b) it is guaranteed not to be 
spuriously or intentionally undone by anyone else.

E.g. reset:  temporarily revoke, then un-revoke.   New ioctl: 
permanently revoke, such that something like a subsequent reset isn't 
going to undo it and make the DMABUF usable again.

The usage scenario is:

1. Process A exports DMABUF from VFIO device.  (Proc A is the 
"orchestrator" here.)
2. Process A sends fd to process B.
3. Process B maps it, or hands it on, etc.
4. Process A eventually decides the buffer is finished with/lifecycle 
done/wants to reuse that BAR range for something else.  It permanently 
revokes the DMABUF.
5. Hopefully this isn't a surprise to B (some cooperation has given it 
up first) but either way, B now cannot access the BAR range anymore. 
This does not _need_ cooperation, so if B becomes malicious, or crashes, 
etc. A can still revoke it.
6. That BAR range is reused for something unrelated.


HTH,


Matt

