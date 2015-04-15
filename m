Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo4tOqv+raFs2LH8sYBmg9vTbNAmKt2KSKFkCJ1dc_QJsw@mail.gmail.com>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan>
	<1429025292.3383705.253616133.4A1DF301@webmail.messagingengine.com>
	<2638174.Fqeb1nNFUX@vostro.rjw.lan>
	<CAErSpo4tOqv+raFs2LH8sYBmg9vTbNAmKt2KSKFkCJ1dc_QJsw@mail.gmail.com>
Date: Wed, 15 Apr 2015 15:16:01 +0200
Message-ID: <CAJZ5v0g+zdvDMyg+YE4iUH5Q6HCCQDfhfXZo9=euNYv0=BiGLw@mail.gmail.com>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to parent
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 15, 2015 at 2:55 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Apr 14, 2015 at 8:03 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, April 14, 2015 12:28:12 PM Henrique de Moraes Holschuh wrote:
>>> On Mon, Apr 13, 2015, at 11:23, Rafael J. Wysocki wrote:
>>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> >
>>> > Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
>>> > / nouveau: Fix VGA switcheroo problem related to hotplug) to propagate
>>> > the ignore_hotplug setting of the device to its parent bridge in case
>>> > hotplug notifications related to the graphics adapter switching are
>>> > given for the bridge rather than for the device itself (the need to
>>> > be ignored in both cases).
>>>
>>> I do apologise if this is a stupid question, but is there any chance the
>>> bridge will be connected to other devices that do require hotplug handling,
>>> and not just to the GPU?
>>
>> The bridge is actually a downstream PCIe port holding the GPU, so no. :-)
>
> When radeon/nouveau call pci_ignore_hotplug(), that's the case, but in
> general all we know is that pci_ignore_hotplug() receives a PCI
> device.  We don't know whether it's PCI or PCIe.  In the hotplug
> topologies I'm familiar with, a bridge only leads to one hot-pluggable
> slot, but I don't remember anything that would guarantee that.  For
> PCIe, I think there can only be one slot, but for PCI I would think it
> possible to have one bridge leading to several hotpluggable slots,
> with the hotplug controller(s) being separate from the bridge.

Realistically, the switcheroo people are the only users of
pci_ignore_hotplug() today and if somebody wants the hotplug events to
be ignored for him and perhaps not for someone else on the same
bridge, then something is seriously broken about that system anyway.

Still, it is up to you whether or not to apply the patch. :-)

Rafael
