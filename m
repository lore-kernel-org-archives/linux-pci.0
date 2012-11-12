Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab2KLQdw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Nov 2012 11:33:52 -0500
Message-ID: <50A124E3.3050901@redhat.com>
Date: Mon, 12 Nov 2012 11:33:39 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH 4/4] PCI,sriov: provide method to reduce the number of
 total VFs supported
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com> <1352146841-64458-5-git-send-email-ddutile@redhat.com> <CAErSpo7gj7p1=o1GJtaa0_ALO-6M3+AfdMmR1mQc9f6T3T_z3Q@mail.gmail.com>
In-Reply-To: <CAErSpo7gj7p1=o1GJtaa0_ALO-6M3+AfdMmR1mQc9f6T3T_z3Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/10/2012 04:33 PM, Bjorn Helgaas wrote:
> On Mon, Nov 5, 2012 at 1:20 PM, Donald Dutile<ddutile@redhat.com>  wrote:
>> Some implementations of SRIOV provide a capability structure
>> value of TotalVFs that is greater than what the software can support.
>> Provide a method to reduce the capability structure reported value
>> to the value the driver can support.
>> This ensures sysfs reports the current capability of the system,
>> hardware and software.
>> Example for its use: igb&  ixgbe -- report 8&  64 as TotalVFs,
>> but drivers only support 7&  63 maximum.
>>
>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>
> I don't really understand the purpose of pci_sriov_set_totalvfs().  I
> think a driver should enforce its limit at the point where it enables
> the VFs.  I think the driver should do that to be defensive regardless
> of whether we add pci_sriov_set_totalvfs().
>
I received feedback from the driver folks that putting this check
into the core reduces dependencies on drivers doing the right check
at the right time.  It's similar to a similar argument made that the
core ought to call pci_sriov_enable/disable(), and not the driver(s).

> So is this just to make the driver's limit visible to user-space?  How
Yes.
> is it better than having the user specify the number he'd like, and
> having the driver reduce that if necessary?  The user will be able to
> read sriov_numvfs to learn how many the driver enabled, right?
>
Most drivers don't enable-what-can-be-enabled;  the request succeeds for
the number of VFS specified, or it tears all the VFs configured up to the
failure, and returns failure, i.e., all or nothing.  I would tend to agree
with this logic, since SRIOV resources (BARS,MSI, etc.) are architected
as n-resources/VF*num_vfs_enabled.

The primary purpose of the patch set is to drive SRIOV/VF enablement
from userspace.  To simplify userspace, it's best to present to it
what *can* be enabled.  Right now, that's read totalvfs & check numvfs;
Having userspace space do 'trial & error' by 'try this number, nope, ok,
try this number'.... vs. totalvfs = numvfs == num-of-vfs-that-can-be-enabled
seems more predictable.

> If we allow sriov_totalvfs to contain a different number than the
> SR-IOV capability has (as seen via "lspci"), then we have to explain
> to users why they might be different.
>
The difference already has to be explained, since this state already
exists today, and on two of the first SRIOV devices in the market.
Now, if we want to quirk this info vs providing a driver interface,
we can change that part of the design.  The interface lets the driver
(policy) change with the driver vs having to do a driver change & a quirk change.
But, we know it exists from day-1, so it should be handled as cleanly
as possible wrt userspace tools from day-1.

> I'm playing devil's advocate a bit here because I really don't know
> that much about SR-IOV or what the administrative interfaces look
> like.
>
>>   drivers/pci/iov.c       | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-sysfs.c |  4 ++--
>>   drivers/pci/pci.h       |  1 +
>>   include/linux/pci.h     | 10 ++++++++++
>>   4 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index aeccc91..3b4a905 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -735,3 +735,51 @@ int pci_num_vf(struct pci_dev *dev)
>>                  return dev->sriov->nr_virtfn;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_num_vf);
>> +
>> +/**
>> + * pci_sriov_set_totalvfs -- reduce the TotalVFs available
>> + * @dev: the PCI PF device
>> + * numvfs: number that should be used for TotalVFs supported
>> + *
>> + * Should be called from PF driver's probe routine with
>> + * device's mutex held.
>> + *
>> + * Returns 0 if PF is an SRIOV-capable device and
>> + * value of numvfs valid. If not a PF with VFS, return -EINVAL;
>> + * if VFs already enabled, return -EBUSY.
>> + */
>> +int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>> +{
>> +       if (!dev || !dev->is_physfn || (numvfs>  dev->sriov->total))
>> +               return -EINVAL;
>> +
>> +       /* Shouldn't change if VFs already enabled */
>> +       if (dev->sriov->ctrl&  PCI_SRIOV_CTRL_VFE)
>> +               return -EBUSY;
>> +       else
>> +               dev->sriov->drvttl = numvfs;
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
>> +
>> +/**
>> + * pci_sriov_get_totalvfs -- get total VFs supported on this devic3
>> + * @dev: the PCI PF device
>> + *
>> + * For a PCIe device with SRIOV support, return the PCIe
>> + * SRIOV capability value of TotalVFs or the value of drvttl
>> + * if the driver reduced it.  Otherwise, -EINVAL.
>> + */
>> +int pci_sriov_get_totalvfs(struct pci_dev *dev)
>> +{
>> +       if (!dev || !dev->is_physfn)
>> +               return -EINVAL;
>> +
>> +       if (dev->sriov->drvttl)
>> +               return dev->sriov->drvttl;
>> +       else
>> +               return dev->sriov->total;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
>> +
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index cbcdd8d..e9c967f 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -413,7 +413,7 @@ static ssize_t sriov_totalvfs_show(struct device *dev,
>>          u16 total;
>>
>>          pdev = to_pci_dev(dev);
>> -       total = pdev->sriov->total;
>> +       total = pci_sriov_get_totalvfs(pdev);
>>          return sprintf(buf, "%u\n", total);
>>   }
>>
>> @@ -459,7 +459,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>>          }
>>
>>          /* if enabling vf's ... */
>> -       total = pdev->sriov->total;
>> +       total = pci_sriov_get_totalvfs(pdev);
>>          /* Requested VFs to enable<  totalvfs and none enabled already */
>>          if ((num_vfs>  0)&&  (num_vfs<= total)) {
>>                  if (pdev->sriov->nr_virtfn == 0) {
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 6f6cd14..553bbba 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -240,6 +240,7 @@ struct pci_sriov {
>>          u16 stride;             /* following VF stride */
>>          u32 pgsz;               /* page size for BAR alignment */
>>          u8 link;                /* Function Dependency Link */
>> +       u16 drvttl;             /* max num VFs driver supports */
>>          struct pci_dev *dev;    /* lowest numbered PF */
>>          struct pci_dev *self;   /* this PF */
>>          struct mutex lock;      /* lock for VF bus */
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 7ef8fba..1ad8249 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1611,6 +1611,8 @@ extern int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
>>   extern void pci_disable_sriov(struct pci_dev *dev);
>>   extern irqreturn_t pci_sriov_migration(struct pci_dev *dev);
>>   extern int pci_num_vf(struct pci_dev *dev);
>> +extern int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>> +extern int pci_sriov_get_totalvfs(struct pci_dev *dev);
>>   #else
>>   static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
>>   {
>> @@ -1627,6 +1629,14 @@ static inline int pci_num_vf(struct pci_dev *dev)
>>   {
>>          return 0;
>>   }
>> +static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
>> +{
>> +       return 0;
>> +}
>> +static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
>> +{
>> +       return 0;
>> +}
>>   #endif
>>
>>   #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
>> --
>> 1.7.10.2.552.gaa3bb87
>>

