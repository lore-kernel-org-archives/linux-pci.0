Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36039 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbbFBT6t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2015 15:58:49 -0400
Received: by qkx62 with SMTP id 62so107313332qkx.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2015 12:58:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <556DE1B9.6020100@roeck-us.net>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon> <556DE1B9.6020100@roeck-us.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Jun 2015 14:58:27 -0500
Message-ID: <CAErSpo4WyQqc+En6hAB9B63sszKc8B93FiycwaDG42tecSB9Mg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 2, 2015 at 12:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/02/2015 07:55 AM, Lorenzo Pieralisi wrote:
>>
>> Bjorn, Guenter,
>>
>> On Wed, May 27, 2015 at 10:04:47PM +0100, Bjorn Helgaas wrote:
>>>
>>> [+cc Lorenzo, Suravee, Will]
>>>
>>> I cc'd Lorenzo, Suravee, and Will because Lorenzo is working on calling
>>> pci_read_bases() from the PCI core instead of from arch code, and there
>>> are
>>> likely some dependencies between these two things.
>>>
>>> On Fri, May 22, 2015 at 05:52:16PM -0700, Guenter Roeck wrote:
>>>>
>>>> The PCI subsystem always assumes that I/O is supported on PCIe bridges
>>>> and tries to assign an I/O window to each port even if that is not
>>>> the case.
>>>>
>>>> This may result in messages such as
>>>>
>>>> pcieport 0000:02:00.0: res[7]=[io  0x1000-0x0fff]
>>>>                                         get_res_add_size add_size 1000
>>>> pcieport 0000:02:00.0: BAR 7: no space for [io  size 0x1000]
>>>> pcieport 0000:02:00.0: BAR 7: failed to assign [io  size 0x1000]
>>>>
>>>> for each bridge port, even if a port or its parent does not support
>>>> I/O in the first place.
>>>>
>>>> To avoid this message, check if a port supports I/O before trying to
>>>> enable it. Also check if port's parent supports I/O, and only modify
>>>> a port's I/O resource size if both the port and its parent support I/O.
>>>>
>>>> If IO is disabled after the initial port scan, the IO base and size
>>>> registers are set to 0x00f0 to indicate that IO is disabled. A later
>>>> rescan interprets this as "IO supported" and enables the IO range,
>>>> even if the parent does not support IO. Handle this situation as well.
>>>>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>   drivers/pci/probe.c     | 14 ++++++++++++++
>>>>   drivers/pci/setup-bus.c |  4 ++--
>>>>   include/linux/pci.h     |  9 +++++++++
>>>>   3 files changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 6675a7a1b9fc..f4944ef45148 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -354,6 +354,20 @@ static void pci_read_bridge_io(struct pci_bus
>>>> *child)
>>>>         base = (io_base_lo & io_mask) << 8;
>>>>         limit = (io_limit_lo & io_mask) << 8;
>>>>
>>>> +       /* If necessary, check if the bridge supports an I/O aperture */
>>>> +       if (!io_base_lo && !io_limit_lo) {
>>>> +               u16 io;
>>>> +
>>>> +               if (!pci_parent_supports_io(child))
>>>> +                       return;
>>>> +
>>>> +               pci_write_config_word(dev, PCI_IO_BASE, 0xe0f0);
>>>> +               pci_read_config_word(dev, PCI_IO_BASE, &io);
>>>> +               pci_write_config_word(dev, PCI_IO_BASE, 0x0);
>>>> +               if (!io)
>>>> +                       return;
>>>> +       }
>>>
>>>
>>> I really like the idea of pushing this into pci_read_bridge_io().
>>>
>>> I wonder if we can do the same with pci_read_bridge_mmio_pref(), and
>>> somehow get rid of pci_bridge_check_ranges() altogether?
>>>
>>> I think I looked at doing that a while back, and it seems like there was
>>> some wrinkle, but I don't remember what it was.
>
> After looking into this some more, I think the wrinkle may be that
> pci_read_bridge_bases() and thus pci_read_bridge_io() isn't called
> on probe-only systems (if PCI_PROBE_ONLY is set). A secondary
> problem is that pci_read_bridge_io() does not enable a resource
> if it is explicitly disabled (base > limit), but the subsequent call
> to pci_bridge_check_ranges() unconditionally enables it.

I haven't researched this, but it sounds wrong that we skip
pci_read_bridge_bases() if PCI_PROBE_ONLY is set.  I think
PCI_PROBE_ONLY should mean "look, but don't touch."  So I think we
should always look at the bridge windows, and my advice is to see if
it looks reasonable to change this aspect of PCI_PROBE_ONLY.

Bjorn
