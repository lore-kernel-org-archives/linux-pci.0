Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE4395DA0;
	Tue,  7 Apr 2026 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565058; cv=none; b=r51wPbXs5IsdI4lTa/I0jz69MFZ/pn4RTqV42AthF3GAs+dhiPq+hBkFEAqIfMETZvhV+6QJW893EhCmfNXoyz3JLPRZhH+cXKsOswMPpCRGOorFHkm1QAJDQiLSVI8ERbSbVULqCKpOKTRjb3oOIMZRGsgfGsBhim1AmP0P4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565058; c=relaxed/simple;
	bh=ijtx/ltxHH3xSD88g3nSbWsCaEKN6jqbrHlB/guHcgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0iGBfKlwd5TeZmMGguUlo5fXVYn+IOZ7gmFjHIIsuAHUKaaaLc683WbqpsmP8aOwNGM2dGFhjG/emQdz5fBvRT++rGZ7uR6FB7wctAaZQysM/XyejfaQG63+qByo99XR3wXeMrDrFcAZ0eX2vleeJnlblUjnC01ifinuL2nJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P85+7f9y; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P85+7f9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fyRGmgRFrZJrUba2c/bbvWonNZsAogO1ce7fqODSjFA=;
	b=P85+7f9ydydOQs+ytGuR37jKBDx/5IXlaItyyUUv/83EBbmGgfqo46s4a+BEkw
	bNmQu89VISR99oWQleOnfjkKl0y2uxKdD4B9uelplQule34n0C16tHTScyf3up9b
	8yYAwvIzmXakgCK1QiPu3y2Nij5PXH9vSuNizyixGwRCY=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3l+21+NRpwAdsDg--.21097S2;
	Tue, 07 Apr 2026 20:29:42 +0800 (CST)
Message-ID: <8f10ec0e-9774-4eb8-b369-95c99a8e0226@163.com>
Date: Tue, 7 Apr 2026 20:29:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: Move pci_bus_speed2lnkctl2() to public header
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260406104708.1218648-1-18255117159@163.com>
 <20260406104708.1218648-3-18255117159@163.com>
 <d19c8a93-71ae-187d-4aa6-a22105edcde3@linux.intel.com>
 <e1acfaad-faaa-410e-a20c-94552fded7a3@163.com>
 <a08aae5d-4239-6099-d95a-9d1ea1661c69@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <a08aae5d-4239-6099-d95a-9d1ea1661c69@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l+21+NRpwAdsDg--.21097S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kZF1rJFWxtr4fAw4xJFb_yoW5GF4xpa
	y3CF1UAF18Jw13AasIg3WkXa4Fqan3tFWUZr13W3s5ZFnIyas3Jw4ftrWY9ryavrW0yr40
	va4UJF17Ca1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRcJ5rUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxb6nmnU+Lb61AAA3s



On 4/7/26 20:26, Ilpo Järvinen wrote:
> On Tue, 7 Apr 2026, Hans Zhang wrote:
> 
>>
>>
>> On 4/7/26 16:11, Ilpo Järvinen wrote:
>>> On Mon, 6 Apr 2026, Hans Zhang wrote:
>>>
>>>> Move the static array-based pci_bus_speed2lnkctl2() function from
>>>> bwctrl.c to pci.h as a public inline function.
>>>>
>>>> This provides efficient O(1) speed-to-LNKCTL2 value conversion using
>>>> static array lookup, maintaining optimal performance while enabling
>>>> code reuse by other PCIe drivers.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>>    drivers/pci/pci.h         | 17 +++++++++++++++++
>>>>    drivers/pci/pcie/bwctrl.c | 17 -----------------
>>>>    2 files changed, 17 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index f0a082bfd6f1..db91878a86ac 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum
>>>> pci_bus_speed speed)
>>>>    	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>>>    }
>>>>    +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>>> +{
>>>> +	static const u8 speed_conv[] = {
>>>> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>>>> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>>>> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>>>> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>>>> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>>>> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>>>> +	};
>>>> +
>>>> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
>>>
>>> drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE() so you
>>> should add it.
>>
>> Hi Ilpo,
>>
>> In the file "drivers/pci/pcie/bwctrl.c", there is no reference to the header
>> file of WARN_ON_ONCE(). It seems that no error was reported. I think it might
>> be that some other header files have indirectly referenced the header file of
>> WARN_ON_ONCE(). However, when I compiled it locally, no errors were reported.
> 
> Hi,
> 
> Apparently it was missing from there as well.
> 
> It might build now (I don't actually even doubt that), but that depends
> on the includes in every file including drivers/pci/pci.h. We should not
> depend on that as it is fragile but ensure a header is self-sufficient
> when it comes to includes necessary for it.

Hi Ilpo,

OK, I see.


> 
>> I think if we want to add a header file, it should be #include
>> <asm-generic/bug.h> ?
> 
> Yes
> 
> #include <asm/bug.h>

Thank you. Will add.

Best regards,
Hans
> 

