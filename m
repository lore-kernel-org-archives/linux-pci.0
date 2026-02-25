Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010D2BFC7B;
	Wed, 25 Feb 2026 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042469; cv=none; b=JnTNHT3zY7PiNuuat/wE/iiqGxdEF5+zUk0RV1tRXF89ZncrEuoryixUdlvzT63oEp4j2R45B8BvtvLc3jtKpvhnEhVB5pfXcC7zF1jeOZKlvoNr0533ZoXY2XtIauDfZQJZI9J2Fl9MSz/AkJ/mGZWkrUiX153aBRN+WPASaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042469; c=relaxed/simple;
	bh=TFbc+GUeADGuSdjbQmqIPxN+gMoOKkRGcSTStzMjyJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUSFoLSr1YVP/kvSO+traA1Cf2sDE2fQ/nhNLFY3BnVflZynY7PkCpr9bgMe3AdWbI15PYZhgtGXj0KJACKElgXNyV9lMLA0vEcSDve1mz8ivQJkoo2vMAEvd2u+81/DfnejiKn6O4AuBORPBvEGdR9vE+cFk5i2SiPmJr8Tx7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFFA015A1;
	Wed, 25 Feb 2026 10:01:00 -0800 (PST)
Received: from [10.57.58.107] (unknown [10.57.58.107])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162483F62B;
	Wed, 25 Feb 2026 10:00:57 -0800 (PST)
Message-ID: <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
Date: Wed, 25 Feb 2026 18:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
To: dan.j.williams@intel.com, Alexey Kardashevskiy <aik@amd.com>,
 x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
 <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-25 4:30 pm, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
>> SWIOTLB is enforced when encrypted guest memory is detected
>> in pci_swiotlb_detect() which is required for legacy devices.
>>
>> Skip SWIOTLB for TDISP devices.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>   include/linux/swiotlb.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> index 3dae0f592063..119c25d639a7 100644
>> --- a/include/linux/swiotlb.h
>> +++ b/include/linux/swiotlb.h
>> @@ -173,6 +173,15 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>>   {
>>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>>   
>> +	/*
>> +	 * CC_ATTR_GUEST_MEM_ENCRYPT enforces SWIOTLB_FORCE in
>> +	 * swiotlb_init_remap() to allow legacy devices access arbitrary
>> +	 * VM encrypted memory.
>> +	 * Skip it for TDISP devices capable of DMA-ing the encrypted memory.
>> +	 */
>> +	if (device_cc_accepted(dev))
>> +		return false;
> 
> I worry this further muddies the meaning of the swiotlb force option.
> What if you want to force swiotlb operation on accepted devices?

For that we'd need a whole other private SWIOTLB plus the logic to 
decide which one to use in the first place. And if you really wanted an 
option to forcibly expose all DMA through shared memory regardless of 
TDISP and friends, that would logically want to be a higher-level CoCo 
option rather than belonging to SWIOTLB itself ;)

Thanks,
Robin.

> For example:
> 
> @@ -173,7 +176,13 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
>   {
>          struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   
> -       return mem && mem->force_bounce;
> +       if (!mem)
> +               return false;
> +       if (mem->force_bounce)
> +               return true;
> +       if (mem->bounce_unaccepted && !device_cc_accepted(dev))
> +               return true;
> +       return false;
>   }
>   
>   void swiotlb_init(bool addressing_limited, unsigned int flags);

