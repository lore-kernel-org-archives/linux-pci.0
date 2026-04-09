Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AD3BB4A;
	Thu,  9 Apr 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720038; cv=none; b=GyXnthK9wIb8eTWUEHjQK7uYhw+zAjexHA6uSgeBEQsysX6mVH7qZUikS/wYNVtFQlcljVSloLRed2uN+OglnhgLdocLf2vwyBRfd8XEtu00wyguqSH+mbwHJJHb5yHE15aSybIb2YhIdJ0zH7vd1Gy+6fdqpM/drdscGqq5K/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720038; c=relaxed/simple;
	bh=QhVx3L6aXJNugOTgpy3aa3tMsZKk7Hb1Lu9fiYhDPfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fz4aqGZKCX0CfE3TqmIePD0YQm70SAVjuqBDsxI6e8UAzPD58WbL0zx5PXyZg4KtarqkXsAg0Nj3amy21blzgIGGxq5H81F0dnFgban6e6/oHZuce+eVMD+RzZOdTDZnu28rKHkYmZU8BwHzqXhZNVHefi5a9VRnP80ZbeVgwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKsjM6Wl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKsjM6Wl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE45C4CEF7;
	Thu,  9 Apr 2026 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775720038;
	bh=QhVx3L6aXJNugOTgpy3aa3tMsZKk7Hb1Lu9fiYhDPfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iKsjM6WldsGYaBiMhmof3lMizjISd5nKoLZ7uMPDPVHfwdnmciDvvH6Vu1ntKYoM2
	 vIDZpLeCtxKefgzRQ3bVej9YfYEIHusoit+cCpQCOTpuzjB2W1V2WvO5Dz5z1xU6d5
	 iYOCKBa4etkoYMJJV7z9b1aKbbN8DGKMwUg2wpEShYhGHcsTzv/7U/O1/psyLVZUy+
	 /OzbICv4Ml+vCys7S05Fh8bWthwGtMiy2MJr/WFEOI/JBh+3XRqobhfkcxqYgqK1pq
	 xS6ka22yv5B2POuXWj56wB2hxmdwyKLsuBX1dUy8ynMltIDeYiGupqPgkA2JyPgM5F
	 nwDJRASKL6M3w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 10/19] x86, swiotlb: Teach swiotlb to skip "accepted"
 devices
In-Reply-To: <20260303000207.1836586-11-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-11-dan.j.williams@intel.com>
Date: Thu, 09 Apr 2026 13:03:48 +0530
Message-ID: <yq5aika08u5f.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> There are two mechanisms to force SWIOTLB operation, the kernel command
> line option and the internal SWIOTLB_FORCE flag. With the arrival of
> "accepted" devices, devices that have been enabled to DMA to private
> encrypted memory, the SWIOTLB_FORCE flag is an awkward fit. It may be the
> case that SWIOTLB operation wants to be forced regardless of the device
> acceptance state.
>
> Introduce a new SWIOTLB_UNACCPTED flag that allows for both augmenting the
> result of is_swiotlb_force_bounce() dynamically and allowing for an "always
> SWIOTLB" override.
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/swiotlb.h   | 15 ++++++++++++---
>  arch/x86/kernel/pci-dma.c |  2 +-
>  kernel/dma/swiotlb.c      |  1 +
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..0efb9b8e5dd0 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -17,6 +17,7 @@ struct scatterlist;
>  #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
>  #define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
>  #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
> +#define SWIOTLB_UNACCEPTED (1 << 3) /* swiotlb for unaccepted devices */
>  
>  /*
>   * Maximum allowable number of contiguous slabs to map,
> @@ -91,6 +92,7 @@ struct io_tlb_pool {
>   * @nslabs:	Total number of IO TLB slabs in all pools.
>   * @debugfs:	The dentry to debugfs.
>   * @force_bounce: %true if swiotlb bouncing is forced
> + * @bounce_unaccepted: %true if unaccepted devices must bounce
>   * @for_alloc:  %true if the pool is used for memory allocation
>   * @can_grow:	%true if more pools can be allocated dynamically.
>   * @phys_limit:	Maximum allowed physical address.
> @@ -109,8 +111,9 @@ struct io_tlb_mem {
>  	struct io_tlb_pool defpool;
>  	unsigned long nslabs;
>  	struct dentry *debugfs;
> -	bool force_bounce;
> -	bool for_alloc;
> +	u8 force_bounce:1;
> +	u8 bounce_unaccepted:1;
> +	u8 for_alloc:1;
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	bool can_grow;
>  	u64 phys_limit;
> @@ -173,7 +176,13 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
> -	return mem && mem->force_bounce;
> +	if (!mem)
> +		return false;
> +	if (mem->force_bounce)
> +		return true;
> +	if (mem->bounce_unaccepted && !device_cc_accepted(dev))
> +		return true;
> +	return false;
>  }
>  
>  void swiotlb_init(bool addressing_limited, unsigned int flags);
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..8a737f501ae5 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -61,7 +61,7 @@ static void __init pci_swiotlb_detect(void)
>  	 */
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>  		x86_swiotlb_enable = true;
> -		x86_swiotlb_flags |= SWIOTLB_FORCE;
> +		x86_swiotlb_flags |= SWIOTLB_UNACCEPTED;
>  	}
>  }
>  #else
>

I guess we can also include arm64 change here
modified   arch/arm64/mm/init.c
@@ -335,7 +335,7 @@ void __init arch_mm_preinit(void)
 
 	if (is_realm_world()) {
 		swiotlb = true;
-		flags |= SWIOTLB_FORCE;
+		flags |= SWIOTLB_UNACCEPTED;
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {

-aneesh
