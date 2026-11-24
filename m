Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795514714;
	b=QGm6gu5gtL0XRaGgsK3btEMGCG6Ns7BLWkCy7xXfdMPHm9bawGdZJ5qSL8h5mbmsFn4h
	 Eag4yRIskLP3wD/bF0irMhly8+TF7spDfycYKloWXgRch577zopSW2aoW71drLAxR5Hgf
	 Fd0bRnV+1orH0RUlo8k56R/ZsvNEZIxnM63McgOnYrZoqKr5Drhk3VBRPEWnq8JNvuppt
	 Ev2D65LHQj0Ku4Tij/6WsteCFMosYK4LvL/5y8DxUy0+mMKPg6O+GJ/sBees2BRgVQTYD
	 77ymjyZ46y4WaZ0Pmbb4mhdG2qKsnqcqGtbOFIgzvKHtMAcsF4XGBqstLRhD8T/8uhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514714;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=H8p63jVzqspLS/yYDkgn0Or4vozMPrWlrtlpK8EIjBA=;
	b=4iP2b9XJdgeQa6lWxduU/j2DOVP/utPt7+lYgEHaBYcp+y+xV4FYOw1mz9UlBikKA9NB
	 fGY0ck5aMZRXEZ2kRSmsPX5MJfNajklureZVQ4e7onga08/tGv4/vwJsZKITH6/ryNQ21
	 EVr4pAOaQZ62oepK10vGoyN57guUXEfsBPrfy2oxZRlJgd09W7A7/iijsafwKll4xIoxu
	 7YgaRrhzGZWDJ+ulKBQqBsC7A4ABW6QtP+sOzKbzE4JjIj4pPJyCYLSPX80FWQ0denXon
	 SvLvdUphFTAdZZET5JBLpnAuNMrPSdJH+RaO4DN3ak3UbWuGb3xtdCuDVDm/NO+Cntw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SgIqTliG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33585606A339;
	Tue, 24 Nov 2026 10:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33585606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SgIqTliG
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B49642020DC;
	Tue, 24 Nov 2026 11:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795514710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8p63jVzqspLS/yYDkgn0Or4vozMPrWlrtlpK8EIjBA=;
	b=SgIqTliGQ/EujMYD5rdTmMNePrv7K80ns5GjscE8pXQb5WmWt2WxIV5auO9EwDNnBk/jfN
	IFFc9LY9/DEHEaABfr8yTqtBU+SRKxY+vD3TZ/s046CcKIvtciUk27SZJ1guyaV1b/ohIN
	6emn8hoU+LX3hi6wSN5AJZI47MowPRXoWA/JTjLYKuMwn4t5n7S+KEpTar5Mf0NLa2hALq
	FY/r3FftvfIEVFIYQDrwSd4uoEfPXo6qAvlVgC967pdmDqc3UeKogpV/mZKGHS7rc+izAy
	y+hcoC9iiLhVBBSHSStkOLtbB6NGXvqSyQ6y3DxvLXuPzEhOXNgurOGHx9XrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795514710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8p63jVzqspLS/yYDkgn0Or4vozMPrWlrtlpK8EIjBA=;
	b=NNCIxjoisA3DfJ9YhHLwZXERhJ+CbYJvR+LxwY5j4hf1serGJihnU/85QxYu8QpEne4GzG
	B26aocmUzhxl+CvYx267940TLNbMTKITo4rYBF9Z8mS8vOLDdP+PRfOjIYlLBnafsOfKhU
	XJwlGMCE1ExIalEDjt5KAF5sCuotjTJXu7Lcyalsn2ylZyi1heyApDpEAMkT6LRdMVxiMN
	66qoqK/ErlsIciMABD9EAMUYqFo3Rb4ZsImjFz+4/fdj7yecRTqHgcZ/BVLx10RF9z9sjd
	F6l0Da1ERUCp3MPhf4fxAbryUzCmeG1VfSpu9/yhtPZFZAOlEOPmvgdetAzLwg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795514710; a=rsa-sha256;
	cv=none;
	b=S0JYSQRGdMO84u/k49CDmLAsD9YPXdZ/QiwFcLxS9EWH7/srhpQTYZNuygCEZjKSiZJjpy
	VZEz47+rHNMQL7iQYimPElyMzb3kP6AOYSaWpoROOc8OSek0LXb4+oqxqc6FeDPL+Twh1X
	1pKY0BzvnuJ67cpgJEOUeZQhHxyVU0cxcWGk7usxnj6zVWTccCs0d/F79czRIALCMtlfwE
	6HCiBCu73M8viEUe+won2xPJjK078UxF7SsMtOMP4Rl5lbrmZw+T+YW4IzGp5kUrjgUBma
	/WZ6Tpp1cfgROGhrZe60KCqhowvOIdxDp8ejleYjub0ImuXWdUs0r0N8q5LSPw==
