Return-Path: <SRS0=Bif1=BA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818AC433E7
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD412080D
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595302518;
	bh=ima5I++EfNgkpGhOlf1qdlYvIoS5nIvajY//GV7Ng9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cZRtwc5CZNoxi5/McFRkK/EF+rzSpgLIbfOx8ASFBIgE5oLbrUpNTYsVlM06k57z0
	 0tcpyBpe3WOxDR+U4WLQKyz3lOfJo1gd5zXz9nMw919iUbWmdSDqUzi4cJLW9P8akr
	 l219IeCvRa3eGEJc3R52NSJsOIVb949LZwbIQn2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGUDfP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:35:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43816 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUDfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 23:35:14 -0400
Received: by mail-io1-f67.google.com with SMTP id k23so19879102iom.10;
        Mon, 20 Jul 2020 20:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPBLAvgsfou0JfvJXuEQB+ES0YNVetU29UisTmz55RQ=;
        b=KragW6nyokA+FaY4x//AE3PHdTxEXppvwbmvHmQOk8GXgKi+rZ3KBOTjTXeNz9JQxQ
         oMrq54y8aP81zwAgHIUeqnkRsW/M6R7kuzuy2QcEXY0jhkwcpVE6fOmBTyjLV/7fw+Of
         LG2vHrFjVYBJWz7MBpdWZVRrApEXbzFj6PeSwtyM1SV8cS6OayCM/2BGuAndD2b1Clp5
         0/JBwxbrmDSz7MKoCOHhLjwXtfde4zU6OEB459KW3tahz6n8zDDRJlX1B+tg4i4KReBR
         gWEzCgX57umVUiPcBkR5yygeVq+ZML184rR4Bx4ImNjMFAYwvikLjLQRqtkExnHIGL0N
         741A==
X-Gm-Message-State: AOAM531/KPYzt2Gg5tAAK/vb/rkT/rxyjnVnMYBnQ5EnUuLmBy8KPVRX
        veIHKYg3PpeUhXPYaOtNehER56VK2Q==
X-Google-Smtp-Source: ABdhPJyiBOR2A1xSeEo/Gj95FPK7DAUeP62MF7tYceygME47H1J8elzK6W14mOyrg7scYIAlDdL/HQ==
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr25590702iow.163.1595302512823;
        Mon, 20 Jul 2020 20:35:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m5sm9868472ilg.18.2020.07.20.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:35:12 -0700 (PDT)
Received: (nullmailer pid 3504966 invoked by uid 1000);
        Tue, 21 Jul 2020 03:35:08 -0000
Date:   Mon, 20 Jul 2020 21:35:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-ide@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        Niklas <niklas.soderlund@ragnatech.se>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/20] dt-bindings: usb: renesas, usb3-peri: Document
 r8a774e1 support
Message-ID: <20200721033508.GA3504365@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Jul 2020 18:18:22 +0100, Lad Prabhakar wrote:
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
