Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548999;
	b=eic1KbWdu2yU+IufpTmLfzXpKSkMs/C+unULU3utQuRnHjGcgJxA3eK5rLnpfFP4QA0y
	 c5F5yLVttM7MDr8plxxzK+d06B2ZDgm6yOPRrAzTE5LG571vQZzlBlNV2efFU3FW7RjkV
	 vYNDqglvD/2kIm6jW4IFv0DkEPrAx2EDN5RA0tzUCYnkPulgtnc3dcphccmDT6yMn+7jx
	 KFZ8N76fCa+1R0fsoD8DA2hCDzGdWbb/p7c3V1RMHhXHPLgY0Xmgu5oJNBeqW+hbvGGOX
	 qfXtMZ/lT+NCsNQsgy6SSU6bAZV1oOAZ8A3EC3qQzfYXK7cg8k3adW51DYpOd89fo9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548999;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=1QCHCXTpwhaXOHfzz5l15bpjdkFUiznzxAOCYs8/1D0=;
	b=tPwp9jUs9ypXgFTNorDrTFFVWxnlPxGW2loTel60SRHCfHNGCWAoqNbh/MW1a7FezTmJ
	 cekm66ohFho2r2s15PxHDBJF+WZAtr9IjzJuwxzzB9E6rkqVT1n97tYpV2gIZ1UnbcC2r
	 Sy8WYCoEbJ/ZnXcXAAi5D7l3/GSQS5wDUupzbyGQXYf5t/Ag3lnVjo7RYB8CPcIlXuSLT
	 qqqbFfQWZ+IDfcSUN0yyDosISuoa+DjFe+jzCizCJi/m4FLM/NhKUNLeV8gJkWrfxkomm
	 ZJecprt5F+jvxIv2M1uUCFx7xfDf/bXXw3E8fPERMwpwnwONvvN2nJ411OLjD7ukEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+IV7MCg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFD606A31C;
	Fri, 13 Nov 2026 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+IV7MCg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2A01F000C6;
	Fri, 13 Nov 2026 05:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794548998;
	bh=1QCHCXTpwhaXOHfzz5l15bpjdkFUiznzxAOCYs8/1D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n+IV7MCgQdlJEEHAi6QKi/kWy8yzp/3uca4izpMGuczcmGYuWXP3sYO6HEulgaSBr
	 jiPtYks0VWhhv6b2H6VteZ5IaAhh5Zd1R7Q4rLovkGkISG7tPg3bxeb2G1DXjlB6qP
	 VDyDvwuF4X1U7cRFjeD2owWdYNi28hs7F7wxcGqpCUmQtrw4osKtcRuZM/NooYos0O
	 sJd4CYmm5Y50NXab3eCYjqRnjvTWUiEw4GDByC7PDQE+k0Q4B6nt+VDWI6ysFMK5zr
	 /KLvD3AiUaFTwd3rQgKN4RRszouPPgU26Q/Db8U6YHBXoV5XrhRsmcRCyb/Io6mwFw
	 l2Ohtqal/D2+Q==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 02/15] virt: coco: tsm: Remove the device from lookup
 before PCI teardown
In-Reply-To: <9eb572d7-fa3a-4734-9773-44a3fb465b6a@amd.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-3-aneesh.kumar@kernel.org>
 <9eb572d7-fa3a-4734-9773-44a3fb465b6a@amd.com>
Date: Fri, 13 Nov 2026 11:19:45 +0530
Message-ID: <yq5ajymhmgau.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 5/11/26 03:16, Aneesh Kumar K.V (Arm) wrote:
>> PCI connect looks up a TSM by ID under pci_tsm_rwsem. Previously,
>> tsm_unregister() released that lock after tearing down PCI state while
>> the TSM was still in the class lookup. 
>
> tsm_unregister() is not touching that lock, what do I miss?
>

pci_tsm_unregister(). It uses guard(rwsem_write)(&pci_tsm_rwsem), so the
lock is released when pci_tsm_unregister() returns. We previously called
device_unregister() only after that.

>
>> A racing connect could then
>> attach a new PCI context that the teardown would never see.
>> 
>> Remove the device from the class lookup first, then take the PCI write
>> lock to drain in-flight operations and destroy their contexts. Drop the
>> device reference only after PCI teardown completes.
>> 
>> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   drivers/virt/coco/tsm-core.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
>> index e784993353d8..f79135986102 100644
>> --- a/drivers/virt/coco/tsm-core.c
>> +++ b/drivers/virt/coco/tsm-core.c
>> @@ -56,26 +56,25 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>>   	return no_free_ptr(tsm_dev);
>>   }
>>   
>> -static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>> -						 struct pci_tsm_ops *pci_ops)
>> +static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)
>
> Why changing a pointer to an int here as later tsm_register() converts
> it back to a pointer?
>

At the end of the series we have
static int tsm_register_pci(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)


>
> And I never understood what is _reset for here (so +1 for that) but
> now we have tsm_register_pci() and pci_tsm_register() which is weird.
> May be just open code it? Thanks,
>

How about rename that to 
__tsm_register(struct tsm_dev *tsm_dev, struct pci_tsm_ops *pci_ops)


-aneesh
