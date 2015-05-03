Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0140.outbound.protection.outlook.com ([65.55.169.140]:18272
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750990AbbECVGW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 3 May 2015 17:06:22 -0400
Message-ID: <55468DC7.6090003@amd.com>
Date: Sun, 3 May 2015 16:06:15 -0500
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: Jayachandran C <jchandra@broadcom.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
 <6662179.AoBfCMOsxD@wuerfel> <20150429174356.GA20947@red-moon>
In-Reply-To: <20150429174356.GA20947@red-moon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 4/29/15 12:43, Lorenzo Pieralisi wrote:
> On Wed, Apr 29, 2015 at 01:34:20PM +0100, Arnd Bergmann wrote:
>> >On Wednesday 29 April 2015 17:09:58 Jayachandran C wrote:
>>> > >The current code in pci-host-generic.c uses pci_common_init_dev()
>>> > >from the arch/arm/ to do a part of the PCI initialization, and this
>>> > >prevents it from being used on arm64.
>>> > >
>>> > >The initialization done by pci_common_init_dev() that is really
>>> > >needed by pci-host-generic.c can be done in the same file without
>>> > >using the hw_pci API of ARM.
>>> > >
>>> > >The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
>>> > >this is be handled by setting up 'struct gen_pci' to embed a
>>> > >pci_sys_data variable as the first element on the ARM platform.
>>> > >
>>> > >Signed-off-by: Jayachandran C<jchandra@broadcom.com>
>> >
>> >This seems very useful
> Yes, it is getting less awful, waiting for pci_sys_data to disappear.
>

Lorenzo,

A while back, you mentioned here (https://lkml.org/lkml/2015/2/16/364) 
that the ARM32 pcibios_align_resource() implementation requires
pci_sys_data, so we _still_ rely on pci_common_init_dev to create one
for us. Is this still the case?

I am looking at the arch/arm32/kernel/bios32.c: pcibios_init_hw() and 
see that it setup the pci_sys_data.align_resource to 
hw_pci.align_resource (see here 
http://lxr.free-electrons.com/source/arch/arm/kernel/bios32.c#L471).

However it seems that the hw_pci.align_resource is never setup in the 
pci-host-generic.c.  Am I missing something here?

Thanks,

Suravee
