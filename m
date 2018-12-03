Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B690BC04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B120864
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 22:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU7DOutP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9B120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLCWHC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:07:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeLCWHC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 17:07:02 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35E420851;
        Mon,  3 Dec 2018 22:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543874821;
        bh=P+ClqifsYBB5+feA1KgYgp5Jf4neLwGqIj2CUPXxFXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU7DOutPAOrnKbkj6S1cjGVdqpBefmmg6dZhPUd4xvvlJ5MUGLXra8s58L3nEtwFO
         klEjdaprxndwSLRhqQAKqXbg9fq9zW4cxOj3BTK2wejgqVjH+UC6X4PfQsrnJmfU58
         7RGdoNxyGmMkNHAmkiWj6DlacsbeFRS3IyLxL/0w=
Date:   Mon, 3 Dec 2018 16:06:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 2/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011451
Message-ID: <20181203220659.GD207198@google.com>
References: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
 <20181202133303.33988-3-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202133303.33988-3-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 02, 2018 at 01:32:45PM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> When LX2 PCIe controller is sending multiple split completions and
> ACK latency expires indicating that ACK should be send at priority.
> But because of large number of split completions and FC update DLLP,
> the controller does not give priority to ACK transmission. This
> results into ACK latency timer timeout error at the link partner and
> the pending TLPs are replayed by the link partner again.
> 
> Workaround:
> 1. Reduce the ACK latency timeout value to a very small value.
> 2. Restrict the number of completions from the LX2 PCIe controller
>    to 1, by changing the Max Read Request Size (MRRS) of link partner
>    to the same value as Max Packet size (MPS).
> 
> This patch implemented part 1, the part 2 can be set by kernel parameter
> 'pci=pcie_bus_perf'

So you're saying that users of this controller must boot with
"pci=pcie_bus_perf"?  That's a little unfriendly to users.  When they
forget to use that parameter and some mysterious PCIe error occurs,
they will not thank you.

We should be able to figure this out automatically via some sort of
quirk in the driver, and then do the right thing in the MPS/MRRS
configuration.  That would also give us a chance to make sure that
when the MPS/MRRS code changes, it can be done in a way that keeps
this Rev1.0 controller working.

If you depend on users booting with "pci=pcie_bus_perf", there's no
connection in the code, and if we change or remove that parameter, we
would have no clue that you depend on it.

> This ERRATA is only for LX2160A Rev1.0, and it will be fixed
> in Rev2.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../pci/controller/mobiveil/pci-layerscape-gen4.c  | 14 ++++++++++++++
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h    |  4 ++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> index 1fe56532b288..ef43033e1c2a 100644
> --- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -220,6 +220,18 @@ static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
>  	.link_up = ls_pcie_g4_link_up,
>  };
>  
> +static void workaround_A011451(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u32 val;
> +
> +	/* Set ACK latency timeout */
> +	val = csr_readl(mv_pci, GPEX_ACK_REPLAY_TO);
> +	val &= ~(ACK_LAT_TO_VAL_MASK << ACK_LAT_TO_VAL_SHIFT);
> +	val |= (4 << ACK_LAT_TO_VAL_SHIFT);
> +	csr_writel(mv_pci, val, GPEX_ACK_REPLAY_TO);
> +}
> +
>  static int __init ls_pcie_g4_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -259,6 +271,8 @@ static int __init ls_pcie_g4_probe(struct platform_device *pdev)
>  	if (!ls_pcie_g4_is_bridge(pcie))
>  		return -ENODEV;
>  
> +	workaround_A011451(pcie);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index ef93b41f4419..c75b7c304c46 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -85,6 +85,10 @@
>  #define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
>  #define PAB_INTP_AXI_PIO_CLASS		0x474
>  
> +#define GPEX_ACK_REPLAY_TO		0x438
> +#define  ACK_LAT_TO_VAL_MASK		0x1fff
> +#define  ACK_LAT_TO_VAL_SHIFT		0
> +
>  #define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
>  #define  AMAP_CTRL_EN_SHIFT		0
>  #define  AMAP_CTRL_TYPE_SHIFT		1
> -- 
> 2.17.1
> 
