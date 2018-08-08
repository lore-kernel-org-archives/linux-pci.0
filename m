Return-Path: <SRS0=iI2m=KX=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=iI2m=KX=broadcom.com=ray.jui@kernel.org>
Subject: Re: [RFC] ARM64, PCIe, annd ACPI
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>,
 Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <89484aa0-08c4-0cff-500d-407d21e2f5fd@broadcom.com>
 <20180808021025.GC49411@bhelgaas-glaptop.roam.corp.google.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <be61d512-5a68-7320-a205-2a6fbd24ce81@broadcom.com>
Date: Wed, 8 Aug 2018 11:46:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180808021025.GC49411@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 8/7/2018 7:10 PM, Bjorn Helgaas wrote:
> On Tue, Aug 07, 2018 at 05:10:15PM -0700, Ray Jui wrote:
>> Hi Lorenzo/Bjorn,
>>
>> I have a question on PCIe controller APCI support on ARM64 based systems.
>>
>> If my understanding of the implementation of "pci_acpi_scan_root" under
>> "arch/arm64/kernel/pci.c" is correct, it appears
>> "pci_acpi_setup_ecam_mapping" is called within "pci_acpi_scan_root".
>>
>> Does that mean for a PCIe host controller on ARM64 to support ACPI, it needs
>> to support ECAM and MMIO based access to the configuration space registers?
>   
> Yes.  In my opinion, a PCIe host controller is generally required to
> support ECAM even if the platform doesn't support ACPI.  I base this
> on PCIe r4.0, sec 7.2.2:
> 
>    For systems that are PC-compatible, or that do not implement a
>    processor-architecture-specific firmware interface standard that
>    allows access to the Configuration Space, the ECAM is required as
>    defined in this section.
> 
>> If the above statement is true, does it imply that any PCIe controller on
>> ARM64 that does not support MMIO based access to the config space register
>> cannot have ACPI support?
> 
> We would treat that as a non-compliant platform that requires special
> quirks to work around the problem.  That does mean we have to add
> platform-specific quirks, which of course means we can't run an old
> kernel on a new platform that lacks standard ECAM.  There are several
> existing systems like this.
> 
> The notes and examples here should be a place to start:
> 
>    drivers/pci/controller/Makefile
>    drivers/pci/controller/dwc/Makefile
>    drivers/acpi/pci_mcfg.c
> 
> Bjorn
> 

Thanks for the pointers, Bjorn! Very helpful!

Ray
