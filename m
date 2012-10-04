Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab2JDWuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Oct 2012 18:50:20 -0400
Message-ID: <506E12A1.6000501@redhat.com>
Date: Thu, 04 Oct 2012 18:50:09 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
References: <1349388885-43938-1-git-send-email-ddutile@redhat.com> <CAE9FiQWBq3seKZgqT7B=JKCovu4vOYuK0XYC+MvBgK5VWu1rbg@mail.gmail.com>
In-Reply-To: <CAE9FiQWBq3seKZgqT7B=JKCovu4vOYuK0XYC+MvBgK5VWu1rbg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for adding Greg k-h to the thread...
(sorry about that omission on git send-email, Greg!)

On 10/04/2012 06:30 PM, Yinghai Lu wrote:
> On Thu, Oct 4, 2012 at 3:14 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>> Provide files under sysfs to determine the max number of vfs
>> an SRIOV-capable PCIe device supports, and methods to enable and
>> disable the vfs on a per device basis.
>>
>> Currently, VF enablement by SRIOV-capable PCIe devices is done
>> in driver-specific module parameters.  If not setup in modprobe files,
>> it requires admin to unload&  reload PF drivers with number of desired
>> VFs to enable.  Additionally, the enablement is system wide: all
>> devices controlled by the same driver have the same number of VFs
>> enabled.  Although the latter is probably desired, there are PCI
>> configurations setup by system BIOS that may not enable that to occur.
>>
>> Three files are created if a PCIe device has SRIOV support:
>> sriov_max_vfs -- cat-ing this file returns the maximum number
>>                   of VFs a PCIe device supports.
>> sriov_enable_vfs -- echo'ing a number to this file enables this
>>                      number of VFs for this given PCIe device.
>>                   -- cat-ing this file will return the number of VFs
>>                      currently enabled on this PCIe device.
>> sriov_disable_vfs -- echo-ing any number other than 0 disables all
>>                       VFs associated with this PCIe device.
>>
>> VF enable and disablement is invoked much like other PCIe
>> configuration functions -- via registered callbacks in the driver,
>> i.e., probe, release, etc.
>>
>> v1->v2:
>> This patch is based on previous 2 patches by Yinghai Lu
>> that cleaned up the vga attributes for PCI devices under sysfs,
>> and uses visibility-checking group attributes as recommended by
>> Greg K-H.
>>
>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/pci.h     |   2 +
>>   2 files changed, 154 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index fbbb97f..e6522c2 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -404,6 +404,128 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>>   }
>>   #endif
>>
>> +bool pci_dev_has_sriov(struct pci_dev *pdev)
>> +{
>> +        int ret = false;
>> +        int pos;
>> +
>> +        if (!pci_is_pcie(pdev))
>> +                goto out;
>> +
>> +        pos =  pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
>> +        if (pos)
>> +                ret = true;
>> +out:
>> +        return ret;
>> +}
>
> should use dev_is_pf?
>
No.  Only want the files to show up on pf's with sriov cap.
dev_is_pf will have the files show up on non-sriov-capable devices.

> cap does not mean you have sriov_init return successfully.
>
will find out if sriov-init fails if driver's sriov-enable callback fails!
could add a flag & check for sriov-init success...

