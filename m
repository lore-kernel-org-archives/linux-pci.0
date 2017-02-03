Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752441AbdBCVEI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 16:04:08 -0500
Date: Fri, 3 Feb 2017 15:04:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH 0/3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
Message-ID: <20170203210405.GB24162@bhelgaas-glaptop.roam.corp.google.com>
References: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484202504-96686-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 02:28:21PM +0800, Dongdong Liu wrote:
> The PCIe controller in Hip06/Hip07 SoCs is not completely
> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> any other bus underneath the root bus it does support ECAM access.
> 
> This series contains
> 1. Add the almost ECAM support in DT way. 
> 2. Add quirk to set root port pdev->no_msi = 1. 
> 3. Add condition #ifndef CONFIG_ARM64 for pci_fixup_irqs.
> 
> This patchset is based on 4.10-rc3.
> 
> Dongdong Liu (3):
>   PCI:hisi: Add DT almost ECAM support for HiSilicon Hip06/Hip07 host
>     controllers
>   PCI: Set pdev->no_msi=1 for HiSilicon Hip06/Hip07 host controllers
>   PCI: generic: Fix the bug of pci_fixup_irqs() for arm64 platform.
> 
>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 37 +++++++++++++++
>  drivers/pci/host/pci-host-common.c                 |  2 +
>  drivers/pci/host/pcie-hisi.c                       | 54 ++++++++++++++++++++--
>  drivers/pci/quirks.c                               |  1 +
>  include/linux/pci_ids.h                            |  3 ++
>  5 files changed, 94 insertions(+), 3 deletions(-)

Current state: I applied the "no MSI" patch on pci/host-hisi and
dropped the other two for now.  If you could update those and repost
them, that'd be great.
