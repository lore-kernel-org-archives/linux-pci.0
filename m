Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921111;
	b=vsuzuubgiKBP6dED7KZbe6TbmGKhXmbQCxOX0Be5JRRUy1kV83RAKZ6F6owlynqZy7PR
	 m/y9ILb9UTUqjFwKs8bpECtBThRcsBvZo4uCSrlk4UzET1OypOwT3qZ98yRzijcOU84Da
	 TVyA7/7mYhm+KqP0FtitgZAfPrginwjMfPvJbsn2gwBs0imU+KXiK093qM6e27uyy0O8u
	 gc1otdGjrcePrdSS3yBkzi2Vm32AOffG1lAY6lI6iKFR8Uplcioho+4gen38+Jr2Wms84
	 z8tWW59x6ZZBvkGK0QxQK4XtyP2KXca8yqjNEvshg48+2x2Qhk6Oo0/d7h6Fn7guuag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921111;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ySVWsnfCog/7pgRJNqt9P4GlYco39PXa3wYJpV9GemM=;
	b=GjaeJ47fOWvNQSbTj77bwuo5J1X0835N6VKJJkfMpo03OZI2hy94bjo0jqnDoogutL8g
	 KaKeaquwQrShhfVLzofDic0MnXH4EcX2O41Dl5WE3KLzOdrHVh6bZvX5nPx3x7jk8EUxp
	 yF625HiVA0UYt3kAvHM9zZz1iaVi6vQnuf8WedsZVWCM/1zn3xDrgBeNzUn5ylmqAxCaT
	 x2z16MT7ajefFC39HTopfw9ODfivSHWyb5M3zGK1cCwJrX9558Ea/qj/BfxE2x9QNCEGm
	 DR+70RSL7NcT4ynh4rrRGUNEC8yD3cDVQOUtRAib2wsjwmJ6uNFJ4mKBSnbLMlNxAlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58875606A323;
	Tue, 17 Nov 2026 13:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F2B1F000C4;
	Tue, 17 Nov 2026 13:11:47 +0000 (UTC)
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
Subject: Re: [PATCH] PCI: qcom: Mask PARF_INT_ALL_3 events on Nord
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
References: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 14:11:40 +0100
Message-Id: <179492110006.194330.16578214355369868159.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ek7lqrLBaWUR0k1khNecNn45o74By3r8KaJ2yN33pWs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq/FKPHAlhyKpcxHf0mQc5N7nw9VlcKRbFWwEjt
 2Uc1tvDEViJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCavxSjwAKCRBVnxHm/pHO
 9WwOB/90mexFSa7x+j5lKKA65EnTO3030tEaWe5ae7XGAGN2umVkKtRfOwqzXoCGa86AW8LGsDk
 w6E9/VFQnsLk7x7VKcuj5EFCtYeZJw+RzXRuXJpOUmkrnCHyfa6etNUyIZlH218D9dmIYHgcVMm
 ZrpPFL+Uor6HN/JaWgdqPsscCPKA7cI52VsxEjqZOHtT0/Nv2WoHFcd9+ihpGc+uiKxqxYzcju+
 Pr3PngMF7a6EdmtKAUNU2yxJlI1mMSA9A4BeC7KsRyGXLaLOwTqcR9890xd+MDU4XN+adBtP7EB
 fOlByVqKfJFyU4S5Uz6ElMxGvecEZIyYJve4LLizbjEDn+rX
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-14 16:47 +0800, Shawn Guo wrote:
> On Nord, the PARF_INT_ALL_3 interrupt group is unmasked out of reset
> (PARF_INT_ALL_3_MASK reads 0x43fff), and its events are routed to the
> same 'global' IRQ as PARF_INT_ALL. The driver neither handles nor clears
> any of them, and the global IRQ handler only looks at
> PARF_INT_ALL_STATUS.
> 
> Some endpoints send a Device Readiness Status (DRS) message after link
> up, e.g. the SK hynix HFS001TFM9X186N NVMe drive (1c5c:1069). This
> latches DRS_MSG_RECEIVED (bit 12) in PARF_INT_ALL_3_STATUS and keeps
> the level triggered global IRQ asserted. The threaded handler then runs
> in a tight loop with PARF_INT_ALL_STATUS reading 0, starving other work
> and stalling the boot (RCU/SRCU stall warnings).
> 
> Mask all PARF_INT_ALL_3 events and clear any latched status on Nord,
> before the global IRQ is requested in probe and again in
> qcom_pcie_reset_root_port(), since the register is reset together with
> PARF_INT_ALL_MASK. To keep the two writes together, move the
> PARF_INT_ALL_MASK programming in probe into the same helper, which now
> runs right before devm_request_threaded_irq() instead of after it.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Missing Fixes tag.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index eba1b2cb30f0..03b2e61fc20f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -73,6 +73,8 @@
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  #define PARF_BDF_TO_SID_CFG			0x2c00
> +#define PARF_INT_ALL_3_MASK			0x2d8c
> +#define PARF_INT_ALL_3_CLEAR			0x2d90
>  
>  /*
>   * Outbound blocker range registers. The blocked range has a write pair
> @@ -294,6 +296,8 @@ struct qcom_pcie_ops {
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
>    * @firmware_managed: Set if the Root Complex is firmware managed
> +  * @mask_int_all_3: Mask PARF_INT_ALL_3 events, which are unmasked by default
> +  * and would otherwise keep the 'global' IRQ asserted

Reword the last line to 'and are not handled by the driver'.

>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> @@ -301,6 +305,7 @@ struct qcom_pcie_cfg {
>  	bool firmware_managed;
>  	bool no_l0s;
>  	bool disable_cgc;
> +	bool mask_int_all_3;
>  };
>  
>  struct qcom_pcie_perst {
> @@ -1738,6 +1743,7 @@ static const struct qcom_pcie_cfg cfg_nord = {
>  	.override_no_snoop = true,
>  	.no_l0s = true,
>  	.disable_cgc = true,
> +	.mask_int_all_3 = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_sc8280xp = {
> @@ -1871,6 +1877,22 @@ static int qcom_pcie_set_max_opp(struct device *dev)
>  	return ret;
>  }
>  
> +static void qcom_pcie_enable_global_irq_events(struct qcom_pcie *pcie)
> +{
> +	/*
> +	 * The PARF_INT_ALL_3 events (e.g. DRS_MSG_RECEIVED) are unmasked by
> +	 * default, but not handled by the driver. Once latched, they keep the
> +	 * level triggered 'global' IRQ asserted, so mask and clear them.
> +	 */

This comment can be dropped.

> +	if (pcie->cfg->mask_int_all_3) {
> +		writel_relaxed(0, pcie->parf + PARF_INT_ALL_3_MASK);
> +		writel_relaxed(~0U, pcie->parf + PARF_INT_ALL_3_CLEAR);
> +	}
> +
> +	writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> +		       pcie->parf + PARF_INT_ALL_MASK);
> +}
> +
>  /*
>   * Qcom PCIe controllers only support one Root Port per controller instance. So
>   * this function ignores the 'pci_dev' associated with the Root Port and just
> @@ -1928,8 +1950,7 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	 * non-sticky.
>  	 */
>  	if (pcie->global_irq)
> -		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> -				pcie->parf + PARF_INT_ALL_MASK);
> +		qcom_pcie_enable_global_irq_events(pcie);
>  
>  	qcom_pcie_start_link(pci);
>  
> @@ -2429,6 +2450,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  			goto err_host_deinit;
>  		}
>  
> +		qcom_pcie_enable_global_irq_events(pcie);

You should not enable interrupts before registering handler. So you'd have to
mask and clear here and keep the enable where it was. This means, you don't need
a helper at all.

- Mani

