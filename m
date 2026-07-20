Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF1306749
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561294; cv=none; b=gC1SB0uzG6tF+A/DBPamaTobnmx53e8COuyudG6+G+VkcoAs5PuLIV9nw7mSSRXcJH9zPGuABextMm2MfGC3PlQr3xzuRw0AoGZauodrL624ExslybhZUGg3G9jEde0AIW9FsYeH7c1ZVhX96ZiFEfF3O6ll46hxpRz2VeKQYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561294; c=relaxed/simple;
	bh=jreQu3izKdVk4O8ukNsef/vgS1gc0C06TEXby33qvVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af+dY32X86BX7fhFI51zELRMUU9YTmaEe0F43Sf4I6zHK37+NhHXA23Mw9KPsfQ59+GiciG9y/okUfIWlYY1HkniBtj/XvWB0KbJoR+XfI3XO/hz6yjcYTc9JjOQx4qrz/sNsI3USTaOfvpY3FpQ1BonwEeZxnPJiWr5uiBqfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oozf8t22; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oozf8t22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qcO4Jx5AKS6Igcf3/JaMxYeNZarJWUVQHogxhHenLsQ=;
	b=oozf8t223x6rPeIKh3fmOHRTrFfQEJHXO5I1LTSkPyUvi/v8oNl9euSwX9hk7I
	7ChfbVtq4Tabfm7+2t+8vO2eg3/K57yr/35p3O6QNrVqgqRe5NgCzUppEu/soTNh
	tHyP1Aeb9EwpaW0sBzrazvG0R3Qsk5QBmpK21+/Za7DRU=
Received: from [IPV6:240e:b8f:91b3:d000:f138:f837:e143:4264] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD31y5hPl5qiykBKQ--.65457S2;
	Mon, 20 Jul 2026 23:27:30 +0800 (CST)
Message-ID: <7b76cdd1-1001-4d2d-a221-33988261faf9@163.com>
Date: Mon, 20 Jul 2026 23:27:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] PCI: dwc: Add pcie_cap field and helper in
 designware header
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-2-18255117159@163.com>
 <20260720151732.7B9A41F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260720151732.7B9A41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD31y5hPl5qiykBKQ--.65457S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW5WF1UurW5ZFyUXFWfuFg_yoW8Kr1Upa
	9xJFyayF48JF43ZF97Aa15WF1akF9IyFy3G3y3G34fZFya9F17Ka1FyrWrKF17GrZ7Kr1Y
	kr4UtF9xCrn5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4BTOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7APZfWpePmPkIQAA3n



On 7/20/26 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Data race and logically flawed caching in dw_pcie_get_pcie_cap() due to unprotected read-modify-write and failure to cache 'not found' state.
> --
> 
> --- Patch [1]: [PATCH v3 01/16] PCI: dwc: Add pcie_cap field and helper in designware header ---
> commit ab22dc6f534d77b34df13c99dd929771547f5ff1
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: dwc: Add pcie_cap field and helper in designware header
> 
> This commit adds a pcie_cap field to struct dw_pcie to cache the offset of
> the PCI Express Capability structure. It introduces dw_pcie_get_pcie_cap()
> to perform the capability search on the first call and cache the result.
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> [ ... ]
>> @@ -829,6 +831,21 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>>   	dw_pcie_writel_dbi(pci, reg, val);
>>   }
>>   
>> +/**
>> + * dw_pcie_get_pcie_cap() - Return cached PCIe Capability offset
>> + * @pci: DWC instance
>> + *
>> + * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
>> + * Returns 0 if the capability is not present.
>> + */
>> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
>> +{
>> +	if (!pci->pcie_cap)
>> +		pci->pcie_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> 
> [Severity: Medium]
> Will this repeatedly search the configuration space if the capability is
> not found? If dw_pcie_find_capability() returns 0 when the capability is
> missing, pci->pcie_cap will remain 0, causing the search to be repeated
> on every subsequent call instead of being cached.
> 
> Also, since this helper might be called concurrently by different threads,
> could the unprotected read and write to pci->pcie_cap cause a data race?
> 

Hi,

As mentioned in the previous reply, there is no need for us to worry 
about this.

https://lore.kernel.org/linux-pci/5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com/


Best regards,
Hans


>> +
>> +	return pci->pcie_cap;
>> +}
> 

