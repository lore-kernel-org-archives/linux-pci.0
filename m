Return-Path: <SRS0=DAdr=DO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE9C41604
	for <linux-pci@archiver.kernel.org>; Wed,  7 Oct 2020 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A8E206BE
	for <linux-pci@archiver.kernel.org>; Wed,  7 Oct 2020 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602088947;
	bh=3A4yZhFTfZzM1GZuO8j6XulnZL9iVxvReOmcntbBu1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CB1GVAt53BHG7BQZp40PKj/weqd7rGLck/N66NGAT2sdbjCCYpqaOMAKN8bN4fuea
	 MMWSXn54CODI24i6eZsgz3ju6TvWQyPINObrbq5OP2fLMkWN4htIf8cYaHBDKmesJq
	 NpWKO8he8r5SfiP3vfMIcF3hkt77EcwWPuRsoLfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgJGQm0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:42:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45658 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGQm0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 12:42:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id z26so3085389oih.12;
        Wed, 07 Oct 2020 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OcQk4vNKYoAU5xLAeaS2OBiQjx+TCKWc3Rt58ihVV48=;
        b=M3I40p8AaDhDMN2CTJRnXOJhKjz4h3BTxv4LT6ayv04VLUd/JUkdyeshQ3ycQNgVBK
         6PvZRt79GyxH5fo+nXECbvgfS6JvHq/NPcmulCRxFpQks2WfXxVq13UHdQJX4tNP/bWT
         b98WCejVh1mBLQEcXv3DE727uzGIoKQwmIed9U+fqh/HuLX8muSvBueUQBuXBDRNHSDW
         11eZh2CiXAZcVs6EWRegdJtpHmuB7tvTRfU1kyEixwqF7vFIRzhav/62YpCmQaQ16s7q
         bXr8Cp/tYOsLTducl0pHmIHThq8zD+SQ/v6XaNpz1DpJ2dSGBQcs5aESUQClHceW1Lzu
         njXA==
X-Gm-Message-State: AOAM532FarhN6zioHoMBQm9vg2XFP9zYTEJ5k0TH7z0YbA+oeC1FVVvE
        EBPcg06Jp3cKKjDKGjnuGg==
X-Google-Smtp-Source: ABdhPJyJ4rc4KEsnlW3T0id3xM2TvSrswV7rdUJfn6O/JZoNU7d7hv/5P3+OGAKWVzFQ5AI5NM+KnA==
X-Received: by 2002:a05:6808:198:: with SMTP id w24mr2482678oic.69.1602088945453;
        Wed, 07 Oct 2020 09:42:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m187sm2265653oia.39.2020.10.07.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:42:24 -0700 (PDT)
Received: (nullmailer pid 354734 invoked by uid 1000);
        Wed, 07 Oct 2020 16:42:23 -0000
Date:   Wed, 7 Oct 2020 11:42:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v7 1/3] PCI: portdrv: Add pcie_port_service_get_irq()
 function
Message-ID: <20201007164223.GA354699@bogus>
References: <1599816814-16515-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1599816814-16515-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599816814-16515-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 11 Sep 2020 18:33:32 +0900, Kunihiko Hayashi wrote:
> Add pcie_port_service_get_irq() that returns the virtual IRQ number
> for specified portdrv service.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/pcie/portdrv.h      |  1 +
>  drivers/pci/pcie/portdrv_core.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
