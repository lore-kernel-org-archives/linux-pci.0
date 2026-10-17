Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83943CB572;
	Sat, 17 Oct 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258410; cv=none; b=a84RXV5yaTnvIVucdY6gI3ZnNijS8mGaF5c8aATIr90+JzT5h0QN+hg+Ren3L7k9VLOEYxC0tFnrmIm4clzffXWNvNqMs9Zl2hAslKEGx1jdOlV0l6NJ1GVgPyhaav5DpyKo60WNb4UXlQ8C/t3z2PG1b31Z+1N1JWJry2Tv3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258410; c=relaxed/simple;
	bh=KFOhPpCDaVSvcqx3h5S1u3IIJg+69R+TD3ChUQ+QsH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHgirR5WKHVrut/pn7nRgYHRhStMihyKrG8N2Pw6SqfdApeNPzwh77BPSdJWpx3CpAkJORrQAqfOcdC7NpA8S1kFNWbQ5QPvl0IlG11Qc1Kd6d0nLmw2NzW0CAdt9WVqAO/2/lkY/kGGPgVIPQYcrA7NZzdZcybqsK4B6PKcRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mkNwSAjk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mkNwSAjk"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j6TRg5JMjzMlJf;
	Sat, 17 Oct 2026 19:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fEdoXKuc9WXprDdd+6o7ABz5SYa93GjZFXW8f8JCo8c=;
	b=mkNwSAjkMdydcycTaM0sSIlpEp452LFEnsimS1i0dw1j6RZlxas8B9i8n/x5mizB3bEphW
	duRFEVxAR2IdXBwX9qUArKrXZ6/jYzlpWrqlYITzjL9iCkRpJgvHuC6GmnsSGnaKg99PRY
	e34vwNSOouW0I4y0RAQ4ZL3G1McgQAuM043wF/im5RkO/SFGz9j9biCEeztaw39zpJeF9R
	qM89i5ZwhaXiY2zYRrUiEVrt4xNJpldNOh7t7kCvgO84OhYVrmeKjxSbhJ9+zOykqIi3yX
	zRHV4RGrBpTZUapEk6HVVTtPfieh8reBDDLHwVRfQy7QxLXbXYq+v/9FBt5//Q==
Message-ID: <f53e0f36-df10-499a-b737-c4c2d619bc71@mailbox.org>
Date: Sat, 17 Oct 2026 14:52:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
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
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-11-den@valinux.co.jp>
 <da9c10df-63af-4cf8-ad3a-084dd249cf21@mailbox.org>
 <bzonjl57inv2yr25bwn5nihjnrsxdswr44qom4raupdjtcwhao@333ri5yg6bil>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bzonjl57inv2yr25bwn5nihjnrsxdswr44qom4raupdjtcwhao@333ri5yg6bil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6rktkebdhutnsa9bb3qjw4tb7zoo4geq
X-MBO-RS-ID: 7231759fab174da8d6a

On 10/5/26 7:05 PM, Koichiro Den wrote:

Hello Den-san,

I apologize for my delayed reply.

>>> +	enable_irq(rcar->msi_irq);
>>>    }
>>>    /*
>>> @@ -804,11 +858,17 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>>>    	ret = rcar_gen4_pcie_host_setup(pp);
>>>    	if (ret)
>>> -		goto err;
>>> +		goto err_deinit;
>>> +
>>> +	ret = rcar_gen4_pcie_msi_irq_init(rcar);
>>
>> Would it make sense to acquire the IRQ a bit earlier, so you could avoid
>> rcar_gen4_pcie_host_perst_assert(pp, true); in the fail path ?
>>
>> I think if the MSI acquisition fails, perst signal would pulse (rapid
>> sequence of deassert and assert), and that could be avoided.
> 
> Good point, thanks. I agree that such a pulse is possible.
> 
> However, if we simply move the request earlier within .init(), before
> deasserting PERST#, request_irq() would enable the line right away before the
> controller is configured, and since .init()/.deinit() are also reused for
> suspend/resume, keeping the request in .init() means freeing and re-requesting
> the IRQ on every sleep cycle.
> 
> So for v3, I'm planning to move the request out of .init() entirely and into
> probe, using IRQF_NO_AUTOEN. That way:
> - The request happens before touching clocks, resets or PERST#, so a failure
>    bails out before the hardware is touched.
> - .init() only needs to enable the IRQ once the controller is set up, which
>    cannot fail.
> - The registration stays intact across suspend/resume, so .deinit() simply
>    disables the IRQ and .init() re-enables it.
> 
> .. That said, this may well be what you had in mind in the first place. If so,
> apologies for the detour.

This is nice, thank you !

>>> +	if (ret)
>>> +		goto err_assert_perst;
>>>    	return 0;
>>> -err:
>>> +err_assert_perst:
>>> +	rcar_gen4_pcie_host_perst_assert(pp, true);
>>> +err_deinit:
>>>    	rcar->drvdata->deinit(rcar);
>>>    	return ret;
>>>    }
>>> @@ -818,6 +878,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
>>>    	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
>>>    	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>>> +	/* Stop the handler before asserting reset and disabling the clocks. */
>>> +	free_irq(rcar->msi_irq, rcar);
>>> +
>>>    	rcar_gen4_pcie_host_perst_assert(pp, true);
>>>    	rcar->drvdata->deinit(rcar);
>> Shouldn't the IRQ be released only after reset is asserted and clock are
>> stopped , otherwise it might accidentally fire and cause unhandled IRQ event
>> ?
> 
> That would be a concern with a shared line, where the remaining handlers would
> see spurious interrupts. This one is requested exclusively, so free_irq()
> removes the last action and shuts the line down, ie. it is masked at the GIC
> from then on, and nothing the controller does afterwards reaches a handler.
> 
> The order matters the other way round. The handler reads the APP status and, for
> MSIs, DBI, so it must not run once the reset is asserted and the clocks are off,
> or it would hang. That is why the handler is stopped first.
> 
> With the v3 plan above this becomes: .deinit() calls disable_irq(), which also
> waits for a running handler to finish, before asserting the reset (again fine
> because the line is ours alone), and the registration itself is released by
> devres at driver detach, ie. only after the controller is down. I believe both
> concerns will be eliminated by that design in v3.
Thank you !
