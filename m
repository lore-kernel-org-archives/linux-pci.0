Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5ee9b263-ed42-ee16-057e-2f4c1d2c1dc6@codeaurora.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609300844.24325.linux@rainbow-software.org> <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
 <201609301756.25894.linux@rainbow-software.org> <94aee80e-f7c3-5732-ef1e-08e3ecb19e5e@codeaurora.org>
 <CAJZ5v0jr=KEfjo3HH6M2WhPCPCB9w1DYGB_VHhXDJXwjh76Pmg@mail.gmail.com> <5ee9b263-ed42-ee16-057e-2f4c1d2c1dc6@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Sep 2016 23:04:23 +0200
Message-ID: <CAJZ5v0isjggpiSnFYy_1omEorTD6HSWe2jCsRmvugyH6qiYq2g@mail.gmail.com>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 10:24 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 9/30/2016 3:39 PM, Rafael J. Wysocki wrote:
>>> how do we feel about increasing the ISA IRQ range to 256 so that
>>> > we are safe for all SCI interrupts?
>> I'm not sure how this is related to the problem at hand.  Care to elaborate?
>>
>
> Sure, let me explain.
>

[cut]

>
> I hope it makes sense now. I tend to skip details sometimes. Feel free to
> send more questions.

Thanks for the information!

IIUC, basically, what you are proposing would be to restore the old
penalizing method for IRQs in the 0-255 range and use the new approach
for the rest, right?

What's the drawback, if any?

Thanks,
Rafael
