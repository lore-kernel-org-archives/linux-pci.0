Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49555 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765152AbcINUrD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 16:47:03 -0400
Date: Wed, 14 Sep 2016 14:47:02 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [pci:pci/host-vmd 2/4] arch/x86/pci/vmd.c:674:6: error:
 'PCI_IRQ_MSIX' undeclared
Message-ID: <20160914204701.GA1591@localhost.localdomain>
References: <201609150417.nlp7t2XD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201609150417.nlp7t2XD%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fortunately these symbols are resolved as of v4.8-rc4


On Thu, Sep 15, 2016 at 04:41:20AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-vmd
> head:   e8debf9c6734726d4fcc5aae5bee48e5e2fcc9c6
> commit: b500e7733fd77bd282caf2f218f2d281c4bdb202 [2/4] x86/PCI: VMD: Convert to use pci_alloc_irq_vectors() API
> config: i386-randconfig-x014-201637 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         git checkout b500e7733fd77bd282caf2f218f2d281c4bdb202
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/pci/vmd.c: In function 'vmd_probe':
> >> arch/x86/pci/vmd.c:674:6: error: 'PCI_IRQ_MSIX' undeclared (first use in this function)
>          PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
>          ^~~~~~~~~~~~
>    arch/x86/pci/vmd.c:674:6: note: each undeclared identifier is reported only once for each function it appears in
> >> arch/x86/pci/vmd.c:674:21: error: 'PCI_IRQ_AFFINITY' undeclared (first use in this function)
>          PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
>                         ^~~~~~~~~~~~~~~~
> 
> vim +/PCI_IRQ_MSIX +674 arch/x86/pci/vmd.c
> 
>    668	
>    669		vmd->msix_count = pci_msix_vec_count(dev);
>    670		if (vmd->msix_count < 0)
>    671			return -ENODEV;
>    672	
>    673		vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
>  > 674						PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
>    675		if (vmd->msix_count < 0)
>    676			return vmd->msix_count;
>    677	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


