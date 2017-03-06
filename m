Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58BD3212.9070202@ti.com>
Date: Mon, 6 Mar 2017 15:25:30 +0530
MIME-Version: 1.0
In-Reply-To: <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
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
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 17 February 2017 10:50 PM, Joao Pinto wrote:
> =C0s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>> Add endpoint mode support to designware driver. This uses the
>> EP Core layer introduced recently to add endpoint mode support.
>> *Any* function driver can now use this designware device
>> in order to achieve the EP functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/Kconfig              |    5 +
>>  drivers/pci/dwc/Makefile             |    1 +
>>  drivers/pci/dwc/pcie-designware-ep.c |  342 +++++++++++++++++++++++++++=
+++++++
>>  drivers/pci/dwc/pcie-designware.c    |   51 +++++
>>  drivers/pci/dwc/pcie-designware.h    |   72 +++++++
>>  5 files changed, 471 insertions(+)
>>  create mode 100644 drivers/pci/dwc/pcie-designware-ep.c
>>
>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>> index dfb8a69..00335c7 100644
>> --- a/drivers/pci/dwc/Kconfig
>> +++ b/drivers/pci/dwc/Kconfig
>> @@ -9,6 +9,11 @@ config PCIE_DW_HOST
>>  	depends on PCI_MSI_IRQ_DOMAIN
>>          select PCIE_DW
>>  =

>> +config PCIE_DW_EP
>> +	bool
>> +	depends on PCI_ENDPOINT
>> +	select PCIE_DW
>> +
>>  config PCI_DRA7XX
>>  	bool "TI DRA7xx PCIe controller"
>>  	depends on PCI
>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>> index a2df13c..b38425d 100644
>> --- a/drivers/pci/dwc/Makefile
>> +++ b/drivers/pci/dwc/Makefile
>> @@ -1,5 +1,6 @@
>>  obj-$(CONFIG_PCIE_DW) +=3D pcie-designware.o
>>  obj-$(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
>> +obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
>>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
>>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
>>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie=
-designware-ep.c
>> new file mode 100644
>> index 0000000..e465c5e
>> --- /dev/null
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -0,0 +1,342 @@
>> +/**
>> + * Synopsys Designware PCIe Endpoint controller driver
>> + *
>> + * Copyright (C) 2017 Texas Instruments
>> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 of
>> + * the License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <https://urldefense.proofpoint=
.com/v2/url?u=3Dhttp-3A__www.gnu.org_licenses_&d=3DDwIBAg&c=3DDPL6_X_6JkXFx=
7AXWqB0tg&r=3Ds2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=3DWif-q5OZ-YZwR=
CxX1bBAl5itP28aoQ8Fv7NmxvWSvyg&s=3DN2kaSPkx7uqpiP9O357WPoXruWEiOzF6AhCVChKm=
dxc&e=3D >.
>> + */
>> +
>> +#include <linux/of.h>
>> +
>> +#include "pcie-designware.h"
>> +#include <linux/pci-epc.h>
>> +#include <linux/pci-epf.h>
>> +
>> +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>> +{
>> +	struct pci_epc *epc =3D ep->epc;
>> +	struct pci_epf *epf;
>> +
>> +	list_for_each_entry(epf, &epc->pci_epf, list)
>> +		pci_epf_linkup(epf);
>> +}
>> +
>> +static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno ba=
r)
>> +{
>> +	u32 reg;
>> +
>> +	reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, 0x0);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, 0x0);
>> +}
>> +
>> +static int dw_pcie_ep_write_header(struct pci_epc *epc,
>> +				   struct pci_epf_header *hdr)
>> +{
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +	void __iomem *base =3D pci->dbi_base;
>> +
>> +	dw_pcie_write_dbi(pci, base, PCI_VENDOR_ID, 0x2, hdr->vendorid);
>> +	dw_pcie_write_dbi(pci, base, PCI_DEVICE_ID, 0x2, hdr->deviceid);
>> +	dw_pcie_write_dbi(pci, base, PCI_REVISION_ID, 0x1, hdr->revid);
>> +	dw_pcie_write_dbi(pci, base, PCI_CLASS_PROG, 0x1, hdr->progif_code);
>> +	dw_pcie_write_dbi(pci, base, PCI_CLASS_DEVICE, 0x2,
>> +			  hdr->subclass_code | hdr->baseclass_code << 8);
>> +	dw_pcie_write_dbi(pci, base, PCI_CACHE_LINE_SIZE, 0x1,
>> +			  hdr->cache_line_size);
>> +	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_VENDOR_ID, 0x2,
>> +			  hdr->subsys_vendor_id);
>> +	dw_pcie_write_dbi(pci, base, PCI_SUBSYSTEM_ID, 0x2, hdr->subsys_id);
>> +	dw_pcie_write_dbi(pci, base, PCI_INTERRUPT_PIN, 0x1,
>> +			  hdr->interrupt_pin);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno=
 bar,
