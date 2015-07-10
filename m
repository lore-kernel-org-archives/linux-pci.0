Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:20892 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbGJBmC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 21:42:02 -0400
Message-ID: <559F22D7.8090402@huawei.com>
Date: Fri, 10 Jul 2015 09:41:43 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	"Borislav Petkov" <bp@alien8.de>
CC: Tony Luck <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC Patch V1 00/12] Reorganize struct msi_desc to prepare for
 support of generic MSI
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/7/9 16:00, Jiang Liu wrote:
> Recently Marc Zyngier <marc.zyngier@arm.com> has posted a patch set at
> https://lkml.org/lkml/2015/7/7/712
> to enhance PCI MSI code to support generic MSI.
> 
> This is a companion patch set to refine struct msi_desc and related data
> structures to support generic MSI, and it would be better to combined with
> Marc's patch set.  It's also requested by
> Stuart Yoder <stuart.yoder@freescale.com>
> 
> It first introduces a helper function msi_desc_to_pci_sysdata(), and
> convert current PCI drivers to use helper functions to access fields
> in struct msi_desc.
> Then it moves msi_list from struct pci_dev into struct device and
> refines struct msi_desc.
> At last it moves alloc_msi_entry() into kernel/irq/msi.c for reuse.
> 
> Currently msi_desc_to_pci_sysdata() and msi_desc_to_pci_dev() are
> implemented as normal functions instead of inlines to avoid header file
> inclusion issue. If inlined version is preferred for performance, we could
> move all of first_pci_msi_entry, for_each_pci_msi_entry, msi_desc_to_pci_dev
> and msi_desc_to_pci_sysdata from linxu/kernel/msi.h into linux/kernel/pci.h.
> 
> This patch set is based on v4.2-rc1 and passes 0day test suite. You
> may access the code at:
> https://github.com/jiangliu/linux.git msi_desc_v1
> 
> Thanks!
> Gerry
> 
> Jiang Liu (12):
>   PCI: Add helper function msi_desc_to_pci_sysdata()
>   MIPS, PCI: Use for_pci_msi_entry() to access MSI device list
>   PowerPC, PCI: Use for_pci_msi_entry() to access MSI device list
>   s390/pci: Use for_pci_msi_entry() to access MSI device list
>   x86, PCI: Use for_pci_msi_entry() to access MSI device list
>   PCI: Use for_pci_msi_entry() to access MSI device list
>   sparc, PCI: Use helper functions to access fields in struct msi_desc
>   PCI: Use helper functions to access fields in struct msi_desc
>   genirq: Move msi_list from struct pci_dev to struct device
>   genirq, PCI: Store 'struct device *' instead 'struct pci_dev *' in
>     struct msi_desc
>   genirq, PCI: Reorginize struct msi_desc to prepare for support of
>     generic MSI
>   genirq, PCI: Move alloc_msi_entry() from PCI MSI code into generic
>     MSI code

Great, it loos good to me, for patch 1,6,8,9,10,11,12, Reviewed-by: Yijing Wang <wangyijing@huawei.com>

> 
>  arch/mips/pci/msi-octeon.c             |    2 +-
>  arch/powerpc/platforms/cell/axon_msi.c |    6 +--
>  arch/powerpc/platforms/pasemi/msi.c    |    4 +-
>  arch/powerpc/platforms/powernv/pci.c   |    4 +-
>  arch/powerpc/platforms/pseries/msi.c   |    6 +--
>  arch/powerpc/sysdev/fsl_msi.c          |    4 +-
>  arch/powerpc/sysdev/mpic_u3msi.c       |    4 +-
>  arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |    4 +-
>  arch/powerpc/sysdev/ppc4xx_msi.c       |    4 +-
>  arch/s390/pci/pci.c                    |    6 +--
>  arch/sparc/kernel/pci.c                |    2 +-
>  arch/x86/pci/xen.c                     |    8 ++--
>  drivers/base/core.c                    |    3 ++
>  drivers/pci/host/pci-keystone-dw.c     |    6 +--
>  drivers/pci/host/pcie-designware.c     |    4 +-
>  drivers/pci/host/pcie-xilinx.c         |   12 ++---
>  drivers/pci/msi.c                      |   82 +++++++++++++++++---------------
>  drivers/pci/xen-pcifront.c             |    2 +-
>  include/linux/device.h                 |    4 ++
>  include/linux/msi.h                    |   55 +++++++++++----------
>  include/linux/pci.h                    |    1 -
>  kernel/irq/msi.c                       |   17 +++++++
>  22 files changed, 136 insertions(+), 104 deletions(-)
> 


-- 
Thanks!
Yijing

