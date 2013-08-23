Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out.neti.ee ([194.126.106.72]:59502 "EHLO smtp-out.neti.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab3HWUfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Aug 2013 16:35:38 -0400
Message-ID: <5217C794.1020902@kraav.com>
Date: Fri, 23 Aug 2013 23:35:32 +0300
From: Leho Kraav <leho@kraav.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [Bug 57961] ExpressCard hot-remove and hot-add not recognized
 by acpiphp
References: <bug-57961-41252@https.bugzilla.kernel.org/> <bug-57961-41252-X2PJk78p44@https.bugzilla.kernel.org/> <CAErSpo4jFGdW-OXf2OrUQw-e8EdE5h6fPs-v9=QQh1xPjz-Nvg@mail.gmail.com> <5217BDF2.4020909@kraav.com> <CAErSpo5B6dvY6ri1-NajudgS1v1tyTCCicb9vMrOYP=8yv4pPg@mail.gmail.com>
In-Reply-To: <CAErSpo5B6dvY6ri1-NajudgS1v1tyTCCicb9vMrOYP=8yv4pPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
> I don't know anything about the LID notifications.
>
> As far as the bus checks on \_SB_.PCI0, I think that message is new or
> possibly we register for those notifications on more devices that we
> previously did.  If your laptop suspended when closing the lid, it
> doesn't surprise me that we get the Bus Check on resume, because that
> might be the only way we could discover device additions or removals
> that happened while suspended.  I'm not sure why we would get them on
> suspend.

I don't suspend on lid close, actually. I close the lid just to carry 
the laptop around, and always suspend manually.

Thanks for taking a look. I guess the key takeaway here is that the 
notify message is harmless and I should look at somewhere else to figure 
out why I'm not getting a LID event.
