Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F77C433FE
	for <linux-pci@archiver.kernel.org>; Wed,  4 May 2022 22:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiEDWWX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 4 May 2022 18:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiEDWWV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 18:22:21 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631594ECC3;
        Wed,  4 May 2022 15:18:44 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso1820191otj.5;
        Wed, 04 May 2022 15:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPA2WXPf2ORHLvPqYvnaXDrZT9G3gl/LbUxeEGa3+Rk=;
        b=M4h8Vw51/xwlanfMXEiTwbgMGOPmm+NZsHpgjeNZtcxSgvcNXffCoaEIQYVz54K3s0
         QzT1QE86vZww78nhW8+vOdOIcSbB/ZxzqgS3BYAjvhKGlBxswvkWccRxJUXk4Tp9y2cq
         LBjSjDXufUvLbjAj560Z2oVMO++btrHsbH6x4bzU98cqgFxTEj3Qp1UoUY04iE5gWFzP
         aOMv51agQI025J2+2WVnEB5zboblp17Ldj9eaa0iGBh1KcKvRTPPByDE8do0G2v+iHC0
         3ANHA6j7YipOscEOqMUlXBLx8eZwQRrOMGPL8SuZN3RCi1HMCaXh4iIGOb3JXH/XFq2g
         mdXg==
X-Gm-Message-State: AOAM531j9G8HVZCpmo6dTcuqOnwXBn7J9VjPf/R0kMQy1LV7qD6s/Z4k
        do5htEvrI8P3jhbpBE+08Q==
X-Google-Smtp-Source: ABdhPJxN6SwWGQWW1Tig+s8KsEXHmVP8UolyZn342PEBZ4kMRNzHqwmoRY1xgkpkGrYlZ3tUZAhjSA==
X-Received: by 2002:a9d:195:0:b0:605:eb43:5b84 with SMTP id e21-20020a9d0195000000b00605eb435b84mr8372575ote.357.1651702723637;
        Wed, 04 May 2022 15:18:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b00325cda1ffb8sm38618oil.55.2022.05.04.15.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:18:43 -0700 (PDT)
Received: (nullmailer pid 2325128 invoked by uid 1000);
        Wed, 04 May 2022 22:18:42 -0000
Date:   Wed, 4 May 2022 17:18:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pci: apple,pcie: Drop max-link-speed from
 example
Message-ID: <YnL7wnGDbyGGksGX@robh.at.kernel.org>
References: <20220502091308.28233-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502091308.28233-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 02 May 2022 18:13:08 +0900, Hector Martin wrote:
> We no longer use these since 111659c2a570 (and they never worked
> anyway); drop them from the example to avoid confusion.
> 
> Fixes: 111659c2a570 ("arm64: dts: apple: t8103: Remove PCIe max-link-speed properties")
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks!
