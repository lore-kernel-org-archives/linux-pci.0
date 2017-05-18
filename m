Return-Path: <SRS0=xBUr=4Y=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=xBUr=4Y=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org> <20170517215611.GJ31462@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 18 May 2017 11:59:14 +0100
Message-ID: <CAKv+Gu9T7vH_LbKfS_40JUbLNK4PYrMi++eKbCq_MzBsuQxUDQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR configuration
 to be preserved
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Graeme Gregory <graeme.gregory@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Leif Lindholm <leif.lindholm@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 17 May 2017 at 22:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Apr 11, 2017 at 05:33:11PM +0100, Ard Biesheuvel wrote:
>> This is a followup to the discussion regarding whether ACPI/arm64 systems
>> should preserve the PCI configuration performed by the firmware, or always
>> reconfigure it from scratch.
>>
>> This series proposes to put it under the control of the firmware, by invoking
>> the _DSM method, and preserving the firmware configuration only when it
>> returns 0.
>>
>> Patch #1 is a preparatory bugfix that solves the issue that I/O bridge
>> windows starting at 0x0 are dismissed when looking for parent resources.
>>
>> Patch #2 adds the logic to invoke the _DSM and claim the existing
>> configuration rather than reallocate it from scratch if it returns '0'
>>
>> Ard Biesheuvel (2):
>>   drivers: pci: do not disregard parent resources starting at 0x0
>>   arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup
>>
>>  arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
>>  drivers/pci/pci.c        |  2 +-
>>  include/linux/pci-acpi.h |  7 ++++---
>>  3 files changed, 23 insertions(+), 6 deletions(-)
>
> I applied the first to pci/resource for v4.13.  I didn't do anything
> with the second because I don't think we have consensus on what the
> right thing to do is yet.

Thanks Bjorn.

Re PCI reconfiguration: currently, the EFI framebuffer is broken on
all systems where the associated BAR lives on a device that is not on
bus 0, which is of course everything other than QEMU (which cannot use
the EFI framebuffer for other reasons when running under KVM)

So the first question is whether anyone cares. I do, but not deeply:
the EFI framebuffer, while useful in cases where there is no real GFC
driver, is a bit of a hack anyway.

Then we have the question whether we can work around it in another
way: I already proposed an alternative patch which simply records the
associated BAR before PCI is reconfigured, and refuses to enable EFIFB
if the BAR has moves. This is a workaround rather than a real fix, but
in many cases, the kernel and UEFI appear to arrive at similar
conclusions regarding where to put the framebuffer BAR, probably
because of the simple reason that its size (ergo alignment) will cause
it to be allocated first.

Re _DSM: I think it makes sense to honour it, because it puts the
allocation under the control of the firmware, which completely removes
the burden of having to reason about a policy in the kernel. That
leaves the question which will be the default, but that is of minor
importance IMO.
