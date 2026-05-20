Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870C13DDAE;
	Wed, 20 May 2026 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779252053; cv=none; b=Zv66b8TUcVXoSxhyMOeJVEYpTkda3wST7ZGUZlk0L7GZMOmV1ALElfpxp+e719GMDCzuewrjnnjbKc2f5y601szaoxExQL46yf6FQRkdpF0X04IDO0IifdbYpcJgpFm6N7aR65CC72/jbWqoIR96BhNydgiA6yS/BJOb/d/4sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779252053; c=relaxed/simple;
	bh=0l3bLpCLiengDYutwjVd1PD0kRWoWNo+fgrSFwAzTr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g46sqg6pWXaPuqkER0/FkKQmfQbGIqnf6AnpIZCvZj5BfbGbOHKTwnjKEfM+vfhdLeNm1DJXI/SqiwmoprHfnjcdNrP6epzY/21K67cCf6CZ4qmEuot1Jf50toww03UoWczP34JtEhyqCLcI44VtWaOgWGcbGbJbRI/BmVDkqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d1vbBbJL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d1vbBbJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZjzlvYJ6+xhh1eFdWFyZBsRti23fjw1LMro9uXybTNc=;
	b=d1vbBbJLa2IPuSReApceGr28IHxvh49Vp1yCjHhBXMWiVwoaUJlGkptuBaH0ax
	BhHEIfVKmO/zIgPvQs38C/BcsvYHHxoUPa3qAkWqMhDQC7sSY7pYWrLaaZDX3n7P
	6qZWfdi5eE1jwdtg10IxtQrx87VX2JO2a/vrIJqp5lG/I=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXtOAoOw1qE3y1CQ--.58419S2;
	Wed, 20 May 2026 12:40:09 +0800 (CST)
Message-ID: <4768d23f-b07c-4cb5-b626-cf4aaeca2647@163.com>
Date: Wed, 20 May 2026 12:40:08 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <6ca26fc1-27d8-45ae-8f16-3266e90e74eb@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXtOAoOw1qE3y1CQ--.58419S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw4Utr1DZFW7Jry7Gr4xXrb_yoW8ZrW3pa
	y8Ga4fGa17XFWfA3Zav3WUJr13K3Z7J34UX39F9r1xurnrZr1UXrsFgFW8GF9rWrZ7Wr47
	t3Z8tasrKr17Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Am2WmoNOymCOgAA3E



On 5/20/26 12:36, Aksh Garg wrote:
> 
> 
> On 20/05/26 08:29, Hans Zhang wrote:
>>
>>
>> On 5/20/26 10:34, Manikandan Karunakaran Pillai wrote:
>>>> EXTERNAL MAIL
>>>>
>>>>
>>>> Extend debugfs support to LGA-based Cadence PCIe controllers. The
>>>> 'ltssm_status' file now works for both HPA and LGA IP by selecting the
>>>> appropriate register access based on the 'is_hpa' flag.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>> .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
>>>> .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
>>>> .../controller/cadence/pcie-cadence-host.c    |  9 ++-
>>>> drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
>>>> 4 files changed, 112 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>> b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>> index 97c5deef2b1a..0a308f95e9f6 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
>>>> @@ -13,6 +13,58 @@
>>>>
>>>> #define CDNS_DEBUGFS_BUF_MAX        128
>>>
>>> Where is CDNS_DEBUGFS_BUF_MAX used for ?
>>
>> Hi Manikandan,
>>
>> Thank you very much for your reply and reminder.
>>
>> This macro definition was used in patch 0002. Since I compiled the 
>> code after applying all three patches together, I didn't notice this 
>> issue. The next version will be fixed and will be included in patch 0002.
> 
> I didn't understood the issue here. The macro definition was indeed 
> introduced in patch 0002 itself right? Am I missing something here?

Hi Aksh,

If only patches 0001 and 0002 are applied, there will be a compilation 
error. Patch 0002 will fail to find CDNS_DEBUGFS_BUF_MAX. Previously, I 
split LGA into patch 0003. I didn't notice this issue. Do you think I 
have explained it clearly?

Best regards,
Hans

