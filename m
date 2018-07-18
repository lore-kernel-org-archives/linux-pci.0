Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Date: Wed, 18 Jul 2018 21:00:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
    Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de> <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de> <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Paul,

On Wed, 18 Jul 2018, Paul Menzel wrote:
> On 07/18/18 17:39, Thomas Gleixner wrote:
> > Bah. Could you please enable GENERIC_IRQ_DEBUGFS and after a successful
> > boot up provide me the content of all files in /sys/kernel/debug/irq/ and
> > its subfolders?
> 
> Sure, please find them attached. `7zr x sys-kernel-debug-irq.7z` should
> extract it.

It generates the files, but they are all size '1' and contain nothing.

Thanks,

	tglx
