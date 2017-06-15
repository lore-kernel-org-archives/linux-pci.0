Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:46715 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdFOH3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2017 03:29:04 -0400
Subject: Re: [PATCH v2] PCI: dwc: dra7xx: Fix compilation warning.
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, <bhelgaas@google.com>
References: <673ccda2e1a722fa1b511a9c3bf1af6fbfc262a3.1497507582.git.arvind.yadav.cs@gmail.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2de7127a-78c3-36dc-fa74-5d29e15fc64c@ti.com>
Date: Thu, 15 Jun 2017 12:58:24 +0530
MIME-Version: 1.0
In-Reply-To: <673ccda2e1a722fa1b511a9c3bf1af6fbfc262a3.1497507582.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 15 June 2017 11:52 AM, Arvind Yadav wrote:
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~LEG_EP_INTERRUPTS & ~MSI);
>        ^
> drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
> drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>        ~INTERRUPTS);

Er.. actually both PCIECTRL_TI_CONF_IRQSTATUS_MSI and
PCIECTRL_TI_CONF_IRQSTATUS_MAIN are "write 1 to clear" registers. So writing
'0' here means no action.

So the right fix should be

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 8decf46cf525..aab0187cdf87 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -174,7 +174,7 @@ static int dra7xx_pcie_establish_link(struct dw_pcie *pci)
 static void dra7xx_pcie_enable_msi_interrupts(struct dra7xx_pcie *dra7xx)
 {
        dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
-                          ~LEG_EP_INTERRUPTS & ~MSI);
+                          MSI | LEG_EP_INTERRUPTS);

        dra7xx_pcie_writel(dra7xx,
                           PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
@@ -184,7 +184,7 @@ static void dra7xx_pcie_enable_msi_interrupts(struct
dra7xx_pcie *dra7xx)
 static void dra7xx_pcie_enable_wrapper_interrupts(struct dra7xx_pcie *dra7xx)
 {
        dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN,
-                          ~INTERRUPTS);
+                          INTERRUPTS);
        dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN,
                           INTERRUPTS);
 }
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Changes in v2:
>              Add casts in the definitions.

please move the change log below "---"

Thanks
Kishon
