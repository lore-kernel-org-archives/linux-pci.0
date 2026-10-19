Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422323;
	b=smrxGPlcRo9uTtT2tZtcJgchpUovCvY/0SiQj2j7NJtSxkSjEulK3R8Awr0EQWV8bOnX
	 jgU4o2I5ou9KYGbPWosKK293auFC5TP2I2jFN9BUC1p0FZJA2UEQ9XAq2mbFha8KYVz9P
	 ybmsVbQVeRdwzKfLh3lCizoxQLvbWRCz4tAqWm0oVjNGcILB+yXYBey4hDTEE8sxr8vMv
	 AXlShGl2M8Oo2TAzr5gR7iJ2jmfqBr2U/ybWmWROk2RHHhssNJ8Iqqj38uq6nRElAA12U
	 fTpzDYmEp1hIs2bO4N7J3t9s7DsCHskAp+zWJR/8CCgk+rmuF8nTKlzdjY1qKFNLqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422323;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=S/mEjzuagw3q0X+ihl6sYp/jM/35hiswml3dS+BNhZY=;
	b=PZeh97IKSaipTcCgv93+ScPArZxsWOcHYuPmocBpR+Ts24jgqa2HFW9MrbU9t/PpaJAD
	 cE5f7J5UtMDRtoO4q2/+Q+n1Ivp4MjGZi9sQ5ZKZ12yR8thdoFtjz44ttKTKDbikS/4fE
	 cAaNyvyExpmBcN/D4LVthb3iWGSsZCIQk1clupoMsug5zAtMgIx+QGv1Or8qxV34vd8BE
	 D9DaN9DhtS9UL2u8i4U+Gh9IP9zUt6z7c3LyQQbM4yUjq+8uKqfMdwuEqRyQbTHsbRBvw
	 gwoHEb7qYLlW0RbS7WMVkaO6V5KJYjUM740lxYWBP+JM/lu9wfY+zebmKV/sB3paFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sGapG2IH;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90136080A93;
	Mon, 19 Oct 2026 15:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90136080A93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sGapG2IH
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j7f3q6dRbzKmd0;
	Mon, 19 Oct 2026 17:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792422311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/mEjzuagw3q0X+ihl6sYp/jM/35hiswml3dS+BNhZY=;
	b=sGapG2IH1/1s46vhm0FmaUmtkIMUcxNZVfpL/JpQ1ywx3AZmL9Bhhn9S2vHKzojye5eYVP
	/LDEwoAHPEGrqZrQPBYd8m4qPvDhBwMUMBUkKKfdUUEgmNTS/WX8gF8zV2JH920uKJCPgx
	fpXzYC5GCvkXghk5DceclOBD17qk26W86S0KtoXn8kJTDpyhJjskTIns/WRR0sGqbFjia9
	U7rRm/i+mSZXm0SzgWeLYUqKj2kMIEg0khIhKmE48XDSxX1ETsBuJCIef7mEjsOYtT8p9g
	595QngrUH5mdJiq52DbaOsxZBnkHVelIHcsRHNVO7a35HsIzWfe9NFwKPKrqxA==
Message-ID: <622ffd73-1dd1-4a77-aade-9f2219e18933@mailbox.org>
Date: Mon, 19 Oct 2026 17:05:07 +0200
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
Subject: Re: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional "aer"
 interrupt for R-Car Gen4 SoCs
To: Koichiro Den <den@valinux.co.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-5-den@valinux.co.jp>
 <814043dc-d194-4afd-8317-03b55cc9e913@mailbox.org>
 <j6ayfdb4evnc45urk4n5ewtnn22f2gwgqyjkhpxr4c7outy5va@5dhrlhgqp2ms>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <j6ayfdb4evnc45urk4n5ewtnn22f2gwgqyjkhpxr4c7outy5va@5dhrlhgqp2ms>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a26e4a6c6dc22a17598
X-MBO-RS-META: y9koge3foc8rwkyxfwu35w75piahkcse

On 10/19/26 4:31 AM, Koichiro Den wrote:
> On Sat, Oct 17, 2026 at 02:17:38PM +0200, Marek Vasut wrote:
>> On 10/15/26 5:30 AM, Koichiro Den wrote:
>>> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
>>> separately from the integrated MSI receiver interrupt. Describe it with
>>> the "aer" name so the controller driver can use it for Root Port error
>>> reporting.
>>>
>>> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
>>> trees remain valid. Extend the example accordingly.
>>>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>> ---
>>> Changes since v3:
>>>     - Rebase on Marek's Gen5 AER binding fix:
>>>       https://lore.kernel.org/r/20261003215710.792518-1-marek.vasut+renesas@mailbox.org/
>>>       This requires "aer" for the Gen5 SoC PCIe4 controller from the
>>>       beginning. Update the subject to clarify that it is optional only
>>>       on Gen4 SoCs, for compatibility with existing DTs.
>>>     - Drop R-b tags due to the changes.
>>>
>>> v3: https://lore.kernel.org/r/20261006084638.3821710-5-den@valinux.co.jp/
>>>
>>>    .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml | 13 ++++++++++---
>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>>> index 083b77d4de8f..a86c06701fa9 100644
>>> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>>> @@ -26,7 +26,8 @@ properties:
>>>              - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
>>>      interrupts:
>>> -    maxItems: 4
>>> +    minItems: 4
>>> +    maxItems: 5
>>
>> Wouldn't it be easier/cleaner keep only maxItems: 4 here and set ...
>>
>>>      clocks:
>>>        maxItems: 2
>>> @@ -93,11 +94,13 @@ allOf:
>>>                - const: config
>>>            interrupt-names:
>>> +          minItems: 4
>>
>> ... minItems/maxItems here ^ for R-Car Gen4 (because Gen4 is the only SoC
>> family which has optional non-mandatorily-described AER interrupt) ...
>>
>>>              items:
>>>                - const: msi
>>>                - const: dma
>>>                - const: sft_ce
>>>                - const: app
>>> +            - const: aer
>>>      - if:
>>>          properties:
>>>            compatible:
>>> @@ -117,6 +120,9 @@ allOf:
>>>                - const: app
>>>                - const: config
>>> +        interrupts:
>>> +          maxItems: 4
>>
>> ... and drop this interrupts: hunk here entirely (because Gen5 always has
>> mandatorily described AER interrupt) ?
>>
>>>            interrupt-names:
>>>              items:
>>>                - const: msi
>>> @@ -146,8 +152,9 @@ examples:
>>>                interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
>>>                             <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
>>>                             <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
>>> -                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
>>> -            interrupt-names = "msi", "dma", "sft_ce", "app";
>>> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
>>>                clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
>>>                clock-names = "core", "ref";
>>>                power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
>>
>> What do you think ?
> 
> Seems that wouldn't work as-is. With your proposed layout and a Gen4 DT that
> includes "aer":
> 
>    $ dt-validate -V
>    2026.9
>    $ dt-validate -s <schema-dir> -l rcar-gen4-pci-host <gen4.dtb>
>      interrupts: [[0, 416, 4], [0, 417, 4], [0, 418, 4], [0, 422, 4], [0, 421, 4]] is too long
>        from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml
> 
> The top-level maxItems:4 would still apply to Gen4.
> We could instead drop the top-level interrupts limits and set them separately in
> the Gen4 and Gen5 'then' blocks, if that would be more readable.
> 
> But TBH, I don't see much benefit over the current (v4) layout, so I'd prefer to
> keep v4 as it is. I'd appreciate your thoughts on it.
I agree, please keep this patch as-is.

Thank you for checking !

-- 
Best regards,
Marek Vasut
