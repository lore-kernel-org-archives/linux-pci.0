Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FEC32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 14:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D1C2085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 14:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJKVrr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:47:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38238 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeJKVrr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 17:47:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A16CEBD;
        Thu, 11 Oct 2018 07:20:23 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831E73F5B3;
        Thu, 11 Oct 2018 07:20:22 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:20:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI:mobiveil: fix multi function endpoint failures
Message-ID: <20181011142019.GB7241@e107981-ln.cambridge.arm.com>
References: <1539083325-7333-1-git-send-email-l.subrahmanya@mobiveil.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539083325-7333-1-git-send-email-l.subrahmanya@mobiveil.co.in>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 09, 2018 at 07:08:45AM -0400, Subrahmanya Lingappa wrote:
> The fix enables mobiveil pcie controller to detect more than one
> functions per device.

Please read:

https://marc.info/?l=linux-pci&m=150905742808166&w=2

and use it as a checklist.

Please run:

git log --oneline drivers/pci/controller/pcie-mobiveil.c

Check the result and compare it to your patch $SUBJECT, you will
notice that this patch style differs so rewrite the $SUBJECT accordingly.

Please add a Fixes: tag to define what commit you are fixing.

Thanks,
Lorenzo

> Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a939e8d3..9acb81a 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -174,7 +174,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
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
