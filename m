Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBB376BEA;
	Mon,  6 Jul 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346932; cv=none; b=a/b9GJZjkar9WL2dkQ05rz4NBAdmuHfO6hnqNfSc/+sPidLIRVFWCi/CtOy+qqEYtC9IHwIiogYHjjLJ68vznzK2HxWeclk3GWaCJwgClN0GR6mUgyN7Gi8Qw1siWsQZKprikmFQFhHYGBsG8E0qFJ9k0vpEEkQQ1YVXDa5/UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346932; c=relaxed/simple;
	bh=wvN+pK9zp8h9EtIJG6A8aPHKkipB7mKjzZskMqY4P/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8qsBy1BIBCWunKVGevdWW5UML4A00YJd5nWrGrSSarLZwb17e8LQK+u+kDhaha8Ur9dUDNI/5HVGaatMd0OsFefxMqmh7zh/zDN8UUQsnYwnF9PdsaxkBoZ/L0J4BM5dHrnTA28KVPjHmeTFjXZQWnKK932VINDGFCVyqOhccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=DvYMblHQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="DvYMblHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783346925; x=1783951725; i=smoch@web.de;
	bh=x+dMgeYg3vp8uR4IWwPvG3GLWdqMGuZq9OQxJmfSw+g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DvYMblHQFw+lHv1R+QxKw/ze57U2IzWLgC6tFXm5AOaVXQEgLYhcS+bu4uC9CpzG
	 48v1lMIhtfv8RA1+ad25F5jnDkMM5W+PQup/HuFMV836lMiiZUKPvamNjnexGRLs/
	 AOWz4h/6+IG2a7gqSur7LHO9lu6uUyCEVP3n7FW9zvOPTNctA7S6uJy7JUyNwPXzi
	 SibBsYUk9DHsZKCnYoUuq5GiTcuCOgncYSbWi1uViX9tCTp8X+bwu0t7lnuEuH1jT
	 Zbc4E8BNj3dbAjaG7XObhdc24PicCizD2Ul4V+gjp4BQPbXefSWwgzvD0mk84+qHW
	 xQysreOS+Osx3ojDag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1xPO4f31uf-00iEUd; Mon, 06
 Jul 2026 16:08:44 +0200
Message-ID: <a42a7e16-1798-4db5-9f03-ba608a700645@web.de>
Date: Mon, 6 Jul 2026 16:08:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
To: hongxing.zhu@oss.nxp.com, frank.li@nxp.com, l.stach@pengutronix.de,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>
References: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T9p+qbyfID9HIhIhmPZHjmpdresrG+cB278lPfBe7i+UxYMPZQh
 OFuojKMqgrCFCx8HcEGYfCEj8Ctv+05igkPcM5sZyrF2xL6L+jHW/ikOX3a4OgbLhIeZkvS
 tasn77MhCLgyzKi5K9lShhCy2/6f9X70VrZXBPpMa/t3B1FcDQxDoVs0ApO8RE/EmX2Bd5O
 nvUXmvU4vbTQ+/jA7tGZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+2vMXAlor9M=;Posf8YOdz4WB8iXJFJDqsQGSOBx
 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
 mjvQvi+5j0hAZaagjDJXIjmFndqZGR9mYrOa5gZ



On 06.07.26 05:06, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulator=
s")
> introduced a boot hang on i.MX6Q/DL variants by changing the initializat=
ion
> sequence.
>
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
>
> Fix this by separating the two concerns:
>
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>    logically belongs with reset operations. This ensures PHY power state
>    is managed as part of the core reset sequence.
>
> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>    shared PHY power management, avoiding code duplication.
>
> - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
>    (REF_CLK_EN) control, simplifying its purpose.
>
> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>    proper sequencing is now handled by the core_reset functions.
>
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
>
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulator=
s")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
With this patch on top of v7.2-rc2 I see everything booting, lspci shows
the root complex, but no PCIe device behind it.
Tested on a i.MX6Q based tbs2910 board.

For me it is not clear whether this fail to detect PCIe devices is related
to the patches in question, the reset timing, or something else. Needs
further investigation.

Regards,
Soeren
> ---
>   drivers/pci/controller/dwc/pci-imx6.c | 43 +++++++++++----------------
>   1 file changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/control=
ler/dwc/pci-imx6.c
> index ea0b4eb03c1d0..6924a06bde305 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -680,21 +680,12 @@ static int imx_pcie_attach_pd(struct device *dev)
>  =20
>   static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool e=
nable)
>   {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_=
TEST_PD);
> -		/*
> -		 * The async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * Add a ~10us delay here.
> -		 */
> -		usleep_range(10, 100);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_RE=
F_CLK_EN);
> -	} else {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_=
REF_CLK_EN);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TE=
ST_PD);
> -	}
> +	if (enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
>  =20
>   	return 0;
>   }
> @@ -823,23 +814,25 @@ static int imx6sx_pcie_core_reset(struct imx_pcie =
*imx_pcie, bool assert)
>   	return 0;
>   }
>  =20
> -static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool asser=
t)
> +static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert=
)
>   {
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_=
SW_RST,
> -			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> -	if (!assert)
> -		usleep_range(200, 500);
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
>  =20
>   	return 0;
>   }
>  =20
> -static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert=
)
> +static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool asser=
t)
>   {
> +	imx6q_pcie_core_reset(imx_pcie, assert);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_=
SW_RST,
> +			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
>   	if (!assert)
> -		return 0;
> -
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TES=
T_PD);
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF=
_CLK_EN);
> +		usleep_range(200, 500);
>  =20
>   	return 0;
>   }

