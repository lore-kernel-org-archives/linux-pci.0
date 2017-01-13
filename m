Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 11/37] PCI: dwc: Split pcie-designware.c into host and
 core files
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-12-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <4a89fb45-af84-d660-5ef0-12227b141cda@synopsys.com>
Date: Fri, 13 Jan 2017 16:49:44 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-12-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 10:26 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> Split pcie-designware.c into pcie-designware-host.c that contains
> the host specific parts of the driver and pcie-designware.c that
> contains the parts used by both host driver and endpoint driver.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/Makefile               |    2 +-
>  drivers/pci/dwc/pcie-designware-host.c |  619 ++++++++++++++++++++++++++=
++++++
>  drivers/pci/dwc/pcie-designware.c      |  613 +-------------------------=
-----
>  drivers/pci/dwc/pcie-designware.h      |    8 +
>  4 files changed, 634 insertions(+), 608 deletions(-)
>  create mode 100644 drivers/pci/dwc/pcie-designware-host.c
> =

> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> index 7d27c14..3b57e55 100644
> --- a/drivers/pci/dwc/Makefile
> +++ b/drivers/pci/dwc/Makefile
> @@ -1,4 +1,4 @@

(snip...)

> -static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> -				      int type, u64 cpu_addr, u64 pci_addr,
> -				      u32 size)
> +void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> +			       u64 cpu_addr, u64 pci_addr, u32 size)
>  {
>  	u32 retries, val;
>  =

> @@ -186,220 +151,6 @@ static void dw_pcie_prog_outbound_atu(struct dw_pci=
e *pci, int index,
>  	dev_err(pci->dev, "iATU is not being enabled\n");
>  }

Kishon, iATU only makes sense in The Root Complex (host), so it should be i=
nside
the pcie-designware-host.

>  =

> -static struct irq_chip dw_msi_irq_chip =3D {
> -	.name =3D "PCI-MSI",
> -	.irq_enable =3D pci_msi_unmask_irq,
> -	.irq_disable =3D pci_msi_mask_irq,
> -	.irq_mask =3D pci_msi_mask_irq,
> -	.irq_unmask =3D pci_msi_unmask_irq,
> -};
> -

(snip...)

> -
> -static const struct irq_domain_ops msi_domain_ops =3D {
> -	.map =3D dw_pcie_msi_map,
> -};
> -
>  static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  {
>  	u32 val;
> @@ -454,303 +192,11 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pc=
ie *pci)
>  	return 0;
>  }

Kishon, iATU only makes sense in The Root Complex (host), so it should be i=
nside
the pcie-designware-host.

(snip...)

> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-des=
ignware.h
> index 491fbe3..808d17b 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -14,6 +14,10 @@
>  #ifndef _PCIE_DESIGNWARE_H
>  #define _PCIE_DESIGNWARE_H
>  =

> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -167,4 +171,8 @@ struct dw_pcie {
>  void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> +void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> +			       int type, u64 cpu_addr, u64 pci_addr,
> +			       u32 size);
> +void dw_pcie_setup(struct dw_pcie *pci);


Kishon, iATU only makes sense in The Root Complex (host), so it should be i=
nside
the pcie-designware-host as static.

>  #endif /* _PCIE_DESIGNWARE_H */
> =


Thanks,
Joao

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
