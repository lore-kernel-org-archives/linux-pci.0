Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:64248 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbaGHUrY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 16:47:24 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so5442976qgd.5
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2014 13:47:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1404833913010.27399@galilsoft.com>
References: <1404833913010.27399@galilsoft.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Jul 2014 14:47:03 -0600
Message-ID: <CAErSpo5p6qEL3=tcWTYMCQCF08oanc3KTUAOdY9P6=5rxZYNZg@mail.gmail.com>
Subject: Re: A question about PCI suspend-resume functionallity
To: Igor Bezukh <Igor@galilsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pm]

On Tue, Jul 8, 2014 at 9:39 AM, Igor Bezukh <Igor@galilsoft.com> wrote:
> Hi,
>
>
> We are testing Intel Gigabit adapter driver (igb) under Fedora 20, kernel 3.14.4 for the following use-case:
>
> (*) Adapter is connected to the PCIE slot
> (*) We put the system under suspend by running pm-suspend from user-space
> (*) Remove the adapter from the PCIE slot
> (*) Wake up the system
>
> Currenlty, we got kernel panics and the system got stuck.
>
> My question is - does the PCI subsystem logic calls the driver remove function when driver resume function returns with error code?
>
> Or should I implement the call to igb_remove from igb_resume in the Intel driver?

I don't know what the best design is here.  I suspect that when we
resume, we should re-enumerate the PCI topology to see if anything
changed, but I don't think we do that.  I think there *is* something
like that for ACPI -- the BIOS can send a Bus Check notification on
resume if it knows something has changed.  But my guess is that if you
remove an adapter below a switch that is powered down because the
system is suspended, the interrupt we would normally get is lost
forever.

It doesn't seem like something that should be solved in the driver,
because you could just as easily have *added* a device while
suspended, and the core has to re-enumerate to find that.

Bjorn
