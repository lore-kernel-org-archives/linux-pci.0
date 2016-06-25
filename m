Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 25 Jun 2016 04:51:03 -0400
From: okaya@codeaurora.org
To: wim@djo.tudelft.nl
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
In-Reply-To: <20160625013920.GA26737@djo.tudelft.nl>
References: <57686D67.8010201@codeaurora.org>
 <20160621124715.GB3528@djo.tudelft.nl> <576943BA.1000001@codeaurora.org>
 <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl> <576BF86E.8060302@codeaurora.org>
 <576C042B.20507@codeaurora.org> <20160623232533.GA14984@djo.tudelft.nl>
 <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
 <20160625013920.GA26737@djo.tudelft.nl>
Message-ID: <3bf1261bc7a931cb5e1e93ea0d66b265@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2016-06-24 21:39, Wim Osterholt wrote:
> On Fri, Jun 24, 2016 at 02:09:15AM -0400, Sinan Kaya wrote:
>> 
>> Can you give it a try?
> 
> Whell, I tried to no avail.
> 
> Wether it is on 4.6 or 4.7, with or without your previous patch,
> I keep getting rejected hunks.
> For example, here the line to be deleted is nowhere to be found:
> 
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 714ba4d..c2f22c9 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -497,7 +497,7 @@ static int acpi_irq_get_penalty(int irq)
>>  	int penalty = 0;
>> 
>>  	if (irq < ACPI_MAX_ISA_IRQS)
>> -		penalty += acpi_isa_irq_penalty[irq];
>> +		return acpi_isa_irq_penalty[irq];
>> 
>>  	/*
>>  	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
> 
> 
> Regards, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----

Please apply the patches on top of clean 4.7-rc4 tree and apply them in 
order with

git am 0001...
git am 0002...
