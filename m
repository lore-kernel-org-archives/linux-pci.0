Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B011D54FA;
	Tue,  8 Sep 2026 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908434; cv=none; b=MBkJEEQtVV5kdpVoYJsQbQGBigpllmif5jvbfSwrTWIIInbwhc3VtHMfdow7fBKlB1jTBOb250NgaN5f2CdpF7vt99eU76CE1ZHmydX/VWlug7NtjdGsM3Emjx+zjNUUHSkrwcgl0aSAwq5z6DRhebKzSc0ptpnDetaU1uhDEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908434; c=relaxed/simple;
	bh=TTF3V9Z1AgnN3JxQqmFlYlk3Mx8eUd4vBmt/eYSjctI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dId9zYU/odBHshg3SNQGxXVFuNPDMzMc8gPFFo9hBlFyb4FemYqfMstY0qacvXd9ywiQN4iJIG7hNuGxE6xSfvCWUksqohHXhFw1Ewx591BnmqjgcoHdYFks2HKV0G6QHQelljj1wf/c5mp3dci/aDF5GfJ6+z2/7Xb5gJLZRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsvAUmLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsvAUmLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D631F00A3A;
	Tue,  8 Sep 2026 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908432;
	bh=SnBXt0B/xE6geNfLDgs5YFnvg9eiWpiU+ISsWmoZ8o8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZsvAUmLgEkdTRPaF4nKBgb6MXOIIbYbZOkbP24BIYcHXBn3K3SKRYcEA6FQbSgdtT
	 sXcuBZ5DwyZZXSEiZwRS84Qxq9ICJ2WjnizaJZf8DuVxjjFyXQDup/bKp/u2ZwXswO
	 jdzfFaSFykZ3V7vj6rPh1WN/zwJ8JoT1sFMHtO5kRbJhHCqpntMmxUZQ/8m7Wds8tM
	 plJEqJbAUqeSYB13gzzKadesg3+ro3od/BqxP5bz3GXckpWO2f9n/2I3PIdJqOHihC
	 fLscdYoz1NNuYwAgtrbBoFCgtf0dOIF47TC2dvIye3I3wwBQwNUZCq3xtNzheXPOOC
	 0fSoJ7yCA9OwQ==
Date: Tue, 8 Sep 2026 18:00:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <20260908230030.GA2776580@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>

On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> After a PCIe link goes down, software may still access the BAR (MMIO)
> space or configuration space of devices behind that link before recovery
> has run. As the link is down, these accesses never complete, resulting in
> a storm of Completion Timeout AERs.

What is special about qcom here?  It seems like the Completion
Timeouts and AER interrupts should happen with every PCIe controller.

Is this mitigating an issue that will still happen on other
controllers and should be solved elsewhere, e.g., by changing the
software that accesses the BAR to look for the error responses it gets
when the Completion Timeout happens?

The patch refers to the ECAM blocker (which I assume affects config
accesses) and doesn't mention MMIO.  Is the SLV_AXI stuff for MMIO?

Assume the root port leads to a switch, and the switch has two links
to downstream devices.  If one of the switch downstream links goes
down, is this going to kill the device on the other link that is still
up?

