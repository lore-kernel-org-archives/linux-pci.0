Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46972332EBA;
	Tue,  7 Apr 2026 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565183; cv=none; b=kHo2kcuu0/4FBWfGw/Al8LFOJAa1ekx92m/D5dyICghPYc7qkXbeQoR3uVGZzU+pjLm17xHRxsgG/S8yleGtnBM9iIVfluOm+xedLrjw5muisi/Hp8P6+pkpc3530jM4PZb05y9rtcx1CzXVVqv4Z4/pfF20hUAxlRn+JKSAaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565183; c=relaxed/simple;
	bh=4jEUS4TVj0mUoG/B4T0vgcXzf61uSxD0SXo9Ymr9jjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrEkOccmmqX7oVvFMjgKtEtt1MHFey0ZJOfEbK0jFqMaT7XkExesjg6vB5u5//bG6w2AzYIOfZjPMI4aD/0GBgxSrT30JGs8bIztTBv/fcNoBBK8IuJart4Via8BkrvfOML4C9grpSBqBJv37KTypzcsg2o6hdPoZSTRgZ+ap8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kLf3lI92; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kLf3lI92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=T3CJe6lVPxvccwbAj3XRUf9iVuhSZuG6SmUOX9MS6+Y=;
	b=kLf3lI92WJEnykUB+TyuMNEIwS9dWCEVl3XvTsLNpMLiD9p+7Flxt1TtsDCHZJ
	iLNfEV57jB55HbaevaMqp0iZDpatpqb3M28sKVmjZsvNHqZ1S9+4MNekuu/sHq28
	Q64/U42FbAJPdkTemy69i0CqHuvHUQ11ZisM6AMQFtDDU=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDH7TZb+dRpr4MiDw--.8196S2;
	Tue, 07 Apr 2026 20:32:28 +0800 (CST)
Message-ID: <83fe07c5-f3c8-4e13-9b04-fbbea67f3326@163.com>
Date: Tue, 7 Apr 2026 20:32:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] PCI: dwc: Use common speed conversion function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260406105613.1228673-1-18255117159@163.com>
 <20260406105613.1228673-4-18255117159@163.com>
 <d2bb9eae-8731-b438-87dd-fcbcf2a17551@linux.intel.com>
 <70f81184-4900-499b-a6ee-fbe18367bd0a@163.com>
 <2af36546-5c33-caf8-b15d-fbf8fec4417e@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2af36546-5c33-caf8-b15d-fbf8fec4417e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH7TZb+dRpr4MiDw--.8196S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4UAw1xKr1rGw4DWr45KFg_yoW5tw1xpa
	y3AF40yF18Jr45Za1qq3WYqa4jqFnxGrWUGrZ8WasYgFy2vF93JF18Kr4S9r9a9rs7Ar12
	y347t3srGw17tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Una9-UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xwlyGnU+VzsmgAA30



On 4/7/26 20:29, Ilpo Järvinen wrote:
> On Tue, 7 Apr 2026, Hans Zhang wrote:
>> On 4/7/26 16:25, Ilpo Järvinen wrote:
>>> On Mon, 6 Apr 2026, Hans Zhang wrote:
>>>
>>>> Replace the private switch-based speed conversion in
>>>> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
>>>> function.
>>>>
>>>> This eliminates duplicate conversion logic and ensures consistency with
>>>> other PCIe drivers, while handling invalid speeds by falling back to
>>>> hardware capabilities.
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>>>>    1 file changed, 3 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>> index 06792ba92aa7..ab8dee5d6c7a 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>> @@ -861,24 +861,12 @@ static void dw_pcie_link_set_max_speed(struct
>>>> dw_pcie *pci)
>>>>    	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>>>>    	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>>>>    -	switch (pcie_get_link_speed(pci->max_link_speed)) {
>>>> -	case PCIE_SPEED_2_5GT:
>>>> -		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>>>> -		break;
>>>> -	case PCIE_SPEED_5_0GT:
>>>> -		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
>>>> -		break;
>>>> -	case PCIE_SPEED_8_0GT:
>>>> -		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
>>>> -		break;
>>>> -	case PCIE_SPEED_16_0GT:
>>>> -		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
>>>> -		break;
>>>> -	default:
>>>> +	link_speed = pcie_get_link_speed(pci->max_link_speed);
>>>> +	link_speed = pci_bus_speed2lnkctl2(link_speed);
>>>
>>> Its signature is:
>>>
>>> u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>>
>>> Using link_speed variable both for in and out does contradict with the
>>> expected typing.
>>>
>>> Maybe it would be beneficial to rename the current 'link_speed' to
>>> 'ctrl2_speed' (or something along those lines) to differentiate Link
>>> Control 2 speed representation from PCI core's internal link speed
>>> representation. And then reintroduce link_speed variable as the
>>> pci_bus_speed. ...But this is just my suggestion, there may be better ways
>>> to untangle this type abuse.
>>
>> Hi Ilpo,
>>
>>
>> Thank you for your review comments. This way it will be clearer. Here are my
>> revisions. If there are no issues, I will send the next version.
>>
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
>> b/drivers/pci/controller/dwc/pcie-designware.c
>> index 06792ba92aa7..21a709a47e82 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -843,8 +843,9 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>>
>>   static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>>   {
>> -       u32 cap, ctrl2, link_speed;
>> +       u32 cap, ctrl2, pci_bus_speed;
> 
> I meant something like this (instead of introducing variable named
> "pci_bus_speed"):

Hi Ilpo,

Thank you. Will change.

Best regards,
Hans

> 
> 	enum pci_bus_speed link_speed;
> 
>>          u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +       u16 ctrl2_speed;
> 
> ...And keep this like you have it now.
> 

