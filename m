Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320F3A3E79;
	Tue,  5 May 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985732; cv=none; b=BlobEfxY0HZ3hVAAQhZJLqjXnMG5IMNLlfkwm9HsnJTq+IMTa13zhgR4iT1K4jeX+RnIUk4pi6bfVOcpxkdopQZ/55xhbg/QCIrNt6T9tXLxHFrosHXEDRXb9Aha8Mo/tLq6iaXEUqyvkYPmbL1pj4b0RUyTMtCz8fiSHlbCAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985732; c=relaxed/simple;
	bh=/yH1Ofm9nsLLcbsujbvGmYJwhKQRghqJqyax0INxTmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX1xNGqqQk+Kh89jr4UZv0J8Px968Ty1YWrZR+ZQz/Po6lIjpt088cB1SXJ25rdrvUo1NkJnaaB5zpwQmbKaJR9l1Erm4YB5NloJ4+h8rUUmW/z5xnMkTOdpe/fd82VWiP3vsd+nqWK/BeWh7p8OSAvp/8x2fuMxKCFYXi84cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fRTAm+cp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fRTAm+cp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AMi3ov2P+2YTc5hMvoKtH1dVk+Jg3S4V+HOG1FzNfAU=;
	b=fRTAm+cpuhZtyVf5FD63sM7PmQiErZRQb1096WxqtEsZ+RatMomfwY4D/2Q3We
	i8ASMrdQhZzGnG5OS4Ty6lq5+k/V3WFBxCBgvaKFijW9C3AKgEiEuMNzJZr9jMtt
	/MJN2aEAxQ0nbSMhemgQwNMmf0Tr+EORl89ef5vkQF1RA=
Received: from [IPV6:240e:b8f:927e:5900:69e7:6e3e:7ca5:7bb0] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3nx106PlpIevSDQ--.21428S2;
	Tue, 05 May 2026 20:54:13 +0800 (CST)
Message-ID: <8647e3e3-0fc3-4a39-91bf-c79a99e38fae@163.com>
Date: Tue, 5 May 2026 20:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260502114019.GA551304@bhelgaas>
 <2f453b89-0ce8-4ef3-ae93-c282a2d08fd7@broadcom.com>
 <a491a592-5576-4987-a866-a8491f8612e8@163.com>
 <631c8f3f-3d38-42e0-b89a-64281d269bfd@broadcom.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <631c8f3f-3d38-42e0-b89a-64281d269bfd@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nx106PlpIevSDQ--.21428S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DXryxZw17ury8uw17Wrg_yoW5ArWxpa
	y7Ja48tFW8trW5uF4jq3ZYvF1YqFs8GrW7Wws8Wr17uwnIvF93tFy0kr1FkF92yrs7uw17
	X3W3t3WxWF1UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAHUkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxYw02n56HYJiwAA36



On 5/5/26 07:46, Florian Fainelli wrote:
> On 5/4/26 10:26, Hans Zhang wrote:
>>
>>
>> On 5/5/26 00:58, Florian Fainelli wrote:
>>> On 5/2/26 04:40, Bjorn Helgaas wrote:
>>>> On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
>>>>> After commit 03f920936977 ("PCI: controller: Validate max-link- 
>>>>> speed"),
>>>>> pcie->gen stopped being assigned and as a result the established PCIe
>>>>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>>>>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>>>>
>>>>> Link: https://github.com/raspberrypi/linux/issues/7343
>>>>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>>>>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>>>>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>>> ---
>>>>>   drivers/pci/controller/pcie-brcmstb.c | 3 +--
>>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/ 
>>>>> controller/pcie-brcmstb.c
>>>>> index 714bcab97b60..6138fc4bc064 100644
>>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>>> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct 
>>>>> platform_device *pdev)
>>>>>           return PTR_ERR(pcie->clk);
>>>>>       ret = of_pci_get_max_link_speed(np);
>>>>> -    if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>>>>> -        pcie->gen = 0;
>>>>> +    pcie->gen = pcie_get_link_speed(ret);
>>>>
>>>> Take a look at https://sashiko.dev/#/ 
>>>> patchset/20260501202438.376033-1- florian.fainelli%40broadcom.com
>>>>
>>>> The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
>>>> PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
>>>> want the more defensive patch instead.
>>>>
>>>> I'll be happy to replace what's on pci/for-linus if so.
>>>
>>> I am starting to think a revert is the simplest path forward, it's 
>>> not clear what pcie_get_link_speed() brings to the table honestly.
>>
>> Hi Florian,
>>
>> The pcie_get_link_speed function is designed to prevent other Root 
>> Port drivers from accessing the array pcie_link_speed out of bounds.
> 
> Yes, so that's useful in the first hunk of your commit where we were 
> printing the link speed without checking that the 'max-link-speed' would 
> be bounds check, however it is not really useful for assigning to pcie- 
>  >gen in our case, so I would prefer the second option:
> 
> 
>            ret = of_pci_get_max_link_speed(np);
>   -       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>   -               pcie->gen = 0;
>   +       pcie->gen = (ret < 0) ? 0 : ret;
> 

Hi Bjorn,

Please replace the pci/for-linus branch with the above modifications. Or 
do you need me to create a new patch again?

Best regards,
Hans

> Thank you for stepping in!

