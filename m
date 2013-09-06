Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f176.google.com ([209.85.213.176]:34441 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3IFW6j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 18:58:39 -0400
Received: by mail-ye0-f176.google.com with SMTP id m4so1240165yen.21
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 15:58:39 -0700 (PDT)
Date: Fri, 6 Sep 2013 16:58:35 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rob Landley <rob@landley.net>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] PCI: clean up pci_find_slot() in pci.txt
Message-ID: <20130906225835.GA12956@google.com>
References: <1378103680-42500-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378103680-42500-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 02, 2013 at 02:34:40PM +0800, Yijing Wang wrote:
> Pci_find_slot() has been removed from the kernel,
> clean up its description in pci.txt
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to my pci/misc branch for v3.13.  Thanks!

> ---
>  Documentation/PCI/pci.txt |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
> index bccf602..ac39338 100644
> --- a/Documentation/PCI/pci.txt
> +++ b/Documentation/PCI/pci.txt
> @@ -525,8 +525,10 @@ corresponding register block for you.
>  6. Other interesting functions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -pci_find_slot()			Find pci_dev corresponding to given bus and
> -				slot numbers.
> +pci_get_domain_bus_and_slot()	Find pci_dev corresponding to given domain,
> +                        bus and slot and number. If the device is
> +                        found, its reference count is increased and
> +                        return the pci_dev pointer.

I fixed this indentation to match the surrounding text.

>  pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
>  pci_find_capability()		Find specified capability in device's capability
>  				list.
> @@ -582,7 +584,6 @@ having sane locking.
>  
>  pci_find_device()	Superseded by pci_get_device()
>  pci_find_subsys()	Superseded by pci_get_subsys()
> -pci_find_slot()		Superseded by pci_get_slot()

I kept this mention and updated the replacement to be
pci_get_domain_bus_and_slot().  The whole point of this section is
to describe things that are no longer in the kernel but might be
seen in old drivers.

>  
>  The alternative is the traditional PCI device driver that walks PCI
> -- 
> 1.7.1
> 
> 
