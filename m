Return-Path: <SRS0=UCfD=CY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A4C433E2
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 01:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C921D7B
	for <linux-pci@archiver.kernel.org>; Tue, 15 Sep 2020 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600133474;
	bh=dCIUW1IfchfJLPpb5Lsp7pR/LnR+IMlVQkp5BOy8nv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V+PaLFlo53r49PKp8+kXmFZa32062Td3RmO18CsIazaIePrVO7vDIUGYc9BPxIdpl
	 pn6dWTUzUiLJB9O3+DPkwEl+Ce91st0RqT0WJaYdx3F5S4iJuYL/eh+Y5mHGSQquCP
	 YrbQBPavZQk5xoCra9849Fe1AVU3H3wl6EqXWm10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIOBbN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:31:13 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45558 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgIOBbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 21:31:13 -0400
Received: by mail-il1-f195.google.com with SMTP id h2so1425146ilo.12;
        Mon, 14 Sep 2020 18:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYoisOp+NfhOtEks+H1PWMjiTQzYklc2RdQNPNRvIWo=;
        b=gOQRhuWK9nRxQQZzUwgriJ9DIMnCAQ8fEjMh+PiFS92asBfR2EWozlM03iNrfgsGwX
         lOiRbz13jPNKykbhP78u/+9FZzj01lSC8POGb5kA53Vb8rJSF3dmPSOMDgzIou2hDp3v
         lHkwknDEyHSz+hrSnRMehixnuDobIQGqYnO4FWggy6k9WCKnHcex9YOU4pF7ZsM1PNvS
         b2LhjonXHISsoN3465WXJoEzE0Y+Axoh+Vdaygv/2yYGgpTwsFH2CxkN+LfuZZBT0dT8
         MFK9qzCn7yToT5WjqtSVdj1MJlrOWOT4Du6zRV8ey15fC0lZxjKdB8Ypjn2satCdKvxq
         Tobg==
X-Gm-Message-State: AOAM533qC3VS7uF5WYSKxkjidkO7II/hKnTlrEuTvIFvV30Y6OTkEeQk
        Bp6PLoBXdHXQLjFxWf6D9YNFVH6TUQzb
X-Google-Smtp-Source: ABdhPJyZu3dA6he1ugzJd9kV2WKXXLwVpYQl1y6Mk48eOKK6N6YxhuxctIZPmSyxiERNVujEHHIAew==
X-Received: by 2002:a92:aac4:: with SMTP id p65mr14098337ill.136.1600133471906;
        Mon, 14 Sep 2020 18:31:11 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g23sm3160900ioe.45.2020.09.14.18.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:31:11 -0700 (PDT)
Received: (nullmailer pid 668440 invoked by uid 1000);
        Tue, 15 Sep 2020 01:31:08 -0000
Date:   Mon, 14 Sep 2020 19:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        minghuan.Lian@nxp.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, robh+dt@kernel.org,
        mingkai.hu@nxp.com, roy.zang@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 5/7] dt-bindings: pci: layerscape-pci: Update the
 description of SCFG property
Message-ID: <20200915013108.GA668381@bogus>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-6-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-6-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Sep 2020 13:37:59 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Update the description of the second entry of 'fsl,pcie-scfg' property,
> as the LS1043A PCIe controller also has some control registers in SCFG
> block, while it has 3 controllers.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
