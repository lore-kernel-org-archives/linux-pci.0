Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:33064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdL1QKg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 11:10:36 -0500
Date: Thu, 28 Dec 2017 17:10:28 +0100 (CET)
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
In-Reply-To: <20171228160522.GC10658@chirva-slack.chirva-slack>
Message-ID: <alpine.DEB.2.20.1712281706010.1899@nanos>
References: <20171218082011.GA24638@arch-chirva.localdomain> <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain> <alpine.DEB.2.20.1712200124440.2282@nanos> <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain> <alpine.DEB.2.20.1712281145510.1688@nanos> <20171228142117.GA10658@chirva-slack.chirva-slack> <alpine.DEB.2.20.1712281531120.1899@nanos> <20171228154835.GB10658@chirva-slack.chirva-slack>
 <20171228160522.GC10658@chirva-slack.chirva-slack>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> Actually, it decided to cooperate for just long enough for me to get
> the dmesg out. Attached.
> 
> This is from the kernel you asked about: Dou's patch + yours, i.e. the
> latest one in that git log I just sent, booted up with 'apic=debug'.

Ok. As I suspected that warning does not trigger. I would have been
massively surprised if that happened. So Dou's patch is just a red herring
and just might change the timing enough to make the problem 'hide'.

Can you try something completely different please?

Just use plain Linus tree without any additional patches on top and disable
CONFIG_NO_HZ_IDLE, i.e. select CONFIG_HZ_PERIODIC.

If that works, then reenable it and add 'nohz=off' to the kernel command
line.

Thanks,

	tglx
