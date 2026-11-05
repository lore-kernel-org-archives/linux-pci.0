Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864134;
	b=I5hVeURJg3tbAyB94mM22ume3f5B3GEtjaqABFZJddgJ7MZnoMx8JE0IseK8XqX16TUO
	 EEPSnd2sYj4deR5HkIV62+0VgyXCC59g/O/usBv5vq37A0zkfuZmHa0CgXSjRcpPL/9Zw
	 I+YeIm20eADK/wTvz7EcUO7CQOk7A+ax5s6D4mSmp5BipejjRhoclW5vx3D1oqB4PIWxM
	 i8gmez9Wyl5UPjDSDzoj4eyH9tidTk07VSVTiLdfr5IEptk9tbhKIBkxwPQQYAtFOLbgy
	 HUlPn+Tb28FguUbnj4W2tjUeFiltMOVvnHG6O0fK5FJ0YUgCX6lVfsx+fUiRFQiWbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864134;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=H32Q4xeGHAL5HVsaW0o1uw523KoBqyjwpUq440U+kXU=;
	b=QelFGpM9H3LnViPWwyiCgYIVFiSxJ7T5F5X1MOJeslO+joNhbO1tprGfesJV64pssvBz
	 SoQFpFJmm2d4+dRliRf8hvQMZSuc2COwVWu7K8fLTekY6rt7ZmamTaLkn7GyGhZHP3YL/
	 sHFBbnpeLigBjNlhLj2Qdo69fpxGTCRAW9Fx0c5/94krsVJgLuOuEiHnMnI0VWk/v5fqR
	 htPf2j089SlROLlUwPkmE4qbmO+LsfMC3rbySegZNN5xbOFKrJVDh5bap0OA1JZ/aj0bh
	 8ta0UDRQ7vSyEp6FDpZ7TipXndWOBw9yXLG/hydAVEFFFnonK30BoLbt/nvrDk7yJOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E03606A31B;
	Thu,  5 Nov 2026 07:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E03606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwD313y3Mexq6bTlAQ--.26457S2;
	Thu, 05 Nov 2026 15:35:19 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAf8DwS3KyMexqcxb2AA--.18258S2;
	Thu, 05 Nov 2026 15:35:15 +0800 (CST)
Message-ID: <c6af23c8-ee5a-47b7-bdf1-dc853ea388d9@phytium.com.cn>
Date: Thu, 5 Nov 2026 15:35:14 +0800
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
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add linux,pci-domain-reuse property
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
 <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
 <8112d8ca-2234-490c-a4a2-c3b01adfbc88@kernel.org>
 <b49779cf-5132-4539-86c2-e4f806b1675d@phytium.com.cn>
 <c0313537-532f-4c9c-86fb-067838829427@kernel.org>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <c0313537-532f-4c9c-86fb-067838829427@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwS3KyMexqcxb2AA--.18258S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAKAGrrh8gDWQAAsf
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGr4xGrW3Wry3Wry5XrWfAFb_yoW5Kr1kpF
	WFqFZxGrW8Xr18Jr4Utr1UJFy5JF4Fka1kJr15J3WDAF90vF1jqr4jgF409ryUWF48Xw1U
	tFsrJryjvF4kXaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 11/4/2026 3:23 PM, Krzysztof Kozlowski wrote:
> On 03/11/2026 03:57, Cui Chao wrote:
>> On 11/2/2026 6:00 PM, Krzysztof Kozlowski wrote:
>>> On 02/11/2026 10:51, Cui Chao wrote:
>>>> Add a new optional boolean property 'linux,pci-domain-reuse' for PCI
>>>> host bridges.
>>>>
>>>> By default, the 'linux,pci-domain' property must be unique across all
>>>> host bridges. This property allows a host bridge to explicitly opt-out
>>>> of this uniqueness check, permitting multiple host bridges to reuse the
>>>> same software domain number.
>>> Why isn't this deducible from the compatibles?
>> Hi Krzysztof,
>>
>> Thanks.
>>
>> The compatible cannot express this. "pci-host-ecam-generic" only
> You have vendor specific compatibles, no?


I used a tool to assist me earlier. I will now discuss directly.
The driver used by our hardware is not a vendor specific driver but
the generic "pci-host-generic" driver, so previously the compatible
in our DTS was only "pci-host-ecam-generic", with no vendor specific
compatibles.

>> describes how configuration space is accessed; it does not describe
>> whether two host bridge instances may share one Linux PCI domain.
>>
>> The same compatible is used on systems where every host bridge must
>> have a unique domain and on this system where two RCs intentionally
>> share a domain with disjoint bus ranges and resource windows.
>> Comparing the compatible strings of the nodes therefore cannot
>> distinguish our case.
> OK, so let's look at your DTS - where is it posted for upstream?


The DTS has not been uploaded upstream. Below is our DTS (with
irrelevant information such as interrupts and IOMMU omitted). Both
nodes use only "pci-host-ecam-generic", and their resources do not
overlap, but the domain is the same.

  pcie0: pcie@80000000 {
         compatible = "pci-host-ecam-generic";
         device_type = "pci";
         #address-cells = <0x3>;
         #size-cells = <0x2>;
         #interrupt-cells = <0x1>;
         reg = <0x0 0x80000000 0x0 0x8000000>;
         linux,pci-domain = <0>;
         bus-range = <0x0 0x7f>;
         ranges = <0x1000000 0x0 0x100000 0x0 0x10000000 0x0 0x100000
                           0x2000000 0x0 0x20000000 0x0 0x20000000 0x0 
0x10000000
                           0x43000000 0x200 0x0 0x200 0x0 0x100 0x0>;
  };

  pcie1: pcie@88000000 {
         compatible = "pci-host-ecam-generic";
         device_type = "pci";
         #address-cells = <0x3>;
         #size-cells = <0x2>;
         #interrupt-cells = <0x1>;
         reg = <0x0 0x88000000 0x0 0x8000000>;
         linux,pci-domain = <0>;
         bus-range = <0x80 0xff>;
         ranges = <0x1000000 0x0 0x200000 0x0 0x10100000 0x0 0x100000
                           0x2000000 0x0 0x30000000 0x0 0x30000000 0x0 
0x10000000
                           0x43000000 0x300 0x0 0x300 0x0 0x100 0x0>;
  };

>> Adding a vendor-specific compatible only to trigger this Linux policy
>> would not describe a different hardware programming model either.
>> What actually makes reuse valid is the platform-level relationship:
>> the bus ranges and resource windows are disjoint.
>>
>> If you prefer to avoid a new property, I can rework this to derive or
>> validate reuse from the non-overlapping bus-range and resource layout
>> instead. Would that be the preferred direction?
>>
> This one is clear paste of LLM output to a message.
>
>
> Best regards,
> Krzysztof

-- 
Best regards,
Cui Chao.

