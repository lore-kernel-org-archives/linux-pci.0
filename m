Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864819;
	b=H/SP79nlbOdmRxFGlAFYCUMaxoGSCOa4NauhWonNTvamya0drzu5mD9yB2PIGdLS2j88
	 RBjsWWf6q41Uy0tFmVxhaX694dnH2L2jtI1+UlzBCSLExa+iKnHfx6gb2OS5wjng0ixod
	 HEzany/6iWdI2hwIqYFCGiMOQGbYDcvosh2hvK+ajPS2PvsPfti6lkreytlirHna50Eik
	 jzI0rhr/dgYwd4RsZhRhpHUcLYXDx6DudfBagN6RLPgJAPrmkJYKiUDncA1EBGjfFhqPK
	 mnuQ0tTSaCVBEU0MojTAlMc/A5fdWVQbjXtD/fhEPQmFqO7dxiIXkXzpCPLCnYlEMQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864819;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PU50rkTM7P9N/lvPiRkmpsgKA2mgcVLrq2zbVJoPex4=;
	b=x1oHF6+fp0z9DdNiwl1h3C6V5N66vEEFKMpXgb3O1MzjpyBtgSgyILQnynb+CtF278aa
	 GAaw7XDEBCHw2CNxBM8GDvtdUs0vwll2+h77XGOZ6pKyb5PoiA0CT3x9JdHloYW5l09jq
	 bekRXL5uGjU+HVxBoP1x7fAX3e6ELsOEird5Vak2IQfVcGSgBt6eIDsq70hJ6xHy+McP8
	 7XjhU/9j3bmdM5ApII2xTwkGoRFk4rnsS6Ft5bQBjEm2JOAWBdvhUGi2m4RuLU+a1jTQN
	 tMfz2cGXs5SRlXH2V1bdOoVkkdTVfe3krIggQLjqv1xSdnJMdWZ5JfTV1YLyadrbPBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fh/7Sh08";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D31606A328;
	Thu,  5 Nov 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fh/7Sh08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3261F000C1;
	Thu,  5 Nov 2026 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864818;
	bh=PU50rkTM7P9N/lvPiRkmpsgKA2mgcVLrq2zbVJoPex4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fh/7Sh08z2YJ1Yqdw8RZUNKty9ZCz/hgiv/J0VYHAxJHoE+0XM8dtRZgD6YYPFJdV
	 q4Mqw/AE0dWFofaBAcYKlFYf/RefqB4PF5MOyXqfDIkxJJtQZJzqKipcxJIbpfDP8H
	 9kg7IP7Y9MUuNPI/eWfDjQEE/EXtqtLY07nUyESiRtGORUROfsD4QDuGZoqaYei/KX
	 mW/L2dc1IUUmVPDfzjs5nN+q80/7sHhDJJszahEvOn5T9myCeL9szljDSUqM9fVdNO
	 RlIkwbhI4hK0UPtI3h7vhgmDvPEKbz/edinZukySfsuRvqnxNVZisUuSp+E/K43RHm
	 I/g41vmHdx3Dg==
Message-ID: <aee09c71-2f5f-49da-8cd6-09df3ba01fe1@kernel.org>
Date: Thu, 5 Nov 2026 08:46:51 +0100
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
To: Cui Chao <cuichao1753@phytium.com.cn>, Will Deacon <will@kernel.org>,
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
 <c6af23c8-ee5a-47b7-bdf1-dc853ea388d9@phytium.com.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <c6af23c8-ee5a-47b7-bdf1-dc853ea388d9@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/11/2026 08:35, Cui Chao wrote:
> 
> On 11/4/2026 3:23 PM, Krzysztof Kozlowski wrote:
>> On 03/11/2026 03:57, Cui Chao wrote:
>>> On 11/2/2026 6:00 PM, Krzysztof Kozlowski wrote:
>>>> On 02/11/2026 10:51, Cui Chao wrote:
>>>>> Add a new optional boolean property 'linux,pci-domain-reuse' for PCI
>>>>> host bridges.
>>>>>
>>>>> By default, the 'linux,pci-domain' property must be unique across all
>>>>> host bridges. This property allows a host bridge to explicitly opt-out
>>>>> of this uniqueness check, permitting multiple host bridges to reuse the
>>>>> same software domain number.
>>>> Why isn't this deducible from the compatibles?
>>> Hi Krzysztof,
>>>
>>> Thanks.
>>>
>>> The compatible cannot express this. "pci-host-ecam-generic" only
>> You have vendor specific compatibles, no?
> 
> 
> I used a tool to assist me earlier. I will now discuss directly.
> The driver used by our hardware is not a vendor specific driver but
> the generic "pci-host-generic" driver, so previously the compatible
> in our DTS was only "pci-host-ecam-generic", with no vendor specific
> compatibles.

Why aren't you using vendor specific compatible?

> 
>>> describes how configuration space is accessed; it does not describe
>>> whether two host bridge instances may share one Linux PCI domain.
>>>
>>> The same compatible is used on systems where every host bridge must
>>> have a unique domain and on this system where two RCs intentionally
>>> share a domain with disjoint bus ranges and resource windows.
>>> Comparing the compatible strings of the nodes therefore cannot
>>> distinguish our case.
>> OK, so let's look at your DTS - where is it posted for upstream?
> 
> 
> The DTS has not been uploaded upstream. Below is our DTS (with

So do we need the property in upstream in such case?

> irrelevant information such as interrupts and IOMMU omitted). Both
> nodes use only "pci-host-ecam-generic", and their resources do not
> overlap, but the domain is the same.
> 
>   pcie0: pcie@80000000 {
>          compatible = "pci-host-ecam-generic";
>          device_type = "pci";
>          #address-cells = <0x3>;
>          #size-cells = <0x2>;
>          #interrupt-cells = <0x1>;
>          reg = <0x0 0x80000000 0x0 0x8000000>;
>          linux,pci-domain = <0>;
>          bus-range = <0x0 0x7f>;
>          ranges = <0x1000000 0x0 0x100000 0x0 0x10000000 0x0 0x100000
>                            0x2000000 0x0 0x20000000 0x0 0x20000000 0x0 
> 0x10000000
>                            0x43000000 0x200 0x0 0x200 0x0 0x100 0x0>;
>   };
> 
>   pcie1: pcie@88000000 {
>          compatible = "pci-host-ecam-generic";
>          device_type = "pci";
>          #address-cells = <0x3>;
>          #size-cells = <0x2>;
>          #interrupt-cells = <0x1>;
>          reg = <0x0 0x88000000 0x0 0x8000000>;
>          linux,pci-domain = <0>;
>          bus-range = <0x80 0xff>;
>          ranges = <0x1000000 0x0 0x200000 0x0 0x10100000 0x0 0x100000
>                            0x2000000 0x0 0x30000000 0x0 0x30000000 0x0 
> 0x10000000
>                            0x43000000 0x300 0x0 0x300 0x0 0x100 0x0>;
>   };
> 

Anyway, I clearly see no usage of linux,pci-domain-reuse in above code,
so I think this closes the case.


Best regards,
Krzysztof
