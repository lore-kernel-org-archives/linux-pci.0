Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbIJUhg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Sep 2015 16:37:36 -0400
Message-ID: <1441917455.20355.624.camel@redhat.com>
Subject: Re: reg: difference in pcie behavior in fedora16 vs fedora20
From: Alex Williamson <alex.williamson@redhat.com>
To: zubin kumar <zubinkumar@gmail.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 10 Sep 2015 14:37:35 -0600
In-Reply-To: <CAHX5tOGkZ+ZtDymyViYrvEi+LdRbYzHU_mOa4uZK_t58G7KcqQ@mail.gmail.com>
References: <CAHX5tOGkZ+ZtDymyViYrvEi+LdRbYzHU_mOa4uZK_t58G7KcqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-09-10 at 12:55 -0700, zubin kumar wrote:
> hi,
> 
> i had some queries regarding pcie behavior in fedora16 vs fedora20.
> 
> observation on fedora16 -
> when i connect a pcie device in slot#3 with fedora16, the pcie device
> comes up properly. i am able to see the pcie device ID, class code and
> all the memory bars.
> 
> observation on fedora20 -
> however when i connect the same device to a fedora20 system, the
> machine itself does not boot. and the motherboard keeps sending out
> the fundamental reset. then it keeps looping in a reset-bootup
> sequence.
> 
> fedora16 kernel - 3.6.11 fc16 x86x64 arch
> fedora20 kernel - 3.11.10-4 fc20 x86x64 arch
> 
> queries -
> 1) i was wondering if pcie enumeration is effected by OS or is it
> controlled directly by motherboard and OS settings/kernel etc. dont
> impact PCIe enum at all?
> 2) what could be the differences between fedora16 Vs fedora20 that
> could cause the pc to boot properly in fedora16 but go into a
> reset-boot loop in fedora20?
> 3) any log file i can check to see what might be causing the issue on the host?
> 4) my pcie device enumerates as an memory device. could this impact
> the fedora16 / fedora20 differently?
> 
> additional observation -
> i have tried other pcie slots on both fedora16 and fedora20 machines.
> either machines are not able to even detect the pcie device if i use
> any slot other than slot#3. i checked the BIOS settings and all the
> pcie slots are enabled.
> 
> if anyone can give some insight into what could be causing the
> difference in behavior in pcie enum in fedora16 vs fedora20, that
> would be great.
> 
> thanks in advance ...

Hi Zubin,

The problem description seems to already presume that the fault is at
the kernel, but it's not even clear to me from the description whether
the F16 vs F20 tests are different kernels on different systems or
different kernels on the same system.  If these are different systems,
an obvious test would be to try F16 on the system with the reset-boot
loop issue.

When you see a reset-boot loop, does it occur during BIOS initialization
or after the kernel has started booting?  If the latter, can you capture
any of the kernel log via serial console?  The fact that the card isn't
even visible in other slots in the "working" system certainly raises
concerns whether the card is actually a generic PCIe device or somehow
specific to that platform.  Obviously knowing the card and something
about the system is potentially useful, otherwise slot#3 doesn't mean
much.  Thanks,

Alex

