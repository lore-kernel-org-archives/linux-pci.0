Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56168F4F.7030000@caviumnetworks.com>
Date: Thu, 8 Oct 2015 08:44:15 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/5] PCI: generic: Misc. bug fixes/enhancements
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com> <20151008152811.GD3885@localhost>
In-Reply-To: <20151008152811.GD3885@localhost>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2015 08:28 AM, Bjorn Helgaas wrote:
> On Fri, Oct 02, 2015 at 11:43:58AM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
[...]
>>
>> David Daney (5):
>>    PCI: Add pci_bus_fixup_irqs().
>>    PCI: generic: Only fixup irqs for bus we are creating.
>
> I'm hoping we won't need the above if we can resurrect Matthew's
> patches.

I will test some things with this today.


>
>>    PCI: generic: Quit clobbering our pci_ops.
>
> Applied to pci/host-generic for v4.4 with Arnd's Reviewed-by and minor
> changelog tweaks (as below).
>
>>    PCI: generic: Correct, and avoid overflow, in bus_max calculation.
>
> Seems not settled yet.
>
>>    PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
>
> Also applied to pci/host-generic, thanks!
>

Many thanks for getting those two in,


David Daney





