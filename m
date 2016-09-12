Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbcILVzz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:55:55 -0400
Date: Mon, 12 Sep 2016 16:55:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH v4 0/2] PCI: altera: Retrain link in rootport mode only
Message-ID: <20160912215549.GE23532@localhost>
References: <1472176045-27815-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472176045-27815-1-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 26, 2016 at 09:47:23AM +0800, Ley Foon Tan wrote:
> Altera PCIe IP can be configured as rootport or device and they might have
> same vendor ID. It will cause the system hang issue if Altera PCIe is in
> endpoint mode and work with other PCIe rootport that from other vendors.
> 
> This series of patch rework configs accessors and move retrain function
> from _FIXUP to altera_pcie_host_init().
> 
> History:
> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
> v3: Move retrain function to before pci_scan_root_bus and remove _FIXUP
> v4: Split patch to 2 patches
> 
> Ley Foon Tan (2):
>   PCI: altera: Rework configs accessors
>   PCI: altera: Move retrain from _FIXUP to altera_pcie_host_init()
> 
>  drivers/pci/host/pcie-altera.c | 215 +++++++++++++++++++++++++----------------
>  1 file changed, 132 insertions(+), 83 deletions(-)

Applied to pci/host-altera for v4.9, thanks!
