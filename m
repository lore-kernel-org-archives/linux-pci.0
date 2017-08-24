Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdHXQcK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 12:32:10 -0400
Date: Thu, 24 Aug 2017 11:32:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, keith.busch@intel.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V5 0/2] PCI/DPC: Add eDPC support
Message-ID: <20170824163207.GF31858@bhelgaas-glaptop.roam.corp.google.com>
References: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 19, 2017 at 05:07:19PM +0800, Dongdong Liu wrote:
> This patchset is to add eDPC support and use a local
> "struct device *dev" for brevity and consistency in DPC driver.
> 
> v4->v5:
> - Fix some compile warnings.
> 
> v3->v4:
> - Use pcie_device's device to keep consistency.
> - Adjust patch sequence.
>  
> v2->v3: 
> - Add a separate patch to use a local "struct device *dev" 
>   for brevity and consistency in  DPC driver.
> - Fix comments on PATCH V2.
> - Rebase on v4.13-rc5.
> 
> v1->v2: 
> - Use a stack local variable instead of the allocated memory for
>   collecting RP PIO information.
> - Fix the condition of RP PIO error.
> - Rebase on v4.13-rc1.
> 
> Dongdong Liu (2):
>   PCI/DPC: Add eDPC support
>   PCI/DPC: Add local struct device
> 
>  drivers/pci/pcie/pcie-dpc.c   | 187 +++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h |  10 +++
>  2 files changed, 187 insertions(+), 10 deletions(-)

Applied with Keith's reviewed-by to pci/dpc for v4.14, thanks!
