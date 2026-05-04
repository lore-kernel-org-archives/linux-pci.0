Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B114AD20;
	Mon,  4 May 2026 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875867; cv=none; b=nN00HHVvzJZXlOvW6JgGTNn6ToZcmsELcMyaCoQPyjkEZook4gYrPWHOUSL2M9iaptUQ4Ls91kLaJ2Fn5meeT/2K8H+cc9ABE1W1uOT5Sa0eL7k/xPPPf7xuwEat4dOSSQThoN3mgDUwcY2rrb1ILnZ2A+2QxfIy5XWfRwiv3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875867; c=relaxed/simple;
	bh=PYB35MQoaY7taFrX9TWz3qPYZADd9v1r68AyDsDtoFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scaCI7yZd76qkvBP2CDrwBBpe8LsqbuIKZYlzCr3vq8I4xpBuf7yRbcv54DXzL5VIBzuswS9DvVWulcyMLa2ItkPBTEOj9QTCwtNjCkci6rQ4luIDr7Y+h2vnNmKJA4jn/FngZjJQTDYqp+wWHsSyDOV4ZMqgtGB0aozCjmvNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MW0kuarW; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MW0kuarW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=eoDyIB9MKLnXGCh0r+3x/f8pDxF2OmHPG/aL1VQ2lUw=;
	b=MW0kuarWRqO895SdwzFvchUvvnwO4oPHaj9gpWOd7wlRac/b7eGBP4oVPstXsD
	+pMzLTGe+Q/O+Rth1SCCBAInEiTi0FDzvGQjFAGEc27WNasCYwxacLaQKsLhrhYm
	O1wPY0uYzCS6NiggMqlVbjzQQ2jEVi5EOaldtNOsGbCUw=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAX2IFmO_hpvbviCA--.227S2;
	Mon, 04 May 2026 14:23:38 +0800 (CST)
Message-ID: <ce5574b7-1c0d-4b46-b92e-e8f7ddbd8ef0@163.com>
Date: Mon, 4 May 2026 14:23:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, vigneshr@ti.com, robh@kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260501153553.66382-1-18255117159@163.com>
 <20260501153553.66382-2-18255117159@163.com>
 <4ce9f13a-b17f-4149-ade8-57519f4a4752@ti.com>
 <699bd359-7389-45fa-a79b-10046f73bf12@163.com>
 <a3093010-d120-4c5d-b272-d8cb3884f0b3@ti.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <a3093010-d120-4c5d-b272-d8cb3884f0b3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAX2IFmO_hpvbviCA--.227S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFyrGr1DZry3WFyUJFy7Jrb_yoWxAFy7pa
	yUWF1xKF40qr45u3Wvv3WUZrySqr98GFy7Gw4kKa4xZrnrCr17tF42gF43WF9xGrs0vr17
	Z3WUtF9rGF1YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5DGOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AqBJWn4O2qsAwAA3t



