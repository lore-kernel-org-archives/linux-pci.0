Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208465;
	b=V/FPqeX3fZwjxETwwkbyf/295qQW3nnXlKTyytwaiL6wzoJj1UYVBIMEXvejxn7Lp0Q8
	 y4KkfbujPviV2LjcgMa2KTBHO9ASQKfJgMn4AqBFg0crczJwPBjX2x1BrdwcE9XLuiRaz
	 fKFeqkXjPyIBVIJKVWNX24GxayU7uNpjbFr8i2NEGoB2oxB/p/BMOkpSbPruGtM3dyowp
	 muC6r+G8VQQKVCUwRME54hpeXoM104+mjam3WXHhyrrGXmrbE1KoigetQpxEdPeU25aex
	 l19wmW2150xfjXXI9Wn0nsmN9Igo+g9UYuRLIdoKqMA9VwJM4pmjOlIaSDstgdknTsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208465;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=fyriXkBqv5S2RoZ4yqnZmH7bFaART5tOxZLSG19Qwtk=;
	b=Jcga+NypUYV1svpimvtLE+SIaLfiNCmO28qLMM7YRLsG19ULd2aFE8V1CuVoaGw0xzoK
	 c6KPMomUesSlk+dTrws1S6NT4N3jmedULPTSOCZYqBdfTtHfssMxbKiMvJ1tGuOLwMCrc
	 z0E8DiDyBnlDlSILZCtUJ9FU8xnDsgEWgJYho7KKi+lHQUV7f2E9wli8ZqBNrTT4ZKza0
	 0U1XTI397ev/bUMc8ftNgnORtm2qqMBSm51RKztgu3otZ0UMq7O36n2I0gCR8ez3xwfQa
	 keL5G06OrGNH4jemj8e4XPg8tjYjRmJl5zjgaBx3/atH9hRxReUXHN9O/anlLqJgwFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eTjhGW8f;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B96606A31A;
	Wed, 28 Oct 2026 17:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eTjhGW8f
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jFDp54FPZzKm4R;
	Wed, 28 Oct 2026 18:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793208461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyriXkBqv5S2RoZ4yqnZmH7bFaART5tOxZLSG19Qwtk=;
	b=eTjhGW8fFANlswC7YarJtfWZk3+ehT6dErNfDPmdEH2KbTgN0BDFm5G1Lms8i06TDg6LRF
	JevReuY7h6zbfU8rQqOXORf8VS4/L4Zi3EROcs1Kr7ZDALcEq53UvNSo7AWZ4mHEhv81pK
	AaifYmPk3+q4FamDcNk1+yNNRIfkRRNzMRqx3ggHmTFY7pNyWagyQ8w3lOjqbCAqVvU0DL
	9tCj3nRlOpoC8p7uOXKJgchfrGclBSaVh0xud0cDxhbWJFtgSoCfsc6cCToEqxgkCmhPxR
	wU9q+48JzZn8u3JZh+zrYDrs8Am/3UUHN+JfeJZUN+JxgosAnZRyNs0KgVFHaw==
Message-ID: <18b4e960-caa1-48b0-a5aa-f3585274787d@mailbox.org>
Date: Wed, 28 Oct 2026 18:27:36 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with
 GPIO reset aux driver
To: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Alex Elder <elder@riscstar.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Jingoo Han <jingoohan1@gmail.com>, Koichiro Den <den@valinux.co.jp>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Lin <randolph@andestech.com>, Rob Herring <robh@kernel.org>,
 Sherry Sun <sherry.sun@nxp.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vidya Sagar <vidyas@nvidia.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6aodyibmnz1i7rqmk15yrgtpx7718x9q
X-MBO-RS-ID: 9ebc450d80878dcba81

On 10/28/26 6:21 PM, Marek Vasut wrote:

[...]

> 1) Combined mandatory PCIe core resets and optional GPIO PERST#:
>     pciec@nnn {
>         compatible = "renesas,r8a779g0-pcie", "renesas,rcar-gen4-pcie";
>         ...
>         resets = <&reset 624>, <&reset 1121>;
>         reset-names = "pwr", "core";
>         reset-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>; // This is GPIO PERST#
>         ...
>     };

[...]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 12f102f48d5d5..b09c01853d807 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -104,10 +104,6 @@ static int dw_pcie_get_resets(struct dw_pcie *pci)
>   	if (ret)
>   		return ret;
>   
> -	pci->pe_rst = devm_gpiod_get_optional(pci->dev, "reset", GPIOD_OUT_HIGH);
> -	if (IS_ERR(pci->pe_rst))
> -		return PTR_ERR(pci->pe_rst);
Bartosz, alternatively, I wonder if there is any way to request the 
reset-gpios as reset controller reset here already. That might be even 
cleaner, but I don't think there is anything like 
devm_reset_control_bulk_get_optional_exclusive_and_also_request_the_gpio_reset() 
or devm_reset_control_get_optional_exclusive_gpio_reset() . Maybe 
something like that could be added to the reset subsystem instead ?

Thank you for your help !
