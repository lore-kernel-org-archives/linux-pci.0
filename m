Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F0FC0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB86720819
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jj7pMnCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB86720819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeKEVbk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:31:40 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59590 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 16:31:40 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 42D2024E1292;
        Mon,  5 Nov 2018 04:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541419933; bh=Gy07hkLdoQGtHMrwkZ7eIMaOnmU74TyfhO8Vn9kBgAw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jj7pMnCKUNhMjxb7WDQ9AMNHfVz26p7tKjGwxBhZVb7T67OKtxGRxJa6uWPDgjxUG
         gPMi9lpfX9SZl8LC2HxRLS76z2QGAf7U1ESJSlzN4PRKoKrJUSOHurjtaoIBotM8YX
         IvLFRBtICpoWKely4d2u2H535tDOs1AgjDGfhW3Ld3DrLoa605uPdtiNx4Mq0/uNtH
         L1FU7LH6715CsCvVmQ7/bTcoeXYcNe9IATgScuKbptOcLzAH23Eo1BViNUfY93CtU9
         A9jyi/++qdzKxCTMAvd6h1T5g9oxrvCq9ibARS8uv/Jb01Nc7piW4UpOxMylEC7pNz
         YRnyU6WDyIKhA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id F13D63834;
        Mon,  5 Nov 2018 04:12:12 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 04:12:12 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:12:11 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:12:11 +0100
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <fbc29901-a98b-7392-3ca5-6e1b4e324105@synopsys.com>
Date:   Mon, 5 Nov 2018 12:08:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027000028.21343-1-tpiepho@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/10/2018 01:00, Trent Piepho wrote:
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
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_3333681_&d=DwIFAw&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=ZglJ52030-QSg4t06j182Uq9rsDcKNSB0P7q7Cx5Ow8&s=sHHaXL5syvT5Y0WGTVohW_3QqpQgnPTPOQ-HxAmvnb0&e=
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

Makes sense.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

>  			pos++;
>  		}
>  	}
> 

