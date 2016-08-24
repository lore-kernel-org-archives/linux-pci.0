Return-Path: <tglx@linutronix.de>
Return-Path: <tglx@linutronix.de>
Date: Wed, 24 Aug 2016 10:39:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
    Jan Kiszka <jan.kiszka@siemens.com>,
    Benedikt Spranger <b.spranger@linutronix.de>,
    Lukas Wunner <lukas@wunner.de>
Subject: Re: x86/PCI: Scan all functions during probing
In-Reply-To: <20160818203348.GK27353@localhost>
Message-ID: <alpine.DEB.2.20.1608241037510.5714@nanos>
References: <alpine.DEB.2.20.1608091318530.5388@nanos> <20160809134452.GA27301@localhost> <20160818203348.GK27353@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 18 Aug 2016, Bjorn Helgaas wrote:
> I looked up the spec: PCI (not PCIe) r3.0, sec 3.2.2.3.4, says:
> 
>   A single-function device may optionally respond to all function
>   numbers as the same function or may ... respond only to function 0
>   and not respond to the other function numbers.
> 
> I'm concerned that a single-function device that responds to all
> function numbers might break with this patch.
> 
>   [multi-function devices] are also required to always implement
>   function 0 in the device.
> 
> Here's the reason we can advance by 8 in the "Go find them" loop.
> 
>   If a single function device is detected (i.e., bit 7 in the Header
>   Type register of function 0 is 0), no more functions for that Device
>   Number will be checked.  If a multi-function device is detected
>   (i.e., bit 7 in the Header Type register of function 0 is 1), then
>   all remaining Function Numbers will be checked.
> 
> This patch does the opposite of what the first sentence recommends.

Fair enough. We'll need to find a way to deal with that in jailhouse then.

Thanks,

	tglx
