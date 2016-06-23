Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 22 Jun 2016 23:54:39 -0400
From: okaya@codeaurora.org
To: wim@djo.tudelft.nl
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
In-Reply-To: <20160621221347.GA28603@djo.tudelft.nl>
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan> <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org> <20160621124715.GB3528@djo.tudelft.nl>
 <576943BA.1000001@codeaurora.org> <20160621221347.GA28603@djo.tudelft.nl>
Message-ID: <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2016-06-21 18:13, Wim Osterholt wrote:
> On Tue, Jun 21, 2016 at 09:40:10AM -0400, Sinan Kaya wrote:
>> 
>> Thanks, It was a guess with no proof.
>> 
>> Let's undo the change above and start adding some print statements to 
>> collect
>> data from your system.
>> 
>> Can you add this to the end of acpi_irq_get_penalty function and then 
>> send
>> the output?
>> 
>> 	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
>> 		penalty);
>> 
> 
> This produced some 60 lines extra. Too much to include here.
> The entire dmesg file is here:
> http://webserver.djo.tudelft.nl/dmesg474+printpenalty

Thanks, let's go back to 4.6 and add a very similar printf to every 
single place where the array is modified and also right before the 
enabled message.

I am trying to find a system with similar characteristics for debug



> 
> 
> Regards, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
