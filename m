Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511493BBFCD;
	Sun, 27 Sep 2026 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547917; cv=none; b=F6rntuqr+SW81bpPbPfSeCmqV1jDpLnNAFowXiydbF+LDEW5S6mHiNfu7d32Xh6vC5djtoy87NEuKL/y/HaNoka7Hod0E4+8Gxb6DErOs/jRC8bAJsIOcSNRS26yWZfS3U2Vsq62ZlU7Mci8E1gMPpIIWU5ZBCFoGQR+fBczRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547917; c=relaxed/simple;
	bh=qWPE2wwc7yRP1UrJO9QKxjKMHbNa3udgfTADPILIPlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQYWwi/HMg99FZwdjMxCQUrTGHt4NHrxKPnqoKOQChoojzUyz4JsKxNw9+VGKpXLO79Iqabbmi+6wD8cL/Itlehf5DoGm0YyCaYmjiyNst+SYE39wNuW2wPvop+nhfI2v2znMDLoQEgTKquYjwUsGK7d0ULSN8J7h61iFhwpE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Rg2sdrMn; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rg2sdrMn"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4htJsY74V8zMlwd;
	Mon, 28 Sep 2026 00:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790547906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAraAGD0aIICq0P432oSi9b+f1P3OFZtrY2LaA1/APY=;
	b=Rg2sdrMnJK3l3SEBSHIlbOE+ZZgtBKSn+K/iZn8EZ+lOxmyFQGHEExBg8Rb68nSP6DtmgS
	0RbkRmHYo37QxRbkHn5hnH+fpzECxdiktHn5pLnHlDF8RxisDLCjAMCwAi5PtqOHemOs9M
	QYrzTBsG4iaJQ6a1HnREsDcSMdGWD1fBE32emUw8kWgMjW/FiOTDNry6Pjfcw3/WhUNekv
	XM1N7mB7Kj9rlQM1y5hHqRThF9QBfFCPnPDVjgXwKwl1w4gpfWRY6NWCbQN5mIwDTJrGv0
	V7gnUjSEUqHtTu+uLOoUweCT0V2gbYPOI3+MH5lAfycV/9T91hZBXhz3NQPfhw==
Message-ID: <502bbcc9-956b-497f-822d-c7f70340d1d0@mailbox.org>
Date: Mon, 28 Sep 2026 00:25:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <rdeabz72swub66aykpwmzqotzcr7pncdqnla6tduki2ex5y3yu@vxb6h7w2uueo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rkg5b9rh6xp1pdxts7c7g9eg18fzc64w
X-MBO-RS-ID: 7a314d5eb55641c0dde

On 9/23/26 6:12 PM, Koichiro Den wrote:

Hello Den-san,

>>> @@ -90,12 +91,22 @@ struct rcar_gen4_pcie_drvdata {
>>>    	enum dw_pcie_device_mode mode;
>>>    };
>>> +enum rcar_gen4_pcie_state {
>>> +	/* The controller is being reset and reinitialized */
>>> +	RCAR_PCIE_RESETTING,
>>> +};
>>> +
>>>    struct rcar_gen4_pcie {
>>>    	struct dw_pcie dw;
>>>    	void __iomem *base;
>>>    	void __iomem *phy_base;
>>>    	struct platform_device *pdev;
>>>    	const struct rcar_gen4_pcie_drvdata *drvdata;
>>> +	unsigned long state;
>>
>> Can we simply use boolean flags here in struct rcar_gen4_pcie, instead of
>> the enum rcar_gen4_pcie_state ?
> 
> Sure! let me rework this for v2.

Thank you.

>>> +	/* Protects APP interrupt enable registers and their software state. */
>>> +	raw_spinlock_t app_lock;
>>> +	/* Serializes Root Port hardware reinitialization. */
>>> +	struct mutex reset_lock;
>>>    };
>>>    #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>>> @@ -344,6 +355,33 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
>>>    	return 0;
>>>    }
>>> +/* Whether the APP interrupt sources may currently be enabled. */
>>> +static bool rcar_gen4_pcie_irqs_blocked(struct rcar_gen4_pcie *rcar)
>>> +{
>>> +	return !!rcar->state;
>>> +}
>>> +
>>> +static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
>>> +{
>>> +	bool armed = !rcar_gen4_pcie_irqs_blocked(rcar);
>>> +	u32 val;
>>> +
>>> +	lockdep_assert_held(&rcar->app_lock);
>>> +
>>> +	val = readl(rcar->base + PCIEINTSTS0EN);
>>> +	val &= ~MSI_CTRL_INT;
>>> +	if (armed && pci_msi_enabled())
>>> +		val |= MSI_CTRL_INT;
>>
>> Should this function cache the state of pci_msi_enabled() in struct
>> rcar_gen4_pcie , so that in case rcar_gen4_pcie_irqs_blocked() reports MSIs
>> as blocked at this point ...
>>
>>> +	writel(val, rcar->base + PCIEINTSTS0EN);
>>> +}
>>> +
>>> +static void rcar_gen4_pcie_app_irq_sync(struct rcar_gen4_pcie *rcar)
>>> +{
>>> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
>>> +
>>> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
>>
>> ... this function can enable MSIs once it is called and MSIs are no longer
>> blocked ?
> 
> Even leaving aside rcar_gen4_pcie_resume_irqs(), which this patch introduces,
> rcar_gen4_pcie_app_irq_sync() re-evaluates the blocked state and
> pci_msi_enabled() on each call, so I would expect it to enable MSIs once
> unblocked, provided pci_msi_enabled() is true.
> 
> Am I missing a case where a cached value would be needed?
> 
> For example, even if there were a race with quirk_disable_all_msi(), I'm not
> sure caching the value would help.

I think there might be a possible issue, please consider this:

- The code enters rcar_gen4_pcie_reset_root_port() with MSI disabled
   (register PCIEINTSTS0EN bit MSI_CTRL_INT is unset)
- rcar_gen4_pcie_quiesce_irqs() is called, updates rcar->state
- rcar_gen4_pcie_resume_irqs() is called on exit from
   rcar_gen4_pcie_reset_root_port(), updates rcar->state again,
   and calls rcar_gen4_pcie_app_irq_sync_locked()
- At this point, I think MSI might be enabled instead of disabled ?
   (register PCIEINTSTS0EN bit MSI_CTRL_INT is SET)

Is that correct ?

Please correct me if I am wrong.

-- 
Best regards,
Marek Vasut
