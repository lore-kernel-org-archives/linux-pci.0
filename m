Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D2C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997E82083D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555595345;
	bh=cfV+Ti7UqGef3FhLSmthhkMDt/16GyaLAhEW0qiR0Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OU6bA1CnRcgt+vryUzH7YfjQdqKG9PETsiHNvVCdIijr8+N63qt/UPnQpvNurWl7F
	 tcIp4D3xiCcloa2lS2eO6O78cHP6/qzMsAxnR3ToeqnI3dv5Lvl0Q3UtqkqrDeu6e7
	 dxp1yd1cRSmAXVsH1XYXPgFbbO4riQA6EResEY8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfDRNtE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388849AbfDRNtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 09:49:04 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE31217FA;
        Thu, 18 Apr 2019 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555595343;
        bh=cfV+Ti7UqGef3FhLSmthhkMDt/16GyaLAhEW0qiR0Q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=se4uJSXKib1pHHnHz9vkF1MvVb1kqXt3ywOA+X4aee7FdbveS+QQHnpFjhCCTpMSM
         pqO3MQ9BMWy04L27WNThpBQ1aDpeNOb2GpI809DRkhCIn+VBBhvgo+NJbCPnvCu21/
         F5ZgYMZptIClzYWWuKZSLHJInl/Q1uis+ixL2xY8=
Date:   Thu, 18 Apr 2019 08:49:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH v2 2/2] switchtec: Fix unintended mask of MRPC event
Message-ID: <20190418134902.GZ126710@google.com>
References: <1555339302-31829-1-git-send-email-wesley.sheng@microchip.com>
 <1555339302-31829-3-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555339302-31829-3-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 10:41:42PM +0800, Wesley Sheng wrote:
> When running application tool switchtec-user's `firmware update` and
> `event wait` commands concurrently, sometimes the firmware update
> speed reduced evidently.
> 
> It is because when the MRPC event happened right after MRPC event
> occurrence check but before event mask loop reach to its header
> register in event ISR, the MRPC event would be masked unintentionally.
> Since there's no chance to enable it again except for a module reload,
> all the following MRPC execution completion check will be deferred to
> timeout.
> 
> Fix this bug by skipping the mask operation for MRPC event in event
> ISR, same as what we already do for LINK event.
> 
> Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> ---
>  drivers/pci/switch/switchtec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 7df9a69..30f6e08 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1177,7 +1177,8 @@ static int mask_event(struct switchtec_dev *stdev, int eid, int idx)
>  	if (!(hdr & SWITCHTEC_EVENT_OCCURRED && hdr & SWITCHTEC_EVENT_EN_IRQ))
>  		return 0;
>  
> -	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE)
> +	if (eid == SWITCHTEC_IOCTL_EVENT_LINK_STATE ||
> +	    eid == SWITCHTEC_IOCTL_EVENT_MRPC_COMP)
>  		return 0;

I'm OK with this, but I do wonder why this check is in mask_event()
instead of in switchtec_event_isr().  AFAICT it doesn't depend on
anything in the mask_all_events() -> mask_event() path, and doing it
in switchtec_event_isr() would avoid the CSR read in mask_event().

But maybe it logically belongs here.  I'll merge it as-is for now.

>  	dev_dbg(&stdev->dev, "%s: %d %d %x\n", __func__, eid, idx, hdr);
> -- 
> 2.7.4
> 
