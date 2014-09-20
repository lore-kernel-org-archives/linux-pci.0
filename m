Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33998 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232AbaITCPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Sep 2014 22:15:34 -0400
Received: by mail-ig0-f171.google.com with SMTP id hn15so127862igb.4
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2014 19:15:34 -0700 (PDT)
Date: Fri, 19 Sep 2014 20:15:30 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Matteo <rootkit85@yahoo.it>
Cc: linux-pci@vger.kernel.org
Subject: Re: [Bug 84821] New: Compex WLE900VX-7A not recognized
Message-ID: <20140920021530.GA2275@google.com>
References: <bug-84821-41252@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bug-84821-41252@https.bugzilla.kernel.org/>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci to make this more searchable]

On Fri, Sep 19, 2014 at 04:08:40PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=84821
> 
>             Bug ID: 84821
>            Summary: Compex WLE900VX-7A not recognized
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.16
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: rootkit85@yahoo.it
>         Regression: No
> 
> I have some mini PCI-express cards that fails to be recognized.
> 
> The card is a Compex WLE900VX-7A
> http://www.compex.com.sg/productdetailinfo.asp?model=WLE900VX
> 
> and it can't be enumerated as PCI device.
> 
> On a Lenovo Thinkpad notebook it can't never be enumerated, on my Samsung
> NP350V5C-S09IT it appears in the devices list only after a reboot (ie. must
> boot, then reboot)
> 
> I'm not sure it's a Linux bug, it could be an hardware bug, but maybe it's
> possible to bring the interface up with some quirk.
> 
> I attach syslog and lspci output of the first and second boot

Based on subsequent testing, it doesn't work with Windows either.  That
makes me think it might be some kind of defect in the card itself.  But it
sounds like maybe it happens with multiple copies of the same card?

I really don't know what to say.  Unless you have some way to attach a PCIe
analyzer and verify that the card is responding and the OS is doing
something wrong, I would probably just return it and get a different card.

Bjorn
