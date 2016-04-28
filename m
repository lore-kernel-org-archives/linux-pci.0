Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59352 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbcD1Vr0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 17:47:26 -0400
Subject: Re: [PATCH V6 08/13] PCI: generic, thunder: update to use generic
 ECAM API
To: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <8950494.UV8UrWiFbx@wuerfel> <20160428201439.GD25125@localhost>
 <5813591.CkzahFEfSl@wuerfel> <20160428211834.GE25125@localhost>
Cc: Tomasz Nowicki <tn@semihalf.com>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, Wangyijing <wangyijing@huawei.com>,
	Marcin Wojtas <mw@semihalf.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <572284E3.6050209@redhat.com>
Date: Thu, 28 Apr 2016 17:47:15 -0400
MIME-Version: 1.0
In-Reply-To: <20160428211834.GE25125@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Arnd, all,

On 04/28/2016 05:18 PM, Bjorn Helgaas wrote:
> On Thu, Apr 28, 2016 at 10:40:35PM +0200, Arnd Bergmann wrote:
>> On Thursday 28 April 2016 15:14:39 Bjorn Helgaas wrote:
>>> On Thu, Apr 21, 2016 at 11:36:53AM +0200, Arnd Bergmann wrote:
>>>> On Thursday 21 April 2016 11:28:15 Tomasz Nowicki wrote:
>>>>> On 19.04.2016 15:06, Arnd Bergmann wrote:
>>>>>> On Monday 18 April 2016 21:31:54 Tomasz Nowicki wrote:
>>>>>>>
>>>>>>> Basically the whole content of pci-thunder-ecam.c and pci-thunder-pem.c.
>>>>>>>
>>>>>>> pci-thunder-ecam.c contains config space accessors. Similar for
>>>>>>> pci-thunder-pem.c but it also has extra init call (it is now called
>>>>>>> thunder_pem_init) which finds and maps related registers.
>>>>>>
>>>>>> They seem to do much more than just override the accessors, they actually
>>>>>> change the contents of the config space as well. Is that really necessary
>>>>>> on ACPI based systems as well?
>>>>>
>>>>> Yes, the pci-thunder-ecam.c accessors are meant to emulate config space 
>>>>> capabilities. They are necessary to synthesize EA capabilities (fixed 
>>>>> PCI BARs), it wont work without this, for ACPI boot as well.
>>>>
>>>> Why is that? I thought the BARs never get reassigned when using ACPI,

Just to specifically jump in here and clarify this piece, which only
pertains to the specific platform's special extra host driver (which
generally speaking I am encouraging all future platforms not to do). In
other words, the following has nothing to do with the rest of the patch
series and is entirely down to one specific SoC and its implementation.

ThunderX supports two different methods of PCIe configuration space for
on-chip devices: with EA and without EA (which is being phased out). EA
(Enhanced Allocation) is a fancy way of saying "read only BARs". Intel
did the spec change for that in PCI SIG, so it wasn't us folks in the
ARM community doing something weird. The good folks at Cavium desired a
means to express their on-SoC hardware using PCI so that it was nice and
enumerable, but without full boat PCI. EA fit the bill better than just
wiring BARs as write ignore or whatever. Again, it's happening in many
cases and there must be a reason Intel wanted to get it also.

I believe pci-thunder-ecam.c contains code to support the older devices
that don't do full EA by faking the EA capabilities, but they can
clarify. The point is, this is a specific and separate issue with the
way one vendor has chosen to implement on-SoC devices as PCIe
discoverable but using the newer PCI EA extension. And then the quirk is
to handle that not every device that's out there yet has real EA.

>>> In general, there's no reason we can't reassign BARs, whether we're
>>> using DT, ACPI, or whatever.  In many cases, systems with ACPI also
>>> assign all the BARs in firmware, and Linux doesn't reassign them
>>> unless it needs to.  But that's just a coincidence.  There's no
>>> requirement that Linux leave BARs as firmware programmed them.

There's no requirement, generally, that PCI compliant devices with ECAM
can't be programmed with different base addresses. There's this PCI
change called EA that is disjoint and some vendors have chosen to use
it. We didn't catch that early in the definition of the SBSA for ARM,
but just as an aside, I have already suggested we require future
generations of chips to not use EA and only support writeable BARs (even
for the decoders in the on-SoC platformish devices doing "PCI"). This
isn't Cavium's fault - they did the right thing with the data at hand
and nobody really considered the impact of PCI getting EA added. Again,
that's something that will likely happen on x86 at some point (maybe it
already is, I don't get any data about future Intel stuff).

On the rest of the quirks and hacks. Without going into too much detail,
some "concerned citizens" are chatting with various folks to ensure that
many of these common quirks aren't needed in future parts.

>> I'm thought I've seen systems in which the ACPI BIOS assumes that
>> certain PCI devices never move around, because it pokes the registers
>> from AML, and changing them would require never using the same device
>> through ACPI. It's likely that this is against some standard, but that
>> won't help you if you have to deal with the system anyway.

Right. This has happened, I think, and there you're no worse off on ARM
than you would be on x86 if you had AML poking at something underneath.

> Yes, I'm pretty sure there are systems like that, e.g., I think SMM
> code on some HP servers assumes the iLO address never changes.  I
> think that is a firmware defect because I don't think there's any spec
> that says firmware retains control over PCI BARs after handoff.  And
> this particular case isn't really ACPI-specific.

If you substitute SMM for EL3 on ARM we're bound to eventually have the
same kinds of things happening on some systems. It's just life.

> But as you say, we have to deal with these systems anyway, even if we
> consider that behavior broken.  My proposal has been to add quirks to
> mark those devices as IORESOURCE_PCI_FIXED, but I don't think anybody
> has gotten around to doing that.

Good to know.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

