Return-Path: <SRS0=CBFd=GN=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=CBFd=GN=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180323210857.GA210003@bhelgaas-glaptop.roam.corp.google.com>
References: <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
 <20180314120547.GB2703@lahna.fi.intel.com> <20180314123332.GC19651@wunner.de>
 <20180320104508.GF2703@lahna.fi.intel.com> <20180320113556.GA24197@wunner.de>
 <20180322104517.GA20389@wunner.de> <20180322165317.GI2703@lahna.fi.intel.com>
 <20180322173903.GA15503@wunner.de> <20180322193630.GB252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323111856.GO2703@lahna.fi.intel.com> <20180323210857.GA210003@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Mar 2018 22:11:53 +0100
Message-ID: <CAJZ5v0iFSgC4gbWCi09Nr4rwa7r4QfAQ__Oz88cagMZ3Z_NnKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Keith Busch <keith.busch@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 23, 2018 at 10:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Mar 23, 2018 at 01:18:56PM +0200, Mika Westerberg wrote:
>> On Thu, Mar 22, 2018 at 02:36:30PM -0500, Bjorn Helgaas wrote:
>> > I hope we can avoid adding suspend_late/resume_early callbacks in
>> > struct pcie_port_service_driver, and I also hope we can avoid adding
>> > device links.  Those both sound pretty complicated.
>> >
>> > Can you do something like the patch below, which does something
>> > similar for PME?
>>
>> AFAICT the core PCI PM code follows the same ordering than what PM core
>> does so it may be possible that not all service drivers get
>> resumed/suspended before other children (PCI buses). Basically this
>> would be the same than just using core PM ops in DPC driver (in which
>> case DPC specific things are still kept in DPC driver not in PCI core).
>
> I'm not sure I follow this.  I assume the core PCI PM code guarantees
> that a bridge is suspended after its children and resumed before them.
> Are you saying that's not the case?

if this is a PCIe port, then there are two categories of childres:
port services and the PCI devices below it.

There are no ordering constraints between the former and the latter,
which appears to be a problem here.
