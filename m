Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
To: wim@djo.tudelft.nl
References: <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl> <576BF86E.8060302@codeaurora.org>
 <576C042B.20507@codeaurora.org> <20160623232533.GA14984@djo.tudelft.nl>
 <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
 <20160625013920.GA26737@djo.tudelft.nl>
 <3bf1261bc7a931cb5e1e93ea0d66b265@codeaurora.org>
 <20160627062724.GA6713@djo.tudelft.nl>
 <9ad14db03ecb39a098d588b25c7b54a0@codeaurora.org>
 <20160627130417.GA8184@djo.tudelft.nl>
 <a8b7406eb12fc43246af4d78fc7e2278@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8602f0b7-e052-913f-d633-294dff6cd3b2@codeaurora.org>
Date: Wed, 29 Jun 2016 04:34:14 -0400
MIME-Version: 1.0
In-Reply-To: <a8b7406eb12fc43246af4d78fc7e2278@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 6/27/2016 5:05 PM, okaya@codeaurora.org wrote:
> On 2016-06-27 16:04, Wim Osterholt wrote:
>> On Mon, Jun 27, 2016 at 04:22:18AM -0400, okaya@codeaurora.org wrote:
>>> > However, an earlier try on my Inspiron 510m did not work.
>>> > I'll do a clean retry later today, just to make sure.
>>>
>>>
>>> Ok, let me know. I can post a clean patch series. I was trying to get
>>> you something to test before posting the official version.
>>
>> The 510m just finished compiling and now it works fine too.
>> Thanks.
>>
> 
> Nice, I will post the official version and let you know.
> 

I posted this [PATCH V2 0/4] ACPI,PCI,IRQ: correct ISA penalty calculation

Can you test this and give me a tested-by?

Alex,
If you could also review this, it would be great.

Sinan

>>
>>
>> Regards, Wim.
>>
>>
>> ----- wim@djo.tudelft.nl -----
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
