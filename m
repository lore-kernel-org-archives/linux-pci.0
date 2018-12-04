Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691FC04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39B82082D
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Aac+Ff1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39B82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeLDJqP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:46:15 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:45308 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 04:46:15 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DAFD710C1106;
        Tue,  4 Dec 2018 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543916774; bh=ynHZ+A35WLK6NMr+tfXzar0m2pN0d7FN5+9avIvfRnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Aac+Ff1IX2V3l1cf1EsPaGiG0iKr1aIfQebUCOwmpn0hUMk0csKAfhQnuXIU/vf6s
         YtKVthNyHF6FMMBJ+7NC8gv5o8ms8ww2FrWHRGW5LViUgcdGNGNSL1VX1zcp0z6Fam
         ClV+WYlE2jrAw/9KuMZp64Q3wCx9E0kSdd93wDMS8nNJepUjSlHljhK7f0wsYyRZl1
         aYA+NTjfzS/yEE97UtPTcSKDIjP71Lafv08WPPhUtQic4NSQ9BzlRiNGccxTU6wUmf
         B1lrNdbJXu1/ZzD1Ldprsked+LSmryEcH0oCMNBorL7Ow0+t7Z8vx6eMVGfwwuMW9l
         RQA+vIfroQJ6Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C0F7058A1;
        Tue,  4 Dec 2018 01:46:14 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 01:46:14 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:46:12 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:46:12 +0100
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181113225734.8026-4-marc.zyngier@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f7d9fe11-deec-5ba3-aee2-e14093b94a2e@synopsys.com>
Date:   Tue, 4 Dec 2018 09:41:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-4-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/11/2018 22:57, Marc Zyngier wrote:
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
> 

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
