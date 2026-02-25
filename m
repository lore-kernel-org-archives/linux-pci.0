Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E2399016;
	Wed, 25 Feb 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038134; cv=none; b=TwUqUPK/p83Er8KI8OBv7O5aYG2LZk98WjvZZ+7b5bSCVcxDOfmoZnUCX6LZW7ZfX7Y0gPTp+2yAc0rU8u2dFy+VWWb7xyibtK6UQw/+3p9X6Eo0R0oC2R69fM7LVc1mckG/kYjNX1d4FNkfAu90XEpWhERIJH4OHsQgbjMu1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038134; c=relaxed/simple;
	bh=r5gGFSVYhvJcPkljV7V4evIL4PFLXO1KiDhxZ5xgajY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPyx6MqX7secVsZ2o6bwFVMglmAuQf2fzqB6dlDimlF7yGGJjslMt8ZHebKrg/i73M2dhFMvYeMvsLjMeamMMqXZVAfkO1zzkvO9O9keTxGJOjfXVpxb+0n5xTW/3M4tiCr1QbgYMycjFQXg2wNWVlTySLaxeigAi0DJEUWSiRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F9B165C;
	Wed, 25 Feb 2026 08:48:46 -0800 (PST)
Received: from [10.57.58.107] (unknown [10.57.58.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530033F73B;
	Wed, 25 Feb 2026 08:48:41 -0800 (PST)
Message-ID: <5c7397b5-0368-4bd7-af5a-e513f289c775@arm.com>
Date: Wed, 25 Feb 2026 16:48:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
To: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Melody Wang <huibo.wang@amd.com>,
 Seongman Lee <augustus92@kaist.ac.kr>, Joerg Roedel <joerg.roedel@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Denis Efremov <efremov@linux.com>, Geliang Tang <geliang@kernel.org>,
 Piotr Gregor <piotrgregor@rsyncme.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Kim Phillips <kim.phillips@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
 iommu@lists.linux.dev
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-5-aik@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260225053806.3311234-5-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-25 5:37 am, Alexey Kardashevskiy wrote:
> SWIOTLB is enforced when encrypted guest memory is detected
> in pci_swiotlb_detect() which is required for legacy devices.
> 
> Skip SWIOTLB for TDISP devices.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>   include/linux/swiotlb.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..119c25d639a7 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -173,6 +173,15 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>   {
>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   
> +	/*
> +	 * CC_ATTR_GUEST_MEM_ENCRYPT enforces SWIOTLB_FORCE in
> +	 * swiotlb_init_remap() to allow legacy devices access arbitrary
> +	 * VM encrypted memory.
> +	 * Skip it for TDISP devices capable of DMA-ing the encrypted memory.
> +	 */
> +	if (device_cc_accepted(dev))
> +		return false;

This seems backwards - how does it make sense for arch code to force 
SWIOTLB globally on the grounds that all DMA must be to shared memory, 
but then generic code override that because it claims to know better?

I'd expect to see something more like:

	if (is_cc_platform && !device_cc_accepted)
		return true;

here, and then get rid of the rest of the (ab)use of SWIOTLB_FORCE for 
this purpose entirely.

However there is the fiddly aspect that it's not necessarily strictly 
enough to just un-force SWIOTLB; we really want to actively ensure that 
no private memory can *ever* end up getting bounced through a shared 
SWIOTLB buffer. The private/shared state is really a property of the 
individual DMA mappings, though, rather than an overall property of the 
device itself (since a device that's trusted to access private memory 
isn't necessarily prohibited from still also accessing shared memory as 
well), hmmm...

Thanks,
Robin.

> +
>   	return mem && mem->force_bounce;
>   }
>   

