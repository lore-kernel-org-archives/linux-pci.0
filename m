Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41792 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbbKOQLw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2015 11:11:52 -0500
Date: Sun, 15 Nov 2015 08:11:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, wangyijing@huawei.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:pci:hotplug Fix  simple_strtoul is obsolete, use
 kstrtoul instead
Message-ID: <20151115161148.GA12585@roeck-us.net>
References: <1447591435-3957-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447591435-3957-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 15, 2015 at 01:43:55PM +0100, Bogicevic Sasa wrote:
> This fixes messages "simple_strtoul is obsolete, use kstrtoul instead"
> from checkpatch.pl script
> 
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index d379d49..a1160c8 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -103,7 +103,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
>  	u8 power;
>  	int retval = 0;
>  
> -	lpower = simple_strtoul(buf, NULL, 10);
> +	lpower = kstrtoul(buf, NULL, 10);

I take it you did not test this code, since it would probably result
in a crash. Does it even compile ?

Hint: When replacing one function call with another, it helps updating
the parameters.

Guenter
