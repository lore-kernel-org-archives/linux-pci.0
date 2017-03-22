Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: dwc: hisi needs PCI_HOST_COMMON
To: Jingoo Han <jingoohan1@gmail.com>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Kishon Vijay Abraham I'" <kishon@ti.com>
References: <20170321143229.3372903-1-arnd@arndb.de>
 <001801d2a25a$9c742760$d55c7620$@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Gabriele Paoloni'" <gabriele.paoloni@huawei.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <58D1EF1B.1080509@hisilicon.com>
Date: Wed, 22 Mar 2017 11:27:23 +0800
MIME-Version: 1.0
In-Reply-To: <001801d2a25a$9c742760$d55c7620$@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/21 23:48, Jingoo Han wrote:
> (+cc: Joao Pinto, Zhou Wang, Gabriele Paoloni)
> 
> On Tuesday, March 21, 2017 10:32 AM, Arnd Bergmann wrote:
>>
>> Without PCI_HOST_COMMON support enabled, we get a link error:
>>
>> drivers/pci/dwc/built-in.o: In function `hisi_pcie_map_bus':
>> pcie-hisi.c:(.text+0x8860): undefined reference to `pci_ecam_map_bus'
>> drivers/pci/dwc/built-in.o: In function `hisi_pcie_almost_ecam_probe':
>> pcie-hisi.c:(.text+0x88b4): undefined reference to `pci_host_common_probe'
>>
>> This adds an explicit 'select', as the other users have.

Hi Arnd,

I wonder if we should select PCI_HOST_GENERIC here, like:

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index dfb8a69..b25dce4 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -89,6 +89,7 @@ config PCI_HISI
        depends on PCI_MSI_IRQ_DOMAIN
        select PCIEPORTBUS
        select PCIE_DW_HOST
+       select PCI_HOST_GENERIC
        help
          Say Y here if you want PCIe controller support on HiSilicon
          Hip05 and Hip06 SoCs
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f7c1d4d..e7a24d0 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -151,7 +151,7 @@ config PCI_HOST_THUNDER_PEM
        bool "Cavium Thunder PCIe controller to off-chip devices"
        depends on ARM64
        depends on OF || (ACPI && PCI_QUIRKS)
-       select PCI_HOST_COMMON
+       select PCI_HOST_GENERIC
        help
          Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.

@@ -159,7 +159,7 @@ config PCI_HOST_THUNDER_ECAM
        bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
        depends on ARM64
        depends on OF || (ACPI && PCI_QUIRKS)
-       select PCI_HOST_COMMON
+       select PCI_HOST_GENERIC
        help
          Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.

Thanks,
Zhou

>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> 
> Best regards,
> Jingoo Han
> 
>> ---
>>  drivers/pci/dwc/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>> index dfb8a69afc28..d2d2ba5b8a68 100644
>> --- a/drivers/pci/dwc/Kconfig
>> +++ b/drivers/pci/dwc/Kconfig
>> @@ -89,6 +89,7 @@ config PCI_HISI
>>  	depends on PCI_MSI_IRQ_DOMAIN
>>  	select PCIEPORTBUS
>>  	select PCIE_DW_HOST
>> +	select PCI_HOST_COMMON
>>  	help
>>  	  Say Y here if you want PCIe controller support on HiSilicon
>>  	  Hip05 and Hip06 SoCs
>> --
>> 2.9.0
> 
> 
> 
> .
> 
