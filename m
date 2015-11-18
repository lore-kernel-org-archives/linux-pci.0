Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: completely disable aspm if it's unsupported
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1447856703-2566-1-git-send-email-jbacik@fb.com>
 <20151118184038.GA4462@localhost>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <bhelgaas@google.com>, <shli@fb.com>,
	<kernel-team@fb.com>, Matthew Garrett <mjg59@coreos.com>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <564CCAC2.5050600@fb.com>
Date: Wed, 18 Nov 2015 14:00:18 -0500
MIME-Version: 1.0
In-Reply-To: <20151118184038.GA4462@localhost>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/18/2015 01:40 PM, Bjorn Helgaas wrote:
> [+cc Matthew]
>
> Hi Josef,
>
> On Wed, Nov 18, 2015 at 09:25:03AM -0500, Josef Bacik wrote:
>> We have some hardware that takes about 30 seconds to setup common clocks for
>> ASPM, but our bios'es don't actually allow ASPM.  It seems we had this thing in
>> place where we would disable ASPM after the pci bus probe so that we would make
>> sure that pre pcie 1.1 devices would be properly skipped during initialization.
>> This is because the mechanism to disable ASPM doesn't actually disable the
>> setting up of the link state stuff, it just keeps us from changing the link
>> state after the fact.  So instead make it so that when we call pcie_no_aspm()
>> that we disable ASPM completley, that is we skip setting up the link state and
>> everything.  This way we avoid the costly setup for a feature we cannot support
>> in the first place and we also make sure we are safe from future tampering with
>> the ASPM link state.  Thanks,
>
> Can you clarify what your BIOS does?  I assume it's an x86 ACPI BIOS.
> Does it enable ASPM before handing off to the OS?  Does it set the
> ACPI_FADT_NO_ASPM bit? (ACPI spec 5.0, sec 5.2.9.3)
>
> You're changing the _OSC failure path.  Why does _OSC fail?  I know
> there is some sort of unresolved problem there
> (https://bugzilla.kernel.org/show_bug.cgi?id=94661); maybe you're
> tripping over that?
>

This is what I see in dmesg

[ 8.647398] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI]
[ 8.647716] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

So seems like the same bug?

> It seems like you're proposing to reverse what Matthew just did with
> 387d37577fdd ("PCI: Don't clear ASPM bits when the FADT declares it's
> unsupported").
>

It looks to me I'm doing what Matthew set out to do, only with a bigger 
hammer ;).  His patch still allowed the initialization of the ASPM 
stuff, like setting up the clocks and such, but then made it so we 
couldn't change the ASPM state at all.  My patch goes the step further 
of not even doing the initialization stuff.  Thanks,

Josef

