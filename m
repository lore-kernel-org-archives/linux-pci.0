Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1470713005-23690-1-git-send-email-rui.y.wang@intel.com>
References: <20160808202251.GB6129@localhost> <1470713005-23690-1-git-send-email-rui.y.wang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Aug 2016 14:09:32 +0200
Message-ID: <CAJZ5v0hPCnDRjntnj-x7D_0FKkdO7Rtxzjp7xnmg57ngidxCiA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] x86/ioapic: Support hot-removal of IOAPICs present
 during boot
To: Rui Wang <rui.y.wang@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 9, 2016 at 5:23 AM, Rui Wang <rui.y.wang@intel.com> wrote:
> On Tuesday, Aug 9, 2016 4:23 AM, Bjorn Helgaas wrote:
>> On Sun, Jun 26, 2016 at 11:44:57AM +0800, Rui Wang wrote:
>> > v5: Remove #ifdef CONFIG_X86 from setup-bus.c, making it neutral to
>> archs.
>> > v4: Add comments explaining when to call acpi_ioapic_add().
>> > v3: Previous versions break mips. This version fixes it.
>> >
>> > IOAPICs present during system boot aren't added to ioapic_list, thus
>> > are unable to be hot-removed. Fix it by calling
>> > acpi_ioapic_add() during root bus enumeration.
>> >
>> > Signed-off-by: Rui Wang <rui.y.wang@intel.com>
>>
>> Hi Rui,
>>
>> Where are we at with this?  If there's anything that still needs to be merged,
>> can you rebase it to v4.8-rc1 and post a new, complete, series?
>>
> Hi Bjorn,
>
> Yes. These patches are needed for IOAPIC hotplug to work.
>
> So Thomas & Rafael, any advice?

Can you please do as per what Bjorn said?  That is, rebase the series
on top of 4.8-rc1 and post it afresh?

Thanks,
Rafael
