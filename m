Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Jan 2016 15:52:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, mika.westerberg@intel.com,
	Qi Zheng <qi.zheng@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] PCI/PM: Revert "PCI/PM: Drop unused runtime PM
 support code for PCIe ports"
Message-ID: <20160119215234.GH14080@localhost>
References: <1452868065-96999-1-git-send-email-qipeng.zha@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452868065-96999-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, author of fe9a743a2601]

On Fri, Jan 15, 2016 at 10:27:44PM +0800, Qipeng Zha wrote:
> This reverts commit fe9a743a2601 ("PCI/PM: Drop unused runtime
> PM support code for PCIe ports"). To support PCIe ports
> runtime PM for Intel Broxton platform.

This changelog is not as useful as it could be.  It's true that this
reverts fe9a743a2601, but what's important is that this adds support
code for runtime PM of PCIe ports, so that should be mentioned first.

The fe9a743a2601 changelog says "If we are to support runtime PM of
PCIe ports, it will have to be done in a different way most likely
anyway."  I don't know what Rafael had in mind there, but we certainly
need to ask him before adding it back the same way it was.

> Signed-off-by: Qi Zheng <qi.zheng@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index be35da2..2ccc9b9 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -93,6 +93,77 @@ static int pcie_port_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_RUNTIME
> +struct d3cold_info {
> +	bool no_d3cold;
> +	unsigned int d3cold_delay;
> +};
> +
> +static int pci_dev_d3cold_info(struct pci_dev *pdev, void *data)
> +{
> +	struct d3cold_info *info = data;
> +
> +	info->d3cold_delay = max_t(unsigned int, pdev->d3cold_delay,
> +				   info->d3cold_delay);
> +	if (pdev->no_d3cold)
> +		info->no_d3cold = true;
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct d3cold_info d3cold_info = {
> +		.no_d3cold	= false,
> +		.d3cold_delay	= PCI_PM_D3_WAIT,
> +	};
> +
> +	/*
> +	 * If any subordinate device disable D3cold, we should not put
> +	 * the port into D3cold.  The D3cold delay of port should be
> +	 * the max of that of all subordinate devices.
> +	 */
> +	pci_walk_bus(pdev->subordinate, pci_dev_d3cold_info, &d3cold_info);
> +	pdev->no_d3cold = d3cold_info.no_d3cold;
> +	pdev->d3cold_delay = d3cold_info.d3cold_delay;
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int pci_dev_pme_poll(struct pci_dev *pdev, void *data)
> +{
> +	bool *pme_poll = data;
> +
> +	if (pdev->pme_poll)
> +		*pme_poll = true;
> +	return 0;
> +}
> +
> +static int pcie_port_runtime_idle(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool pme_poll = false;
> +
> +	/*
> +	 * If any subordinate device needs pme poll, we should keep
> +	 * the port in D0, because we need port in D0 to poll it.
> +	 */
> +	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
> +	/* Delay for a short while to prevent too frequent suspend/resume */
> +	if (!pme_poll)
> +		pm_schedule_suspend(dev, 10);
> +	return -EBUSY;
> +}
> +#else
> +#define pcie_port_runtime_suspend	NULL
> +#define pcie_port_runtime_resume	NULL
> +#define pcie_port_runtime_idle		NULL
> +#endif
> +
>  static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.suspend	= pcie_port_device_suspend,
>  	.resume		= pcie_port_device_resume,
> @@ -101,6 +172,9 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  	.poweroff	= pcie_port_device_suspend,
>  	.restore	= pcie_port_device_resume,
>  	.resume_noirq	= pcie_port_resume_noirq,
> +	.runtime_suspend = pcie_port_runtime_suspend,
> +	.runtime_resume = pcie_port_runtime_resume,
> +	.runtime_idle	= pcie_port_runtime_idle,
>  };
>  
>  #define PCIE_PORTDRV_PM_OPS	(&pcie_portdrv_pm_ops)
> -- 
> 1.8.3.2
> 
