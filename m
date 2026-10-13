Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142145349AA;
	Tue, 13 Oct 2026 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917353; cv=none; b=QhvuiX+JMxM0l9Egu0orz8h3deB8YiqjdliPPnbEVg5dPcXCwcM8/9uaedL32MIwZGuwADy4cZx/pAY9elJaykia8rouSGyaXBYKixq5HCVUMArANcFo8JY491K+8rS/4jjh0Nccg3t/lNlex9d5PPb3KLruj1+okepEVG7vSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917353; c=relaxed/simple;
	bh=h9eSoJBPlSKMV9GPuwPqWD3tM0tkXMEuYQdYPg0IKaY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=c2OuxYtw4E+whK2Y8w/IjMGaFKa+Hr5vwtLunq5SHiLFX0+w6xyOKe9jaUvAd0ghZFiiP6myM897yJ4XfC3u29OIZVvrKTNNntPbf0EbwUykvfCcrvy1VKLACBaRCqAwSkIZtza8Ih77g72ERab+KD1afhBOq+rSBd8AVHjEylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTXsVBY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTXsVBY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F941F00893;
	Tue, 13 Oct 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791917351;
	bh=W2LK46YutHa3oM+xUu+YyUYDdDuDRMk9fL5ystfIlDc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bTXsVBY8L2hiFt/lX44+36LdKu0+Af4DYvhIMIKcG4bRcIFERWTzv95PbLNRlgePL
	 CqQSp7GoNYsrXskXGpJa0nok+ue8SA5l07BFlCWazWWlUnyBx4yAmRzlIx9MGMJKkn
	 fpp22GvOUe7mY4Ss8xQJCOrTSup9aOuu5q5czHHsHvOHpWrm1GzMAUCdVm25U7ut0D
	 WarcoPvGRQKEaG5SOaJ1GvxI0DmcCmSPCx2FvMyOLKpSO+c+gkgjOfAohkS3kmpHQj
	 8BIAt9GygOF5yIE7qeEmkD5eA9+oeZHfj405BYiivT7QGj1AOusFjBMY1fvEifTPlG
	 DsPCL8vAvFVZA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
Date: Wed, 14 Oct 2026 00:18:57 +0530
Message-Id: <179191733707.12828.15231988052096272779.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4265; i=mani@kernel.org;
 h=from:subject:message-id; bh=h9eSoJBPlSKMV9GPuwPqWD3tM0tkXMEuYQdYPg0IKaY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzn0bKa2b1ZElqC1ZZLD0461BQLLkljsz8CTkv
 mcVRYwIEpSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas59GwAKCRBVnxHm/pHO
 9dt6CACUWonlZ9vT5z/JAsPPzaPJghCoWcwQa7irZNahQtFDrKmc0JEEdS07p1dv7/ejiVjUpD3
 kRkYuK6CxWG2qiYXAsaFaDdu5Js9gY50kh8ZTpmdX7TQXFIE8i7nfl+Kv4a8Zqbk1beOslV+GVQ
 fy7rXip0H714OQ3xOCAJ2C9IePkaUhFCNh/Y3a8QidRolkBH6JP8hwMqPqrElbM3lfcPB9eO+e2
 2+Ki92mSmO57qbIDdAu4900AmzW9BajB/IBwEmOVr6LGYKIfgj39ENpnrhVcI8Xa9cZ+LpeI48I
 XMQns/3TPwHHefh9IO+CLQeKuSD7TQ+1Dc6T6vW+LYK3RLzE
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 16:51 +0200, Sebastian Reichel wrote:
> Add system PM support for Rockchip PCIe Designware Controllers.
> 
> I've tested this on the Rockchip RK3576 EVB1, the Radxa ROCK 4D
> and the ArmSom Sige5 boards.
> 
> While I haven't experienced any issues, most of my tests have been done
> without any devices attached (i.e. default board without any extras), so
> there _might_ still be some problems. As system suspend does not work at
> all right now, I think it makes sense to get at least the basic
> configurations working as soon as possible as it will allow us to catch
> regressions by enabling system suspend in CI systems like KernelCI.
> 
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 100 ++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 47d9cab909bc..e675918ba184 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -120,6 +120,7 @@ struct rockchip_pcie {
>  	struct gpio_desc *rst_gpio;
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
> +	u32 intx;
>  	const struct rockchip_pcie_of_data *data;
>  	bool supports_clkreq;
>  	struct delayed_work trace_work;
> @@ -1042,6 +1043,99 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>  	return ret;
>  }
>  
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "suspend is not supported in EP mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	ret = dw_pcie_suspend_noirq(pci);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "resume is not supported in EP mode\n");
> +		return -EOPNOTSUPP;
> +	}

This is going to regress the EP system suspend. If the EP suspend used to work
before this patch, then you can safely return 0 here.

> +
> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_disable_clk;
> +	}
> +
> +	ret = rockchip_pcie_phy_init(rockchip);
> +	if (ret) {
> +		dev_err(dev, "phy init failed: %d\n", ret);
> +		goto err_disable_regulator;
> +	}
> +
> +	reset_control_deassert(rockchip->rst);
> +
> +	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->intx),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +	ret = dw_pcie_resume_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "failed to resume: %d\n", ret);
> +		/*
> +		 * During resume, dw_pcie_wait_for_link() is called and when
> +		 * there is no device connected at all it returns -EIO with
> +		 * the message "Device found, but not active". Ignore it for
> +		 * now.
> +		 */

This is not correct. When there is no device connected, -ENODEV will be
returned.

- Mani

