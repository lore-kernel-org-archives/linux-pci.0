Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <4220489.2ZUOL1U5cK@vostro.rjw.lan>
 <d3fd8f7a-520d-d204-87d8-e9f59fb8f180@codeaurora.org>
 <201609281032.35190.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b404278b-d8e1-2b16-e044-c30d27ba8c25@codeaurora.org>
Date: Wed, 28 Sep 2016 10:11:39 -0400
MIME-Version: 1.0
In-Reply-To: <201609281032.35190.linux@rainbow-software.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/28/2016 4:32 AM, Ondrej Zary wrote:
>>> OK
>>> > >
>>> > > Sinan, can you help, please?
>> >
>> > Sure, let's see what's going on. I was writing an email.
>> >
>> > Can we apply this and collect the kernel log? It also helps to see the
>> > kernel log from a working combination.
> This is from yet another machine with the same problem:

Thanks, It sounds like you have more than one machine with similar problems.
Can you collect the log from the other machines with 4.8-rc8? 

and also a boot log with 4.6 kernel where things are working?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
