Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37319 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab3HWUkb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 16:40:31 -0400
Received: by mail-ie0-f170.google.com with SMTP id 17so1696329iea.29
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2013 13:40:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5217C794.1020902@kraav.com>
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/>
 <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com>
 <5217BDF2.4020909@kraav.com> <CAErSpo5B6dvY6ri1-NajudgS1v1tyTCCicb9vMrOYP=8yv4pPg@mail.gmail.com>
 <5217C794.1020902@kraav.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 Aug 2013 14:40:10 -0600
Message-ID: <CAErSpo5j-_JWinFSDSJx6uGnw-opEHm668Md=9z-ZoxZmuX+VQ@mail.gmail.com>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized by acpiphp
To: Leho Kraav <leho@kraav.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Fri, Aug 23, 2013 at 2:35 PM, Leho Kraav <leho@kraav.com> wrote:
>>
>> I don't know anything about the LID notifications.
>>
>> As far as the bus checks on \_SB_.PCI0, I think that message is new or
>> possibly we register for those notifications on more devices that we
>> previously did.  If your laptop suspended when closing the lid, it
>> doesn't surprise me that we get the Bus Check on resume, because that
>> might be the only way we could discover device additions or removals
>> that happened while suspended.  I'm not sure why we would get them on
>> suspend.
>
>
> I don't suspend on lid close, actually. I close the lid just to carry the
> laptop around, and always suspend manually.
>
> Thanks for taking a look. I guess the key takeaway here is that the notify
> message is harmless and I should look at somewhere else to figure out why
> I'm not getting a LID event.

Huh.  That's strange.  I don't know why you would get bus checks on
lid open/close events when you're not suspending/resuming.  Maybe
Rafael will have some ideas.

If you can collect an acpidump, that might have a clue, too.  At
least, we ought to be able to see a method that is sending the Notify
to the PCI host bridge.

Bjorn
