Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55610 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbaA3ULG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jan 2014 15:11:06 -0500
From: Bandan Das <bsd@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] vfio: Set PCI_DEV_FLAGS_ASSIGNED when assigning device to guest
References: <jpgeh3ppelz.fsf@redhat.com> <1391103225.6959.71.camel@bling.home>
	<1391103376.6959.72.camel@bling.home> <jpg7g9hl4yg.fsf@redhat.com>
	<1391107087.6959.79.camel@bling.home>
Date: Fri, 31 Jan 2014 01:40:58 +0530
Message-ID: <jpg7g9h44dp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson <alex.williamson@redhat.com> writes:

> On Thu, 2014-01-30 at 23:36 +0530, Bandan Das wrote:
>> Alex Williamson <alex.williamson@redhat.com> writes:
>> 
>> > [cc +linux-pci]
>> >
>> > On Thu, 2014-01-30 at 10:33 -0700, Alex Williamson wrote:
>> >> On Thu, 2014-01-30 at 22:54 +0530, Bandan Das wrote:
>> >> > Some drivers such as ixgbe rely on pci_vfs_assigned() to prevent
>> >> > disabling sr-iov when vfs are still assigned during hotplug
>> >> > event or module removal. Set and unset PCI_DEV_FLAGS_ASSIGNED
>> >> > appropriately
>> >> 
>> >> This flag has always felt like a band-aide for KVM device assignment
>> >> because a device could be used without an actual driver attached to the
>> >> device.  vfio-pci is an actual driver, so why should it matter whether
>> >> the device is assigned or in use by ixgbevf or in use by pci-vfio?  It
>> >> seems like sr-iov shouldn't be disabled so long as either a driver or
>> >> this (needs to be deprecated) flag are set.  Thanks,
>> 
>> With cases such as vfio-pci, not having this flag set will disable sriov
>> while a guest is using it resulting in a hung guest.
>
> That sounds like a bug, why would a PF disable sr-iov while there's
> still a driver attached to the VF?  Is the PF assuming the driver can
> reconnect to the VF later or continue w/o a VF?  How can it make such an
> assumption?

It seems (atleast in the ixgbe driver), the decision is based on 
pci_vfs_assigned which checks the PCI_DEV_FLAGS_ASSIGNED bit i.e
whether or not the device is assigned.

int ixgbe_disable_sriov(struct ixgbe_adapter *adapter) {
...
#ifdef CONFIG_PCI_IOV
	/*
	 * If our VFs are assigned we cannot shut down SR-IOV
	 * without causing issues, so just leave the hardware
	 * available but disabled
	 */
	if (pci_vfs_assigned(adapter->pdev)) {
		e_dev_warn("Unloading driver while VFs are assigned - VFs will not be deallocated\n");
		return -EPERM;
	}
	/* disable iov and allow time for transactions to clear */
	pci_disable_sriov(adapter->pdev);
#endif

The only other place I found this bit being used is i40e and xen pci stub. 

>>  I am unfamiliar if 
>> similar scenarios are applicable to other test cases. If the flag needs
>> to be set, what's a better place then ? Or how does the PF driver decide not 
>> to disable sr-iov, should it be based on - as long as the device is bound to 
>> a driver ?
>
> It seems like a better approach would be for drivers that are capable of
> having the VF removed from under them to set a flag, which would allow
> the PF driver to be told rather than assume it can disable sr-iov.  Then
> it would be a feature flag rather than some made-up association with
> device assignment.  Thanks,

Sorry but I am a little unclear here. Isn't the PCI_DEV_FLAGS_ASSIGNED bit 
(maybe renamed) be usable for this case too ? Just setting/clearing that bit 
during the probe is what is required for the above to work...
or am I missing something ?

> Alex
>
>> >> > ---
>> >> >  drivers/vfio/pci/vfio_pci.c | 2 ++
>> >> >  1 file changed, 2 insertions(+)
>> >> > 
>> >> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> >> > index 7ba0424..7cc7ed6 100644
>> >> > --- a/drivers/vfio/pci/vfio_pci.c
>> >> > +++ b/drivers/vfio/pci/vfio_pci.c
>> >> > @@ -90,6 +90,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>> >> >  		vdev->has_vga = true;
>> >> >  #endif
>> >> >  
>> >> > +	pdev->dev_flags |= PCI_DEV_FLAGS_ASSIGNED;
>> >> >  	return 0;
>> >> >  }
>> >> >  
>> >> > @@ -149,6 +150,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>> >> >  				__func__, dev_name(&pdev->dev), ret);
>> >> >  	}
>> >> >  
>> >> > +	pdev->dev_flags &= ~PCI_DEV_FLAGS_ASSIGNED;
>> >> >  	pci_restore_state(pdev);
>> >> >  }
>> >> >  
>> >> 
>> >> 
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe kvm" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
