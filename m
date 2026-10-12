Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85C3314D2;
	Mon, 12 Oct 2026 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786298; cv=none; b=KS7j1kMRUERBxZ0o/8mJAv11EBJ3pJJz7CQ9J6sCu9PHxo0hhPtonaPLz/0TU2sGeBJRZ39iLJBcSNBj00ePsqInpP6g4KqiHpisqVY8PAEvS1GY9vEB4VSwha6/VzO8/dGsCB8GfJL5W9l6s5SUA15jTmDiujAyClW/QUwKH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786298; c=relaxed/simple;
	bh=86C1Jlo6Ff2qZEUyPo1ngsVb4CExL9RXbBlqDJ3REuE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HDL3VqPxe4qzhSBYchGEAnZ/N3ncT5LzT3YVhAiExSHh8S4XJznmrAAD93VCJDA64Dem2JMWavBPn3r4KVBQbDkXyxnyvrXLdHzLafGELMf/+3TX+Sw5S6prWnH15OzaAXxuYraQlWEo/i3Yo2zdt0jqI1bwCZXalicmYp01HkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9483B1F0089B;
	Mon, 12 Oct 2026 06:24:53 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] PCI: qcom: Disable halting feature
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
References: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 11:54:40 +0530
Message-Id: <179178628037.5255.5716306594409590306.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4884;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=86C1Jlo6Ff2qZEUyPo1ngsVb4CExL9RXbBlqDJ3REuE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzH0wPaFYf4RcbYpl74DZY30DmP3TG+h6efg2j
 L7wN6xq9EeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCasx9MAAKCRBVnxHm/pHO
 9dA6B/9OwKEHQUdxsvt8huFQ3mNfrsqT89lWFsjcfNGe1wfnIo1fwzWSsvZqERguugYsck51dsT
 xhZ84PZfg7HPvrrPer5+P/VKORWA2FodcW5p9jwBNrB6YkgPWQNTwge74jLns968fqfG1+7Z53u
 av1uQW/0SfnXtvzQNPKX3TPxnGSvmvybS6bzgGO+NUuD1QVdjWZiBpuitf09zPU87oM4hjVf05k
 qhaB7tJdbMkhIsBMYd8I1mPUasdOvvobHcJLrmliWxN1NO64n18V9Q6EMAo5rMHUjX6q5Mg/AWv
 xPb+26ZOt/pO9oKKJLC6o+0h8IprqGHmyUfcNTNtcdsvzJtU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

> The PARF write, read and BDF halt features make the controller wait
> for earlier AXI transactions to complete before issuing new ones. This
> is needed on SoCs whose NoC cannot preserve the ordering of inbound
> transactions from the controller.
> 
> On newer SoCs, the NoC preserves this ordering on its own. Halting at
> the controller adds no correctness benefit and reduces inbound DMA
> bandwidth.
> 
> Add a noc_ensures_ordering flag to struct qcom_pcie_cfg. Clear all
> three halt features on SoCs that set it. Other SoCs keep enabling
> write halt as before.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..73eb303919c1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -53,6 +53,7 @@
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x16c
>  #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>  #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
> +#define PARF_AXI_MSTR_RD_HALT_NO_WRITES		0x1a4
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>  #define PARF_Q2A_FLUSH				0x1ac
>  #define PARF_LTSSM				0x1b0
> @@ -67,6 +68,7 @@
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
>  #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
>  #define PARF_NO_SNOOP_OVERRIDE			0x3d4
> +#define PARF_AXI_MSTR_WR_NS_BDF_HALT		0x4a0
>  #define PARF_ATU_BASE_ADDR			0x634
>  #define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_DEVICE_TYPE			0x1000
> @@ -134,6 +136,9 @@
>  /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
>  #define EN					BIT(31)
>  
> +/* PARF_AXI_MSTR_RD_HALT_NO_WRITES */
> +#define RD_HALT_NO_WRITES_EN			BIT(0)
> +
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
>  #define PARF_LTSSM_STATE_MASK			GENMASK(5, 0)
> @@ -149,6 +154,9 @@
>  #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
>  #define RD_NO_SNOOP_OVERRIDE_EN			BIT(3)
>  
> +/* PARF_AXI_MSTR_WR_NS_BDF_HALT */
> +#define BDF_CHANGE_HALT_EN			BIT(0)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC				0x4
>  
> @@ -275,12 +283,16 @@ struct qcom_pcie_ops {
>    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
>    * snooping
>    * @firmware_managed: Set if the Root Complex is firmware managed
> +  * @no_l0s: Set if the Root Complex does not support L0s

Spurious change.

> +  * @noc_ensures_ordering: Set if the NoC preserves the ordering of inbound
> +  * transactions from the controller.

@disable_halt: Set to disable the HALT feature on SoCs where it is enabled by
default and the NoC preserves the ordering of inbound transactions from the
controller.

>    */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool noc_ensures_ordering;

Change to 'disable_halt'

>  };
>  
>  struct qcom_pcie_perst {
> @@ -1081,9 +1093,23 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  	pci->l1ss_support = true;
>  
> -	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> -	val |= EN;
> -	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	if (pcie->cfg->noc_ensures_ordering) {
> +		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +		val &= ~EN;
> +		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +
> +		val = readl(pcie->parf + PARF_AXI_MSTR_RD_HALT_NO_WRITES);
> +		val &= ~RD_HALT_NO_WRITES_EN;
> +		writel(val, pcie->parf + PARF_AXI_MSTR_RD_HALT_NO_WRITES);
> +
> +		val = readl(pcie->parf + PARF_AXI_MSTR_WR_NS_BDF_HALT);
> +		val &= ~BDF_CHANGE_HALT_EN;
> +		writel(val, pcie->parf + PARF_AXI_MSTR_WR_NS_BDF_HALT);
> +	} else {
> +		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +		val |= EN;
> +		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> +	}
>  
>  	return 0;
>  err_disable_clocks:
> @@ -1597,12 +1623,14 @@ static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  
>  static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  	.ops = &ops_1_9_0,
> +	.noc_ensures_ordering = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_1_34_0 = {
>  	.ops = &ops_1_9_0,
>  	.override_no_snoop = true,
>  	.no_l0s = true,
> +	.noc_ensures_ordering = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
> @@ -1624,15 +1652,18 @@ static const struct qcom_pcie_cfg cfg_2_4_0 = {
>  
>  static const struct qcom_pcie_cfg cfg_2_7_0 = {
>  	.ops = &ops_2_7_0,
> +	.noc_ensures_ordering = true,
>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_9_0 = {
>  	.ops = &ops_2_9_0,
> +	.noc_ensures_ordering = true,

ops_2_9_0 is using qcom_pcie_init_2_9_0(). So this flag has no effect.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

