Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ADFC4361B
	for <linux-pci@archiver.kernel.org>; Mon,  7 Dec 2020 18:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED459238E2
	for <linux-pci@archiver.kernel.org>; Mon,  7 Dec 2020 18:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGSCF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:02:05 -0500
Received: from foss.arm.com ([217.140.110.172]:57042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGSCF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 13:02:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF98E1042;
        Mon,  7 Dec 2020 10:01:15 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896463F66B;
        Mon,  7 Dec 2020 10:01:14 -0800 (PST)
Date:   Mon, 7 Dec 2020 18:01:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     daire.mcnamara@microchip.com
Cc:     bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, cyril.jean@microchip.com,
        ben.dooks@codethink.co.uk
Subject: Re: [PATCH v18 4/4] Add Daire McNamara as maintainer for the
 Microchip PCIe driver
Message-ID: <20201207180112.GB18363@e121166-lin.cambridge.arm.com>
References: <20201203121018.16432-1-daire.mcnamara@microchip.com>
 <20201203121018.16432-5-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203121018.16432-5-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 12:10:18PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>

Add a commit log.

Subject should start with "MAINTAINERS:".

Next time you change a file read the git log --oneline history for
it so that we don't have to repeat these comments indefinitely.

> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..dc926b36116b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13628,6 +13628,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/pci/mediatek*
>  F:	drivers/pci/controller/*mediatek*
>  
> +PCIE DRIVER FOR MICROCHIP
> +M:	Daire McNamara <daire.mcnamara@microchip.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindigs/pci/microchip*

s/bindigs/bindings

> +F:	drivers/pci/controller/*microchip*
> +
>  PCIE DRIVER FOR QUALCOMM MSM
>  M:	Stanimir Varbanov <svarbanov@mm-sol.com>
>  L:	linux-pci@vger.kernel.org
> -- 
> 2.25.1
> 
