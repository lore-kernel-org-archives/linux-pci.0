Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B413A1A59;
	Wed, 13 May 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673934; cv=none; b=LXULx2sWZi/OBWZpIcXAA8smktbXcCJyroRFzQNGW32QbKmMAYsP1R+g/mmbr1oq46gpSRIp5/nQmDcVw7Tc5pvkr6fnJ9OIustNqKQaz2pfmXDR/5BfKNpI5thf3atbjiLSdRNDPDU1I011qY0kIVbDS7st9sRwW1U/An9Kkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673934; c=relaxed/simple;
	bh=39nYSZaV3j83HDUonnKcXqsRKn17XSxxGgOmt1v/RPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhYcgjOu02LxNSF2Mobas9kx5JaEQsEhbbzNezR8gag+YorKs7RAijy3ylpsPQiUfKI+oS6I8JCpDqIM9oUWHMUqhjsLMx4HCXyD2fygVltxwnpqsU2OV0al6oOT9qIFtJLxcp04I+E/CzU6G1fn56GKSyDhXbu4MYGK2y0AA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ROcWTAJ4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ROcWTAJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=NoxHw9X5uLYqX0VGCmzJi8dSOhpSVxm1bkDTTdtKtL4=;
	b=ROcWTAJ4/4iBfCwUFYjSNQWRV0Fx+uhu5J73ghQUJpvVY9x4mEScyrwTNB1BeO
	p3MCJF2w9izWG3VNi+yzKh7C7h+c8C+M0A+YEdiDVuH0CzkueeRbNY6Jljn8efme
	RZvrlUfl/v8PEkdUkSiS0c2zbBEHRoT77jHR5a3i86aBA=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgB31+_gaARqvCzjDQ--.6052S2;
	Wed, 13 May 2026 20:04:48 +0800 (CST)
Message-ID: <329f790d-303e-42a5-874f-8eeb616352d7@163.com>
Date: Wed, 13 May 2026 20:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
To: Aksh Garg <a-garg7@ti.com>,
 Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <31b5f0ad-70a5-4397-8740-6808d0266a7e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgB31+_gaARqvCzjDQ--.6052S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr13Cw1kKw1xGw43XFWUJwb_yoW5ur1fpa
	9xGF1FkFs8XrW0yFn2vF1fWFyF9rn8tFW5ur1kK34Uua4qqr95ZrsYyrWj9FsxurWqkr43
	Kw48A343Aw4YyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwDtkWoEaOCTYQAA3r



On 5/13/26 19:30, Aksh Garg wrote:
> 
> 
> On 13/05/26 14:25, Hans Zhang wrote:
>>
>>
>> On 5/13/26 16:34, Aksh Garg wrote:
>>
>>>>>
>>>>
>>>> The above LTSSM states are internal LTSSM encoding states and may 
>>>> not be available for software to use.
>>>> The LTSSM states in the document pointed by Aksh (TI Soc) are the 
>>>> states  available in all cadence controllers.
>>>
>>> Is this true for HPA IPs as well? The test performed by Hans:
>>> root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
>>> L0_STATE (0x29)
>>> L0_STATE (0x29)
>>> L0_STATE (0x29)
>>>
>>> This implies that the L0_STATE LTSSM state is mapped to 0x29 (41) there,
>>> which according to your response is internal LTSSM encoding, and hence
>>> the register read should have resulted in 0x10 instead of 0x29.
>>>
>>
>> Hi Aksh,
>>
>>
>> For HPA, my view is similar to that of DWC - it requires a common 
>> internal LTSSM state. For each of its own Root Port drivers, a 
>> callback can be used to implement the reading of LTSSM. This part can 
>> be referred to as the implementation of the function in DWC.
>>
>>
>> static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
>> {
>>      u32 val;
>>
>>      if (pci->ops && pci->ops->get_ltssm)
>>          return pci->ops->get_ltssm(pci);
>>
>>      val = dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0);
>>
>>      return (enum dw_pcie_ltssm)FIELD_GET(PORT_LOGIC_LTSSM_STATE_MASK, 
>> val);
>> }
>>
>>
>> static int ltssm_status_show(struct seq_file *s, void *v)
>> {
>>      struct dw_pcie *pci = s->private;
>>      enum dw_pcie_ltssm val;
>>
>>      val = dw_pcie_get_ltssm(pci);
>>      seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), 
>> val);
>>
>>      return 0;
>> }
>>
>>
>>
>> For example, it can be modified as follows. Of course, the function 
>> name will start with "cdns".
>>
>> For LGA IP, currently we will allow each Root Port driver to implement 
>> the corresponding ops::get_ltssm() by itself.
>>
>> static int ltssm_status_show(struct seq_file *s, void *v)
>> {
>>      struct dw_pcie *pci = s->private;
>>      enum dw_pcie_ltssm val;
>>
>>      if (pci->ops && pci->ops->get_ltssm)
>>          val = pci->ops->get_ltssm(pci);
>>      else
>>          val = dw_pcie_get_ltssm(pci);
>>      seq_printf(s, "%s (0x%02x)\n", dw_pcie_ltssm_status_string(val), 
>> val);
>>
>>      return 0;
>> }
>>
> 
> The process above tells how to read the register and get the LTSSM
> state values. However, my concern is whether we require different LTSSM
> state encoding in your debugfs patch, one for LGA, and other for HPA.
> This is because the L0_state seems to have different values in the LTSSM
> fields of different IPs. On LGA, the L0_state seems to have value as
> 0x10 in the register (as can be seen in the J7200 TRM). On HPA, the
> L0_state seems to have value of 0x29 in the register (as can be seen in
> your test logs in the cover letter). Hence, if we want to print the
> LTSSM state string in the debugfs, then for LGA IPs, 0x10 value should
> print L0_STATE, and for HPA IPs, 0x41 value should print L0_state.
> 

Hi Aksh,

Yes, different codes will be used. The reason for this was because of 
the result I obtained from consulting Manikandan. This time, it was a 
problem identified by Sashiko's review. So, we need to ask you and 
Manikandan to confirm this LTSSM code again.


Best regards,
Hans

