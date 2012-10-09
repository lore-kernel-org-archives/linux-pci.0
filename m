Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab2JISj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Oct 2012 14:39:57 -0400
Message-ID: <50746F77.60201@redhat.com>
Date: Tue, 09 Oct 2012 14:39:51 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Greg Rose <gregory.v.rose@intel.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	davem@davemloft.net
Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
References: <1349388885-43938-1-git-send-email-ddutile@redhat.com> <5070768C.4030905@gmail.com> <20121008084439.00006e56@unknown>
In-Reply-To: <20121008084439.00006e56@unknown>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2012 11:44 AM, Greg Rose wrote:
> On Sat, 6 Oct 2012 11:21:00 -0700
> Alexander Duyck<alexander.duyck@gmail.com>  wrote:
>
>> On 10/4/2012 3:14 PM, Donald Dutile wrote:
>>> Provide files under sysfs to determine the max number of vfs
>>> an SRIOV-capable PCIe device supports, and methods to enable and
>>> disable the vfs on a per device basis.
>>>
>>> Currently, VF enablement by SRIOV-capable PCIe devices is done
>>> in driver-specific module parameters.  If not setup in modprobe
>>> files, it requires admin to unload&  reload PF drivers with number
>>> of desired VFs to enable.  Additionally, the enablement is system
>>> wide: all devices controlled by the same driver have the same
>>> number of VFs enabled.  Although the latter is probably desired,
>>> there are PCI configurations setup by system BIOS that may not
>>> enable that to occur.
>>>
>>> Three files are created if a PCIe device has SRIOV support:
>>> sriov_max_vfs -- cat-ing this file returns the maximum number
>>>                    of VFs a PCIe device supports.
>>> sriov_enable_vfs -- echo'ing a number to this file enables this
>>>                       number of VFs for this given PCIe device.
>>>                    -- cat-ing this file will return the number of VFs
>>>                       currently enabled on this PCIe device.
>>> sriov_disable_vfs -- echo-ing any number other than 0 disables all
>>>                        VFs associated with this PCIe device.
>>>
>>> VF enable and disablement is invoked much like other PCIe
>>> configuration functions -- via registered callbacks in the driver,
>>> i.e., probe, release, etc.
>>>
>>> v1->v2:
>>> This patch is based on previous 2 patches by Yinghai Lu
>>> that cleaned up the vga attributes for PCI devices under sysfs,
>>> and uses visibility-checking group attributes as recommended by
>>> Greg K-H.
>>>
>>> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>>
>> I'm not certain if having separate values/functions for enable and
>> disabling VFs will work out very well.  It seems like it would
>> probably make more sense just to have one value that manipulates
>> NumVFs.  As is, in the sriov_enable_vfs case we would end up having
>> to disable SR-IOV should we be changing the number of VFs anyway so
>> it would probably make sense to just merge both values into a single
>> one and use 0 as the value to disable SR-IOV.
>>
>> Also in the naming scheme for the values it may preferable to use the
>> names of the values from the SR-IOV PCIe capability to avoid any
>> confusion on what the values represent.  I believe the names for the
>> two values you are representing are TotalVFs and NumVFs.
>
> Alex makes a good point here.  If you could change sriov_max_vfs to
> total_vfs that would help.
>
consider it done; pls read my reply to Alex's suggestion(s).

> And a single callback is all that is necessary, especially if you take
> into account my further comments below.  After looking at the
> implementation and thinking about it a bit over the weekend I see some
> problems that we should probably address.
>
+1.

> In my opinion we shouldn't be having the endpoint device driver call
> the pci_enable_sriov() and pci_disable_sriov() functions as this
> implementation requires.  The pci bus driver should do that itself and
> then just notify the endpoint device driver of the action and, in the
> case of enabling VFs, tell it how many were enabled, with the num_vfs
> parameter.
>
I want to double-check this logic, but on first glance I agree for this API...
But, until the PF driver's, param-based, 'max_vfs' interface is removed,
the driver will still have to have a code path that does the enable/disable_sriov().
Again, I agree it is flawed, as a bad driver not calling disable_sriov()
will leak resources and quickly fail other PCI (hotplug) ops (be they VFs or PFs).
Q: what did you mean by 'and then just notify the endpoint device driver' ?
    -- another/new api for pf drivers w/sriov support/device ??

> There is a good reason for this too. I asked you to change the return
> value of sriov_disable_vfs() to an int so that the driver could check
> if VFs are assigned and return an error.  But the more I think of I
> feel that is backwards.  This means that the system is at the mercy of
> the endpoint device driver to do the check for assigned VFs.  Badly
> written drivers might not do that check and then crash the system. Plus
> that means every driver has to write the same code to check for
> assigned VFs which could easily be put into the pci bus driver.
>
Isn't this code still needed when user-level unbind done, i.e.,
echo 1 > /sys/bus/pci/drivers/ixgbe/unbind

remove_id is another one, but bind/unbind the common path for virtualization

> If the pci bus driver were to check for assigned VFs then it could take
> steps to protect the system and not depend on dumb device driver
> writers such as yours truly to do it.
>


> I've pasted in the code below from the ixgbe driver that checks for
> assigned VFs.  The pci bus driver has access to all the necessary
> information for the check but it would need to get the VF device ID
> from the PF SR-IOV capability structure.
>
easy to do; already done & in the vid/did of the vf's pci-dev structure.

> - Greg
>
> --------------
>
> static bool ixgbe_vfs_are_assigned(struct ixgbe_adapter *adapter)
> {
>          struct pci_dev *pdev = adapter->pdev;
>          struct pci_dev *vfdev;
>          int dev_id;
>
>          switch (adapter->hw.mac.type) {
>          case ixgbe_mac_82599EB:
>                  dev_id = IXGBE_DEV_ID_82599_VF;
>                  break;
>          case ixgbe_mac_X540:
>                  dev_id = IXGBE_DEV_ID_X540_VF;
>                  break;
>          default:
>                  return false;
>          }
>
>          /* loop through all the VFs to see if we own any that are assigned */
>          vfdev = pci_get_device(PCI_VENDOR_ID_INTEL, dev_id, NULL);
>          while (vfdev) {
>                  /* if we don't own it we don't care */
>                  if (vfdev->is_virtfn&&  vfdev->physfn == pdev) {
>                          /* if it is assigned we cannot release it */
>                          if (vfdev->dev_flags&  PCI_DEV_FLAGS_ASSIGNED)
>                                  return true;
>                  }
>
>                  vfdev = pci_get_device(PCI_VENDOR_ID_INTEL, dev_id, vfdev);
>          }
>
>          return false;
> }
>
>

