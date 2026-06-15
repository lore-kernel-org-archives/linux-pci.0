Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597A4028E3;
	Mon, 15 Jun 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536693; cv=none; b=tnarCa9lJFLBX8Bdqif9RR0r+WuSdGBognW+GCptGIWnoPRDuWrSS2FtmQw79N+9Gfq6G56tkhrWRsMllbwF6ePBWlzHY2p1TnHPNEmVe0NHmRijLq6ysvPUa0xqc2CAYMz5I8Y1l/1N+SSPqnCKPRd6WY1Nm9o7Ujk1YgqN1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536693; c=relaxed/simple;
	bh=ZuUAU5+gsD9PUTgmc15w8Ni8oi3PM1AXnH2EKuV2ouw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGYN7bvJb/PNL7w8zCobxOJwdqwOAFje92Baj79OjygwnjVBZjX4s0i80EqlYTYt2gevzzVzwVvI7qdoP80j/1zdrjPgvJHWnkMDbWBi53ldbGKBnTg1b+v+ZJuWdUEQzeWl3uX+INr7LJ0ooZ0/wUELpwGotnw9ZVSliqUh43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CT5OCwJt; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CT5OCwJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EuCiZfvqe4Hf4gkOmphcRmJ3GJ4VApPml/SFc43XjNo=;
	b=CT5OCwJtDseMveQ+Ty5dOwka7Hn3qBVu8Ev/fiWGXTDMJ/8pyjexESqdQwpXV3
	z+NwjeHZxC1phjrPiV/S7lf8A7aWyaN+CxvfmNT726eZjqtuiyGragZ1EiSSIGSM
	0JS2mhvAu+nnwjAzuAO3jXH5e7yN2Je4YjvHCdKsNWNt0=
Received: from [IPV6:240e:b8f:91b3:d000:367d:ab80:34a0:4b1f] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3BSKMFzBqh0N5CQ--.20143S2;
	Mon, 15 Jun 2026 23:17:33 +0800 (CST)
Message-ID: <644f5a0b-6730-445f-a537-329ac3e69cbf@163.com>
Date: Mon, 15 Jun 2026 23:17:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
References: <20260611172301.GA490724@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260611172301.GA490724@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgC3BSKMFzBqh0N5CQ--.20143S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rZFy8ZF18Ar1kJrW3trb_yoW8trW8pa
	yDJFyYyF18X3W5Zr4qq3WrZFyY9FZ3trW8CrW3W3srZF13A3s3Ja43KFWFgr9FqrW2yF18
	Z3WYvF1rCr4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUU8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w2PM2owF43h7gAA3V



On 6/12/26 01:23, Bjorn Helgaas wrote:
> On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
>> Extract the PCIe speed validation logic from bwctrl.c's static
>> pcie_valid_speed() into a public static inline function in pci.h.
>>
>> This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
>> multiple drivers and functions, avoiding duplicate code and ensuring
>> validation consistency as per PCIe specifications.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Any objection, Ilpo?
> 
> It looks like 1/3 and 2/3 are pure moves, and the interesting part is
> the use in dwc, which I'd like to be reviewed and applied by Mani.

Hi Mani,

Gentle ping on this series. Please apply it when you have time. Thank 
you very much!

Best regards,
Hans

> 
>> ---
>>   drivers/pci/pci.h         | 5 +++++
>>   drivers/pci/pcie/bwctrl.c | 5 -----
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 4a14f88e543a..f0a082bfd6f1 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
>>   	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>>   	 0)
>>   
>> +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>> +{
>> +	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>> +}
>> +
>>   static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>>   {
>>   	switch (speed) {
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index c4c8d260bf96..ea82e326f164 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
>>   /* Prevent port removal during Link Speed changes. */
>>   static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>>   
>> -static bool pcie_valid_speed(enum pci_bus_speed speed)
>> -{
>> -	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>> -}
>> -
>>   static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>   {
>>   	static const u8 speed_conv[] = {
>> -- 
>> 2.34.1
>>

