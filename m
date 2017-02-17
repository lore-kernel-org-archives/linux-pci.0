Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58A6F757.2060705@ti.com>
Date: Fri, 17 Feb 2017 18:45:03 +0530
MIME-Version: 1.0
In-Reply-To: <1487325042-28227-9-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 17 February 2017 03:20 PM, Kishon Vijay Abraham I wrote:
> Add endpoint mode support to designware driver. This uses the
> EP Core layer introduced recently to add endpoint mode support.
> *Any* function driver can now use this designware device
> in order to achieve the EP functionality.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Kconfig              |    5 +
>  drivers/pci/dwc/Makefile             |    1 +
>  drivers/pci/dwc/pcie-designware-ep.c |  342 ++++++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-designware.c    |   51 +++++
>  drivers/pci/dwc/pcie-designware.h    |   72 +++++++
>  5 files changed, 471 insertions(+)
>  create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index dfb8a69..00335c7 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -9,6 +9,11 @@ config PCIE_DW_HOST
>  	depends on PCI_MSI_IRQ_DOMAIN
>          select PCIE_DW
>  
> +config PCIE_DW_EP
> +	bool
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW
> +
>  config PCI_DRA7XX
>  	bool "TI DRA7xx PCIe controller"
>  	depends on PCI
> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> index a2df13c..b38425d 100644
> --- a/drivers/pci/dwc/Makefile
> +++ b/drivers/pci/dwc/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> +obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> new file mode 100644
> index 0000000..e465c5e
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -0,0 +1,342 @@
> +/**
> + * Synopsys Designware PCIe Endpoint controller driver
> + *
> + * Copyright (C) 2017 Texas Instruments
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 of
> + * the License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/of.h>
> +
> +#include "pcie-designware.h"
> +#include <linux/pci-epc.h>
> +#include <linux/pci-epf.h>
> +
> +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> +{
> +	struct pci_epc *epc = ep->epc;
> +	struct pci_epf *epf;
> +
> +	list_for_each_entry(epf, &epc->pci_epf, list)
> +		pci_epf_linkup(epf);

Just notices, the right place to use this list should be pci-epc-core. Will fix
this in the next revision.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
