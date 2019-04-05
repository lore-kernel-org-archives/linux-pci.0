Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39368C282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0724521871
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554500384;
	bh=fOJQWpXT0IhmLaQ+arMO+cYV5jNuWzGUa+JiYkIBAmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9wiA1+0gJL9MrBw7ZN4fMA/f4jBnXt6KtAhj8J57c6avcVpOf2QujsoAZZnX7tf1
	 qm4e6PbRBGfj69/NKiK/DTRXKlXlomFKp+sRtbKX7cFeAgT43DuUx0UEXTPXsuTFGT
	 PSZUkbLZda5QT/D+mcns8a+qyZ3CqY4jMB2+A/fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDEVjn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEVjn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 17:39:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B02E21726;
        Fri,  5 Apr 2019 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554500381;
        bh=fOJQWpXT0IhmLaQ+arMO+cYV5jNuWzGUa+JiYkIBAmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smdnJg7yM++WBVw+VidCSDqJ+gC1Cng+ZaVnEkUGR5O3quA19euQ5PSYBfLif9pxw
         BssNcauLQgpflTKuA8ey7vzKHmYTrU14K8fHYR3MPMSne5m1HW39qkCwj78lm6FN4x
         6S4Yjbb9MAgQoddYpk5/3YAnIv467dQ5ijivBFGY=
Date:   Fri, 5 Apr 2019 16:39:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Andrew Maier <andrew.maier@eideticom.com>
Subject: Re: [PATCH] PCI: Fix issue with "pci=disable_acs_redir" parameter
 being ignored
Message-ID: <20190405213939.GC159318@google.com>
References: <20190401193302.12813-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401193302.12813-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 01, 2019 at 01:33:02PM -0600, Logan Gunthorpe wrote:
> In most cases, kmalloc will not be available early in boot when
> pci_setup() is called. Thus, the kstrdup call that was added to fix the
> __initdata bug with the disable_acs_redir parameter usually returns
> NULL. Thus the parameter is discarded and it does not take into effect.
> 
> To fix this we have to do what we originally did with the
> resource_alignment parameter: allocate a static buffer and copy the
> string from the command line to it.
> 
> Fixes: d2fd6e81912a ("PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Andrew Maier <andrew.maier@eideticom.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> Sorry, it seems I didn't test the previous patch in this area properly
> and I actually made disable_acs_redir ineffective in most cases.
> 
> This change should fix it and I got a colleague to test it fully
> on his system as well.
> 
> drivers/pci/pci.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c1b362f599a..537395dfd0df 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3125,7 +3125,17 @@ void pci_request_acs(void)
>  	pci_acs_enable = 1;
>  }
> 
> -static const char *disable_acs_redir_param;
> +static char disable_acs_redir_param[COMMAND_LINE_SIZE];

I certainly acknowledge the problem, but I'm a little hesitant to add
a static buffer of 256-4096 bytes (2048 on x86, arm64, powerpc, sparc)
for a relatively low-usage situation.  The memory usage doesn't seem
in proportion to the value-add.

Ugh, and we allocate another similar buffer for
resource_alignment_param[], which I would guess is also rarely used.

Since disable_acs_redir_param[] and resource_alignment_param[] are
both read-only and big enough to hold the entire command line, we
should be able to share a single buffer between them if we made the
parsers a little smarter.  In fact, I bet there's already a static
copy lying around somewhere for /proc/cmdline.

> +static void pci_set_disable_acs_redir_param(const char *param)
> +{
> +	if (strlen(param) >= sizeof(disable_acs_redir_param)) {
> +		pr_err("PCI: disable_acs_redir parameter is too long and has been ignored!\n");
> +		return;
> +	}
> +
> +	strcpy(disable_acs_redir_param, param);
> +}
> 
>  /**
>   * pci_disable_acs_redir - disable ACS redirect capabilities
> @@ -3140,7 +3150,7 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
>  	int pos;
>  	u16 ctrl;
> 
> -	if (!disable_acs_redir_param)
> +	if (!disable_acs_redir_param[0])
>  		return;
> 
>  	p = disable_acs_redir_param;
> @@ -6262,8 +6272,7 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "pcie_scan_all", 13)) {
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> -				disable_acs_redir_param =
> -					kstrdup(str + 18, GFP_KERNEL);
> +				pci_set_disable_acs_redir_param(str + 18);
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);
> --
> 2.20.1
