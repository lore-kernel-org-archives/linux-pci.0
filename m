Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460292;
	b=0IkQNeXfKtLiOsPYyeUkhNfbue8wdgSGJjs/VoXrUCSA2E0u0VPwwpyyFPZBNhEDX1nq
	 8G+5IjCOnh1ii3UfxVMglDS9X9ebnajbAd6rJt5cUKJhy/9mN1tMaKcTgfVgPJ84EGAsM
	 oEyd5BmBCovxvWkCLqFAR0en2BG0AfQEVV9eP0GTqx4iDz2CmtdUwG+NSBqryzJrG/6O/
	 1tNuGG+J+YQDZPcL2SGJh43s7IB3zBDMG4UetvDvw50CCxFA3kzhhCn8lM2T7kSnsv/+J
	 lKK+CMXdzTOLkuWm79FflpuQHqi1DP9s3kgkNodO8mgHDwkB/t6PnpAxdRCkx0dMwLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460292;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=2uUBJF342k/4gPby2H7U6z2OOmR9jw+AkFYz58yDUYY=;
	b=grTzPAflnFdDsjlC7iHRwqkZwe/YZyGPBNcy/YXxZ3+fsgpk6rXcFspImTacMCA2Dbz7
	 xe++Arizcu3NidKauINn4idLWV6BVo+LtPQdAsqRxm3jpRa6IWk30tL+M4DqKLF2M+a4m
	 aim36dLRlOaKRsyZlNrq0J3FxqtJvLPQmm4V6N1NnAafdpJdwug3Oa3Owrz3d65la3x2D
	 udTQKYaT02pwcna0HB9n3sO15e7S7/kW1bzP+ZJkFB+FC3jLuSOP8blIH2pPHllnOjBnY
	 Ef2RXBRQ9z7u+RV5bbkecNUiCKcZDPFznuZGPImnAVyC1Vd/VwFstRMlC00tQSG8e6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3420606A339;
	Tue, 20 Oct 2026 01:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3420606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j7w676s8vz8vLc;
	Tue, 20 Oct 2026 03:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792460288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uUBJF342k/4gPby2H7U6z2OOmR9jw+AkFYz58yDUYY=;
	b=uFsvpaBfLS9PPBl/Vm7AkkYu8bfV2LF1Nz/xRR8cGTV3zHAFBkLj31WdtTdQAXtRJkwenc
	gz6JHHEPuJMbgjjFtdUaz8iTh4urWQnO1Ol6zs8maMvjl9po5XzL7GW4PufzVcSoI5OigJ
	uxg6cmdGv7Fedzo4KovEIjxf72kMgjk1LzXJo6QGj6klCFL21DfXHLZBY6DJYRZtIHY450
	OkNAcXj7syT1OZouI+KFAMNKeFMMpL+SbZdLeym2XoBAFb3CnVxRM513G7j4WTzF+cK98A
	oYVznWhJt4eDK414fjyJxErEDvWzqJWGcb3I0UvaBuzfGOnkW1rCPKLwb6fvpg==
Message-ID: <0fece6ed-e91a-4d35-99ab-ce3f4fd789a9@mailbox.org>
Date: Mon, 19 Oct 2026 22:18:57 +0200
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
Subject: Re: [PATCH v4 09/18] PCI: rcar-gen4: Add Root Port reset support
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
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
 <20261015033103.3076869-10-den@valinux.co.jp>
 <072cccd1-8fd4-41e5-a64c-3cc4dc0dee07@mailbox.org>
 <57zypillvon2jsw6ayckcuyhkhmv5kehh7rpxox33dzg2lfkqt@4zqkgpwxob7b>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <57zypillvon2jsw6ayckcuyhkhmv5kehh7rpxox33dzg2lfkqt@4zqkgpwxob7b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b058a89cf9cff052a67
X-MBO-RS-META: pjb3j94z77kpgpi34dphjsbh5tdgszsp

On 10/19/26 5:01 AM, Koichiro Den wrote:

[...]

>>> @@ -563,9 +604,11 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>>>    	writel(0, rcar->base + AXIINTCCONT);
>>>    	/* Deconfigure MSI interrupt signal */
>>> +	raw_spin_lock_irqsave(&rcar->app_lock, flags);
>>
>> This is only a small nitpick. I wonder if you could use the same
>> scoped_guard() {} call here instead of the raw_spin_lock_irqsave() and
>> raw_spin_unlock_irqrestore() pair?
>>
>> scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
>>
>>>    	val = readl(rcar->base + PCIEINTSTS0EN);
>>>    	val &= ~MSI_CTRL_INT;
>>>    	writel(val, rcar->base + PCIEINTSTS0EN);
>>
>> }
> 
> Yeah, actually I've been always wondering whether to ask you and the other
> maintainers about the guard/scoped_guard policy in this driver, or PCI
> contreoller drivers more broadly. I'm not aware of any documented PCI-specific
> policy, while netdev as an example, has some guidance on this.
> 
> In v2, Sashiko flagged the mix of goto-based cleanup and guard():
> https://lore.kernel.org/r/20260928170317.B0B331F000FF@smtp.kernel.org/
> so I switched that part to explicit locking in v3/v4.

Mixing guard and goto makes the code difficult to read, which would most 
likely lead to bugs, right. I think scoped_guard() and goto is OKish, as 
long as there is no goto inside the scoped guard (that would be horror).

> Would you consider an explicit scoped_guard() block (instead of guard()) at the
> end of the function OK, even though the function still uses goto? Or, maybe I
> should have just ignored the feedback from Sashiko, and guard() would have been
> fine here too?
> 
> Since I need to respin anyway:
> https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
> I'm thinking of replacing the lock/unlock pair with scoped_guard() as you suggest.

Please see above, as long as there is no "goto out" inside the 
scoped_guard, I think it is fine to have scoped_guard in function with goto.

> Thanks for the review!
Thank you for your help !

[...]

-- 
Best regards,
Marek Vasut
