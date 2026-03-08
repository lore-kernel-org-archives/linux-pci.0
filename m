Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366C1DE8BE;
	Sun,  8 Mar 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772978483; cv=none; b=bMlnB+J8MWI9HID7jl6ieJTd44RFAFwDbRkg8tc7DFiw6N/akxbTiQ1FNjWwdAINFkFLQg4/NAfcyyRbs+CWpPMH8F32pc/oG40kKwr2eEybUqOOzswUqXPitNbmYH8efQ4vSd5fuBHgHKGTLjNhlUFNQ8akxAe/2JC+b/ewdlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772978483; c=relaxed/simple;
	bh=9rnnUsfXohKbRdAKRMWa5Mm430Jtak5oc3AGGdiq6J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdTeL+u95EQQh2nVOkUEHIWwacOZT+5x4d4xG3L6N4yP4hnO2bIqT2NV6gN15s0Ima+Q4RxVOl/LhxuWHcfcc8SNPKr5TpYz3GpZ1558tduCIJVsa2JBYtvK3mKCyzQpOx+JJrPg80miJrGkhqNYc35HlgFP55Wrp1ot86o6LBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ja/7LY64; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ja/7LY64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+v4jkSzibX0o3mm42lH3EOUtrW5WSZQxgQYaZX+A0RU=;
	b=Ja/7LY64zSe57BBQzadbTzJQTgKh9yMyxlPnIWzTNuKPHC+Unfk+dWo8wt0y7q
	w1yyga6CcSY2/Nal6UKdyA3nFWoJ8UPvm+ARLQGJR9ft5p9kN7WKyBR+D2itRv8E
	CTfmmxeBtaA80epb3cilbfEMO2N8yScwXz+Ahe8dv0yiw=
Received: from [IPV6:240e:b8f:927e:1000:60f0:8e48:72f8:8e88] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXsqISga1pklhROw--.2572S2;
	Sun, 08 Mar 2026 22:00:51 +0800 (CST)
Message-ID: <51abc012-d0f6-4f57-b9aa-0a1df6a2e91c@163.com>
Date: Sun, 8 Mar 2026 22:00:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] PCI: of: Remove max-link-speed generation
 validation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>
References: <20260306170856.GA107733@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260306170856.GA107733@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXsqISga1pklhROw--.2572S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry3Xw45Ar4kKw48KFW3KFg_yoWrAFykpF
	WjyryF9rW8Xr4rWw4Ut3W8ZFyjvwn3XrW8tryrG3ZrZwn8XFySqa4SqF1FvFnF9Fs5Cr4I
	q3W2qF47G34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRLjj9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxQrzmmtgRSLKQAA3B



On 2026/3/7 01:08, Bjorn Helgaas wrote:
> [+cc Rob]
> 
> On Thu, Dec 18, 2025 at 09:20:36PM +0800, Hans Zhang wrote:
>> The current implementation of of_pci_get_max_link_speed() validates
>> max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
>> However, this creates maintenance overhead as each new PCIe generation
>> requires updating this validation logic.
>>
>> Since device tree binding validation already enforces the allowed
>> values through the schema, and the callers of this function perform
>> their own validation checks, this intermediate validation becomes
>> redundant.
>>
>> Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
>> Gen5/Gen6 support, removing this hardcoded check enables seamless
>> support for future PCIe generations without requiring kernel updates
>> for each new speed grade.
> 
> The upcoming SoC info seems like too much detail for the commit log.
> 
>> Remove the max-link-speed > 4 validation check while retaining the
>> property existence and non-zero check. This simplifies maintenance
>> and aligns with the existing validation architecture where DT binding
>> and driver-level checks provide sufficient validation.
> 
> I don't think it's legit to rely on DT binding checks.  The code
> should protect itself regardless of what offline binding checkers
> find.
> 
> I'm not convinced that callers do their own validation.  For example,
> dw_pcie_get_resources() assigns of_pci_get_max_link_speed() to
> pci->max_link_speed with no validation at all.
> 
> That's in the DWC core, so it's probably OK to expect the actual
> controller drivers to validate pci->max_link_speed when they use it,
> but dw_pcie_config_presets() uses pcie_link_speed[pci->max_link_speed]
> and I don't see an obvious check that prevents an out-of-bounds
> reference there.
> 
> I think this patch is the right direction -- I don't think there's
> anything in drivers/pci/of.c that *uses* the value of
> "max-link-speed", so it would be nice if it didn't have to be updated
> for every generation.

Hi Bjorn,

Thank you very much for your reply.

I will resend the v7 series patch and check in the dwc code whether 
there is an array out-of-bounds issue with the maximum link speed.

Best regards,
Hans

> 
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>> ---
>> Changes for v6:
>> - It'd be good to return the actual errno as of_property_read_u32() can return
>>    -EINVAL, -ENODATA and -EOVERFLOW. (Mani)
>>
>> Changes for v5:
>> https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/
>>
>> - Delete the check for speed. (Mani)
>>
>> Changes for v4:
>> https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/
>>
>> - Add pcie_max_supported_link_speed.(Ilpo)
>>
>> Changes for v3:
>> https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/
>>
>> - Modify the commit message.
>> - Add Reviewed-by tag.
>>
>> Changes for v2:
>> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
>> - The following files have been deleted:
>>    Documentation/devicetree/bindings/pci/pci.txt
>>
>>    Update to this file again:
>>    dtschema/schemas/pci/pci-bus-common.yaml
>> ---
>>   drivers/pci/of.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..b56fdbcb3d72 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -888,10 +888,11 @@ bool of_pci_supply_present(struct device_node *np)
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
>> -- 
>> 2.34.1
>>

