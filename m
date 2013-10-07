Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33126 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab3JGWwH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 18:52:07 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so16743535ieb.26
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 15:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131007224006.GA27499@obsidianresearch.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com> <20131007224006.GA27499@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Oct 2013 16:51:44 -0600
Message-ID: <CAErSpo6_bVKbBKXix0qCQObrAGf-pUgXYXBZ=5ykX2QsEECQ5A@mail.gmail.com>
Subject: Re: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link is
 up to enable hot plug
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Seungwon Jeon <tgih.jun@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 7, 2013 at 4:40 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Oct 07, 2013 at 04:28:52PM -0600, Bjorn Helgaas wrote:
>> [+cc Seungwon]
>>
>> On Tue, Oct 1, 2013 at 11:58 AM, Jason Gunthorpe
>> <jgunthorpe@obsidianresearch.com> wrote:
>> > Otherwise hotplugging the PEX doesn't work at all since the driver
>> > detects the link state at probe time. Simply replacing the two tests
>> > of haslink with a register read is enough to fix it.
>> >
>> > Tested on kirkwood with repeated plug/unplug of the link partner.
>> >
>> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>
>> Last I heard (Sep 26), you had some mvebu changes in your tree
>> already, Jason, so I was assuming you'd handle pci-mvebu.c changes, at
>> least for the v3.13 merge window.  But you marked this "resend"; does
>> that mean you're waiting for me to do something with it?
>
> Are you thinking of Jason C.? He is handling much of the mvebu stuff.

Oops, sorry, yep, indeed I meant Jason C.  Sorry about confusing you guys :)

> Hopefully Jason C. can clarify which route these patches should take
> to hit the 3.13 merge window.
>
> This was reposted at the request of Thomas, IIRC.
>
>>   PCI: mvebu - Support a bridge with no IO port window
>
> This one is broken, I have yet to fix it still.
>
>>   PCI: mvebu: add I/O access wrappers
>
> This isn't one of mine ..

That's Seungwon's.  I just wanted to collect all the mvebu patches
from the PCI patchwork.

Bjorn
