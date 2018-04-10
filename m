Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:58261 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752802AbeDJNPr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Apr 2018 09:15:47 -0400
Subject: Re: [PATCH 0/4] PCI/AER: Use-after-free fix
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
CC: <Alex_Gagniuc@Dellteam.com>, Scott Bauer <scott.bauer@intel.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <557174ae-5c79-f5f2-b9cb-0fd967f602c7@huawei.com>
Date: Tue, 10 Apr 2018 21:15:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180409220444.6632-1-keith.busch@intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


ÔÚ 2018/4/10 6:04, Keith Busch Ð´µÀ:
> AER error handling walks the PCI topology below a root port, saving
> pointers of the pci_dev structs affected by the error along the way.
>
> At the same time, the pcie hotplug driver could be freeing those very
> same structures, causing the AER driver to reference freed memory.

I also have met such issue.  The details see the below link.
https://www.spinics.net/lists/linux-pci/msg70614.html
It seems do reset_link() will trigger hotplug driver to remove/rescan device
when met AER fatal error.
do_recovery()
    --- reset_link()
	--- pci_reset_secondary_bus() //then trigger link down/up.
So if the root port support hotplug, it will remove/rescan device.
I still have a question, since AER driver have already done recovery,
it seems no need to trigger hotplug to remove and rescan the device.

Thanks,
Dongdong

>
> This series fixes this by synchroniziing the aer driver with the pci
> hotplug driver during. The final patch is the one that ultimately provides
> the locking by having AER lock the same pci lock rescan/remove mutex as
> the pciehp driver. The first three patches are prepping to make it safe
> for the aer bottom half handler to hold that lock.
>
> Keith Busch (4):
>   PCI/AER: Remove unused parameters
>   PCI/AER: Replace struct pcie_device with pci_dev
>   PCI/AER: Reference count aer structures
>   PCI/AER: Lock pci topology when scanning errors
>
>  drivers/pci/pcie/aer/aerdrv.c      | 28 +++++++++++++++++++++-------
>  drivers/pci/pcie/aer/aerdrv.h      |  9 +++------
>  drivers/pci/pcie/aer/aerdrv_core.c | 38 +++++++++++++++++---------------------
>  3 files changed, 41 insertions(+), 34 deletions(-)
>
