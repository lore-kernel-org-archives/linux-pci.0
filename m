Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6BFC43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 23:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C491221B68
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 23:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550187705;
	bh=HeY7w7Sqzynqib3CLLk9zdx89T71gOTkRPAr72jLGkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCYxDofoFmWJW8RNZBZUx4sTM4tbmeg2s+zP+wGtni/B65YjKidiO33CTnDBOpHNW
	 kceu9UM7lFb2NnaRKPG5Z/ZGaVsiQ7FBu4inCqb+HwBws6jcqfRDGvH0DoMkGCc16T
	 Osipob9PjFvZ6Fc5JXPmp6nt14EzdYBRyDSOYub0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfBNXlp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfBNXlo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 18:41:44 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A171A20835;
        Thu, 14 Feb 2019 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550187703;
        bh=HeY7w7Sqzynqib3CLLk9zdx89T71gOTkRPAr72jLGkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4HV/MpMNhMbmAlHKrujpIf3MgEMq2KfYfa8yxNGrnEesDJkvPuMU6ofdBXdKZ4db
         EPylqvGbJbTQ2y1auiBfxi0oFwUTKonUSrYRvsZB2I/MZvhqNWf/AA3CCfhJjRgEQL
         grbS9DzQppz8nvTy3YWjBPCPgcbHqrW1EkQ5UMZ4=
Date:   Thu, 14 Feb 2019 17:41:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     honghui.zhang@mediatek.com
Cc:     lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryder.lee@mediatek.com,
        matthias.bgg@gmail.com, youlin.pei@mediatek.com,
        poza@codeaurora.org, fred@fredlawl.com, rafael.j.wysocki@intel.com,
        jianjun.wang@mediatek.com
Subject: Re: [RFC PATCH v2] PCI/portdrv: Support for subtractive decode bridge
Message-ID: <20190214234142.GP96272@google.com>
References: <1550121677-10474-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550121677-10474-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 14, 2019 at 01:21:17PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The Class Code for subtractive decode PCI-to-PCI bridge is 060401h,
> add one entry to make portdrv support this type bridge.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>

Applied to pci/portdrv for v5.1, thanks!

> ---
>  drivers/pci/pcie/portdrv_pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0acca35..c129f2f 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -185,6 +185,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  static const struct pci_device_id port_pci_ids[] = { {
>  	/* handle any PCI-Express port */
>  	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
> +	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
> +	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0),
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
