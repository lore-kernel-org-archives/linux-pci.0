Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36935 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbG2RnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 13:43:14 -0400
MIME-Version: 1.0
In-Reply-To: <1438158927.5106.20.camel@tiscali.nl>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-4-git-send-email-lftan@altera.com>
	<1438158927.5106.20.camel@tiscali.nl>
Date: Thu, 30 Jul 2015 01:43:13 +0800
Message-ID: <CAFiDJ5_yXoXJ+UUROX1aiNeTyxt6wDZ+h8DW=c4EdUiS5OkkJg@mail.gmail.com>
Subject: Re: [PATCH 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 4:35 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On di, 2015-07-28 at 18:45 +0800, Ley Foon Tan wrote:
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>
>> +config PCIE_ALTERA
>> +     bool "Altera PCIe controller"
>> +     depends on ARCH_SOCFPGA
>> +     depends on OF
>> +     select PCI_MSI_IRQ_DOMAIN if PCI_MSI
>> +     help
>> +       Say Y here if you want to enable PCIe controller support for Altera
>> +       SoCFPGA family of SoCs.
>
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>
>> +obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
>
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-altera.c
>
>> +#include <linux/module.h>
>
>> +static const struct of_device_id altera_pcie_of_match[] = {
>> +     { .compatible = "altr,pcie-root-port-1.0", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
>
>
>> +static struct platform_driver altera_pcie_driver = {
>> +     [...]
>> +             .owner  = THIS_MODULE,
>> +     ]...]
>> +};
>> +
>> +module_platform_driver(altera_pcie_driver);
>> +
>> +MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
>> +MODULE_DESCRIPTION("Altera PCIe host controller driver");
>> +MODULE_LICENSE("GPL v2");
>
> PCIE_ALTERA is a bool symbol. So pcie-altera.o is built-in only. Yet
> pcie-altera.c uses a number of module-specific constructs. Should
> PCIE_ALTERA perhaps be tristate?
Yes, PCIE_ALTERA can be changed to tristate after we remove call to
pci_common_init_dev to now.
pci_common_init_dev is not a exported symbol.


> Likewise for PCIE_ALTERA_MSI in 4/6.
PCIE_ALTERA_MSI can only be built-in only. It depends on quite a
number of non-exported symbols.
Eg: pci_msi_mask_irq, pci_msi_create_irq_domain, irq_domain_set_info and etc..

Thanks.

Regards
Ley Foon
