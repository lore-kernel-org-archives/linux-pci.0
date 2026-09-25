Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB31489FBC
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368338; cv=none; b=tdsw84sBxfr7A2P7lYjJO8+27mS/INMk1YsbTzOvKp2KPnspbb7SG/TrpgZGu9zRlLF8RoZzO352s44lvpwn7jVjlGQqZJuUKkz+hDP67tuRlWmPcf3lIfBScszn1xKagAXOe/fDBKOtsiDa8EPvpJxH6AYGJdq0wvpkCoH2Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368338; c=relaxed/simple;
	bh=x+NZ7oR4Mxe8szkX1Tps/7aS2pavuRglVKXoGveVbY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9paGtsAXDyIWqFLkaJ1d+EvZd20y0UHyAq7tsjJqScrkbbJLoYR2+VwCujIK+CW5+Kxe0utFYY5fGgfJihh/zFH2Yzx2iUgskjKfqyExvNi+66OQmz46xzmRnRcOa0guw1b6VX9I8fOzje+vRuJWGz8psZ+wE1UDyrg6HiOPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DX0ALvKq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DX0ALvKq"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hs2S64XkCzMlQs;
	Fri, 25 Sep 2026 22:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790368326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsfIvoLVoub3AcxCPTfghbyCrS51ukxfT0A1RVsHsA4=;
	b=DX0ALvKqpt+ctBSj/LZBtOs/CchSKRd3kPEoRjIrN4E3kZwAl4U0VJHjoHdTDCs26MXvBI
	FRrZPi6x4mbitUkwOXDHA/cQznGOMyJzN0S5hphvSkdGbsNn3kBFzJI0mLYwxx9QzLMR/m
	m4wyhhEyh7e1DxQ2WYr61MFRreLfDZKzhqNUPvsMDvRKk5oMtdv6G6VQocr5ga2rhKQHqc
	zhKz0czSQaetThzy75TRKlZ/rusTspqpu7xGwG5GbX+Ohm0JVkoW5j9FFVOwEfuBze89GS
	6FY1EAUue0770/WSdv1ikIeXuPcNdVFjfXtPfJWnl1ci6IGB6I0baa/iJVEUqQ==
Message-ID: <4db17831-4bbe-4d22-a0ec-97b1653c3cd1@mailbox.org>
Date: Fri, 25 Sep 2026 22:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [pci:controller:dwc-rcar-gen4] BUILD SUCCESS WITH UNVERIFIED
 WARNING 7fc9907223d6fa1bea13f896af7d0c77b36724e0
To: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <202609250740.xsN0zhYb-lkp@intel.com>
 <20260925161402.GA2056819@bhelgaas>
 <91faeaaf-4252-4d21-84a3-c8069b2d85cf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <91faeaaf-4252-4d21-84a3-c8069b2d85cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kpk837zwz117hxizyoh3b9bzwe9cm37c
X-MBO-RS-ID: 21dafab658e4585d76d

On 9/25/26 6:37 PM, Krzysztof Kozlowski wrote:
> On 25/09/2026 18:14, Bjorn Helgaas wrote:
>> [+to Marek, +cc Rob, Krzysztof, Conor]
>>
>> On Fri, Sep 25, 2026 at 07:18:43AM +0800, kernel test robot wrote:
>>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
>>> branch HEAD: 7fc9907223d6fa1bea13f896af7d0c77b36724e0  PCI: rcar-gen4: Add Application/Local register reset control
>>>
>>> Unverified Warning (likely false positive, kindly check if interested):
>>>
>>>      https://lore.kernel.org/oe-kbuild/202609230547.zdjJoKk2-lkp@intel.com
>>>      https://lore.kernel.org/oe-kbuild/202609230819.0wgao12k-lkp@intel.com
>>>
>>>      Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
>>>      Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml: properties:reset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'const': 'core'}]} should not be valid under {'required': ['maxItems']}
>>
>> Can you take a look at this?  I'm not much of a DT reader, but I think the
>> warning is saying that maxItems: is unnecessary when the items: list
>> already tells us the maxItems?
>>
>>    reset-names:
>>      minItems: 1
>>      maxItems: 2
>>      items:
>>        - const: pwr
>>        - const: core
>>
>> I don't see any other PCI .yaml that uses maxItems: and items: in quite the
>> same way, but maybe we want them to match the 'reset:' property?
> 
> 
> The code was never tested. You need to drop maxItems, so
> 
>    reset-names:
>      minItems: 1
>      items:
>        - const: pwr
>        - const: core
I sent two fixes, sorry about that, thank you for the hint above:

[PATCH 1/2] dt-bindings: PCI: rcar-gen4-pci-host: Fix reset-names
[PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Fix reset-names
