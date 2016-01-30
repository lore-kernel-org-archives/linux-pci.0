Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54489 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbcA3RvE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2016 12:51:04 -0500
Message-ID: <b7e1eb3b78a09c8aacc84a15cb165585.squirrel@www.codeaurora.org>
In-Reply-To: <20160130133027.GA16394@localhost>
References: <20160120160427.GD13437@red-moon>
    <569FB210.9090605@codeaurora.org> <20160129230645.GG12965@localhost>
    <56AC0065.5030909@codeaurora.org> <20160130133027.GA16394@localhost>
Date: Sat, 30 Jan 2016 17:51:03 -0000
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
From: Okaya@codeaurora.org
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Sinan Kaya" <okaya@codeaurora.org>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, "Zhou Wang" <wangzhou1@hisilicon.com>,
	"Phil Edworthy" <phil.edworthy@renesas.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Fri, Jan 29, 2016 at 07:14:29PM -0500, Sinan Kaya wrote:
>> On 1/29/2016 6:06 PM, Bjorn Helgaas wrote:
>> > On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
>> >> On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
>> >>>
>> >>> We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:
>> >>
>> >> For platforms that does not have UEFI BIOS, it makes sense to remove
>> the probe only
>> >> option as the firmware is not doing anything.
>> >
>> > I don't understand this statement.  It sounds like you mean "non-UEFI
>> > BIOS firmware doesn't assign PCI BARs", but that's not true, so you
>> > must mean something else.
>>
>> It depends on the firmware flavor. I know u-boot does some PCI
>> assignment but it does minimum to use PCI itself not for OS
>> consumption. It may not deal with with switches/bridges etc. or will
>> only assign mem32 resources and not touch prefetchable.
>
> Ah, I see the problem.  When you wrote "non-UEFI BIOS," I thought
> "old-fashioned x86 BIOS," which generally do assign resources.  But I
> don't have much experience with other firmware like U-boot.  There are
> good reasons, e.g., portability and boot-time optimization, why
> firmware might not touch things it doesn't need.  That's especially
> true for PCI resource assignment, where we know the OS must do it
> itself anyway, and there's little point in doing it twice.
>
>> Most non-UEFI firmwares I have seen on ARM rely on device specific
>> driver like synopsys etc. to do the device initialization and ask
>> kernel to do the enumeration.
>>
>> ACPI systems on the other hand handle the resource assignment before
>> the OS starts.
>
> My guess is that this is more of a tradition than anything actually
> required by the spec.
>
> The bottom line is that Linux can't rely on much consistency across
> the universe of architectures and firmwares.  I think the only thing
> that really makes sense for us to do is:
>
>   - Read whatever assignments the firmware may have made
>   - Keep them unchanged if they seem sensible
>   - Reassign them if they aren't sensible
>   - Use quirks to handle exceptions
>
> Bjorn
>


+1 to this list.

