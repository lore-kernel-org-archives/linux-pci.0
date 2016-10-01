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
 <a1d4d971-2737-c831-1f34-93f2be449478@codeaurora.org>
 <CAJZ5v0gKFVEYFhyge8+_ZTSg_OK6uzBByivgbvEV-Up4Q3YSiw@mail.gmail.com>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <dda55738-d52b-1cdd-8973-8dea3506a835@codeaurora.org>
Date: Sat, 1 Oct 2016 13:49:17 -0400
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gKFVEYFhyge8+_ZTSg_OK6uzBByivgbvEV-Up4Q3YSiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/30/2016 5:27 PM, Rafael J. Wysocki wrote:
>>> >> What's the drawback, if any?
>> >
>> > I don't see any drawback to be honest.
> I'd go for it then, if Bjorn doesn't hate it.
> 

I posted a follow up patch a minute ago. 

[PATCH 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array size to 16"
[PATCH 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
[PATCH 3/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"

Can we have some testing coverage? and eventually have tested-by?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
