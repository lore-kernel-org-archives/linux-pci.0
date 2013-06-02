Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:60487 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab3FBAMk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2013 20:12:40 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so5279598obc.16
        for <linux-pci@vger.kernel.org>; Sat, 01 Jun 2013 17:12:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001001ce5e99$2f6c7f90$8e457eb0$@samsung.com>
References: <001001ce5e99$2f6c7f90$8e457eb0$@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 1 Jun 2013 18:12:19 -0600
Message-ID: <CAErSpo4+9wFwWpMtN40fJ6rycA0qoc69ZZQ06oO+xnEfCnvC8w@mail.gmail.com>
Subject: Re: [PATCH] PCI: sysfs: replace strict_strtoul() with kstrtoul()
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 1, 2013 at 1:25 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> The usage of strict_strtoul() is not preferred, because
> strict_strtoul() is obsolete. Thus, kstrtoul() should be
> used.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/misc for v3.11, thanks!

> ---
>  drivers/pci/pci-sysfs.c |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5b4a9d9..0b56e08 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -66,7 +66,7 @@ static ssize_t broken_parity_status_store(struct device *dev,
>         struct pci_dev *pdev = to_pci_dev(dev);
>         unsigned long val;
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         pdev->broken_parity_status = !!val;
> @@ -188,7 +188,7 @@ static ssize_t is_enabled_store(struct device *dev,
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         unsigned long val;
> -       ssize_t result = strict_strtoul(buf, 0, &val);
> +       ssize_t result = kstrtoul(buf, 0, &val);
>
>         if (result < 0)
>                 return result;
> @@ -259,7 +259,7 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
>         struct pci_dev *pdev = to_pci_dev(dev);
>         unsigned long val;
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         /* bad things may happen if the no_msi flag is changed
> @@ -291,7 +291,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
>         unsigned long val;
>         struct pci_bus *b = NULL;
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         if (val) {
> @@ -315,7 +315,7 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
>         unsigned long val;
>         struct pci_dev *pdev = to_pci_dev(dev);
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         if (val) {
> @@ -342,7 +342,7 @@ remove_store(struct device *dev, struct device_attribute *dummy,
>         int ret = 0;
>         unsigned long val;
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         /* An attribute cannot be unregistered by one of its own methods,
> @@ -362,7 +362,7 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
>         unsigned long val;
>         struct pci_bus *bus = to_pci_bus(dev);
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         if (val) {
> @@ -384,7 +384,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>         struct pci_dev *pdev = to_pci_dev(dev);
>         unsigned long val;
>
> -       if (strict_strtoul(buf, 0, &val) < 0)
> +       if (kstrtoul(buf, 0, &val) < 0)
>                 return -EINVAL;
>
>         pdev->d3cold_allowed = !!val;
> @@ -1236,7 +1236,7 @@ static ssize_t reset_store(struct device *dev,
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         unsigned long val;
> -       ssize_t result = strict_strtoul(buf, 0, &val);
> +       ssize_t result = kstrtoul(buf, 0, &val);
>
>         if (result < 0)
>                 return result;
> --
> 1.7.10.4
>
>
