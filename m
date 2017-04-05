Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42566 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdDEFn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2017 01:43:59 -0400
Subject: Re: [pci:pci/host-designware 37/43]
 drivers/misc/pci_endpoint_test.c:420:8: error: implicit declaration of
 function 'pci_alloc_irq_vectors'
To: kbuild test robot <fengguang.wu@intel.com>
References: <201704050616.ukHhiUMi%fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <142dc385-28e5-a068-d6a9-076c7156e955@ti.com>
Date: Wed, 5 Apr 2017 11:13:52 +0530
MIME-Version: 1.0
In-Reply-To: <201704050616.ukHhiUMi%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 05 April 2017 03:42 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-designware
> head:   f6a1972e20ab2f40f4a8a1000bf34f4df3145c01
> commit: 450afc42599ba3544e23fb45e86a995d839e2e1c [37/43] misc: Add host side PCI driver for PCI test function device
> config: blackfin-allmodconfig (attached as .config)
> compiler: bfin-uclinux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 450afc42599ba3544e23fb45e86a995d839e2e1c
>         # save the attached .config to linux build tree
>         make.cross ARCH=blackfin 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/misc/pci_endpoint_test.c: In function 'pci_endpoint_test_probe':
>>> drivers/misc/pci_endpoint_test.c:420:8: error: implicit declaration of function 'pci_alloc_irq_vectors' [-Werror=implicit-function-declaration]
>      irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>            ^~~~~~~~~~~~~~~~~~~~~
>>> drivers/misc/pci_endpoint_test.c:420:43: error: 'PCI_IRQ_MSI' undeclared (first use in this function)
>      irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
>                                               ^~~~~~~~~~~
>    drivers/misc/pci_endpoint_test.c:420:43: note: each undeclared identifier is reported only once for each function it appears in
>>> drivers/misc/pci_endpoint_test.c:487:2: error: implicit declaration of function 'pci_disable_msi' [-Werror=implicit-function-declaration]
>      pci_disable_msi(pdev);
>      ^~~~~~~~~~~~~~~
>    drivers/misc/pci_endpoint_test.c: At top level:
>>> drivers/misc/pci_endpoint_test.c:530:1: warning: data definition has no type or storage class
>     module_pci_driver(pci_endpoint_test_driver);
>     ^~~~~~~~~~~~~~~~~
>>> drivers/misc/pci_endpoint_test.c:530:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>>> drivers/misc/pci_endpoint_test.c:530:1: warning: parameter names (without types) in function declaration
>    drivers/misc/pci_endpoint_test.c:524:26: warning: 'pci_endpoint_test_driver' defined but not used [-Wunused-variable]
>     static struct pci_driver pci_endpoint_test_driver = {
>                              ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

This seems to be because of CONFIG_COMPILE_TEST=y. Will fix the Kconfig of
pci_endpoint_test.c.

Thanks
Kishon
