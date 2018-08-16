Return-Path: <SRS0=nBid=K7=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=nBid=K7=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 14:57:08 +0530
From: poza@codeaurora.org
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Keith Busch
 <keith.busch@intel.com>, Sinan Kaya <okaya@kernel.org>, Dongdong Liu
 <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <f11c06374a90650e862cb68206ad2fdb@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 02:56, Jon Derrick wrote:
> Some users may want to disable downstream port containment (DPC), so
> give them this option
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci.c      |  2 ++
>  drivers/pci/pci.h      |  6 ++++++
>  drivers/pci/pcie/dpc.c | 48 
> ++++++++++++++++++++++++++++++++++++++----------
>  include/linux/pci.h    |  6 ++++++
>  4 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 80da484..4e629c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6062,6 +6062,8 @@ static int __init pci_setup(char *str)
>  				pcie_ats_disabled = true;
>  			} else if (!strcmp(str, "noaer")) {
>  				pci_no_aer();
> +			} else if (!strcmp(str, "nodpc")) {
> +				pci_no_dpc();
>  			} else if (!strcmp(str, "earlydump")) {
>  				pci_early_dump = true;
>  			} else if (!strncmp(str, "realloc=", 8)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d152..f73f29e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -536,4 +536,10 @@ static inline void
> pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline void pci_aer_clear_device_status(struct pci_dev *dev) { 
> }
>  #endif
> 
> +#ifdef CONFIG_PCIE_DPC
> +void pci_no_dpc(void);
> +#else
> +static inline void pci_no_dpc(void) { }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f03279f..068fca0 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -44,6 +44,18 @@ struct dpc_dev {
>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
> 
> +static int pcie_dpc_disable;
> +
> +void pci_no_dpc(void)
> +{
> +	pcie_dpc_disable = 1;
> +}
> +
> +bool pci_dpc_available(void)
> +{
> +	return !pcie_dpc_disable && pci_aer_available() && pci_msi_enabled();

1) why do you check pci_aer_available() ?
2) and pci_aer_available() already internally checks pci_msi_enabled();

> +}
> +
>  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -209,6 +221,17 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
> 
> +static void dpc_disable(struct pci_dev *pdev)
> +{
> +	u16 cap_pos, ctl;
> +
> +	cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> +	pci_read_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_EN_NONFATAL |
> +		 PCI_EXP_DPC_CTL_INT_EN);
> +	pci_write_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL, ctl);
> +}
> +
>  #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>  static int dpc_probe(struct pcie_device *dev)
>  {
> @@ -221,9 +244,16 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (pcie_aer_get_firmware_first(pdev))
>  		return -ENOTSUPP;
> 
> +	if (!pci_dpc_available()) {
> +		status = -ENOTSUPP;
> +		goto disable_dpc;
> +	}
> +
>  	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> -	if (!dpc)
> -		return -ENOMEM;
> +	if (!dpc) {
> +		status = -ENOMEM;
> +		goto disable_dpc;
> +	}
> 
>  	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>  	dpc->dev = dev;
> @@ -235,7 +265,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (status) {
>  		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
>  			 status);
> -		return status;
> +		goto disable_dpc;
>  	}
> 
>  	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
> @@ -260,17 +290,15 @@ static int dpc_probe(struct pcie_device *dev)
>  		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
>  		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
>  	return status;
> +
> +disable_dpc:
> +	dpc_disable(pdev);
> +	return status;
>  }
> 
>  static void dpc_remove(struct pcie_device *dev)
>  {
> -	struct dpc_dev *dpc = get_service_data(dev);
> -	struct pci_dev *pdev = dev->port;
> -	u16 ctl;
> -
> -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> -	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
> +	dpc_disable(dev->port);
>  }
> 
>  static struct pcie_port_service_driver dpcdriver = {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5454e6b..559b792 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1473,6 +1473,12 @@ static inline int pci_irqd_intx_xlate(struct
> irq_domain *d,
>  static inline bool pci_aer_available(void) { return false; }
>  #endif
> 
> +#ifdef CONFIG_PCIE_DPC
> +bool pci_dpc_available(void);
> +#else
> +static inline bool pci_dpc_available(void) { return false; }
> +#endif
> +
>  #ifdef CONFIG_PCIE_ECRC
>  void pcie_set_ecrc_checking(struct pci_dev *dev);
>  void pcie_ecrc_get_policy(char *str);
