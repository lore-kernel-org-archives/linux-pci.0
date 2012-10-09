Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:31659 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab2JIDoI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 23:44:08 -0400
Message-ID: <50739D40.8040005@huawei.com>
Date: Tue, 9 Oct 2012 11:42:56 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/7] disable bridge ari forwarding after connected ari
 device hot removed
References: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1349751804-7476-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

How about this patch, which disables ARI when adding new PCI devices?
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5485883..c841aa6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2016,13 +2016,14 @@ void pci_free_cap_save_buffers(struct pci_dev *dev)
 void pci_enable_ari(struct pci_dev *dev)
 {
        u32 cap;
+       bool enable = true;
        struct pci_dev *bridge;

        if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
                return;

        if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI))
-               return;
+               enable = false;

        bridge = dev->bus->self;
        if (!bridge)
@@ -2032,8 +2033,15 @@ void pci_enable_ari(struct pci_dev *dev)
        if (!(cap & PCI_EXP_DEVCAP2_ARI))
                return;

-       pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
-       bridge->ari_enabled = 1;
+       if (enable) {
+               pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+                                        PCI_EXP_DEVCTL2_ARI);
+               bridge->ari_enabled = 1;
+       } else {
+               pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
+                                        PCI_EXP_DEVCTL2_ARI);
+               bridge->ari_enabled = 0;
+       }
 }

 /**

On 2012-10-9 11:03, Yijing Wang wrote:
> pci_enable_ari will be called if an ARI pci device found, then set its bridge ARI Forwarding Enable
> bit in Device Control 2 Register. But the bridge ARI Forwarding Enable bit will never be cleared
> when an ARI device hot removed.
> 
> my steps:
> 1. Hot add an ARI pci device;
> 2. Hot remove the ARI pci device;
> 3. Hot add an non ARI pci device;
> 
> In this case, after setp 3, we could only find fun 0 of non ARI pci device because of its bridge ARI Forwarding Enable
> bit set.
> 
> As PCIe Spec 2.0(6.13/441) recommends:
> "Following a hot-plug event below a Downstream Port, it is strongly recommended that software
> Clear the ARI Forwarding Enable bit in the Downstream Port until software determines that a
> newly added component is in fact an ARI Device"
> 
> This series of patches fix this problem.
> 
> Yijing Wang (7):
>   PCI: rework pci_enable_ari for support disable ari forwarding
>   PCI, acpiphp: disable ARI forwarding for acpiphp
>   PCI, pciehp: disable ARI forwarding for pciehp
>   PCI, cpqphp: disable ARI forwarding for cpqphp
>   PCI, shpchp: disable ARI forwarding for shpchp
>   PCI, sgi: disable ARI forwarding for sgiphp
>   PCI, ibmphp: disable ARI forwarding for ibmphp
> 
>  drivers/pci/hotplug/acpiphp_glue.c     |    1 +
>  drivers/pci/hotplug/cpci_hotplug_pci.c |    1 +
>  drivers/pci/hotplug/cpqphp_pci.c       |    1 +
>  drivers/pci/hotplug/ibmphp_core.c      |    1 +
>  drivers/pci/hotplug/pciehp_pci.c       |    1 +
>  drivers/pci/hotplug/sgi_hotplug.c      |    1 +
>  drivers/pci/hotplug/shpchp_pci.c       |    1 +
>  drivers/pci/pci.c                      |   16 +++++++++++-----
>  drivers/pci/pci.h                      |    2 +-
>  drivers/pci/probe.c                    |    2 +-
>  10 files changed, 20 insertions(+), 7 deletions(-)
> 
> 
> 
> .
> 


