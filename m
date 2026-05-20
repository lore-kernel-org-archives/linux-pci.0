Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87010367B79;
	Wed, 20 May 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255936; cv=none; b=mJwmnp6wT+Pqx7hUkKUcFZq8RAZWhxj/MX8gOLcEY4vjBVWlIktBAgKK6eMO+984nCps38RHbakM45azUHsFegpDKBrpu111llpVTyqg/L3EIJWCvdFnxOy/vtRAI9eEhgXG7/ms1ltg2c0f00LdCKVu1fKfEGRmUicC92SHz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255936; c=relaxed/simple;
	bh=83feIIA02cyUG3pN6qEQLO701bhENlpUm9hqJJgfz2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTbH9rYTypeH2S+lrWNrqPjHra44B8JI1f+V3xHVHSVMWtQeQ50m4Lj+rYjHCvxhYCyh+YfluZBtV8iEF2fEeu4bXcla0r0VeDPyqrr6mnH3gPZRpL1BRBikEKTX+JyxJTNgfM1dVahyM9Mj/Kn/vf7masVw6xVrbafyHPckHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OzBl/2xR; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OzBl/2xR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=FJEHxflLrLMVkNzQGdXlh/Hc0MxZt7+ZgkqMjzVVD7o=;
	b=OzBl/2xR8ZOtoNw2ByDkwWrXJkgQUl/WJhEEu04TrEwS4jrhwXC3IIjVo1jBid
	wgWZZOgZU0PwvhAELUluM2CHeBYkb3rk9yoI7KRNA5LKM6xenv2ikMlprhjgZL7K
	WzmhxSQlALS4D37q41r+RCJMY4kAP2dvTkv1WGKtDstm0=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3bepVSg1quT2lFQ--.54696S2;
	Wed, 20 May 2026 13:44:54 +0800 (CST)
Message-ID: <4bf0d8b0-3cd0-4853-8a2b-416f3fd98139@163.com>
Date: Wed, 20 May 2026 13:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
To: Aksh Garg <a-garg7@ti.com>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260519123609.1595280-1-18255117159@163.com>
 <20260519123609.1595280-4-18255117159@163.com>
 <DM6PR07MB6716A1B312BB85439C399D56A2012@DM6PR07MB6716.namprd07.prod.outlook.com>
 <e3fa093e-28a5-46a1-a10e-e8065d127d08@163.com>
 <6ca26fc1-27d8-45ae-8f16-3266e90e74eb@ti.com>
 <4768d23f-b07c-4cb5-b626-cf4aaeca2647@163.com>
 <026b1332-1d53-44bb-8528-2b6be5f91233@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <026b1332-1d53-44bb-8528-2b6be5f91233@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgA3bepVSg1quT2lFQ--.54696S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4fKr1kXw1kAF43WF1UAwb_yoW5GFWxpa
	y8GayfGa1UXrWSy3Zav3WUJr13Kwn7G34UXwsFkr18urnIvr1UZr42gFWrCF9rWrn3Wr17
	tw1Yqas7Wr17AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BaFKWoNSlZWWgAA3h



On 5/20/26 13:27, Aksh Garg wrote:
> 
> 
> On 20/05/26 10:10, Hans Zhang wrote:
>>
>>
>> On 5/20/26 12:36, Aksh Garg wrote:
>>>
>>>
>>> On 20/05/26 08:29, Hans Zhang wrote:
>>>>
>>>>
>>>> On 5/20/26 10:34, Manikandan Karunakaran Pillai wrote:
>>>>>> EXTERNAL MAIL
>>>>>>
>>>>>>
>>>>>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>>>>>> 'ltssm_status' file now works for both HPA and LGA IP by selecting 
>>>>>> the
>>>>>> appropriate register access based on the 'is_hpa' flag.
>>>>>>
>>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>>> ---
>>>>>> .../controller/cadence/pcie-cadence-debugfs.c | 61 +++++++++++++++ 
>>>>>> +++-
>>>>>> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>>>>>> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>>>>>> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>>>>>> 4 files changed, 112 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>>> b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>>> index 97c5deef2b1a..0a308f95e9f6 100644
>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>>>> @@ -13,6 +13,58 @@
>>>>>>
>>>>>> #define CDNS_DEBUGFS_BUF_MAX        128
>>>>>
>>>>> Where is CDNS_DEBUGFS_BUF_MAX used for ?
>>>>
>>>> Hi Manikandan,
>>>>
>>>> Thank you very much for your reply and reminder.
>>>>
>>>> This macro definition was used in patch 0002. Since I compiled the 
>>>> code after applying all three patches together, I didn't notice this 
>>>> issue. The next version will be fixed and will be included in patch 
>>>> 0002.
>>>
>>> I didn't understood the issue here. The macro definition was indeed 
>>> introduced in patch 0002 itself right? Am I missing something here?
>>
>> Hi Aksh,
>>
>> If only patches 0001 and 0002 are applied, there will be a compilation 
>> error. Patch 0002 will fail to find CDNS_DEBUGFS_BUF_MAX. Previously, 
>> I split LGA into patch 0003. I didn't notice this issue. Do you think 
>> I have explained it clearly?
> 
> I see no compilation errors after applying only patch 1 and 2.
> CDNS_DEBUGFS_BUF_MAX macro is defined in the patch 2 itself.
> 
> Patch 3 just uses the CDNS_DEBUGFS_BUF_MAX macro definition code for the 
> reference point to add the new code lines in that patch, it didn't 
> introduced the macro here.

Hi Aksh,

Well, I was misled. Could you please help test this series of patches? 
If there are no issues, please add your test label.

Best regards,
Hans



