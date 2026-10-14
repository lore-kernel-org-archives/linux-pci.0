Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7B3C456B;
	Wed, 14 Oct 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010336; cv=none; b=sIigbkiTTcDR/PpkJh7z34NjN3BJRh+Ji4A4JwBJ8MtnAKo8vNqKG82P0mcafJHgWWnpAqnZ2SYwSbz3UOyQl5wqW6MIpuUzG+ljg60Dt3YjagURSEsUVncaOf+WHQaR5jlPm/gFcif+52oaCfUtVmssIwoUUCc6dI6BuSF6MPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010336; c=relaxed/simple;
	bh=Ght/aBzy4llCz6EMP8auv1XpvupCUpViG+bXTIZP3qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO9Liz7qNFshdIVvwzQC680mohIefZqwSsFRfMDVBr/igQuiv8Rprfo5RE9W8SE166DS6Vwr3k4Ozfy4fERqqSu7eCzpJDIpdlkLwwRD9wJAF8OjD8Lk5h2FHUzKoQdxi5vHzv5RNFoG3B2xkGy66wnT9FyqrtqC/qBqo+bKOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=xD7cx5hO; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="xD7cx5hO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1792010330;
	bh=3Terinl8SuwfSYjw1hUDkfwIQWKWVy1NH/KsV7THaRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xD7cx5hOso7zpoKz9w0MCwp2erAQ266sRA3Daej6urcADyMwOfxP0ElO1XJcMp8Pz
	 Ca5m8lKXvuU3U+Y8WCNGSlsbwncz+8686EtyTWM9KihCTuWAqmFoR5uJ3Kumv2xqFR
	 /4dI+G5UnweWCDPPc/MY0UzriL+3nweWEEw8UbVpigliGLmYKn4DgUI2Qr3HbLPFvQ
	 LdfOIb4pAhLoLmgUqXsic+24UWzDlqf+UeIgBBVwisiaqViswaM+78/UTSBbR6gLtY
	 5WpiyBZoyQ7n4vXTuLDKRBeiicDA4B6/UOvyiNIjXMzGMwV1jaqauXA0wPHhXi5/yr
	 ZshaFLBqn0HHw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j4jhy41Mrz4w91;
	Thu, 15 Oct 2026 07:38:41 +1100 (AEDT)
Message-ID: <0bd00c26-4f53-4387-86be-99f0c37fa47c@ozlabs.org>
Date: Wed, 14 Oct 2026 21:38:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-9-matt@ozlabs.org>
 <20261013171347.54e856c7@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20261013171347.54e856c7@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexes,

On 14/10/2026 00:13, Alex Williamson wrote:
> On Tue,  6 Oct 2026 20:36:36 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
>> support for mmap() of this fd.  This provides another route for a
>> process to map BARs, in which the process can only map a specific
>> subset of a BAR represented by the exported DMABUF.
>>
>> mmap() support enables userspace drivers to safely delegate BAR
>> sub-ranges to other processes by sharing a DMABUF fd, without having
>> to share the (omnipotent) VFIO device fd with them.
>>
>> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
>> the existing vm_ops.
>>
>> The lifecycle of an exported DMABUF remains decoupled from that of the
>> device fd it came from, i.e. the device fd could be closed with DMABUF
>> VMAs present, meaning a fault on a VMA could happen concurrently with
>> vfio_pci_dma_buf_cleanup().
>>
>> To deal with this scenario, the fault handler now temporarily takes a
>> VFIO device registration to ensure the vdev remains valid, and then
>> vdev locks can be taken.
> 
> This sounds like potentially measurable overhead if something is
> slamming the fault handler where huge-fault is not supported or active.
> Have you considered a fast path for the internal dmabuf where the
> lifecycle is constrained?

Good question, I did think about this (rationale below) though ended up 
trying to keep this function simpler/easier to reason about.  I can have 
another look.

< long info, as AlexM and I were talking about this offline >

The position of your comment sounds like the device registration was 
part of the concern, but can you clarify please?  I think it's more that
..._fault() now takes dmabuf->resv plus vdev->dmabuf_lock (on top of the 
pre-existing vdev->memory_lock) rather than the device registration. 
The device registration refcount should be cheap (like, not block or 
contend beyond the atomic op), and wasn't the bit I worry about.  :)

The overhead is the single thread "this function does more stuff", plus 
the scenario of threads both concurrently faulting.

What's the baseline/fast path?  With an internal/VFIO mmap DMABUF we'd 
at least need vdev->dmabuf_lock for its status, then the existing 
memory_lock for existing reasons.  But once you have memory_lock then 
(aside from the access cost of the atomic op) the new dmabuf_lock will 
be cheap/uncontended in the absence of a blitz of concurrent exports. 
(Export vs fault is a new performance dependency.)

[ Aside: when adding vdev->dmabuf_lock it occured that we could revisit 
the tests in vfio_pci_vmf_insert_pfn() that require memory_lock, and 
remove that lock from the fault path:  e.g. if we know a DMABUF isn't 
revoked then that implies vdev->bars_revoked = false, and that should 
already be in sync with pm_runtime_engaged, __vfio_pci_memory_enabled() 
...  I haven't traced this all through. ]

The one I worry about more is dmabuf->resv; if there are importers and 
fencing then this'll now hold up behind them.  (But this is only for 
explicit DMABUFs, and feels like the price you pay with P2P.  This won't 
happen for internal/VFIO mmap DMABUFs.)

My gut concern is mostly the straight-line cost of Taking More Locks, 
rather than that they will be hugely more contended in the threaded case 
(where threads will already interfere via memory_lock, and taking 
dmabuf_lock under that is Unlikely to also contend).  Well, and
dmabuf->resv.

But I don't have measurements of this; more complex will obviously cost 
more, though we don't yet know whether it's prohibitive or noise.

I'd rather not split this function before it's a problem, so to speak, 
as it'll be slightly more complicated.  What I'd do:  introduce a flag 
to vfio_pci_dma_buf to indicate "was internal/external export" then use 
this to do extra synchronisation, or avoid it for a VFIO mmap VMA. 
(priv->file != NULL is more or less that, but might be cleaner with a flag.)

Hmm.  I'll hack up a test to try to measure the relative overhead of 
VMA faults before/after (modulo access to meaningful HW).

> Hopefully we can get those selftests included to avoid regressions.

We'll post more tests separately (there're some extra requirements, e.g. 
"real devices"/device access to work through).  The existing tests go 
some way regarding avoiding existing VFIO fd mmap() regressions.  The 
liability of not bringing the DMABUF-mmap tests into this series is just 
on that feature, at least.

If anyone has tested this series (whether to see existing VFIO works, or 
to try the new DMABUF-mmap/revoke) that would be great to know.  AlexM 
and I have some ideas for further testing internally too.

> Overall, I'm not finding too much to pick on in this series, but it
> also hasn't collected much in the way of reviews.  For a fundamental
> change like this, I hope we can get more eyes on it.  Thanks,

I'm glad, I feel it's in a good state now.

100% agree needs more eyes.  FWIW Kevin and Praan reviewed ~all of v5, 
though I dropped their R-Bs because all of the patches have in some way 
changed.  (Though most of the changes are very small, am a stickler for 
process.)  Please, if they or others have time for another pass... <:-)


Many thanks,


Matt

