Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF8C04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D00C2087F
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 10:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cbg4+u24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D00C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLDKUw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:20:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45922 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLDKUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 05:20:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB4AKjJA021110;
        Tue, 4 Dec 2018 04:20:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543918845;
        bh=aenBgZt0M66uWzj7TRGPoJ5YcToWEC2Y8L02226t9To=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cbg4+u24lvWEJuFR5nejOPmsUpu0NlU2hGw7zmEAwGLrz8qGb3HnBiJ+bajaEQ+Pg
         GGzBoB24AuzRHZr+55im7xahLZhBrKZhlT8J2Kyofk+G2L/IfP+czH1skF2grdXfZV
         czx4uWSIUHs73G5dbDrqlHOeCD9PTqFwKDUN05Bc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB4AKjW1046951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 04:20:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 04:20:45 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 04:20:45 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB4AKeNf022183;
        Tue, 4 Dec 2018 04:20:41 -0600
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
To:     Marc Zyngier <marc.zyngier@arm.com>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <faiz_abbas@ti.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181113225734.8026-4-marc.zyngier@arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <126f12da-b69d-ae3a-72bf-dc1bff22cd77@ti.com>
Date:   Tue, 4 Dec 2018 15:50:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-4-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14/11/18 4:27 AM, Marc Zyngier wrote:
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

This register should be written only if msi_irq_ack callback is not populated
similar to other dw_pci_bottom_*() functions.

Thanks
Kishon
