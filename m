Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755993Ab2JIWtJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Oct 2012 18:49:09 -0400
Message-ID: <5074A9DD.3000800@redhat.com>
Date: Tue, 09 Oct 2012 18:49:01 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: "Rose, Gregory V" <gregory.v.rose@intel.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
References: <1349388885-43938-1-git-send-email-ddutile@redhat.com> <5070768C.4030905@gmail.com> <20121008084439.00006e56@unknown> <50746F77.60201@redhat.com> <C5551D9AAB213A418B7FD5E4A6F30A071533B57E@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <C5551D9AAB213A418B7FD5E4A6F30A071533B57E@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/09/2012 04:31 PM, Rose, Gregory V wrote:
>> -----Original Message-----
>> From: Don Dutile [mailto:ddutile@redhat.com]
>> Sent: Tuesday, October 09, 2012 11:40 AM
>> To: Rose, Gregory V
>> Cc: Alexander Duyck; linux-pci@vger.kernel.org; bhelgaas@google.com;
>> yuvalmin@broadcom.com; bhutchings@solarflare.com; davem@davemloft.net
>> Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
>>
>> On 10/08/2012 11:44 AM, Greg Rose wrote:
>>> On Sat, 6 Oct 2012 11:21:00 -0700
>
> [snip]
>
>>> In my opinion we shouldn't be having the endpoint device driver call
>>> the pci_enable_sriov() and pci_disable_sriov() functions as this
>>> implementation requires.  The pci bus driver should do that itself and
>>> then just notify the endpoint device driver of the action and, in the
>>> case of enabling VFs, tell it how many were enabled, with the num_vfs
>>> parameter.
>>>
>> I want to double-check this logic, but on first glance I agree for this
>> API...
>> But, until the PF driver's, param-based, 'max_vfs' interface is removed,
>> the driver will still have to have a code path that does the
>> enable/disable_sriov().
>
> True, but those will be somewhat different code paths in our driver and I'm going to insert a message into the driver that lets the user know that using the 'max_vfs' module parameter is deprecated.  Eventually I'd like to get rid of it entirely when this new interface becomes common.
>
Sounds like plan, i.e., removing stuff that may cause problems.. :)

>> Again, I agree it is flawed, as a bad driver not calling disable_sriov()
>> will leak resources and quickly fail other PCI (hotplug) ops (be they VFs
>> or PFs).
>> Q: what did you mean by 'and then just notify the endpoint device driver'
>> ?
>>      -- another/new api for pf drivers w/sriov support/device ??
>
> No, I was thinking of a sequence like this:
>
> 1) PCI bus driver notifies endpoint device driver that user requests<num_vfs>
> 2) The endpoint driver processes the request and configures the HW to be ready for VFs coming on-line.
> 3) The endpoint device driver returns the number of VFs it is able to create or else a negative value of some error code.
> 4) The PCI bus driver sees that the notification/request is successful so it goes ahead and calls pci_enable_sriov() to enable the VFs.
>
> This has the advantage of minimizing the amount of disruption in service to a minimum.  Also, it is how I'm handling it now in my experimental patches.  Everything is checked, configured and gotten ready and then the last thing I do before returning from sriov_enable_vfs() is call pci_enable_sriov().
>
> That said, I suppose it is six of one and half a dozen of another except I like the approach I mention a little better because it forces the endpoint device driver to configure everything first successfully before enabling the VFs.  In the PCI bus driver if the call to pci_enable_sriov() fails then it can just quickly turn around and call the endpoint device driver to disable SR-IOV so that it will reconfigure itself to non SR-IOV operational mode.
>
Well, there's all kind of fun that can still occur at pci_sriov_enable() time --
not enough mmio resources is one of them.
So, the above sounds like a reasonable change, and IMO, makes more sense
to have the core code doing enable/disable & appropriate checking.

>>
>>> There is a good reason for this too. I asked you to change the return
>>> value of sriov_disable_vfs() to an int so that the driver could check
>>> if VFs are assigned and return an error.  But the more I think of I
>>> feel that is backwards.  This means that the system is at the mercy of
>>> the endpoint device driver to do the check for assigned VFs.  Badly
>>> written drivers might not do that check and then crash the system.
>>> Plus that means every driver has to write the same code to check for
>>> assigned VFs which could easily be put into the pci bus driver.
>>>
>> Isn't this code still needed when user-level unbind done, i.e., echo 1>
>> /sys/bus/pci/drivers/ixgbe/unbind
>
> Oh yeah.  Since that's the case then the endpoint device drivers will still need to do the check, but it might be a good idea to go ahead and put the check into the PCI bus driver also.  System panics are bad and whatever we can do to avoid them is hence good.
>
I get your type --- get it out of my driver... put it in the core!
winner! :)  The issue is that bind/unbind is under pci/drivers/<blah>
and not pci/devices/D:B:D.F/, so I have to find where to hook into bind/unbind
so vf->is_assigned check can be done for PCI devices.

>>
>> remove_id is another one, but bind/unbind the common path for
>> virtualization
>>
>>> If the pci bus driver were to check for assigned VFs then it could
>>> take steps to protect the system and not depend on dumb device driver
>>> writers such as yours truly to do it.
>>>
>>
>>
>>> I've pasted in the code below from the ixgbe driver that checks for
>>> assigned VFs.  The pci bus driver has access to all the necessary
>>> information for the check but it would need to get the VF device ID
>>> from the PF SR-IOV capability structure.
>>>
>> easy to do; already done&  in the vid/did of the vf's pci-dev structure.
>
> OK, good deal.
>
> I've finished some patches for the ixgbe driver and they are under internal review.  Testing turned out pretty well.  Hopefully they'll be ready for posting tomorrow afternoon since I'm gone Thursday and Friday.  They'll be based on your RFC v2 patch.  I don't expect many changes will be required for the next version of your patch.
>
> - Greg
>
Great!
I'll work on re-doing the patch set to have just the two sysfs files
as discussed above.
We can make an incremental change to move the sriov_enable/disable since
your patch has it ready to do just that.

