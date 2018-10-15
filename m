Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B914C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0856621471
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7FVVLEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0856621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJPCXl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPCXl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Oct 2018 22:23:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E735208B3;
        Mon, 15 Oct 2018 18:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628635;
        bh=4etPwDx1t4w5P/RP14WFoKzN6btdnvV9tY/orolqHXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7FVVLEIp2U/F/c0xzDNyAGEW1QuR8SJ0lomkVxytbLV67QZgdSx0IFvigYjNGUlT
         xVy0Q+E0hDv7WccgAdZ2Ds2H04OqmR8TDygmOrXUpkzp7lHjxRoSeorsLddFonXbZ5
         VbSlP48deEJR31imgfSkHm255pYYfYgmsz0NrTJ0=
Date:   Mon, 15 Oct 2018 13:37:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, marc.zyngier@arm.com,
        jianjun.wang@mediatek.com, yt.shen@mediatek.com,
        matthias.bgg@gmail.com, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, yong.wu@mediatek.com
Subject: Re: [PATCH v8 2/9] PCI: mediatek: Fix class type for MT7622 as
 PCI_CLASS_BRIDGE_PCI
Message-ID: <20181015183713.GC5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
 <1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539590940-13355-3-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 04:08:53PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The commit 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class
> type for MT7622") have set the class type for MT7622 as un-properly
> value of PCI_CLASS_BRIDGE_HOST.
> 
> The PCIe controller of MT7622 is complexed with Root Port and PCI-to-PCI
> bridge, the bridge has type 1 configuration space header and related bridge
> windows. The HW default value of this bridge's class type is invalid. Fix
> its class type as PCI_CLASS_BRIDGE_PCI since it is HW defines.
> 
> Making the bridge visiable to PCI framework by setting its class type
> properly will get its bridge windows configurated during PCI device
> enumerate.
> 
> Fixes: 101c92dc80c8 ("PCI: mediatek: Set up vendor ID and class type for MT7622")
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Nak until this patch is preceded by one that fixes the PCI core defect
I pointed out earlier [1].  It's OK to change the class code, but
not as a way of working around that PCI core defect.

[1] https://lore.kernel.org/linux-pci/20181012141202.GV5906@bhelgaas-glaptop.roam.corp.google.com

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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
