Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1650350.VG8hpWuxzd@vostro.rjw.lan>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CACK8Z6Gh=rLS_tBdx-xyr-RwtTFtnkUD=A5ibJyy6SrE5jAZbw@mail.gmail.com>
 <CAErSpo5-ny8xjb=KgETZMAoiNMQykYC2iMG8iw03UQnjtLeG8g@mail.gmail.com> <1650350.VG8hpWuxzd@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 18:17:50 -0500
Message-ID: <CAErSpo5yopgvkKEWhvrMU2JcFgPKj5SjgbrfhPcmdew5VYisuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: pciehp: Clean up debug logging
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rajat Jain <rajatja@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 4:52 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, June 18, 2015 04:22:53 PM Bjorn Helgaas wrote:
>> [+cc Rafael]
>>
>> On Thu, Jun 18, 2015 at 1:08 PM, Rajat Jain <rajatja@google.com> wrote:
>> > On Thu, Jun 18, 2015 at 11:01 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> On Thu, Jun 18, 2015 at 12:27 PM, Rajat Jain <rajatja@google.com> wrote:
>> >>> Hi,
>> >>>
>> >>> On Thu, Jun 18, 2015 at 9:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >>>> The pciehp debug logging is overly verbose and often redundant.  Almost all
>> >>>> of the information printed by dbg_ctrl() is also printed by the normal PCI
>> >>>> core enumeration code and by pcie_init().
>> >>>>
>> >>>> Remove the redundant debug info.
>> >>>>
>> >>>> When claiming a pciehp bridge, we print the slot characteristics, e.g.,
>> >>>>
>> >>>>   Slot #6 AttnBtn- AttnInd- PwrInd- PwrCtrl- MRL- Interlock- NoCompl+ LLActRep+
>> >>>>
>> >>>> Add the Hot-Plug Capable and Hot-Plug Surprise bits to this information,
>> >>>
>> >>> If the slot is not hotplug capable. then pciehp wouldn't claim it in
>> >>> the first place.
>> >>>
>> >>> So printing of "hotplug capable" may really not be needed..
>> >>
>> >> Yes, I did think about that, and you're right that it probably isn't
>> >> needed.  But the criteria for claiming a slot and deciding whether
>> >> acpiphp or pciehp should manage it are not 100% clear yet, so I
>> >> figured it wouldn't hurt to be a bit more transparent.
>> >
>> > Sounds right.
>> >
>> > Reviewed-by : Rajat Jain <rajatja@google.com>
>> >
>> > Side note: To clarify when and why the slot was claimed by pciehp or
>> > acpihp, do you think we need some mumbling / logging in
>> > acpi_pci_detect_ejectable() or pciehp_acpi_slot_detection_check()?
>>
>> Maybe so (but I haven't added anything).
>>
>> My intuition is that acpiphp and pciehp are not really symmetric.  I
>> think pciehp should claim PCIe downstream ports (Root Ports and
>> Downstream Ports) when _OSC has granted us control.
>>
>> But it doesn't seem like acpiphp should decide whether to claim
>> certain devices based on whether they have _ADR, _EJ0, _RMV, etc.
>
> But it doesn't do that, does it?

I guess it's actually *pciehp* that looks at that stuff via this path:

  pciehp_probe
    pciehp_acpi_slot_detection_check
      acpi_pci_detect_ejectable
        acpi_walk_namespace(..., check_hotplug, ...)
          check_hotplug
            pcihp_is_ejectable
              acpi_has_method(..., "_ADR")
              ...

Oh, wait a minute, you removed all that junk with e705c2959b06 ("PCI:
pciehp: Drop pointless ACPI-based "slot detection" check"), so ...
never mind :)

And THANKS AGAIN for getting rid of all that crud!

>> Shouldn't it just be integrated with the ACPI core so  it can field
>> notifications from the platform, no matter what methods are present,
>> and even if pciehp has claimed a bridge in that scope?
>
> That's how it is implemented today AFAICS.

Great, that makes a lot of sense to me.

Bjorn
