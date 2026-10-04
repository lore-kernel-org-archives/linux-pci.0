Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0DF3B47FF;
	Sun,  4 Oct 2026 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791076692; cv=none; b=pMKA8p72MHQ+ivIsBmof4P9R1usLSTjBqNO44E6DOOY8N6VpGeBiMuoRgQZai0RXGKdkeBGYQmR9KZBSpDJUZI33aGduOhcJOMPCThlsR3CHfb41n3QLefQoJEMQUCphptBl1/c9E8Cfd+10LsUTzrI5ImDSGjs41Of/XtsAeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791076692; c=relaxed/simple;
	bh=ZrK5F+BS8P/F+Eki9Yf7hdYpHLirl+MxxafEYwNJCM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gp1f8SzesVUXxnvhSw6JMh9kb7rwAECAMAcaaU28Pe4cEwlNt6B59pVKCAf9gSU1cgWav/LwobcAw9hHsqOCr6Xt3ntMYiLcB+CCZN5556E/ZID6S1ihG62c1vy8/cpSks1hYr6vUPYfurjh0s8z+Q8bTaOBIWYuC9iTNlWVTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RYBML55L; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RYBML55L"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hy4QQ49bxz8v5H;
	Sun, 04 Oct 2026 03:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791076686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I27LSBbroR4zeqOTMUyWqnpoHOi6vENrapJOQR+Z8SY=;
	b=RYBML55LpHSL5qYqULnQDEnxOLOCT7XcFCOoJhFv0y3PEeTrOXcsHgHX6f0zU+dftyE02l
	Lh0u5VtDaD6atFkZ4MNXdm0dxIAJPcK9BJ/KT4lr/OB5LQQE6yZ82kyHQgHSozlFA/Fsza
	kfYnf5oviGchsFyQCvvWOb2DiM4XtBYhqPtF/OWNCb5DWrkbszNhBSH+9/nIx273+ERdAx
	33ZT+63mMIOylF2OnIda+P6RhqYA5KfV0GTeJt0nNNdTnn7EtUZB5LprYYdKkMBBtMu5yf
	ldTVd30aMquIQQJ6ExhwsPYgjVpR8O7xBcyh9xPUkekzaO0wYOFF7UDxIjF88w==
Message-ID: <0e0daa99-b155-4ddf-b4ee-90ce2d2ad270@mailbox.org>
Date: Sun, 4 Oct 2026 03:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
To: Koichiro Den <den@valinux.co.jp>,
 Geert Uytterhoeven <geert@linux-m68k.org>
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
 <CAMuHMdXoKFCroL1d6-fLwYR0UkLBL7suKy=rOFavioLd7rC4OA@mail.gmail.com>
 <cmswtcb2i3todukcpra4vsqnkgu6w3wytxwvdqi2pvyep2j4kh@4dmmgyhkx7rp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cmswtcb2i3todukcpra4vsqnkgu6w3wytxwvdqi2pvyep2j4kh@4dmmgyhkx7rp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qq4a9iuxgbc1886au8qx3xzassphg6ug
X-MBO-RS-ID: 4b655c4b4c1caaf1934

On 9/30/26 8:38 AM, Koichiro Den wrote:
> On Tue, Sep 29, 2026 at 07:43:28PM +0200, Geert Uytterhoeven wrote:
>> Hi Den-san, Marek,
>>
>> On Mon, 28 Sept 2026 at 18:53, Koichiro Den <den@valinux.co.jp> wrote:
>>> On R-Car Gen4, intreq_pcim_sub ("msi") carries more than the integrated
>>> MSI receiver: the controller's reset requests and the Root Port's PME
>>> and bandwidth notifications are signalled on the same line, and the
>>> following patches need to handle them. With the DesignWare core owning
>>> the line through its chained handler, the driver would have to hook into
>>> that handler when iMSI-RX is used and request the line itself otherwise.
>>>
>>> Instead, request the interrupt in the driver in all configurations and
>>> set pp->msi_irq[0] to -ENODEV so the core does not install its chained
>>> handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
>>> the MSIs through dw_handle_msi_irq() when the APP block reports
>>> msi_ctrl_int. With an external MSI controller or pci=nomsi the iMSI-RX
>>> is not set up, so keep msi_ctrl_int masked rather than enabled, and the
>>> handler has nothing to do there yet. Request the interrupt before
>>> enumeration, as endpoint drivers may use MSIs from their probe, with
>>> IRQF_NO_THREAD so the MSIs are demultiplexed in hard IRQ context like
>>> the chained handler did. The interrupt is required by the binding.
>>>
>>> Release the interrupt in .deinit, before asserting the controller reset
>>> and disabling its clocks. Disable it around a Root Port reset because
>>> the handler accesses the MSI status registers through DBI.
>>>
>>> The DT routes downstream INTx to the same line, but the driver has never
>>> supported INTx (no INTx domain, INTx enables never set), so requesting
>>> the line exclusively takes nothing away.
>>>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>
>> Thanks for your patch!
>>
>> FTR, this interacts badly with "[PATCH v2] PCI: rcar-gen4: Add missing
>> PM ops"[1] during resume from s2idle:
> 
> Hi Geert, thanks for the heads-up.
> 
> I'll fix this in v3. I'm planning to address this together with the "Known gap"
> noted below the commit message, by moving IRQ setup/teardown out of
> .init()/.deinit(). On hindsight, I should have done so in v2. That should also
> avoid freeing and re-requesting IRQs during suspend/resume, without needing
> IRQF_NO_SUSPEND.
> 
> By the way, AFAIK Marek has posted v4 of the PM ops patch:
> https://lore.kernel.org/r/20260922175525.288106-1-marek.vasut+renesas@mailbox.org/
> 
> I had only (re-)tested v3 on the EP side (not RC side):
> https://lore.kernel.org/r/ain27ypszl767h3fygurivurojxctyjy2yprada6lgjef5c623@23nn7tsrecb6/
> but while looking at your report and reproducing, I noticed that
> rcar_gen4_pcie_host_ops lacks .pme_turn_off implementation,
> so I wonder if it should also set 'pp->use_atu_msg = true'.
> 
> I mean, something like this:
> 
> ------8<-------8<------
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 1f8821e3a424..b8237962de18 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -671,6 +671,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>                  return -ENODEV;
> 
>          pp->num_vectors = MAX_MSI_IRQS;
> +       /* Reserve an iATU window for the generic PME_Turn_Off implementation. */
> +       pp->use_atu_msg = true;
>          pp->ops = &rcar_gen4_pcie_host_ops;
> 
>          return dw_pcie_host_init(pp);
> 
> ------8<-------8<------
> 
> Marek, I'd appreciate your thoughts on this too.
> Perhaps this small change could be included in v5, if you agree.
This does make sense, yes, thank you for spotting this. I will be 
sending a V5 of the PM ops patch now.

[...]
