Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35970 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbbCSP7X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 11:59:23 -0400
Received: by oigv203 with SMTP id v203so68595203oig.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 08:59:23 -0700 (PDT)
Date: Thu, 19 Mar 2015 10:59:20 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rob Herring <robh@kernel.org>, jiang.liu@linux.intel.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: versatile: Fix building error for
 resource_list_for_each_entry
Message-ID: <20150319155920.GG26935@google.com>
References: <1426475463-11352-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426475463-11352-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:11:03AM +0800, Yijing Wang wrote:
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/host/pci-versatile.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index e3a2450..4352ee9 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/resource_ext.h>
>  
>  static void __iomem *versatile_pci_base;
>  static void __iomem *versatile_cfg_base[2];
> @@ -80,7 +81,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	resource_list_for_each_entry(win, res, list) {
> +	resource_list_for_each_entry(win, res) {

This fix appeared in v4.0-rc3 as f1651a242809 ("PCI: versatile: Update for
list_for_each_entry() API change").

Rafael merged it through his tree because I think the problem happened in
872912352c5b ("Merge tag 'pm+acpi-3.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm") where the
conflict resolution changed list_for_each_entry() to
resource_list_for_each_entry() but forgot to drop the extra parameter.

I rebased my "next" branch to v4.0-rc4, which picks up that fix.


>  		struct resource *parent, *res = win->res;
>  
>  		switch (resource_type(res)) {
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