>> +				  dma_addr_t cpu_addr,
>> +				  enum dw_pcie_as_type as_type)
>> +{
>> +	int ret;
>> +	u32 free_win;
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	free_win =3D find_first_zero_bit(&ep->ib_window_map,
>> +				       sizeof(ep->ib_window_map));
>> +	if (free_win >=3D ep->num_ib_windows) {
>> +		dev_err(pci->dev, "no free inbound window\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D dw_pcie_prog_inbound_atu(pci, free_win, bar, cpu_addr,
>> +				       as_type);
>> +	if (ret < 0) {
>> +		dev_err(pci->dev, "Failed to program IB window\n");
>> +		return ret;
>> +	}
>> +
>> +	ep->bar_to_atu[bar] =3D free_win;
>> +	set_bit(free_win, &ep->ib_window_map);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t p=
hys_addr,
>> +				   u64 pci_addr, size_t size)
>> +{
>> +	u32 free_win;
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	free_win =3D find_first_zero_bit(&ep->ob_window_map,
>> +				       sizeof(ep->ob_window_map));
>> +	if (free_win >=3D ep->num_ob_windows) {
>> +		dev_err(pci->dev, "no free outbound window\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
>> +				  phys_addr, pci_addr, size);
>> +
>> +	set_bit(free_win, &ep->ob_window_map);
>> +	ep->outbound_addr[free_win] =3D phys_addr;
>> +
>> +	return 0;
>> +}
>> +
>> +static void dw_pcie_ep_clear_bar(struct pci_epc *epc, enum pci_barno ba=
r)
>> +{
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +	u32 atu_index =3D ep->bar_to_atu[bar];
>> +
>> +	dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
>> +	clear_bit(atu_index, &ep->ib_window_map);
>> +}
>> +
>> +static int dw_pcie_ep_set_bar(struct pci_epc *epc, enum pci_barno bar,
>> +			      dma_addr_t bar_phys, size_t size, int flags)
>> +{
>> +	int ret;
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +	enum dw_pcie_as_type as_type;
>> +	u32 reg =3D PCI_BASE_ADDRESS_0 + (4 * bar);
>> +
>> +	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>> +		as_type =3D DW_PCIE_AS_MEM;
>> +	else
>> +		as_type =3D DW_PCIE_AS_IO;
>> +
>> +	ret =3D dw_pcie_ep_inbound_atu(ep, bar, bar_phys, as_type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dw_pcie_write_dbi(pci, pci->dbi_base2, reg, 0x4, size - 1);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
>> +			      u32 *atu_index)
>> +{
>> +	u32 index;
>> +
>> +	for (index =3D 0; index < ep->num_ob_windows; index++) {
>> +		if (ep->outbound_addr[index] !=3D addr)
>> +			continue;
>> +		*atu_index =3D index;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, phys_addr_t addr)
>> +{
>> +	int ret;
>> +	u32 atu_index;
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	ret =3D dw_pcie_find_index(ep, addr, &atu_index);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_OUTBOUND);
>> +	clear_bit(atu_index, &ep->ob_window_map);
>> +}
>> +
>> +static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
>> +			       u64 pci_addr, size_t size)
>> +{
>> +	int ret;
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	ret =3D dw_pcie_ep_outbound_atu(ep, addr, pci_addr, size);
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to enable address\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_get_msi(struct pci_epc *epc)
>> +{
>> +	int val;
>> +	u32 lower_addr;
>> +	u32 upper_addr;
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	val =3D dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_CONTROL, 0x2);
>> +	val =3D (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
>> +
>> +	lower_addr =3D dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_ADDR_L=
32,
>> +				      0x4);
>> +	upper_addr =3D dw_pcie_read_dbi(pci, pci->dbi_base, MSI_MESSAGE_ADDR_U=
32,
>> +				      0x4);
>> +
>> +	if (!(lower_addr || upper_addr))
>> +		return -EINVAL;
>> +
>> +	return val;
>> +}
>> +
>> +static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 encode_int)
>> +{
>> +	int val;
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	val =3D (encode_int << MSI_CAP_MMC_SHIFT);
>> +	dw_pcie_write_dbi(pci, pci->dbi_base, MSI_MESSAGE_CONTROL, 0x2, val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dw_pcie_ep_raise_irq(struct pci_epc *epc,
>> +				enum pci_epc_irq_type type, u8 interrupt_num)
>> +{
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +
>> +	if (!ep->ops->raise_irq)
>> +		return -EINVAL;
>> +
>> +	return ep->ops->raise_irq(ep, type, interrupt_num);
>> +}
>> +
>> +static void dw_pcie_ep_stop(struct pci_epc *epc)
>> +{
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	if (!pci->ops->stop_link)
>> +		return;
>> +
>> +	pci->ops->stop_link(pci);
>> +}
>> +
>> +static int dw_pcie_ep_start(struct pci_epc *epc)
>> +{
>> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +
>> +	if (!pci->ops->start_link)
>> +		return -EINVAL;
>> +
>> +	return pci->ops->start_link(pci);
>> +}
>> +
>> +static const struct pci_epc_ops epc_ops =3D {
>> +	.write_header		=3D dw_pcie_ep_write_header,
>> +	.set_bar		=3D dw_pcie_ep_set_bar,
>> +	.clear_bar		=3D dw_pcie_ep_clear_bar,
>> +	.map_addr		=3D dw_pcie_ep_map_addr,
>> +	.unmap_addr		=3D dw_pcie_ep_unmap_addr,
>> +	.set_msi		=3D dw_pcie_ep_set_msi,
>> +	.get_msi		=3D dw_pcie_ep_get_msi,
>> +	.raise_irq		=3D dw_pcie_ep_raise_irq,
>> +	.start			=3D dw_pcie_ep_start,
>> +	.stop			=3D dw_pcie_ep_stop,
>> +};
>> +
>> +void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>> +{
>> +	struct pci_epc *epc =3D ep->epc;
>> +
>> +	pci_epc_mem_exit(epc);
>> +}
>> +
>> +int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>> +{
>> +	int ret;
>> +	void *addr;
>> +	enum pci_barno bar;
>> +	struct pci_epc *epc;
>> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>> +	struct device *dev =3D pci->dev;
>> +	struct device_node *np =3D dev->of_node;
>> +
>> +	ret =3D of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows=
);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to read *num-ib-windows* property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows=
);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to read *num-ob-windows* property\n");
>> +		return ret;
>> +	}
>> +
>> +	addr =3D devm_kzalloc(dev, sizeof(phys_addr_t) * ep->num_ob_windows,
>> +			    GFP_KERNEL);
>> +	if (!addr)
>> +		return -ENOMEM;
>> +	ep->outbound_addr =3D addr;
>> +
>> +	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
>> +		dw_pcie_ep_reset_bar(pci, bar);
>> +
>> +	if (ep->ops->ep_init)
>> +		ep->ops->ep_init(ep);
>> +
>> +	epc =3D devm_pci_epc_create(dev, &epc_ops);
>> +	if (IS_ERR(epc)) {
>> +		dev_err(dev, "failed to create epc device\n");
>> +		return PTR_ERR(epc);
>> +	}
>> +
>> +	ret =3D of_property_read_u8(np, "max-functions", &epc->max_functions);
>> +	if (ret < 0)
>> +		epc->max_functions =3D 1;
>> +
>> +	ret =3D pci_epc_mem_init(epc, ep->phys_base, ep->addr_size);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to initialize address space\n");
>> +		return ret;
>> +	}
>> +
>> +	ep->epc =3D epc;
>> +	epc_set_drvdata(epc, ep);
>> +	dw_pcie_setup(pci);
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-de=
signware.c
>> index 686945d..49b28c8 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -173,6 +173,57 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci,=
 int index, int type,
