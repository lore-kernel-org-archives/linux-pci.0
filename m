Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419630DEB0
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878521; cv=none; b=cZmRHDWdVqnTsNOJsS2AHQsvAqjMTG214TnVqAc/Isca8fFAzBfPywt7dzfsvfQnckRtmVluIjImxZMg2RJU0UnE56G6YCVtdJ5VGaK5XyhB2GF5GYOa9779S3e6QiDvvn+tyg22b77MoulsG1zMRtQ4vl5FyDcQjybbv8ZncR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878521; c=relaxed/simple;
	bh=f3kEW98WK9EcyX72K/U5UD+F3rGK/4d/or99b/Abpxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWH2tT7CduWglde71lbsKBvKpKYwX89M+mqsBllSSFFH1stKhNNkjeUFIiuDJ4LHSMpOyC7SoIgjaw39S7FnDKccXmHVsiiPWJzYV/eTX2ENn72ocNkcyM0yQd4HbV/+8824HtGt/30SIymkafAuR6s251VEuiLi+/Np0OGdo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWARlAU9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWARlAU9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso1231324f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774878518; x=1775483318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m2UWLhFLqzaB3574DuyBh7oJTMtmzHTn/Ed1EUPm7SE=;
        b=YWARlAU9iXaWPz3cy1A1Ojctr5LQpRboeXqDz1WI8ieZNWwP8NDHD04vklGEY7TfO4
         yLRj5l4xJTIdm3i4biQ7wvO5N5HE5ABx2c20tmkX8AhWIRCi2aLN+0THJLkTqtNgSeKq
         y9qjGk4U+vkVvpT4W36v06GJzowct5zEUFrr536Z3sskEiUET6D2OCj3ALDaEAhq53X7
         ECKHzIpT5Bcm2akU5EY1oHoz41Z0JnIEsQwhgAAjC55lLbHlJfImpio2gFlrwFB9GmcK
         NIBWJa6jJPQePs1rNgHqLZujAAUQCQrMZ0ljWInao8tfS99CAB7w5CFwWhNKB3a8ztO6
         H2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878518; x=1775483318;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2UWLhFLqzaB3574DuyBh7oJTMtmzHTn/Ed1EUPm7SE=;
        b=MRXNWKEomtbcqQuNvtakmCLsrnpTH2mndCE1UulD8VWygmwdCgHsZ+tW2wHg/BFUpU
         bndWR7ls1BJscsP/wT5I3+q3IFnQY/RyDK49VniKTaEdfLEJvm0M/TGh5fXgJxrN3ZQ+
         o2uIte6YeUKQRhfmrWBQVMeptSWzzhsV+5+DaaARla/+xPAlDJYl5IDHxU05nTH5bO2a
         RQ8dF5SwfFFmk7sdIaoraAuWwdf1ibiCrhtpJ0eok6U+aTHGYKUfcc/AVWTh1JymejTg
         FEOlEC5EVGoOcVmjRgtIDJ69tGAQjGQKzQlqeCJFsFLcYSQqQnv9uk8YuRFnZwuUZLLi
         7AyA==
X-Forwarded-Encrypted: i=1; AJvYcCUfOakgqVRmRjN2yfqgZYryDnZEaFMqvmGdBF1f6KkTI7B+RrYkiwpYhPeQJXUOaZkqNtcYvl7St7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXn1j6wEQGpK8AfU0PpfcuH+GJazqcSKrt6ukNJ0aYNvwwWdqZ
	Exf172cPdBFYQrrFf6r/Jm8Ok9ZbgukwbXTDHe5b+qKGzH7Lemxg5i6wOKDaNoDPD2Y=
X-Gm-Gg: ATEYQzyf05YgdWTrpfhR7SorzpX+QcfiodoTods2wALwgbJF2Q97RrE93YRNSoa5SIs
	/H79pJIoxYdjkCx99rk8PNK4UT7As0/loN2OP9Z5WRTl6UmjU8DoEQSwKDPAqWPwuH/3eENPU4j
	OswYArL3rqR6iRVhz4EH7qqS6g+kgwkmRcQQB9uI2YM81cAg/9SrLj8C4Ffif6gbvQcJkmYZVKn
	3501jhIYJXiHap75OjVCWq/Q5eGdYPjg7NSSiLw+9WanYxyYheM6KbNFwmAb9zYewm7192+dei7
	ux2kP7wNLIOWA2d+Q7yeUiH7mX1MQNkxGYkg5IZhF7vVlpO8MnglL5XMT06LoY/UpA4PfQ21Zgq
	KKxGmwBvK0KhlIT4vH91uwBgqvaBr3GYWdn6dCM+nLMafvRwjyp1nCHCiFAO7qqBXPe9VP8TA1S
	LrfJrFAtHzxJ1sCr7NVX8coAr5mw==
X-Received: by 2002:a05:6000:186f:b0:43d:184:8a9c with SMTP id ffacd0b85a97d-43d01848d07mr4354587f8f.12.1774878518231;
        Mon, 30 Mar 2026 06:48:38 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245e2f6sm19726998f8f.18.2026.03.30.06.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 06:48:37 -0700 (PDT)
