Return-Path: <SRS0=oDjp=K6=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=oDjp=K6=intel.com=keith.busch@kernel.org>
Date: Wed, 15 Aug 2018 17:03:22 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Sinan Kaya <okaya@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180815230321.GA5438@localhost.localdomain>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -536,4 +536,10 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_PCIE_DPC
> +void pci_no_dpc(void);
> +#else
> +static inline void pci_no_dpc(void) { }
> +#endif

<snip>

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1473,6 +1473,12 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  static inline bool pci_aer_available(void) { return false; }
>  #endif
>  
> +#ifdef CONFIG_PCIE_DPC
> +bool pci_dpc_available(void);
> +#else
> +static inline bool pci_dpc_available(void) { return false; }
> +#endif

Seems like these two sections belong together. Otherwise, looks fine.
