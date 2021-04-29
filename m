Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E6DC433ED
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 22:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1663161452
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhD2Wj2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Apr 2021 18:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhD2Wj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 18:39:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 069696143A;
        Thu, 29 Apr 2021 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619735920;
        bh=FJMABtH4cJ+ulkHtvdjpFRnQDT287AnLQBcU7uZ3HuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gbNHxJKNLFLiIv667svdxfipXsmqwezyoKN/2QseSq68pQHGrhCXFI1k5WYaonlPa
         HRSLQp0J02skiT876VSW68SmZQKq9ghR3q9P79Hg0lp9ExFqadO+4CPN1Qx1FxKINA
         +CQnaHo4GEKHUeY8JMU8SZJDOyqBHvtM/8k4+1kM18OL90GlTkbJQkfCu/yzf9UBIO
         uiR5Uiiv+Bk9uhNQqii6u4+AKkw7/V2ndzQx3rhOGODbDkUoz8ImsgsK7cf5b+yAj2
         TRaTD0P0MPnV/JFKoQVCsruDhTwD4eHs505iuu97gvowpVPYBDnw8X2rjCdAS7wewv
         l0KQ29yN4laxA==
Date:   Thu, 29 Apr 2021 17:38:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Verify whether the free_ck clock is
 ungated or not
Message-ID: <20210429223838.GA588275@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429134749.75157-1-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can you make the subject say something at a higher level instead of
just paraphrasing the C code?  I'm guessing this means resume will now
fail if the clock isn't turned on?

On Thu, Apr 29, 2021 at 07:17:49PM +0530, Amey Narkhede wrote:
> Verify that the free_ck clock is ungated on device resume
> by checking return value of clk_prepare_enable().

Also the commit log -- this doesn't say anything more than the code
itself.  Did you find this by tripping over it?  Or just by code
inspection?  I guess without the check, we continue on and try to
resume, but accesses to PCI devices fail and maybe return ~0 data or
cause machine checks or something?

> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 23548b517..9b13214bf 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1154,11 +1154,14 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
>  {
>  	struct mtk_pcie *pcie = dev_get_drvdata(dev);
>  	struct mtk_pcie_port *port, *tmp;
> +	int ret;
> 
>  	if (list_empty(&pcie->ports))
>  		return 0;
> 
> -	clk_prepare_enable(pcie->free_ck);
> +	ret = clk_prepare_enable(pcie->free_ck);
> +	if (ret)
> +		return ret;

Most callers print an error message when clk_prepare_enable() fails.

>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
>  		mtk_pcie_enable_port(port);
> --
> 2.31.1
