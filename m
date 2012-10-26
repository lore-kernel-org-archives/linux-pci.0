Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078Ab2JZPHN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Oct 2012 11:07:13 -0400
Message-ID: <508AA719.2060705@redhat.com>
Date: Fri, 26 Oct 2012 11:07:05 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/8] PCI: sysfs per device SRIOV control and status
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>  <1351190310-5043-4-git-send-email-ddutile@redhat.com> <1351196234.2662.37.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1351196234.2662.37.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/2012 04:17 PM, Ben Hutchings wrote:
> On Thu, 2012-10-25 at 14:38 -0400, Donald Dutile wrote:
> [...]
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -14,6 +14,7 @@
>>    *
>>    */
>>
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* has to precede printk.h */
>>
>>   #include<linux/kernel.h>
>>   #include<linux/sched.h>
>> @@ -66,7 +67,7 @@ static ssize_t broken_parity_status_store(struct device *dev,
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	unsigned long val;
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	pdev->broken_parity_status = !!val;
>> @@ -188,7 +189,7 @@ static ssize_t is_enabled_store(struct device *dev,
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	unsigned long val;
>> -	ssize_t result = strict_strtoul(buf, 0,&val);
>> +	ssize_t result = kstrtoul(buf, 0,&val);
>>
>>   	if (result<  0)
>>   		return result;
>> @@ -259,7 +260,7 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	unsigned long val;
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	/* bad things may happen if the no_msi flag is changed
>> @@ -292,7 +293,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
>>   	unsigned long val;
>>   	struct pci_bus *b = NULL;
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	if (val) {
>> @@ -316,7 +317,7 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
>>   	unsigned long val;
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	if (val) {
>> @@ -343,7 +344,7 @@ remove_store(struct device *dev, struct device_attribute *dummy,
>>   	int ret = 0;
>>   	unsigned long val;
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	/* An attribute cannot be unregistered by one of its own methods,
>> @@ -363,7 +364,7 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
>>   	unsigned long val;
>>   	struct pci_bus *bus = to_pci_bus(dev);
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	if (val) {
>> @@ -387,7 +388,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	unsigned long val;
>>
>> -	if (strict_strtoul(buf, 0,&val)<  0)
>> +	if (kstrtoul(buf, 0,&val)<  0)
>>   		return -EINVAL;
>>
>>   	pdev->d3cold_allowed = !!val;
>
> All this cleanup belongs in a separate patch.
Yes.  Multiple people were getting anxious to see this V3, so I wanted
to get it out for review of its direction.
I did a checkpatch.pl run after I posted... ugh! what a mess!
you note a number of the issues below.

>
>> @@ -404,6 +405,114 @@ static ssize_t d3cold_allowed_show(struct device *dev,
>>   }
>>   #endif
>>
>> +#ifdef CONFIG_PCI_IOV
>> +static ssize_t sriov_totalvfs_show(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  char *buf)
>> +{
>> +	struct pci_dev *pdev;
>> +	u16 total;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	total = pdev->sriov->total;
>> +	return sprintf (buf, "%u\n", total);
>
> No space after sprintf, please.
>
yep, checkpatch...

>> +}
>> +
>> +
>> +static ssize_t sriov_numvfs_show(struct device *dev,
>> +                                 struct device_attribute *attr,
>> +                                 char *buf)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	return sprintf (buf, "%u\n", pdev->sriov->nr_virtfn);
>> +}
>> +
>> +/*
>> + * num_vfs>  0; number of vfs to enable
>> + * num_vfs = 0; disable all vfs
>> + *
>> + * Note: SRIOV spec doesn't allow partial VF
>> + *       disable, so its all or none.
>> + */
>> +static ssize_t sriov_numvfs_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +	struct pci_dev *pdev;
>> +	int num_vfs_enabled = 0;
>> +	int num_vfs;
>> +	int ret = 0;
>> +	u16 total;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	/* Requested VFs to enable<  totalvfs
>> +	 * and none enabled already
>> +	 */
>> +	if (kstrtoint(buf, 0,&num_vfs)<  0)
>> +		return -EINVAL;
>
> The above comment belongs with
> 'if ((num_vfs>  0)&&  (num_vfs<= total))'.
>
yes, forgot to move it. thanks!

>> +	/* is PF driver loaded w/callback */
>> +	if (!pdev->driver || !pdev->driver->sriov_configure) {
>> +		pr_info("Driver doesn't support sriov configuration via sysfs \n");
>> +		return -ENOSYS;
>
> Use dev_err() to set the proper severity and provide context.  Not sure
> whether this is the right error code.
>
well, i used pr_info() b/c that was what I was requested to do
when I did similar cleanup in the dmar.c file recently.  I
can change to dev_*() formatting.

>> +	}
>> +
>> +	/* if enabling vf's ... */
>> +	total = pdev->sriov->total;
>> +	if ((num_vfs>  0)&&  (num_vfs<= total)) {
>> +		if (pdev->sriov->nr_virtfn == 0) { /* if not already enabled */
>> +		    num_vfs_enabled = pdev->driver->sriov_configure(pdev, num_vfs);
>> +        	    if ((num_vfs_enabled>= 0)&&  (num_vfs_enabled != num_vfs))
>> +			pr_warn("%s: %04x:%02x:%02x.%d: Only %d VFs enabled \n",
>> +                        	pdev->dev.driver->name, pci_domain_nr(pdev->bus),
>> +                        	pdev->bus->number, PCI_SLOT(pdev->devfn),
>> +                        	PCI_FUNC(pdev->devfn), num_vfs_enabled);
>
> Use dev_warn(), don't try to replicate it.
>
ditto.

>> +			return count;
>> +		} else {
>> +			pr_warn("VFs already enabled. Disable before re-enabling\n");
>> +			return -EINVAL;
>
> It would be helpful to make an 'enable' write succeed when
> num_vfs == pdev->sriov->nr_virtfn.
>
ah, functional feedback!
yes, setting numvfs == existing value could reply success,
but I had it this way since it could show a programming error
with a mgmt tool that is trying to do the enable when it
should not, or already had, and a successful return may be interpreted
as a correctness in the mgmt app's logic. .... I could go either way.
I'll wait for other feedback on this to see which way the
group wants to have it.

>> +		}
>> +	}
>> +
>> +	/* disable vfs */
>> +	if (num_vfs == 0) {
>> +		if (pdev->sriov->nr_virtfn != 0) {
>> +			ret = pdev->driver->sriov_configure(pdev, 0);
>> +			return ret ? ret: count;
>> +		} else {
>> +			pr_err("Disable failed since no VFs enabled\n");
>> +			return -EINVAL;
>
> This definitely should be treated as successful, not an error.
>
Same comment as above.  it could be considered successful,
or it could be considered a rtn for programming logic error
of a mgmt app. again, I could go either way. ditto above.

>> +		}
>> +	}
>> +
>> +	pr_err("Invalid value for number of VFs to enable: %d\n", num_vfs);
>> +
>> +	return -EINVAL;
>> +}
>> +#else
>> +static ssize_t sriov_totalvfs_show(struct device *dev,
>> +                                   struct device_attribute *attr,
>> +                                   char *buf)
>> +{ return 0; }
>> +static ssize_t sriov_numvfs_show(struct device *dev,
>> +			         struct device_attribute *attr,
>> +			         char *buf)
>> +{ return 0; }
>
> Shouldn't these print "0\n"?
>
agree.

>> +static ssize_t sriov_numvfs_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{ return count; }
>> +#endif /* CONFIG_PCI_IOV */
>> +
>> +static struct device_attribute sriov_totalvfs_attr = __ATTR_RO(sriov_totalvfs);
>> +static struct device_attribute sriov_numvfs_attr =
>> +		__ATTR(sriov_numvfs, (S_IRUGO|S_IWUSR|S_IWGRP),
>> +                	sriov_numvfs_show, sriov_numvfs_store);
>
> sriov_numvfs should be read-only if !CONFIG_PCI_IOV, rather than
> ignoring writes.
>
If !CONFIG_PCI_IOV, none of these attributes are visible,
so they won't exist.

>>   struct device_attribute pci_dev_attrs[] = {
>>   	__ATTR_RO(resource),
>>   	__ATTR_RO(vendor),
>> @@ -1194,7 +1303,7 @@ static ssize_t reset_store(struct device *dev,
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	unsigned long val;
>> -	ssize_t result = strict_strtoul(buf, 0,&val);
>> +	ssize_t result = kstrtoul(buf, 0,&val);
>>
>>   	if (result<  0)
>>   		return result;
>> @@ -1408,8 +1517,14 @@ static struct attribute *pci_dev_dev_attrs[] = {
>>   	NULL,
>>   };
>>
>> +static struct attribute *sriov_dev_attrs[] = {
>> +&sriov_totalvfs_attr.attr,
>> +&sriov_numvfs_attr.attr,
>
> These are wrongly indented with spaces.
>
checkpatch!

>> +	NULL,
>> +};
>> +
>>   static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>> -						struct attribute *a, int n)
>> +					 struct attribute *a, int n)
>>   {
>>   	struct device *dev = container_of(kobj, struct device, kobj);
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>> @@ -1421,13 +1536,33 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>   	return a->mode;
>>   }
>>
>> +static umode_t sriov_attrs_are_visible(struct kobject *kobj,
>> +					 struct attribute *a, int n)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +
>> +	if ((a ==&sriov_totalvfs_attr.attr) ||
>> +	    (a ==&sriov_numvfs_attr.attr)) {
>> +		if (!dev_is_pf(dev))
>> +			return 0;
> [...]
>
> An odd thing about dev_is_pf() is that if !CONFIG_PCI_IOV then it is
> false for all devices.  Which means that the dummy attribute reader
> functions will actually be dead code.  I think that either dev_is_pf()
> should be fixed to be accurate when !CONFIG_PCI_IOV, or the attributes
> should be completely removed if !CONFIG_PCI_IOV.
>
> Ben.
>
Since it's all in the same file, I could wrap the following code with
CONFIG_PCI_IOV:

static const struct attribute_group *pci_dev_attr_groups[] = {
         &pci_dev_attr_group,
#ifdef CONFIG_PCI_IOV
         &sriov_dev_attr_group,
#endif
         NULL,
};

and then the dummy attribute function could be removed.
another good cleanup, thanks!

Thanks for the thorough review of the above!


Ok, my turn:
Any feedback on having the sysfs configure call pci_sriov_[enable/disable](),
as well as do the don't-disable if VFs are assigned to guests?


