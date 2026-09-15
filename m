Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B12353A9E;
	Tue, 15 Sep 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482152; cv=none; b=ay5i00VD+uI6V+WPmuizLCmgZgMZrB3+aNOx3nFJ9Y526lh1yLgJabDKviq9EnB7KtEfp45jm208hsUlDnT6WgrcJ+ppRzCEUZEWPkHMLRM/5zlGI4PUKHIVaOmiHPvPwrjeDctHh/P2MAhJ/GwAa0t+JWwitmBbHosDOlAVHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482152; c=relaxed/simple;
	bh=50Y72TPeowVtAS93/+EgvbkaawHnyaQmBAfcNUWNtTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhFL5P6UVt7O7Om97Na74g+kZK+1lOGYrE7xgVPrA+i2Rj1tGN4v9KhG57J+AnSXBKCQHMrjqcw7Z/u5jUEJCKaN59wO8Emb2qDS81tDmXBnq+w1bu3OPqjMJNFAsBJOfzSQABSHBFjOFVQooZwN5XVXcRm4SFbuOErk5kkburs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=J/EKm1ot; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="J/EKm1ot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789482131;
	bh=JcYucMj7YIbG7YaZWu+7otPfMtUjjyXpiltn2C04Tx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J/EKm1otMfFKpLh1PMEA5saa7JQdSg4AJVshyxdLAEnaGKCexNlkLev4zNTxsg8Sb
	 JPwQWgSRB41i2QlSjocGmOuLYbG3D4Ii0QeNP9g3bk0MpyHRHUoHlP8orPF2g35Nsj
	 gfCsz8XV3vEZrmklDGVJR2fRf32OWFCFZPcQZnCQkWVkSKGOp7DRGUzzG7AnpbW+dZ
	 D3KvumOsoVAH1lbqKLeTbZLvrMV9u23RY0yA4z6H/n8Y9yuCSNvwQFSXUrs4OXmU09
	 hRpdmORwQMFPhDENDw33JvIOiXCNqNyFDnqaiNq2rYl527WkycAv5bk2nJGLoSOrvT
	 b3ugaKI7D85tA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hkkjl53dyz4wV0;
	Wed, 16 Sep 2026 00:22:03 +1000 (AEST)
Message-ID: <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
Date: Tue, 15 Sep 2026 15:22:16 +0100
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
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christian,

On 15/09/2026 12:13, Christian König wrote:
> On 9/15/26 09:20, Leon Romanovsky wrote:
>> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>>> Hi Leon,
>>>
>>> On 14/09/2026 12:54, Leon Romanovsky wrote:
>>>> On Mon, Sep 14, 2026 at 08:36:47AM -0300, Jason Gunthorpe wrote:
>>>>> On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
>>>>>> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
>>>>>>> Expand the VFIO DMABUF revocation state to three states:
>>>>>>> Not revoked, temporarily revoked, and permanently revoked.
>>>>>>
>>>>>> The thing is that "temporarily revoked" is actually the standard
>>>>>> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
>>>>>> for VFIO.
>>>>>
>>>>> I think temporarily revokes here means it is revoked from a dmabuf
>>>>> perspective
>>>>
>>>> My guess is that this is more of a "change owner" operation than a
>>>> revoke operation.
>>>>
>>>> The main issue here is that we have to guess the semantics instead of
>>>> having a properly named and documented operation.
>>>
>>> Apologies if the cover letter for the series and patch commit message (which
>>> cover this) are unclear about the motivations and semantics.  On the commit
>>> message, can you suggest clarifications:
>>>
>>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>>> ranges previously delegated to a subordinate client process: by
>>> revoking, the driver process can ensure that the loaned resources are
>>> made inaccessible when the client is deemed "done".  The original
>>> DMABUF is defunct, and BAR resources can then be safely re-exported
>>> for use by new clients."
>>>
>>> Given what I'll explain below, do give suggestions please.  There is more
>>> context in the cover letter (the volume of which I didn't think appropriate
>>> for the commit message).
>>
>> 1. Do not mix "driver" and "client" in the same description. For a
>> non-native English speaker, "driver" has a very specific meaning in the
>> context of the Linux kernel.
> 
> In the context of DMA-buf it has also proven vital to clearly use the terms importer and exporter to describe the different roles a driver can have.
> 
> I can't count how often there was confusion because people (me included) just used "driver" and it wasn't clear which role was meant.

:)  I see where the quote can be clearer.  FWIW the "driver process" was
referring to a userspace driver (which is a legitimate use of the D-word
with VFIO, but still).  I'll clarify that, and will indicate this
mechanism is used by userspace to influence the VFIO _exporter_ behaviour.

>> 2. Explain the lifecycle in the commit message, and why "revoke", which
>> is effectively what the importer does, is not sufficient.
>>
>> 3. The more you put in the cover letter, the less likely people are to
>> read it.
>>
>> 4. Commit messages should describe the patches themselves, since they
>> are what remains visible in the git log, unlike the cover letter.
>>
>> 5. I would call what you describe as "temporarily revoke" is actually "reclaim".
> 
> +1

I don't follow here, sorry.  Would you please elaborate?

Currently VFIO uses the priv->revoked flag to track whether
it-the-exporter had previously done dma_buf_invalidate_mappings() on a
buffer and is now causing all .attach requests to fail.  Do you mean
that (even without this series) you want to call that concept
priv->reclaimed instead?

Or do you mean that you don't like the words "temporary"/"permanent" and
are looking for another name for a temporarily unavailable buffer?  (If
so, I find "not revoked", "reclaimed", "revoked" much less clear than
not/temp/perm revoked, as such names give no hint as to what to expect.
But I may have misunderstood what you're getting at.)

From the importer side, there is no change from this patch: they might
observe an invalidate_mappings() and find attach() of a given buffer now
fails, same as before this patch.  This is only about guaranteeing the
impossibility of an importer ever being able to re-attach in future.


Thanks,


Matt


PS:  A hypothetical alternative way of doing what this patch is doing is
instead to have:

 - existing priv->revoked
 - new 	    priv->revoked_flag_is_immutable

Then, the ioctl triggers an invalidate_mappings() for a targeted DMABUF,
sets revoked = true, and revoked_flag_is_immutable = true.  The new flag
prevents a future vfio_pci_dma_buf_move(false) from clearing revoked.
For example, a reset doing `move(true); reset; move(false);` can make
all DMABUFs available to attach again, except for those marked
immutably-revoked.  (That is equivalent to this new "permanent" state.)


