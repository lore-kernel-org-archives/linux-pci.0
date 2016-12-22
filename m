Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965954AbcLVV2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Dec 2016 16:28:34 -0500
Date: Thu, 22 Dec 2016 15:28:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>, zhangzhihai@hisilicon.com,
        jiashi.lin@hisilicon.com
Subject: Re: Help about MSI support in PCI Express Bus support driver
Message-ID: <20161222212829.GB16855@bhelgaas-glaptop.roam.corp.google.com>
References: <585B9411.7050006@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <585B9411.7050006@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 22, 2016 at 04:51:29PM +0800, Zhou Wang wrote:
> Hi All,
> 
> I have noticed that MSI support in PCI Express Bus support driver does not match
> with the PCIe spec.
> 
> In function init_service_irqs, we get interrupts of all PCIe port services.
> We only use one MSI for all the PCIe port services, which does not match with
> PCIe3.0 spec.
> 
> Interrupt Message Number bits are used to indicate which MSI vector will be used
> for a PCIe port service. The related definitions can be found in 6.2.4.1.2 for AER,
> 6.7.3.4 for hotplug, 6.2.10.1 for DPC, 6.1.6 for PME.
> 
> So do we have a plan to fix this feature? just like what we did in pcie_port_enable_msix.

I do not know of any plans for fixes here.  If it's broken, it'd be
great if you fixed it!

Bjorn
