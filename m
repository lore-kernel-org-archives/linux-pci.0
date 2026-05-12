Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42A3E170C;
	Tue, 12 May 2026 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591119; cv=none; b=nrG9QSwS08DBzxK36pGDuhxejAZ/s+rF6ksxkqOiOKE8EjHW4NQDKKRKdJUTTdw5wk1/RmPrfpk6CvXhc9x8R2G0gGoM2RJo0AGo6hY0ssf0OHK6hWgcLOULr37deD3MtiVSFLf+aZHUjhYEIEt4gEcl2HUX/HTtRQmL4OzECYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591119; c=relaxed/simple;
	bh=bg4o7RwuuxEDvH8OIFEtF3dwjttBqocBKfhQEXr8ROo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDKpqABcrzmwPQsI4f/FmfKV/T/YrqTNV4snvle7mohRa3fp6wgPR9pmrKS0LB7ENcAnUqZRzFHTUk6T0ljXlGTTFcGyaLZpKF/HxIkVShxqgKhJXjbBBODBbUr4RhzOb9s3fKxzT3exdwukK68bIkyto0GtDlVTYSa/lOzJVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAJ4+SWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAJ4+SWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20081C2BCB0;
	Tue, 12 May 2026 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778591119;
	bh=bg4o7RwuuxEDvH8OIFEtF3dwjttBqocBKfhQEXr8ROo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAJ4+SWW6dGKdQlvU4QHubSOcxUTtjskun01cJTOk3Rq+++/n/I9fNV1eawjLpMno
	 2t+p9/OePnaKrEg6gZb+Dwq8dQpklF1ievE2b6SCHzbmjSTESi9AUzt4B5IOITc82D
	 vjWplV2ktWv5fsndOHlm2sQV7UKAN2O9cmsZx9YM/G4dgZLdCa3WnARD7CEiz3MCOg
	 FYTZIHEvZS2p8l/pvh83CLIZrX2/OoCpXlXqjxGZwPq4VerPZmZQvKCUHZWPz/aE9x
	 k3uCwqq7ejXymYyBy1ongNdqkUVbYEpxsw1ajVMyTCwbyWilDhEwd5dFaSWVlquWdg
	 lBPsLDyLnnZuQ==
Date: Tue, 12 May 2026 18:35:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	subhransu.sekhar.prusty@altera.com, dinguyen@kernel.org
Subject: Re: [PATCH 3/3] PCI: altera: add Agilex 5 support
Message-ID: <46lb3ald2zwoum53oivvlgoy2uognjygkgtks5vcngqo4wxply@75a6zvxtfwes>
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
 <20260424094913.522123-4-mahesh.vaidya@altera.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424094913.522123-4-mahesh.vaidya@altera.com>

On Fri, Apr 24, 2026 at 02:49:13AM -0700, Mahesh Vaidya wrote:
> Add PCIe root port controller support for the Agilex 5 (V4) family

There is no 'root port controller'. Root Port and Controller (Root Complex) are
two different IPs.

