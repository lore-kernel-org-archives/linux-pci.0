Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7788ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92121523
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C92121523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJQVtO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:49:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46456 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQVtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 17:49:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id k64-v6so21092813oia.13;
        Wed, 17 Oct 2018 06:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9HKxcAtkLY5j9z+Vi59ci6Zm8gfKnNTpPnnHbp9+XU=;
        b=bQJd7a6xt3WcjRky76aUUwf9v8La44HqvgCcx1j1q/qHsAM9LC9DoAlJbzCuskWGeY
         yiizFeLt8QoPp2SL355enzy+ycJB6VqPDSUeQkoU/UKwGIik3rqfhaZpLy8DcFjCn/eR
         kh8lDpqHyXK2p9WN7G76waSN/XvkT+hDzolDVr4G8XRIcgH9j1WAWMTsqLrmXXl6yfbz
         R9Tp3Qx9zOOa1iUrB/6Fz0+6LS/xO18FJWS1h34esFuYvDecnzyfWhII01qiH4zkUIHU
         0jsfTnO6hS9QF/i0wi4IkeyqRpezJwryvPXi2+goBrbJ8AqgOFqnhY7HBMic/lapr9Dz
         DoJA==
X-Gm-Message-State: ABuFfoi80hSoBwyKyHA24UUm9EHE09QOAqZ7UwkfcwdRFKkJgsrC3emV
        RoaW6fyB9Hcus5Sbj6rt9Q==
X-Google-Smtp-Source: ACcGV62eVAKrVyUzB60pCgYSnrAtYHR/i0G98BNEyec0yaCFdtoLaOAM6utGqPo78A1CGpF3dA7D5w==
X-Received: by 2002:a54:4183:: with SMTP id 3-v6mr14600685oiy.159.1539784405013;
        Wed, 17 Oct 2018 06:53:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s187-v6sm5127912oie.31.2018.10.17.06.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:53:24 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:53:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, shawnguo@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181017135323.GA31980@bogus>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:14:26AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Similar comments on this one too.

> 
> Removed the compatible string "snps,dw-pcie", it is for the reference
> platform driver for PCI RC IP Protoyping Kits based on the ARC SDP,
> so it is not suitable for all platform with designware PCIe controller,
> and platform vendors have themselves' drivers.
> 
> The compatible string "snsp,dw-pcie" was added by mistake and it's not
> matched that time, but it is matched because pcie drivers has been
> collected recently.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 5eb1c202932f..9b2b8d66d1f4 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -13,8 +13,8 @@ information.
>  
>  Required properties:
>  - compatible: should contain the platform identifier such as:
> -        "fsl,ls1021a-pcie", "snps,dw-pcie"
> -        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
> +        "fsl,ls1021a-pcie"
> +        "fsl,ls2080a-pcie", "fsl,ls2085a-pcie"
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
> @@ -36,7 +36,7 @@ Required properties:
>  Example:
>  
>  	pcie@3400000 {
> -		compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +		compatible = "fsl,ls1021a-pcie";
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -- 
> 2.17.1
> 
