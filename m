Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43706 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab2GCBod (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2012 21:44:33 -0400
Received: by lbbgm6 with SMTP id gm6so8515537lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Jul 2012 18:44:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120628100231.GA21288@mail.eitzenberger.org>
References: <20120628100231.GA21288@mail.eitzenberger.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Jul 2012 19:44:11 -0600
Message-ID: <CAErSpo7x84-r_7fX72+SWdxjZgO+nFc0AGqkKdGaRkbi4doEsQ@mail.gmail.com>
Subject: Re: pciutils: problem identifying PCI devices uniquely
To: linux-pci@vger.kernel.org
Cc: =?ISO-8859-2?Q?Martin_Mare=B9?= <mj@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin, pciutils maintainer]

On Thu, Jun 28, 2012 at 4:02 AM, Holger Eitzenberger
<holger@eitzenberger.org> wrote:
> Hi,
>
> I have a problem identifying PCI devices (NICs in this case) on some
> hardware.
>
> In case the questions I have are too stupid please just ignore this
> email.
>
> While I usually use the bus:device.function to identify the hardware
> this is not possible on some hardware, because the bus numbers are
> changing.  And this is all because the box has 4 slots, and each slot
> can possibly hold one of 3 different types of modules, differing in
> the number of NICs they hold.
>
> I found out that this is a well known problem, which is due to the
> fact that the different modules have a different number of PCI bridges
> on them.  In my case from 2 to 7 PCI bridges per module.
>
> And then I came across the Chassis Capability (id 04).  On first read
> this sounded as it would solve the problem, making the ID unique again
> if configured properly, irrespective of the actual slot module used.
> Has anyone experience with the Chassis Capability?

I think you're referring to the "Slot Identification" capability.  As
far as I can tell, the kernel ignores it.

I don't see spec details about it; the PCI spec v3 says it's fully
documented in the PCI to PCI Bridge spec, but I don't see anything in
the P2P bridge spec v1.2.  But I suppose if pciutils knows how to
decode it, it must be documented *somewhere*.

> In my understanding the Chassis Capability is transparent to the OS,
> the devices can still be identified by bus:device.function, correct?

Yes.  The kernel uses segment/bus/device/function to identify a PCI device.

I'm not sure exactly what your objective is, but maybe this is
related: https://fedoraproject.org/wiki/Features/ConsistentNetworkDeviceNaming

> According to the lspci source it should show something like:
>
>   Capabilities: [04] Slot ID: 8 slots, First1, chassis 42
>
> I was unable to find some sample lspci output when googling, a sample
> output would be helpfull as well.
>
> What I found helpfull, without the Chassis Capability, was a small tool
> I wrote (derived from pciutils/examle.c), which is able to identify
> the devices with a "path walk" from the PCI Root Port to the actual
> device.  So e. g. when specifying:
>
>  ./example -s '/00:02.0/:05.0/:01.1/:05.1'
>
> In this case '00:02.0' is the Root Port, the other device except the
> last are PCI bridges, specified with a wildcard for the bus number.
>
> Would this be a feature of interest for pciutils in general?
>
> Thanks!
>
>  /Holger
