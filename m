Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36052 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbbFSRMx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 13:12:53 -0400
Received: by oigb199 with SMTP id b199so42832018oig.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 10:12:52 -0700 (PDT)
Date: Fri, 19 Jun 2015 12:12:49 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: Use usleep_range() instead of msleep() for
 better accuracy
Message-ID: <20150619171249.GK7710@google.com>
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
 <1434700666-6346-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434700666-6346-4-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 19, 2015 at 03:57:46PM +0800, Yijing Wang wrote:
> Msleep < 20ms can sleep for up to 20ms, see
> Documentation/timers/timers-howto.txt, so we could
> use usleep_range instead.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index daf54be..4553728 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -118,7 +118,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  		}
>  		if (timeout < 0)
>  			break;
> -		msleep(10);
> +		usleep_range(10000, 11000);

timers-howto.txt also says to use msleep for 10ms+ delays, so the guidance
is a bit ambiguous.

This particular delay does not need to be precise, and if we delay 20ms
instead of 10ms (1/50th of a second vs 1/100th of a second), I don't think
it makes any difference at all.

If we *did* make a change here, I think we should use a range of at least
10ms.  There's no need to tighten the wakeup time to the 1ms window between
10ms and 11ms.  Any time in the range of 10ms to 50ms would probably be
fine.

But I don't think a change here is necessary, and it does make it a bit
harder to analyze the code because we have some things in microseconds and
others in milliseconds.

>  		timeout -= 10;
>  	}
>  	return 0;	/* timeout */
> -- 
> 1.7.1
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
