Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:50286 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab3BOQ0e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Feb 2013 11:26:34 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so3776214obc.12
        for <linux-pci@vger.kernel.org>; Fri, 15 Feb 2013 08:26:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130215060635.43f06f71@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6_6bYjo5XX5tzoBfMu5Htgpa__foNCyoCnCNEHocx67Q@mail.gmail.com> <20130215060635.43f06f71@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 15 Feb 2013 09:26:09 -0700
Message-ID: <CAErSpo6KPzXj6cN95YuTZGhq+RLp4vDLddbpz=RDtRBvy_Rujg@mail.gmail.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 14, 2013 at 10:06 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

>> > +       case PCI_PREF_LIMIT_UPPER32:
>> > +               bridge->preflimitupper = value;
>> > +               break;
>>
>> You're relying on a subsequent PCI_COMMAND write to set PCI_COMMAND_IO
>> and/or PCI_COMMAND_MEMORY, and you program the bridge windows at that
>> time.
>
> Correct.
>
>>  It might be a good idea if the PCI core did clear those bits
>> while updating the windows, but I'm not sure we do.  In any case,
>> delaying the update is a difference from a standard P2P bridge that
>> could cause issues later.
>
> When would you want the window assignment to occur? Directly when the
> registers containing the base/limit are being written to? There are
> multiple registers for base/limit, so I'll have to figure out a way to
> validate when the base/limit informations are valid.

For a standard bridge, the window change occurs immediately upon
writing the base/limit, so that would be the best time.

Here's the scenario I have in mind: We have a bridge X leading to
several devices A and B.  Drivers are bound to A and B, and they are
operating.  A hotplug event requires us to expand or shrink one of X's
windows, but the new window is still sufficient to operate A and B.
The question is how we do the window update.  If we turn off
PCI_COMMAND_MEMORY for the update, then we have to coordinate with the
drivers for A and B.  But I think it is possible to do some updates
safely even with the window decoding enabled, without any effect on A
and B, and these are the ones that would cause trouble with your
current scheme.

I don't think the PCI core does any updates like this today, but it's
something we might like to do in the future.

Bjorn
