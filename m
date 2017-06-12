Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: endpoint: fix endpoint test build error
To: Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <89a5b4f8-69bb-a5bc-5400-06c24050595d@infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bb2a288e-8f90-a204-c0fe-8e8a09afa087@ti.com>
Date: Mon, 12 Jun 2017 13:59:08 +0530
MIME-Version: 1.0
In-Reply-To: <89a5b4f8-69bb-a5bc-5400-06c24050595d@infradead.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Monday 12 June 2017 07:40 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> PCI endpoint test driver uses crc32_le() so it should select
> CRC32. Fixes this build error (when CRC32=m):
> 
>   drivers/built-in.o: In function `pci_epf_test_cmd_handler':
>   pci-epf-test.c:(.text+0x2d98d): undefined reference to `crc32_le'
> 
> Fixes 349e7a85b25f (PCI: endpoint: functions: Add an EP function to test PCI).
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-412-rc4.orig/drivers/pci/endpoint/functions/Kconfig
> +++ lnx-412-rc4/drivers/pci/endpoint/functions/Kconfig
> @@ -5,6 +5,7 @@
>  config PCI_EPF_TEST
>  	tristate "PCI Endpoint Test driver"
>  	depends on PCI_ENDPOINT
> +	select CRC32
>  	help
>  	   Enable this configuration option to enable the test driver
>  	   for PCI Endpoint.
> 
> 
