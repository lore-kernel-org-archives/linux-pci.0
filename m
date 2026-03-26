Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD838F929;
	Thu, 26 Mar 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527155; cv=none; b=NV0tD3W3TzSBmruG7AbY2QQ0LPPGg/kVktQnIq8ep5kp9PX7u/1S/vf3/spMNnu7PmrC7fKm68oNQ6xLxiM+DJKUdgNLzzBw6hJz5MY8OQ0gSWKST2kwNkFkzSBVNdnSlZ6wMdLmpf5280wLnFMxaG4d/kQsHbnQ25bjfEqZspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527155; c=relaxed/simple;
	bh=6As1ZJhRb6x/u6Cg+5qyJyDZ4Vf0rF/ZKNt30A1fiyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8rT6stg4/QdE1zqh3Zg4su7/1eUGwnw4aRKtw27WogW6RTQHagx19ZAdjbMD33P8ZH4ocqy9iUC4fDxGMMq3IuxhfoLKInQ44gHO5XC2yyAc8121FsE3D/vtd6Dv5ghTDf4shWjRVnfSH5lWeNwtfNKqmdKNZaX00qVoXygxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gVaqCYgZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gVaqCYgZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447AE175A;
	Thu, 26 Mar 2026 05:12:26 -0700 (PDT)
Received: from [10.57.76.165] (unknown [10.57.76.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610813FB90;
	Thu, 26 Mar 2026 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774527152; bh=6As1ZJhRb6x/u6Cg+5qyJyDZ4Vf0rF/ZKNt30A1fiyw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gVaqCYgZO1uxxmDGD4aysfodjBovNgwu1wU9wJxLST0oWxuZMUOsSi+/JpGuT15Jz
	 3umGGUJXw6pVkNSKbuG4eRxKEdwy3orLraH/MOzDbyduXr1TVLBCrU1LV5Ru92WC5Y
	 OabO5hrBTNZXV2z7AYQyCNhkOl7xImeznOXMgppw=
Message-ID: <ee49dea1-96f6-4991-8095-6920ed88585e@arm.com>
Date: Thu, 26 Mar 2026 12:12:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
To: Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, iommu@lists.linux.dev
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
 <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
 <acQTxJ75lq4tkszi@ryzen>
 <i4jgdqzliz2mae6jnl5pycasjy4h5x27negpxdxabhu7so7vcs@mvk6qbkw3j7r>
 <acUDdigoIj_uusgI@ryzen> <acUJgChL1hypb6ei@ryzen>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <acUJgChL1hypb6ei@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-03-26 10:25 am, Niklas Cassel wrote:
> On Thu, Mar 26, 2026 at 10:59:26AM +0100, Niklas Cassel wrote:
>> On Thu, Mar 26, 2026 at 05:49:13PM +0900, Koichiro Den wrote:
>>>>
>>>> The transaction is a write from
>>>> PCIe bus -> PCIe controller iATU -> internal bus -> IOMMU -> PCIe controller
>>>> (the same controller as initiated the transaction).
>>>
>>> Yes, I think we're on the same page about this path itself.
>>>
>>> On my R-Car S4 setup, changing this to DMA_TO_DEVICE consistently triggers an
>>> IOMMU fault, so at least on this platform the local path used for the doorbell
>>> mapping is IOMMU-visible. That is the case this dma_map_resource() is intended
>>> to cover.
>>>
>>> For that path, my understanding is that the doorbell access ends up as a local
>>> write on the EP side, so it needs write permission, hence DMA_FROM_DEVICE.
>>>
>>>> Would be interesting why this is not working like normal (when using buffers):
>>>> "For Networking drivers, it’s a rather simple affair.
>>>> For transmit packets, map/unmap them with the DMA_TO_DEVICE direction specifier.
>>>> For receive packets, just the opposite, map/unmap them with the DMA_FROM_DEVICE
>>>> direction specifier."
>>>
>>> I think the closer analogy is RX: the data comes from outside, but the device
>>> writes to the target, so it needs write permission.
>>
>> I think it is from the PoV from the IOMMU, is the transaction a Read by a device
>> or a Write by a device?
>>
>> For a NIC driver:
>> For a RX packet, the data is coming from the device to the memory.
>> device is doing a transaction to memory.
>> For a TX packet, the data is going from the memory to the device.
>>
>> In our case, the data is coming from the device, to a device.
>>
>> Almost like a P2P DMA, but in our case, both devices are the same, so
>> using the P2P DMA API like pci_p2pdma_add_resource() seems unnecessary.
>>
>> So should it be DMA_BIDIRECTIONAL ? :)
>>
>> I understand that for the R-Car S4 Spider IOMMU, it is sufficient to map
>> it as DMA_FROM_DEVICE. I just want to be sure that on some other IOMMU,
>> they might consider it sufficient to map this as DMA_TO_DEVICE (because
>> it is also a transaction going to a device).
>>
>> I just want to make sure that the code works on more than one IOMMU.
>>
>> Perhaps some IOMMU experts could help chime in.
>>
>>
>> Note that I am happy to merge the code as is, as it obviously works on the
>> only platform that this has been tested on (R-Car S4 Spider), and if other
>> platform tries to run this test case, if their IOMMU works differently, it
>> will scream and they will report it to the list. So all good.
>>
>> I'm mostly want to know how the DMA-API is supposed to be used in this
>> specific scenario (device doing a write transaction to the same device).
> 
> I guess if a device will be reading or writing from this IOVA that is
> created by IOMMU by the dma_map() call...
> 
> The device will only be writing to this IOVA.
> The device will never be reading from the IOVA (since the physical address
> is a register in the device itself, we will never supply this IOVA for the
> device to read from).
> 
> DMA_FROM_DEVICE seems correct in all cases. DMA_BIDIRECTIONAL seems wrong
> since the device will never read from this IOVA. Sorry for the noise.

DMA_FROM_DEVICE means the device will be sending write requests to the 
address; DMA_TO_DEVICE means the device will be sending read requests to 
the address; DMA_BIDIRECTIONAL means the device might send either or 
both. Never does the *address* try to pull or push data anywhere of its 
own accord, regardless of whether it's RAM or MMIO or whatever. Hence 
why we don't have or need DMA_{TO,FROM}_MEMORY either ;)

Indeed if the endpoint controller could somehow recognise that an 
incoming write was a "doorbell" write based on the incoming BAR offset 
and internally short-circuit that to directly raise its own interrupt 
*without* propagating a transaction into the rest of the system, then it 
wouldn't need the DMA mapping. However, if it's just set up to forward 
ranges of BAR address to ranges of system addresses, and there's an 
IOMMU in that path (such that the iATU's "system addresses" at that 
point are actually IOVAs), then all that really matters is what requests 
the IOMMU is going to see coming out of the iATU, irrespective of 
whether a particular system address after translation happens to be an 
MSI controller, and that MSI controller coincidentally happens to live 
right next to the iATU itself.

(Of course the DMA API itself does also care about the general 
distinction of the target address being "memory" or "not memory", as 
implied by dma_map_page/single/sg() vs. dma_map_resource(), but that's 
mostly just for the software aspects of knowing not to attempt cache 
maintenance etc. on the "not memory" where it wouldn't be meaningful or 
valid.)

Thanks,
Robin.

> 
> 
> Kind regards,
> Niklas

