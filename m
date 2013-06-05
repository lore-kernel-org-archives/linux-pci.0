Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:57362 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3FEScZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 14:32:25 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so1412384oag.41
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2013 11:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369974092-11450-3-git-send-email-jiang.liu@huawei.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com> <1369974092-11450-3-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Jun 2013 12:32:04 -0600
Message-ID: <CAErSpo7QspthZ31WadyLx6aSD_JD=YWibpzcNv=GMX7kjttbqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Hide remove and rescan sysfs interfaces for
 SR-IOV virtual functions
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 30, 2013 at 10:21 PM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Jiang Liu <liuj97@gmail.com>
>
> PCI devices for SR-IOV virtual functions should only be created/
> destroyed by pci_enable_sriov()/pci_disable_sriov() because special
> data structures are associated with SR-IOV virtual functions.
> So hide hotplug related sysfs interfaces "remove" and "rescan" for
> SR-IOV virtual functions, otherwise it may causes memory leakage
> and other issues.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Donald Dutile <ddutile@redhat.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Ram Pai <linuxram@us.ibm.com>

Applied to my -next branch for v3.11, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5b4a9d9..403da60 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -325,6 +325,8 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
>         }
>         return count;
>  }
> +struct device_attribute dev_rescan_attr = __ATTR(rescan, (S_IWUSR|S_IWGRP),
> +                                                NULL, dev_rescan_store);
>
>  static void remove_callback(struct device *dev)
>  {
> @@ -354,6 +356,8 @@ remove_store(struct device *dev, struct device_attribute *dummy,
>                 count = ret;
>         return count;
>  }
> +struct device_attribute dev_remove_attr = __ATTR(remove, (S_IWUSR|S_IWGRP),
> +                                                NULL, remove_store);
>
>  static ssize_t
>  dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
> @@ -504,8 +508,6 @@ struct device_attribute pci_dev_attrs[] = {
>         __ATTR(broken_parity_status,(S_IRUGO|S_IWUSR),
>                 broken_parity_status_show,broken_parity_status_store),
>         __ATTR(msi_bus, 0644, msi_bus_show, msi_bus_store),
> -       __ATTR(remove, (S_IWUSR|S_IWGRP), NULL, remove_store),
> -       __ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_rescan_store),
>  #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
>         __ATTR(d3cold_allowed, 0644, d3cold_allowed_show, d3cold_allowed_store),
>  #endif
> @@ -1463,6 +1465,29 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>         return a->mode;
>  }
>
> +static struct attribute *pci_dev_hp_attrs[] = {
> +       &dev_remove_attr.attr,
> +       &dev_rescan_attr.attr,
> +       NULL,
> +};
> +
> +static umode_t pci_dev_hp_attrs_are_visible(struct kobject *kobj,
> +                                               struct attribute *a, int n)
> +{
> +       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +
> +       if (pdev->is_virtfn)
> +               return 0;
> +
> +       return a->mode;
> +}
> +
> +static struct attribute_group pci_dev_hp_attr_group = {
> +       .attrs = pci_dev_hp_attrs,
> +       .is_visible = pci_dev_hp_attrs_are_visible,
> +};
> +
>  #ifdef CONFIG_PCI_IOV
>  static struct attribute *sriov_dev_attrs[] = {
>         &sriov_totalvfs_attr.attr,
> @@ -1494,6 +1519,7 @@ static struct attribute_group pci_dev_attr_group = {
>
>  static const struct attribute_group *pci_dev_attr_groups[] = {
>         &pci_dev_attr_group,
> +       &pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
>         &sriov_dev_attr_group,
>  #endif
> --
> 1.8.1.2
>
