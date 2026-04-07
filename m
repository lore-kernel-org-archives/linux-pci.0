Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2C372B3B;
	Tue,  7 Apr 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566944; cv=none; b=E3FQgzDqFe5hiIJgxE4Uh0f6Uq6AN2VU+TRriWQUxzSUg319iFerC4A6qwU4SplT2ME+fYLsbtBnweDHrYnvjiAw+Z2yOi/Y96Q/w89wFbYU6o0mmM7KPevvtJQXbuTF2X71LCX0CA+mqJBgyqvt7B7+2Koviuxt1YrtKvelRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566944; c=relaxed/simple;
	bh=cLJaD1mJbYOx+7+c9AgkCgsp24Ousfgpz3ybCn19k7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijAmjGANe9oTYizJ4A4MTS4qWHElAiH8UuHDEoRXEcFkzpmjb+endbhK2wBp6x1uZydU9hhYdz5s9LikUOsKI5G7rNh93Udna69ziSZGnrM9BFjC6eloAgnWDxLHGFskaFo6cJr2EcauUJxXkodpDlbfXjyjG/765oVhUQd/jAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VFkj4gmh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VFkj4gmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VeDhuPJUpkaY46YHojScEOxRMmR4YaCPlG6BjfmRqfA=;
	b=VFkj4gmh4P+WWtkcP5lLQc8/S+U/w+cFWNWyJAKKgiRtMEu80ImcyzaemB9mZs
	Ek/cmtOg0dwFE7xK+EACFDab0Mdq2DaytGM6DwltzbuGMaXjeSFQoENAM/Tcrd/u
	Py5Tc/araRJmlWwMsDE8h9BoW/e5dncs4ixTglxH+SRNM=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHL7w4ANVpOgiUAA--.25S2;
	Tue, 07 Apr 2026 21:01:47 +0800 (CST)
Message-ID: <1a8583ad-0d27-4606-9a27-de3bc31d3e67@163.com>
Date: Tue, 7 Apr 2026 21:01:44 +0800
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
 <8f10ec0e-9774-4eb8-b369-95c99a8e0226@163.com>
 <6525a7bd-3540-4eb7-866f-d325282d1e78@163.com>
 <e79055d3-1353-b6be-7c83-f61697efeae9@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e79055d3-1353-b6be-7c83-f61697efeae9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHL7w4ANVpOgiUAA--.25S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1DKF1DKr1fJF4xKryrXrb_yoWrXr4Dpa
	y3AF17AF48Jr17AFnIg3W8JFyrtan3JFyUXr15Wry8XFnFyr97Jr17tryF9r9rJrWjyr1j
	qFyUJFy7Z3WjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRcJ5rUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xvdgWnVADuV8AAA3O



On 4/7/26 20:53, Ilpo Järvinen wrote:
> On Tue, 7 Apr 2026, Hans Zhang wrote:
>> On 4/7/26 20:29, Hans Zhang wrote:
>>> On 4/7/26 20:26, Ilpo Järvinen wrote:
>>>> On Tue, 7 Apr 2026, Hans Zhang wrote:
>>>>> On 4/7/26 16:11, Ilpo Järvinen wrote:
>>>>>> On Mon, 6 Apr 2026, Hans Zhang wrote:
>>>>>>
>>>>>>> Move the static array-based pci_bus_speed2lnkctl2() function from
>>>>>>> bwctrl.c to pci.h as a public inline function.
>>>>>>>
>>>>>>> This provides efficient O(1) speed-to-LNKCTL2 value conversion using
>>>>>>> static array lookup, maintaining optimal performance while enabling
>>>>>>> code reuse by other PCIe drivers.
>>>>>>>
>>>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>>>> ---
>>>>>>>     drivers/pci/pci.h         | 17 +++++++++++++++++
>>>>>>>     drivers/pci/pcie/bwctrl.c | 17 -----------------
>>>>>>>     2 files changed, 17 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>> index f0a082bfd6f1..db91878a86ac 100644
>>>>>>> --- a/drivers/pci/pci.h
>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>> @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum
>>>>>>> pci_bus_speed speed)
>>>>>>>         return (speed >= PCIE_SPEED_2_5GT) && (speed <=
>>>>>>> PCIE_SPEED_64_0GT);
>>>>>>>     }
>>>>>>>     +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed
>>>>>>> speed)
>>>>>>> +{
>>>>>>> +    static const u8 speed_conv[] = {
>>>>>>> +        [PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>>>>>>> +        [PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>>>>>>> +        [PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>>>>>>> +        [PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>>>>>>> +        [PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>>>>>>> +        [PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>>>>>>> +    };
>>>>>>> +
>>>>>>> +    if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
>>>>>>
>>>>>> drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE() so
>>>>>> you
>>>>>> should add it.
>>>>>
>>>>> Hi Ilpo,
>>>>>
>>>>> In the file "drivers/pci/pcie/bwctrl.c", there is no reference to the
>>>>> header
>>>>> file of WARN_ON_ONCE(). It seems that no error was reported. I think it
>>>>> might
>>>>> be that some other header files have indirectly referenced the header
>>>>> file of
>>>>> WARN_ON_ONCE(). However, when I compiled it locally, no errors were
>>>>> reported.
>>>>
>>>> Hi,
>>>>
>>>> Apparently it was missing from there as well.
>>>>
>>>> It might build now (I don't actually even doubt that), but that depends
>>>> on the includes in every file including drivers/pci/pci.h. We should not
>>>> depend on that as it is fragile but ensure a header is self-sufficient
>>>> when it comes to includes necessary for it.
>>>
>>> Hi Ilpo,
>>>
>>> OK, I see.
>>>
>>>
>>>>
>>>>> I think if we want to add a header file, it should be #include
>>>>> <asm-generic/bug.h> ?
>>>>
>>>> Yes
>>>>
>>>> #include <asm/bug.h>
>>
>> Hi Ilpo,
>>
>> Executing the following check script will trigger a warning. However, using
>> #include <asm-generic/bug.h> will not cause any issues. So, should we use
>> #include <asm-generic/bug.h> ?
>>
>> ./scripts/checkpatch.pl ...../*patch
>>
>> 0002-PCI-Move-pci_bus_speed2lnkctl2-to-public-header.patch
>> ---------------------------------------------------------------------
>> WARNING: Use #include <linux/bug.h> instead of <asm/bug.h>
>> #27: FILE: drivers/pci/pci.h:5:
>> +#include <asm/bug.h>
>>
>> total: 0 errors, 1 warnings, 53 lines checked
>>
>> NOTE: For some of the reported defects, checkpatch may be able to
>>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> This is a header, so using <asm/bug.h> minimizes what it pulls in so it
> is justified to use asm/ over linux/ in this case.
> 

Hi Ilpo,

Thank you. OK.

Best regards,
Hans

> 

