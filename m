Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD2309EE9;
	Mon,  6 Apr 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775442216; cv=none; b=njlVkdxOyKzRGEAfgrea98KjboWLhb/1Rvd9uPKCgJ5hp4R/T0K21Af3sRLKkZRy/B72x0Vh1u+oKu2NWCcoHvEWw+FuNre4uy/7r63jIDcwHB3mDa7bRTgLo4FAxdKbC4Z/Xrwa+TDdCGwBOjECnJXkCpeXnrreh3w3QZ91iF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775442216; c=relaxed/simple;
	bh=qgH5lLMPz12kcMtpYmHSsDNTWuj9PjnekwQx2BCuQ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqqo7MiQ/DGSOSMz8qWrrocvlREtYg60B5LO3QADf+XtUtdL6dE/sG/9QkS47mBIYO4sbPEskh7Km61+kJ+qXME5ysyRIS4CKPtfmHht57Crkw9iCWVtRfSAHH/9oL0/GH12zTwsrMyHjhmghxay/Lg/hSQuD3sP6OjXDCwIiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KqSEVf3a; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KqSEVf3a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YECcG1HVAHm+5vEAAqi3wT4vV8qbA8EnX2Cnublm+OU=;
	b=KqSEVf3aUGyhkwhiI9ksP8PKca7i2SqBPQ5wrFlsYHuuJ/zYkQiaZIM7SySJrU
	1cAbQPaulVFQ0v9XUvGIaYXbkjywxSEsFVgM46YTORHlG/Mxi1ech3A3/gc3fw7Y
	8DPdAMyd8EYqc80vJb3daKFRMr97Fw8F/c6O/V6lEXC+A=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnYK_qGNNpQQMTVA--.221S2;
	Mon, 06 Apr 2026 10:22:37 +0800 (CST)
Message-ID: <16f61139-5feb-4c90-acea-80dda81d113a@163.com>
Date: Mon, 6 Apr 2026 10:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] PCI: dwc: Use common speed conversion function
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102143206.111347-1-18255117159@163.com>
 <20251102143206.111347-4-18255117159@163.com>
 <haordo3chzioc36ciby6x44eyullcacqyoyas636urrhjexk2g@pe6htoghrd6p>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <haordo3chzioc36ciby6x44eyullcacqyoyas636urrhjexk2g@pe6htoghrd6p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDnYK_qGNNpQQMTVA--.221S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr45Cw43CFW3Cw1DJFyUGFg_yoW8tFyxpa
	y3AF40yF48JF45uan0ga4kXFyUXFnxCrWDGrW5Was5XFy2y3s3XF18Zr4Sqr9I9FZFyr1x
	ur17JrW7Gw17tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UerWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCww2QNGnTGO3klwAA3W



On 4/5/26 00:35, Manivannan Sadhasivam wrote:
> On Sun, Nov 02, 2025 at 10:32:06PM +0800, Hans Zhang wrote:
>> Replace the private switch-based speed conversion in
>> dw_pcie_link_set_max_speed() with the public pci_bus_speed2lnkctl2()
>> function.
>>
>> This eliminates duplicate conversion logic and ensures consistency with
>> other PCIe drivers, while handling invalid speeds by falling back to
>> hardware capabilities.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> I hope Bjorn will merge this series.


Hi Mani,

Thank you. Since the pci-next branch has removed the direct reference to 
pcie_link_speed, I will re-create this series of patches based on the 
pci-next branch or v7.1-rc1.

Best regards,
Hans

> 
> - Mani
> 
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>>   1 file changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index c644216995f6..20ba314e82d5 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -717,24 +717,12 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>>   	ctrl2 = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
>>   	ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
>>   
>> -	switch (pcie_link_speed[pci->max_link_speed]) {
>> -	case PCIE_SPEED_2_5GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_2_5GT;
>> -		break;
>> -	case PCIE_SPEED_5_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
>> -		break;
>> -	case PCIE_SPEED_8_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
>> -		break;
>> -	case PCIE_SPEED_16_0GT:
>> -		link_speed = PCI_EXP_LNKCTL2_TLS_16_0GT;
>> -		break;
>> -	default:
>> +	link_speed = pcie_link_speed[pci->max_link_speed];
>> +	link_speed = pci_bus_speed2lnkctl2(link_speed);
>> +	if (link_speed == 0) {
>>   		/* Use hardware capability */
>>   		link_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, cap);
>>   		ctrl2 &= ~PCI_EXP_LNKCTL2_HASD;
>> -		break;
>>   	}
>>   
>>   	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, ctrl2 | link_speed);
>> -- 
>> 2.34.1
>>
> 