>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>  }
>>  =

>> +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>> +			     u64 cpu_addr, enum dw_pcie_as_type as_type)
>> +{
>> +	int type;
>> +	void __iomem *base =3D pci->dbi_base;
>> +
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
>> +			  PCIE_ATU_REGION_INBOUND | index);
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_LOWER_TARGET, 0x4,
>> +			  lower_32_bits(cpu_addr));
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_UPPER_TARGET, 0x4,
>> +			  upper_32_bits(cpu_addr));
>> +
>> +	switch (as_type) {
>> +	case DW_PCIE_AS_MEM:
>> +		type =3D PCIE_ATU_TYPE_MEM;
>> +		break;
>> +	case DW_PCIE_AS_IO:
>> +		type =3D PCIE_ATU_TYPE_IO;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR1, 0x4, type);
>> +	dw_pcie_write_dbi(pci, base, PCIE_ATU_CR2, 0x4, PCIE_ATU_ENABLE |
>> +			  PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
>> +	return 0;
>> +}
>> +
> =

> This Atu programming is for PCI Cores <=3D 4.70. Please follow the same a=
pproach as:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/drivers=
/pci/dwc/pcie-designware.c?h=3Dpci/host-designware#n95

Okay. But *iatu_unroll_enabled* is being set in "if (!pp->ops->rd_other_con=
f)".
This ops is specific to RC. I think we should have some other mechanism to
detect if iatu is required or not.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
