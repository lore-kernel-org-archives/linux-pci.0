Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC039B4A1;
	Mon, 28 Sep 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620217; cv=none; b=nsnZ9X8DbEoTtIIElnDVoW0DVN15B3JxJJF4KLVfNH9Fl7f86IabIrcw30E3OylgRkrojmiZzClhk13kwiUkabRc5afnOILGjnSBuCUPAK7klemMw+QmOEoaMXE8RxRLPApGZ6zwuuVlhL4r77/nyaZtMGHBT2gPRhAc7MHq0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620217; c=relaxed/simple;
	bh=j9k227IxJVDVLC+tTHq9WSYuX/DGuyzvktDK79m+Eeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJeXeCYxaYRedTztQqDOIoHsU2OJzD7P5G+sRRG1yCQTt0fU6sH3YWR/TEexUP436Azv9LNCQslZRorq0ngGkdJ4tH+f/99BKycgeoYGX26XvXRwNX4QqAMYc87vuu/9NU4FY/Zni7CMhbj837g6tUvJIKMoIC6b2wMintM6wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NTLoHTky; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aJ5pIjeM; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NTLoHTky";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aJ5pIjeM"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4htqc52PCNzMlp8;
	Mon, 28 Sep 2026 20:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790620213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tu1E1O7hSxnEsaqiUNj7jjzxaBMdEnJSAQBOPccJ0Tc=;
	b=NTLoHTkyVTPWC7hsRnXfnZGRbWMUv/epJlhpAejnthMjXnqj9hbini6YxwZJ7DYryiIH+d
	eb+qw/sMOBP/iUMm4WNPN+JZSTZByVGXI5JOq96l4aiXzzcekPZlqOfjDE9e5s+/fCcRxa
	eDkpuGxOGoch5t0WEB2OBsLGR5JTVnk/8WLVw53vemvzVLGLsh3nHQWi0MrCgM1Cg70dc9
	lED1tL+mj8CEqV+3zw+WKZ/IpYe3c7Uinp3OAFEcqmj5p908BXWCxvYmn+s2ql2n/oZbGs
	c1TUXpOxwEpGQRfcSsTkatojq+O80kEOzqAwZK8Pa0pMYodN1QRk3nioLduT/g==
Message-ID: <a783b225-9c48-4b12-b498-f98d17087729@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790620211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tu1E1O7hSxnEsaqiUNj7jjzxaBMdEnJSAQBOPccJ0Tc=;
	b=aJ5pIjeMwpCiyCzbpZI0qz5m4hfy2y9dOSfQz0++lZ8Dscf+bonlbDV8MkdHVv6CMjzCmG
	M3P+zdHpb379FbI6zKNPRjOllJ3bsGUnEE5gbnfYDwwnJaHlqdusupl2n3oYAEGxHE7Um+
	kkrBZ0who7diYya57klSVAhIm4BfJX3APDl8LTQNGxujSXXeTEFr/HrRP/nBIbBNzdbx9x
	avcOyw2tqD0lxafmyM5kjP+NEtXD2Glx06JLMFlqSpl6lPdSRtgxPM4PXyNvVyjo4Bsr6U
	mhSwniKTxFWasQSdABl4GMrDZh/PaM2JvhFvgJn50AmtO5U1kx2J7tt55g63Ag==
Date: Mon, 28 Sep 2026 19:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] PCI: rcar-gen4: Add Root Port reset support
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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
 <20260918032038.2216471-7-den@valinux.co.jp>
 <4e7d7c8b-3daa-4ab3-9de1-51468975c28d@mailbox.org>
 <rdeabz72swub66aykpwmzqotzcr7pncdqnla6tduki2ex5y3yu@vxb6h7w2uueo>
 <502bbcc9-956b-497f-822d-c7f70340d1d0@mailbox.org>
 <lic2nmokugkeu3r6zgjux5a4p2o3545vs2kaijfth3f7rqipz2@ppokxnd7t3ai>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <lic2nmokugkeu3r6zgjux5a4p2o3545vs2kaijfth3f7rqipz2@ppokxnd7t3ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q3qjq3rs4sgdc681nkodjbh19jznoee5
X-MBO-RS-ID: 2d676807b7639e2922a

On 9/28/26 5:50 AM, Koichiro Den wrote:

Hello Den-san,

>>>>> +static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
>>>>> +{
>>>>> +	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
>>>>> +	u32 val;
>>>>> +
>>>>> +	lockdep_assert_held(&rcar->app_lock);
>>>>> +
>>>>> +	val = readl(rcar->base + PCIEINTSTS0EN);
>>>>> +	val &= ~MSI_CTRL_INT;
>>>>> +	if (armed && pci_msi_enabled())
>>>>> +		val |= MSI_CTRL_INT;
>>>>
>>>> Should this function cache the state of pci_msi_enabled() in struct
>>>> rcar_gen4_pcie , so that in case rcar_gen4_pcie_irqs_blocked() reports MSIs
>>>> as blocked at this point ...
>>>>
>>>>> +	writel(val, rcar->base + PCIEINTSTS0EN);
>>>>> +}
>>>>> +
>>>>> +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
>>>>> +{
>>>>> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
>>>>> +
>>>>> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
>>>>
>>>> ... this function can enable MSIs once it is called and MSIs are no longer
>>>> blocked ?
>>>
>>> Even leaving aside rcar_gen4_pcie_resume_irqs(), which this patch introduces,
>>> rcar_gen4_pcie_app_irq_sync() re-evaluates the blocked state and
>>> pci_msi_enabled() on each call, so I would expect it to enable MSIs once
>>> unblocked, provided pci_msi_enabled() is true.
>>>
>>> Am I missing a case where a cached value would be needed?
>>>
>>> For example, even if there were a race with quirk_disable_all_msi(), I'm not
>>> sure caching the value would help.
>>
>> I think there might be a possible issue, please consider this:
>>
>> - The code enters rcar_gen4_pcie_reset_root_port() with MSI disabled
>>    (register PCIEINTSTS0EN bit MSI_CTRL_INT is unset)
>> - rcar_gen4_pcie_quiesce_irqs() is called, updates rcar->state
>> - rcar_gen4_pcie_resume_irqs() is called on exit from
>>    rcar_gen4_pcie_reset_root_port(), updates rcar->state again,
>>    and calls rcar_gen4_pcie_app_irq_sync_locked()
>> - At this point, I think MSI might be enabled instead of disabled ?
>>    (register PCIEINTSTS0EN bit MSI_CTRL_INT is SET)
>>
>> Is that correct ?
> 
> I understand, but I'm still unsure when MSI_CTRL_INT should remain clear after
> a successful reset, with pci_msi_enabled() still true. And if there is such a
> case, wouldn't we need to preserve the intended enable state of MSI_CTRL_INT,
> rather than cache pci_msi_enabled()?

I only have a weak argument here -- I can think of a case where someone 
cleared MSI_CTRL_INT bit intentionally to prevent triggering an IRQ 
handler, with the intention of restoring that bit once their work was 
done. But I do agree this is a weak concern.

I will review V2 in the next couple of days.

Thank you for your help !

-- 
Best regards,
Marek Vasut
