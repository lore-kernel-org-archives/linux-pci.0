Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7624C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFDC205F4
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 21:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHrNtYmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFDC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPFRj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbeJPFRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 01:17:38 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7831205F4;
        Mon, 15 Oct 2018 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539639036;
        bh=RlBszQEIkX/CoCcex3tfYbvj5j69MLzqxC6fHeN8By4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHrNtYmHKfQ5OFnQM501vH6yzEdtmv6alYKjjymBZ2bNDdWz4oqLHw7e46+AWz2cp
         xhfe63HB+VpgMQdbeQLEb28vb4uf4R2gtGBCLHag8GdAKPExoRfG8FrJPdnGSS0FNJ
         /CE1PyiMQqJ3skQ9UqBt8qoOZCEP1WTdC/ObC9as=
Date:   Mon, 15 Oct 2018 16:30:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     lorenzo.pieralisi@arm.com, kishon@ti.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        cyrille.pitchen@bootlin.com
Subject: Re: [PATCH v4 4/4] PCI: cadence: Check link is up before sending IRQ
 from EP
Message-ID: <20181015213034.GF5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539274617-1661-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539274617-1661-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 05:16:57PM +0100, Alan Douglas wrote:
> If EP attempts to send an IRQ (legacy, MSI or MSI-X) while the
> link is not up, return -EINVAL
> 
> Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  drivers/pci/controller/pcie-cadence-ep.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index b762214..3667d70 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -370,6 +370,12 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
>  				  u16 interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	u32 link_status;
> +
> +	/* Can't send an IRQ if the link is down. */
> +	link_status = cdns_pcie_readl(&ep->pcie, CDNS_PCIE_LM_BASE);
> +	if (!(link_status & 0x1))
> +		return -EINVAL;

This looks racy.  What happens if the link goes down right after the
CDNS_PCIE_LM_BASE read, but before we get here?

>  	switch (type) {
>  	case PCI_EPC_IRQ_LEGACY:
> -- 
> 1.9.0
> 
