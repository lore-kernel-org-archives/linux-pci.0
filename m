Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE8C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A320869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 14:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285A320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeKFXuY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:50:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388702AbeKFXuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 18:50:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6809980D;
        Tue,  6 Nov 2018 06:24:56 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F1633F5BD;
        Tue,  6 Nov 2018 06:24:55 -0800 (PST)
Date:   Tue, 6 Nov 2018 14:24:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2] PCI: mobiveil: fix multi function endpoint failures
Message-ID: <20181106142449.GA19060@e107981-ln.cambridge.arm.com>
References: <1541422301-29176-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <1541422301-29176-2-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541422301-29176-2-git-send-email-l.subrahmanya@mobiveil.co.in>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 05, 2018 at 07:51:41AM -0500, Subrahmanya Lingappa wrote:
> The fix enables mobiveil pcie controller to detect more than one
> functions per device. Also increases the MSI interrupts.

1 patch, 1 logical change, you are making 1 patch 2 logical changes,
split the patch in two and repost them please.

I will consider patch v1 obsolete too, no idea why it was posted.

Lorenzo

> Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver")
> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 4d6c20e..113d56a 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -89,7 +89,7 @@
>  #define PAB_INTX_START	5
>  
>  /* supported number of MSI interrupts */
> -#define PCI_NUM_MSI	16
> +#define PCI_NUM_MSI	256
>  
>  /* MSI registers */
>  #define MSI_BASE_LO_OFFSET	0x04
> @@ -172,7 +172,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>  	 * Do not read more than one device on the bus directly
>  	 * attached to RC
>  	 */
> -	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
> +	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
>  		return false;
>  
>  	return true;
> -- 
> 1.8.3.1
> 
