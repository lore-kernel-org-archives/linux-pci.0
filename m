Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62091C04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2893A2082D
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lyQQMzD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2893A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDJpR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:45:17 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33118 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 04:45:17 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AF09B24E0E3C;
        Tue,  4 Dec 2018 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543916716; bh=5wzy3YDkPVyg0fog6UndOfOsI6IXJrgCX7SuWA/wR4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=lyQQMzD6XW5C4byPD1mxQ8cRwQMjtjGbMue653ZrwtYNnyCPzpg5dD3ocTP5HToNB
         YyEMA2wPzHpRVume/FM9s/YTt1kFzLlozbZQAlmDFsOf7u2qqgrkl3+O5NN3w0VK6+
         7kWwhLpsr/b6OzBhknJfkXPibRORJx6t9ubPo9TIjUT6CC3quW+nvc8klBymlkVxKg
         9/9B+31ak4lNaa7HpHkJsG5nu2KjnF1Xw2GdKvxuMJTNn8U+344rz5gZyfGGzBQRiK
         iIYVur3nNr+lGlcGur/h356h+PP045w95boZawklcnTSBP7ePL7KwUdq6unGG69ZQL
         3RQp8JaDnltqw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 831B355A8;
        Tue,  4 Dec 2018 01:45:16 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 01:45:16 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:45:14 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 10:45:14 +0100
Subject: Re: [PATCH 1/3] PCI: designware: Use interrupt masking instead of
 disabling
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
 <20181113225734.8026-2-marc.zyngier@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <97c5b213-3280-1049-7c2f-2306b4b9e454@synopsys.com>
Date:   Tue, 4 Dec 2018 09:41:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113225734.8026-2-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 13/11/2018 22:57, Marc Zyngier wrote:
> The dwc driver is showing an interesting level of brokeness, as it
> insists on using the "enable" register to mask/unmask MSIs, meaning
> that an MSIs being generated while the interrupt is in that "disabled"
> state will simply be lost.
> 
> Let's move to the MASK register, which offers the expected semantics.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..c3aa8b5fb51d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -168,7 +168,7 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>  		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  		pp->irq_status[ctrl] &= ~(1 << bit);
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>  				    pp->irq_status[ctrl]);
>  	}
>  
> @@ -191,7 +191,7 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>  		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
>  		pp->irq_status[ctrl] |= 1 << bit;
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4,
> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>  				    pp->irq_status[ctrl]);
>  	}
>  
> 

I've tested this patch with the fix-up [1] some time ago, it worked fine under
stress tests with a NVMe EP (MSI-X).

[1] https://marc.info/?l=linux-pci&m=154218928401960&w=2

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
