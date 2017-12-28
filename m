Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46776 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdL1X7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 18:59:12 -0500
Date: Thu, 28 Dec 2017 18:59:09 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171228235909.iz2pevxo4vnczu54@D-69-91-141-110.dhcp4.washington.edu>
References: <20171228172250.GD10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281823140.1899@nanos>
 <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712281930590.1899@nanos>
 <alpine.DEB.2.20.1712282253180.1899@nanos>
 <20171228225014.GE10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712282357380.1899@nanos>
 <alpine.DEB.2.20.1712290018210.1899@nanos>
 <20171228233058.c76a4upqbx6elmvg@D-69-91-141-110.dhcp4.washington.edu>
 <alpine.DEB.2.20.1712290034420.1899@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1712290034420.1899@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 12:36:37AM +0100, Thomas Gleixner wrote:
> On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> 
> > Attached, but heads up on this: when redirecting the output of lspci
> > -vvv to a text file as root I get
> > 
> > pcilib: sysfs_read_vpd: read failed: Input/output error
> > 
> > I can find bugs filed for various distros to this same effect, but
> > haven't tracked down any explanations.
> 
> Weird, but the info looks complete.
> 
> Can you please add 'pci=nomsi' to the 4.15 kernel command line and see
> whether that works?

It does (emailing from that successful boot as we speak). I'm on a
clean 4.15-rc5 (as in no patches, etc.). 

This was also suggested way at the top of this thread by Dexuan Cui
for 4.15-rc3 (where this exchange started), and it worked back then
too.

> 
> Thanks,
> 
> 	tglx
