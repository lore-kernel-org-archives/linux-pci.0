Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F7C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C12190C
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552699;
	bh=xCDG12FYokW29hwSl6SqhHgSTnAUY4toDR6JhbOvZzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FcWgPmNv2rDhZQi3AfrzkROqH+KMPMOIQa5V/mSVQn8FMztqD4yg2W2jGojufPLp7
	 gV3jCTmvkNqmOMY2T7LwsyQy9rHROjPtumT8oFGNun7hV56/g3AvxX8DM84pl1Js+c
	 5MjMdLWIGqg2d30/esU94Go6cUAQwVmJK2SRKw/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfBGPSS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBGPSS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:18 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16BA2190A;
        Thu,  7 Feb 2019 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549552697;
        bh=xCDG12FYokW29hwSl6SqhHgSTnAUY4toDR6JhbOvZzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=10qs5cocQJwHmFhGGwPcpH3vssYdS3YokAcnZxy8HcKWr7tQ18ebTvHwSnfQCbDyL
         B5ZgM63v823jDw/7tcOrAQ3NoHefUnx4jhD+cWZNu5JI8HUC43juE5NPuNMz4+GGbT
         IU2aKsM0FywynFHu3YF15cIVuuHGSGY5PXED6Lwc=
Date:   Thu, 7 Feb 2019 09:18:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        matthias.bgg@gmail.com, youlin.pei@mediatek.com,
        poza@codeaurora.org, fred@fredlawl.com, rafael.j.wysocki@intel.com,
        jianjun.wang@mediatek.com
Subject: Re: [RFC PATCH] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190207151816.GI7268@google.com>
References: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544758829-10327-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Honghui,

On Fri, Dec 14, 2018 at 11:40:29AM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> change the class_mask values to make portdrv support this type bridge.

I assume you have a Root Port or Switch Port that supports subtractive
decode?  I'm trying to understand how such a device would work.

Out of curiosity, can you show the "lspci -vv" output for the device
and the downstream devices of interest?

Do you happen to know whether this functionality is configurable,
e.g., is there some way software can enable or disable subtractive
decode?  I assume this would be some device-specific thing, because I
can't find anything in the Bridge Control register or similar.  The
PCIe spec doesn't even contain the word "subtractive".

The "PCI Express to PCI/PCI-X Bridge Specification", r1.0, says a PCI
Express bridge (which would include Root Ports and Switch Ports) has a
Class Code of 0x060400 (Non-Subtractive PCI-PCI Bridge) (sec 1.1).

Sec 1.3.4 says subtractive decode on the primary interface is "not
applicable or outside the scope of this spec".

Bjorn

> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index eef22dc..86926ea 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -179,7 +179,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>   */
>  static const struct pci_device_id port_pci_ids[] = { {
>  	/* handle any PCI-Express port */
> -	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> +	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0x01),
>  	}, { /* end: all zeroes */ }
>  };
>  
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
