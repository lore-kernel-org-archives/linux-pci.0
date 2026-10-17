Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAD3E3166;
	Sat, 17 Oct 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258426; cv=none; b=DP26UNJPn5+mmvP1j++zd+x2ybQyhuVfQytLODtu7w0TztXd+Z62cDle63jGg9dkSiHV6jzHXkeZTPw/zIGgtOK4qVXdQJH1RrXiLvTbESDqyr4U2kkpMHVH7khBPYQ89fUmuZdnzPsv2qzoFdCY4XnMd5lY1kcJFXUpHJm9rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258426; c=relaxed/simple;
	bh=IUJd51KWozyQLygSes8hddJB8a7qdmrT5nPCtefoB4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJO5nfuA529WTaTggzEHm+XoX/IjQS+Vy8uXRG0aF3dHTnClaoDwcUD1Ni513KevdzrW/e2ZfC6H5ZXz+WVfh/+S+ndEKxLuFbSSN92N3ieUvIibVqGeRMCFo+Sl8xqR6wXm18kTLmTcZhZReKOJ/mGvKrSgkV7abbyST+lJpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HH02ghAt; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HH02ghAt"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6TS610tSzMlgt;
	Sat, 17 Oct 2026 19:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792258422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvwuFiBfGMkK7gd+d5AlAkqkQpsPkiDHaN3e8k7c/ZQ=;
	b=HH02ghAtMwW/dX3kRjhcJzTK3WCqspb8M1ohVnthbmReezeFC3d16EsiewjdSPRhw1uwjQ
	CN/JdbZylPSw1i51eRd0vlJDHaXEhgt6ep87jF1wxWa/ZQ7Ld0mDhW/TB7MkEvh2dxd/Ic
	57eaWkhIk9bdYJhWq0PnncgDB9b2nNXTvJw7OalqL9EdqYZLzAg8gjU+i8hxTiME0fl5BZ
	ux2q4z7lLRO8PQ3abv/Nnsf71q5asAcnbs0LkVJ5/svWiIJbL38HdwcncWQjQFKnU13MpE
	fL1VDIF8xLQ5wHZ0xn1O1l6gqzPaLkhcMEqAnphEvKTrEbwcoz67R+lPYCXSng==
Message-ID: <46a5f906-54da-4869-b57d-5bdede502eee@mailbox.org>
Date: Sat, 17 Oct 2026 16:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/18] PCI: rcar-gen4: Route Root Port AER to a virtual
 Root Port IRQ
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
 <20261015033103.3076869-15-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261015033103.3076869-15-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3058120e682829987cf
X-MBO-RS-META: hrd1m131xyh95nn17nsnaajfgdb196ox

On 10/15/26 5:30 AM, Koichiro Den wrote:
> On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
> signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
> intreq_pcim_lperr, and PME and bandwidth notifications to
> intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
> LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
> Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
> Root Port MSI capabilities are already hidden, but its INTx maps to
> intreq_pcim_sub. Note that even before this driver took over the IRQ
> with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
> request it, as the DWC core used that IRQ for its chained MSI handler.
> In either case, iMSI-RX or an external MSI controller, Root Port
> interrupts are not delivered to the port services.
> 
> Set no_rp_msi so the Root Port services use INTx regardless of the MSI
> controller. Use a virtual IRQ to deliver notifications from separate
> platform IRQs to the standard handlers. Route AER from the optional
> "aer" interrupt. DTs without it remain supported, but Root Port AER
> stays unavailable.
> 
> The APP block may still receive MSI-form notifications because hiding
> the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
> these alongside the INTx-form level signals. Clear the MSI-form latch
> before the AER handler clears Root Error Status, so a late APP clear
> does not erase a new notification.
> 
> Check for reset requests before dispatch: on S4, DBI accesses from
> the port services can hang the host immediately after link down.
> 
> The next patch also feeds PME and bandwidth notifications from "msi"
> into this IRQ, so both parents may dispatch concurrently.
> handle_level_irq() calls irq_ack() before checking whether it can run
> the handlers. Keep the APP latches set while the IRQ is in progress or
> disabled, so the level parents can retry through the reset checks.
> This avoids losing notifications without a raw lock around port
> services that take regular spinlocks.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
