Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706CECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213721526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 13:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213721526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJQVri (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:47:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41763 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQVri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 17:47:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id c32so26226678otb.8;
        Wed, 17 Oct 2018 06:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r3UGQLQZg6yrqJBHvha+OLFJK9ZSThxlDiT2EmOF+hA=;
        b=DEY25V1dDA3etdHPZEfZzX/mtvFPga0Ea0C6174b70E6Cgf0QGeYebnx4tB/msj/fN
         44q5P4yJQZcBncEVSQEwAErVCGZphgnG8fAHlkX6ND/TPWp1e0gep8ZFfR6zS1dgJUrr
         XXEb6Ia2UWaZJSTQbV8F318LTWHiIHJQ2x0vFCfgb62ogZnMYTW7uMlJ7l/BPQBQTJpe
         nue+y9aIiPVS+ZcuSZrmdiKMpnrv1gv5b/BIkEG2eTPMPQKGT2Wnhk8fMhI0GBx0XaqC
         edXwRP2ErNNhLYFlTIrhUEJZyNynp3WbBSCbYOXVe7759eDZorY2wnBboTavNTG3+hB2
         sFAg==
X-Gm-Message-State: ABuFfoihTCObjGIF92Lc9WqYGnLT2QhQKu/nA7RhZ6mJ4MdWDrIwTpVA
        stLzEQOFt8iNVsLTmJoGUw==
X-Google-Smtp-Source: ACcGV62uMxu/RTizlj88yh7cPvN9XE4E//WAYoX9P62WkTE7fvUlgBkWAJzm34bjPGFzoCVnKvhFhw==
X-Received: by 2002:a9d:439b:: with SMTP id t27mr16089678ote.235.1539784309614;
        Wed, 17 Oct 2018 06:51:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j40sm1253450otd.29.2018.10.17.06.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:51:48 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:51:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        leoyang.li@nxp.com, shawnguo@kernel.org, mark.rutland@arm.com,
        bhelgaas@google.com, Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com
Subject: Re: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible
 strings
Message-ID: <20181017135148.GA29469@bogus>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008031428.25293-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:14:25AM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The pcie compatible string for LS1043A was lost, so add it.

PCIe

The subject could be improved to say exactly what compatible string you 
are adding. And the subject should start with "dt-bindings: pci: ..."

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 66df1e81e0b8..5eb1c202932f 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -18,6 +18,7 @@ Required properties:
>          "fsl,ls2088a-pcie"
>          "fsl,ls1088a-pcie"
>          "fsl,ls1046a-pcie"
> +        "fsl,ls1043a-pcie"
>          "fsl,ls1012a-pcie"
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
> -- 
> 2.17.1
> 
