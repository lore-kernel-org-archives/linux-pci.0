Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB3C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CF320848
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1SxK8v9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CF320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLCSCv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:02:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42817 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeLCSCv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 13:02:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so12272213lja.9
        for <linux-pci@vger.kernel.org>; Mon, 03 Dec 2018 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=esYBHPdWSv1yRU6usljDyU3XdM+0Rnv9PF2M3eoDJjM=;
        b=C1SxK8v9uohryXxrt7z65nJVOKftRb0HDJg6FZd+pKQJ7BKxP4GAhvNnRiiHPSPpr1
         jodnJZsbIlVjW00SwHVzP6fuV4gEDWWDgjKfD66vj6MwwTnv/2wwvRhQodcKE3kCbj7B
         hFKNNykOdTHEvU7+cowGMeb35iYHAJ4l0fT6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=esYBHPdWSv1yRU6usljDyU3XdM+0Rnv9PF2M3eoDJjM=;
        b=Nrv0Maqq1GqYXfYLmMnsBRz4SWgGLLdisFRtRnIsBSK07N1140vPJi7r4O/30pgxTz
         V1K1hmqXQKfiT1qTyU4xcLhOCE+L9BAnmZwAAOARwZEcEltAJPcnkdDU+6E+eTt9Isdv
         2lW+lsE/tYH5Ue0I1rIVJdO4PcuFnn4Qv8INFsvJlImWOYzBow+DbfAlzOYaSJjdPcER
         uDtWjQZHTytdNWil7E2enxeImRrKTbU5203LW1Ad6FAw73azo5+IRjqh4iprIW9DbCYm
         aN1XchfUFxh/65M0JgQXPyLY44nCkRJC6Br50Jv8s15/U9na6i4vh1v1HEQ71eyfx7pG
         R+aA==
X-Gm-Message-State: AA+aEWZ8u6YGA4SvNeCpDEdtHMri0QlCq4bBzsV/uDjJLR5339nmHMKr
        UygMfTTlkg/Ls1PMNTufGDfn4w==
X-Google-Smtp-Source: AFSGD/XTKF5/8XmTbvs54wSM6AZC37jTxpoN5oDZPGT+1g2hMv3zPHUzCqPQxDMrvOA5IZZSUsKpTw==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr10771813lji.144.1543860163033;
        Mon, 03 Dec 2018 10:02:43 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2645441ljj.91.2018.12.03.10.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:02:42 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:02:40 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [3/3] PCI: designware: Move interrupt acking into the proper
 callback
Message-ID: <20181203180240.GC18985@centauri.lan>
References: <20181113225734.8026-4-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113225734.8026-4-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:57:34PM +0000, Marc Zyngier wrote:
> The write to the status register is really an ACK for the HW,
> and should be treated as such by the driver. Let's move it to the
> irq_ack callback, which will prevent people from moving it around
> in order to paper over other bugs.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0a76948ed49e..f06e67c60593 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>  					       pos);
>  			generic_handle_irq(irq);
> -			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
> -						(i * MSI_REG_CTRL_BLOCK_SIZE),
> -					    4, 1 << pos);
>  			pos++;
>  		}
>  	}
> @@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>  
>  static void dw_pci_bottom_ack(struct irq_data *d)
>  {
> -	struct msi_desc *msi = irq_data_get_msi_desc(d);
> -	struct pcie_port *pp;
> +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
> +	unsigned int res, bit, ctrl;
>  	unsigned long flags;
>  
> -	pp = msi_desc_to_pci_sysdata(msi);
> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
> +
>  	if (pp->ops->msi_irq_ack)
>  		pp->ops->msi_irq_ack(d->hwirq, pp);
>  

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
