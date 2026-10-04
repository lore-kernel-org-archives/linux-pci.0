Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F126296;
	Sun,  4 Oct 2026 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072707; cv=none; b=qIScY9KCnV4aw00Y20cONarqm//TGgYsKKH9yNeQbmLScQaLSJFVBFH7svQUC5YQECFbGEF6YYS9nvNk1CsQjbb1NbQ60Rt97DGenGG8mEvfRIk1vmPuRTBf0/Up1xI6aaZA3M36X6Et0reZfkU3TxVwppySrrEPECHLnmSiWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072707; c=relaxed/simple;
	bh=j5NivsM6Abd7q/r0STUeF1BWClQLsSJ2VzkYv+R2+pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLTD9aea2b3B/nLIb90tNiVduNAixDuU4HaLInjPpt0pB9sfYzy4tGhzyN1ht2pF1XiDXoXjP9gqEIxk2DtvaTHnz5MzXZP475+MsRRmpAFVHRUfXidcucHFjWMk9iCYAtxbnNvI68kT4pRX2ZwZ3A7ruTWCoiYxcygZULRVKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uDKVyEFv; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bHqDUPE2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uDKVyEFv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bHqDUPE2"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hy2xq3jcKzMlJj;
	Sun, 04 Oct 2026 02:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791072703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vDNHPkvvAMC058wVYuCg/qLERKnJd710F0m3V+FqgU=;
	b=uDKVyEFvjmDWcA41AZsDpWhGrEGafpXM59SR4wURt0rGnBLgxSBMTOUU/8QjZaa7uoGmA6
	6slCrNpLpaAiUNqZTup+E6qNzORFPm5pc1BkgIVlSI/WFM+AR0h0lL1HL6uNJMhMVSEfuZ
	GFcq/0Us0wo1HmtN0adyDNuX7fMyWdQhrGdffWL+fEiabW5QdU9sOgMMUQ14RoaeJnaCI9
	AL97MAMah/wV4ZDfosZht9B6rDiTn3yhwTz45jP93J6bt9QsfxAvG+aay1CurhxvNuqPJF
	bxi6uh9ekNEfag/fiqCDLc3lehT54cqWGZwZiaMrpIpnVMXwq6hvFuivyrBNbw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bHqDUPE2;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <f9258887-2cc5-4c88-b465-5ac7fc1e82ea@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791072701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vDNHPkvvAMC058wVYuCg/qLERKnJd710F0m3V+FqgU=;
	b=bHqDUPE2yAxHA4h9JMkia0GApU9yau1onndQrFUVLPBq+FEWUUW7LsBw1O6xrGwNmVNU7L
	OAnArAfWgX2YXs2VJgqnXnrJzffEa5H+pGPqTXMTFj1iahs1KNigR/iLAQOUX1B7jjOQk0
	f6onJBPjWmIF7JEuPmIaUmmmOVR52BZfgPDPOiJ6MU0q6BPsdfut/Jcif9vNTigRAAV7wY
	scSXP1Oekw5wqEf+MgmWJt1+uDlj97+XCUWmk+QdElJAVmSEzvebu04i5Fe58cCaaJb29+
	yKSNnBaly9H33kr+7hLFZ21AM4RE1c2+d/bNRqmHPn1s6xjdervzXWhKakyniA==
Date: Sun, 4 Oct 2026 02:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] PCI: rcar-gen4: Add Root Port reset support
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
 <20260928165230.3397664-10-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 23aee43605556893c6d
X-MBO-RS-META: mwrtr9br5d6utu5ogsrn5xrsrorotaam
X-Rspamd-Queue-Id: 4hy2xq3jcKzMlJj

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Implement the host bridge reset_root_port() callback so PCI error
> recovery can reset and reinitialize the R-Car controller. This also
> provides the reset operation for the link-down handling added later.
> 
> Call .reinit() with clocks and PHY initialization retained, restore
> the Root Port registers and restart link training.
> 
> Rather than tracking which APP interrupt enables survive the power
> reset, derive them from software state through a single helper. A flag
> keeps the sources masked from the start of a reset until one succeeds,
> so a failed reinitialization does not re-enable them against an
> uninitialized controller.
> 
> Serialize the reset with a mutex, as not all callers hold the Root
> Port's device lock: pci_try_reset_function() on a downstream device only
> locks that device before falling back to a parent bus reset.

Please pardon my ignorance, but is this maybe something that could be 
fixed in the core code ?

[...]

> +/*
> + * R-Car Gen4 controllers have a single Root Port per instance, so the

I have two nitpicks here.

First, this is also applicable to R-Car Gen5 SoC PCIe4 controller, so 
please rephrase as:

-R-Car Gen4 controllers ...
+R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller ...

Second, in another review thread, Bjorn mentioned it would be good to be 
more explicit about what is SoC generation and what is PCIe generation:

https://lore.kernel.org/all/20260928222442.GA2266778@bhelgaas/

That is also why I used such a lengthy sentence above, that is

                               Controllers are here
                                         |
                        _________________^__________________
                       |                                    |
                vvvvvvvvvvvvvvvv                    vvvvvvvvvvvvvvvv
R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller ...
       ^^^^^^^^                            ^^^^^^^^
           |                                   |
           '----------------- -----------------'
                             V
                             |
                    SoC generation is here

> + * 'pci_dev' is ignored and the whole controller is reset.
> + */
> +static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +					  struct pci_dev *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
> +	struct dw_pcie *dw = &rcar->dw;
> +	struct dw_pcie_rp *pp = &dw->pp;
> +	struct device *dev = dw->dev;
> +	int ret;
The rest looks good, thank you !
