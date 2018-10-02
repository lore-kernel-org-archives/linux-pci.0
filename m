Return-Path: <SRS0=XHdA=MO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C1C43143
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1023208E7
	for <linux-pci@archiver.kernel.org>; Tue,  2 Oct 2018 10:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1023208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeJBQqM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:46:12 -0400
Received: from foss.arm.com ([217.140.101.70]:33714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJBQqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Oct 2018 12:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426C27A9;
        Tue,  2 Oct 2018 03:03:44 -0700 (PDT)
Received: from red-moon (red-moon.emea.arm.com [10.4.13.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9733F5B3;
        Tue,  2 Oct 2018 03:03:41 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:04:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] DT: pci: rcar-pci: document R8A77990 bindings
Message-ID: <20181002100426.GA24071@red-moon>
References: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 22, 2018 at 05:02:52PM +0200, Marek Vasut wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
> 
> Document the R-Car E3 (R8A77990) SoC in the R-Car PCIe bindings.
> 
> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/controller-misc for v4.20, thanks.

Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index a5f7fc62d10e..5f2f9e380efb 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -9,6 +9,7 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
>  	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
>  	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
> +	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
>  	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
>  				     RZ/G1 compatible device.
>  	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
> -- 
> 2.18.0
> 
