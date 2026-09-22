Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC5552952
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089125; cv=none; b=h8B4NSgQ7tpFQIjzqYvMPhU6nhtJbeBNo/HCws3gmZ2gR3Nol5cLADf3mkWcq3PR3MoRizdjU6K7GX+vzpch8aJS1T5RskiCk16vcAFQYI8NXcuHL5ZjK7HOqJGKcZ4iYzgFGm/nHl/EidqkwBhgft+I+eM/iv8IH+5HesZ6Phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089125; c=relaxed/simple;
	bh=PrbQY0RcGMwPGNZcFQycnUk8EQqGWXZB5cn//rm/h7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F64cAvgQjDyKFQrOOpn6Pv8rvUYXdCvGF3nA2/yzWPP7S5K2mI0QK+qtCjFvO/jYHw+iWchDHMDTZRLvzj+DVgtVE4sWVPTOQ0QZIpZAZ5qk5kkF6Ofn2Nx8bdR3fnoec1D/XRYr4y/FxcL7HU795+FEKEfqz985E6T0Xts7u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hni+7VGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hni+7VGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C61F00899;
	Tue, 22 Sep 2026 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089123;
	bh=gpn5qSOygPsY+Cz3Y+bGT9WAvpzpnxERkanAImuSiQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hni+7VGbxd7S7P8VRI9lojtPhfZzask5FyuO6UHxrQ5dDZTFy9KN6OTBj7LXwacUU
	 iHnlSeylGxjIyOlmFPykRY3vlZCW55oEVthaFB+mN3sXheKrdgZldkxTfnBe3bi+NG
	 qrWmr+/Gdkw2ewZsRVlUZaGAArk5bpCAAW22Egv5Ojzpwj7E5qEelXLyjbvefgnNyy
	 JF3GMjmeCNFlNXqxa4Xab741dnPkDUAYsaua1ECGNS7igA8dPhhAvUPB8LqylggDZv
	 Fq6kKRhNq+n/svcWci0Bg09uBoD9m5qZkFbPekBodZKBGNN+X7FtCR893TO1wq8tM6
	 BzMr8Fm0ch4/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] PCI: rzg3s-host: Move IRQ domain setup code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260922144629.586997-7-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:58:42 +0000
Message-Id: <20260922145842.DA3C61F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: UAF in rzg3s_pcie_teardown_intx() due to inverted teardown or=
der
- [Medium] pci: silent removal of PCI_EXP_LNKCTL2_TLS configuration
--

commit 3b9e569b1b1720a0862f47115eba6a10d96f3784
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Move IRQ domain setup code

Subsequent patches add support for the event IRQ to handle link
up/down events. The event IRQ handler will use
rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
support, move the IRQ domain initialization code after
rzg3s_pcie_set_max_link_speed().

> PCI: rzg3s-host: Move IRQ domain setup code

[Severity: Medium]
The commit message indicates this is a refactoring commit to move IRQ domain
setup code. Is the hardware target link speed configuration
(PCI_EXP_LNKCTL2_TLS) silently omitted from rzg3s_pcie_set_max_link_speed()
in this patch?

Omitting the hardware target link speed configuration (PCI_EXP_LNKCTL2)
could lead to link training issues or incorrect PCIe state during local
initialization or hotplug paths.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 40d5ef3e347e4..f4b27a77a89df 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1169,6 +1095,79 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>  	return ret;
>  }
> =20
> +static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int c=
ount)
> +{
> +	if (host->intx_domain)
> +		irq_domain_remove(host->intx_domain);

[Severity: High]
Does this inverted teardown order introduce a use-after-free risk?

By calling irq_domain_remove() before unchaining the interrupt handlers,
host->intx_domain is freed early. If an INTx interrupt fires in this window,
rzg3s_pcie_intx_irq_handler() will be executed and dereference the freed
host->intx_domain.

Can we safely destroy the IRQ domain after unchaining the interrupt handler=
s?

> +
> +	while (--count >=3D 0) {
> +		irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
> +						 NULL);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D6
