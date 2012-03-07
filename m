MIME-Version: 1.0
In-Reply-To: <CAE9FiQXsY7Dn5TGtD1ARM_KFdz1V1hJOvYAy6e4msM=i3VfhDg@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-24-git-send-email-yinghai@kernel.org>
	<CAErSpo5TjhNv1W=PxSPO6qXfhW1Mi4dMp83vj82=O_hFOq1vow@mail.gmail.com>
	<CAE9FiQXsY7Dn5TGtD1ARM_KFdz1V1hJOvYAy6e4msM=i3VfhDg@mail.gmail.com>
Date: Tue, 6 Mar 2012 20:49:33 -0700
Message-ID: <CABhMZUWDngY6jL8jkxQ+SHzEHqTS4i3DqtCD7DUBtL4QS58ovA@mail.gmail.com>
Subject: Re: [PATCH 23/23] x86, PCI: add pcibios_root_rescan
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

[Sorry, gmail made this HTML, so LKML rejected it.  Sigh.  Please
respond to this one, not the HTML one.]

On Tue, Mar 6, 2012 at 5:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Mar 6, 2012 at 3:13 PM, Bjorn Helgaas <bhelgaas@google.com> wrote=
:
>> On Tue, Mar 6, 2012 at 12:14 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> need use it to rescan root bus that was not added via acpi probe.
>>>
>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>> ---
>>> =A0arch/x86/pci/legacy.c | =A0 25 +++++++++++++++++++++++++
>>> =A01 files changed, 25 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/legacy.c b/arch/x86/pci/legacy.c
>>> index aab0e41..7a7c78f 100644
>>> --- a/arch/x86/pci/legacy.c
>>> +++ b/arch/x86/pci/legacy.c
>>> @@ -79,3 +79,28 @@ int __init pci_subsys_init(void)
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> =A0subsys_initcall(pci_subsys_init);
>>> +
>>> +void __devinit pcibios_root_rescan(void)
>>> +{
>>> + =A0 =A0 =A0 int busn;
>>> + =A0 =A0 =A0 struct pci_bus *bus;
>>> +
>>> + =A0 =A0 =A0 if (pcibios_last_bus <=3D 0 || pcibios_last_bus > 0xff)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>> +
>>> + =A0 =A0 =A0 for (busn =3D 0; busn <=3D pcibios_last_bus; busn++) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_find_bus(0, busn);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bus)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D __pcibios_scan_specific_bus(busn,=
 false);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bus)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_assign_unassigned_bus_resources(bus);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_devices(bus);
>>> + =A0 =A0 =A0 }
>>> +}
>>
>> Do we need it? =A0I assume we only care about host bridge hotplug via AC=
PI on x86.
>
> my sandbridge system has cpu bus 0x7f, and 0xff in DSDT.
>
> but nehalem and westmere system does not have cpu bus 0xf8, ... 0xff.

I think you're saying that on some machines, the BIOS decided not to
expose host bridges leading to CPU devices, and you want to discover
those devices anyway.  (What's the reason you want to discover them?)

I guess that's OK for now, but I don't like this strategy in general.
The expectation of BIOS writers is that the OS will discover things
using the ACPI namespace and not go grubbing around outside that.
Sometimes the BIOS has good reasons to hide things from the OS, e.g.,
to keep the OS from tripping over hardware defects, to reduce support
calls by preventing users from making dangerous changes, etc.

Bjorn
