Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0100.outbound.protection.outlook.com ([157.56.110.100]:18272
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932168AbbI2QDp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Sep 2015 12:03:45 -0400
Message-ID: <560AB653.6070602@caviumnetworks.com>
Date: Tue, 29 Sep 2015 09:03:31 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder
 fixed BARs.
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com> <1981236.3bSkWiA8PH@wuerfel>
In-Reply-To: <1981236.3bSkWiA8PH@wuerfel>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/29/2015 12:42 AM, Arnd Bergmann wrote:
> On Monday 28 September 2015 17:56:24 David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Early versions of the Cavium Thunder CN88XX processor are missing
>> Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
>> by the on-SoC hardware blocks.
>>
>> Add config access functions that synthesize the missing EA
>> capabilities for versions that are missing that information.  Since
>> this is a little hacky, gate the inclusion of the code with a new
>> Kconfig variable.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>
>> As suggested by Bjorn Helgaas...  It is RFC at this point, but this is
>> working well for me.
>
> I don't have an opinion on the way you implement the config space
> accessors, but it seems that the overall amount of code is comparable
> to the normal pci-host-generic driver without this,

That is not a correct interpretation of the patch.  We need *both* 
files.  So if we, hypothetically, duplicated the contents of 
pci-host-generic.c and combined it with the new 
thunder_ecam_config_io.c, the result would be over twice as much code. 
That doesn't even address the anti-pattern of making many copies of the 
common code (unfactoring?) found in pci-host-generic.c  I am not even 
going to attempt such a thing as it would surely receive many NAKs.

> and it is not
> really generic at all.

The "generic" part of that driver really refers to the framework of 
parsing the OF device tree, mapping the config space address windows and 
creating and scanning of the PCI buses.  It already contains several 
specializations of config space accessors, my patch just adds an 
additional config space accessor.

>
> I think because of this, it makes more sense to have a separate top-level
> driver for this and not reuse the pci-host-generic implementation here.

I will not do that, as some of our first attempts at getting PCI support 
merged used that strategy, and were NAKed for being reimplementations of 
pci-host-generic.c

The current thinking on Cavium ThunderX on-SoC PCI buses really consists 
of two options:

1) Use pci-host-generic.c with existing ECAM config space accessors. 
Set PCI_PROBE_ONLY, and then enumerate and assign BARs for all external 
PCIe devices in firmware.

2) Use pci-host-generic.c with this new EA synthesizing config space 
accessor.

My interpretation of Bjorn Helgaas' suggestion was to do #2, and the 
first attempt at this is this patch.

David Daney

