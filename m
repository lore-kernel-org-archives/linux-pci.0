Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7C39060B;
	Mon, 28 Sep 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620200; cv=none; b=cx9a0/e/OtqDOYzXlx9tKxWiOj5h8+PdQz3djGhVj7oOMnhyr/mXWR918NaQcqxUOfdhyK2WUN5nPeReIY1wPKTK4oMNUnHOktYtu0AyIRvp9JBx1K+k35sCBVoNxkP9gOo6zk3fcA6XnnwQN8RqZPFJZu5xdk3bl2p/IcMqfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620200; c=relaxed/simple;
	bh=X71mzH2uZG4Zz90V/svIDvBuqeL/+Ow6zYk3jJO0vE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK+4b9SsTcoqkq/Gq+gGUmwEJooJsQ+GP+RZOHFK+7bVkamAryoUc7u+DeyKHYs8mwQX2RpjKOgrbiIFpZv9a8BmM6hUDOMw+2NPubPj3SH3mVCIvVMAbWDXJJaQEsTfmX48+EADpr0rDIn00TRnVrkJbUwjuoFspgJNzOWDueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jS2k2Qal; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jS2k2Qal"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4htqbj3f3ZzKp1J;
	Mon, 28 Sep 2026 20:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790620193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4UOx5QX7kX+W5/Ie5nHMORdMpDg/AS6sI2RXKzrPs0=;
	b=jS2k2QalraFTd0mPbabNjUw57uYZ91D6GRz16oV/j0WCmDpfNkvzn9bOGr1yZiIYm68SQH
	vgB5Sk/EluiS7f+aY9mTPyQWE0Iz2A0+1BBfS7tLBZZV8IwPl4PzGBetgUQRru1tWBw7j/
	fp02IAlREJhUMuIQALPKIZP5PdC+Q003lqwu+OsUDOhUoa6YswejAPJWCthXi0nFghimcI
	QM+Shr9IEbmcYFvkn6p0vt+/EgtIELAYQMvXieD9GfJTvv0++ySREemVaMzkrQtQUe5HU8
	vDlM0gR6QgNjebGvJKVpi9BseMl67c+xrNatzRtyZXbdwwzSeIGzG2xYr523IA==
Message-ID: <4b82b8e9-6cf5-4f88-af10-dcbce0181d5f@mailbox.org>
Date: Mon, 28 Sep 2026 17:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] PCI: rcar-gen4: Drop the APP-based link_up check
To: Koichiro Den <den@valinux.co.jp>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-3-den@valinux.co.jp>
 <c2807afc-3e69-4744-8588-20f60839a603@mailbox.org>
 <4peziifkgyfpglfl4jtyvcxqht2yo4r4bswmkweicpxdf45ejc@jxbqgurozlft>
 <badcd2d5-7d61-426a-86d6-000043a6aa93@mailbox.org>
 <4fgnblug6mknuy4zq2lqeuni3dmu2f6c4mpb2qfvvyt5bpnovm@b6gundxnhr7d>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4fgnblug6mknuy4zq2lqeuni3dmu2f6c4mpb2qfvvyt5bpnovm@b6gundxnhr7d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pfr94jinfo8zdyppkwf9s6rq1kxnbpz8
X-MBO-RS-ID: dd2d6aa1575c6556ca9

On 9/28/26 6:20 AM, Koichiro Den wrote:

Hello Den-san,

[...]

>>> That said, I agree that in general we should follow the R-Car reference manual
>>> where possible, and your draft makes sense for that purpose. If we go that way,
>>> I have one question: would we need a polling loop with a timeout
>>> (PCIE_LINK_WAIT_MAX_RETRIES * PCIE_LINK_WAIT_SLEEP_MS) in
>>> rcar_gen4_pcie_start_link(), similar to dw_pcie_wait_for_link()?
>>
>> This is a good point, and I think we probably shouldn't do it this way,
>> because we can reuse the DWC core code for that purpose.
>>
>> How about extending the .link_up callback, and check both the SMLH/RDLH bits
>> there (to fulfill the datasheet compliance, dw_pcie_start_link() is always
>> followed by dw_pcie_wait_for_link() which calls the .link_up() callback) and
>> the DEBUG1 bits (to make sure we check the current state of the link) ?
>>
>> That should cover all our concerns (datasheet compliance, DEBUG1 current
>> state of link check, polling), shouldn't it ?
> 
> If you mean AND-ing the SMLH/RDLH check with the DEBUG1 check, that sounds
> reasonable. We could clear the APP latches in .start_link(), before enabling
> LTSSM, and leave them latched across .link_up() calls.

Yes, that.

> Thanks for the suggestion!
> 
>>
>>> P.S. I'll rebase v2 onto the latest pci/controller/dwc-rcar-gen4.
>>
>> Thank you, and I apologize for the inconvenience.
> 
> No worries at all. I just hadn't caught up with your X5H series.
> I've now rebased v2 onto next-20260925, since the series also needs
> b43aa6a6ebe8 ("arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes"),
> as noted in the cover letter.

Understood.

-- 
Best regards,
Marek Vasut
