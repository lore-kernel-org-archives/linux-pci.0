Return-Path: <SRS0=yV40=KD=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=yV40=KD=linutronix.de=tglx@kernel.org>
Date: Thu, 19 Jul 2018 15:48:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
    Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <ed32c159-1629-68e5-26e2-b1770a43acc3@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807191541130.1602@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de> <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
 <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de> <178bb701-56af-06cf-4836-1a26e74f2b07@molgen.mpg.de> <alpine.DEB.2.21.1807182058110.1689@nanos.tec.linutronix.de> <7660f2f2-0c37-a617-ecdc-949cd4ecc060@molgen.mpg.de>
 <ed32c159-1629-68e5-26e2-b1770a43acc3@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Paul,

On Thu, 19 Jul 2018, Paul Menzel wrote:

> I had to copy the files, and then was able to create an archive with
> non-zero files. Please find the tar archive attached.

Thanks for providing the data. All looks normal there.

Just for clarification. Did this happen exactly once, or did it just not
happen again after you plugged in a serial cable?

One thing you might try is to disable irqbalanced when the machine is up
and then stress the affinity setter mechanism with scripting.

Something like

while true; do
 for I in {0..3}; do echo $I > /proc/irq/$IRQ/smp_affinity_list; done
done

might be able to trigger it. But don't ask me which interrupt was involved,
so you have to iterate through the ones which are MSI based.

'cat /proc/interrupt | grep MSI' will tell you.

Thanks,

	tglx
