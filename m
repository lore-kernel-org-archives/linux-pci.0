Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2KAVKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 Nov 2012 17:10:46 -0400
Message-ID: <5092E54C.5080105@redhat.com>
Date: Thu, 01 Nov 2012 17:10:36 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Ben Hutchings <bhutchings@solarflare.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 3/4] PCI,sys: SRIOV control and status via sysfs
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>  <1351718353-6124-4-git-send-email-ddutile@redhat.com> <1351727268.2706.48.camel@bwh-desktop.uk.solarflarecom.com>
In-Reply-To: <1351727268.2706.48.camel@bwh-desktop.uk.solarflarecom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 07:47 PM, Ben Hutchings wrote:
> On Wed, 2012-10-31 at 17:19 -0400, Donald Dutile wrote:
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
>> sriov_totalvfs -- cat-ing this file returns the maximum number
>>                    of VFs a PCIe device supports as reported by
>>                    the TotalVFs in the SRIOV ext cap structure.
>> sriov_numvfs -- echo'ing a positive number to this file enables this
>>                  number of VFs for this given PCIe device.
>>               -- echo'ing a 0 to this file disables
>>                  any previously enabled VFs for this PCIe device.
>>               -- cat-ing this file will return the number of VFs
>>                  currently enabled on this PCIe device, i.e.,
>>                  the NumVFs field in SRIOV ext. cap structure.
>>
>> VF enable and disablement is invoked much like other PCIe
>> configuration functions -- via registered callbacks in the driver,
>> i.e., probe, release, etc.
>>
>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/pci.h     |   1 +
>>   2 files changed, 136 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index fbbb97f..83be8ce 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
> [...]
>> +static ssize_t sriov_numvfs_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct pci_dev *pdev;
>> +	int num_vfs_enabled = 0;
>> +	int num_vfs;
>> +	int ret = 0;
>> +	u16 total;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	if (kstrtoint(buf, 0,&num_vfs)<  0)
>> +		return -EINVAL;
>> +
>> +	/* is PF driver loaded w/callback */
>> +	if (!pdev->driver || !pdev->driver->sriov_configure) {
>> +		dev_info(&pdev->dev,
>> +			 "Driver doesn't support SRIOV configuration via sysfs\n");
>> +		return -ENOSYS;
>> +	}
>> +
>> +	/* if enabling vf's ... */
>> +	total = pdev->sriov->total;
>> +	/* Requested VFs to enable<  totalvfs and none enabled already */
>> +	if ((num_vfs>  0)&&  (num_vfs<= total)) {
>> +		if (pdev->sriov->nr_virtfn == 0) {
>> +			num_vfs_enabled =
>> +				pdev->driver->sriov_configure(pdev, num_vfs);
>> +			if ((num_vfs_enabled>= 0)&&
>> +			    (num_vfs_enabled != num_vfs))
>> +				dev_warn(&pdev->dev,
>> +					 "Only %d VFs enabled\n",
>> +					 num_vfs_enabled);
>> +			return count;
>
> If num_vfs_enabled<  0 then it's an error value which should be returned
> instead of count.
>
> [...]
agreed. will update.

>> @@ -1409,7 +1512,7 @@ static struct attribute *pci_dev_dev_attrs[] = {
>>   };
>>
>>   static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>> -						struct attribute *a, int n)
>> +					 struct attribute *a, int n)
>>   {
>>   	struct device *dev = container_of(kobj, struct device, kobj);
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>
> This hunk should be folded into patch 1.
>
i removed it.  will do a cleanup of this file in another patch.

>> @@ -1421,6 +1524,33 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>   	return a->mode;
>>   }
>>
>> +#ifdef CONFIG_PCI_IOV
>> +static struct attribute *sriov_dev_attrs[] = {
>> +	&sriov_totalvfs_attr.attr,
>> +	&sriov_numvfs_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static umode_t sriov_attrs_are_visible(struct kobject *kobj,
>> +					 struct attribute *a, int n)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +
>> +	if ((a ==&sriov_totalvfs_attr.attr) ||
>> +	    (a ==&sriov_numvfs_attr.attr)) {
>> +		if (!dev_is_pf(dev))
>> +			return 0;
>> +	}
>
> Why do you check the attribute address?  The whole group should be
> visible or invisible depending on dev_is_pf().  Any attributes that need
> another condition belong in another group.
>
agreed.  it's a leftover design when it was part of the uber pci-dev attrs,
but now that it's separate, dev_is_pf() is sufficient.
good cleanup.

>> +	return a->mode;
>> +}
>> +
>> +static struct attribute_group sriov_dev_attr_group = {
>> +	.attrs = sriov_dev_attrs,
>> +	.is_visible = sriov_attrs_are_visible,
>> +};
>> +#endif /* CONFIG_PCI_IOV */
> [...]
>

