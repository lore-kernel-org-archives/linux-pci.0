Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
Subject: Re: [PATCH V4 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1478682897-119874-1-git-send-email-liudongdong3@huawei.com>
 <1478682897-119874-3-git-send-email-liudongdong3@huawei.com>
 <20161114233320.GB30262@bhelgaas-glaptop.roam.corp.google.com>
 <20161116230040.GA19913@bhelgaas-glaptop.roam.corp.google.com>
CC: <arnd@arndb.de>, <rafael@kernel.org>, <Lorenzo.Pieralisi@arm.com>,
        <tn@semihalf.com>, <wangzhou1@hisilicon.com>,
        <pratyush.anand@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jcm@redhat.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <350379a5-733e-a91d-a3c1-ca932e8bde72@huawei.com>
Date: Thu, 17 Nov 2016 11:02:25 +0800
MIME-Version: 1.0
In-Reply-To: <20161116230040.GA19913@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn
在 2016/11/17 7:00, Bjorn Helgaas 写道:
> On Mon, Nov 14, 2016 at 05:33:20PM -0600, Bjorn Helgaas wrote:
>> On Wed, Nov 09, 2016 at 05:14:57PM +0800, Dongdong Liu wrote:
>>> PCIe controller in Hip05/HIP06/HIP07 SoCs is not ECAM compliant.
>>> It is non ECAM only for the RC bus config space;for any other bus
>>> underneath the root bus we support ECAM access.
>>> Add specific quirks for PCI config space accessors.This involves:
>>> 1. New initialization call hisi_pcie_init() to obtain rc base
>>> addresses from PNP0C02 as subdevice of PNP0A03.
>>> 2. New entry in common quirk array.
>>>
>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> ---
>>>  MAINTAINERS                       |   1 +
>>>  drivers/acpi/pci_mcfg.c           |  13 ++++
>>>  drivers/pci/host/Kconfig          |   8 ++
>>>  drivers/pci/host/Makefile         |   1 +
>>>  drivers/pci/host/pcie-hisi-acpi.c | 157 ++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pci-ecam.h          |   5 ++
>>>  6 files changed, 185 insertions(+)
>>>  create mode 100644 drivers/pci/host/pcie-hisi-acpi.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1cd38a7..b224caa 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9358,6 +9358,7 @@ L:	linux-pci@vger.kernel.org
>>>  S:	Maintained
>>>  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>>  F:	drivers/pci/host/pcie-hisi.c
>>> +F:	drivers/pci/host/pcie-hisi-acpi.c
>>>
>>>  PCIE DRIVER FOR ROCKCHIP
>>>  M:	Shawn Lin <shawn.lin@rock-chips.com>
>>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>>> index ac21db3..b1b6fc7 100644
>>> --- a/drivers/acpi/pci_mcfg.c
>>> +++ b/drivers/acpi/pci_mcfg.c
>>> @@ -57,6 +57,19 @@ struct mcfg_fixup {
>>>  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
>>>  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
>>>  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
>>> +#ifdef CONFIG_PCI_HISI_ACPI
>>> +	#define PCI_ACPI_QUIRK_QUAD_DOM(table_id, seg, ops) \
>>> +	{ "HISI  ", table_id, 0, seg + 0, MCFG_BUS_ANY, ops }, \
>>> +	{ "HISI  ", table_id, 0, seg + 1, MCFG_BUS_ANY, ops }, \
>>> +	{ "HISI  ", table_id, 0, seg + 2, MCFG_BUS_ANY, ops }, \
>>> +	{ "HISI  ", table_id, 0, seg + 3, MCFG_BUS_ANY, ops }
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP05   ", 0, &hisi_pcie_ops),
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP06   ", 0, &hisi_pcie_ops),
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 0, &hisi_pcie_ops),
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 4, &hisi_pcie_ops),
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 8, &hisi_pcie_ops),
>>> +	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
>>> +#endif
>>>  };
>>>
>>>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>> index ae98644..9ff2bcd 100644
>>> --- a/drivers/pci/host/Kconfig
>>> +++ b/drivers/pci/host/Kconfig
>>> @@ -227,6 +227,14 @@ config PCI_HISI
>>>  	  Say Y here if you want PCIe controller support on HiSilicon
>>>  	  Hip05 and Hip06 and Hip07 SoCs
>>>
>>> +config PCI_HISI_ACPI
>>> +	depends on ACPI && ARM64
>>> +	bool "HiSilicon Hip05 and Hip06 and Hip07 SoCs ACPI PCIe controllers"
>>> +	select PNP
>>> +	help
>>> +	  Say Y here if you want ACPI PCIe controller support on HiSilicon
>>> +	  Hip05 and Hip06 and Hip07 SoCs
>>> +
>>>  config PCIE_QCOM
>>>  	bool "Qualcomm PCIe controller"
>>>  	depends on ARCH_QCOM && OF
>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>> index 084cb49..9402858 100644
>>> --- a/drivers/pci/host/Makefile
>>> +++ b/drivers/pci/host/Makefile
>>> @@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
>>>  obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>>>  obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
>>>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
>>> +obj-$(CONFIG_PCI_HISI_ACPI) += pcie-hisi-acpi.o
>>>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>> diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
>>> new file mode 100644
>>> index 0000000..aade4b5
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-hisi-acpi.c
>>> @@ -0,0 +1,157 @@
>>> +/*
>>> + * PCIe host controller driver for HiSilicon HipXX SoCs
>>> + *
>>> + * Copyright (C) 2016 HiSilicon Co., Ltd. http://www.hisilicon.com
>>> + *
>>> + * Author: Dongdong Liu <liudongdong3@huawei.com>
>>> + *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +#include <linux/pci.h>
>>> +#include <linux/pci-acpi.h>
>>> +#include <linux/pci-ecam.h>
>>> +
>>> +#define DEBUG0				0x728
>>> +#define PCIE_LTSSM_LINKUP_STATE		0x11
>>> +#define PCIE_LTSSM_STATE_MASK		0x3F
>>
>> These are now unused.
>>
>>> +static const struct acpi_device_id hisi_pcie_rc_res_ids[] = {
>>> +	{"HISI0081", 0},
>>> +	{"", 0},
>>> +};
>>> +
>>> +static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>> +				  int size, u32 *val)
>>> +{
>>> +	struct pci_config_window *cfg = bus->sysdata;
>>> +	int dev = PCI_SLOT(devfn);
>>> +
>>> +	if (bus->number == cfg->busr.start) {
>>> +		/* access only one slot on each root port */
>>> +		if (dev > 0)
>>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>>> +		else
>>> +			return pci_generic_config_read32(bus, devfn, where,
>>> +							 size, val);
>>> +	}
>>> +
>>> +	return pci_generic_config_read(bus, devfn, where, size, val);
>>> +}
>>> +
>>> +static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
>>> +				  int where, int size, u32 val)
>>> +{
>>> +	struct pci_config_window *cfg = bus->sysdata;
>>> +	int dev = PCI_SLOT(devfn);
>>> +
>>> +	if (bus->number == cfg->busr.start) {
>>> +		/* access only one slot on each root port */
>>> +		if (dev > 0)
>>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>>> +		else
>>> +			return pci_generic_config_write32(bus, devfn, where,
>>> +							  size, val);
>>> +	}
>>> +
>>> +	return pci_generic_config_write(bus, devfn, where, size, val);
>>> +}
>>> +
>>> +static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>>> +				       int where)
>>> +{
>>> +	struct pci_config_window *cfg = bus->sysdata;
>>> +	void __iomem *reg_base = cfg->priv;
>>> +
>>> +	if (bus->number == cfg->busr.start)
>>> +		return reg_base + where;
>>> +	else
>>> +		return pci_ecam_map_bus(bus, devfn, where);
>>> +}
>>> +
>>> +/*
>>> + * Retrieve RC base and size from sub-device under the RC
>>> + * Device (RES1)
>>> + * {
>>> + *	Name (_HID, "HISI0081")
>>> + *	Name (_CID, "PNP0C02")
>>> + *	Name (_CRS, ResourceTemplate (){
>>> + *		Memory32Fixed (ReadWrite, 0xb0080000, 0x10000)
>>> + *	})
>>> + * }
>>> + */
>>> +static int hisi_pcie_rc_addr_get(struct acpi_device *adev,
>>> +				 void __iomem **addr)
>>> +{
>>> +	struct acpi_device *child_adev;
>>> +	struct list_head list;
>>> +	struct resource *res;
>>> +	struct resource_entry *entry;
>>> +	unsigned long flags;
>>> +	int ret;
>>> +
>>> +	list_for_each_entry(child_adev, &adev->children, node) {
>>> +		ret = acpi_match_device_ids(child_adev, hisi_pcie_rc_res_ids);
>>> +		if (ret)
>>> +			continue;
>>> +
>>> +		INIT_LIST_HEAD(&list);
>>> +		flags = IORESOURCE_MEM;
>>> +		ret = acpi_dev_get_resources(child_adev, &list,
>>> +					     acpi_dev_filter_resource_type_cb,
>>> +					     (void *)flags);
>>> +		if (ret < 0) {
>>> +			dev_err(&child_adev->dev,
>>> +				"failed to parse _CRS method, error code %d\n",
>>> +				ret);
>>> +			return ret;
>>> +		} else if (ret == 0) {
>>> +			dev_err(&child_adev->dev,
>>> +				"no IO and memory resources present in _CRS\n");
>>> +			return -EINVAL;
>>> +		}
>>> +
>>> +		entry = list_first_entry(&list, struct resource_entry, node);
>>> +		res = entry->res;
>>> +		*addr = devm_ioremap(&child_adev->dev,
>>> +				     res->start, resource_size(res));
>>> +		acpi_dev_free_resource_list(&list);
>>> +		if (IS_ERR(*addr)) {
>>> +			dev_err(&child_adev->dev, "error with ioremap\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +
>>> +		return 0;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>
>> OK, so MCFG (with the possible help of quirks) tells us where *most*
>> of this RC's ECAM space is, but it doesn't tell us where the root bus
>> ECAM space is, which is why we need this block of ugly code.  Right?
>
> Tomasz is doing the same thing for ThunderX.  Can we share the code
> somehow, e.g., add something that takes the _HID to look for and just
> returns the register address?  Maybe in pci-acpi.c, decl in
> drivers/pci/pci.h, under #ifdef CONFIG_ARM64?0

As we have the PNP0C02 device at the root of the ACPI namespace (under \_SB).
We need a way to tell which root bus the PNP0C02 resource belong to.

Firstly, use _HID(HISI0081) to get the PNP0C02 devices that we need..
Secondly, use _UID to match segment to tell which root bus the PNP0C02 resource belong to.

The implementaton is as below. What do you think about this?
If the code is ok for other manufacturers, we can share the code.

struct hisi_pcie_acpi {
	u16 segment;
	acpi_handle handle;
};

/*
  * Retrieve RC base and size from PNP0C02 at the root of the ACPI namespace
  * (under \_SB).
  * Device (RES0)
  * {
  *	Name (_HID, "HISI0081")
  *	Name (_CID, "PNP0C02")
  *	Name (_UID, 0x0)
  *	Name (_CRS, ResourceTemplate (){
  *		Memory32Fixed (ReadWrite, 0xa0090000, 0x10000)
  *	})
  * }
  */
static int hisi_pcie_rc_addr_get(struct acpi_device *adev,
				 void __iomem **addr)
{
	struct list_head list;
	struct resource *res;
	struct resource_entry *entry;
	unsigned long flags;
	int ret;

	INIT_LIST_HEAD(&list);
	flags = IORESOURCE_MEM;
	ret = acpi_dev_get_resources(adev, &list,
				     acpi_dev_filter_resource_type_cb,
				     (void *)flags);
	if (ret < 0) {
		dev_err(&adev->dev,
			"failed to parse _CRS method, error code %d\n",
			ret);
		return ret;
	} else if (ret == 0) {
		dev_err(&adev->dev,
			"no IO and memory resources present in _CRS\n");
		return -EINVAL;
	}

	entry = list_first_entry(&list, struct resource_entry, node);
	res = entry->res;
	*addr = devm_ioremap(&adev->dev,
			     res->start, resource_size(res));
	acpi_dev_free_resource_list(&list);
	if (IS_ERR(*addr)) {
		dev_err(&adev->dev, "error with ioremap\n");
		return -ENOMEM;
	}

	return 0;
}

static acpi_status find_rc_resource(acpi_handle handle, u32 lvl,
				    void *context, void **rv)
{
	struct hisi_pcie_acpi *pcie_acpi = context;
	acpi_status status;
	unsigned long long uid;

	status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
	if (ACPI_FAILURE(status) || uid != pcie_acpi->segment)
		return AE_CTRL_DEPTH;

	pcie_acpi->handle = handle;
	return AE_CTRL_TERMINATE;
}

static int hisi_pcie_init(struct pci_config_window *cfg)
{
	struct acpi_device *adev = to_acpi_device(cfg->parent);
	struct acpi_pci_root *root = acpi_driver_data(adev);
	struct hisi_pcie_acpi *pcie_acpi;
	int ret;
	void __iomem *reg_base;

	pcie_acpi = devm_kzalloc(&adev->dev, sizeof(*pcie_acpi), GFP_KERNEL);
	if (!pcie_acpi)
		return -ENOMEM;

	pcie_acpi->segment = root->segment;
	acpi_get_devices("HISI0081", find_rc_resource, pcie_acpi, NULL);

	ret = acpi_bus_get_device(pcie_acpi->handle, &adev);
	if (ret)
		return ret;

	ret = hisi_pcie_rc_addr_get(adev, &reg_base);
	if (ret) {
		dev_err(&adev->dev, "can't get rc base address");
		return ret;
	}

	cfg->priv = pcie_acpi->reg_base;
	return 0;
}

Thanks
Dongdong
>
> .
>
