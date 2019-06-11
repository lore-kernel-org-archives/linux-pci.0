Return-Path: <SRS0=+3kZ=UK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD6DC43218
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 10:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4853B2089E
	for <linux-pci@archiver.kernel.org>; Tue, 11 Jun 2019 10:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbfFKKHs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:07:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404406AbfFKKHs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 06:07:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D65337;
        Tue, 11 Jun 2019 03:07:47 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0681F3F557;
        Tue, 11 Jun 2019 03:09:28 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:07:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v2] PCI: endpoint: Set endpoint controller pointer to null
Message-ID: <20190611100742.GA29976@redmoon>
References: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558647944-13816-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 23, 2019 at 02:45:44PM -0700, Alan Mikhak wrote:
> Set endpoint controller pointer to null in pci_epc_remove_epf()
> to avoid -EBUSY on subsequent call to pci_epc_add_epf().
> 
> Requires checking for null endpoint function pointer.
> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to pci/endpoint for v5.3, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index e4712a0f249c..2091508c1620 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>  {
>  	unsigned long flags;
>  
> -	if (!epc || IS_ERR(epc))
> +	if (!epc || IS_ERR(epc) || !epf)
>  		return;
>  
>  	spin_lock_irqsave(&epc->lock, flags);
>  	list_del(&epf->list);
> +	epf->epc = NULL;
>  	spin_unlock_irqrestore(&epc->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> -- 
> 2.7.4
> 
