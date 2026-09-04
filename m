Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B37503BD5;
	Fri,  4 Sep 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539583; cv=none; b=Uv8DdMGOZzaNPiCaREFiaU+J5aGnw/dX5QtipYxOYwCkWZk6+YTAvSRoZNQ+aDg8OmRP8wJhWqJXpSQ1moBfwlczkGVrv8fMtBmZh05X83WJ/EYmSCe98tUU1XOPHxh/+DxJqLMqgM6VVDbVDaEKxPuGI+ArKlazr4gZ/obTcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539583; c=relaxed/simple;
	bh=PsJg1897VlUxWP6HRMzBvbZknxzRbYho/mJd1blxZUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCnmCcMTObTmRpKtTkMk25sdal8bhcynwvp4YWozXKxD+cwjsr/2tkjFBywRjxpqHcKv7zgFXaJBSaeVaD+Q1jlrcAszoVMslkD1g8UdIfDsEoEwRWi1DRArNMnH3Ygl54b9ZMOjqXYmawk5bWUQbRGh5QLDCg03+q0PzKpmclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HncCxS6Q; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HncCxS6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=D73+Lw6lDTZZGE8DKePAMYQBhMEcGIxUQ+Nz85ARoAs=;
	b=HncCxS6QUOMQ/pccClxhmpAt/wDqcaIIBbJblUJY3M9uiOgvTQlhn/1xpPdK8I
	JWiP8OFny7FhV29PJwZ3dCZQM92bWjx9lm9IenSiDNaRjNecx8CsQF9rOIEp+9ty
	8XLHOF8ZauEhr/Z4STbfLTDfJr5megQNnFfeOP8GiN9/o=
Received: from [IPV6:240e:b8f:91b3:d000:cb89:e59c:b7d0:5b84] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnFyue8ppq3aEFQA--.23653S2;
	Sat, 05 Sep 2026 00:32:31 +0800 (CST)
Message-ID: <7eb29846-7561-4ead-9a05-0c5966de5fd6@163.com>
Date: Sat, 5 Sep 2026 00:32:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: dwc: Rename PCIE_PORT_LINK_CONTROL to
 PORT_LINK_CTRL_OFF
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, a-garg7@ti.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Feizhou Yu <yufeizhou201@163.com>
References: <20260904161250.GA2318713@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260904161250.GA2318713@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgBnFyue8ppq3aEFQA--.23653S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy7JFyUJrW5Wr4xZF4UCFg_yoWrKFW7pa
	y5tF1FkF1DAa13Z3Wjkas7ZF4aq3ZxtFWUCrs7K3Zru3Z3Ary8KF18tF1aqrn7XF4Iqr4Y
	yr42qFZxuFy3A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoqcUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x8lyGqa8p-mBgAA3k



On 9/5/26 00:12, Bjorn Helgaas wrote:
> On Fri, Sep 04, 2026 at 02:18:23PM +0800, Hans Zhang wrote:
>> The register at offset 0x710 is documented in the Synopsys DesignWare
>> PCIe Controller Reference Manual as "PORT_LINK_CTRL_OFF" (Port Link
>> Control Register). The current macro name PCIE_PORT_LINK_CONTROL does
>> not match the documentation, making it difficult to cross-reference
>> with the spec when debugging or maintaining the code.
> 
> I'm a little skeptical about this change.  I agree it's good to match
> the spec, and the leading "PCIE_" seems superfluous.  But I think it's
> pointless to add "_OFF" to every register offset.  "PORT_LINK_CTRL"
> seems like enough, and it's pretty close to the spec's name.
> 
> Adding "_OFF" also invites confusion: does it mean "offset" or "off"
> (the opposite of "on")?

Hi Bjorn,

I checked the official documentation of Synopsys. It seems that the 
suffix "_OFF" is added to each register, and it appears to mean "offset".

> 
> It's also nice if names of fields within a register include the
> register name, e.g., PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC, etc.
> For long register names like PCIE_PORT_MULTI_LANE_CTRL, with a
> PORT_MLTI_UPCFG_SUPPORT field, you have squint pretty hard to see the
> connection between the register and the field, but a name like
> "PCIE_PORT_MULTI_LANE_CTRL_UPCFG_SUPPORT" would be just ridiculous.

I agree with what you said. The official documentation of Synopsys 
currently defines it this way. If the naming is simplified, it would 
make it harder to search for where the registers are located. This is 
one of the purposes of this modification.



I will send a document to you and Mani. Or there might be a better way 
that I would be very happy to accept. I will also make the necessary 
modifications according to your preferences.

Best regards,
Hans

> 
>> Rename the macro to PORT_LINK_CTRL_OFF to align with the Synopsys
>> documentation, and update all usage sites accordingly. No functional
>> change is intended.
>>
>> This improves code maintainability and eases future reference to the
>> controller manual.
>>
>> Co-developed-by: Feizhou Yu <yufeizhou201@163.com>
>> Signed-off-by: Feizhou Yu <yufeizhou201@163.com>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
>>   drivers/pci/controller/dwc/pcie-designware.h | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 593388f29bdd..9a0d8f0be792 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -894,7 +894,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>>   		return;
>>   
>>   	/* Set the number of lanes */
>> -	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>> +	plc = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
>>   	plc &= ~PORT_LINK_FAST_LINK_MODE;
>>   	plc &= ~PORT_LINK_MODE_MASK;
>>   
>> @@ -922,7 +922,7 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>>   		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
>>   		return;
>>   	}
>> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>> +	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, plc);
>>   	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
>>   
>>   	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> @@ -1295,10 +1295,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>   		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>>   	}
>>   
>> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>> +	val = dw_pcie_readl_dbi(pci, PORT_LINK_CTRL_OFF);
>>   	val &= ~PORT_LINK_FAST_LINK_MODE;
>>   	val |= PORT_LINK_DLL_LINK_EN;
>> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>> +	dw_pcie_writel_dbi(pci, PORT_LINK_CTRL_OFF, val);
>>   
>>   	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>>   }
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 0735ae940924..77420230433b 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -87,7 +87,7 @@
>>   #define PORT_AFR_L1_ENTRANCE_LAT_SHIFT	27
>>   #define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
>>   
>> -#define PCIE_PORT_LINK_CONTROL		0x710
>> +#define PORT_LINK_CTRL_OFF		0x710
>>   #define PORT_LINK_DLL_LINK_EN		BIT(5)
>>   #define PORT_LINK_FAST_LINK_MODE	BIT(7)
>>   #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
>> -- 
>> 2.43.0
>>

