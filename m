Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA79AC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789C1206BA
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBHMUd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:20:33 -0500
Received: from foss.arm.com ([217.140.101.70]:50054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMUc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 07:20:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32CF680D;
        Fri,  8 Feb 2019 04:20:32 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66BF33F719;
        Fri,  8 Feb 2019 04:20:30 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:20:27 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: Re: [PATCH v2] PCI: endpoint: functions: Use kmemdup instead of
 duplicating its function
Message-ID: <20190208122027.GE13009@e107981-ln.cambridge.arm.com>
References: <20181206125225.9497-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206125225.9497-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 06, 2018 at 08:52:25PM +0800, Wen Yang wrote:
> kmemdup has implemented the function that kmalloc() + memcpy().
> We prefer to kmemdup rather than code opened implementation.
> 
> This issue was detected with the help of coccinelle.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Kishon Vijay Abraham I <kishon@ti.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> CC: Niklas Cassel <niklas.cassel@axis.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> CC: linux-pci@vger.kernel.org (open list:PCI ENDPOINT SUBSYSTEM)
> CC: linux-kernel@vger.kernel.org (open list)
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Kishon,

this looks OK to me, anything I am missing ?

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3e86fa3c7da3..8df6c019f8a2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -169,14 +169,12 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  		goto err_addr;
>  	}
>  
> -	buf = kzalloc(reg->size, GFP_KERNEL);
> +	buf = kmemdup(src_addr, reg->size, GFP_KERNEL);
>  	if (!buf) {
>  		ret = -ENOMEM;
>  		goto err_map_addr;
>  	}
>  
> -	memcpy(buf, src_addr, reg->size);
> -
>  	crc32 = crc32_le(~0, buf, reg->size);
>  	if (crc32 != reg->checksum)
>  		ret = -EIO;
> -- 
> 2.19.1
> 
