Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4A36827E;
	Thu,  9 Jul 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610548; cv=none; b=Jm//J7XON4oOEIZkFzOv5/L3I218JdFqWlRiaC2agLZoiqGKEqSznZPfotjCi8NNNnB86qCXheVC0nY3XwiUog/fhNRUQkDx1m4++3xMJfUsKoqlZdtD+hH1Dq9cB4iho1G8GybHu1X2Xxx27DP1BTzCPK0BiXnnkNrUODQCU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610548; c=relaxed/simple;
	bh=BSIfjK1k/RavKFMkJAdhOhD5k3mXFCRucl7IdwdjzMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu+JzI67yc9nCsOeREatajyr419LLzaunvj/Zkr9KLlnjwOvhHZDf4LJ07b9Nbd+pdX0YWtfPNgEqh8Nia80Y+ivF3SvoaVLw+FJe8mvngh0h1QjEJQKHNf51Drsa3999wKv1FegTRl/9sZK8Pflyffey98e7J1irH7Pynf1Kcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rtC/EAly; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rtC/EAly"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwzGl2hsWzMlFX;
	Thu, 09 Jul 2026 17:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783610543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsIcksqCjHhl+PgskQMA9X+AMXn/bCWoXZcBglPsCLQ=;
	b=rtC/EAlyOKiXirZSk/d71ooja/c7nLc/BRFJk2yPB9Kp77blaHjJixRruUPHZShcnQmrMh
	7+SMmdJEdMxFsB5ZS7lZPfaJ+uVcB/KjL9gMSXOj56cxfdFXHHhVVxljxPCcL6NsH/puCO
	FoVe9kapTLf4GFyfNn/3znlCX6oEG7hqvtGSw4XwUWovt25rISI/AKNsA66c4U8xvMxhPx
	3c6MvDftlnqEPNrogLW4S8YKlLwiEb1GkNAos/eb8XFxS23SScur9PYnsWuljTvW1QQ6fM
	29aOllfZZP/td96j/NbsGuV27BUOp/FVm82DoRkNx1FQ6FwOEnIxfqooQWgq2w==
Message-ID: <a8eaf0be-175e-4e3e-a773-d0684a23b396@mailbox.org>
Date: Thu, 9 Jul 2026 17:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] PCI: rcar-gen4: irqchip/gic-v3: Handle GIC ITS
To: Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260707203743.88299-1-marek.vasut+renesas@mailbox.org>
 <ybnitlgx3dcqsesubz6jz7pn6snseuxhtz564tinbtvukianaq@33ubmcynyqmt>
 <c12941e4-3715-404e-b674-090c62b868b8@mailbox.org>
 <87v7ao5o5t.wl-maz@kernel.org>
 <lkxuw3lgr6gbi4vnj33pfq5kh7h7qefkwiovlqsltnfivbrfit@khnoyfmibg5f>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <lkxuw3lgr6gbi4vnj33pfq5kh7h7qefkwiovlqsltnfivbrfit@khnoyfmibg5f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 329c7eef028ecd092b3
X-MBO-RS-META: tctohij9qgjyajkrm4cs6844iwq15twh

On 7/9/26 2:57 PM, Manivannan Sadhasivam wrote:
> On Thu, Jul 09, 2026 at 01:43:26PM +0100, Marc Zyngier wrote:
>> On Thu, 09 Jul 2026 13:33:22 +0100,
>> Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>
>>> On 7/9/26 2:19 PM, Manivannan Sadhasivam wrote:
>>>> On Tue, Jul 07, 2026 at 10:35:38PM +0200, Marek Vasut wrote:
>>>>> Configure all R-Car Gen4 PCIe controller MSI registers fully, both in
>>>>> case MSI are enabled and disabled.
>>>>>
>>>>> Patch GIC ITS driver and add quirks for R-Car Gen4 GIC ITS, which is
>>>>> configured to 32-bit address width for AXI or APB interface.
>>>>>
>>>>> Switch R-Car V4H to use GIC ITS in its DT and describe the GIC ITS
>>>>> implementation cacheable and shareable limitations.
>>>>>
>>>>> Marek Vasut (5):
>>>>>     PCI: dwc: Determine whether iMSI is used before calling .init
>>>>>     PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
>>>>>     irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
>>>>>     irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
>>>>
>>>> Is there a functional dependency between irqchip and PCI patches? Since the
>>>> irqchip patches touch ARM64 Kconfig etc... I'm wondering if it still need to go
>>>> through PCI tree.
>>> I do not believe there is.
>>>
>>> These two configure the PCIe controller hardware:
>>>    PCI: dwc: Determine whether iMSI is used before calling .init
>>>    PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
>>>
>>> These two fill in GIC ITS quirks:
>>>    irqchip/gic-v3: Refactor GIC600 limited to 32bit PA erratum handling
>>>    irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
>>>
>>> This one does yes depend on the two and two patches above, and can
>>> only be applied once all four aforementioned patches land, otherwise
>>> things really yes will break:
>>>    arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes
>>>
>>> Would you like me to split the series up , or can you and Marc (?)
>>> pick the relevant parts via matching trees ?
>>
>> I don't think there's anything for me to pick. The whole thing looks
>> like a consistent set, and it probably should be kept together.
>>
>> Given that the irqchip stuff has been acked by the relevant party, and
>> that the last patch will cause havoc if taken on its own, the only
>> course of action is to route the whole thing together, the PCI tree
>> being the most obvious victim.
> 
> Alright then. I'll merge all 4 patches to PCI tree.
Thank you all.
