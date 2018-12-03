Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989AC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACC920848
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfQ1kvgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACC920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLCSCh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:02:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44871 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLCSCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 13:02:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so9844041lfe.11
        for <linux-pci@vger.kernel.org>; Mon, 03 Dec 2018 10:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYvxO9p507wSPGCcHvooIMBby45TxxFYFmotJsbbWXU=;
        b=ZfQ1kvguIspXlF9TdA7b8ZXpbzOBh5kmxyUoMIriJxRV5abDoTsVMkREcNsJCExBfV
         zp4b5FRX0mnVDcJCu/3Gu7QKpcDfPAW8pSiaFA+pmG1eiuNG23aUhggLKg8DuTBBYy6F
         8Iq+IYGgJ4B4kZm/Z8Ld/8Nr8MEIM8B4U0n2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYvxO9p507wSPGCcHvooIMBby45TxxFYFmotJsbbWXU=;
        b=fPdNa/TTLZptZJCwURhHSgRKsj9NbAZSESff5800J8X4mjv2R0iuQMcHfxmEvYIG5J
         vFyEU68UnN1e5POmEnH2JGrSnZehm+GSy91Fnb0YLykVSxY7ASsSvSp+JoBGoL+5cgHl
         W0Tbc3X3KNMXUiO3BP7QfPvOf5j88DpzzhgfhpFeQdqtjrYLG0tlMoe8qsOaAKeL+rSW
         NLxZPGX33HtUr62lmQHBiKq+mrPlfWaOoJ8E3zTUtYAIFy/7hNPtCV8un+eJdD1sIcVk
         3pZMgYmgjvHQNnSEVo0BcQCIJcwyfkN4ewhn9k3Nx2yNx5LPCYPHSRfkyu3B6waikHds
         T4Zg==
X-Gm-Message-State: AA+aEWZJAAW/9FN+gHCpGlKW0taE6kG2XuLH0s94Q2Guy8oWD43/HV6a
        iAsyHyOBDLxdNFntS3c0QDoh2w==
X-Google-Smtp-Source: AFSGD/XZdTJbcteU5XCAX0GewpFup3MP4S5LxTJFITxGnSvIbBKwjRFgBimKIbx3liOWnQrcjjcG5g==
X-Received: by 2002:a19:4849:: with SMTP id v70mr9452530lfa.62.1543860150097;
        Mon, 03 Dec 2018 10:02:30 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 1-v6sm2540391lju.61.2018.12.03.10.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:02:29 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:02:27 +0100
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
Subject: Re: [2/3] PCI: designware: Take lock when ACKing an interrupt
Message-ID: <20181203180227.GB18985@centauri.lan>
References: <20181113225734.8026-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113225734.8026-3-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:57:33PM +0000, Marc Zyngier wrote:
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

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
