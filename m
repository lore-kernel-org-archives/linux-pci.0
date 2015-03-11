Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35127 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbCKCQk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 22:16:40 -0400
Received: by qgfh3 with SMTP id h3so6885658qgf.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 19:16:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t_14e1TzVZpFxq7pwTKJFN7cdXXqVd64_3e2iknUMG1kw@mail.gmail.com>
References: <CAH9N0t_14e1TzVZpFxq7pwTKJFN7cdXXqVd64_3e2iknUMG1kw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Mar 2015 21:16:19 -0500
Message-ID: <CAErSpo5LFrGjmzTQFYLsWMRhg3G2KpDQMJK-qe0VVqm9y=oTLQ@mail.gmail.com>
Subject: Re: MRL Sensor or Attention Button event and hotplug scripts
To: Paulo Fortuna Carvalho <pricardofc@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg, Ludwig (participants in previous conversation)]

On Fri, Mar 6, 2015 at 6:00 AM, Paulo Fortuna Carvalho
<pricardofc@gmail.com> wrote:
> Good morning,
> I have an ATCA systema with a PCIe endpoint card.
> I need to stop applications from running everytime i remove the PCIe
> endpoint before remove event occurs.

That would be convenient, but a more robust design would be to make
the applications able to deal with unexpected device removal.  Then
the apps could still work even with devices in different form factors
like ExpressCard, where you don't get any warning about a device being
removed.

> For that task I have 2 hot-add events a MRL Sensor event and the
> PRESENCE OFF event.
> At the moment with the hotplug scripts (.rules files) I can configure
> the behaviour of remove procedure using the "remove" tag. I dont know
> if there is  the possibility to use the same script (and which tag)
> for the MRL Sensor event.
> In addiction, is it better to use the MRL Sensor event or the
> Attention Button for this purpose?

As far as I can tell, pciehp currently doesn't do much with MRL Sensor
events.  Starting with PCI_EXP_SLTSTA_MRLSS, it looks like
pciehp_handle_switch_change() will queue an INT_SWITCH_OPEN or
INT_SWITCH_CLOSE close event, but interrupt_event_handler() ignores
those events.

It seems possible that we could treat MRL sensor "switch open" and
button press events as a "request to remove device" signal and expose
that to user-space via udev.  But we'd have to think about whether
that really makes sense and what the implications would be, e.g., how
to handle subsequent "switch close" or button press events.  And you
might want some sort of signal from user-space back into the kernel to
say "yes, it's OK to remove the device."  That sounds like more of an
issue because then the kernel is dependent on something in user-space,
and I don't really want to go that direction.

If you want to prototype all this and experiment with it, that would
be a first step to exploring it.  But I would encourage you to focus
on making the applications more resilient if at all possible.

Bjorn
