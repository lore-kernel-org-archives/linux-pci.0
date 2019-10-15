Return-Path: <SRS0=CLTA=YI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050DC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 15 Oct 2019 19:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089B220854
	for <linux-pci@archiver.kernel.org>; Tue, 15 Oct 2019 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571167501;
	bh=ThEwon+h0lFfh0WuULNO4nKv1KKzru316EDhKnllBt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PiiuCPGS2HjoGBledKnMUTLaXvhqT8e3uZpLVGFWIdIcvkJ0do5FdCjqL0AxeOgWH
	 JrsR+d4Fc2l5FIgREl2nNH0x8VwNc2dqM2F2pT9qEgSiF8AZ4EZi1DGU6z+BgC9xz8
	 dVefP9EHAW8clE1vpZiGif7U+Voc9Z+dBX76jJ3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfJOTZA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:25:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40313 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfJOTZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 15:25:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so17868547oib.7;
        Tue, 15 Oct 2019 12:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyIrl1GE+9gjH4x9dLD9qpYH84cDi+R+Uj8YTerE0Ak=;
        b=R+cK8qRprqxasnmLDhXSVZjGurImzrS1+2mXoNweAYks4szs1703GSAgh55rYb+1RW
         sCddf1G9lo/QoVjJb/ITz+kWQVXusPThWiCKVpYPa4wsrLTZLbHT8mYMYZqjVIKaZtaB
         uuYLBzK0rpeNyM0sTr2YRJ5f3Avh69xAFKXzk67T6646FGHpnCfmBoopRefuTckJydAc
         c3ikDodwbfx6r191cAvjpjAjOGc0a1z3i54SkSOirDTNpKd/zQc33EAg8f/ddnKVcqVV
         0Alpi8T/AEdWSvzytezerv8eGKMca21SA9QVMhdSNcaI9r+AkdDOcHnKPt7UoFTR7ART
         3wPw==
X-Gm-Message-State: APjAAAW2Eelf5I9/VqovfeedNq4cnztUdqTfmZuvRFz/ZpVKSOOKRr04
        z/YWBg3HoLjf4c+cCdz9UlzfBFE=
X-Google-Smtp-Source: APXvYqyCrUehiwj/WPDrgEVfLwqAslHQqnl9viQs2KI3xWSpXWrN8xq2YrHzi6M8plH+C3IOVDVyQQ==
X-Received: by 2002:aca:4744:: with SMTP id u65mr143448oia.164.1571167497967;
        Tue, 15 Oct 2019 12:24:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm6713118otj.64.2019.10.15.12.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:24:57 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:24:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
Subject: Re: [PATCH 1/7] dt-bindings: watchdog: renesas-wdt: Document
 r8a774b1 support
Message-ID: <20191015192456.GA407@bogus>
References: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570178133-21532-2-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri,  4 Oct 2019 09:35:27 +0100, Fabrizio Castro wrote:
> RZ/G2N (a.k.a. R8A774B1) watchdog implementation is compatible
> with R-Car Gen3, therefore add the relevant documentation.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
