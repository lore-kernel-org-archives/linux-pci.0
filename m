Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E799C65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF12213A2
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF12213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJIAga (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:36:30 -0400
Received: from foss.arm.com ([217.140.101.70]:53548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIAg3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 20:36:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1423DED1;
        Mon,  8 Oct 2018 10:23:46 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F043F5D3;
        Mon,  8 Oct 2018 10:23:43 -0700 (PDT)
Date:   Mon, 8 Oct 2018 18:23:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com, bhelgaas@google.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        youlin.pei@mediatek.com, yt.shen@mediatek.com,
        sean.wang@mediatek.com
Subject: Re: [PATCH v6 2/9] PCI: mediatek: Fixup class ID for MT7622 as
 PCI_CLASS_BRIDGE_PCI
Message-ID: <20181008172337.GA13538@e107981-ln.cambridge.arm.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
 <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538969088-7136-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 11:24:41AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The PCIe controller of MT7622 has TYPE 1 configuration space type, but
> the HW default class type values is invalid.
> 
> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> type for MT7622") have set the class ID for MT7622 as
> PCI_CLASS_BRIDGE_HOST, but it's not workable for MT7622:
> 
> In __pci_bus_assign_resources, the framework only setup bridge's
> resource window only if class type is PCI_CLASS_BRIDGE_PCI. Or it
> will leave the subordinary PCIe device's MMIO window un-touched.
> 
> Fixup the class type to PCI_CLASS_BRIDGE_PCI as most of the controller
> driver do.

I think that this patch is correct but the commit log fails to pin point
the problem. The IP you are programming is a root port, that's why you
have to have the proper class code, the patch looks fine but I would
like to peek Bjorn's brain on this since it is a fundamental concept.

If the kernel does not assign resources unless it detects a
PCI_CLASS_BRIDGE_PCI this means that for components that are
actually PCI_CLASS_BRIDGE_HOST their register set must come
preprogrammed unless I am missing something.

I would like to get to the bottom of this since it is a fundamental
enumeration concept.

Thanks,
Lorenzo

> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 288b8e2..bcdac9b 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -432,7 +432,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		val = PCI_VENDOR_ID_MEDIATEK;
>  		writew(val, port->base + PCIE_CONF_VEND_ID);
>  
> -		val = PCI_CLASS_BRIDGE_HOST;
> +		val = PCI_CLASS_BRIDGE_PCI;
>  		writew(val, port->base + PCIE_CONF_CLASS_ID);
>  	}
>  
> -- 
> 2.6.4
> 
