Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523629AB02
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157207; cv=none; b=bkCxwalEXx64J+lw1Yb7FTrUQJNX1nXb9w5iyjY/MtZn7r0L3tBlSbsc2n9LtBYJCwPftKhWzBY/ypHNywc+1utSzq2StoOUkZP4Y4k62ymVj0NdSVjx7psbh8PjPJZyGptqsmBF6k5t6YIcQUNztwIO9RG5N3veeEzJeoF5FtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157207; c=relaxed/simple;
	bh=nktT2CDtkvBBujNkJsimUqUA3r1MaQTYIBlKnFXwY1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSgYsdleNXKCvxg43HwJL6PIQbyAMhon/ppuQaDCTQHsab0qFMkO/ONstBa4vZIca0nvEodLl5RdRP2JvxJNqmTezq39Jcl08TfjtyyC3De/cq939dLHrlQ8r7tlJBfJbKW5F15h+oyGbKwCM6NZ4QuLLAsCzLwqUDpBSdqrp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6mgAOuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6mgAOuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19DD1F00893;
	Sat, 30 May 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157206;
	bh=5AmDjlDPhLjrXS9Miqnl7vD6bh4hYcPdJ4AAp2wL4uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6mgAOuYosGOhwxdUw+/K8FSA644PknPVod2eGya+Q6Zw+NGR9Xg7CmyaBpcOGLj2
	 geAoTdbnQkXere+9quhf0ZS1glGAsYpkPqeUBfx4jz9Nb4xi2oRSA1okcq0b3l1WtD
	 aQJAdktlBz6bn9Qn1HlX2NlqYzzggSLbFLXlf+l6eQRWzh8/AImCritLMf1RK1IxZw
	 V+PHbZfvI/F6JEcwDsh82M/mxWLTKsVbBSTgUoIQuu+XLYb4o1WQ916ra4OozU38Sf
	 q2Sp+V+Q0+AgdpGU21fIi8oUvdORPMv3Fy8hZs3+qx0MeuMuR/2ZXZqwKzroSJotox
	 /+UiVPNPIQkWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/16] PCI: dwc: tegra194: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-16-18255117159@163.com>
References: <20260530153101.695580-16-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:06:45 +0000
Message-Id: <20260530160645.D19DD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `dw_pcie_get_pcie_cap()` during `dw_pcie_ep_init()` causes=
 a synchronous external abort in Tegra194 Endpoint mode because the hardwar=
e is unclocked.
--

commit 240e0a20036fb631179ee7e94b3f17f4d5523ad8
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: tegra194: Use cached PCIe capability offset

This patch updates the Tegra194 PCIe host and endpoint initialization paths=
 to
use dw_pcie_get_pcie_cap() to retrieve and cache the capability offset. The
commit message explains that this is safe because the driver has already
enabled the hardware before these functions are called.

> In endpoint mode: pex_ep_event_pex_rst_deassert() runs before
> dw_pcie_ep_init(), but the driver has already enabled hardware.
> dw_pcie_get_pcie_cap() will perform the DBI read and cache the offset.

[Severity: High]
Is this sequence accurate for the endpoint mode?

Looking at tegra_pcie_config_ep() in pcie-tegra194.c, dw_pcie_ep_init() is
invoked synchronously during device probe:

tegra_pcie_config_ep()
    dw_pcie_ep_init()

This happens before the endpoint hardware clocks and power domains are
enabled, because clock enablement is deferred until the PERST# interrupt
triggers pex_ep_event_pex_rst_deassert().

Since a prior commit in this series modified dw_pcie_ep_init() in
pcie-designware-ep.c to unconditionally cache the PCIe capability offset by
calling dw_pcie_get_pcie_cap(), this triggers an early DBI read.

Will this MMIO read on the unclocked PCIe controller trigger a synchronous
external abort on Tegra platforms and cause a kernel panic during boot?

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 795cef5a915dc..bf482bc66a929 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
[ ... ]
> @@ -1889,8 +1888,7 @@ static void pex_ep_event_pex_rst_deassert(struct te=
gra_pcie_dw *pcie)
>  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>  	}
> =20
> -	pcie->pcie_cap_base =3D dw_pcie_find_capability(&pcie->pci,
> -						      PCI_CAP_ID_EXP);
> +	pcie->pcie_cap_base =3D dw_pcie_get_pcie_cap(pci);
> =20
>  	/* Clear Slot Clock Configuration bit if SRNS configuration */
>  	if (pcie->enable_srns) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D15
