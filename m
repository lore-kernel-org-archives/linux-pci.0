Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4296C433F5
	for <linux-pci@archiver.kernel.org>; Wed, 20 Apr 2022 21:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiDTVZY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Apr 2022 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382477AbiDTVZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 17:25:20 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD748399;
        Wed, 20 Apr 2022 14:22:33 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id q129so3540062oif.4;
        Wed, 20 Apr 2022 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1OlONqUEeuZBKJj4P1V2oJXxW6/ql//Y9DnbYPS7ps=;
        b=3J9FVESgFGmZaBz3JP8gec4HNcIXgmHsBb2t+AhqF4YUrbPFfLQkpLYfJiBMmlz0Iz
         ImnEWBzXBuW3T3HcJsn5IUvAX8TDN3XhN4oFH1bUa48EjnxaZdNmXifvBYagBhz0FvVU
         p/MssEp/0ux9RfXAWNyTU99LFWLUGK2cICFX5xgZ7ffMdn4tpl7zWePL+MOI8MpWKhmv
         E8lkbA6DyRFyAw2SRWo3+8His5bUgQX/NngozFarEniZzZM1ONqEvMscybhBUdMeIFxz
         zskyyRgt/pjqvCbz3oh65uRWpyuXWYIdtlSAcmsardxD1tX7Fhbvg/ng3vKVPq3b3pAU
         /+Lg==
X-Gm-Message-State: AOAM531nYMgp242VHCzJqFp0MCOiOqgkLSE2p+P7nGX5JFivO0LgazWz
        EE2NoISi438uSvFGJbWEAg==
X-Google-Smtp-Source: ABdhPJzGBp4/re7AsiDqxq5EfXny4vXXW9xSN7cF8MdhOTesJ73VAYvt3KV2eIpL1n6UADjVWwTIiw==
X-Received: by 2002:a05:6808:2185:b0:2d9:ebf0:fb66 with SMTP id be5-20020a056808218500b002d9ebf0fb66mr2664428oib.69.1650489752551;
        Wed, 20 Apr 2022 14:22:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp17-20020a056808239100b00322c34c4afbsm2199741oib.25.2022.04.20.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:22:32 -0700 (PDT)
Received: (nullmailer pid 1871147 invoked by uid 1000);
        Wed, 20 Apr 2022 21:22:31 -0000
Date:   Wed, 20 Apr 2022 16:22:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: designware-ep: Increase
 maxItems of reg and reg-names
Message-ID: <YmB5l3LSBMwpB/Zr@robh.at.kernel.org>
References: <1650241100-3606-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1650241100-3606-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650241100-3606-2-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 09:18:19AM +0900, Kunihiko Hayashi wrote:
> UniPhier PCIe EP controller has up to 5 register mappings (dbi, dbi2, link,
> addr_space and atu), so maxItems of "reg" and "reg-names" should allow 5.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
