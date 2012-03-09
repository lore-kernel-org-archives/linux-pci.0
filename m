Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAErSpo7W_2skcxsgFia+4caf1MgXCt3jqXCrKdX7q3EZ-KLP2Q@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<CABhMZUU_YNMXAU0Mr5zQMzxrk_XkFzk1HrwAN0SQxDf8n+F9kA@mail.gmail.com>
	<CAE9FiQVNYWnZzfdNsW38P4vsD1ZpXeA+SwqqDK45SZAAphz_6A@mail.gmail.com>
	<CAErSpo7W_2skcxsgFia+4caf1MgXCt3jqXCrKdX7q3EZ-KLP2Q@mail.gmail.com>
Date: Fri, 9 Mar 2012 00:19:30 -0800
Message-ID: <CAE9FiQVxno4xGg_SSrbBVs+nifP8+=cqS8SzD5kvVr2cvJD0wA@mail.gmail.com>
Subject: Re: [PATCH 00/23] PCI, x86: pci root bus hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <bjorn.helgaas@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	x86 <x86@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 8, 2012 at 4:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Mar 6, 2012 at 11:58 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Tue, Mar 6, 2012 at 8:44 PM, Bjorn Helgaas <bjorn.helgaas@gmail.com> =
wrote:
>>> On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> Does this series support hot-add, too, or just removal?
>>>
>>> If it is intended to support hot-add, I didn't see any support for
>>> _CBA, which I *think* is the way hotplug-capable host bridges are
>>> required to report MMCONFIG areas.
>>
>> to make the whole hotplug working with intel new cpus with IIO,
>> in addition to physical cpu and memory hotplug, will still need
>> a. ioapic controller hotplug
>> b. intr-remapping hotplug
>> c. intel-iommu hotplug
>> d. mmconf support.
>> e. root bus hotplug
>>
>> this patch set is only involved with partitally root bus removal/add bac=
k.
>> and assume ioapic, intr-remap, intel-iommu, and mmconf related are
>> working from early initialization.
>>
>> that will help us to help to fix bugs like devices refcount leaking.
>
> OK, so this series only supports host bridge removal. =A0There are some
> situations where it allows a bridge to be added, but only if the other
> things you mentioned (ioapic, intr-remapping, etc.) are already
> present, probably because we didn't remove them when removing the host
> bridge.

yes.

pci based ioapic support is there for x86....

still need to look at acpi based: ioapic, iommu. etc.

>
> In the case of MMCONFIG in particular, I think this should be moved
> into the host bridge add path, e.g., in acpi_pci_root_add(). =A0The fact
> that it's totally separate today is a mistake. =A0But that can be fixed
> later.

could have different pci_ops to make it simple.

but need to kill direct using of raw_pci_read/writing at first.

>
> Overall nits, because kernel development is obsessive by nature:
> Please format your changelogs with textwidth=3D75, so that when you read
> them with "git log" in an 80-column terminal, the normal text doesn't
> wrap across a line ending.
>
> Please make your subject lines lines consistent in style and
> capitalization. =A0Sometimes you have "PCI", sometimes "pci". =A0Sometime=
s
> the first word after "PCI: " is capitalized, sometimes not. =A0One of
> your intel-iommu.c patches is "IOMMU:"; the other is "pci, dmar:" (and
> these patches are not adjacent in the series, even though they could
> be). =A0This is just sloppy and distracting.

Sorry, that patch sit on local directly for some time,  and forget to updat=
e
subject this time.

>
> In English, the first word of a sentence is capitalized. =A0Words in the
> middle are not, unless they are acronyms or proper nouns. =A0It would be
> helpful if you could follow these conventions in your changelogs,
> because I expect to be reading them for years to come, and I'm easily
> distracted.
...
>
> The notes about "-v2, -v3, -v4, etc." are not really useful in the
> commit changelogs. =A0They're helpful in the [00/] message, but not in
> the changelogs.

But Jesse may still need mark to figure out which one is latest?

>
> I appreciate the effort you're making to write changelogs. =A0They're
> definitely starting to contain some useful information.

Sure, will try my best on that part.

Thanks

Yinghai
