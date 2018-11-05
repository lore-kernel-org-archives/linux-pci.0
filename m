Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026CDC46475
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 10:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0DA2086A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 10:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0DA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeKETqO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:46:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46064 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeKETqO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 14:46:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA5AR7K7094769;
        Mon, 5 Nov 2018 04:27:07 -0600
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA5AR7SI090928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Nov 2018 04:27:07 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 5 Nov
 2018 04:27:06 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 5 Nov 2018 04:27:06 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA5AR3tL011435;
        Mon, 5 Nov 2018 04:27:04 -0600
From:   Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
Message-ID: <2e7472b5-4da1-12e8-385e-5017da2cbf33@ti.com>
Date:   Mon, 5 Nov 2018 15:58:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027000028.21343-1-tpiepho@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 27/10/18 5:30 AM, Trent Piepho wrote:
> This reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status
> after it is handled, not before").
> 
> This is a very real race that we observed quickly after switching from
> 4.13 to 4.16.  Using a custom PCI-e endpoint and driver, I was able to
> track it to the precise race and verify the fixed behavior, as will be
> described below.
> 
> This bug was originally fixed in 2013, in commit ca1658921b63 ("PCI:
> designware: Fix missing MSI IRQs") The discussion of that commit,
> archived in patchwork [1], is informative and worth reading.
> 
> The bug was re-added in the '8c934 commit this is reverting, which
> appeared in the 4.14 kernel.
> 
> Unfortunately, Synopsys appears to consider the operation of this PCI-e
> controller secret.  They provide no publicly available docs for it nor
> allow the references manuals of SoCs using the controller to publish any
> documentation of it.
> 
> So I can not say certain this code is correctly using the controller's
> features.  However, extensive testing gives me high confidence in the
> accuracy of what is described below.
> 
> If an MSI is received by the PCI-e controller while the status register
> bit for that MSI is set, the PCI-e controller will NOT generate another
> interrupt.  In addition, it will NOT queue or otherwise mark the
> interrupt as "pending", which means it will NOT generate an interrupt
> when the status bit is unmasked.
> 
> This gives the following race scenario:
> 
> 1.  An MSI is received by, and the status bit for the MSI is set in, the
> DWC PCI-e controller.
> 2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
> for the MSI received.
> 3.  At some point, the interrupt handler must decide, correctly, that
> there is no more work to do and return.
> 4.  The hardware generates a new MSI.  As the MSI's status bit is still
> set, this new MSI is ignored.
> 6.  dw_handle_msi_irq() unsets the MSI status bit.
> 
> The MSI received at point 4 will never be acted upon.  It occurred after
> the driver had finished checking the hardware status for interrupt
> conditions to act on.  Since the MSI status was masked, it does not
> generated a new IRQ, neither when it was received nor when the MSI is
> unmasked.
> 
> It seems clear there is an unsolvable race here.
> 
> After this patch, the sequence becomes as follows:
> 
> 1.  An MSI is received and the status bit for the MSI is set in the
> DWC PCI-e controller.
> 2.  dw_handle_msi_irq() clears this MSI status bit.
> 3.  dw_handle_msi_irq() calls a driver's registered interrupt handler
> for the MSI received.
> 3.  At some point, the interrupt handler must decide, correctly, that
> there is no more work to do and return.
> 4.  The hardware generates a new MSI.  This sets the MSI status bit and
> triggers another interrupt in the interrupt controller(s) above the DWC
> PCI-e controller.  As the the dwc-pcie handler is not re-entrant, it is
> not run again at this time.
> 6.  dw_handle_msi_irq() finishes.  The MSI status bit remains set.
> 7.  The IRQ is re-raised and dw_handle_msi_irq() runs again.
> 8.  dw_handle_msi_irq() invokes the MSI's registered interrupt handler
> again as the status bit was still set.
> 
> The observant will notice that point 4 present the opportunity for the
> SoC's interrupt controller to lose the interrupt in the same manner as
> the bug in this driver.  The driver for that interrupt controller will
> be written to properly deal with this.  In some cases the hardware
> supports an EOI concept, where the 2nd IRQ is masked and internally
> queued in the hardware, to be re-raised at EOI in step 7.  In other
> cases the IRQ will be unmasked and re-raised at step 4, but the kernel
> will see the handler is INPROGRESS and not re-invoke it, and instead set
> a PENDING flag, which causes the handler to re-run at step 7.
> 
> [1] https://patchwork.kernel.org/patch/3333681/
> 
> Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")
> Cc: stable@vger.kernel.org
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---


Thanks for the patch! I have observed similar race as described above
using DWC controller on DRA7xx SoCs[2]. The proposed patch and correct
handling of MSIs within controller driver helps overcome this issue. So,
for this patch:

Reviewed-by: Vignesh R <vigneshr@ti.com>


[2] https://www.spinics.net/lists/linux-pci/msg68996.html

>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..9a3960c95ad3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -98,10 +98,10 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  			irq = irq_find_mapping(pp->irq_domain,
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>  					       pos);
> -			generic_handle_irq(irq);
>  			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  						(i * MSI_REG_CTRL_BLOCK_SIZE),
>  					    4, 1 << pos);
> +			generic_handle_irq(irq);
>  			pos++;
>  		}
>  	}
> 

-- 
Regards
Vignesh
