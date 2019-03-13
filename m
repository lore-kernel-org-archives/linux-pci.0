Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD622C4360F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFDD2171F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FosqpDgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCMKFe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:05:34 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:34908 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMKFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 06:05:34 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id BA6E010C1E4D;
        Wed, 13 Mar 2019 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552471533; bh=Z+xGZYnutxceKMnuby8zql687TXvUYPRaNKAXZ01Y6g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=FosqpDgxeKrSY29WtJoqACzFROVzFVlYv4Joq1OYq3u74vavqCOi/Z3yTd/pZpOga
         NzJmH2T6KSFVwiN0b00IWy/KjG0MDpMNraH7+o3tiDgSVwibWl/Kca/yLOX5PuCB+e
         rEmvNYTTrfA/8nJdNX6wP35xe4qHUa1lTiyQsvufwhfAkVskRs+730dJQXTxVyK/uL
         ChzBEtcayStLh0ACIotW+0JUGx/kM7DZqk+qcadha2aHJtJr+fE0HVjIWsRp1gOuFT
         vt+7Sfg5E4emPukNlaSrSk2plnQXpF8zz2ixXVmce4qcKrj0dSfUIpnlQpp0soTHGw
         BZ3NP8so/EjDQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 57B52A0067;
        Wed, 13 Mar 2019 10:05:28 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 03:05:28 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:05:26 +0100
Received: from [10.107.19.55] (10.107.19.55) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:05:25 +0100
Subject: Re: [PATCH v2 1/5] PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is
 invalid
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190301125510.4e2ee985@xhacker.debian>
 <20190301125625.4e15d869@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <8a0bda6b-6879-e4ac-cfe6-171abbd72abd@synopsys.com>
Date:   Wed, 13 Mar 2019 10:05:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301125625.4e15d869@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.55]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/03/2019 05:03, Jisheng Zhang wrote:
> We should check msi_irq before calling irq_set_chained_handler() and
> irq_set_handler_data().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0c18ab63811f..a94d3530b694 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -298,8 +298,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	irq_set_chained_handler(pp->msi_irq, NULL);
> -	irq_set_handler_data(pp->msi_irq, NULL);
> +	if (pp->msi_irq) {
> +		irq_set_chained_handler(pp->msi_irq, NULL);
> +		irq_set_handler_data(pp->msi_irq, NULL);
> +	}
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> 

Sounds good.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
