Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41605 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdCMQi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Mar 2017 12:38:26 -0400
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20170313105004.GA24989@mwanda>
Cc: Stephen Bates <stephen.bates@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d7484df5-6951-a8eb-fbf5-aa945aa4c7f8@deltatee.com>
Date: Mon, 13 Mar 2017 10:38:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170313105004.GA24989@mwanda>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH 1/2] switchtec: off by one in ioctl_event_ctl()
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dan,

Thanks for catching these!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

(for both patches)

Logan

On 13/03/17 04:50 AM, Dan Carpenter wrote:
> The > should be >= SWITCHTEC_IOCTL_MAX_EVENTS.  Otherwise we probably
> read one space beyond the end of the loop, hit a sanity check and return
> -EINVAL.  This bug doesn't look super serious.
> 
> Fixes: 61c2e02154a9 ("switchtec: Add IOCTLs to the Switchtec driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 1f045c95dec6..82ae08956457 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1049,7 +1049,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
>  	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
>  		return -EFAULT;
>  
> -	if (ctl.event_id > SWITCHTEC_IOCTL_MAX_EVENTS)
> +	if (ctl.event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
>  		return -EINVAL;
>  
>  	if (ctl.flags & SWITCHTEC_IOCTL_EVENT_FLAG_UNUSED)
> 
