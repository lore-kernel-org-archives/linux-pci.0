Return-Path: <SRS0=EmHj=BI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8143C433E0
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jul 2020 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BBF2075D
	for <linux-pci@archiver.kernel.org>; Wed, 29 Jul 2020 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596051307;
	bh=NzOavhypQiRK+fikxf4URNUQ281LTHgwzpWksY2B5j8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=raKpdTPTLSwOXcrjSsRBZ9bfOngxJbdJqpSrSatPv+nCccJ/g6aznBTwovXi3rNPP
	 YxFI9fpZ3N5sGsPIUZrOsE5bwEmVGwsC7BLUkIfrgeofg3pbGr53Onp1WsOFv1c53m
	 eB2o745hMiJMKFep3WC1XsZOEHCY1Tki8rWdZwIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2TfH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgG2TfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 15:35:07 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4401206D4;
        Wed, 29 Jul 2020 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596051306;
        bh=NzOavhypQiRK+fikxf4URNUQ281LTHgwzpWksY2B5j8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=va7MDQS4LRM/ecdjwCpXltGEt61+wCS4zFLaeboEgcCzWoFtgvvCQ4mSKNBo1v66o
         wz2Uh5D6HO6Dy9eG/p1Bf0vSGoUPoVI+35+kLyInUV3IjtOr90muXlZHNNr4BbqMhN
         JZLkbfYMCKz4mg72FAqJvBOtPjkvQUEKTX0JFhJw=
Date:   Wed, 29 Jul 2020 14:35:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Kelvin.Cao@microchip.com
Subject: Re: [PATCH 1/2] PCI/switechtec: Add missing __iomem and __user tags
 to fix sparse warnings
Message-ID: <20200729193504.GA1960928@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728192434.18993-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 01:24:33PM -0600, Logan Gunthorpe wrote:
> Fix a number of missing __iomem and __user tags in the ioctl functions of
> the switchtec driver. This fixes a number of sparse warnings of the form:
> 
>   sparse: sparse: incorrect type in ... (different address spaces)
> 
> Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/switchtec for v5.9, thanks!

> ---
> 
> Here are a couple quick patches to fix some sparse warnings I was
> notified about a couple weeks ago.
> 
> I've split them into two patches based on Fixes tag, but they could be
> squashed depending on the preference.
> 
> Thanks!
> 
> drivers/pci/switch/switchtec.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 850cfeb74608..3d5da7f44378 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -940,7 +940,7 @@ static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
>  	size_t off;
> 
>  	if (event_id < 0 || event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
> -		return ERR_PTR(-EINVAL);
> +		return (u32 __iomem *)ERR_PTR(-EINVAL);
> 
>  	off = event_regs[event_id].offset;
> 
> @@ -948,10 +948,10 @@ static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
>  		if (index == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
>  			index = stdev->partition;
>  		else if (index < 0 || index >= stdev->partition_count)
> -			return ERR_PTR(-EINVAL);
> +			return (u32 __iomem *)ERR_PTR(-EINVAL);
>  	} else if (event_regs[event_id].map_reg == pff_ev_reg) {
>  		if (index < 0 || index >= stdev->pff_csr_count)
> -			return ERR_PTR(-EINVAL);
> +			return (u32 __iomem *)ERR_PTR(-EINVAL);
>  	}
> 
>  	return event_regs[event_id].map_reg(stdev, off, index);
> @@ -1057,11 +1057,11 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>  }
> 
>  static int ioctl_pff_to_port(struct switchtec_dev *stdev,
> -			     struct switchtec_ioctl_pff_port *up)
> +			     struct switchtec_ioctl_pff_port __user *up)
>  {
>  	int i, part;
>  	u32 reg;
> -	struct part_cfg_regs *pcfg;
> +	struct part_cfg_regs __iomem *pcfg;
>  	struct switchtec_ioctl_pff_port p;
> 
>  	if (copy_from_user(&p, up, sizeof(p)))
> @@ -1104,10 +1104,10 @@ static int ioctl_pff_to_port(struct switchtec_dev *stdev,
>  }
> 
>  static int ioctl_port_to_pff(struct switchtec_dev *stdev,
> -			     struct switchtec_ioctl_pff_port *up)
> +			     struct switchtec_ioctl_pff_port __user *up)
>  {
>  	struct switchtec_ioctl_pff_port p;
> -	struct part_cfg_regs *pcfg;
> +	struct part_cfg_regs __iomem *pcfg;
> 
>  	if (copy_from_user(&p, up, sizeof(p)))
>  		return -EFAULT;
> 
> base-commit: 92ed301919932f777713b9172e525674157e983d
> --
> 2.20.1
