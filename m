Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 30 Jun 2016 12:43:57 +0300
From: okaya@codeaurora.org
To: wim@djo.tudelft.nl
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
In-Reply-To: <20160630023041.GA5407@djo.tudelft.nl>
References: <576C042B.20507@codeaurora.org>
 <20160623232533.GA14984@djo.tudelft.nl>
 <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
 <20160625013920.GA26737@djo.tudelft.nl>
 <3bf1261bc7a931cb5e1e93ea0d66b265@codeaurora.org>
 <20160627062724.GA6713@djo.tudelft.nl>
 <9ad14db03ecb39a098d588b25c7b54a0@codeaurora.org>
 <20160627130417.GA8184@djo.tudelft.nl>
 <a8b7406eb12fc43246af4d78fc7e2278@codeaurora.org>
 <8602f0b7-e052-913f-d633-294dff6cd3b2@codeaurora.org>
 <20160630023041.GA5407@djo.tudelft.nl>
Message-ID: <f5946f98d202472e9c1b2327e75ffd93@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2016-06-30 05:30, Wim Osterholt wrote:
> On Wed, Jun 29, 2016 at 04:34:14AM -0400, Sinan Kaya wrote:
>> >
>> 
>> I posted this [PATCH V2 0/4] ACPI,PCI,IRQ: correct ISA penalty 
>> calculation
>> 
>> Can you test this and give me a tested-by?
> 
> 
> Kernel-4.7-rc5 plus this patch works like a charm on my Inspiron 4100.
> Dmesg output is quite similar to the one from kernel-4.6 .
> 
> Tested-by: Wim Osterholt. <wim@djo.tudelft.nl>
> 

Thank you.


> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
