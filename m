Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbdFLUs3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jun 2017 16:48:29 -0400
Date: Mon, 12 Jun 2017 15:48:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] pci: endpoint: fix endpoint test build error
Message-ID: <20170612204825.GB28578@bhelgaas-glaptop.roam.corp.google.com>
References: <89a5b4f8-69bb-a5bc-5400-06c24050595d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89a5b4f8-69bb-a5bc-5400-06c24050595d@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 11, 2017 at 07:10:38PM -0700, Randy Dunlap wrote:
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

Applied with Kishon's ack to for-linus for v4.12 (since 349e7a85b25f first
appeared in v4.12-rc1), thanks!

> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
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
