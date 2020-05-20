Return-Path: <SRS0=tlVJ=7C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FBC433E2
	for <linux-pci@archiver.kernel.org>; Wed, 20 May 2020 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8022D20885
	for <linux-pci@archiver.kernel.org>; Wed, 20 May 2020 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590016023;
	bh=maGktyVvVjAOinDebeNtJUlcldwhjTZs1RJtoDQ0sa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qOHKEPjjhUS5pgjgncBtuOjCf19PI1S+dS9VfAOAFBVIYporY+Gw3rwPIDuN7PqSL
	 mFkRhBFdR2iZ3AYszhVhI0QJQ7geOoTcgAJ1RWzaHfnzFAju1fKEIz/CqzqMNSzdMZ
	 jCQ5dodLY5LmWeYwEFkUMB7RsDXjy+VfiAi227Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgETXHA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 May 2020 19:07:00 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45995 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgETXHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 19:07:00 -0400
Received: by mail-il1-f193.google.com with SMTP id b15so5040065ilq.12;
        Wed, 20 May 2020 16:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpxe6Kf1Y1YKMS1+011D2HXa532cg7CAEDYR3p5RkEw=;
        b=LdoGNGArJeHLdn8MZq6irDRDbDKJmSU53w3sOyRkH7x6VeV71zRu/B/2DzUVtEUCAi
         O8Bk/hX4Xgdd6gpMqLXjDfm7sojbJfyAvrhqibcAoQm2AYK+zDYMmjFFQRmHmnESD1IJ
         9CW/8gkoYh96Moj3ePuRJB+BZl2jwEam+IlL/jvROz5PfUmFnk9ZNI5pOjDE4hthJRQ4
         5xcwK2eIbyKiwE0YHG0esWp1F6ZhLles/2+dfpbk4iiHjdh0pceR3cz59ufYRUOZnepK
         E2JXhLVEHHJR5jPEAt5X4C0DOSgSgDmwoSREDSUdU2f3DKo3X+PDAHvhcpWcZeE1chLh
         ShWg==
X-Gm-Message-State: AOAM530z2zSnqA2DUuR9iw9avBRTxdGgsoK2I8dncH8Sw70Ah1jz0DYg
        FgB7Eudq4lNZ+K6nEhb+9A==
X-Google-Smtp-Source: ABdhPJxjcHECSsdzZdmzcqRS1EuJexuCuPYCn1h85LxDvs0MwMakXDkCfb4HocQNRcy4sUr6NgDWnA==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr6278919ilj.107.1590016018819;
        Wed, 20 May 2020 16:06:58 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q13sm1667155ion.36.2020.05.20.16.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:06:58 -0700 (PDT)
Received: (nullmailer pid 788100 invoked by uid 1000);
        Wed, 20 May 2020 23:06:57 -0000
Date:   Wed, 20 May 2020 17:06:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 2/2] PCI: uniphier: Add Socionext UniPhier Pro5 PCIe
 endpoint controller driver
Message-ID: <20200520230657.GA788030@bogus>
References: <1589457801-12796-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589457801-12796-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457801-12796-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 21:03:21 +0900, Kunihiko Hayashi wrote:
> Add driver for the Socionext UniPhier Pro5 SoC endpoint controller.
> This controller is based on the DesignWare PCIe core.
> 
> And add "host" to existing controller descriontions for the host controller
> in Kconfig.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  drivers/pci/controller/dwc/Kconfig            |  13 +-
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 383 ++++++++++++++++++++++++++
>  4 files changed, 396 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-uniphier-ep.c
> 

Reviewed-by: Rob Herring <robh@kernel.org>
