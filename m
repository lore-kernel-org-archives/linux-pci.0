Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3EBC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4820848
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTZ2pGuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA4820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeLCSCS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:02:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38324 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCSCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Dec 2018 13:02:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so9855880lfg.5
        for <linux-pci@vger.kernel.org>; Mon, 03 Dec 2018 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjxo77HLOwXZgqZrzdmytZRn5YRf80zljBom3D8Rfxs=;
        b=UTZ2pGuZqcgO0QbZ3YRkunR8LP45bXm9P/1gR9ZBx5GIo6e0V7dizB8gHUKGifNTa7
         BtGvpuHO5mBwiWeBUGRhGvoHFMISJgva0HeuuIPmZhvmwGZu8tnXdJ8ve5Kh+oNYz1Nd
         s2VUHkBfHoTQlyYTc6oGgINFg79mb2H3AnLjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjxo77HLOwXZgqZrzdmytZRn5YRf80zljBom3D8Rfxs=;
        b=gLW13JAld/XHHLRlRfAgGY2uFn5OsRTREPaGfqD/H/g3dMkyOy/Q0tha1Hhmxq30YG
         5E5xN2tvn/B3eRJcuCQAYlD8Ix05pndbUO0ZWx3iTzfZ43OG926YOvO+VtWpWUCxaxXo
         q2Lz7JRRwoVfQnIy7EYYn0rPjLbMMV+ei8shDP3aImOZeehwnumCdd+IkwbF/foHNpk+
         tq56A9Ay3p1OiEP2HFx07ImAEo/R8DCu4jcuMh+r+M21vJoI1Cjxrbvc6ZBdl4tbjbxJ
         PaWw6A7z0Z93H1kRg7v/Dr/2LnmquPR033f0zD3dxaUDOqNXp+i/Hmp12/Tac16cpIRa
         Gsmw==
X-Gm-Message-State: AA+aEWaKb3eiYdY6l7iUf++weBrMXBCuXEcVy4IP5MZcD44frk+/2XYE
        0J/b1Ai0Rz8Fai2HN7clem2OGQ==
X-Google-Smtp-Source: AFSGD/VCikYmFgdM0Gt5KhgSBojDXoOz2wGB77voF8gugZH99eatf6XWhL1ln44s5hhtUQZLZ4mmXg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr9337806lfg.89.1543860130789;
        Mon, 03 Dec 2018 10:02:10 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id i78sm2728954lfa.9.2018.12.03.10.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:02:10 -0800 (PST)
Date:   Mon, 3 Dec 2018 19:02:08 +0100
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
Subject: Re: [1/3] PCI: designware: Use interrupt masking instead of disabling
Message-ID: <20181203180208.GA18985@centauri.lan>
References: <20181113225734.8026-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113225734.8026-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 10:57:32PM +0000, Marc Zyngier wrote:
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

For this patch combined with the fix-up from:
https://marc.info/?l=linux-pci&m=154218928401960&w=2

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
