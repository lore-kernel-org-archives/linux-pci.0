Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27135 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071Ab3HAVzo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 Aug 2013 17:55:44 -0400
Message-ID: <51FAD95F.9010501@intel.com>
Date: Thu, 01 Aug 2013 14:55:43 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Don Dutile <ddutile@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip
 that
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org> <1374937868-24437-2-git-send-email-yinghai@kernel.org> <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com> <51F6D161.1040106@redhat.com> <CAErSpo5d2+mCkwED-RYV4=3LCvpj7HNxT_6yHxqNA-kcHSHF2g@mail.gmail.com> <51FAD170.4000302@redhat.com>
In-Reply-To: <51FAD170.4000302@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/01/2013 02:21 PM, Don Dutile wrote:
> On 08/01/2013 04:16 PM, Bjorn Helgaas wrote:
>> On Mon, Jul 29, 2013 at 2:32 PM, Don Dutile<ddutile@redhat.com>  wrote:
>>> On 07/29/2013 03:58 PM, Bjorn Helgaas wrote:
>>>>
>>>> On Sat, Jul 27, 2013 at 9:11 AM, Yinghai Lu<yinghai@kernel.org>  
>>>> wrote:
>>>>>
>>>>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>>>>> (PCI: Simplify IOV implementation and fix reference count races)
>>>>> VF need to be removed via virtfn_remove to make sure ref to PF
>>>>> is put back.
>>
>> OK, I'm lost here.  I think this is the scenario where Yinghai saw a
>> regression (please correct me if not):
>>
>>    00:03.0 Root port to [bus 02]
>>    02:00.0 SR-IOV NIC (PF in slot 2)
>>    02:00.1 VF (for example)
>>
>>    # echo -n 0>  /sys/bus/pci/slots/2/power
>>    02:00.0 PF is powered off
>>    02:00.0 PF pci_dev is released, but VF 02:00.1 pci_dev still exists
>> and holds a reference to the PF pci_dev, so the 02:00.0 pci_dev is not
>> actually deallocated
>>
>>    # echo -n 1>  /sys/bus/pci/slots/2/power
>>    pciehp 0000:00:03.0:pcie04: Device 0000:02:00.0 already exists at
>> 0000:02:00, cannot hot-add
>>
>> Prior to dc087f2f6 ("Simplify IOV implementation and fix reference
>> count races"), this scenario (powering the slot off then back on)
>> apparently worked, and hot-adding 02:00.0 worked fine.
>>
>> But what about the VF pci_devs?  Prior to dc087f2f6, I assume they
>> still existed even after we removed power from the PF.  But obviously
>> the hardware VFs are disabled when we power the slot back up.  It
>> doesn't make sense to me to have pci_devs for these VFs that are no
>> longer enabled, so maybe I'm missing something here.
>>

Actually this is part of what I don't understand as well.  I would have
thought that if the device was hot-plugged that the VF devices would
have been removed as devices on the PCI bus since they all lived on the
same bus.  Why is it the VFs are still present to hold a reference to
the PF at all?

I'm not sure why we even have to disable SR-IOV in this case.  It seems
like the hot-plug should have walked though the bus already and removed
the VFs.

>>>>> Some driver (like ixgbe) does not call pci_disable_sriov() if
>>>>> sriov is enabled via /sys/.../sriov_numvfs setting.
>>>>> ixgbe does allow driver for PF get detached, but still have VFs
>>>>> around.
>>>>
>>>> Is this something ixgbe should be doing differently?
>>>>
>>>> I'm not 100% sold on the idea of the VFs staying active after the
>>>> driver releases the PF.  It seems asymmetric because I think the
>>>> driver has to claim the PF to *enable* the VFs, but we don't disable
>>>> them when releasing the PF.
>>>>
>>>> What's the use case for detaching the PF driver while the VFs are
>>>> active?
>>>>
>>> VF's assigned to (KVM) guest (via device-assignment).
>>> Virtually, it's as if the enet cable is unplugged to the VF in the
>>> guest --
>>> the device is still there (the PF wasn't unplugged, just the driver
>>> de-configured).
>>
>> OK, but why is it necessary to detach and reattach the PF driver at
>> all?  Are you trying to update the PF driver or something?  Change the
>> number of VFs?
>>
> One case is to update the PF driver; the other is 'operator error' :-/
> Want to not crash the guest w/VFs, and allow operator to 'mend their
> error',
> i.e., re-load the PF driver back.
>

That pretty much matches my understanding of things.  Basically we
cannot modify the number of VFs until all of the VFs are unassigned.

>>> Pre-sysfs-based configuration, the std way to configure the VFs into
>>> a system was to unload the PF driver, and reload it with a vf-enabling
>>> parameter
>>> (like max_vfs=<n>  in the case of ixgbe, igb).
>>
>> Yes.  But I assume the first time the PF was loaded, there were no VFs
>> enabled.  So disabling VFs at unload wouldn't cause any problem there.
>>   Then you reload the driver with "max_vfs=<n>".  The driver enables
>> VFs.  Is there any reason to unload the PF driver again?
>>
>>> Now, if someone unloaded the PF driver in the host, the unplanned
>>> removal
>>> of the PF enabled the VF to crash the host (maybe AlexD can provide the
>>> details how that occurred).
>>> So, the solution was to 'pause' the VF operation and let packets drop
>>> in the guest, and re-enable the VF operation if the PF driver was
>>> re-configured.
>>
>> I don't get this.  Why should we tolerate "unplanned removal of the
>> PF"?  If you yank the card, I would *expect* anything using it to
>> crash.
>>
> Last time I checked, PCIe handles surprise removal, electrically,
> on unplanned removal -- it's capacitively coupled so crashes due to
> odd signalling transition can be handled (malformed pcie packet, w/c,
> which aer handles/dismisses).
>

PCIe handles the surprise removal, but the kernel doesn't do much about
it.  From what I have seen in the past surprise removal results in
completion timeouts and reads returning ~0.  The device itself doesn't
get removed from the bus by the device going away.

> Note, the i(x)gb(e) code was designed to handle operator error around
> PF driver removal.  hot plug/unplug was probably not tested against
> the 'save the VF state' code in the i(x)gb(e)vf drivers.
> Again, try asking the driver owner(s).

I'm suspecting hot-plug will probably cause the same issues the we saw
with the PF driver removal.  I'm still waiting on the response from
testing before I know one way or the other.

Thanks,

Alex
