Return-Path: <SRS0=cf5F=6A=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=cf5F=6A=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170627234326.GO17844@bhelgaas-glaptop.roam.corp.google.com>
References: <12296383.UdE5HVtyng@aspire.rjw.lan> <2524735.NRzn8A9HAf@aspire.rjw.lan>
 <20170627234326.GO17844@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jun 2017 01:49:29 +0200
Message-ID: <CAJZ5v0jzyj=gEu9NXYaf1mM3XG+4GcRuWcz+Pwhq67ZVEg4Y4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM: Unify the handling of device wakeup settings
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 1:43 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Rafael,

Hi Bjorn,

> On Sat, Jun 24, 2017 at 01:50:55AM +0200, Rafael J. Wysocki wrote:
>> On Monday, June 19, 2017 11:31:58 PM Rafael J. Wysocki wrote:
>> > Hi All,
>> >
>> > The handling of device wakeup settings, especially in the ACPI core and the PCI
>> > bus type, depends on whether it is about system wakeup from sleep states or
>> > remote wakeup in the working state (runtime).  However, that distinction is
>> > mostly based on the ACPI concept of "wakeup" and "runtime" GPEs, which is
>> > somewhat artificial, because the underlying hardware mechanism is basically
>> > the same in both cases.
>> >
>> > Moreover, suspend-to-idle is now supported as a sleep state and wakeup from it
>> > is based on exactly the same hardware capabilities as the working-state
>> > (runtime) remote wakeup.
>> >
>> > The following patch series removes that distinction and unifies the handling of
>> > device wakeup settings between system sleep and runtime.  It also fixes one
>> > issue related to wakeup signaling through PCI bridges.
>> >
>> > [1/6]: Get rid of the "runtime wakeup" concept from the ACPI core.
>> > [2/6]: Unify device wakeup settings code paths in the ACPI core.
>> > [3-4/6]: Unify device wakeup settings code paths in the PCI bus type code.
>> > [5/6]: Fix wakeup-related issue with bridges in the PCI bus type code.
>> > [6/6]: Get rid of the "runtime wakeup" concept from the driver core.
>> >
>> > The series is based on current linux-next and will be made available for
>> > testing in the linux-pm.git tree in a couple of days.
>>
>> Here's a v2 with tentatively added Reviewed-by tags from Mika.
>>
>> I've dropped patch [5/6] from the previous iteration as it didn't really belong
>> here and the issue it attempted to fix is rather theoretical.  I'm going to
>> take a different approach there.
>>
>> Apart from this, the function previously called acpi_pm_device_wakeup() has
>> a different name now: acpi_pm_set_device_wakeup(), to possibly avoid
>> confusion about its purpose.
>>
>> Also the changelog of patch [3/5] has been modified slightly.
>
> This series does touch drivers/pci, but is mostly ACPI.  Do you want
> to take it via your tree?

Yes, I do.

> I have a couple PM changes in my tree, but
> I don't see anything that should conflict with this series.
>
> For the PCI parts:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