> Use the controller's ECAM blocker to drop these accesses to the PCIe
> address space as soon as the link-down interrupt fires, so that Completion
> Timeout AERs are reduced. The blocked range covers the entire address
> space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
> register space remains accessible regardless.
> 
> The range is programmed once in the host init path, since the range
> registers are wiped by BCR reset. This leaves only the ECAM_BLOCKER_EN
> bit to be flipped from the link-down IRQ handler, so the blocker can be
> armed with a single fast register write for immediate effect.
> 
> The subsequent Root Port reset re-initialises the controller, which clears
> the enable bit and re-programs the range for the fresh link.
> 
> Some IP revisions implement the ECAM blocker registers but do not wire
> up the "global" interrupt used to deliver the link-down event that arms
> the blocker, so there is no way to enable the blocker on those platforms.
> Restrict blocker initialization to the post_init hooks of the IP
> revisions that do have a global IRQ wired up
> (qcom_pcie_post_init_2_3_3(), qcom_pcie_post_init_2_7_0() and
> qcom_pcie_post_init_2_9_0()), instead of unconditionally programming it
> from the common host_init path.
> 
> The link-down IRQ thread's blocker-enable write to PARF_SYS_CTRL can race
> with a Root Port reset triggered independently through AER, which
> reprograms PARF_SYS_CTRL as part of reinitializing the controller.
> Serialize these with a per-controller mutex.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
> Changes in v2:
> - Only initialize the ECAM blocker on IP revisions that have the "global" IRQ wired up.
> - Add a per-controller mutex to serialize the link-down IRQ thread's PARF_SYS_CTRL write against a concurrent Root Port reset from AER recovery.
> - Link to v1: https://patch.msgid.link/20260810-ecam_blocker-v1-1-e588e07f68d4@oss.qualcomm.com
> 
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kwilczynski@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 83 +++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..e8cf349579a8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/init.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
> @@ -73,6 +74,23 @@
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  #define PARF_BDF_TO_SID_CFG			0x2c00
>  
> +/*
> + * ECAM blocker range registers. The blocked range has a write pair
> + * (WR_BASE/WR_LIMIT) and a read pair (RD_BASE/RD_LIMIT); each address is
> + * split into a low (32-bit) and a HI (upper 32-bit) register.
> + */
> +#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
> +#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
> +#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
> +#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
> +#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
> +#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
> +
> +#define PARF_ECAM_BASE				0x380
> +#define PARF_ECAM_BASE_HI			0x384
> +
>  /* ELBI registers */
>  #define ELBI_SYS_CTRL				0x04
>  #define ELBI_SYS_STTS				0x08
> @@ -90,6 +108,7 @@
>  
>  /* PARF_SYS_CTRL register fields */
>  #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
> +#define ECAM_BLOCKER_EN				BIT(26)
>  #define MST_WAKEUP_EN				BIT(13)
>  #define SLV_WAKEUP_EN				BIT(12)
>  #define MSTR_ACLK_CGC_DIS			BIT(10)
> @@ -308,6 +327,7 @@ struct qcom_pcie {
>  	struct gpio_desc *reset;
>  	int global_irq;
>  	bool use_pm_opp;
> +	struct mutex hw_lock;
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -445,6 +465,25 @@ static void qcom_pcie_configure_dbi_atu_base(struct qcom_pcie *pcie)
>  	}
>  }
>  
> +static void qcom_pcie_init_ecam_blocker(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	/* ECAM base must match the DBI base address */
> +	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
> +	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
> +
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
> +
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
> +	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
> +	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
> +}
> +
>  static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -990,6 +1029,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +	qcom_pcie_init_ecam_blocker(pcie);
> +
>  	return 0;
>  }
>  
> @@ -1104,6 +1145,8 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  
>  	qcom_pcie_set_slot_cap(pcie->pci);
>  
> +	qcom_pcie_init_ecam_blocker(pcie);
> +
>  	return 0;
>  }
>  
> @@ -1322,6 +1365,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  	for (i = 0; i < 256; i++)
>  		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
>  
> +	qcom_pcie_init_ecam_blocker(pcie);
> +
>  	return 0;
>  }
>  
> @@ -1382,6 +1427,18 @@ static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
>  		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
>  }
>  
> +static void qcom_pcie_enable_ecam_blocker(struct qcom_pcie *pcie)
> +{
> +	u32 sys_ctrl;
> +
> +	sys_ctrl = readl(pcie->parf + PARF_SYS_CTRL);
> +	sys_ctrl |= ECAM_BLOCKER_EN;
> +	writel(sys_ctrl, pcie->parf + PARF_SYS_CTRL);
> +
> +	/* Flush the write so the blocker is enabled before this function returns */
> +	readl(pcie->parf + PARF_SYS_CTRL);
> +}
> +
>  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1775,13 +1832,15 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	u32 val;
>  	int ret;
>  
> +	mutex_lock(&pcie->hw_lock);
> +
>  	/* Wait for the pending transactions to be completed */
>  	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
>  					 val & FLUSH_COMPLETED, 10,
>  					 FLUSH_TIMEOUT_US);
>  	if (ret) {
>  		dev_err(dev, "Flush completion failed: %d\n", ret);
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	/* Clear the FLUSH_MODE to allow the core to be reset */
> @@ -1795,7 +1854,7 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  					 FLUSH_TIMEOUT_US);
>  	if (ret) {
>  		dev_err(dev, "Flush mode clear failed: %d\n", ret);
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	qcom_pcie_host_deinit(pp);
> @@ -1803,12 +1862,12 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	ret = qcom_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(dev, "Host init failed\n");
> -		return ret;
> +		goto out_unlock;
>  	}
>  
>  	ret = dw_pcie_setup_rc(pp);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	/*
>  	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> @@ -1822,11 +1881,14 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  
>  	ret = dw_pcie_wait_for_link(pci);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	dev_dbg(dev, "Root Port reset completed\n");
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&pcie->hw_lock);
> +
> +	return ret;
>  }
>  
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> @@ -1878,6 +1940,11 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  
>  	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
>  		dev_dbg(dev, "Received Link down event\n");
> +
> +		mutex_lock(&pcie->hw_lock);
> +		qcom_pcie_enable_ecam_blocker(pcie);
> +		mutex_unlock(&pcie->hw_lock);
> +
>  		for_each_pci_bridge(port, pp->bridge->bus) {
>  			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
>  				pci_host_handle_link_down(port);
> @@ -2204,6 +2271,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&pcie->ports);
>  
> +	ret = devm_mutex_init(dev, &pcie->hw_lock);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> 
> ---
> base-commit: 3de6add8d15430cde96c615fd156216676762bf9
> change-id: 20260810-ecam_blocker-f801b3a02bcd
> 
> Best regards,
> --  
> Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
