Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA434C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C37421473
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 10:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJDR1p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:27:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeJDR1p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 13:27:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15E767A9;
        Thu,  4 Oct 2018 03:35:06 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FA7B3F5D3;
        Thu,  4 Oct 2018 03:35:04 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:34:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7744
Message-ID: <20181004103455.GA5233@e107981-ln.cambridge.arm.com>
References: <1538051331-14860-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538051331-14860-1-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 27, 2018 at 01:28:51PM +0100, Biju Das wrote:
> Add internal PCI bridge support for r8a7744 SoC.  The Renesas RZ/G1N
> (R8A7744) internal PCI bridge is identical to the R-Car Gen2 family.
> 
> This doesn't change the driver, so it does nothing by itself.  But it does
> mean that checkpatch won't complain about a future patch that adds
> "renesas,pci-r8a7744" to a DT, which helps ensure that shipped DTs use
> documented compatibility strings.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch is tested against linux-next next-20180927
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/controller-misc for v4.20.

Thanks,
Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index 9fe7e12..b94078f 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -7,6 +7,7 @@ OHCI and EHCI controllers.
>  
>  Required properties:
>  - compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
> +	      "renesas,pci-r8a7744" for the R8A7744 SoC;
>  	      "renesas,pci-r8a7745" for the R8A7745 SoC;
>  	      "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC;
> -- 
> 2.7.4
> 
