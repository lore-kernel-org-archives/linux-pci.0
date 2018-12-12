Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F5C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E0F20873
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544654602;
	bh=VIxtIFtRQmk7t6qIoKqlNdbuLv+MybgedcnEsrBnh1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZJL4vzzT5W577bONu4LKx+rYgkg/gqnKwlC6wyfG/d9hv49Y57c+BSZEEatxRfEns
	 EOT5+Nulbl46H8dbDwfueaVlRcgMGa59a8OMkHNrEQsEleMvjxFDzTfee3IzFbuwMT
	 AEJKwsbyB3yYALqn4Kq36ommT1SR2TX0Z0KQ1ZUs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E0F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeLLWnV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeLLWnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 17:43:21 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D24020645;
        Wed, 12 Dec 2018 22:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544654600;
        bh=VIxtIFtRQmk7t6qIoKqlNdbuLv+MybgedcnEsrBnh1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRr55J7RRdEkA4xOIZ96FTOjpLNlTKSgLl+zrq6HIq411D/z63SFF3NRaR2HN+ibG
         Wl0LED/50mMb/xHriQ+E1mCk76fXc2gLQWD6X0ry7tHuul41SKgTvdYIxRX6l7ICDm
         KBXBIh6Myz6W/PALXb/hpX1DaDvWWUm1XxmUMvOs=
Date:   Wed, 12 Dec 2018 16:43:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wesley Sheng <wesley.sheng@microchip.com>
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        wesleyshenggit@sina.com
Subject: Re: [PATCH 3/5] switchtec: A temporary variable should be used for
 the flags of switchtec_ioctl_event_ctl
Message-ID: <20181212224315.GK99796@google.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-4-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544433144-7563-4-git-send-email-wesley.sheng@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 10, 2018 at 05:12:22PM +0800, Wesley Sheng wrote:
> From: Joey Zhang <joey.zhang@microchip.com>
> 
> For nr_idxs is larger than 1 switchtec_ioctl_event_ctl event flags will be
> used by each event indexes. In current implementation the event flags are
> overwritten by first call of the function event_ctl().
> 
> Preserve the event flag value with a temporary variable.
> 
> Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
> Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/switch/switchtec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 480107e..a908670 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -796,6 +796,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>  {
>  	int ret;
>  	int nr_idxs;
> +	unsigned int event_flags;
>  	struct switchtec_ioctl_event_ctl ctl;
>  
>  	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
> @@ -817,7 +818,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>  		else
>  			return -EINVAL;
>  
> +		event_flags = ctl.flags;
>  		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
> +			ctl.flags = event_flags;
>  			ret = event_ctl(stdev, &ctl);

event_ctl() overwrites several other things, in addition to ctl.flags:

  ctl.data[]
  ctl.occurred
  ctl.count

Is that what you intend?  It looks like only the values from the *last*
call of event_ctl() will be copied back to the user buffer.

>  			if (ret < 0)
>  				return ret;
> -- 
> 2.7.4
> 
