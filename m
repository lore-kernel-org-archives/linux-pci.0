Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbdHSVEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Aug 2017 17:04:44 -0400
Date: Sat, 19 Aug 2017 16:04:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v6 2/2] PCI: iproc: add device shutdown for PCI RC
Message-ID: <20170819210440.GT28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
 <1501861696-25767-3-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501861696-25767-3-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 09:18:16PM +0530, Oza Pawandeep wrote:
> PERST must be asserted around ~500ms before the reboot is applied.
> 
> During soft reset (e.g., "reboot" from Linux) on some iproc based SOCs
> LCPLL clock and PERST both goes off simultaneously.
> This will cause certain Endpoints Intel NVMe not get detected, upon
> next boot sequence.
> 
> This is specifically happening with Intel P3700 400GB series.
> Endpoint is expecting the clock for some amount of time after PERST is
> asserted, which is not happening in Stingray (iproc based SOC).
> This causes NVMe to behave in undefined way.
> 
> On the contrary, Intel x86 boards will have ref clock running, so we
> do not see this behavior there.
> 
> Besides, PCI spec does not stipulate about such timings.
> In-fact it does not tell us, whether PCIe device should consider
> refclk to be available or not to be.
> 
> It is completely up to vendor to design their EP the way they want
> with respect to ref clock availability.

I am unconvinced.  Designing an endpoint that relies on ref clock
timing not guaranteed by the spec does not sound like a way to build
reliable hardware.

The PCIe Card Electromechanical spec, r2.0, sec 2.2.3 says the clock
goes inactive after PERST# goes active, but doesn't specify how long.
In the absence of a spec requirement, I don't see a reason to assume
other systems preserve the ref clock after PERST#, so if the Intel
device requires clocks for 500ms after PERST#, we should see problems
on other systems.

Sec 2.2 says that on power up, the power rails must be stable at least
T(PVPERL) (100ms) and reference clocks must be stable at least
T(PERST-CLK) (100us) before PERST# is deasserted.  I think it's more
likely the problem is here.

The current iproc_pcie_reset() looks like it sleeps 100ms *after* it
deasserts PERST#.  Should that be *before* deasserting PERST#?

> 500ms is just based on the observation and taken as safe margin.
> This patch adds platform shutdown where it should be
> called in device_shutdown while reboot command is issued.
> So in sequence first Endpoint Shutdown (e.g. nvme_shutdown)
> followed by RC shutdown, which issues safe PERST assertion.
> 
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index 90d2bdd..9512960 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -131,6 +131,13 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>  	return iproc_pcie_remove(pcie);
>  }
>  
> +static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
> +{
> +	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	iproc_pcie_shutdown(pcie);
> +}
> +
>  static struct platform_driver iproc_pcie_pltfm_driver = {
>  	.driver = {
>  		.name = "iproc-pcie",
> @@ -138,6 +145,7 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>  	},
>  	.probe = iproc_pcie_pltfm_probe,
>  	.remove = iproc_pcie_pltfm_remove,
> +	.shutdown = iproc_pcie_pltfm_shutdown,
>  };
>  module_platform_driver(iproc_pcie_pltfm_driver);
>  
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 583cee0..ee40651 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -627,7 +627,7 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	.write = iproc_pcie_config_write32,
>  };
>  
> -static void iproc_pcie_reset(struct iproc_pcie *pcie)
> +static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
>  {
>  	u32 val;
>  
> @@ -639,20 +639,28 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
>  	if (pcie->ep_is_internal)
>  		return;
>  
> -	/*
> -	 * Select perst_b signal as reset source. Put the device into reset,
> -	 * and then bring it out of reset
> -	 */
> -	val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
> -	val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
> -		~RC_PCIE_RST_OUTPUT;
> -	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
> -	udelay(250);
> -
> -	val |= RC_PCIE_RST_OUTPUT;
> -	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
> -	msleep(100);
> +	if (assert) {
> +		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
> +		val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
> +			~RC_PCIE_RST_OUTPUT;
> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
> +		udelay(250);
> +	} else {
> +		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
> +		val |= RC_PCIE_RST_OUTPUT;
> +		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
> +		msleep(100);
> +	}
> +}
