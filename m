Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200413C9EFB;
	Tue,  5 May 2026 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962607; cv=none; b=ilTBljF/MG4mvVUA+xKquKgVQGd+6S9VcGx9N4qyik+ZUJ5yBKQnh/uBH00sVvAJwxo70+JoNFT071hYta7euyUJvEZDKgveK0qH/ZaFXipYmbAQ/3nX4vCNdyDslGeFf+nAAA/fjLT3iZZLKmn1osatZULg8NW8GrDCNGEXDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962607; c=relaxed/simple;
	bh=Gshdy4KsJzWqCiRNt8lQefnoup6TCmp8iBuVAHQYh7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXrwhGDUPsxxDKWULCIf6sdmnumMDPAKtyGoDIGYipKCpV4qo7ci3uO9qinaWWWgC+4QYgqxxMBRO+PGbiTLA9Frwsg7snnrmKCt2RREG6/cSLmgSr81GLuwqw6fPgvfO+SUFmfpaV9oNXNXnmY4sEQtvVi1m0DgmWQsomgF5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dGVv4kpf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dGVv4kpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mMW8AEGhMafvz4O5+74DGobnCil6TvXWOF0reU/8wjk=;
	b=dGVv4kpfLQOtKe1W90YBYeq37NsDG0q3mgiZtNY4I3Vu6DXExg46Xh1QNmWoVk
	hsIzTfkoNYC7nY5yQS/HFhc2St/qnnCH5kY/kdyHPdZyulsjOovGbEqUvGttAyK2
	nUC+vzJJ3R2Wn+AXjYuZkjsGzT+P/zbgUE+HTLZEAlsq8=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCnTnkgjvlpV+DSDQ--.40732S2;
	Tue, 05 May 2026 14:28:49 +0800 (CST)
Message-ID: <25d5e524-d7b4-432d-8114-44d32b736732@163.com>
Date: Tue, 5 May 2026 14:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 vigneshr@ti.com, robh@kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260504162216.GA646395@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260504162216.GA646395@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnTnkgjvlpV+DSDQ--.40732S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF4ruF43JFy3AFy7ZF45trb_yoW7KrWUpa
	yUGF1IkF4vqr45Z3Wvv3W5XrySqr98JFy7Xw1kKryxXrnFvr17tF42gF4agFy3Xr4qyr17
	Zr1UtF9rGr1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwGEKGn5jiEdbwAA3j



