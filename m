Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 27 Jun 2016 04:22:18 -0400
From: okaya@codeaurora.org
To: wim@djo.tudelft.nl
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
In-Reply-To: <20160627062724.GA6713@djo.tudelft.nl>
References: <576943BA.1000001@codeaurora.org>
 <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl> <576BF86E.8060302@codeaurora.org>
 <576C042B.20507@codeaurora.org> <20160623232533.GA14984@djo.tudelft.nl>
 <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
 <20160625013920.GA26737@djo.tudelft.nl>
 <3bf1261bc7a931cb5e1e93ea0d66b265@codeaurora.org>
 <20160627062724.GA6713@djo.tudelft.nl>
Message-ID: <9ad14db03ecb39a098d588b25c7b54a0@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2016-06-27 02:27, Wim Osterholt wrote:
> On Sat, Jun 25, 2016 at 04:51:03AM -0400, okaya@codeaurora.org wrote:
>> On 2016-06-24 21:39, Wim Osterholt wrote:
>> 
>> Please apply the patches on top of clean 4.7-rc4 tree and apply them 
>> in
>> order with
>> 
>> git am 0001...
>> git am 0002...
> 
> It doesn't work that way.
> Beginners problems with git.
> Tried all kinds of things, including a new git clone to no avail.
> Took a long time to discover that in the above example these were the 
> names
> of the 'attachments'.
> It didn't work. Error 'could not find out the kind of patch' or some 
> such.
> Took much longer to find out that in that mail and in the saved 
> attachments
> there were lines beginning with '>From' that were the culprit.
> 
> Still not found out how to make patch work without errors.
> Anyway, by doing it with more manual intervention om a stock 
> kernel-4.7-rc4
> on my (very slow) Inspiron 4100 it seems to work like before. Hooray.
> However, an earlier try on my Inspiron 510m did not work.
> I'll do a clean retry later today, just to make sure.


Ok, let me know. I can post a clean patch series. I was trying to get 
you something to test before posting the official version.

> 
> regards, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
