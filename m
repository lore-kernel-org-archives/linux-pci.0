Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD5C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7E62098A
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 16:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7E62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJPXwK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:52:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJPXwK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 19:52:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7848C341;
        Tue, 16 Oct 2018 09:01:04 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2756C3F71C;
        Tue, 16 Oct 2018 09:01:03 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:01:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        gustavo.pimentel@synopsys.com, cyrille.pitchen@bootlin.com
Subject: Re: [PATCH v4 3/4] PCI: cadence: Check whether MSI is masked before
 sending it
Message-ID: <20181016160100.GC16390@e107981-ln.cambridge.arm.com>
References: <1539274571-545-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539274571-545-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 05:16:11PM +0100, Alan Douglas wrote:
> The EP driver did not check the mask bit for each MSI before
> sending it in raise_irq.  This is now checked, and -EINVAL is
> returned if masked.
> 
> Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/pci/controller/pcie-cadence-ep.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index c3a0889..b762214 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -332,6 +332,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>  	if (!interrupt_num || interrupt_num > msi_count)
>  		return -EINVAL;
>  
> +	/* Check whether MSI is masked */
> +	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_MASK_64);
> +	if (data & (1 << (interrupt_num - 1)))
> +		return -EINVAL;
> +

By looking at this, I think this is wrong too. To the best of my
knowledge a masked MSI should be still delivered when the MSI is
unmasked, otherwise the condition that triggered the MSI is lost.

There must be code in the EP subsystem that records the "pending" MSI
and deliver it when the MSI is actually unmasked (I assumed this is
done in HW but I need your clarification on this).

Either that or the return value must signal a masked MSI so that the
code calling send_msi_irq() can reissue it (when though ?).

I will have to drop this patch too unless you convince me I am wrong; I
still want to understand how this code is *currently* working, I
understand that for the time being the only EP device we have is the
test one but this code path does not look very solid to me.

Thanks,
Lorenzo

>  	/* Compute the data value to be written. */
>  	data_mask = msi_count - 1;
>  	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> -- 
> 1.9.0
> 