On 5/5/26 00:22, Bjorn Helgaas wrote:
> On Mon, May 04, 2026 at 02:23:34PM +0800, Hans Zhang wrote:
>> On 5/4/26 13:08, Siddharth Vadapalli wrote:
>>> On 03/05/26 21:16, Hans Zhang wrote:
>>>> On 5/2/26 13:18, Siddharth Vadapalli wrote:
>>>>> On 01/05/26 21:05, Hans Zhang wrote:
>>>>>> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports
>>>>>> Link speeds
>>>>>> greater than 5.0 GT/s, software must wait a minimum of 100
>>>>>> ms after Link
>>>>>> training completes before sending a Configuration Request.
>>>>>>
>>>>>> Add a new 'max_link_speed' field in struct cdns_pcie to record the
>>>>>> maximum supported (or currently configured) link speed of
>>>>>> the controller.
>>>>>>
>>>>>> In cdns_pcie_host_wait_for_link(), after the link is reported as up,
>>>>>> insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
>>>>>> implements the required delay at the common Cadence host layer.
>>>>>>
>>>>>> Currently max_link_speed is zero-initialized, so the delay is not yet
>>>>>> active. Glue drivers must set max_link_speed appropriately to enable
>>>>>> the delay. This matches the approach taken for the Synopsys DWC
>>>>>> controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
>>>>>> dw_pcie_wait_for_link() waits 100 ms after link up").
>>>>>>
>>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>>> ---
>>>>>>    .../pci/controller/cadence/pcie-cadence-host-common.c    |
>>>>>> 9 +++++ ++++
>>>>>>    drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
>>>>>>    2 files changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/drivers/pci/controller/cadence/pcie-cadence-host- common.c
>>>>>> b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>> index 2b0211870f02..d4ae762f423f 100644
>>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>>> @@ -14,6 +14,7 @@
>>>>>>    #include "pcie-cadence.h"
>>>>>>    #include "pcie-cadence-host-common.h"
>>>>>> +#include "../../pci.h"
>>>>>>    #define LINK_RETRAIN_TIMEOUT HZ
>>>>>> @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct
>>>>>> cdns_pcie *pcie,
>>>>>>        /* Check if the link is up or not */
>>>>>>        for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>>>>            if (pcie_link_up(pcie)) {
>>>>>> +            /*
>>>>>> +             * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>>>>>> +             * supports Link speeds greater than 5.0 GT/s, software
>>>>>> +             * must wait a minimum of 100 ms after Link training
>>>>>> +             * completes before sending a Configuration Request.
>>>>>> +             */
>>>>>> +            if (pcie->max_link_speed > 2)
>>>>>> +                msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>>>>
>>>>> I think the above could be moved to cdns_pcie_host_start_link()
>>>>> as follows:
>>>>>
>>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-
>>>>> common.c b/
>>>>> drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>> index 2b0211870f02..0f885dcbdb12 100644
>>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>>>> @@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct
>>>>> cdns_pcie_rc *rc,
>>>>>        if (!ret && rc->quirk_retrain_flag)
>>>>>            ret = cdns_pcie_retrain(pcie, pcie_link_up);
>>>>>
>>>>> +    /*
>>>>> +     * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>>>>> +     * supports Link speeds greater than 5.0 GT/s, software
>>>>> +     * must wait a minimum of 100 ms after Link training
>>>>> +     * completes before sending a Configuration Request.
>>>>> +     */
>>>>> +    if (!ret && pcie->max_link_speed > 2)
>>>>> +        msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>>>> +
>>>>>        return ret;
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
>>>>>
>>>>> This will avoid an additional and unnecessary delay when
>>>>> 'cdns_pcie_retrain()' retrains the link.
>>>>>
>>>>> Instead of checking for the link being up using
>>>>> "pcie_link_up(pcie)", checking for 'ret' being zero should also
>>>>> work (ret being zero indicates that the link is up).
>>>>>
>>>>> Since configuration space accesses will not be performed until
>>>>> cdns_pcie_host_start_link() completes executing, it should be
>>>>> safe to switch to the above implementation.
>>>>
>>>> Hi Siddharth,
>>>>
>>>> I think this is applicable to LGA IP as per the method you
>>>> mentioned. However, for HPA IP, additional repetitive code needs to
>>>> be added in the following code.
>>>
>>> Yes, additional code is required as you rightly pointed out, but the
>>> problem I was trying to address with your patch is the following:
>>>       cdns_pcie_host_start_link()
>>>         calls cdns_pcie_host_wait_for_link()
>>>           Link is Up and we wait for 100 ms here
>>>         calls cdns_pcie_retrain()
>>>             calls cdns_pcie_host_wait_for_link() a second time
>>>               Link is Up again after retraining and we wait and
>>>               we wait an additional 100 ms here.
>>>
>>> Instead, it will be sufficient if we could wait just once after
>>> cdns_pcie_retrain() returns.
>>
>> Hi Siddharth,
>>
>> Yes, I looked at the code and indeed it works this way.
>>
>> Because of the abundance of redundant comments. I'm wondering if it's
>> possible to encapsulate a helper function in the file
>> drivers/pci/controller/pci-host-common.c, so that controller drivers like
>> dwc and cadence can call this API. Or do you know where it would be
>> appropriate to place it?
>>
>> Hello, Bjorn and Mani, I wonder what your opinions are.
> 
> Make a proposal.  Sounds fine to remove redundant comments if they
> cause confusion.  Adding a helper to make things more consistent
> across drivers also sounds fine, but it would be better to have a
> straw-man proposal to respond to.

Hi Bjorn,

Thank you for your reply. I will then prepare the next version.

Best regards,
Hans

> 
> Bjorn

