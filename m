Return-Path: <SRS0=Bif1=BA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043EC433DF
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4548D2073A
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 03:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595302577;
	bh=QUh4WP32Zhn1T9n1H/an9RfsyceSIFgXaxt+jxn2D5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wz8Ya68o+biRDRLt2bM2TrOClebYhwJUTMg0jTeIUP7sebXP3u9cRBqv/pWdzFZTs
	 uyzt6cQdPWv+prTaz2x3KN5hck0midr8bUXKJS2q8imOe6/IxJOj3YZTDlIjEFYHhw
	 RSaKwr8Pg1UZokilZJ/9zrVWxJ3/C0FY88xDcO1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgGUDgL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:36:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37061 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUDgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jul 2020 23:36:10 -0400
Received: by mail-io1-f67.google.com with SMTP id v6so19900362iob.4;
        Mon, 20 Jul 2020 20:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XLGTyXCkmMJoVwCT0eUYcNsMnQ7R+zGFloTuhsZ5vXQ=;
        b=eK/ALOWz+O4IzCcgugiKDWkAfd3u4eexv6H+4YBX3Yhd/Nh0m/dao2bV+scpSB2msE
         XYdGcPI8hqsmaEdJ672EIHTVdkcbo7+kcwp6hWVIjGdNNsqUlo/97+7mg7vMdBKPfg6w
         PQlya/mguMuiO1xoZMl0NDmGiTTqKQACr3+/DNAjw4rdXqk5Vuwe7Dtgr+JALrPoajyb
         9NeBWNB+U1qI/VEIUeJzPZP3lm9IoA+tUmksoFgpmyXCEDa4bpGYsEBQbGcjqKFMymXV
         Ty7yj5EQT5h8SyOc+WWtkyUnFfZO30cJZfjgjjxrkI/1/2QKi5h3+lVC0LcdSkDd23tr
         TvBw==
X-Gm-Message-State: AOAM530AVNWZax98lX2I4B3iMNq0+aunBHc3naRqdp4OdUnaD49h3NLZ
        0TiPafzHm2sYzpgomnzI2w==
X-Google-Smtp-Source: ABdhPJxuljtBA6IS7ZsT9GN703rwNxLoyaryqa25QgNuRvDnlFpDQSGZSl22m1OvsKcpvDZHSnDk2w==
X-Received: by 2002:a05:6638:1014:: with SMTP id r20mr29509699jab.44.1595302568835;
        Mon, 20 Jul 2020 20:36:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n7sm9796964iob.44.2020.07.20.20.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 20:36:08 -0700 (PDT)
Received: (nullmailer pid 3506684 invoked by uid 1000);
        Tue, 21 Jul 2020 03:36:06 -0000
Date:   Mon, 20 Jul 2020 21:36:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
        linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-usb@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 16/20] dt-bindings: media: renesas,csi2: Add R8A774E1
 support
Message-ID: <20200721033606.GA3506635@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-17-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Jul 2020 18:18:31 +0100, Lad Prabhakar wrote:
> Add the compatible string for RZ/G2H (R8A774E1) to the list of supported
> SoCs.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/renesas,csi2.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
