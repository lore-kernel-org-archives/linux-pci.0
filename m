Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B425C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510E72082D
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lBfz1wQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510E72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLDJpl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:45:41 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45268 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJpl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 04:45:41 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1F6AA10C1183;
        Tue,  4 Dec 2018 01:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543916741; bh=pY2ELzUuLvqUYo9S37bDzMi7wFh8jtUfc9HTD0jOTu0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=lBfz1wQq0dALz7f6jcXjQu+p83FrOo2dSpOyXl8qjgXDY4PrFxbU+bSDfZAMa0A0b
         Fro7eaHTuu9pQZ9x9itXJXbc6x9+ZoGR85w2ruPAC5NOrOD71HE124OtCccymXEWw0
         bOzAzkRDt6JzThg0Oh+4mlji6P5L4t4hmOmIFXbi+ZHE+ldDoRctyLsO/em4M+jPx5
         Z/0mIe6KMky0koe5YZKbjVw4ekpJLISZrRtO7m9SDDHwGjS45raHUxCSz49G9eWyNz
         zecLagk+5Gcq7Om4l8DamLV3PVtodGLuZgs+29mUPOSEw3oOCo5W356/9NW5epCZrl
         6LZ4DYqSPj+WA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 037EE571F;
        Tue,  4 Dec 2018 01:45:41 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 01:45:41 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:45:38 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:45:38 +0100
Subject: Re: [PATCH 2/3] PCI: designware: Take lock when ACKing an interrupt
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
 <20181113225734.8026-3-marc.zyngier@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <64c3b3da-7589-956f-74a6-19bbeef696d3@synopsys.com>
Date:   Tue, 4 Dec 2018 09:41:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-3-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/11/2018 22:57, Marc Zyngier wrote:
> Bizarrely, there is no lock taken in the irq_ack helper. This
> puts the ack callback provided by a specific platform in a awkward
> situation where there is no synchronization that would be expected
> on other callback.
> 
> Introduce the required lock, giving some level of uniformity among
> callbacks.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c3aa8b5fb51d..0a76948ed49e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -202,11 +202,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>  {
>  	struct msi_desc *msi = irq_data_get_msi_desc(d);
>  	struct pcie_port *pp;
> +	unsigned long flags;
>  
>  	pp = msi_desc_to_pci_sysdata(msi);
>  
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
>  	if (pp->ops->msi_irq_ack)
>  		pp->ops->msi_irq_ack(d->hwirq, pp);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
>  static struct irq_chip dw_pci_msi_bottom_irq_chip = {
> 

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
