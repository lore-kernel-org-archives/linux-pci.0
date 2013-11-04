Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:56277 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3KDBgx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Nov 2013 20:36:53 -0500
Message-ID: <5276FA23.3040402@huawei.com>
Date: Mon, 4 Nov 2013 09:36:35 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: Changes for v3.13 merge window
References: <20131101152102.GA27643@google.com>
In-Reply-To: <20131101152102.GA27643@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Yijing Wang (17):
>       PCI: Use pci_is_pcie() to simplify code
>       x86/pci: Use cached pci_dev->pcie_cap to simplify code
>       [SCSI] bfa: Use pcie_set()/get_readrq() to simplify code
>       [SCSI] csiostor: Use pcie_capability_clear_and_set_word() to simplify code
>       [SCSI] qla2xxx: Use pcie_is_pcie() to simplify code
>       powerpc/pci: Use pci_is_pcie() to simplify code

Hi Bjorn,
   Can you help update the patch "powerpc/pci: Use pci_is_pcie() to simplify code" by using the latest version v3 ?
Because Benjamin Herrenschmidt found that "cap" in this patch is stale variable after applied this patch.
Here is the link, https://patchwork.kernel.org/patch/3021121/
If necessary, I can resend it again.

Thanks very much!

>       PCI: Export pcie_set_mps() and pcie_get_mps()
>       tile/PCI: use cached pci_dev->pcie_mpss to simplify code
>       IB/qib: Use pci_is_root_bus() to check whether it is a root bus
>       IB/qib: Use pcie_set_mps() and pcie_get_mps() to simplify code
>       PCI: Update pci_find_slot() description in pci.txt
>       PCI: Remove unused "is_pcie" from pci_dev structure
>       PCI: Remove unused PCI_MSIX_FLAGS_BIRMASK definition
>       staging: et131x: Use pci_dev->pcie_mpss and pcie_set_readrq() to simplify code
>       drm/radeon: use pcie_get_readrq() and pcie_set_readrq() to simplify code
>       PCI: Add pci_dev_show_local_cpu() to simplify code
>       PCI: Fail MSI/MSI-X initialization if device is not in PCI_D0

