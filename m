Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8C33E37A;
	Sun,  4 Oct 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088922; cv=none; b=Pfu4D+yTZNwY8IfNEAq1jUFBUez/ZbFbz4QdsddvrCu8JosqXvNTCesD7DwkQ0YOhQ15ATJcIAuci/Gis2NPk7nsyuTBc+er/i6DqvFDBIq7n+2pQ9ghrUfR++VFbulTGruN9Z+TIfym+S6pah6pSConHxjfVjX7J02HovM7iKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088922; c=relaxed/simple;
	bh=uZcxBtZB3Xm5NW7jagvNAk5VawUQPQGWNLsRm+RiYS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cc9DPblKfzo11UxcN568IMIBGhynwKgVGa+kDYDPdlcjx9uOQOnXZpK+8Tpzaos6Yr9kL8hh5qo0W5bAWNXN2bhPQqmMfgXLnOq7mPDdIO9/XhVP633fy5tjtBTbyrDNMgpGbsh5ObFMauUjujr+v2CqxLd+Oc1Them+64Dxxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fTwj8DYW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=S+fRFLyn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fTwj8DYW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S+fRFLyn"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hy8xX5YkPzKp6n;
	Sun, 04 Oct 2026 06:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRryD4iMy0JcxbevsBdfb95sOyBQYzLLuO8ePtdynDo=;
	b=fTwj8DYWbvRarfAshW2BoSwWzcbV969g1DauxxL/EDe26NE5g7MwrvwbLWfxFGbLIm+qru
	OmPSn7Cp3OZFkvdJXWl/tMfSN5KVzTH8Y+lgrnNZ+TtoerwPHgSq1Yz1WMD6NgW/TSu8hn
	jpceMlzkVDrEVaBVTyH4LhxbZlHjLcSBEEKHiG7YyWtyqvaq0HBqr+FEwrq25wReaDJl/+
	kzqcPmNFV6ZXyDiE9Mo3Y6gtW3KJglhdse4vqGtI3O7D98A32Pt+3awMO04khpq3JzM5zy
	AqXjfszKAa57tfiSfEd45SNHcU9Oq8CX9ae8IuLWISltWYeJP4QLB8oINMrEAQ==
Message-ID: <c469a0f3-2f71-4464-ae82-23c7aae32a96@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRryD4iMy0JcxbevsBdfb95sOyBQYzLLuO8ePtdynDo=;
	b=S+fRFLynj/OyTjs6IQEQLVZ4JSmiKSMbg8m+xch0xiiVfwyfqyuGRrrUdmY7XW8fEzCqgG
	0usDhR6usQMKKuVcdTUTp112ZfyUHbJbLKpLz4XdmNz7+GLHkCN/Yp4KIxcXhAor2yJB6K
	WHyyEHTVaMEv25k/Oqp5NxuMkN9cBkFSL9cDDB7+02SCyc4EzUGkOCshXb3Q3AJKUexrxF
	qhCpPXtt3tHLWwlJmV6cp1pMxzo/j5F2wfQxEU97PtC85Bo4vqIegVa4AKWjxMDzmaOGm2
	bUC19WDorE70/1GFjvzYzdERD3xaIXf8mtpRtf7V/o9wWWxR4YjOb41s2gJFaw==
Date: Sun, 4 Oct 2026 04:52:13 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] PCI: rcar-gen4: Route Root Port AER to a virtual
 Root Port IRQ
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-14-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-14-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 82c44c6f8304cbbca79
X-MBO-RS-META: qyo1sxezettko6w9749hy8fyqhg1b7hb

On 9/28/26 6:52 PM, Koichiro Den wrote:
> On R-Car Gen4, the APP block exposes the Root Port interrupt signals in
> PCIEINTSTS0 and routes them to platform IRQs: AER to intreq_pcim_lperr,
> and PME and bandwidth notifications to intreq_pcim_sub. On an R-Car S4
> with GIC ITS, a link retrain set LnkSta.LBMS and latched PCIEINTSTS0[23]
> (cfg_bw_mgt_msi), but the Root Port's MSI never fired while endpoint
> MSIs worked fine. With iMSI-RX the Root Port MSI capabilities are
> already hidden, but its INTx maps to intreq_pcim_sub. Note that even
> before this driver took over the IRQ with
> rcar_gen4_pcie_msi_irq_handler, the port service was unable to request
> it, as the DWC core used that IRQ for its chained MSI handler. In either
> case (ie. iMSI-RX or an external MSI controller), Root Port interrupts
> are not delivered to the port services.
> 
> Set no_rp_msi so the port services always fall back to INTx. Allocate an
> IRQ in a single-entry domain and return its number from the bridge's
> map_irq callback for the Root Port only, leaving downstream INTx
> mappings unchanged. Notifications from different platform IRQs can then
> feed the one IRQ the port services share. Route the AER notifications
> from the "aer" interrupt to it. rcar_gen4_pcie_host_msi_init() sets
> MSICAP0.MSIE when pci_msi_enabled() is true, and hiding the capability
> does not clear it, so handle both the MSI and INTx forms of the status
> bits. DTs without "aer" remain supported, but the APP AER notification
> sources stay masked.
> 
> Preserve the virtual IRQ's enable state across controller resets, but
> keep its APP sources masked while reinitialization is pending or Root
> Port events are disarmed. Clear only the MSI-form APP latch, before the
> AER handler clears Root Error Status, to avoid clearing a newly latched
> notification.
> 
> Handle pending reset requests before dispatching AER to avoid unsafe DBI
> access. Serialize dispatches from the parent IRQs, including the "msi"
> path added by the next patch, since handle_level_irq() could otherwise
> acknowledge a concurrent interrupt without running its handlers. Recheck
> reset requests after taking the lock in case the other parent has marked
> reinitialization as pending.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