>> +
>> +#ifdef CONFIG_PCI_IOV
>> +static ssize_t sriov_max_vfs_show(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  char *buf)
>> +{
>> +        struct pci_dev *pdev;
>> +
>> +        pdev = to_pci_dev(dev);
>> +        return sprintf (buf, "%u\n", pdev->sriov->total);
>> +}
>> +
>> +
>> +static ssize_t sriov_enable_vfs_show(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{
>> +        struct pci_dev *pdev;
>> +
>> +        pdev = to_pci_dev(dev);
>> +
>> +        return sprintf (buf, "%u\n", pdev->sriov->nr_virtfn);
>> +}
>> +
>> +static ssize_t sriov_enable_vfs_store(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf, size_t count)
>> +{
>> +        struct pci_dev *pdev;
>> +        int num_vf_enabled = 0;
>> +        unsigned long num_vfs;
>> +        pdev = to_pci_dev(dev);
>> +
>> +        /* Requested VFs to enable<  max_vfs
>> +         * and none enabled already
>> +         */
>> +        if (strict_strtoul(buf, 0,&num_vfs)<  0)
>> +               return -EINVAL;
>
> checkpatch.pl should ask you to change to kstrtoul instead.
>
ok, thanks.  i saw strict_strtoul() used elsewhere, but
glad to update.

>> +
>> +        if ((num_vfs>  pdev->sriov->total) ||
>> +            (pdev->sriov->nr_virtfn != 0))
>> +                return -EINVAL;
>> +
>> +        /* Ready for lift-off! */
>> +        if (pdev->driver&&  pdev->driver->sriov_enable) {
>> +                num_vf_enabled = pdev->driver->sriov_enable(pdev, num_vfs);
>> +        }
>> +
>> +        if (num_vf_enabled != num_vfs)
>> +                printk(KERN_WARNING
>> +                        "%s: %04x:%02x:%02x.%d: Only %d VFs enabled \n",
>> +                        pci_name(pdev), pci_domain_nr(pdev->bus),
>> +                        pdev->bus->number, PCI_SLOT(pdev->devfn),
>> +                        PCI_FUNC(pdev->devfn), num_vf_enabled);
>> +
>> +        return count;
>
> do you need pci_remove_rescan_mutex ?
>
I saw that in your patch set; wondering if i need to now that the
files are added in sysfs device attribute framework, which would have
same race for other attributes, I would think.  Thus, I didn't add it.
Greg?

> also that enable could take a while ..., may need to use
> device_schedule_callback to start one callback.
>
agreed, but device_schedule_callback doesn't allow a parameter
to be passed. only way I can think to get around it is to
put the requested-num-vf's in the pci-(pf)-dev structure,
and have the pf driver pluck it from there.
other way to pass num-vf-to-enable?

>
>> +}
>> +
>> +static ssize_t sriov_disable_vfs_store(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       const char *buf, size_t count)
>> +{
>> +        struct pci_dev *pdev;
>> +       int ret = 0;
>> +
>> +        pdev = to_pci_dev(dev);
>> +
>> +        /* make sure sriov device&  at least 1 vf enabled */
>> +        if (pdev->sriov->nr_virtfn == 0) {
>> +               ret = -ENODEV;
>> +                goto out;
>> +       }
>> +
>> +        /* Ready for landing! */
>> +       /* Note: Disabling VF can fail if VF assigned to virtualized guest */
>> +        if (pdev->driver&&  pdev->driver->sriov_disable) {
>> +                ret = pdev->driver->sriov_disable(pdev);
>> +        }
>> +out:
>> +        return ret ? ret : count;
>> +}
>> +#else
>> +static ssize_t sriov_max_vfs_show(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  char *buf)
>> +{ return 0; }
>> +static ssize_t sriov_enable_vfs_show(struct device *dev,
>> +                                     struct device_attribute *attr,
>> +                                     char *buf)
>> +{ return 0; }
>> +static ssize_t sriov_enable_vfs_store(struct device *dev,
>> +                                      struct device_attribute *attr,
>> +                                      const char *buf, size_t count)
>> +{ return count; }
>> +static ssize_t sriov_disable_vfs_store(struct device *dev,
>> +                                       struct device_attribute *attr,
>> +                                       const char *buf, size_t count)
>> +{ return count; }
>> +#endif /* CONFIG_PCI_IOV */
>> +
>> +static struct device_attribute sriov_max_vfs_attr = __ATTR_RO(sriov_max_vfs);
>> +static struct device_attribute sriov_enable_vfs_attr =
>> +               __ATTR(sriov_enable_vfs, (S_IRUGO|S_IWUSR|S_IWGRP),
>> +                       sriov_enable_vfs_show, sriov_enable_vfs_store);
>> +static struct device_attribute sriov_disable_vfs_attr =
>> +               __ATTR(sriov_disable_vfs, (S_IWUSR|S_IWGRP),
>> +                       NULL, sriov_disable_vfs_store);
>> +
>>   struct device_attribute pci_dev_attrs[] = {
>>          __ATTR_RO(resource),
>>          __ATTR_RO(vendor),
>> @@ -1408,8 +1530,15 @@ static struct attribute *pci_dev_dev_attrs[] = {
>>          NULL,
>>   };
>>
>> +static struct attribute *sriov_dev_attrs[] = {
>> +&sriov_max_vfs_attr.attr,
>> +&sriov_enable_vfs_attr.attr,
>> +&sriov_disable_vfs_attr.attr,
>> +       NULL,
>> +};
>> +
>>   static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>> -                                               struct attribute *a, int n)
>> +                                        struct attribute *a, int n)
>>   {
>>          struct device *dev = container_of(kobj, struct device, kobj);
>>          struct pci_dev *pdev = to_pci_dev(dev);
>> @@ -1421,13 +1550,35 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>          return a->mode;
>>   }
>>
>> +static umode_t sriov_attrs_are_visible(struct kobject *kobj,
>> +                                        struct attribute *a, int n)
>> +{
>> +       struct device *dev = container_of(kobj, struct device, kobj);
>> +       struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +       if ((a ==&sriov_max_vfs_attr.attr) ||
>> +           (a ==&sriov_enable_vfs_attr.attr) ||
>> +           (a ==&sriov_disable_vfs_attr.attr)) {
>> +               if (!pci_dev_has_sriov(pdev))
>> +                       return 0;
>> +       }
>> +
>> +       return a->mode;
>> +}
>> +
>>   static struct attribute_group pci_dev_attr_group = {
>>          .attrs = pci_dev_dev_attrs,
>>          .is_visible = pci_dev_attrs_are_visible,
>>   };
>>
>> +static struct attribute_group sriov_dev_attr_group = {
>> +       .attrs = sriov_dev_attrs,
>> +       .is_visible = sriov_attrs_are_visible,
>
> you could fold contents in sriov_dev_attrs and sriov_attrs_are_visible into
> pci_dev_dev_attrs and pci_dev_attrs_are_visible.
>
Yes, I did that originally, but since you had
the attr_groups[] below, I figured you wanted it separate,
and it makes clear division for other cleanup (pm attributes?).

>> +};
>> +
>>   static const struct attribute_group *pci_dev_attr_groups[] = {
>>          &pci_dev_attr_group,
>> +&sriov_dev_attr_group,
>>          NULL,
>>   };
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index be1de01..b3e25a8 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -595,6 +595,8 @@ struct pci_driver {
>>          int  (*resume_early) (struct pci_dev *dev);
>>          int  (*resume) (struct pci_dev *dev);                   /* Device woken up */
>>          void (*shutdown) (struct pci_dev *dev);
>> +       int (*sriov_enable) (struct pci_dev *dev, int num_vfs);    /* PF pci dev */
>> +       int (*sriov_disable) (struct pci_dev *dev);
>>          const struct pci_error_handlers *err_handler;
>>          struct device_driver    driver;
>>          struct pci_dynids dynids;
>> --
>> 1.7.10.2.552.gaa3bb87
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for prompt review & feedback.
I'll wait for other feedback b4 spinning a final PATCH.
