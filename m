Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43990 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbKEFPB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 00:15:01 -0500
Subject: Re: [PATCH] PCI: pciehp: Always protect pciehp_disable_slot() with
 hotplug mutex
To: rajatxjain@gmail.com
References: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
 <CAA93t1o1tFvZDiBNfU62q+sfiykVxKCAs_ZWJ-uDjyEWaLEwoQ@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563AE5D3.3060001@roeck-us.net>
Date: Wed, 4 Nov 2015 21:14:59 -0800
MIME-Version: 1.0
In-Reply-To: <CAA93t1o1tFvZDiBNfU62q+sfiykVxKCAs_ZWJ-uDjyEWaLEwoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/04/2015 06:59 PM, Rajat Jain wrote:
> Geez... I wonder how did I miss it. Thanks for fixing this.
> Looks good to me.
>
Hi Rajat,

easy to miss. I only found it accidentally.

Thanks a lot for the review!

Guenter

> Reviewed-by: Rajat Jain <rajatxjain@gmail.com <mailto:rajatxjain@gmail.com>>
>
> On Sun, Nov 1, 2015 at 1:58 PM, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>
>     When called from pciehp_sysfs_disable_slot(), the call to
>     pciehp_disable_slot() was not protected by the hotplug mutex.
>
>     Cc: Rajat Jain <rajatxjain@gmail.com <mailto:rajatxjain@gmail.com>>
>     Signed-off-by: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
>     ---
>       drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
>       1 file changed, 2 insertions(+)
>
>     diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>     index 4c8f4cde6854..880978b6d534 100644
>     --- a/drivers/pci/hotplug/pciehp_ctrl.c
>     +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>     @@ -511,7 +511,9 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
>              case STATIC_STATE:
>                      p_slot->state = POWEROFF_STATE;
>                      mutex_unlock(&p_slot->lock);
>     +               mutex_lock(&p_slot->hotplug_lock);
>                      retval = pciehp_disable_slot(p_slot);
>     +               mutex_unlock(&p_slot->hotplug_lock);
>                      mutex_lock(&p_slot->lock);
>                      p_slot->state = STATIC_STATE;
>                      break;
>     --
>     2.1.4
>
>

