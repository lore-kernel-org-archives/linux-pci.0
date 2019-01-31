Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D8C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A16A21872
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 21:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548970611;
	bh=yzcBI/0W24G8x1f5Xr7NzrPSRHBlzH6cM6XBb1PH/E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mbrTFPns2+Ssf6Uiu9qW0Xb0WxA7WR2EVN10LXvu4DmBDCry5Ipvtwx1y8ZFFib5h
	 SEYrVf1l+ZGsh3hjTGOkHnQSDqX0aXJI6WWt+iTzZ46a1cU7OrVu8NMA13j7Y8Garf
	 opFXV41LIQuvr2t54oqQaHWoCTPz9BAkxTl2u1Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfAaVgu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfAaVgu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 16:36:50 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD0D20B1F;
        Thu, 31 Jan 2019 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548970609;
        bh=yzcBI/0W24G8x1f5Xr7NzrPSRHBlzH6cM6XBb1PH/E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CwYcQWONddNQY/fG6Ssf7+ZHJeTZIt7kJrFIKQljHYXDtt9ecaDAX37L+VfRQn8Ad
         JQqt7DvgSEHAJLcuitY7wZWbYQOQNbMMqNYso5BKaxX421pFqFqX5Pe2J5AwX/GrAC
         q0FUJ/3cd+K4JYK8trBbktRwTyEG8+gQiuLG8wn8=
Date:   Thu, 31 Jan 2019 15:36:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        youlin.pei@mediatek.com, poza@codeaurora.org, fred@fredlawl.com,
        rafael.j.wysocki@intel.com, jianjun.wang@mediatek.com
Subject: Re: [PATCH v2 1/2] PCI: mediatek: Use resource_size function on
 resource object
Message-ID: <20190131213647.GP229773@google.com>
References: <1548921713-5355-1-git-send-email-honghui.zhang@mediatek.com>
 <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548921713-5355-2-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 04:01:52PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> scripts/coccinelle/api/resource_size.cocci complain about the
> following warning:
> 
> pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> 
> Use resource_size(mem) instead of mem->end - mem->start to eliminate the
> complain. Since the MMIO window size for both MT2712 and MT7622 are all
> 0x1000_0000, this change also fix the AHB2PCIe window size smaller than
> HW MMIO window size issue by change the values of fls(size) from
> fls(0xfff_ffff) to fls(0x1000_0000).

Good, I'm glad this actually fixes a bug.  The warning was actually
useful!

Since that's the case, the *bug* is the important thing (not the
warning), and the subject line should be about the bug fix.  The fact
that it also happens to remove a warning is really just incidental.

You say "the AHB2PCIe window size smaller than HW MMIO window size
issue" as though it should be familiar to us.  But it's not :)

So the changelog needs to start by explaining what the AHB2PCIe window
size issue is, mention what user-visible problem that causes, then
explain how you're fixing it by using resource_size().

Then you can mention that this also incidentally removes a coccinelle
warning.

Bjorn

> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 55e471c..01126b8 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	struct resource *mem = &pcie->mem;
>  	const struct mtk_pcie_soc *soc = port->pcie->soc;
>  	u32 val;
> -	size_t size;
>  	int err;
>  
>  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> @@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		mtk_pcie_enable_msi(port);
>  
>  	/* Set AHB to PCIe translation windows */
> -	size = mem->end - mem->start;
> -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> +	val = lower_32_bits(mem->start)
> +	      | AHB2PCIE_SIZE(fls(resource_size(mem)));

Nit: I think it's more typical to put the "|" on the first line.

>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
>  
>  	val = upper_32_bits(mem->start);
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
