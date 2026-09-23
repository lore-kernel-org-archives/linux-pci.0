Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAA497B77;
	Wed, 23 Sep 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178023; cv=none; b=S2ZeFX7SZyAEjmOCYAfC+yo3iySgN1hmMqiSZLzGTouXEd76Z0HChQ6BHndQVBYuMp9oFoQK9FHazyiJL69SFMPxYAfb72IPR+4rkmn9rHVuyuz7I6ri9HvxFi64KNq/ZtFIp8Vhtq2KR8AKWScIAlJD00fP/Xz5hrxhPvaipWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178023; c=relaxed/simple;
	bh=+Q1bN+lyJlgwEwcCF9Qz+L2nU4YyCQhZD63+cNDqjPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFvSSbVBdgtkvJZdondXmTR8mHyCh4Z8P2o+lI10ZsSJhU29WMZw2B/NLk0zzxPMjCKSwChIdATpA719G1lWe20xHXjNALJOBZJPot5iNnx360aUJ8ZnlQHfHEzvLxLcGe/446AVB0lkoV+NVAUbAffrZVrTJPc0yX1y6kOhM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=iyouXx+j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="iyouXx+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790177995;
	bh=Pvf6utvFFy4W0lCvpXIM2zHVFitTH88Hp81cFrCEahk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iyouXx+jA+xaknvK7tvNx3mfKFDu+72K2NrM6eeU4LF9DV+5VmxR22njJv9A7ic32
	 bpNrdkvN6fL6lSIbBbYw3RNdTNIS8ieRpSodoWhuihAzFUk8/aq3S/HUEL8oCGzgv4
	 niaLMPC+ek5SV3Co7KUa7/WQUjPRnoUaZbiVOT+aR86tS2G597vqecgjH40IEr/Xb6
	 CDZOmWouOW8shnBSWJX3pR2mD924McGg0K7uN+0dfJd6HcN4qMu6JasI++X8HnhEoc
	 GAZbz9kWvywsowbJHsC0vIv2y9+zsNzzvY5IKL4wCH4gSfF680v/yoMzXkER24E7a3
	 hYyHIuiVmYJeg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hqh3h1tlnz4wB5;
	Thu, 24 Sep 2026 01:39:43 +1000 (AEST)
Message-ID: <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
Date: Wed, 23 Sep 2026 16:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
References: <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com> <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260922225747.GB2545495@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason, Alex,

On 22/09/2026 23:57, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2026 at 03:31:07PM -0700, Alex Mastro wrote:
> 
>> So I empathize with Matt's contention that the _existing_ behavior that the
>> priv->revoked flag represents is actually "temporarily revoked": the importer
>> can use the same dma-buf again, later, without having to re-import
>> it!
> 
> mlx5 isn't a revoking importer, it is move capable. So the above
> sequence isn't a revoke, it is a move with an unmapped placement for a
> while.
> 
> This is why "temporarily revoked" is a confusing phrase.
> 
> The API is such that move and revoke importers can co-exist like this
> but they experiance a different version of things..

Ahhhhh.  That was very helpful (esp. to contrast with the previous
iommufd statement about invalidate_mappings being permanent), thank you!

So the worry was that the VFIO DMABUF's temp/perm state could be
misconstrued as an implication/guarantee about the future availability
of that DMABUF to importers, OK.  And we want the existing move(false)
behaviour still, for dynamic importers that treat it as a move.

> We probably should not have made it have this move compatible
> restoration and had things more consistent. User space can't know if
> the importer is move capable or not so it has to assume revoke and it
> has to go and unmap things before resetting/etc.
> >> This series doesn't intend to change the behavior of either. Is the
confusion
>> about whether the current behavior is intentional and/or desirable? If the
>> answer to both is "no", then IMO this series paves the way nicely towards making
>> PERM_REVOKED the only supported semantic later.
> 
> Right, I think the only concern is language.
In that case, the VFIO-internal tracking could be:

 priv->status = VFIO_PCI_DMABUF_OK;      /* was priv->revoked = false */
 priv->status = VFIO_PCI_DMABUF_REVOKED; /* was priv->revoked = true */
 priv->status = VFIO_PCI_DMABUF_DEAD;

The latter means that an invalidate_mappings was performed (due to a new
userspace ioctl trigger), and that all future dma_buf_*attach() attempts
must fail.  I'd add a comment to explain this clearly in the enum.

If that's too macabre, DEFUNCT?  (A word implying guaranteed
permanence...).  The userspace action causing all this can IMHO be
called REVOKE still; it's what it does.  (I'll clarify the observable
effect from the POV of an importer in the UAPI.)

WDYT?


Matt

