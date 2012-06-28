Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51585 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932777Ab2F1KCg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jun 2012 06:02:36 -0400
Received: from holger by kruemel.eitzenberger.org with local (Exim 4.69)
	(envelope-from <holger@eitzenberger.org>)
	id 1SkBYV-00005Q-L2
	for linux-pci@vger.kernel.org; Thu, 28 Jun 2012 12:02:31 +0200
Date: Thu, 28 Jun 2012 12:02:31 +0200
From: Holger Eitzenberger <holger@eitzenberger.org>
To: linux-pci@vger.kernel.org
Subject: pciutils: problem identifying PCI devices uniquely
Message-ID: <20120628100231.GA21288@mail.eitzenberger.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I have a problem identifying PCI devices (NICs in this case) on some
hardware.

In case the questions I have are too stupid please just ignore this
email.

While I usually use the bus:device.function to identify the hardware
this is not possible on some hardware, because the bus numbers are
changing.  And this is all because the box has 4 slots, and each slot
can possibly hold one of 3 different types of modules, differing in
the number of NICs they hold.

I found out that this is a well known problem, which is due to the
fact that the different modules have a different number of PCI bridges
on them.  In my case from 2 to 7 PCI bridges per module.

And then I came across the Chassis Capability (id 04).  On first read
this sounded as it would solve the problem, making the ID unique again
if configured properly, irrespective of the actual slot module used.
Has anyone experience with the Chassis Capability?

In my understanding the Chassis Capability is transparent to the OS,
the devices can still be identified by bus:device.function, correct?

According to the lspci source it should show something like:

  Capabilities: [04] Slot ID: 8 slots, First1, chassis 42

I was unable to find some sample lspci output when googling, a sample
output would be helpfull as well.

What I found helpfull, without the Chassis Capability, was a small tool
I wrote (derived from pciutils/examle.c), which is able to identify
the devices with a "path walk" from the PCI Root Port to the actual
device.  So e. g. when specifying:

 ./example -s '/00:02.0/:05.0/:01.1/:05.1'

In this case '00:02.0' is the Root Port, the other device except the
last are PCI bridges, specified with a wildcard for the bus number.

Would this be a feature of interest for pciutils in general?

Thanks!

 /Holger

