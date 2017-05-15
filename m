Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35124 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965046AbdEOTsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 15:48:32 -0400
Received: by mail-it0-f68.google.com with SMTP id 67so12952640itx.2
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 12:48:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170515163623.GA15237@google.com>
References: <20170512181107.13853.34680.stgit@localhost.localdomain> <20170515163623.GA15237@google.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 May 2017 12:48:30 -0700
Message-ID: <CAKgT0UfNBhHSK9yvt7rZFMb+aZ9OF-Y7O4H8Axsr4NF99w9phQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Disable master abort while waiting for an FLR to complete
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 9:36 AM, Brian Norris <briannorris@chromium.org> wrote:
> On Fri, May 12, 2017 at 11:13:57AM -0700, Alexander Duyck wrote:
>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> This patch is meant to address issues seen when performing on FLR on some
>> systems as the long wait can result in a master abort when reading a
>> function that is not yet ready.
>>
>> To prevent the master abort from being reported up we should disable
>> reporting for it while waiting on the reset. Once the reset is completed
>> then we can re-enable the master abort for the bus.
>>
>> Fixes: 5adecf817dd6 ("PCI: Wait for up to 1000ms after FLR reset")
>>
>> Reported-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>
>> I haven't been able to test this code as I don't have a system that can
>> reproduce the issue. The fix itself is based on the issue as reported by
>> Brian so I am hoping he can test this on the Samsung Chromebook Plus with
>> RK399 OP1 that this was seen on.
>
> FYI, it's "RK3399" not "RK399". No harm done :)

I will try to update my patch in case there is a future re-submission.

>>  drivers/pci/pci.c |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 7904d02ffdb9..acbdbabeaa0e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3758,14 +3758,31 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>>   */
>>  static void pci_flr_wait(struct pci_dev *dev)
>>  {
>> +     struct pci_dev *bridge = dev->bus->self;
>>       int i = 0;
>> +     u16 bctl;
>>       u32 id;
>>
>> +     /*
>> +      * Disable MasterAbortMode while we are waiting to avoid reporting
>> +      * bus errors for reading the command register on a device that is
>> +      * not ready (in some architectures)
>
> I assume it's intentional to only do this *after* you've started the
> reset (but before you start polling)?

Yes. The general idea is that the only thing that should be accessing
the device is us. So this way we can catch any other code that might
be broken such as a device driver that is leaving a thread active that
is accessing the device before a reset.

>> +      */
>> +     if (bridge) {
>> +             pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &bctl);
>> +             pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
>> +                                   bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
>> +     }
>> +
>>       do {
>>               msleep(100);
>>               pci_read_config_dword(dev, PCI_COMMAND, &id);
>
> IIUC, the patch works fine, in that I no longer get an abort from the
> RC.

So did you actually test this patch or are you just speculating it
should work? I'm just not sure what you mean by "IIUC" in this context
here, were you referring to how the patch fixes the issue or how the
testing should work for verifying it fixed the issue?

>>       } while (i++ < 10 && id == ~0);
>
> BTW, the RK3399 host controller doesn't actually return all 1's on
> aborted transactions. So this loop doesn't really work for it at all.
>
> I take it that this (seemingly widely used) pattern all derives from the
> PCI spec, which notes:
>
>   "The host bus bridge, in PC compatible systems, must return all 1's on
>   a read transaction and discard data on a write transaction when
>   terminated with Master-Abort."
>
> RK3399 is far from a "PC compatible system", but I don't know if that's
> a real excuse here...

So if it doesn't return all 1's does it return all 0's? I'm just
curious what is returned?

Also do we know why we are reading the PCI_COMMAND register instead of
just checking for the device ID? Just wondering because the easiest
solution would be to copy out the logic in
pci_bus_read_dev_vendor_id() if all we are doing is waiting on the
configuration space to begin responding to requests again.

>>
>> +     /* restore bridge state */
>> +     if (bridge)
>> +             pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bctl);
>> +
>>       if (id == ~0)
>>               dev_warn(&dev->dev, "Failed to return from FLR\n");
>
> And there's no actual error code returned here; so since several of the
> error cases I can trigger on my hardware seem to never actually recover
> (no longer how long I wait and/or poll), it seems like we should
> propagate the error upward. Right now, we still unconditionally continue
> with the pci_dev_restore(), even though that's doomed to abort too...

If you take a look we ignore the return value anyway and call the
restore function in pci_reset_function(). I think the general idea is
we should still have a device here after attempting to perform the
reset.

It may be that performing an FLR isn't the right choice for this
hardware. Do you know if it functions correctly and actually completes
the reset correctly? I know in the case of some of the Intel Ethernet
silicon we were advertising support for it but found an issue that was
causing the Ethernet PHY to go offline as a result of performing the
FLR. Do you know what it was that was kicking off the need to perform
the reset in the first place? Also you may consider possibly adding a
quirk if the FLR is kicking your device completely out of the system.
There was recently a PCI flag added to indicate a device doesn't
support FLR. You might try adding your own version of the quirk for
this device to see if maybe pushing it to use a different sort of
reset might be more useful.

> So there may be several implementation bugs with RK3399. I don't know
> how much can be fixed on Rockchip's side, vs. how much can be
> accomodated in the PCI core.
>
> Brian

This is the kind of thing we have PCIe quirks for if nothing else.
Odds are we should be able to work around it, it is just a matter of
knowing what all the quirks are.

- Alex
