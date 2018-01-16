Return-Path: <SRS0=fLq0=EL=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=fLq0=EL=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Tue, 16 Jan 2018 11:21:53 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Marek Behun <marek.behun@nic.cz>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, linux-pci@vger.kernel.org, =?UTF-8?B?R3LDqWdvcnk=?=
 Clement <gregory.clement@free-electrons.com>, Antoine =?UTF-8?B?VMOpbmFy?=
 =?UTF-8?B?dA==?= <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOo?=
 =?UTF-8?B?bA==?= Raynal <miquel.raynal@free-electrons.com>
Subject: Re: pci-aardvark ath9k arm64 issues
Message-ID: <20180116112153.5cd06eb0@windsurf>
In-Reply-To: <20180113002234.0ae646d6@nic.cz>
References: <20180113002234.0ae646d6@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Marek,

Thanks for your bug report!

On Sat, 13 Jan 2018 00:22:34 +0100, Marek Behun wrote:

> we are having a CPU stall issue with ath9k driver on pci-aardvark
> (Marvell Armada 3720 (arm64)).
> 
> The ath9k driver loads correctly and the interface connects and for
> some time it works correctly, but then CPU stalls and kernel dumps
> self-detected stall on CPU.
> 
> I don't know if this is issue with aardvark or whole arm64 (someone had
> a similar problem, see
> https://www.spinics.net/lists/linux-wireless/msg157038.html ), but
> ath10k doesn't have this problem.
> 
> I am attaching the rcu_sched stall detection backtrace (although I
> don't know if contains needed information).
> 
> Can you please point me how to debug/solve this issue?

Could you try to apply the following patches ?

  https://patchwork.ozlabs.org/patch/819586/
  https://patchwork.ozlabs.org/patch/819589/
  https://patchwork.ozlabs.org/patch/819587/
  https://patchwork.ozlabs.org/patch/819592/
  https://patchwork.ozlabs.org/patch/819590/
  https://patchwork.ozlabs.org/patch/819591/
  https://patchwork.ozlabs.org/patch/819588/

And see if it helps? If it does help, could you try with just
https://patchwork.ozlabs.org/patch/819592/ applied ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
