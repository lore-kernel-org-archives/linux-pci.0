Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1582253FC;
	Thu, 14 May 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723206; cv=none; b=X6v0HGmW7M/g2SZxA5SaFemD7UPaHJq8IfFQW+Aik+j0W2kU5FZLIcBqNKOod/6IWvoHWGDBPgExTHHEAx1CpVwA1i1Io/DwhwJBLyvzKleWthStxuDVMlQrwSHcLszicZHi+p/VEztPQOwXrKK+ZRA3+jU899U4Fzxqyav/nN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723206; c=relaxed/simple;
	bh=f/hkcqIzRUMHPXt1aypGSMnQFyaRsV77DzcTCmx251A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOSCquVTaUZApXlMO4Ur+T97fCTOWIiqfDwTc2gOwNj9VWhfPphM80iL2duBd3ZZ6tJZjSN4YVmeCgmQs6iJGiFY9rz9dQWo1uKtXyEWF90U9ST9gsB1Yiq/gnrf1BCFeEtR/TfpcK7ETIUikIe/dD9mX6RIeHtU4YQOsn/rlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pkz4fW6x; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pkz4fW6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=cgSEJ6D5AkfR1qbfwbLbASRN014sxIaLtXsGm7hxCAg=;
	b=Pkz4fW6xFPSe+RSmpbzME6uL1OJRSgY7qeCkstxlPiHAwTDtL2lVZd2MMomyVG
	lOysBGF2L/imkGhoDAbXs9xalwwD78Sn49JKvmhdAPuCc078ovPLSuEYmVEdRPaU
	9rrzhS0fEzc7SpZpaks/NYHAV4o24spMgJwWPgIlIkbkw=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnmgtdKQVqNm7ZEQ--.48441S2;
	Thu, 14 May 2026 09:46:06 +0800 (CST)
Message-ID: <156f44d7-0adc-49ce-be6a-5b875a2c97fd@163.com>
Date: Thu, 14 May 2026 09:46:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 Aksh Garg <a-garg7@ti.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260508034101.1910036-1-18255117159@163.com>
 <20260508034101.1910036-3-18255117159@163.com>
 <3ab81da4-a745-4e85-8aa3-3a217e3fdcbe@ti.com>
 <BY5PR07MB6705FFD54E7D97EF5AB0A211A2062@BY5PR07MB6705.namprd07.prod.outlook.com>
 <f8ada2e3-15c2-43b1-b013-2f3fd263f25f@ti.com>
 <c0bd820d-9716-4109-9d5e-7e72e0716cf1@163.com>
 <31b5f0ad-70a5-4397-8740-6808d0266a7e@ti.com>
 <329f790d-303e-42a5-874f-8eeb616352d7@163.com>
 <DM6PR07MB671631B20C59B8760D728A3EA2072@DM6PR07MB6716.namprd07.prod.outlook.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <DM6PR07MB671631B20C59B8760D728A3EA2072@DM6PR07MB6716.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnmgtdKQVqNm7ZEQ--.48441S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryfJw18Gw47JFW7Kw4UJwb_yoWrZr17pa
	98GF1YkFs8Xry0yFn2qF15XF98tr15JF45ur1kt34UWas0qr90vrs8trWj9FZrCrWDKr47
	tw4xAry3ZFWYyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5-BiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwx894GoFKV-5yQAA3o



