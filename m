Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF63352F86;
	Sun,  4 Oct 2026 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088921; cv=none; b=e9idIqDAsnw+Q3FvBypQ2d8fOwzUmUFh/gnLJzqjm/IxYip3V+oUG+M9/AfP3tKTPoHQTkPvwbC7oG2BFwl3ZmGOfrKQxaFTDFufvkUKNl4wDPASQOVNJwnFfo5NxPlbnojmNhMeD/pqix6St6MiPUsHZ7aHFTilMnGwhKajM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088921; c=relaxed/simple;
	bh=WeYAbnKraGquD6hG+iwdKCLUsXQhWhgthSL7+YCGGus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/oyTDdG4pJqslbI0NUJVZFFIaTtnEvwtsYaE9Bly3h9Evi39i00SP6Zc2bExrUeD/DYXDWdVbdSobV2Wv4j3E9qvLybLheeCStoo/a9W/jwNqEJwjsYkp7z65oLMQ17oEQqufr4DBfUcsCcbmkxl43LGa0bcXEv9JP8H1qcDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DismZzUk; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xRvO1oTh; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DismZzUk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xRvO1oTh"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hy8xd2xr8zKnRy;
	Sun, 04 Oct 2026 06:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsjaPFOhIeaA9bw45la9E5+jYEJeCq3GYxOiu8lOmxA=;
	b=DismZzUkcuweoYgJktSsHsHEQnvxFHnxhrDSrwdjjsGJyc+qh2I4uMY9/7L52/Zmv7rSWb
	3IVuEHfhtESPk+9T4hYQC0si60BsAzjQoM0H900RHx9kyPShB4+xWQleTiajSpDZSbfsu2
	1sHvb0dZEbEf9nptGdHABXoCdpa5JjZz+qoB/OPJNXWdFw3LLEEhAOUwnqU5robbtYHjZU
	3MXvXLy/XZdtiEiCR5xlBIeJQ9INtbPW/d/zkeHRXanL0aCakU1oCJaKXe0i43l2WPw114
	6oWISW1ZXLw+gcNrLzsDJjcqCUpMn0O2MBO7BQmb4LDihanpbCq3J3YKsNAn6g==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xRvO1oTh;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <9035b113-c53c-40a0-906f-0fe280d7d762@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsjaPFOhIeaA9bw45la9E5+jYEJeCq3GYxOiu8lOmxA=;
	b=xRvO1oTh4tND/Bf1DtwnRRPeo6Nf6woXKKhB4l0DqxtVQd9r63G5+5QoBKIPY2bjOi6x1W
	xWX1JHvDzLe94QKwY/ekKq0Qm717r0fsYKpW1YdwAI0yWGCPjQnnw6/h1esoTUOXaq81bH
	0BAz/WtUnkZCYyCla3OLcPBnxR7/ZJFTliLlm+7Vrkt37tnjHnlJpGYyRPiASptNVUzaf6
	aJUhPVaR+SInzZZDDdhuKTy5lO06M6nhlxtPxfHXrH9DzWw93tAalE2gVgWlaBLef+Yu+5
	xd1qM5zMuKJYWaEtEHwwWb/tVlIL3Bg01OgmR4KTFH4P9tpWWFmfhvQ9wA6WzQ==
Date: Sun, 4 Oct 2026 06:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
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
 <20260928165230.3397664-15-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-15-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: s5y9gdg7oojgotueyh1ithis3gwmew6i
X-MBO-RS-ID: 89d29a133166690a8c4
X-Rspamd-Queue-Id: 4hy8xd2xr8zKnRy

On 9/28/26 6:52 PM, Koichiro Den wrote:

[...]

> @@ -753,12 +766,12 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(int irq, void *data)
>   
>   	status = readl(rcar->base + PCIEINTSTS0) &
>   		 readl(rcar->base + PCIEINTSTS0EN);
> -	if (!(status & MSI_CTRL_INT))
> -		return IRQ_NONE;
> +	if (status & MSI_CTRL_INT)
> +		dw_handle_msi_irq(&rcar->dw.pp);
> +	if (status & RP_SUB_MASK)
> +		rcar_gen4_pcie_rp_irq_dispatch(rcar);
>   
> -	dw_handle_msi_irq(&rcar->dw.pp);
> -
> -	return IRQ_HANDLED;
> +	return status & (MSI_CTRL_INT | RP_SUB_MASK) ? IRQ_HANDLED : IRQ_NONE;

Only a small nitpick, please don't use the ternary operator, readability 
suffers, please do:

"
if (status & (MSI_CTRL_INT | RP_SUB_MASK))
   return IRQ_HANDLED;

return IRQ_NONE;
"

with that fixed,

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
