Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5601A5C2.4030206@caviumnetworks.com>
Date: Tue, 22 Sep 2015 12:02:26 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/3] PCI: generic: Add support for Cavium ThunderX PCIe
 root complexes.
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com> <1442529694-1792-4-git-send-email-ddaney.cavm@gmail.com> <20150922185230.GR7356@arm.com>
In-Reply-To: <20150922185230.GR7356@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/22/2015 11:52 AM, Will Deacon wrote:
> On Thu, Sep 17, 2015 at 11:41:34PM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The config space for external PCIe root complexes on some Cavium
>> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
>> shift values that have to be applied to the bus and devfn numbers to
>> compose that address window offset.  These root complexes also have
>> the interesting property that there is no root bridge, so the standard
>> manner of limiting scanning to only the first device doesn't work.  We
>> can use the standard pci-host-generic driver if we make a minor
>> addition to handle these differences, so we...
>>
>> Add a mapping function for ThunderX PCIe root complexes with a bus
>> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
>> than the first device on the primary bus.
>>
>> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   .../devicetree/bindings/pci/host-generic-pci.txt   |  8 +++---
>>   drivers/pci/host/pci-host-generic.c                | 29 ++++++++++++++++++++++
>>   2 files changed, 34 insertions(+), 3 deletions(-)
>
> Thanks, this looks better now:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>

Thanks Will.

Because patches 1/3 and 2/3 will be reworked, I will re-send this as a 
stand-alone patch.

David Daney


> Will
>

