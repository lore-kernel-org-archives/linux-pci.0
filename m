Return-Path: <linux-kernel-owner@vger.kernel.org>
From: ebiederm@xmission.com (Eric W. Biederman)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
	<20150917154424.GI25767@google.com>
Date: Thu, 17 Sep 2015 10:49:06 -0500
In-Reply-To: <20150917154424.GI25767@google.com> (Bjorn Helgaas's message of
	"Thu, 17 Sep 2015 10:44:24 -0500")
Message-ID: <874mitxczx.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> On Sun, Sep 06, 2015 at 06:32:35PM +0300, Michael S. Tsirkin wrote:
>> On some hypervisors, virtio devices tend to generate spurious interrupts
>> when switching between MSI and non-MSI mode.  Normally, either MSI or
>> non-MSI is used and all is well, but during shutdown, linux disables MSI
>> which then causes an "irq %d: nobody cared" message, with irq being
>> subsequently disabled.
>> 
>> Since bus mastering is already disabled at this point, disabling MSI
>> isn't actually useful for spec compliant devices: MSI interrupts are
>> in-bus memory writes so disabling Bus Master (which is already done)
>> disables these as well: after some research, it appears to be there for
>> the benefit of devices that ignore the bus master bit.
>> 
>> As it's not clear how common this kind of bug is, this patch simply adds
>> a quirk, to be set by devices that wish to skip disabling msi on
>> shutdown, relying on bus master instead.
>> 
>> We set this quirk in virtio core.
>> 
>> Reported-by: Fam Zheng <famz@redhat.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Yinghai Lu <yhlu.kernel.send@gmail.com>
>> Cc: Ulrich Obergfell <uobergfe@redhat.com>
>> Cc: Rusty Russell <rusty@rustcorp.com.au>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Eric, what do you think of this?  You had many comments on previous
> versions.

I still think it is a hack to avoid actually fixing a driver.

I think the hack is better as a quirk.  I think the quirk would tend to
be better if it was limited to whatever set of hypervisors where this is
actually a problem.

And of course given that on any sane configuration we have the irq
watchdog I don't see what this is fixing in practice.

Other than suggesting this hack become find a way to limit itself to the
driver that is actually having problems I don't see a way to improve it.

> Minor comment on a comment below.
>
>> ---
>> 
>> 
>> changes from v6:
>> 	limit changes to virtio only
>> changes from v5:
>>         rebased on top of pci/msi
>>         fixed commit log, including comments by Bjorn
>>         and adding explanation to address comments/questions by Eric
>>         dropped stable Cc, this patch does not seem to qualify for stable
>> changes from v4:
>>         Yijing Wang <wangyijing@huawei.com> noted that
>>         early fixups rely on pci_msi_off.
>>         Split out the functionality and move off the
>>         required part to run early during pci_device_setup.
>> Changes from v3:
>>         fix a copy-and-paste error in
>>           pci: drop some duplicate code
>>         other patches are unchanged
>>         drop Cc stable for now
>> Changes from v2:
>>         move code from probe to device enumeration
>>         add patches to unexport pci_msi_off
>> 
>> 
>>  include/linux/pci.h                | 2 ++
>>  drivers/pci/pci-driver.c           | 6 ++++--
>>  drivers/virtio/virtio_pci_common.c | 4 ++++
>>  3 files changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 860c751..80f3494 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -180,6 +180,8 @@ enum pci_dev_flags {
>>  	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 6),
>>  	/* Do not use PM reset even if device advertises NoSoftRst- */
>>  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>> +	/* Do not disable MSI on shutdown, disable bus master instead */
>
> This comment doesn't really match what the patch does.  The patch merely
> does "Do not disable MSI on shutdown."  It doesn't "disable bus master
> instead."
>
> Bus master may be disabled elsewhere, but that is independent of the
> PCI_DEV_FLAGS_NO_MSI_SHUTDOWN flag.
>
>> +	PCI_DEV_FLAGS_NO_MSI_SHUTDOWN = (__force pci_dev_flags_t) (1 << 8),
>>  };
>>  
>>  enum pci_irq_reroute_variant {
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 3cb2210..59d9e40 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -450,8 +450,10 @@ static void pci_device_shutdown(struct device *dev)
>>  
>>  	if (drv && drv->shutdown)
>>  		drv->shutdown(pci_dev);
>> -	pci_msi_shutdown(pci_dev);
>> -	pci_msix_shutdown(pci_dev);
>> +	if (!(pci_dev->dev_flags & PCI_DEV_FLAGS_NO_MSI_SHUTDOWN)) {
>> +		pci_msi_shutdown(pci_dev);
>> +		pci_msix_shutdown(pci_dev);
>> +	}
>>  
>>  #ifdef CONFIG_KEXEC
>>  	/*
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index 78f804a..26f46c3 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -528,6 +528,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>>  	if (rc)
>>  		goto err_register;
>>  
>> +	pci_dev->dev_flags |= PCI_DEV_FLAGS_NO_MSI_SHUTDOWN;
>> +
>>  	return 0;
>>  
>>  err_register:
>> @@ -546,6 +548,8 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>>  {
>>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>>  
>> +	pci_dev->dev_flags &= ~PCI_DEV_FLAGS_NO_MSI_SHUTDOWN;
>> +
>>  	unregister_virtio_device(&vp_dev->vdev);
>>  
>>  	if (vp_dev->ioaddr)
>> -- 
>> MST
