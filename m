Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355B3537C6;
	Thu, 12 Mar 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332376; cv=none; b=C5NTjmsB8EBq20Gc7fUnoYLo4Riyg72fmWQCUp66u6+EaXJ1rlt3m5PIKQoaO7xb7W/dRJuU8g4vEkwH8QBKseAvZ2EwU9BZNRwuOpBtW/JJrhVYMQqcI558GWzgOsRqWN45Z4dgbvVwm8l6MXA8UrAgs5UDshCs/xuFfqUj2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332376; c=relaxed/simple;
	bh=sq23CloKbyRwC39uUMgOHC1mIdTGEOUJLoAZdJtI6ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1QIWarH0+MK906dauCBvE3OI83CfZQM/l2ln4g5xzfhcsSy0YojiNZhGTIBG5skp+x5tSRrJU5wKnKrkRSUPgzS7ax5Y7n3+0aylulrMqOdqusvmwh2AfXW4Oy58BRmVUMpNyvkwYQvlcLMTG2JCU7Q4mbNWPlHuWm9kzsMMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q4JbzW+M; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q4JbzW+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=sYAp2VSnYxks6oevHvjdp6DJcqQc1zpAQ6ueXOh7CV8=;
	b=Q4JbzW+MmpfDmA0jj/nUjiqiveAVIvCrEe10/h2pf2EgNLlPcVn2RlDiSwHflB
	vF9KV8oqm9YVSnsdVRMEhigLNwrcmwpRbKWwviZnz1mcJfCTd/fvkQGqgwyWiO71
	6D+zp37aALzA5m54NLGRHP2fEX49pjpAa/koYzFewLEMw=
Received: from [IPV6:240e:b8f:927e:1000:1caf:6d92:f4ee:5e02] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3n+Ng57Jp21l6VQ--.25885S2;
	Fri, 13 Mar 2026 00:18:41 +0800 (CST)
Message-ID: <26c5ad7d-4685-467a-8e34-9580586d7eb6@163.com>
Date: Fri, 13 Mar 2026 00:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260310223717.GA835760@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260310223717.GA835760@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgD3n+Ng57Jp21l6VQ--.25885S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF45KF4UWr1DGr1rtFykAFb_yoWrJFWkpF
	W2yr1Y9r1UJF45Xr47Ja1rZa4Y9wnxWrWUtr15Gw1kur13ZFsxtFy2qFyaqF9a9r9rZr12
	qa1aqFsrCa4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnFxbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AEZvGmy52FdZQAA3t



On 2026/3/11 06:37, Bjorn Helgaas wrote:
> On Sun, Mar 08, 2026 at 10:26:28PM +0800, Hans Zhang wrote:
>> The of_pci_get_max_link_speed() function currently validates the
>> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
>> This imposes a maintenance burden because each new PCIe generation
>> would require updating this validation.
>>
>> Remove the range check so the function returns the raw property value
>> (or a negative error code if the property is missing or malformed).
>> Callers must now validate the returned speed against the range they
>> support.  A subsequent patch adds such validation to the DWC driver,
>> which is the primary user of this function.
>>
>> This change allows future PCIe generations to be supported without
>> modifying drivers/pci/of.c.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Mani's right that we shouldn't have a window without any validation.
> I hope I didn't otherwise.
> 
>> ---
>>   drivers/pci/of.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 9f8eb5df279e..cff5fd337c2b 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -889,10 +889,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>>   int of_pci_get_max_link_speed(struct device_node *node)
>>   {
>>   	u32 max_link_speed;
>> +	int ret;
>>   
>> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -	    max_link_speed == 0 || max_link_speed > 4)
>> -		return -EINVAL;
>> +	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
>> +	if (ret)
>> +		return ret;
>>   
>>   	return max_link_speed;
>>   }
> 
>  From AI review (gemini/gemini-3.1-pro-preview):
> 
>    By removing the upper bounds check here, the returned max_link_speed
>    value can now be arbitrarily large if configured incorrectly in the
>    device tree. While the commit message notes that a subsequent patch
>    adds validation to the DWC driver, there are several other callers
>    in the tree that assume the returned value is bounded. These drivers
>    remain vulnerable to out-of-bounds accesses and hardware
>    misconfiguration at the end of this patch series.
> 
>    For example, in drivers/pci/controller/pcie-rzg3s-host.c, the
>    returned value is used directly as an array index. Could this cause
>    an out-of-bounds read on pcie_link_speed[]?
> 
> I think this is a valid concern, and I think we should protect
> pcie_link_speed[] by making it static and accessing it via a function
> that validates the index.  It's too hard to enforce validation at
> every place that uses it.
> 
> I think you're going to have to:
> 
>    - Validate every use of dw_pcie.max_link_speed (set from
>      of_pci_get_max_link_speed()) in the dwc glue drivers
> 
>    - Validate the return from of_pci_get_max_link_speed() at every
>      other caller.  It looks like j721e_pcie_set_link_speed(),
>      brcm_pcie_probe(), mtk_pcie_setup(), rzg3s_pcie_probe() would need
>      that.
> 
> Right now we validate inside of_pci_get_max_link_speed(), which can
> help avoid generic problems like indexing pcie_link_speed[], but it
> can't account for individual driver restrictions.  So I do still think
> you're right to move it from drivers/pci/of.c to the individual
> drivers because those drivers are where it's really important, and it
> avoids changing a common place for driver-specific reasons.  We're
> just going to have to strictly enforce it in those drivers.

Hi Bjorn,

Thank you very much for your reply. The V8 series will be sent to you 
for review shortly. If there are any issues, I will make the corrections 
again.

Best regards,
Hans

