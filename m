Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C24C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C074222A1
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfBKRhn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:37:43 -0500
Received: from foss.arm.com ([217.140.101.70]:54772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbfBKRhn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 12:37:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C326EBD;
        Mon, 11 Feb 2019 09:37:43 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 287643F675;
        Mon, 11 Feb 2019 09:37:41 -0800 (PST)
Date:   Mon, 11 Feb 2019 17:37:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
Message-ID: <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114111513.21618-9-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
> Base Address Register irrespective of the size. Fix it here to indicate
> 64-bit BAR if the size is > 2GB.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This looks like a fix and should me marked as such. Does it work
as as standalone patch if it gets backported ?

Lorenzo

> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 825fa24427a3..8bfdcd291196 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -131,7 +131,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>  	epf->bar[bar].phys_addr = phys_addr;
>  	epf->bar[bar].size = size;
>  	epf->bar[bar].barno = bar;
> -	epf->bar[bar].flags = PCI_BASE_ADDRESS_SPACE_MEMORY;
> +	epf->bar[bar].flags |= upper_32_bits(size) ?
> +				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> +				PCI_BASE_ADDRESS_MEM_TYPE_32;
>  
>  	return space;
>  }
> -- 
> 2.17.1
> 
