Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 13 Nov 2015 17:03:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [Patch v7 4/7] PCI/ACPI: Add interface acpi_pci_root_create()
Message-ID: <20151113170316.GB15253@red-moon>
References: <20151109171042.GA11909@red-moon>
 <6488357.xJV65iBRHq@wuerfel>
 <564185B6.8040006@linux.intel.com>
 <20151111174647.GA30051@red-moon>
 <56445117.8090307@linux.intel.com>
 <56449246.2010308@semihalf.com>
 <56449C55.2090001@linux.intel.com>
 <5644A613.2010304@semihalf.com>
 <5644AAB9.6010700@linux.intel.com>
 <5645DE3A.7040406@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5645DE3A.7040406@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please trim your emails, thanks.

On Fri, Nov 13, 2015 at 01:57:30PM +0100, Tomasz Nowicki wrote:
> On 12.11.2015 16:05, Jiang Liu wrote:

[...]

> >>>IA64 actually ignores the translation type flag and just assume it's
> >>>TypeTranslation, so there may be some IA64 BIOS implementations
> >>>accidentally using TypeStatic. That's why we parsing SparseTranslation
> >>>flag without checking TranslationType flag. I feel ARM64 may face the
> >>>same situation as IA64:(
> >>>
> >>>We may expect (TypeStatic, 0-offset) and (TypeTranslation,
> >>>non-0-offset) in real word. For other two combinations, I haven't
> >>>found a real usage yet, though theoretically they are possible.

I do not understand why (TypeStatic, non-0-offset) is not a valid
option. Aren't there any (x86) platforms with a CPU<->PCI _physical_
address space offset out there (I am talking about memory space) ?

> >>I think we should not bend the generic code for IA64 only and expose
> >>other platforms to the same issue. Instead, lets interpret spec
> >>correctly and create IA64 quirk for the sake of backward compatibility.
> >>Thoughts?
> >I think there are at least two factors related to this issue.
> >
> >First we still lack of a way/framework to fix errors in ACPI resource
> >descriptors. Recently we have refined ACPI resource parsing interfaces
> >and enforced strictly sanity check. This brings us some regressions
> >which are really BIOS flaws, but it used to work and now breaks:(
> >I'm still struggling to get those regressions fixed. So we may run
> >into the same situation if we enforce strict check for TranslationType:(
> >
> >Second enforcing strict check doesn't bring us too much benifits.
> >Translation type is almost platform specific, and we haven't found a
> >platform support both TypeTranslation and TypeStatic, so arch code
> >may assume the correct translation type no matter what BIOS reports.
> >So it won't hurt us even BIOS reports wrong translation type.

TBH I still do not understand what TranslationType actually means,
I will ask whoever added that to the specification to understand it.

> That is my point, lets pass down all we need from resource range
> descriptors to arch code, then archs with known quirks can whatever
> is needed to make it works. However, generic code like
> acpi_decode_space cannot play with offsets with silent IA64
> assumption.
> 
> To sum it up, your last patch looks ok to me modulo Lorenzo's concern:
> >>>>>> If we go with this approach though, you are not adding the offset to
> >>>>>> the resource when parsing the memory spaces in acpi_decode_space(),
> >>>>>> are we
> >>>>>> sure that's what we really want ?
> >>>>>>
> >>>>>> In DT, a host bridge range has a:
> >>>>>>
> >>>>>> - CPU physical address
> >>>>>> - PCI bus address
> >>>>>>
> >>>>>> We use that to compute the offset between primary bus (ie CPU
> physical
> >>>>>> address) and secondary bus (ie PCI bus address).
> >>>>>>
> >>>>>> The value ending up in the PCI resource struct (for memory space) is
> >>>>>> the CPU physical address, if you do not add the offset in
> >>>>>> acpi_decode_space
> >>>>>> that does not hold true on platforms where CPU<->PCI offset != 0 on
> >>>>>> ACPI,
> >>>>>> am I wrong ?
> His concern is that your patch will cause:
> acpi_pci_root_validate_resources(&device->dev, list,
> 				 IORESOURCE_MEM);
> to fail now.

Not really. My concern is that there might be platforms out there with
an offset between the CPU and PCI physical address spaces, and if we
remove the offset value in acpi_decode_space we can break them,
because in the kernel struct resource data we have to have CPU physical
addresses, not PCI ones. If offset == 0, we are home and dry, I do not
understand why that's a given, which is what we would assume if Jiang's
patch is merged as-is unless I am mistaken.

Thanks,
Lorenzo
