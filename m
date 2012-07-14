Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:39556 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2GNNJR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jul 2012 09:09:17 -0400
Date: Sat, 14 Jul 2012 15:09:11 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
To: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 43247] O2 micro SD/MMC+1394 controller: 1394 device can't
 work (Register access failure)
Message-ID: <20120714150911.666409bf@stein>
In-Reply-To: <20120710110216.83BDF11FA14@bugzilla.kernel.org>
References: <bug-43247-52301@https.bugzilla.kernel.org/>
	<20120710110216.83BDF11FA14@bugzilla.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Jul 10 bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=43247
> 
> --- Comment #19 from jennifer <jennifer.li@o2micro.com>  2012-07-10 11:02:16 ---
[...]
> > Do you mean by that that
> > the original Linux driver works for you if you boot Linux but do not let
> > the driver be automatically loaded during boot, but instead load the driver
> > later by 'modprobe firewire-ohci' after the rest of the system has finished
> > booting up?
> 
> Yes.
> 
> > 
> > And if yes, did you also need to load the sdhci-pci driver manually this
> > way?  
> 
> There are 4 ways which can pass the issue.
> 1. Load 1394 by OS + Load sdhci-pci by manually.
> 2. Load sdhci-pci by OS + Load 1394 by manually.
> 3. Load 1394 by manually + load sdhci-pci by manually.
> 4. Load sdhci-pci by manually + load 1394 by manually.
> 
> > And further, does it matter whether sdhci-pci is loaded before
> > firewire-ohci or the other way around?
> 
> According to our test result, if we load the driver by manually and the issue
> will disappear. It didn't has the relationship about the loaded priority.
> But, if we load those drivers by OS and the issue will happen.


Could somebody at linux-pci@vger.kernel.org please advise?

1.)  Is there a kernel parameter which Jennifer could try in order to
force serialized PCI driver probing?

2.)  If there is one and if this turns out to cure the issue in testing:
How can I implement serialization between the O2Micro FireWire .probe()
and .resume() on one hand and the O2Micro SDHCI .probe() and .resume() on
the other hand?


[If you reply to this via bugzilla mail, please add
    Cc: linux-pci@vger.kernel.org
in your reply.  I am not aware of a way to add it to bugzilla.kernel.org's
Cc list of bug 43247.]
-- 
Stefan Richter
-=====-===-- -=== -===-
http://arcgraph.de/sr/
