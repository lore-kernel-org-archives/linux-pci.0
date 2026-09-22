Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7152BE31;
	Tue, 22 Sep 2026 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113508; cv=none; b=R7ydssNURo9BXNpRY7/BNbQIm8aTKeC41UViJOX3YPHNg0wt9XG7qOHhRtQNCstv+eueB0N4wpXAs1LYY62AAlfnxtMyiwqWPuVTj2FXDcMTPwYUkp1O2C0u8CnrKHSAlB1Ww+9Vkd01emEZY4CDrT4a9OiBXeBp1MSy5huOISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113508; c=relaxed/simple;
	bh=jtXWduW9T8sdenTyKPeEOj8abQDK+0uQ7YLqg2kq7wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bolyKX0sRt/7gW8Qs2h8tQZJI/0lhYF1e8OhNozCv1DvYnz4Op+Zs+jboXA5Er1HrNGyGE6V4XRNXa28u/0f92nhu5diDZofMSGTpjwe2nF2X+ABymIi8Kt2rPEWVYXI8l9LZ+n6X+57DYqGH6XTXuk9V/knHRHECkTdhyqAjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jxstbTcB; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jxstbTcB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hqDC92Y6czMlTw;
	Tue, 22 Sep 2026 23:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7d+H5tuYUz+5N+ap+ceCZ440EuzT6CKTUEXJLtqrNsw=;
	b=jxstbTcBaMDFYjezPeyCdWAaKMPTVzS/F1uIqSoVPxGh3OtsdnpmNqowQUHMCMGjiC/mDK
	U4CFea/xhsGkuXpD8mCKKK7DdSR78HQTsUXll8YX/8CVQ0NcdfQNlZMQGlaiWtlh1fgJ1s
	xjooZ22l+E+CBXU7liZskkt2eVT14Yc+NwNipWxnQ7jSdnV4VCO00ZH7SVH+Wczigvl+t1
	MGThWvEQcgtA5LKNk6DAsRRyR/aaUgbEDyjDY2Vw6wHOPRZet2R690friko+bqVhRS+YI9
	C+sfVghItagYQSZF1kLp2mwdC+swI9HujNQKt9WK6qvyfH4qRxUjiWSmYJHuwg==
Message-ID: <e99b8b02-861e-4980-b7a0-f0075640589d@mailbox.org>
Date: Tue, 22 Sep 2026 23:15:48 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 05/11] PCI: rcar-gen4: Split reusable hardware
 initialization
To: Koichiro Den <den@valinux.co.jp>,
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
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-6-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-6-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 16gim63djxqq4kgewzs4spxh9e65ukxg
X-MBO-RS-ID: d842c81bab921a0cfd7

On 9/18/26 5:20 AM, Koichiro Den wrote:

[...]

> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -178,23 +178,18 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>   	u32 val;
>   	int ret;
>   
> -	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> -	if (ret) {
> -		dev_err(dw->dev, "Enabling core clocks failed\n");
> +	ret = reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> +	if (ret)
>   		return ret;
> -	}
>   
> -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
> -		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> -		/*
> -		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
> -		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
> -		 * indicates that for peripherals in HSC domain, after
> -		 * reset has been asserted by writing a matching reset bit
> -		 * into register SRCR, it is mandatory to wait 1ms.
> -		 */
> -		fsleep(1000);
> -	}
> +	/*
> +	 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
> +	 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
> +	 * indicates that for peripherals in HSC domain, after
> +	 * reset has been asserted by writing a matching reset bit
> +	 * into register SRCR, it is mandatory to wait 1ms.
> +	 */
> +	fsleep(1000);

This fsleep here should only happen if the reset wasn't asserted before.
Is removal of reset_control_status() correct ?

>   	val = readl(rcar->base + PCIEMSR0);
>   	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
[...]
