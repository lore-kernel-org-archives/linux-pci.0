Return-Path: <SRS0=aHqq=C2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70551C43464
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098722083B
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600379282;
	bh=VUAIgo4ZS9CEzEo039Yyv38u1gYD6swYwqcKyVXWrTI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=h8bY/bbCgonmdAz8tzxszOB70UhxcdfQa2QY8Dm6k4Re8JjukbBe8E2whTWnqZrPx
	 Xh/aClvrWTRIs0kXcf8BmQd1DcI7JHZn/lkuWbEgcz5Qbxy7C6X3f60enG/3OFustZ
	 4gdFacOcM1qWB4D0cbseycusNaoQM7K3NC1Bgp8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgIQVsB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQVsB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:48:01 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C804B2075B;
        Thu, 17 Sep 2020 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600379281;
        bh=VUAIgo4ZS9CEzEo039Yyv38u1gYD6swYwqcKyVXWrTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tRh48cVnCuQgB5BHoxuYLk2oLMvrZWVxRccqW4F86JMZSbrPa9/lbEbsGexH+bhl1
         /lXXHpQinBV2nCHEfzBPFoU1j5BBiDJKr+irbX2hBh6iAWS5peQtqEjIQxxT7a7rqP
         RKtb1xdk0BaOmJsIUzIxsNB2jwe6zO0swPpjcxWI=
Date:   Thu, 17 Sep 2020 16:47:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] [-next] PCI: DWC: Fix cast truncates bits from constant
 value
Message-ID: <20200917214759.GA1741197@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7743c426ae2c34573d59636d4d6cefaccdb00990.1600378070.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 11:28:03PM +0200, Gustavo Pimentel wrote:
> Fixes warning given by executing "make C=2 drivers/pci/"
> 
> Sparse output:
> CHECK drivers/pci/controller/dwc/pcie-designware.c
>  drivers/pci/controller/dwc/pcie-designware.c:432:52: warning:
>  cast truncates bits from constant value (ffffffff7fffffff becomes
>  7fffffff)
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c3a4d1..dcb7108 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -429,7 +429,7 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  	}
>  
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~PCIE_ATU_ENABLE);
> +	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, (u32)~0 & ~PCIE_ATU_ENABLE);

But this cure is worse than the disease.  If this is the only way to
fix the warning, I think I'd rather see the warning ;)  I'm hopeful
there's a nicer way, but I'm not a language lawyer.

>  }
>  
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> -- 
> 2.7.4
> 
