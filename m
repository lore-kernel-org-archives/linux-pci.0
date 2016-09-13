Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 2/2] PCI: add CRS support to error handling path
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
 <20160913200152.GE4138@localhost>
 <dd6d9d71-1ba0-84c8-7cab-21fe8b555f1c@codeaurora.org>
 <20160913214709.GI4138@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a2e05b37-7ebc-7969-046d-017866509416@codeaurora.org>
Date: Tue, 13 Sep 2016 18:44:42 -0400
MIME-Version: 1.0
In-Reply-To: <20160913214709.GI4138@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 9/13/2016 5:47 PM, Bjorn Helgaas wrote:
> On Tue, Sep 13, 2016 at 05:04:49PM -0400, Sinan Kaya wrote:
>> On 9/13/2016 4:01 PM, Bjorn Helgaas wrote:
>>> On Thu, Sep 01, 2016 at 07:00:01PM -0400, Sinan Kaya wrote:
>>>> The PCIE spec allows an endpoint device to extend the initialization time
>>>> beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
>>>> vendor ID read request.
>>>>
>>>> This basically means "I'm busy now, please call me back later".
>>>>
>>>> There are two moving parts to CRS support from the SW perspective. One part
>>>> is to determine if CRS is supported or not. The second part is to set the
>>>> CRS visibility register.
>>>>
>>>> As part of the probe, the Linux kernel sets the above two conditions in
>>>> pci_enable_crs function. The kernel is also honoring the returned CRS in
>>>> pci_bus_read_dev_vendor_id function if supported. The function will poll up
>>>> to specified amount of time while endpoint is returning CRS response.
>>>>
>>>> The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
>>>> resets.
>>>>
>>>> The hot reset is initiated by starting a secondary bus reset. This patch is
>>>> adding vendor ID read immediately after a bus reset so that the
>>>> initialization procedure can be extended by the amount of time endpoint
>>>> requires.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> ---
>>>>  drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index b209378..ebd0fc6 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3829,6 +3829,44 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Mostly copy paste from pci_walk_bus with the exceptions of hard coded
>>>> + * work and removed locks.
>>>> + */
>>>> +static void pci_bus_probe_crs(struct pci_bus *top)
>>>> +{
>>>> +	struct pci_dev *dev;
>>>> +	struct pci_bus *bus;
>>>> +	struct list_head *next;
>>>> +	int retval;
>>>> +	u32 l;
>>>> +
>>>> +	bus = top;
>>>> +	next = top->devices.next;
>>>> +	for (;;) {
>>>> +		if (next == &bus->devices) {
>>>> +			/* end of this bus, go up or finish */
>>>> +			if (bus == top)
>>>> +				break;
>>>> +			next = bus->self->bus_list.next;
>>>> +			bus = bus->self->bus;
>>>> +			continue;
>>>> +		}
>>>> +		dev = list_entry(next, struct pci_dev, bus_list);
>>>> +		if (dev->subordinate) {
>>>> +			/* this is a pci-pci bridge, do its devices next */
>>>> +			next = dev->subordinate->devices.next;
>>>> +			bus = dev->subordinate;
>>>> +		} else
>>>> +			next = dev->bus_list.next;
>>>> +
>>>> +		retval = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &l,
>>>> +						    60 * 1000);
>>>> +		if (retval)
>>>> +			break;
>>>> +	}
>>>> +}
>>>
>>> Sigh.  Man, this is ugly.  Maybe we're locked into the current
>>> strategy and don't really have a choice, but I really don't like it.
>>
>> I can add a locked version of the walkbus API. 
>> Then, I can minimize this code to a couple of lines. How does that sound?
> 
> I didn't mean that, I meant the whole idea of having to walk the whole
> hierarchy and touch each device.  It's sort of like we're enumerating
> things, but not really, so this checking is kinda sorta parallel to
> the enumeration path.

Well, we have to do this to run the CRS algorithm against all the devices
that are issuing the CRS. Hot reset is a broadcast message. There could
be multiple devices issuing a CRS in the tree. We should not start talking
to the device before CRS procedure is finished for the device.

The restore_bus routine blindly assumes that all devices under this tree
are accessible. 

However, I take your concern about save and restore. We could potentially
get rid of both save, restore and CRS code and then, try to re-enumerate. 
I am afraid that can also interfere with the AER error handling notifications
present in the AER driver. A device driver wouldn't get a chance to quiesce
itself before re-enumeration and can leave dangling threads around.

I'm curious if there is any way we can rescan the bus without involving
the endpoint drivers. If we can do that then this could potentially work.
Re-enumeration can also potentially assign different resources that the endpoint
already has mapped. I see even a bigger problem there.


> 
>>> You mentioned several kinds of reset where CRS is allowed.  Doesn't this
>>> fix only one of them?  I know we support at least FLR reset also.
>>
>> The CRS is for hot reset, warm reset and FLR reset. There is nothing we can do in SW
>> for warm reset. This patch is to address hot reset caused by SBR. 
>>
>> I was hoping that Alex would help us for directions on the FLR reset later.
> 
> What sort of help from Alex were you hoping for?  Is fixing the FLR
> path harder than this one?  If we're going to fix one path, I'd prefer
> to fix them all at the same time rather than tripping over this again
> later.
> 

I don't mind taking a stab at all paths if possible. Last time I checked,
there is already some code trying to find the endpoint. Alex is on the CC.
he can always review my change. 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
