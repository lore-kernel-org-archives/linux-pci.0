Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4489AC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B71218A1
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545146143;
	bh=hL+OjmqDQsMlbbsagd8Nizmshe4fBv3fqkUyaYlrrlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z1v2pKrBQSVDdv6uHtT8R0gXFZvIkSKJWhbR8YjPso8CfNhCoGE2KT8vNXPI+ZHkC
	 uR7Sfym1W8HYEcKdo/0NkBOjcln0n6WQ91323yxeT+kE7bxq3kuboNq1SIsL36ywoo
	 qSn2mw8HKuVHYlaGRoqjKWQ4Xem70gD8PoJTHUOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeLRPPh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:15:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45064 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeLRPPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 10:15:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so2174695oie.12;
        Tue, 18 Dec 2018 07:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R6FiizF1WZO/jYfpHg3Lq2YG0OpoJsKc5a+tOWuKe9M=;
        b=qpXl+P7jpxgs42NuayiPAqNS90Cl7ZBBAeOWVpM3SJa4CcHd+VWJ8C2rgsbtUamP78
         hXfLvPauXMGwGjJlMo5a82t6hcdO9Uviu/qOfBehf5w/UtDZ9KgKc7nilUO2rUxXpH9R
         OQRk6F7jNXVR/P25AhL2yvJws0w2WLCCSSQyRrvdHEdnQwfMYeGOo7/M0muDI5CcxF/W
         NFM6sCIL5cq5PnmG1VgWynzrfhoInwpsAab59/XipD7Ij6Ojd/oYcbnMgMmrhTqPG5yk
         e9yJOHPYTl+/oHBNkgEneRKko0/91bnQv5ZQWuOXOnoHY6cPVea6AKzyo16FWmDptIGn
         eXGw==
X-Gm-Message-State: AA+aEWZSRVN8oetjPXPwR2lu2JS7oE8JzPcpm54euwNCNNlN0TezsuVP
        Ag7Gvu0QvdxMllYIePcqYg==
X-Google-Smtp-Source: AFSGD/U+VViOFv01xysi619namV0zfIztq2Q1OIIQsE1SoxVMSJAxcYAiY7owRJpQ8eXZN/HS9/TOA==
X-Received: by 2002:aca:5205:: with SMTP id g5mr8315705oib.149.1545146134892;
        Tue, 18 Dec 2018 07:15:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm2813042otk.51.2018.12.18.07.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 07:15:34 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:15:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
Message-ID: <20181218151533.GA2922@bogus>
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218040702.29231-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> Add code needed to support i.MX8MQ variant.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
>  drivers/pci/controller/dwc/Kconfig            |  4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 82 ++++++++++++++++++-
>  3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index d514c1f2365f..1a10c313e8d7 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -9,6 +9,7 @@ Required properties:
>  	- "fsl,imx6sx-pcie",
>  	- "fsl,imx6qp-pcie"
>  	- "fsl,imx7d-pcie"
> +	- "fsl,imx8mq-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
>    PCIE_PHY power domains
>  - power-domain-names: Must be "pcie", "pcie_phy"
>  
> -Additional required properties for imx7d-pcie:
> +Additional required properties for imx7d-pcie and imx8mq-pcie:
>  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
>  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
>    IP block
> @@ -54,6 +55,9 @@ Additional required properties for imx7d-pcie:
>  	       - "apps"
>  	       - "turnoff"
>  
> +Additional required properties for imx8mq-pcie:
> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> +

Remove this.

If GPR register offset is what you need, then put that into DT. 
Typically, we'd have a property with iomuxc phandle and offset.

Rob
