Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073349;
	b=fDRyj6x1gRzkMzRNG5vE/K6qyEdMAE3rzgIgTsnAcAlncdhc5pVdaUPN3x/mUIjz9XHh
	 namreGz4DYcimXbpKCixhbQY5N8Rv9oZ8TUP07IbD6jwkR5Nj2eTlx5CQPCRlLCg4HhxW
	 ZjgfOv7a7gpnzeBzbjbgKJuhCNGGqH+S6YAGG+WUUG+9fnZZbPfc8cQpPIcT5ou2N7rAu
	 XwFL4eFo4jH+t4/roBvpg3XS7GYyIiDOxDkwKa9+FxkW60sYuTR7aEl6gqCN2jEQ0qzG1
	 ODKFXYktdKXdARjlNvOE38oBNhYtcF6PHqbncJL+IK9rSuzDZxPEVcsm7TRonIeS0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073349;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=T0TcPMhnJboefGjG0dX42ucxF+Z41m2N3+6Nxl59W/o=;
	b=P0TTxFB7Ep7OUeptu9wLug9LrDiEb1tPtl6VrAA4LodF0uj/JpppyQTzgljc4SNWsEso
	 Rd5yQXCXC49B4oE7uCBleB0GwuT8QfkgZU+/FQe7drYGEKJ36bLFoEN4JRQ9ykr+N/+Yj
	 wBzd6fEDmYtcYfx9EjOJ9IYcorG4PqInTHRmkgfbbNYz+Sxux14F7mjDiFrSUCbcRdxHV
	 cHpHnHsKfR10eOFuioRwSzJIOjj8CYasdJhIlSjuLgPbk+sZHnBpsuOxPB5JcPnnaiZKT
	 5s9qJJe26c65AA9ppwhxYF16gFLkFLxxMfsgf+rf6yw8ZFh82VPyN7o9kVcCp3R/eOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Fi221Vvl;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E6606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 673E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Fi221Vvl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=T0TcPMhnJboefGjG0dX42ucxF+Z41m2N3+6Nxl59W/o=;
	b=Fi221VvloIkNvZbdj3lKq+HdEGQPtgHh2/PWzntI6Mo1izjyXJ/McQnd04eCYp
	o2csqEQI2t/NQWx37zq1bOGSzaay7/KWf4DsGH/z0mxkNGlwWn1R7g0tBzh6JUl+
	jjOWCsqtGE3wci9D6Uv8uEGJn/w+SLk1nn1NzgnoJLxzo=
Received: from [IPV6:240e:b8f:91b3:d000:dbd3:438:3de0:f148] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYznHYu9qSfN5Eg--.55065S2;
	Sun, 08 Nov 2026 01:41:27 +0800 (CST)
Message-ID: <5512a99d-9c72-4988-aa94-0826d098a09d@163.com>
Date: Sun, 8 Nov 2026 01:41:27 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] PCI: dwc: Add pcie_cap field and caching helper
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, imx@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
 Frank.Li@kernel.org, neil.armstrong@linaro.org
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-2-18255117159@163.com>
 <sashiko-outbox-187403@kernel.org>
 <3773fc58-a6ab-4f8d-a9a1-c865217afe84@163.com>
 <179399401605.55876.3520713514569261990.b4-reply@b4>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <179399401605.55876.3520713514569261990.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgDHYznHYu9qSfN5Eg--.55065S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF43Cw48AFWfArWUCFy3Arb_yoWrGr18p3
	9rJayYyF4DJr42vFnFv3WrXrnIyasxAFW7WwnrGrnIvr9Fyr17KF4ayFWjg3Z7GrWIkr1j
	9rWaqr9ruFn8JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUzVbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wdgBGrvYsdbgQAA3y



On 11/7/26 03:40, Manivannan Sadhasivam wrote:
> On 2026-10-28 11:18 +0800, Hans Zhang wrote:
>>
>>
>> On 10/28/26 11:15, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] PCI: dwc: unconfirmed offset returned in dw_pcie_get_pcie_cap()
>>> --
>>>
>>> commit c6fcd840cdb57dd351ea1787cae915ad3164fb13
>>> Author: Hans Zhang <18255117159@163.com>
>>>
>>> PCI: dwc: Add pcie_cap field and caching helper
>>>
>>> This commit adds a pcie_cap field to struct dw_pcie and introduces a
>>> dw_pcie_get_pcie_cap() helper that lazily looks up and caches the PCI
>>> Express Capability offset on first use once confirmed via a DBI read-back.
>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>>> index 6d788aa000117..dede6b3966585 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> [ ... ]
>>>> @@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>>>>    	dw_pcie_writel_dbi(pci, reg, val);
>>>>    }
>>>>    
>>>> +/**
>>>> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
>>>> + * @pci: DWC instance
>>>> + *
>>> [ ... ]
>>>> + * Return: the offset of the PCIe Capability, or 0 if it could not be
>>>> + * found or has not been confirmed yet.
>>>> + */
>>>> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
>>>> +{
>>>> +	u8 cap = READ_ONCE(pci->pcie_cap);
>>>> +
>>>> +	if (!cap) {
>>>> +		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>>> +		if (cap && dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP)
>>>> +			WRITE_ONCE(pci->pcie_cap, cap);
>>>> +	}
>>>> +
>>>> +	return cap;
>>>> +}
>>>
>>> [Severity: Medium]
>>> In drivers/pci/controller/dwc/pcie-designware.h, the kernel-doc for
>>> dw_pcie_get_pcie_cap() states that it returns 0 if the capability could not
>>> be found or has not been confirmed yet.
>>>
>>> However, when pci->pcie_cap is 0 and transient DBI data causes
>>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to return a non-zero offset cap
>>> while the confirmation check dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP
>>> evaluates to false, pci->pcie_cap is left as 0, but the unconfirmed non-zero
>>> cap is still returned to the caller.
>>>
>>> Callers that guard DBI writes on a non-zero return (such as
>>> rockchip_pcie_enable_l0s()) or cache a non-zero return in driver state (such
>>> as tegra_pcie_dw_host_init() setting pcie->pcie_cap_base when
>>> !pcie->pcie_cap_base) will then consume or permanently store the unconfirmed
>>> offset.
>>>
>>> Should dw_pcie_get_pcie_cap() return 0 when the confirmation read-back fails,
>>> or should the kernel-doc comment be updated to match the implementation?
>>>
>>
>> Hi,
>>
>> We have already replied to Bjorn before. According to the specification,
>> the value of pcie_cap is not equal to 0.
>>
> 
> Then please update the stale the kernel doc.

Hello Mani,

How about modifying it to "stale the kernel documentation"? If the 
description below is valid, do I still need to send the v6 series patch?


+ * A DBI read issued while the controller is not accessible returns
+ * platform specific data, and a transient bogus value must not stick in
+ * the cache.  The offset is therefore only cached once the capability
+ * ID has been read back at that offset.  If the read-back does not
+ * confirm the capability, the offset is still returned for the current
+ * access but not cached, so the next call performs the lookup again.
+ *
+ * Return: the offset of the PCIe Capability, or 0 if it could not be
+ * found.


Best regards,
Hans

