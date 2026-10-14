Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B49503BD8;
	Wed, 14 Oct 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001159; cv=none; b=DncmT+8BLC9bsdOXCj49L7uEq9ug+Ik+/eXxRnfNcoT+zYZKCxGE/tqizgBI0RzTPpMN6Os5EQOBQqZqvZwdJZ0qSZHO8GtOUV5IP8qG6jm5/lM8ta+ZOP2WBGp1D7MSUYeCpbX+ak2xmSBj5Fb10/qVRe1DFVDUHSYh6XeXy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001159; c=relaxed/simple;
	bh=fQn3+84evWcFw8/01U6Ysd+ty6z5WK2oUtlPCaRstQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSja7xCAk10ELN4H5BqpmlUQ/ceUi3bK/gvGY1Glq6+XrKH14pgtZvTrE39AlOyAGfMwwLfiPOhPhw7ATCsLP4AJqlZf3RYdmoN3LaKy6zeXZ/lf/u4ZumCQtAqC9MGaZhfR3JRp/KOPqJ1Bmey6l1PEYi5gEljznOjgT+i5BR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=HhdSgVuZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HhdSgVuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1792001154;
	bh=A/YfHX/3fZumK9vHo0wbkd9nVZibQ7MqdJzxO23iME4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HhdSgVuZBt417lj3wDa1A+PxkTvAr5bXI0LE/oI7VfZxn5COesZJa5cfaQFFWKpfj
	 5hfIQqivjglbjEMEwsCSUbSqRxldmtac296JYUBKBGnv51kf318CoSJMYiwslBJ3mr
	 8mHhJ0saap1EuUqZttcj2x3T3hNno+DL7tmkT1FnQxY3WfK2CD6zya/j2vCtCMUhLn
	 306i4dWpRYJW/1DHqUwJYlv9Stmrqw2SC+rTClTAEAE+QPRFopgymrduAyUBIKRpAv
	 Mls9PON2h6YvKoz9d6WupX1Gwf8M1e+ycgRsW1nMRyb+kHhXSBXZao2pbbC0TxMLVL
	 WwzZM7cP9gkSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4j4fJT5wqSz4wCt;
	Thu, 15 Oct 2026 05:05:45 +1100 (AEDT)
Message-ID: <20051ac9-43d0-4143-88fe-1198ebb6383e@ozlabs.org>
Date: Wed, 14 Oct 2026 19:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-2-matt@ozlabs.org>
 <20261013171416.40b00e73@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20261013171416.40b00e73@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 14/10/2026 00:14, Alex Williamson wrote:
> On Tue,  6 Oct 2026 20:36:29 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> The VFIO_DEVICE_FEATURE_DMA_BUF export previously used
>> vdev->memory_lock to protect VFIO's list of exported DMABUFs
>> (vdev->dmabufs) and their revocation status.  When adding a new
>> export, memory_lock was taken for write.
>>
>> A future commit will refactor DMABUF export into a function used from
>> mmap(), which would create a new mmap_lock -> memory_lock dependency.
>>
>> In preparation, this commit introduces a vdev->dmabuf_lock that
>> protects the dmabufs list, per-DMABUF revocation state, and a new
>> bars_revoked flag.  The flag tracks the device-wide BAR revocation
>> state set via vfio_pci_dma_buf_move() under dmabuf_lock, removing the
>> test of __vfio_pci_memory_enabled() and dependency on
>> vdev->memory_lock.
> 
> There's a subtle change here that I'm not sure is worth mentioning, so
> I'll at least put it on the list for posterity.  The initial revoked
> state of a newly minted DMABUF is now governed by the device-wide BAR
> revocation state set via vfio_pci_dma_buf_move().  This is subtly
> different from the current behavior where the initial state is based on
> instantaneous BAR accessibility tested under vdev->memory_lock.  Thanks,

Yes right, that's good to capture here.

The new lifecycle is then _only_ coupled to the revocation state both 
(with this patch) at creation time and (already) thereafter.

We sorta have two mechanisms to track "BARs accessible", via 
__vfio_pci_memory_enabled() and the changes initiated by 
vfio_pci_dma_buf_move() (which already exist, but the new
vdev->bars_revoked flag now tracks).  They shouldn't really differ, i.e. 
a BAR is accessible or not (whether by CPU or P2P) and we should clean 
this up in future.  In this patch, creating it from the bars_revoked
state makes the state consistently set from one place, at least.

Cheers,


Matt


> 
> Alex
> 
>> This is a cleanup currently, but allows the future export path to
>> avoid holding memory_lock under mmap_lock and a therefore avoid a
>> deadlock scenario (a fault handler attempting to take mmap_lock in a
>> vfio-pci variant driver thread that holds memory_lock, vs another
>> thread doing an mmap/export holding them both in the other order).
> 

