Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:37390 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754009AbdKPM02 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Nov 2017 07:26:28 -0500
Subject: =?UTF-8?Q?Re:_xhci=5fhcd_HC_died;_cleaning_up_with_TUSB7340_and_?=
 =?UTF-8?Q?=c2=b5PD720201?=
To: "Quadros, Roger" <rogerq@ti.com>
References: <BN6PR18MB124994D85EAC4B5B1AD5EC56866E0@BN6PR18MB1249.namprd18.prod.outlook.com>
 <3dd7a4fc-da86-03cc-9b01-a0d29dd73230@ti.com>
From: Vignesh R <vigneshr@ti.com>
CC: Chris Welch <Chris.Welch@viavisolutions.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Joao Pinto <jpinto@synopsys.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>
Message-ID: <f57ccfd8-0b99-278c-6c10-474395f96a3c@ti.com>
Date: Thu, 16 Nov 2017 17:56:56 +0530
MIME-Version: 1.0
In-Reply-To: <3dd7a4fc-da86-03cc-9b01-a0d29dd73230@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+linux-pci

Hi Chris,

On Thursday 16 November 2017 05:20 PM, Quadros, Roger wrote:
> +Vignesh
> 
> On 13/09/17 17:26, Chris Welch wrote:
>> We are developing a product based on the TI AM5728 EVM.  The product utilizes a TUSB7340 PCIe USB host for additional ports.  The TUSB7340 is detected and setup properly and works OK with low data rate devices.  However, hot plugging a Realtek USB network adapter and doing Ethernet transfer bandwidth testing using iperf3 causes the TUSB7340 host to be  locked out.  The TUSB7340 host appears to no longer communicate and the logging indicates xhci_hcd 0000:01:00.0: HC died; cleaning up.  Same issue occurs with another USB Ethernet adapter I tried (Asus).
>>
>> We looked at using another host and found a mini PCIe card that utilizes the µPD720201 and can be directly installed on the TI AM5728 EVM.  The card is detected properly and we reran the transfer test.  The uPD720201 gets locks out with the same problem.
>>
>> The AM5728 testing was performed using the TI SD card stock am57xx-evm-linux-04.00.00.04.img, kernel am57xx-evm 4.9.28-geed43d1050, and it reports that it is using the TI AM572x EVM Rev A3 device tree.
>>
>> It shows the following logging when it fails (this is with the TI EVM and uPD720201).
>>
>> [  630.400899] xhci_hcd 0000:01:00.0: xHCI host not responding to stop endpoint command.
>> [  630.408769] xhci_hcd 0000:01:00.0: Assuming host is dying, halting host.
>> [  630.420849] r8152 2-4:1.0 enp1s0u4: Tx status -108
>> [  630.425667] r8152 2-4:1.0 enp1s0u4: Tx status -108
>> [  630.430483] r8152 2-4:1.0 enp1s0u4: Tx status -108
>> [  630.435297] r8152 2-4:1.0 enp1s0u4: Tx status -108
>> [  630.440122] xhci_hcd 0000:01:00.0: HC died; cleaning up
>> [  630.453961] usb 2-4: USB disconnect, device number 2
>>
>> The problem appears to be a general driver issue given we get the same problem with both the  TUSB7340 and the µPD720201.

Seems like PCIe driver is missing MSI IRQs leading to stall. 
Reading xHCI registers via PCIe mem space confirms this.

I see two problems wrt MSI handling:
Since commit 8c934095fa2f3 ("PCI: dwc: Clear MSI interrupt status after it is handled, not before"),
dwc clears MSI status after calling EP's IRQ handler. But, it happens that another MSI interrupt is
raised just at the end of EP's IRQ handler and before clearing MSI status.
This will result in loss of new MSI IRQ as we clear the MSI IRQ status without handling.

Another problem appears to be wrt dra7xx PCIe wrapper:
PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI does not seem to catch MSI IRQs unless,
its ensured that PCIE_MSI_INTR0_STATUS register read returns 0.

So, could you try reverting commit 8c934095fa2f3 and 
also apply below patch and let me know if that fixes the issue?

-----------

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index e77a4ceed74c..8280abc56f30 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -259,10 +259,17 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
        u32 reg;
 
        reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
+       dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
 
        switch (reg) {
        case MSI:
-               dw_handle_msi_irq(pp);
+               /*
+                * Need to make sure no MSI IRQs are pending before
+                * exiting handler, else the wrapper will not catch new
+                * IRQs. So loop around till dw_handle_msi_irq() returns
+                * IRQ_NONE
+                */
+               while (dw_handle_msi_irq(pp) != IRQ_NONE);
                break;
        case INTA:
        case INTB:
@@ -273,8 +280,6 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
                break;
        }
 
-       dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
-
        return IRQ_HANDLED;
 }




-- 
Regards
Vignesh
