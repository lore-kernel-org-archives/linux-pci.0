Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157568;
	b=uHTnJ/AEKaD1VyqXO2tX/7HJYWC9cdFiIdRjmlU2o4RzQ/GGHEYUXMnDWfepPMTs7Rle
	 kSkgUiSoXwWUO96QJSAnLwEQpmJu6hjj121dQTv4xSxBX2RigBMjTsvrZanSpFW5OiNIE
	 8BLpU1qfBeD9ciyIEVjtEhMd4ZOgpudAktK2LJjyqMfDKWMgFqbOceNklnwniXwGmDnpB
	 yz1jHf8SfjnoyjF0MvX0xdQFB89bP5zWlLW3ElK0hNQ2008cuy9eiwX5pOUaANzH+U214
	 U2Acqo+aMNBTQqNutn38sxNgTjnV0u/zlv+3muhBHW/87vNvnuc0C6pvvBcm7bfJHCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157568;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=d0TnDNXpTSOKkU/wZ+OsWRKYPI+WZH1qEV3bCcO11Io=;
	b=ElLD/ENRUx8V0reAGkDT592+uaYxeKeEm4pZoqViMoYQUGuMLy/gpF88JEIBcg3Ink/i
	 O58M+Gxgki0V/pYOG9bIYAlXkG9OAzW3Br6dT+ZIhCpe+6N5ma9gZpoR+Oi/XmZ8Bnml7
	 Eqcdc7PQHJRXPREqBTQ6+cK53+kuQ9bUG8/PeNvkGEm+agXxnKUkSl5hL+FR8qVFra/xn
	 ea6MdEZ+Se+hJdwZBYssJWhFNbv8WaR28ne0ZwJOSaTIXwlOcvji8puDBKermkCFhWtYu
	 lAzsqN8TbYrcJRMLmnFH1hLEEz8JkGcDgjN7N6jobHVm6/Gh5MQdn+YiT0HsR6LDXpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MzWVMjzN;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1108606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1108606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MzWVMjzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=d0TnDNXpTSOKkU/wZ+OsWRKYPI+WZH1qEV3bCcO11Io=;
	b=MzWVMjzNB+Aunb0I6CPgaT0gJpqVlQGRp7urPYKPy4M8wXJ1rzLA/o2GdiMEvN
	pwctFPB09l1Mz1hQljpkTWCaq1qZtWMd8UaJwDn+0PPigoQmDB19uiRvV18FjfPX
	742AEZYlU0YChS4UdCouOmDguwXejJdhucENZ7cLvJV/o=
Message-ID: <3773fc58-a6ab-4f8d-a9a1-c865217afe84@163.com>
Date: Wed, 28 Oct 2026 11:18:51 +0800
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
To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
 linux-pci@vger.kernel.org, Frank.Li@kernel.org, neil.armstrong@linaro.org
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-2-18255117159@163.com>
 <sashiko-outbox-187403@kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <sashiko-outbox-187403@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgCn8AehaeFqDd1zCQ--.33353S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDZw4xCF1ruryxCrWktFb_yoW5Wr17pa
	9xJFyYkFWUJrW7ZFn2y3WrXr13tasxAFW7Gws3GrnavFy2yr17GF4YkrW3t3Z7GrWI9ryj
	krWaqr9ruFs5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzT5LUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AGVOWrhaaGG1wAA3T



On 10/28/26 11:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] PCI: dwc: unconfirmed offset returned in dw_pcie_get_pcie_cap()
> --
> 
> commit c6fcd840cdb57dd351ea1787cae915ad3164fb13
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: dwc: Add pcie_cap field and caching helper
> 
> This commit adds a pcie_cap field to struct dw_pcie and introduces a
> dw_pcie_get_pcie_cap() helper that lazily looks up and caches the PCI
> Express Capability offset on first use once confirmed via a DBI read-back.
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 6d788aa000117..dede6b3966585 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> [ ... ]
>> @@ -832,6 +834,42 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>>   	dw_pcie_writel_dbi(pci, reg, val);
>>   }
>>   
>> +/**
>> + * dw_pcie_get_pcie_cap() - Return the PCIe Capability offset
>> + * @pci: DWC instance
>> + *
> [ ... ]
>> + * Return: the offset of the PCIe Capability, or 0 if it could not be
>> + * found or has not been confirmed yet.
>> + */
>> +static inline u8 dw_pcie_get_pcie_cap(struct dw_pcie *pci)
>> +{
>> +	u8 cap = READ_ONCE(pci->pcie_cap);
>> +
>> +	if (!cap) {
>> +		cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +		if (cap && dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP)
>> +			WRITE_ONCE(pci->pcie_cap, cap);
>> +	}
>> +
>> +	return cap;
>> +}
> 
> [Severity: Medium]
> In drivers/pci/controller/dwc/pcie-designware.h, the kernel-doc for
> dw_pcie_get_pcie_cap() states that it returns 0 if the capability could not
> be found or has not been confirmed yet.
> 
> However, when pci->pcie_cap is 0 and transient DBI data causes
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to return a non-zero offset cap
> while the confirmation check dw_pcie_readb_dbi(pci, cap) == PCI_CAP_ID_EXP
> evaluates to false, pci->pcie_cap is left as 0, but the unconfirmed non-zero
> cap is still returned to the caller.
> 
> Callers that guard DBI writes on a non-zero return (such as
> rockchip_pcie_enable_l0s()) or cache a non-zero return in driver state (such
> as tegra_pcie_dw_host_init() setting pcie->pcie_cap_base when
> !pcie->pcie_cap_base) will then consume or permanently store the unconfirmed
> offset.
> 
> Should dw_pcie_get_pcie_cap() return 0 when the confirmation read-back fails,
> or should the kernel-doc comment be updated to match the implementation?
> 

Hi,

We have already replied to Bjorn before. According to the specification, 
the value of pcie_cap is not equal to 0.


Best regards,
Hans



