Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
References: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
Date: Wed, 4 Nov 2015 19:01:12 -0800
Message-ID: <CAA93t1prZP+kjao0i93pCD6Fww_KQqcEjek-q8M8zAkzru+upw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Always protect pciehp_disable_slot() with
 hotplug mutex
From: Rajat Jain <rajatxjain@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Geez... I wonder how did I miss it. Thanks for fixing this.
Looks good to me.

Reviewed-by: Rajat Jain <rajatxjain@gmail.com>

On Sun, Nov 1, 2015 at 1:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> When called from pciehp_sysfs_disable_slot(), the call to
> pciehp_disable_slot() was not protected by the hotplug mutex.
>
> Cc: Rajat Jain <rajatxjain@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 4c8f4cde6854..880978b6d534 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -511,7 +511,9 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
>         case STATIC_STATE:
>                 p_slot->state = POWEROFF_STATE;
>                 mutex_unlock(&p_slot->lock);
> +               mutex_lock(&p_slot->hotplug_lock);
>                 retval = pciehp_disable_slot(p_slot);
> +               mutex_unlock(&p_slot->hotplug_lock);
>                 mutex_lock(&p_slot->lock);
>                 p_slot->state = STATIC_STATE;
>                 break;
> --
> 2.1.4
>
