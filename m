Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A3C2FF;
	Tue,  7 Apr 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563814; cv=none; b=BX+cQaHLHzfeswB1M+AjV05OSvtpXeIf1AYv2EnHhZ/GKKHrRC6ygFmsOF2zwEem6YeR5ipGxzvjH1rgzyQG1ylCOq2VjKeM6JQQZU3PTizoCUKQ/5u/kZN+oCzMVj8M3vn8cShIrGQQPGfwq6tatbYbmgR6xKE6Zu2b/xQQqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563814; c=relaxed/simple;
	bh=0icj21BdzxEURU+/9Q68nCCqKz6J/3TgY6V83XiC/xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHiULDd96xp+5DhmcWgsual9QYysoU4IKEBEE8YmXmU8aybXLJqJ5x1xvOr64qzypvWJhs0xN6F/UDT2KToE/DUQHII/TOaA6y5BKOnPLoiUCyf7S8RdfT0pe53P9h0G6ZFcD/SCJYJrw1tz8CZkTtfds0OyXtVuiDwJRalKmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iDXLxYNq; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iDXLxYNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=JusMDspgfnp9ijHpg8OqUeqKHxWR7v/cVK8rLjb2EcU=;
	b=iDXLxYNqXRY6t5nRSb/6p+XB334PlOBMRMuL1ex4pYzwfqwC211g1woRVtE8sJ
	F63TT+ezirTxSS1hYfNlrZzptJu02ik4wKkFX1O1kA2Cqk7cDKrrrdSnKOlRSAfI
	QDW1dkQpQAbQDuPV1gB13DakrzJQz3RpjbmQkXrBmPW7w=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXlWz089RpmqKQDg--.52570S2;
	Tue, 07 Apr 2026 20:09:24 +0800 (CST)
Message-ID: <e1acfaad-faaa-410e-a20c-94552fded7a3@163.com>
Date: Tue, 7 Apr 2026 20:09:24 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <d19c8a93-71ae-187d-4aa6-a22105edcde3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXlWz089RpmqKQDg--.52570S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1ruF45Xw17Kw17WryUJrb_yoW8ZFy3pa
	9xCF1UAF18J3W3Aa9aga4kXa4rXFs3KFWUurW3W3s5WFyfA3s5Ga4ftryF9ryaqrW0yr40
	va45GF1UCa1jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRI1v3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BTJbWnU8-Q53gAA3B



On 4/7/26 16:11, Ilpo Järvinen wrote:
> On Mon, 6 Apr 2026, Hans Zhang wrote:
> 
>> Move the static array-based pci_bus_speed2lnkctl2() function from
>> bwctrl.c to pci.h as a public inline function.
>>
>> This provides efficient O(1) speed-to-LNKCTL2 value conversion using
>> static array lookup, maintaining optimal performance while enabling
>> code reuse by other PCIe drivers.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.h         | 17 +++++++++++++++++
>>   drivers/pci/pcie/bwctrl.c | 17 -----------------
>>   2 files changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index f0a082bfd6f1..db91878a86ac 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -611,6 +611,23 @@ static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>>   	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>   }
>>   
>> +static inline u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>> +{
>> +	static const u8 speed_conv[] = {
>> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
>> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
>> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
>> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
>> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
>> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
>> +	};
>> +
>> +	if (WARN_ON_ONCE(!pcie_valid_speed(speed)))
> 
> drivers/pci/pci.h doesn't seem to have include for WARN_ON_ONCE() so you
> should add it.

Hi Ilpo,

In the file "drivers/pci/pcie/bwctrl.c", there is no reference to the 
header file of WARN_ON_ONCE(). It seems that no error was reported. I 
think it might be that some other header files have indirectly 
referenced the header file of WARN_ON_ONCE(). However, when I compiled 
it locally, no errors were reported.

I think if we want to add a header file, it should be #include 
<asm-generic/bug.h> ?

Best regards,
Hans

> 

