Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3FC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67E6218A3
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555101179;
	bh=x1EjrIohq+tGRXeEF3KJf/4m9Sterb+q/h16tr9lCdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxMMbIv40HvpDsBcBDeAfDmIBfxGyzi72VMz4Gsd9cYZFbaNQZ5KUO0nPP5adcknu
	 wsGXx21Q4YURQKTqddI3pDqyuiPZxj6lGIVeAF4JfkuL35CqXDBeAOQcSLlaue5nSJ
	 NYieN8+FcwKJAmKRzLaQoZRE6JpAJTSLL3qxT9Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLUc7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfDLUc6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 16:32:58 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78C12171F;
        Fri, 12 Apr 2019 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555101178;
        bh=x1EjrIohq+tGRXeEF3KJf/4m9Sterb+q/h16tr9lCdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWtfBIMSMqY8H8g6jqks8Tv2XuBIhJg5zMW8sIxf2F3LN0dfBoUVvFnAAE9WyMqWJ
         qabFo2gxmWBZziQ9VsfKCmHtYmCmzzq7OYs8uqF55bZ+oH5zCyL5abMLpT933vtu/A
         i2ZBh/CTdCqNbQWFCqFPMRyIlnZtjtattKyyIdj4=
Date:   Fri, 12 Apr 2019 15:32:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Fix issue with "pci=disable_acs_redir"
 parameter being ignored
Message-ID: <20190412203256.GF141472@google.com>
References: <20190410210532.4538-1-logang@deltatee.com>
 <20190410210532.4538-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410210532.4538-2-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 03:05:31PM -0600, Logan Gunthorpe wrote:
> In most cases, kmalloc will not be available early in boot when
> pci_setup() is called. Thus, the kstrdup call that was added to fix the
> __initdata bug with the disable_acs_redir parameter usually returns
> NULL. Thus the parameter is discarded and it does not take into effect.
> 
> To fix this, we store the string that's in initdata until a initcall
> function can allocate the memory appropriately. This way we
> don't need any additional static memory.
> 
> Fixes: d2fd6e81912a ("PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied to for-linus for v5.1, thanks, Logan!

> ---
>  drivers/pci/pci.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c1b362f599a..766f5779db92 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6262,8 +6262,7 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "pcie_scan_all", 13)) {
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> -				disable_acs_redir_param =
> -					kstrdup(str + 18, GFP_KERNEL);
> +				disable_acs_redir_param = str + 18;
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);
> @@ -6274,3 +6273,19 @@ static int __init pci_setup(char *str)
>  	return 0;
>  }
>  early_param("pci", pci_setup);
> +
> +/*
> + * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
> + * to data in the __initdata section which will be freed after the init
> + * sequence is complete. We can't allocate memory in pci_setup() because some
> + * architectures do not have any memory allocation service available during
> + * an early_param() call. So we allocate memory and copy the variable here
> + * before the init section is freed.
> + */
> +static int __init pci_realloc_setup_params(void)
> +{
> +	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
> +
> +	return 0;
> +}
> +pure_initcall(pci_realloc_setup_params);
> -- 
> 2.20.1
> 
