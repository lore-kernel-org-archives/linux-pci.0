Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2350230BDB
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776959345; cv=none; b=B304svIyiyqK5iuhp5BJYEwT47ltBwAQrZbuGfoqTv18ZEXkFBDhS4UY3jRJVqK2cBvHn5B1YsPi0kI0itpqt3I94JeItH86MltPc0G/VApvR7v9Dy6FNQdS2Wl8Gg6k6Vt+1W89wZn5eNxo6RfJGpf+MWqj9s83c5dPl6nKTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776959345; c=relaxed/simple;
	bh=80eSES/iMbAO9OuT/7JX5Lx9NP9r7mOfkvygcvQBRSw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=byAPcOxg+o10xt95t4cZuyQhCMUz07TtVqzWFaTj9Xkk76BFpJwDtmy6MdqqM7ybT8QA8PwZrCCZ2L6Pj5uYpKc/sLLVn5WrwftTZrSfTvuTOohqv7mH552Ue7Pa2XxLlzfVkeFzqKXyAB1pPt3U6pgKU6jJpnRTfDXh6JE60l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NxYyTXuo; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NxYyTXuo"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63MJigaI3336647
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:49:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ktUnuoD8CuSUNuBwVhOJzuNt3VlOsH8SY1Gfl8vm3Z4=; b=NxYyTXuoDGqh
	HUIpRba1OxTwsiuK5hAb6P9tDMHrH81yfQVOEVZGe9IWcKaH0TJ7ATIDi9+Wn0/3
	D16waw4ltpCWH1/LUvSTWaYK2ljGKgGW1lLMP+OGlrxiethWgjWFfWjmL25aUJ5R
	4ElyRGONreBKEYUVLd2/3syO6NofYjDHVv9HJy8ayHavdR4fhXp3hXdsNdL4z+sR
	SlbwNnlFUKW/91aabOkiu8WlIIouAXrsn4tghlxgLaVJNghTMR1GCw+0aGeXjRIL
	On+Zmjv4gsFdDYPGZWMsXtggLdXqqT8889Hfd4eVosYfvL9+BGh49m3gOuybOCOf
	dmu40kfugQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by m0001303.ppops.net (PPS) with ESMTPS id 4dpepb594b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:49:02 -0700 (PDT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdd327d970so4281159eec.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 08:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776959341; x=1777564141;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktUnuoD8CuSUNuBwVhOJzuNt3VlOsH8SY1Gfl8vm3Z4=;
        b=WdtB2ZcpncQfsuT3tJTevotMbpYNeEP1kd/WgeNi3YRzLsu9cwgkGW5jH+Qq19UiQ7
         sejeoxmumWnWDoAW4jpyUvtrOvQO1dyz97NLcK6H+/gKHA+ai6cKrHCg2HRh3XqUj+hW
         Y2VVLJFEIXdNZevINk3kWZeZH1gbVhjee2yoZkZDl+W8VmXlnfejI7I9yxkrPJQTaDRp
         s/civJW6lfVy3owTjLJ448Ygt0Xe7Pix30KwE6JOa9+JO0FiSXMBCwshJZrSF6UUOlBn
         4SjLYyP7oIeo4Pux0DdMl3ozuzZ3Sqqn7QZBQXjSRp0jpJO/O+5DQY205G2+oegt8ajT
         7zeg==
X-Forwarded-Encrypted: i=1; AFNElJ/7F1YrVCwSAuzRXtrYLlyR2L2KmRiekKi8StcWzFwzvDYgXhXWfNgbREenxCsd4cuLVERw082yYGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5D2W19v3XNvDG0ejCzrIYHs1bgT7eWAVkFhlniNJeJuqkvyc
	dslNf9MwkBW5Ie76KZW8G8Z9WKlfbuaV6C/Z5JGpSYVCaN4ojTdTObb8g2+kiU6dFVo6z8PDazy
	n5xGCbnrQHYS6Am+WjOOuC5xzW+g/xKVl2dz+XhqPldJrZZVMe42FxDchQymi
X-Gm-Gg: AeBDiespHn9vqFflKoaJl62NecB4+KGOOwzj/0Q/UyEgiu0swMPl8EA8yJBVBwMwMV0
	1UVVlYkJ7DRyKzTvU/6B5x/EokFHXb36BlWP1IbOnQKSb15pgNaQ8y374rvSqKQNHlttw6RQgzC
	8g7rn/yC6bx4+JKYJpoM1372Z65fEwLi6wmCTweqnMRqlUGLRlfhGfcVhs01ceBj6p1/yLFyJam
	tvHE8yBWQVunhEffhJu3OmZz7n08wmlW2t6QcpWV5c2YU1D6/azd9ayE2upPqMx/7hpFho8gA2M
	XAtl+dOHC0MxQqc3MRvOVwKISuo64MIwPuPfNy91XI1inYys3WC4Cif/LdQ3XMr7vHBpS10KZyq
	n2DFPibQRbgVnQzPkD/ynL0RsqgO05CfsoePHcJ63
X-Received: by 2002:a05:7300:3253:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2e42dc0732emr9866568eec.11.1776959341137;
        Thu, 23 Apr 2026 08:49:01 -0700 (PDT)
X-Received: by 2002:a05:7300:3253:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2e42dc0732emr9866544eec.11.1776959340327;
        Thu, 23 Apr 2026 08:49:00 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce460sm28587165eec.19.2026.04.23.08.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:48:59 -0700 (PDT)
Message-ID: <46ba7198-c5fd-44ca-9b35-b9970f400fdd@meta.com>
Date: Thu, 23 Apr 2026 16:48:56 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matt Evans <mattev@meta.com>
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe
 <logang@deltatee.com>,
        Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260421174351.3897842-1-mattev@meta.com>
 <20260421194954.GA28413@unreal>
 <a42eff69-e31e-4f99-a63a-5db2402154eb@meta.com>
 <20260422151906.GB28413@unreal>
Content-Language: en-GB
In-Reply-To: <20260422151906.GB28413@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1NiBTYWx0ZWRfX/oAMdP4v5qw2
 h4YxTlKdOeaN0OFkjJ9WwHchO8xwJqWfcFUthEqguzfWrCpLzqJ+9FbrpG2V30WMhNGsHkyoH7n
 CysBGTKrU5ot5DyekfH8jOFfdh/ocewh8PNreY3s8ESXW8QOlNRltZq2AhoDlTNKHKGDjQCabbz
 vX/AUJjE+vfZiW8SZRr7nhFyv9h7xObAW2Q7Yf+Ykh2dAwkkr68J82327xAaZd+nHOIZ7eb+VnD
 9W6vCUEKuRC4uZpZFC5cNcJaHHFPCQIdZ2YqHBjSM5I+Jf3msmx8UU9IJjCJ6PlJu0ICGLNSyEP
 6hKJuzJEtY2QHVEQtOrw85PeBu86JqPXwYhbVIvyyNt9V74IwpKTrihJs6NCX3VxBTbiV42y1T2
 zeNlRoFP7M1AHRzMffhz5k9/8vffl3IKtEg3Xg6aQssoy//dIxFLSXeXRBwzH1P57gmvuC9hLF2
 iucVp9Cyy88yAELP7ag==
X-Authority-Analysis: v=2.4 cv=aN3Ab79m c=1 sm=1 tr=0 ts=69ea3f6e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=rOgdde6qJ7EhcwaZcN0A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 3BB1pfR7PBq7IbZ_flB1VxXwy5ToyH3Q
X-Proofpoint-GUID: 3BB1pfR7PBq7IbZ_flB1VxXwy5ToyH3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

Hi Leon,

On 22/04/2026 16:19, Leon Romanovsky wrote:
> 
> On Wed, Apr 22, 2026 at 03:22:53PM +0100, Matt Evans wrote:
>> Hi Leon,
>>
>> On 21/04/2026 20:49, Leon Romanovsky wrote:
>>>
>>> On Tue, Apr 21, 2026 at 10:43:51AM -0700, Matt Evans wrote:
>>>> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
>>>> pdev->non_mappable_bars set.
>>>>
>>>> Consumers such as VFIO were previously able to map these for access by
>>>> the CPU or P2P.  Update the comment on non_mappable_bars to show it
>>>> refers to any access, not just userspace CPU access.
>>>>
>>>> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
>>>
>>> I don't object to the patch, but this Fixes line doesn't look correct.
>>> non_mappable_bars applies only to s390, which doesn't support p2p. That
>>> wasn't prevented before 372d6d1b8ae3c refactoring too.
>>
>> Thanks; I'd chosen that commit as it adds the function that the additional
>> test is being added to.
> 
> Can I suggest slightly different solution?
> If CONFIG_..._S390 is set, we will unset CONFIG_PCI_P2PDMA and pcim_p2pdma_provider()
> will be compiled to return NULL, without changing non_mappable_bars
> description.

Where we got to in

    https://lore.kernel.org/kvm/20260415181623.1021090-1-mattev@meta.com/

was that non_mappable_bars could be used in future for non-s390 quirks, 
i.e. s390 is the current (but potentially not only) user.  Secondly, it 
isn't a P2P-specific issue because in

    https://lore.kernel.org/kvm/20260416131815.2729131-1-mattev@meta.com/

I'm aiming to add mmap() support to VFIO DMABUFs, which (without a fix 
like this) would allow CPU access too.


Thanks,


Matt