> of SoC FPGAs.
> 
> The Agilex 5 PCIe Hard IP reuses the same config-space access path
> as Agilex 7 (V3). Root port and endpoint configuration reads/writes
> use direct MMIO to the HIP and CRA regions.
> 
> The difference is in the HIP port-level registers (IRQ status and IRQ
> enable). On V3 these are directly mapped through the HIP MMIO window.
> On V4 these registers are only reachable through an indirect access
> mailbox (CFG REG IA CTRL) in the PCIe Subsystem AXI-Lite interface,
> documented in the GTS AXI Streaming IP for PCIe User Guide.
> 
> This adds:
> - ALTERA_PCIE_V4 version and platform data
> - Indirect register read/write helpers using readl_poll_timeout_atomic
> - Chained IRQ handler (aglx5_isr) for the V4 interrupt path
> - OF match for "altr,pcie-root-port-4.0"
> 
> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Co-developed-by: Peter Colberg <peter.colberg@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 156 ++++++++++++++++++++++++++-
>  1 file changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 025ba74d1ee2..db8149d84c96 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -12,6 +12,8 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/init.h>
> +#include <linux/bitfield.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_pci.h>
> @@ -93,16 +95,36 @@
>  #define AGLX_CFG_TARGET_LOCAL_2000	2
>  #define AGLX_CFG_TARGET_LOCAL_3000	3
>  
> +/* PCIe subsystem indirect register access */
> +#define PCIE_SS_IA_CTL			0xc8 /* control register */
> +#define PCIE_SS_IA_FN_NUM		0xcc /* function number */
> +#define PCIE_SS_IA_FN_WRDATA		0xd0 /* write data */
> +#define PCIE_SS_IA_FN_RDDATA		0xd4 /* read data */
> +
> +/* PCIE_SS_IA_CTL bitfields */
> +#define PCIE_SS_IA_CTL_INITIATE		BIT(0)
> +#define PCIE_SS_IA_CTL_WRITE		BIT(1)
> +#define PCIE_SS_IA_CTL_BYTE_EN		GENMASK(5, 2)
> +#define PCIE_SS_IA_CTL_ADDR		GENMASK(31, 6)
> +
> +/* PCIE_SS_IA_FN_NUM function types */
> +#define PCIE_SS_IA_FN_TYPE_HIP		2
> +
> +#define AGLX5_INDIRECT_SLEEP_US		1
> +#define AGLX5_INDIRECT_TIMEOUT_US	1000
> +
>  enum altera_pcie_version {
>  	ALTERA_PCIE_V1 = 0,
>  	ALTERA_PCIE_V2,
>  	ALTERA_PCIE_V3,
> +	ALTERA_PCIE_V4,
>  };
>  
>  struct altera_pcie {
>  	struct platform_device	*pdev;
>  	void __iomem		*cra_base;
>  	void __iomem		*hip_base;
> +	void __iomem		*controller_base;
>  	int			irq;
>  	u8			root_bus_nr;
>  	struct irq_domain	*irq_domain;
> @@ -849,6 +871,98 @@ static void aglx_isr(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> +/*
> + * Indirect register access to HIP registers via the PCIe Subsystem
> + * AXI-Lite mailbox, documented in the GTS AXI Streaming IP for PCIe
> + * User Guide. Called from chained IRQ handler (hardirq) and probe
> + * (before handler is installed), so no locking is required.
> + */
> +static int aglx5_indirect_readl(const struct altera_pcie *pcie,
> +				unsigned int addr, unsigned int *val)

s/unsigned int/u32

> +{
> +	unsigned int ctl;

s/unsigned int/u32

> +	int ret;
> +
> +	writel(PCIE_SS_IA_FN_TYPE_HIP,
> +	       pcie->controller_base + PCIE_SS_IA_FN_NUM);
> +
> +	ctl = FIELD_PREP(PCIE_SS_IA_CTL_ADDR, addr >> 2) |
> +	      PCIE_SS_IA_CTL_BYTE_EN | PCIE_SS_IA_CTL_INITIATE;
> +	writel(ctl, (pcie->controller_base + PCIE_SS_IA_CTL));
> +
> +	ret = readl_poll_timeout_atomic(pcie->controller_base + PCIE_SS_IA_CTL,
> +					ctl, !(ctl & PCIE_SS_IA_CTL_INITIATE),
> +					AGLX5_INDIRECT_SLEEP_US,
> +					AGLX5_INDIRECT_TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	*val = readl(pcie->controller_base + PCIE_SS_IA_FN_RDDATA);
> +
> +	return 0;
> +}
> +
> +static int aglx5_indirect_writel(const struct altera_pcie *pcie,
> +				 unsigned int addr, unsigned int val)

s/unsigned int/u32

> +{
> +	unsigned int ctl;

s/unsigned int/u32

> +	int ret;
> +
> +	writel(PCIE_SS_IA_FN_TYPE_HIP,
> +	       pcie->controller_base + PCIE_SS_IA_FN_NUM);
> +	writel(val, pcie->controller_base + PCIE_SS_IA_FN_WRDATA);
> +
> +	ctl = FIELD_PREP(PCIE_SS_IA_CTL_ADDR, addr >> 2) |
> +	      PCIE_SS_IA_CTL_BYTE_EN | PCIE_SS_IA_CTL_WRITE |
> +	      PCIE_SS_IA_CTL_INITIATE;
> +	writel(ctl, pcie->controller_base + PCIE_SS_IA_CTL);
> +
> +	ret = readl_poll_timeout_atomic(pcie->controller_base + PCIE_SS_IA_CTL,
> +					ctl, !(ctl & PCIE_SS_IA_CTL_INITIATE),
> +					AGLX5_INDIRECT_SLEEP_US,
> +					AGLX5_INDIRECT_TIMEOUT_US);
> +
> +	return ret;

return readl_poll_timeout_atomic();

- Mani

-- 
மணிவண்ணன் சதாசிவம்
