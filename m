Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60839 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1LDK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 06:03:10 -0500
Date: Thu, 28 Dec 2017 12:03:05 +0100 (CET)
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
In-Reply-To: <20171220131929.GC24638@arch-chirva.localdomain>
Message-ID: <alpine.DEB.2.20.1712281201210.1688@nanos>
References: <20171218082011.GA24638@arch-chirva.localdomain> <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain> <alpine.DEB.2.20.1712200124440.2282@nanos> <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 Dec 2017, Alexandru Chirvasitu wrote:
> Merging the contents of another exchange spawned from the original

> > On Wed, Dec 20, 2017 at 02:12:05AM +0000, Dexuan Cui wrote:

> > For Linux VM running on Hyper-V, we did get "spurious APIC interrupt
> > through vector " and a patchset, which included the patch you identifed
> > ("genirq: Add config option for reservation mode"), was made to fix the
> > issue. But since you're using a physical machine rathter than a VM, I
> > suspect it should be a different issue. 

Aaargh! Why was this never reported and where is that magic patchset?

Thanks,

	tglx
