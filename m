Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970297AbdDTPLD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Apr 2017 11:11:03 -0400
Date: Thu, 20 Apr 2017 11:20:12 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: bhelgaas@google.com, jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc/host: Mark PCIe/PCI (MSI) cascade ISR as
 IRQF_NO_THREAD
Message-ID: <20170420152011.GC21311@localhost.localdomain>
References: <20170420102718.3778-1-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420102718.3778-1-jszhang@marvell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 06:27:18PM +0800, Jisheng Zhang wrote:
> Similar as commit 8ff0ef996ca0 ("PCI: host: Mark PCIe/PCI (MSI) IRQ
> cascade handlers as IRQF_NO_THREAD"), we should mark PCIe/PCI (MSI)
> IRQ cascade handlers IRQF_NO_THREAD explicitly. I just found this
> issue in pcie-designware-plat driver, then searched the code, I think
> we should fix pcie-qcom and vmd as well.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/dwc/pcie-designware-plat.c | 3 ++-
>  drivers/pci/dwc/pcie-qcom.c            | 3 ++-
>  drivers/pci/host/vmd.c                 | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Okay for vmd driver.

Reviewed-by: Keith Busch <keith.busch@intel.com>
