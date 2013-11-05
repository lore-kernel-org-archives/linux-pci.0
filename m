Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46664 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3KES4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 13:56:18 -0500
Received: by mail-ie0-f177.google.com with SMTP id e14so15697356iej.36
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2013 10:56:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131102155054.GD23938@kroah.com>
References: <20131029214631.GA19354@kroah.com> <CAErSpo5YpE-aoTbXd5=0xBDe+_aQPEO4PejrG=+JoEM=w2ZxQw@mail.gmail.com>
 <20131102155054.GD23938@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 5 Nov 2013 11:55:57 -0700
Message-ID: <CAErSpo5DD_H8_auWZ9QAVPLk85=Zcviv3RjeEWmHQkHPnFPCzA@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI: export MSI mode using attributes, not kobjects
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Veaceslav Falico <vfalico@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Knut Petersen <Knut_Petersen@t-online.de>,
	Ingo Molnar <mingo@kernel.org>,
	Paul McKenney <paulmck@linux.vnet.ibm.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Neil Horman <nhorman@tuxdriver.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 2, 2013 at 9:50 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Nov 01, 2013 at 05:40:02PM -0600, Bjorn Helgaas wrote:
>> On Tue, Oct 29, 2013 at 3:46 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > The PCI MSI sysfs code is a mess with kobjects for things that don't
>> > really need to be kobjects.  This patch creates attributes dynamically
>> > for the MSI interrupts instead of using kobjects.
>> >
>> > Note, this does not delete the existing sysfs MSI code, but puts the
>> > attributes under a "msi_irqs_2" directory for testing / example.
>> >
>> > Also note, this removes a directory from the current MSI interrupt sysfs
>> > code:
>> >
>> > old MSI kobjects:
>> > pci_device
>> >    └── msi_irqs
>> >        └── 40
>> >            └── mode
>> >
>> > new MSI attributes:
>> > pci_device
>> >    └── msi_irqs_2
>> >        └── 40
>> >
>> > As there was only one file "mode" with the kobject model, the interrupt
>> > number is now a file that returns the "mode" of the interrupt (msi vs.
>> > msix).
>> >
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >
>> > Bjorn, I can make up a patch that rips out the existing kobject code
>> > here, but I figured this patch would make things easier to follow
>> > instead of having to dig through the removed logic at the same time.
>> >
>> > I'll clean up the error handling path for the create attribute logic as
>> > well, this was just a proof of concept that this could be done.
>> >
>> > Do you think that anyone cares about the current mode files in sysfs to
>> > move things in this manner?
>>
>> I like this a lot better than trying to fix all the holes in the
>> current kobject code.
>
> Great.
>
>> I have no idea who, if anybody, cares about the "mode" files.  I
>> assume there's a way to create the "mode" files with attributes, too?
>> If so, we could replicate the existing structure with one patch, and
>> simplify it with a second patch, so it would be easier to revert the
>> directory change while keeping the fix.
>
> No, we can't create a 2-level deep attribute at the moment, only one
> level, like the patch does.
>
> Based on Neil's comments, I think we should be fine with this as-is as
> no one is messing with these files directly (which implies that we could
> possibly just remove them entirely to save us the overall pain...)

Hmmm.  https://bugzilla.redhat.com/show_bug.cgi?id=744012 suggests
that irqbalance might be reading these files.

> Want me to redo this in a way that is acceptable (i.e. remove the
> existing code at the same time?)
