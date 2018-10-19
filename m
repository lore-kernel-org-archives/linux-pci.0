Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A7ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370820869
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 15:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E370820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJSXRD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:17:03 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57849 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSXRD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 19:17:03 -0400
X-Originating-IP: 50.39.174.102
Received: from localhost (50-39-174-102.bvtn.or.frontiernet.net [50.39.174.102])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0F9261BF204;
        Fri, 19 Oct 2018 15:10:25 +0000 (UTC)
Date:   Fri, 19 Oct 2018 08:10:23 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/9] powerpc: PCI_MSI needs PCI
Message-ID: <20181019151019.GA5618@localhost>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019120952.32763-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> Various powerpc boards select the PCI_MSI config option without selecting
> PCI, resulting in potentially not compilable configurations if the by
> default enabled PCI option is disabled.  Explicitly select PCI to ensure
> we always have valid configs.
[...]
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -24,6 +24,7 @@ config BLUESTONE
>  	default n
>  	select PPC44x_SIMPLE
>  	select APM821xx
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_MSI
>  	select PPC4xx_PCI_EXPRESS
> @@ -78,6 +79,7 @@ config KATMAI
>  	select 440SPe
>  	select PCI
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI

This case already had PCI selected a couple of lines above.

>  	select PPC4xx_MSI
>  	help
> @@ -219,6 +221,7 @@ config AKEBONO
>  	select SWIOTLB
>  	select 476FPE
>  	select PPC4xx_PCI_EXPRESS
> +	select PCI
>  	select PCI_MSI
>  	select PPC4xx_HSTA_MSI
>  	select I2C
> -- 
> 2.19.1
> 
