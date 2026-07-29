Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960CC42C4F5;
	Wed, 29 Jul 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344482; cv=none; b=LXqQ8wV5hxAEpaAH0oeP+F0OWA/bpVYmVeWTgaDenEBaUamqCxy1Vz4WIpHgSdeKZTZhascXjVtzoJMvMnjT6b9CCj9F663TcdfxwvtWbflkol/JsCwiIaNzY993NiWFyRe/wwwrksQHWmQwj00T8PCOMBcr9UdNUEFFpoSHOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344482; c=relaxed/simple;
	bh=jkVy1fXASbJ3IbWGxSb4dJJpDFD5a7KWdX78Lz/ZGeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsOJK1evjBYp81S3sF9hNq7iPx9Bf0q9gGV5ETnIoM1kH4SvJ57Bw9v0u0VxTfHfPF+juuJKZwK5dJOLvs4OQemncgH7xEoYyyjB8nDjS/GDJ+Lv3F9Mb+gpUBrKW8IUOVyDhBE5PyCh7MBwTSE/+34XQjut4ue9dnDZIdCPFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv+igihF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv+igihF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C301F000E9;
	Wed, 29 Jul 2026 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344479;
	bh=0qn9MseQaABDq0jzuTJTTFvGuBz93H8dXrHhwqUAhtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nv+igihFdvPZ39GrgKyFl313gXd3lhyix7DoUQnwNp2U9jPHWkV/0q5vBdIO5EE++
	 8DyO7e3+EI9srapuB6lyiLLIvqgGtr+9tPCzWgN3QigGpQxsssVKIhYkTK1lHAQYoh
	 EY9VOO1yRWp2Em1UAlrpjVSLas4CWmx4f7SdSG+3Dk67Op3DABx5/4TwH7fRkag1fg
	 B1E0dOKNHtGHiKkkjjabdmtDqVfvl557P8pEpBpepyMFJCwNq3e6J5sx9jSW3fu3+0
	 OqgZCXbEV+i8z+ft6CTnvEJn7JFU/1zT5W9hXrfgjRDvkjGB9Wen4S/1PQcOnHkYnW
	 9Xw55k0exIdHw==
Date: Wed, 29 Jul 2026 19:01:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Michal Gorlas <michal.gorlas@9elements.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: enable ASPM L1 only iff CLKREQ# is supported
Message-ID: <t2zu6bv4dqf5znpn5uypkoieltlrzlp4kskt6jwp46xgqajhjp@6g5kiwwn72a4>
References: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com>

On Sun, Jul 19, 2026 at 02:47:54AM +0200, Michal Gorlas wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms"), ASPM states are force enabled
> on all devicetree platforms. This causes PCI devices on some iMX SoCs
> (for e.g. iMX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> though CLKREQ# is not supported (and consequently supports-clkreq is
> not set in pcie controller node of their DT), which causes the device to
> never wake up from L1.
> 
> Hence, disable L1 capability in the LINKCAP register if supports-clkreq
> is not set in the DT explicitly.
> 
> Note, the logic here is very similar to 613f3255a35a, only difference
> is that leaving L0s enabled does not cause issues (at least
> I never encountered them myself when testing on the device) as its
> not dependent on CLKREQ# being physically there.
> Since there is already a way of specifying its presence in the DT,
> the driver should be aware and disable L1.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 98e1db751132..7471501fbf04 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1318,6 +1318,22 @@ static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
>  	}
>  }
>  
> +static void imx_pcie_disable_l1(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	u8 offset;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPM_L1;
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1442,6 +1458,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	imx_setup_phy_mpll(imx_pcie);
>  
> +	if (!imx_pcie->supports_clkreq)
> +		imx_pcie_disable_l1(pci);

Sashiko raised a valid issue here:
https://patchwork.kernel.org/project/linux-pci/patch/20260719-l1-conditional-imx-v1-1-a55a57915c68@9elements.com/#27076171

IMX_PCIE_FLAG_BROKEN_SUSPEND is only set for i.MX6Q, but none of its DTs have
'supports-clkreq' property. So this patch will impact them also and since they
do not reinitialize the hardware fully in resume(), ASPM settings will reset to
hardware default.

It'd be good if NXP folks could share their thoughts on this!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
