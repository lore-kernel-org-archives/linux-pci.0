Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069403;
	b=gX+LCaAY7uOiaVCcV+b+yzw/2WbxCUq1cuAM5h8n0lRrEDv6q3s0pdtZ88V5ZmAnJrIm
	 7joG6kWNrHTSx3ZijM/dCWCTtVjGtGvzWAZj0QgBzpPak3+aGBAdSU48G0Z4TBVteEpI+
	 m9yMdpD8N3qcvHblHoO2mrDSx0StrOoR87Yd4n+twpwyGxfjZUdyV/XOUiTfn6UuZUeLx
	 V+wueUFwEtfYjjFbd3jZp0VeO9PCoA1BNydzDpvkL+f0TJpUh4ZBqxMRi6Zd6GRfEmP65
	 atGU03kFYibJ//0Eke41Pm3nyRnOq6V8utgeczr6YYcTPPsGCgwbb6zsIU3OwNYrkbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069403;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=oM5eh/s+Pspuu1PUdwzvcQsHh+H6EmixK49kWJ77C90=;
	b=5noJPO6VUz506q1moH+0bm+kWNDlEXFecOVjvra5ILWdM/KIRjhX8+hNEwiDz9dGzQD0
	 +PFl4BXeMpLTWv8YkaVnz8KSfy/jyD1DaIOCOaCFHAWTNCsQkHjDwWT5s62/PkdvcNHCh
	 M1rwbSYGiykHaKsYxlhU5edScoxCdu68Mgf/pevnKl38B96Uqo06NaKew/wqVe9QYf6oC
	 4QQD3t2UFJb6TV7RZ5HZvx5MvVNKXQ2TIuJVZjd+k4JXxcNgQTCyljGzRfEVnFXU9W9W1
	 1BRiUskHA8kIqSV9qEYG3N7uc9iTj75J3xDifo91Z8+2ESnFLAB2Qqqin+a3GskUTMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F264606A339;
	Sat,  7 Nov 2026 16:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23661F008A2;
	Sat,  7 Nov 2026 16:36:41 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 9/9] PCI: dw-rockchip: Add system PM support
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
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
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-9-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v9-9-a2e55846649e@collabora.com>
Date: Sat, 07 Nov 2026 22:06:40 +0530
Message-Id: <179406940043.65886.12399286680610211664.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=8365VW6X0RcfnFpRVJgWusqFqAVt4w96wEE77tPrWjE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq71OZbVmkYD9JMJROI0BZDcoNwWxrcAtLcQwbj
 0t0/rTYQ2GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCau9TmQAKCRBVnxHm/pHO
 9bzuB/9qHp6yNX81ggnW8qnKGqz2yTTtqcKvB0xahmmLZBSKgA5YOzM1wRR1HdjHlfU3ijEyr1P
 U9rY0H5/Zh44dXLHoRPwFTBIU14FHK5reN6PV5U9wfXkMbmZ9QqBerln+1dw9JYUoMEaZG0xtqm
 4zeUJc5pY+dYx23nV9udXC1gLaPvJq1cAlNba0qIK7Hmh0K4zFvmDSDY73MUzlDfYQ2zE3wQJSp
 GuXDhmfyl/29yvSzvywp3smDG/YUyF729MzW3EI7GQrwe9MqJWSvkkT1N4oRlL5iWpikg+8QYpQ
 WYfMP+sCtFR/EG+8bj7/Bg4h7cNMeIu1Amku3NJyW6Dn9EPA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-05 14:33 +0100, Sebastian Reichel wrote:
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
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 102 ++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index a603475d4450..39faefaf568d 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -124,6 +124,7 @@ struct rockchip_pcie {
>  	struct gpio_desc *rst_gpio;
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
> +	u32 intx;
>  	const struct rockchip_pcie_of_data *data;
>  	bool supports_clkreq;
>  	struct delayed_work trace_work;
> @@ -807,6 +808,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
> +	pp->suspend_poweroff = true;
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> @@ -1030,6 +1032,100 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>  	return ret;
>  }
>  
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode == DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	if (pci->suspended)
> +		return 0;

This check looks wrong. 'suspended' flag is only set at the end of
dw_pcie_suspend_noirq() and is used as an indication to glue suspend callbacks
to turn off the resources or not. here is no way this can be set at the start
of tne glue suspend callback.

I'll drop this check while applying.

- Mani


