Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3AC10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB2020854
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="hxxdOr8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCRKgn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:36:43 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53652 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCRKgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 06:36:43 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D875D25B80E;
        Mon, 18 Mar 2019 21:36:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552905401; bh=BmuavvgZlMuREJ0DY/54svKrJ/ohB7PoDn/Y0cF0pq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxxdOr8T/07IkffFown+MSpdz3xs8DhwEqI8mNVUV5OYVU9iDXdB04gXMvsPLaY8E
         KT871azGUREYmk3GZ7yZiWlMpSxLPyArfRvZ73Ck6cvfiRcpv9YsOdbq6AVS7VWNot
         aQPjvcBwsu32i0DRB31Fq4beZy/hkzJMIOEwzrXc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id F0CBF9406ED; Mon, 18 Mar 2019 11:36:38 +0100 (CET)
Date:   Mon, 18 Mar 2019 11:36:38 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH] PCI: rcar: don't shadow the 'irq' variable
Message-ID: <20190318103638.xjrxzoaf3yeqop72@verge.net.au>
References: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 10:34:45AM +0100, Wolfram Sang wrote:
> sparse rightfully says:
> drivers/pci/controller/pcie-rcar.c:741:30: warning: symbol 'irq' shadows an earlier one
> 
> It doesn't affect the current code. But fix it now to avoid future
> surprises and for good coding style.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Only build tested.
> 
>  drivers/pci/controller/pcie-rcar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 7002e9ad0b81..f513058e3a70 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -738,15 +738,15 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
>  
>  	while (reg) {
>  		unsigned int index = find_first_bit(&reg, 32);
> -		unsigned int irq;
> +		unsigned int msi_irq;
>  
>  		/* clear the interrupt */
>  		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
>  
> -		irq = irq_find_mapping(msi->domain, index);
> -		if (irq) {
> +		msi_irq = irq_find_mapping(msi->domain, index);
> +		if (msi_irq) {
>  			if (test_bit(index, msi->used))
> -				generic_handle_irq(irq);
> +				generic_handle_irq(msi_irq);
>  			else
>  				dev_info(dev, "unhandled MSI\n");
>  		} else {
> -- 
> 2.19.1
> 