Message-ID: <7d67722b-5107-4dc3-b8fb-04c3c86a1563@suse.com>
Date: Mon, 30 Mar 2026 16:48:36 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/31] x86/virt/tdx: Support allocating contiguous
 pages for tdx_page_array
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-5-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260327160132.2946114-5-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> The current tdx_page_array implementation allocates scattered order-0
> pages. However, some TDX Module operations benefit from contiguous
> physical memory. E.g. Enabling TDX Module Extensions (an optional TDX
> feature) requires ~50MB memory and never returns. Such allocation
> would at worst cause ~25GB permanently fragmented memory if each
> allocated page is from a different 2M region.
> 
> Support allocating contiguous pages for tdx_page_array by making the
> allocation method configurable. Change the tdx_page_array_alloc() to
> accept a custom allocation function pointer and a context parameter.
> Wrap the specific allocation into a tdx_page_array_alloc_contig()
> helper.
> 
> The foreseeable caller will allocate ~50MB memory with this helper,
> exceeding the maximum HPAs (512) a root page can hold, the typical usage
> will be:
> 
>   - struct tdx_page_array *array = tdx_page_array_alloc_contig(nr_pages);
>   - for each 512-page bulk
>     - tdx_page_array_populate(array, offset);
>     - seamcall(TDH_XXX_ADD, array, ...);
> 
> The configurable allocation method would also benefit more
> tdx_page_array usages. TDX Module may require more specific memory
> layouts encoded in the root page. Will introduce them in following
> patches.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 42 +++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index a3021e7e2490..6c4ed80e8e5a 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -289,7 +289,8 @@ static void tdx_free_pages_bulk(unsigned int nr_pages, struct page **pages)
>   		__free_page(pages[i]);
>   }
>   
> -static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages)
> +static int tdx_alloc_pages_bulk(unsigned int nr_pages, struct page **pages,
> +				void *data)
>   {
>   	unsigned int filled, done = 0;
>   
> @@ -326,7 +327,10 @@ void tdx_page_array_free(struct tdx_page_array *array)
>   EXPORT_SYMBOL_GPL(tdx_page_array_free);
>   
>   static struct tdx_page_array *
> -tdx_page_array_alloc(unsigned int nr_pages)
> +tdx_page_array_alloc(unsigned int nr_pages,
> +		     int (*alloc_fn)(unsigned int nr_pages,
> +				     struct page **pages, void *data),
> +		     void *data)

This interface seems cumbersome, since you will always have separate 
allocation paths:

Contig, Bulk and Iommu mt pages let's just keep them separate. I.e the 
flow should be:

1. Do common allocation by calling tdx_page_array_alloc (you aren't 
passing the alloc function) you just get a bare-bones tdx_page_array struct

2. Do the specific allocation in either :

tdx_page_array_create - for the bulk case
tdx_page_array_alloc_contig - for the contig case
tdx_page_array_create_iommu_mt - for the iommu case. Here you can open 
code tdx_alloc_pages_iommu_mt.

And keep the specific clearly separate in each function.

>   {
>   	struct tdx_page_array *array = NULL;
>   	struct page **pages = NULL;
> @@ -348,7 +352,7 @@ tdx_page_array_alloc(unsigned int nr_pages)
>   	if (!pages)
>   		goto out_free;
>   
> -	ret = tdx_alloc_pages_bulk(nr_pages, pages);
> +	ret = alloc_fn(nr_pages, pages, data);
>   	if (ret)
>   		goto out_free;
>   
> @@ -388,7 +392,7 @@ struct tdx_page_array *tdx_page_array_create(unsigned int nr_pages)
>   	if (nr_pages > TDX_PAGE_ARRAY_MAX_NENTS)
>   		return NULL;
>   
> -	array = tdx_page_array_alloc(nr_pages);
> +	array = tdx_page_array_alloc(nr_pages, tdx_alloc_pages_bulk, NULL);
>   	if (!array)
>   		return NULL;
>   
> @@ -521,6 +525,36 @@ int tdx_page_array_ctrl_release(struct tdx_page_array *array,
>   }
>   EXPORT_SYMBOL_GPL(tdx_page_array_ctrl_release);
>   
> +static int tdx_alloc_pages_contig(unsigned int nr_pages, struct page **pages,
> +				  void *data)
> +{
> +	struct page *page;
> +	int i;
> +
> +	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
> +				  &node_online_map);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pages[i] = page + i;
> +
> +	return 0;
> +}
> +
> +/*
> + * For holding large number of contiguous pages, usually larger than
> + * TDX_PAGE_ARRAY_MAX_NENTS (512).
> + *
> + * Similar to tdx_page_array_alloc(), after allocating with this
> + * function, call tdx_page_array_populate() to populate the tdx_page_array.
> + */
> +static __maybe_unused struct tdx_page_array *
> +tdx_page_array_alloc_contig(unsigned int nr_pages)
> +{
> +	return tdx_page_array_alloc(nr_pages, tdx_alloc_pages_contig, NULL);
> +}
> +
>   #define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
>   #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
>   #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)