Message-ID: <f5d30781ae9502cd76ee2b6757f96a0e5ffa8b71.camel@pengutronix.de>
Subject: Re: [PATCH v2 7/8] PCI: cs7542: Add CS7542 PCIe host support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: filipp.dunsky@gmail.com, Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Brian
 Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Neil Armstrong	 <neil.armstrong@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Nov 2026 11:05:10 +0100
In-Reply-To: <20261123-b4-cs7542-pcie-v2-7-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
	 <20261123-b4-cs7542-pcie-v2-7-f589a9cd0bef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mo, 2026-11-23 at 23:32 +0300, Fil Dunsky via B4 Relay wrote:
> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add DesignWare host glue consuming separate clock, reset and PHY
> providers. Use live link status and stop previous training before
> enumeration. Finish endpoint teardown before draining the shared IRQ and
> freeing MSI domains. Dispatch enabled INTx/MSI sources through one
> application interrupt and use its MSI target window.
>=20
> Prevent root configuration accesses at and above 0x200, including direct
> DesignWare DBI reads, while preserving the private CSR bank and separate
> iATU callback base. Unwind power and IRQ domains on failure and removal.
>=20
> Read live link/LTSSM state through the application wrapper. After link
> loss, block configuration and DBI accesses until controller reset and
> reprobe.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig       |  12 +
>  drivers/pci/controller/dwc/Makefile      |   2 +
>  drivers/pci/controller/dwc/pcie-cs7542.c | 551 +++++++++++++++++++++++++=
++++++
>  3 files changed, 565 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0a0d56fcf..2ebaa8db1 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -577,4 +577,16 @@ config PCIE_ULTRARISC
>  	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
>  	  requiring no further configuration on that platform.
> =20
> +config PCIE_CS7542
> +	tristate "Cortina Systems CS7542 PCIe controller"
> +	depends on OF && HAS_IOMEM && PCI_MSI && COMMON_CLK
> +	select PCIE_DW_HOST
> +	select GENERIC_PHY
> +	select RESET_CONTROLLER

Drop RESET_CONTROLLER, this is not a reset controller driver.
The consumer API has stubs.

[...]
> diff --git a/drivers/pci/controller/dwc/pcie-cs7542.c b/drivers/pci/contr=
oller/dwc/pcie-cs7542.c
> new file mode 100644
> index 000000000..5487e667d
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-cs7542.c
> @@ -0,0 +1,551 @@
[...]
> +static int cortina_pcie_probe(struct platform_device *pdev)
> +{
[...]
> +	cp->reset =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(cp->reset))
> +		return dev_err_probe(dev, PTR_ERR(cp->reset), "controller reset\n");
[...]
> +	ret =3D reset_control_reset(cp->reset);

Please use assert/deassert, this is not a self-clearing reset.
See my comments on the reset controller driver.

Would a convenience function like [1] be helpful?

[1] https://lore.kernel.org/all/20261112-reset-control-pulse-v1-1-25cea1058=
83e@pengutronix.de/


regards
Philipp
