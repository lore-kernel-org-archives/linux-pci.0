Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609300844.24325.linux@rainbow-software.org>
 <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
 <201609301756.25894.linux@rainbow-software.org>
 <94aee80e-f7c3-5732-ef1e-08e3ecb19e5e@codeaurora.org>
 <CAJZ5v0jr=KEfjo3HH6M2WhPCPCB9w1DYGB_VHhXDJXwjh76Pmg@mail.gmail.com>
 <5ee9b263-ed42-ee16-057e-2f4c1d2c1dc6@codeaurora.org>
 <CAJZ5v0isjggpiSnFYy_1omEorTD6HSWe2jCsRmvugyH6qiYq2g@mail.gmail.com>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a1d4d971-2737-c831-1f34-93f2be449478@codeaurora.org>
Date: Fri, 30 Sep 2016 17:14:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0isjggpiSnFYy_1omEorTD6HSWe2jCsRmvugyH6qiYq2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/30/2016 5:04 PM, Rafael J. Wysocki wrote:
>> >
>> > I hope it makes sense now. I tend to skip details sometimes. Feel free to
>> > send more questions.
> Thanks for the information!
> 
> IIUC, basically, what you are proposing would be to restore the old
> penalizing method for IRQs in the 0-255 range and use the new approach
> for the rest, right?

Correct. 

> 
> What's the drawback, if any?

I don't see any drawback to be honest. The reason why I got rid of these ISA
API functions was to remove some of the x86ism from ACPI code. This was Bjorn's
request to clean it up and we failed in two places so far. 

1. acpi_irq_penalty_init
2. acpi_penalize_sci_irq

and we ended up reverting both of these changes. The reverts are all because of the
fact that these APIs are called asynchronously without any coordination with the
PCI Link object or the interrupt controller driver about when it is a good time to be
called.

During this debug, I learnt that acpi_penalize_isa_irq gets called before even ACPI
gets to initialize and relies on static IRQ array for keeping the penalties.

> 
> Thanks,
> Rafael
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