On 5/14/26 09:39, Manikandan Karunakaran Pillai wrote:
>>>> On 5/13/26 16:34, Aksh Garg wrote:
>>>>
>>>>>>>
>>>>>>
>>>>>> The above LTSSM states are internal LTSSM encoding states and may
>>>>>> not be available for software to use.
>>>>>> The LTSSM states in the document pointed by Aksh (TI Soc) are the
>>>>>> states  available in all cadence controllers.
>>>>>
>>>>> Is this true for HPA IPs as well? The test performed by Hans:
>>>>> root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
>>>>> L0_STATE (0x29)
>>>>> L0_STATE (0x29)
>>>>> L0_STATE (0x29)
>>>>>
>>>>> This implies that the L0_STATE LTSSM state is mapped to 0x29 (41) there,
>>>>> which according to your response is internal LTSSM encoding, and hence
>>>>> the register read should have resulted in 0x10 instead of 0x29.
>>>>>
>>>>
>>>> Hi Aksh,
>>>>
>>>>
>>>> For HPA, my view is similar to that of DWC - it requires a common
>>>> internal LTSSM state. For each of its own Root Port drivers, a
>>>> callback can be used to implement the reading of LTSSM. This part can
>>>> be referred to as the implementation of the function in DWC.
>>>>
>>>>
>>>> static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>>>> {
>>>>       u32 val;
>>>>
>>>>       if (pci->ops && pci->ops->get_ltssm)
>>>>           return pci->ops->get_ltssm(pci);
>>>>
>>>>       val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
>>>>
>>>>       return (enum
>> dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK,
>>>> val);
>>>> }
>>>>
>>>>
>>>> static int ltssm_status_show(struct seq_file *s, void *v)
>>>> {
>>>>       struct dw_pcie *pci = s->private;
>>>>       enum dw_pcie_ltssm val;
>>>>
>>>>       val = dw_pcie_get_ltssm(pci);
>>>>       seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val),
>>>> val);
>>>>
>>>>       return 0;
>>>> }
>>>>
>>>>
>>>>
>>>> For example, it can be modified as follows. Of course, the function
>>>> name will start with "cdns".
>>>>
>>>> For LGA IP, currently we will allow each Root Port driver to implement
>>>> the corresponding ops::get_ltssm() by itself.
>>>>
>>>> static int ltssm_status_show(struct seq_file *s, void *v)
>>>> {
>>>>       struct dw_pcie *pci = s->private;
>>>>       enum dw_pcie_ltssm val;
>>>>
>>>>       if (pci->ops && pci->ops->get_ltssm)
>>>>           val = pci->ops->get_ltssm(pci);
>>>>       else
>>>>           val = dw_pcie_get_ltssm(pci);
>>>>       seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val),
>>>> val);
>>>>
>>>>       return 0;
>>>> }
>>>>
>>>
>>> The process above tells how to read the register and get the LTSSM
>>> state values. However, my concern is whether we require different LTSSM
>>> state encoding in your debugfs patch, one for LGA, and other for HPA.
>>> This is because the L0_state seems to have different values in the LTSSM
>>> fields of different IPs. On LGA, the L0_state seems to have value as
>>> 0x10 in the register (as can be seen in the J7200 TRM). On HPA, the
>>> L0_state seems to have value of 0x29 in the register (as can be seen in
>>> your test logs in the cover letter). Hence, if we want to print the
>>> LTSSM state string in the debugfs, then for LGA IPs, 0x10 value should
>>> print L0_STATE, and for HPA IPs, 0x41 value should print L0_state.
>>>
>>
>> Hi Aksh,
>>
>> Yes, different codes will be used. The reason for this was because of
>> the result I obtained from consulting Manikandan. This time, it was a
>> problem identified by Sashiko's review. So, we need to ask you and
>> Manikandan to confirm this LTSSM code again.
>>
>>
>> Best regards,
>> Hans
> 
> The LTSSM codes are the same across HPA and LGA. You have to refer to "External LTSSM state encoding" table in
> the specification given by cadence.
> 

Hi Manikandan,


Are there 128 different states? If they are the same, for the LGA IP, 
which register should I read?

Previously, Sashiko reported a problem with the review. Please click on 
the following link:

https://lore.kernel.org/linux-pci/20260508041956.C8F10C2BCB0@smtp.kernel.org/


"""
 > +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)

Does this mask need to be extended to cover all possible states?

This mask covers only 6 bits, allowing it to extract values up to 63.
However, the cdns_pcie_ltssm enum defines states up to 127. If the
hardware enters a state 64 or higher, FIELD_GET will silently truncate
the value, making state 65 appear as state 1.

"""


Best regards,
Hans


