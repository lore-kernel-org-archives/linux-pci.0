Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACK8Z6Gh=rLS_tBdx-xyr-RwtTFtnkUD=A5ibJyy6SrE5jAZbw@mail.gmail.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150618161238.32739.42666.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CACK8Z6E_bobMhP1_0Y87R20DMfDa881LVmswZpM=YqQEZC2+=Q@mail.gmail.com>
 <CAErSpo6BCtM8zJS=yNTNTugXW--8PpuRhod2GAydZj38tCo+-w@mail.gmail.com> <CACK8Z6Gh=rLS_tBdx-xyr-RwtTFtnkUD=A5ibJyy6SrE5jAZbw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 16:22:53 -0500
Message-ID: <CAErSpo5-ny8xjb=KgETZMAoiNMQykYC2iMG8iw03UQnjtLeG8g@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: pciehp: Clean up debug logging
To: Rajat Jain <rajatja@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Thu, Jun 18, 2015 at 1:08 PM, Rajat Jain <rajatja@google.com> wrote:
> On Thu, Jun 18, 2015 at 11:01 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Thu, Jun 18, 2015 at 12:27 PM, Rajat Jain <rajatja@google.com> wrote:
>>> Hi,
>>>
>>> On Thu, Jun 18, 2015 at 9:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> The pciehp debug logging is overly verbose and often redundant.  Almost all
>>>> of the information printed by dbg_ctrl() is also printed by the normal PCI
>>>> core enumeration code and by pcie_init().
>>>>
>>>> Remove the redundant debug info.
>>>>
>>>> When claiming a pciehp bridge, we print the slot characteristics, e.g.,
>>>>
>>>>   Slot #6 AttnBtn- AttnInd- PwrInd- PwrCtrl- MRL- Interlock- NoCompl+ LLActRep+
>>>>
>>>> Add the Hot-Plug Capable and Hot-Plug Surprise bits to this information,
>>>
>>> If the slot is not hotplug capable. then pciehp wouldn't claim it in
>>> the first place.
>>>
>>> So printing of "hotplug capable" may really not be needed..
>>
>> Yes, I did think about that, and you're right that it probably isn't
>> needed.  But the criteria for claiming a slot and deciding whether
>> acpiphp or pciehp should manage it are not 100% clear yet, so I
>> figured it wouldn't hurt to be a bit more transparent.
>
> Sounds right.
>
> Reviewed-by : Rajat Jain <rajatja@google.com>
>
> Side note: To clarify when and why the slot was claimed by pciehp or
> acpihp, do you think we need some mumbling / logging in
> acpi_pci_detect_ejectable() or pciehp_acpi_slot_detection_check()?

Maybe so (but I haven't added anything).

My intuition is that acpiphp and pciehp are not really symmetric.  I
think pciehp should claim PCIe downstream ports (Root Ports and
Downstream Ports) when _OSC has granted us control.

But it doesn't seem like acpiphp should decide whether to claim
certain devices based on whether they have _ADR, _EJ0, _RMV, etc.
Shouldn't it just be integrated with the ACPI core so  it can field
notifications from the platform, no matter what methods are present,
and even if pciehp has claimed a bridge in that scope?

Bjorn
