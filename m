Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3751A6811;
	Wed, 30 Sep 2026 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731722; cv=none; b=XdHyxIYKEbMJ91e6YQhZ8a6/K2/QyQ9z9XJkGycsJXOa6CTVNboJHWMubx28UUVntQsoSPpQP7fNPArVgCWqkOYxaeJWc85ogAX7vwdvQ/V8eb6GBhyRHBisTl0rbHAnD8/LY0RN44bDT5Cv7SynO28LwqspiW3NJMd5eI+7R08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731722; c=relaxed/simple;
	bh=URq4TpIYI+NXTK4BAUeL7vsLy98CUY12sWfdNUO8bWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgVzhbWaqJ5K4YIi5EEH5Xo8i6vfLqh7Z0R9Dwz46LpyEPvT3+sGK5Dftll6YunQ+for2KtSVtKoEbtkjcefZ9Rw4arMfmeCPo+OR79uAvUS0QpyvMDqtX2D0rbzs3/ITGoX/n1k7OvjNoxbGGPUAq8c1V803D7jBYP8EBSggPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jjxRzqGT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jjxRzqGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=y4LgJcxG58FFth/hB4/i7KbJf2H3darIqdWGj6YwQ/s=;
	b=jjxRzqGTAYcYRKiHAHIVCbgcrTAW/dqGYAbEjBqLST5e81bz9cyk0EZOljUVwv
	YiJa/Qmillt5urd1n7wlLmwWLeZsQ1fa4RAfaXMcwGZ/bPW/TLSwG1u5fDjNQeps
	hUs5bBmyQ9VD2y8ZPgKQuBMw6abZAk8KFv2VpQlN1AmQw=
Message-ID: <e8a9863f-d4ea-4796-8dfe-c59f5e379687@163.com>
Date: Wed, 30 Sep 2026 09:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Align register macros with Synopsys
 documentation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com, pali@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Feizhou Yu <yufeizhou201@163.com>
References: <20260928215110.GA2266447@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260928215110.GA2266447@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3B4aDZbxq7D5eBg--.58103S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWkWw1fJFy3Ary3Wr17Jrb_yoW8urWxpa
	1xJF4rtw4DXF4aqw4Ig3WrX3W7Xrn3JrZ8X3yvqw18tan5Xr93Gr40grWjkFWkZrn3Kr1j
	qr4jq3yxWry3Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC2NNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwRE52q8ZYQf4QAA3t



On 9/29/26 05:51, Bjorn Helgaas wrote:
> On Mon, Sep 28, 2026 at 04:50:09PM -0500, Bjorn Helgaas wrote:
>> On Sat, Sep 12, 2026 at 12:25:36AM +0800, Hans Zhang wrote:
>>> The DWC PCIe register and field macros are inconsistently named and
>>> often do not match the Synopsys DesignWare PCIe Controller Reference
>>> Manual.  This makes it harder to cross-reference the code with the
>>> documentation when debugging or maintaining the driver.
>>
>>> +#define  PORT_AFAC_L0S_ELS		24		/* L0s Entrance Latency shift */
>>> +#define  PORT_AFAC_L0S_ELM		GENMASK(26, 24)	/* L0s Entrance Latency mask */
>>> +#define  PORT_AFAC_L1_ELS		27		/* L1 Entrance Latency shift */
>>> +#define  PORT_AFAC_L1_ELM		GENMASK(29, 27)	/* L1 Entrance Latency mask */
>>
>> Surely we don't need both the shift and the mask?  Maybe a separate
>> patch convert to FIELD_PREP()?
> 
> Oops, sorry, didn't notice that Mani had already applied these.  This
> could be material for follow-on patches.

Hi Bjorn,

I will send a patch separately based on the branch controller/dwc.


Best regards,
Hans


> 
>>> +#define  GEN3_CTRL_RATE_SHADOW_SEL_SHIFT 24		/* Rate Shadow Select shift */
>>> +#define  GEN3_CTRL_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)	/* Rate Shadow Select mask */
>>
>> Ditto.
>>
>>> +#define MSIX_DOORBELL			0x948
>>> +#define  MSIX_DOORBELL_PF_SHIFT		24
>>
>> Probably would be better to define a mask so we have the position
>> *and* the width.
>>
>>> @@ -621,15 +621,15 @@ static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
>>>   	u32 val;
>>>   
>>>   	val = dw_pcie_readl_dbi(&pcie->pci, pcie->ras_des_cap +
>>> -				PCIE_RAS_DES_EVENT_COUNTER_CONTROL);
>>> +				RAS_DES_EVENT_COUNTER_CONTROL);
>>>   	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
>>>   	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
>>>   	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
>>>   	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
>>
>> Probably a good chance to convert these to FIELD_PREP() etc. as well,
>> maybe in a separate patch.

