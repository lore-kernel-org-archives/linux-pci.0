Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33750 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbIRVBf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 17:01:35 -0400
Received: by igbkq10 with SMTP id kq10so44548203igb.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 14:01:34 -0700 (PDT)
Date: Fri, 18 Sep 2015 16:01:30 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
	Tianhong Ding <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 1/1] PCI: remove an unnecessary if statement
Message-ID: <20150918210130.GN25767@google.com>
References: <1441881631-5044-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441881631-5044-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 10, 2015 at 06:40:31PM +0800, Zhen Lei wrote:
> This patch have no functional change. Successful return count, otherwise
> return -ENODEV.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied with changelog below to pci/misc for v4.4, thanks!

commit 9222097f0d2f88db602c0340d19d90a1c72b5fec
Author: Zhen Lei <thunder.leizhen@huawei.com>
Date:   Thu Sep 10 18:40:31 2015 +0800

    PCI: Remove unnecessary "if" statement
    
    In store_remove_id(), set the default return value to -ENODEV, and
    overwrite it with the input buffer size if we find a matching list entry.
    Then we don't need to test whether to return an error or the count.
    
    No functional change.
    
    [bhelgaas: changelog]
    Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
> ---
>  drivers/pci/pci-driver.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 52a880c..02919ec 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -172,7 +172,7 @@ static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
>  	__u32 vendor, device, subvendor = PCI_ANY_ID,
>  		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
>  	int fields = 0;
> -	int retval = -ENODEV;
> +	size_t retval = -ENODEV;
> 
>  	fields = sscanf(buf, "%x %x %x %x %x %x",
>  			&vendor, &device, &subvendor, &subdevice,
> @@ -190,15 +190,13 @@ static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
>  		    !((id->class ^ class) & class_mask)) {
>  			list_del(&dynid->node);
>  			kfree(dynid);
> -			retval = 0;
> +			retval = count;
>  			break;
>  		}
>  	}
>  	spin_unlock(&pdrv->dynids.lock);
> 
> -	if (retval)
> -		return retval;
> -	return count;
> +	return retval;
>  }
>  static DRIVER_ATTR(remove_id, S_IWUSR, NULL, store_remove_id);
> 
> --
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
