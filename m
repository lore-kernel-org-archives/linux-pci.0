Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE233CBE79;
	Sat, 17 Oct 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258411; cv=none; b=l0q4tD8PNI3LK3ieRaA8XDCNIZ1/Hl37yxyhGFgRxe1TqNZr2NA9NYcj5yVxJQZMkYsbDrb/vbk/dAaVw8LDOQPJ+tHLJweLvtorrEM9i2+w67otbOz0m9KofA5SAT3FmzVWZd3lHLSMALTsgmnjyeuKlYiJRHUoF7GmOPKJQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258411; c=relaxed/simple;
	bh=SVPxMCmXzVBzbJpAKDVgPG9wF+xi4YDvl/8d5ZlJo6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AksvRW7rCG2vEvmG5DNFlK5wXD+S6+MNMxCndLWeqU1b4K4VU8oj7+tz54mrp8lz+SlrU0Iv/i2oG08qYdo90LlJVs0SIUdKlZ5I/LdRzk8zlZE6qxUvdOabQGd1SJwFoLXq4Otaao5dSRQ814VSUEo0g/QX7Lo7Sp4PwxTYA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ki2N0vJe; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ki2N0vJe"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j6TRp1jGwzKnXG;
	Sat, 17 Oct 2026 19:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WACH0kj3DWQ5bZQXuydmn1UgxTbNp6A0TmV9yPB79u8=;
	b=Ki2N0vJepZ1Jt0g8tjaO78BudoWJi5eOWVYp+uwGIH9b4tf5eNTPxu2sdDYbAf2+BHTJYI
	Es4KGlefG5VuRyrkWFuiw4XVW+UCBE9OyzbXc/zemaMxyvwkW1/HqBJnkmAt+8L2wbh6dk
	Nb8UNbs0yeO18qmKZ/5KgiTrBGpPFSHe2NXygwSxLLpdrZzN+yCWzb2LAgrg75epNKkiFA
	QVWc3cQaMK1zuZ3ARMdks8EGzIaWiSAQwqvnDhR0XVuZ5sYxbsVs9HF+5JIljlu20tfMK1
	iqo7x27qnqWHoKPjKMNcmqXINmncM7oDCa3q9RfNetN3HaRU0nGrQxEFZe44sw==
Message-ID: <ba065c55-e28b-41c1-a350-301272bf8444@mailbox.org>
Date: Sat, 17 Oct 2026 15:07:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/18] PCI: rcar-gen4: Take over the iMSI-RX interrupt
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-12-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gcaa7afamr66je5rxhmie88qtwo1afom
X-MBO-RS-ID: a328a4c66f96da4a860

On 10/15/26 5:30 AM, Koichiro Den wrote:
> On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
> integrated MSI receiver: the controller's reset requests and the Root
> Port's PME and bandwidth notifications are signalled on the same line,
> and the following patches need to handle them. With the DesignWare core
> owning the line through its chained handler, the driver would have to
> hook into that handler when iMSI-RX is used and request the line itself
> otherwise.
> 
> Instead, request the interrupt in the driver in all configurations and
> set pp->msi_irq[0] to -ENODEV so the core does not install its chained
> handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
> the MSIs through dw_handle_msi_irq() when the APP block reports
> msi_ctrl_int, in hard IRQ context like the chained handler did. With an
> external MSI controller or pci=nomsi the iMSI-RX is not set up, so keep
> msi_ctrl_int masked, and the handler has nothing to do there yet.
> 
> Request the interrupt in probe with IRQF_NO_AUTOEN and enable it at the
> end of .init(), before endpoint drivers can use MSIs from their probe.
> Disable it in .deinit(), before the controller is powered down, and
> around a Root Port reset, as the handler reads the controller registers.
> Suspend and resume go through the same two callbacks.
> 
> The DT routes downstream INTx to the same line, but the driver has never
> supported INTx (no INTx domain, INTx enables never set), so requesting
> the line exclusively takes nothing away.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
