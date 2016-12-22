Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:27423 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbcLVIxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2016 03:53:14 -0500
To: <linux-pci@vger.kernel.org>
CC: <gabriele.paoloni@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>, <zhangzhihai@hisilicon.com>,
        <jiashi.lin@hisilicon.com>, <wangzhou1@hisilicon.com>
From: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Help about MSI support in PCI Express Bus support driver
Message-ID: <585B9411.7050006@hisilicon.com>
Date: Thu, 22 Dec 2016 16:51:29 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

I have noticed that MSI support in PCI Express Bus support driver does not match
with the PCIe spec.

In function init_service_irqs, we get interrupts of all PCIe port services.
We only use one MSI for all the PCIe port services, which does not match with
PCIe3.0 spec.

Interrupt Message Number bits are used to indicate which MSI vector will be used
for a PCIe port service. The related definitions can be found in 6.2.4.1.2 for AER,
6.7.3.4 for hotplug, 6.2.10.1 for DPC, 6.1.6 for PME.

So do we have a plan to fix this feature? just like what we did in pcie_port_enable_msix.
Please let me know if I missed something.

It will be very appreciated if anyone can share ideas about this problem!

Thanks,
Zhou

