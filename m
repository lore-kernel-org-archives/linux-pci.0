Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49066C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DCA21920
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 16:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbfBMQGN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:06:13 -0500
Received: from foss.arm.com ([217.140.101.70]:56636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfBMQGN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 11:06:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B3FA78;
        Wed, 13 Feb 2019 08:06:12 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E79133F575;
        Wed, 13 Feb 2019 08:06:11 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:06:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] MAINTAINERS: Mark PCI Cadence entry as Orphan
Message-ID: <20190213160609.GB2280@e107981-ln.cambridge.arm.com>
References: <20190213145009.32220-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213145009.32220-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 02:50:09PM +0000, Lorenzo Pieralisi wrote:
> Current PCI Cadence controller maintainer email address
> bounces which does not bode well for its maintainership
> status.
> 
> Remove the email address from the MAINTAINERS entry and mark
> its status as Orphan.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..6b5f5fe78527 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11581,9 +11581,8 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  F:	drivers/pci/controller/dwc/pcie-armada8k.c
>  
>  PCI DRIVER FOR CADENCE PCIE IP
> -M:	Alan Douglas <adouglas@cadence.com>
>  L:	linux-pci@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	Documentation/devicetree/bindings/pci/cdns,*.txt
>  F:	drivers/pci/controller/pcie-cadence*

Hi Cyrille,

are you interested in taking over given that you authored the driver ?

Thanks,
Lorenzo
