Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:65022 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3JDSJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 14:09:24 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so10100659iec.32
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 11:09:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
References: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Oct 2013 12:09:03 -0600
Message-ID: <CAErSpo77zy6K3yMa8_31zbrehA6MByXTBbn5Trr8Sv5TL7ScZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: sysfs: Staticize local symbols
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 28, 2013 at 4:12 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Local variables used only in this file are made static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pci/pci-sysfs.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d8eb880..ec1dbea 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -304,7 +304,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
>  }
>  static BUS_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, bus_rescan_store);
>
> -struct attribute *pci_bus_attrs[] = {
> +static struct attribute *pci_bus_attrs[] = {

Did you compile this?  I see this:

drivers/pci/pci-sysfs.c:306:29: error: static declaration of
‘pci_bus_attrs’ follows non-static declaration
drivers/pci/pci.h:159:29: note: previous declaration of ‘pci_bus_attrs’ was here

and there is a use in drivers/pci/pci-driver.c.

I applied this (without the pci_bus_attrs hunk) to my pci/misc branch, thanks!

Bjorn

>         &bus_attr_rescan.attr,
>         NULL,
>  };
> @@ -335,8 +335,9 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
>         }
>         return count;
>  }
> -struct device_attribute dev_rescan_attr = __ATTR(rescan, (S_IWUSR|S_IWGRP),
> -                                                NULL, dev_rescan_store);
> +static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> +                                                       (S_IWUSR|S_IWGRP),
> +                                                       NULL, dev_rescan_store);
>
>  static void remove_callback(struct device *dev)
>  {
> @@ -366,8 +367,9 @@ remove_store(struct device *dev, struct device_attribute *dummy,
>                 count = ret;
>         return count;
>  }
> -struct device_attribute dev_remove_attr = __ATTR(remove, (S_IWUSR|S_IWGRP),
> -                                                NULL, remove_store);
> +static struct device_attribute dev_remove_attr = __ATTR(remove,
> +                                                       (S_IWUSR|S_IWGRP),
> +                                                       NULL, remove_store);
>
>  static ssize_t
>  dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
> @@ -554,7 +556,7 @@ boot_vga_show(struct device *dev, struct device_attribute *attr, char *buf)
>                 !!(pdev->resource[PCI_ROM_RESOURCE].flags &
>                    IORESOURCE_ROM_SHADOW));
>  }
> -struct device_attribute vga_attr = __ATTR_RO(boot_vga);
> +static struct device_attribute vga_attr = __ATTR_RO(boot_vga);
>
>  static ssize_t
>  pci_read_config(struct file *filp, struct kobject *kobj,
> --
> 1.7.9.5
>
