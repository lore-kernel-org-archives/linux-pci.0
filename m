Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aibo.runbox.com ([91.220.196.211]:37992 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932067AbeBSU4o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Feb 2018 15:56:44 -0500
References: <20180212230457.23181-1-kballou@devnulllabs.io>
From: Kenny Ballou <kballou@devnulllabs.io>
To: linux-pci@vger.kernel.org
Cc: googlegot@yahoo.com, bhelgaas@google.com
Subject: Re: [PATCH] pci: use kstrtobool over ad hoc string parsing
In-reply-to: <20180212230457.23181-1-kballou@devnulllabs.io>
Date: Mon, 19 Feb 2018 13:56:23 -0700
Message-ID: <87eflghf60.fsf@devnulllabs.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 2018年02月12日 23:04 GMT, Kenny Ballou wrote:
> Convert ROM read access enable/disable string parsing to use the
> `kstrtobool` function.
>
> This fixes Bugzilla Bug 111301 -- Sysfs PCI rom file functionality does
> not match documentation.
>
> bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=111301
>
> Reported-by: googlegot@yahoo.com
> Signed-off-by: Kenny Ballou <kballou@devnulllabs.io>
> ---
>  drivers/pci/pci-sysfs.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index eb6bee8724cc..3cde1f25e786 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1424,10 +1424,12 @@ static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if ((off ==  0) && (*buf == '0') && (count == 2))
> -		pdev->rom_attr_enabled = 0;
> -	else
> +	bool res = false;
> +
> +	if (kstrtobool(buf, &res) == 0 && res)
>  		pdev->rom_attr_enabled = 1;
> +	else
> +		pdev->rom_attr_enabled = 0;
>  
>  	return count;
>  }

Bjorn,

How does one know if a patch was accepted?  Should I be monitoring
patchwork?  What's the status of the quoted patch?  Patchwork doesn't
seem to show any changes for this patch.

Regards,
-Kenny
