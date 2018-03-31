Return-Path: <SRS0=A2bG=GV=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=A2bG=GV=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180331095615.GT2703@lahna.fi.intel.com>
References: <20180226132112.81447-2-mika.westerberg@linux.intel.com>
 <20180327185742.GB7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180328114346.GZ2703@lahna.fi.intel.com> <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com> <20180331082903.GA21051@wunner.de>
 <20180331085852.GQ2703@lahna.fi.intel.com> <20180331091245.GA10720@wunner.de>
 <20180331092017.GS2703@lahna.fi.intel.com> <CAJZ5v0iFP3VuJoMD2PXp73WoszB3rDFpro6Sgy5PnrVp0Zz0zQ@mail.gmail.com>
 <20180331095615.GT2703@lahna.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 31 Mar 2018 12:05:50 +0200
Message-ID: <CAJZ5v0hUHZQDYnzhORReCZkTyszQBvSARLnDrc-8N4nfFHt2wA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <Mario.Limonciello@dell.com>, Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 11:56 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Sat, Mar 31, 2018 at 11:30:44AM +0200, Rafael J. Wysocki wrote:
>> > The whole point here is that those are *not* hotplug slots just regular
>> > downstream ports.
>>
>> I'm not sure what scenario exactly you are referring to to be honest.
>>
>> Something related to Thunderbolt I suppose?
>
> Here is an example that hopefully clarifies. This example is from a
> system using Thunderbolt in "native" mode but I think it is not specific
> to Thunderbolt. The idea is that when you don't have anything connected
> to Thunderbolt ports you have following PCI topology:
>
>   00:1b.0 --
>
> So a root port that is hotplug capable and handled by pciehp.
>
> Next when you plug in a Thunderbolt enpdoint, you get native PCIe
> hotplug event and after it is handled the topology looks like:
>
>   00:1b.0 --- 01:00.0 --+- 02:00.0 --
>                         +- 02:01.0 (hotplug) --
>                         \- 02:02.0 --
>
> In other words there is a PCIe switch with one hotplug port (02:01.0)
> that is again handled by pciehp (this is used to daisy chain further
> devices). However, downstream ports 02:00.0 and 02:02.0 are not marked
> as hotplug capable so pciehp is not controlling them.
>
> To bring in xHCI and/or Thunderbolt host controller we get ACPI Notify()
> to the root port 00:1b.0 which should result following topology after
> handled by acpiphp:
>
>   00:1b.0 --- 01:00.0 --+- 02:00.0 -- Thunderbolt host controller
>                         +- 02:01.0 (hotplug) --
>                         \- 02:02.0 -- xHCI host controller
>
> In other words ACPI Notify() is used to populate devices connected to
> non-hotplug downstream ports. It is also used to "hot-unplug" them in
> the same way (for example if you only connect standard USB-C device to
> the port the Thunderbolt host controller is hot-unplugged using this
> mechanism).
>
> Rest of the devices in the chain are hotplugged using standard native
> PCIe hotplug so pciehp will be controlling then.

OK, thanks!

I thought it would be something like this. :-)

So the mechanism is not TBT-specific in principle, but I don't think
that it is used in practice anywhere outside of Thunderbolt.

I also think that it would be good to put the above example somewhere
like a git commit changelog or even a comment in the code, so people
in the future don't have to wonder what this is all about.
