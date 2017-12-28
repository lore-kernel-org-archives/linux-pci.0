Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1Vye (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 16:54:34 -0500
Date: Thu, 28 Dec 2017 22:54:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
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
In-Reply-To: <alpine.DEB.2.20.1712281930590.1899@nanos>
Message-ID: <alpine.DEB.2.20.1712282253180.1899@nanos>
References: <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com> <20171220131929.GC24638@arch-chirva.localdomain> <alpine.DEB.2.20.1712281145510.1688@nanos> <20171228142117.GA10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281531120.1899@nanos>
 <20171228154835.GB10658@chirva-slack.chirva-slack> <20171228160522.GC10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281706010.1899@nanos> <20171228172250.GD10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281823140.1899@nanos>
 <20171228175009.ucxr4to2nb42e3s4@D-69-91-141-110.dhcp4.washington.edu> <alpine.DEB.2.20.1712281930590.1899@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Dec 2017, Thomas Gleixner wrote:
> On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> 
> > No; it seems to be tied to this specific issue, and I was seeing even
> > before getting logs just now, whenever I'd start one of the bad
> > kernels in recovery mode.
> > 
> > But no, I've never seen that in any other logs, or on any other
> > screens outside of those popping up in relation to this problem.
> 
> Ok. I'll dig into it and we have a 100% reproducer reported by someone else
> now, which might give us simpler insight into that issue. I'll let you know
> once I have something to test. Might be a couple of days though.

Can you please provide the output of

    lspci -vvv

from a working kernel, preferrably 4.14.y

Thanks,

	tglx
