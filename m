Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1D1DA57;
	Tue, 29 Sep 2026 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642565; cv=none; b=CcFkzd1iX6rNSIoFDwBk1bIU2uVB2/sYCZERmq/7VyTQGQqw0JkCznJoJKzfdmpVEwS8TpMPNy/sRd85zQRPcBLy4mRYHQ0PGAjsT3DA8HQzZGaSJvFKoWrFhjm3cVry1WWGTu3lvyUAcm8dF8Ez0jDLwgPo2B35Xn0cp7nVAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642565; c=relaxed/simple;
	bh=OWhcwknLRyPzDmXgalH6NabLxd+2MPu1XxuBbMgZxsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH0/YG0ITOIGnuZYFO/7UtZgD5wr8MZgGGrTOUJfoK6oaHy2XH8eNP63C6J5Z0kgEM1eGDSzojDmcM1QIwTG7TQER99J+z1yiA3tarW6D88xPCGz9yQ3ZFe2vwaUKC8UJrdfLCtci8xIQGNcg/9zChHmEiQHa8IPxXOXV+zjWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ysoZstVY; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ysoZstVY"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4htzsj020ZzKn2J;
	Tue, 29 Sep 2026 02:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790642553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYZdjHSXMYQifjl/oycijS7tIo3obhxZW530Z+Tdr74=;
	b=ysoZstVYT9kJZ0p+C3oJMwuX/R3prdjcwqklLJ814vDuPxUJYwk4I4JlifmfqZK1II4bCG
	GPQ0F2CaCZrjdgdqAuBJbOI699d2+3nkumTLGq3T9nedDKQ9jnGcqX3trKwK0S0z/sCXCc
	Oc8Wcq1yoNLWXlhz8XzumjosPwTfw3jvCDnJ5Spa4qHHuICNvkyQ1ckUa8ep2efdqqsZO+
	y46vKlbRu5FePJ0R7oYr64FkyltPdSuwpKgwqouS+Pe4ABfCWLZOREm+fZcb1ATaAxjTB+
	F4qZiFhtd+K0Anf4Mc7ubjkP7slLdSydqPsae0IyQiWliQm0CoVhEM7VvS4JOg==
Message-ID: <d4cab7d0-23d7-4998-8957-b879382395b9@mailbox.org>
Date: Tue, 29 Sep 2026 02:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260928222442.GA2266778@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928222442.GA2266778@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: n5r3abih9upesd63k85pf9uic4hcaarb
X-MBO-RS-ID: 56a18349aca01d73551

On 9/29/26 12:24 AM, Bjorn Helgaas wrote:

Hello Bjorn,

>>> The gen5/pcie4 usage is confusing.
>>>
>>> I often push back on things like "PCIe Gen4" because it's ambiguous
>>> (does it mean "compliant with base spec r4.0" or "supports 16 GT/s" or
>>> something else), but it's so widely used to mean transfer rate that
>>> it's hard to resist, and the best I can hope for is clarification.
>>>
>>> But in "renesas,rcar-gen5-pcie4", I don't know what the 5 and the 4
>>> mean.  Maybe "gen5" refers to some internal R-Car thing, and "pcie4"
>>> is something like "PCIe Gen4, i.e., 16 GT/s"?
>>
>> Gen5 refers to R-Car Gen5 (5th R-Car SoC generation).
>>
>> PCIe4 refers to the PCIe Gen4 core in the R-Car Gen5 SoC. There is also PCIe
>> Gen6 core in the same SoC, but that will require a different driver and
>> different compatible string.
>>
>> Since none of this shipped in any kernel version yet, would you prefer some
>> sort of rename ? I can send patches.
> 
> Huh.  TIL that pcie-rcar-gen4.c refers to the 4th generation R-Car
> SoCs

Yes.

> (and, I guess the point of this series is to add support for 5th
> generation SoCs), not to PCIe Gen4 link speeds.

Correct.

> I see that
> "renesas,rcar-genX" is all over the place in 'compatible' strings, so
> I guess we should follow that precedent.

Yes.

> If the "renesas,rcar-gen5" SoC includes both PCIe Gen4 and PCIe Gen6
> cores, I suppose everybody refers to them as pcie-gen4 and pcie-gen6,
> so the "renesas,rcar-gen5-pcie4" you used is probably the obvious
> choice.

Right, and also the least cumbersome compatible string I could come up with.

> But maybe we can make commit logs less confusing by saying things
> like:
> 
>    - R-Car Gen4 SoCs S4/V4H/V4M
>    - R-Car Gen5 SoC X5H
>    - the R-Car Gen5 SoC PCIe Gen4 core
>    - the R-Car R8A78000 X5H PCIe Gen4 core, which supports a x8 link at
>      16 GT/s

Understood, I'll expand future patches to be more explicit about this.

Does that work for you ?

-- 
Best regards,
Marek Vasut