On 5/4/26 13:08, Siddharth Vadapalli wrote:
> On 03/05/26 21:16, Hans Zhang wrote:
>>
>>
>> On 5/2/26 13:18, Siddharth Vadapalli wrote:
>>> On 01/05/26 21:05, Hans Zhang wrote:
>>>> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link 
>>>> speeds
>>>> greater than 5.0 GT/s, software must wait a minimum of 100 ms after 
>>>> Link
>>>> training completes before sending a Configuration Request.
>>>>
>>>> Add a new 'max_link_speed' field in struct cdns_pcie to record the
>>>> maximum supported (or currently configured) link speed of the 
>>>> controller.
>>>>
>>>> In cdns_pcie_host_wait_for_link(), after the link is reported as up,
>>>> insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
>>>> implements the required delay at the common Cadence host layer.
>>>>
>>>> Currently max_link_speed is zero-initialized, so the delay is not yet
>>>> active. Glue drivers must set max_link_speed appropriately to enable
>>>> the delay. This matches the approach taken for the Synopsys DWC
>>>> controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
>>>> dw_pcie_wait_for_link() waits 100 ms after link up").
>>>>
>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>> ---
>>>>   .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++ 
>>>> ++++
>>>>   drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
>>>>   2 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host- 
>>>> common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>> index 2b0211870f02..d4ae762f423f 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>> @@ -14,6 +14,7 @@
>>>>   #include "pcie-cadence.h"
>>>>   #include "pcie-cadence-host-common.h"
>>>> +#include "../../pci.h"
>>>>   #define LINK_RETRAIN_TIMEOUT HZ
>>>> @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie 
>>>> *pcie,
>>>>       /* Check if the link is up or not */
>>>>       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>>           if (pcie_link_up(pcie)) {
>>>> +            /*
>>>> +             * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>>>> +             * supports Link speeds greater than 5.0 GT/s, software
>>>> +             * must wait a minimum of 100 ms after Link training
>>>> +             * completes before sending a Configuration Request.
>>>> +             */
>>>> +            if (pcie->max_link_speed > 2)
>>>> +                msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>>
>>> I think the above could be moved to cdns_pcie_host_start_link() as 
>>> follows:
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host- 
>>> common.c b/ drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> index 2b0211870f02..0f885dcbdb12 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> @@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct 
>>> cdns_pcie_rc *rc,
>>>       if (!ret && rc->quirk_retrain_flag)
>>>           ret = cdns_pcie_retrain(pcie, pcie_link_up);
>>>
>>> +    /*
>>> +     * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>>> +     * supports Link speeds greater than 5.0 GT/s, software
>>> +     * must wait a minimum of 100 ms after Link training
>>> +     * completes before sending a Configuration Request.
>>> +     */
>>> +    if (!ret && pcie->max_link_speed > 2)
>>> +        msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>> +
>>>       return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
>>>
>>> This will avoid an additional and unnecessary delay when 
>>> 'cdns_pcie_retrain()' retrains the link.
>>>
>>> Instead of checking for the link being up using "pcie_link_up(pcie)", 
>>> checking for 'ret' being zero should also work (ret being zero 
>>> indicates that the link is up).
>>>
>>> Since configuration space accesses will not be performed until 
>>> cdns_pcie_host_start_link() completes executing, it should be safe to 
>>> switch to the above implementation.
>>
>> Hi Siddharth,
>>
>> I think this is applicable to LGA IP as per the method you mentioned. 
>> However, for HPA IP, additional repetitive code needs to be added in 
>> the following code.
> 
> Yes, additional code is required as you rightly pointed out, but the 
> problem I was trying to address with your patch is the following:
>      cdns_pcie_host_start_link()
>        calls cdns_pcie_host_wait_for_link()
>          Link is Up and we wait for 100 ms here
>        calls cdns_pcie_retrain()
>            calls cdns_pcie_host_wait_for_link() a second time
>              Link is Up again after retraining and we wait and
>              we wait an additional 100 ms here.
> 
> Instead, it will be sufficient if we could wait just once after 
> cdns_pcie_retrain() returns.

Hi Siddharth,

Yes, I looked at the code and indeed it works this way.

Because of the abundance of redundant comments. I'm wondering if it's 
possible to encapsulate a helper function in the file 
drivers/pci/controller/pci-host-common.c, so that controller drivers 
like dwc and cadence can call this API. Or do you know where it would be 
appropriate to place it?

Hello, Bjorn and Mani, I wonder what your opinions are.

> 
>>
>> Regarding the "quirk_retrain_flag" tag, I reviewed this submission 
>> record and it appears to be a workaround method. Can it be considered 
>> that it is not a universal method? Or is the same processing logic 
>> also added in the HPA?
> 
> I am not sure, but to the best of my knowledge, the quirk is not 
> applicable to HPA.
> 

The SOC of our company is HPA IP, and it doesn't require this flag setting.

Best regards,
Hans

>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/ 
>> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> index 0f540bed58e8..65159f52067d 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> @@ -305,6 +305,15 @@ int cdns_pcie_hpa_host_link_setup(struct 
>> cdns_pcie_rc *rc)
>>          if (ret)
>>                  dev_dbg(dev, "PCIe link never came up\n");
>>
>> +       /*
>> +        * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>> +        * supports Link speeds greater than 5.0 GT/s, software
>> +        * must wait a minimum of 100 ms after Link training
>> +        * completes before sending a Configuration Request.
>> +        */
>> +       if (pcie->max_link_speed > 2)
>> +               msleep(PCIE_RESET_CONFIG_WAIT_MS);
>> +
>>          return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
>>
>> Best regards,
>> Hans
> 
> [TRIMMED]
> 
> Regards,
> Siddharth.

