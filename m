Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE732084F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552313646;
	bh=DeX8Tnx+/DvUL5y4hqhKMNh6svHiIweAR/X01hBixrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uhHMcr6D4mpsG3jZARjF9EGD686Hy5BIyBazQL18d5az7Sayr02WqFalEtDgU+UBh
	 yTBn9yjYT54j25/graSVMdhwbNOGkMGcO6XKC1Rl37H8hRbuRyMVIhel1Ycxr22OaC
	 JI+SfvTmrYMqyCN5C0+pvnJZgl/XlHZRp6LV1y5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCKOOF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfCKOOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 10:14:04 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2011E2075C;
        Mon, 11 Mar 2019 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552313643;
        bh=DeX8Tnx+/DvUL5y4hqhKMNh6svHiIweAR/X01hBixrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw3GanCNRK5zOAUggeNcCLXf2gu+Te/x/v63BGlFcM5iPhC4IOwu7qusrBLF2QC6c
         1DPqMPZZERwbkicjMPy/bRFrbGixD/Gd2dybpkFgExHP+dJe2OpkKprEFMiSDcoi/I
         9+4BXSxLCO89Wg9J/TK3F7U80s9c2HkASxYTUoyE=
Date:   Mon, 11 Mar 2019 09:14:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 11/28] PCI: mobiveil: only fix up the Class Code field
Message-ID: <20190311141401.GG214730@google.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-12-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093130.7209-12-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 09:31:23AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Fix up the Class Code to PCI bridge, do not change the Revision ID.
> And move the fixup to mobiveil_host_init function.

Add parens after function name.

Please explain why this change is needed.  Does it fix a bug?

Does this fix the problem that the PCI core didn't correctly identify
the device as a bridge because it identified bridges by class code
instead of header type?

That problem *should* be fixed by b2fb5cc57469 ("PCI: Rely on config
space header type, not class code"), which is now upstream.

You might still want this class code change so that lspci shows the
correct thing.  That's fine, but the changelog should say why we're
doing it.

> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
> IP driver")

Make this "Fixes:" line a single line again.

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
> V4:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 78e575e71f4d..8eee1ab7ee24 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  				   type, resource_size(win->res));
>  	}
>  
> +	/* fixup for PCIe class register */
> +	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
> +	value &= 0xff;
> +	value |= (PCI_CLASS_BRIDGE_PCI << 16);
> +	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
> +
>  	/* setup MSI hardware registers */
>  	mobiveil_pcie_enable_msi(pcie);
>  
> @@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>  
> -	/* fixup for PCIe class register */
> -	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
> -
>  	/* initialize the IRQ domains */
>  	ret = mobiveil_pcie_init_irq_domain(pcie);
>  	if (ret) {
> -- 
> 2.17.1
> 
