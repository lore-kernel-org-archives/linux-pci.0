Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47884 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab3JDVJw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 17:09:52 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so10634995iec.32
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 14:09:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380524558-25188-1-git-send-email-wangyijing@huawei.com>
References: <1380524558-25188-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Oct 2013 15:09:31 -0600
Message-ID: <CAErSpo5K0sMtg6OnK+Ve_8LDe7axspDvTGxeKNVbgUYzdWNmsg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Introudce pci_dev_show_local_cpu() to simplify code
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 30, 2013 at 1:02 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Local_cpus_show() and local_cpulist_show() are almost the same,
> introudce a new helper function pci_dev_show_local_cpu() to simplify
> code.
>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/misc, thanks!

Bjorn

> ---
>  drivers/pci/pci-sysfs.c |   32 +++++++++++++++-----------------
>  1 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7128cfd..3b41405 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -74,9 +74,11 @@ static ssize_t broken_parity_status_store(struct device *dev,
>         return count;
>  }
>
> -static ssize_t local_cpus_show(struct device *dev,
> -                       struct device_attribute *attr, char *buf)
> -{
> +static ssize_t pci_dev_show_local_cpu(struct device *dev,
> +               int type,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
>         const struct cpumask *mask;
>         int len;
>
> @@ -86,29 +88,25 @@ static ssize_t local_cpus_show(struct device *dev,
>  #else
>         mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
>  #endif
> -       len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
> +       len = type ?
> +               cpumask_scnprintf(buf, PAGE_SIZE-2, mask) :
> +               cpulist_scnprintf(buf, PAGE_SIZE-2, mask);
> +
>         buf[len++] = '\n';
>         buf[len] = '\0';
>         return len;
>  }
>
> +static ssize_t local_cpus_show(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
> +{
> +       return pci_dev_show_local_cpu(dev, 1, attr, buf);
> +}
>
>  static ssize_t local_cpulist_show(struct device *dev,
>                         struct device_attribute *attr, char *buf)
>  {
> -       const struct cpumask *mask;
> -       int len;
> -
> -#ifdef CONFIG_NUMA
> -       mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> -                                         cpumask_of_node(dev_to_node(dev));
> -#else
> -       mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
> -#endif
> -       len = cpulist_scnprintf(buf, PAGE_SIZE-2, mask);
> -       buf[len++] = '\n';
> -       buf[len] = '\0';
> -       return len;
> +       return pci_dev_show_local_cpu(dev, 0, attr, buf);
>  }
>
>  /*
> --
> 1.7.1
>
>
