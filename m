Return-Path: <SRS0=Qgrw=CH=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=Qgrw=CH=mobiveil.co.in=l.subrahmanya@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171108172349.GC28427@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx2mc6bjJkXbjOeKqwJhFSicu3fXYSMgL8ET-mnuEvB2rQ@mail.gmail.com>
 <20171108172349.GC28427@bhelgaas-glaptop.roam.corp.google.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 18:34:08 +0530
Message-ID: <CAFZiPx061E0MuucnTw-6uJ-+YP739Cdi2+jkLkDh+nJomGfwtA@mail.gmail.com>
Subject: Re: [Patch] PCIe: Add Mobiveil PCIe Host Bridge IP driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Bjorn,
I went through all the links, prepared the patches and resubmitted
with v2  version.
This driver follows xilinx Root port driver architecture in same folder.


Thanks,

On Wed, Nov 8, 2017 at 10:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Nov 08, 2017 at 09:42:29PM +0530, subrahmanya l wrote:
>> This is the driver for Mobiveil  AXI PCIe Host Bridge Soft IP
>>
>> --
>> Mobiveil INC., CONFIDENTIALITY NOTICE: This e-mail message, including any
>> attachments, is for the sole use of the intended recipient(s) and may
>> contain proprietary confidential or privileged information or otherwise be
>> protected by law. Any unauthorized review, use, disclosure or distribution
>> is prohibited. If you are not the intended recipient, please notify the
>> sender and destroy all copies and the original message.
>
> I can't do anything with email marked "confidential".
>
> Also, please review these hints for posting patches:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst
> https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
>
> Please include your patch inline (not as an attachment).  Patchwork
> (https://patchwork.ozlabs.org/project/linux-pci/list/), the system I
> use to track patches, doesn't pick up attachments, so they tend to get
> lost.
>
> Please look at the other drivers in drivers/pci/host/ and make yours
> look as much as possible like them.  Same coding style, same
> organization, same function naming scheme, etc.
>
> Bjorn
