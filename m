Return-Path: <SRS0=Bif1=BA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB1C433E8
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0497220792
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595302438;
	bh=/Ruyt31NFI5sI30fJDI/y8nmbFQsM/U3W9lruITyABE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=APa+gI9dA9uygYmtPlh0peqGa1h/rOo8OXqckO7cNUxSkBIi+Y71W5Y6T7dUiPloy
	 N98nqWglWxUXxvOGnWiMAWeglCmpjRx6SF+Cx6UJUNm65TLKbqsj+0jYPPm2LR+ChN
	 bNno7JjkfFXpTjzengEl+tlHu5ZullKcsAh5lxZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGUDd5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:33:57 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36946 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgGUDd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 23:33:56 -0400
Received: by mail-il1-f194.google.com with SMTP id r12so15215112ilh.4;
        Mon, 20 Jul 2020 20:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBcdY3HFaainNH7/Ra9c82Wh/rj6UMBKXbkEBttOuWA=;
        b=JxM7Mc/7/1XHywFcTOS6vmpY7CJOVRYnGLrE5dMHbrVobFUoPlhn6xTWEruOeUKyFQ
         99BBLU56lOrT0Ek3Z0sKF7YX1LpfSXuYysg0jWZzWy9lDhCxkO5fyFft9vWIJE12IFM6
         M//Ufj027hcQpK8vQ9hOKri+4w24WkCN+LP0EKHm+9SlQUSY6YGUSa1kiurs4gFSKSV8
         n9wpj+wyMX2K0ln00lIrhPSKbJ9D2fgFBIZ63R/4+Nu+0pIl0bSLYGi2BAAITlucU/Fc
         h53oTmlhMxfPzy9bdBB8t9fIB8K0HCB8Usai1G+YmwoOq+ENQWsca5irnzGE2PpCNvqL
         dtSA==
X-Gm-Message-State: AOAM530tbsvQUQCyjLQK/eLydWZqtoELXMQxND6ZsnSA6RJVTk4e3ESA
        DhDyEbHMhER9hJKdFd1nBg==
X-Google-Smtp-Source: ABdhPJzQK7HIV/ZdYzlF04FRAnR2t2Iyb81D/LpbBVswH0ZpPuKlVzm71H/c6uxFmJxJiRvZiRiOvQ==
X-Received: by 2002:a92:6a02:: with SMTP id f2mr23892378ilc.68.1595302434623;
        Mon, 20 Jul 2020 20:33:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm9039035ili.28.2020.07.20.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:33:53 -0700 (PDT)
Received: (nullmailer pid 3503019 invoked by uid 1000);
        Tue, 21 Jul 2020 03:33:52 -0000
Date:   Mon, 20 Jul 2020 21:33:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-i2c@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        Niklas <niklas.soderlund@ragnatech.se>,
        linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 01/20] dt-bindings: pci: rcar-pci: Add device tree
 support for r8a774e1
Message-ID: <20200721033352.GA3502973@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Jul 2020 18:18:16 +0100, Lad Prabhakar wrote:
> Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
