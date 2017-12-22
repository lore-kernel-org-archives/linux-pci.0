Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18846 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757106AbdLVK2u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Dec 2017 05:28:50 -0500
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
To: Alexandru Chirvasitu <achirvasub@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devel@linuxdriverproject.org>, KY Srinivasan <kys@microsoft.com>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
Date: Fri, 22 Dec 2017 18:28:41 +0800
MIME-Version: 1.0
In-Reply-To: <20171221022356.GE24638@arch-chirva.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alexandru,

At 12/21/2017 10:23 AM, Alexandru Chirvasitu wrote:
> This might be more helpful. I ran another bisect with the following
> final log:
> 
> ---
> 
> git bisect start
> # bad: [d6ffc6ac83b1f9f12652d89b9cb5bcbfbea7796c] x86/vector: Respect affinity mask in irq descriptor
> git bisect bad d6ffc6ac83b1f9f12652d89b9cb5bcbfbea7796c
> # good: [e4ae4c8ea7c65f61fde29c689d148c8c9e05305a] Merge branch 'irq/core' into x86/apic
> git bisect good e4ae4c8ea7c65f61fde29c689d148c8c9e05305a
> # good: [4ef76eb6de734dc03a7f3b8f80884362364e6049] x86/apic: Get rid of the legacy irq data storage
> git bisect good 4ef76eb6de734dc03a7f3b8f80884362364e6049
> # good: [ba801640b10d87b1c4e26cbcbe414a001255404f] x86/vector: Compile SMP only code conditionally
> git bisect good ba801640b10d87b1c4e26cbcbe414a001255404f
> # good: [90ad9e2d91067983f3328e21b306323877e5f48a] x86/io_apic: Reevaluate vector configuration on activate()
> git bisect good 90ad9e2d91067983f3328e21b306323877e5f48a
> # bad: [4900be83602b6be07366d3e69f756c1959f4169a] x86/vector/msi: Switch to global reservation mode
> git bisect bad 4900be83602b6be07366d3e69f756c1959f4169a
> # bad: [2db1f959d9dc16035f2eb44ed5fdb2789b754d6a] x86/vector: Handle managed interrupts proper
> git bisect bad 2db1f959d9dc16035f2eb44ed5fdb2789b754d6a
> # first bad commit: [2db1f959d9dc16035f2eb44ed5fdb2789b754d6a] x86/vector: Handle managed interrupts proper

It's helpful to me. I tried it in QEmu with

   (Intel(R) Core(TM)2 Duo CPU  T7700  @ 2.40GHz)
but, can't reproduced the bug.

> 
> ---
> 
> That first bad commit 2db1f95 identified at the end is interesting:
> it's the only one I've tried through all of this that actually gives
> me a kernel panic when unadorned with kernel options (so unlike all of
> the others it fails to even drop me at a tty login prompt).
> 
> I tried a number of things to fiddle with it: it boots fine with
> either nolapic or noapic. The former results in seeing a single cpu
> with lscpu, but the latter (noapic) seems to give me as much
> functionality as I'd need. I'm not seeing the issue noted before,

Because the "noapic" just disable the I/O APIC, but, the "nolapic" will
disable both the Local APIC and I/O APIC

> whereby noapic for 4.15.0-rc3 was somehow disabling my ethernet card.
> 
> I hope this second bisect went down better than the last one..

Could you add "apic=debug" in the kernel command line, then, give me the 
dmesg log?

Thanks,
	dou.
