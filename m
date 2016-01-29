Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, izumi.taku@jp.fujitsu.com, wency@cn.fujitsu.com,
	caoj.fnst@cn.fujitsu.com, ddaney.cavm@gmail.com,
	okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/1] pci: fix unavailable irq number 255 reported by BIOS
Date: Fri, 29 Jan 2016 04:37:19 +0100
Message-ID: <8924816.km1PStJUTB@vostro.rjw.lan>
In-Reply-To: <20160128205736.GA12965@localhost>
References: <1453944946-18852-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <20160128205736.GA12965@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 28, 2016 02:57:36 PM Bjorn Helgaas wrote:
> Hi Chen,
> 
> Thanks a lot for persevering and working this all out!
> 
> On Thu, Jan 28, 2016 at 09:35:46AM +0800, Chen Fan wrote:
> > In our X86 environment, when enable Secure boot, we found an abnormal
> > phenomenon as following call trace shows. after investigation, we
> > found the firmware assigned an irq number 255 which means unknown
> > or no connection in PCI local spec for i801_smbus, meanwhile the
> > ACPI didn't configure the pci irq routing. and the 255 irq number
> > was assigned for megasa msix without IRQF_SHARED. then in this case
> > during i801_smbus probe, the i801_smbus driver would request irq with
> > bad irq number 255. but the 255 irq number was assigned for memgasa
> > with MSIX enable. which will cause request_irq fails and result in
> > the call trace below, here we introduce an IRQ_NOTCONNECTED to identify
> > the device interrupt is not connected.
> > 
> > i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
> > i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
> > i801_smbus 0000:00:1f.3: PCI INT C: no GSI
> > genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa)
> > CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
> > Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5
> > 
> > Call Trace:
> >   dump_stack+0x19/0x1b
> >   __setup_irq+0x54a/0x570
> >   request_threaded_irq+0xcc/0x170
> >   i801_probe+0x32f/0x508 [i2c_i801]
> >   local_pci_probe+0x45/0xa0
> > i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
> > i801_smbus: probe of 0000:00:1f.3 failed with error -16
> > 
> > Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Rafael, I assume you'll take this if you think it's ready.

I can do that.

> This is a subtle problem and, if I understand correctly, can manifest
> intermittently depending on the machine configuration.  For example,
> if you got rid of the "megasa" driver, I suspect i801_smbus would not
> complain, but it wouldn't work.
> 
> I think we might want to consider doing something for non-x86 arches
> as well, but we can do that later.  I propose a changelog like the
> following.  Please correct anything I got wrong.  I suspect we will be
> revisiting this issue eventually, so I'd like to have a good
> description.
> 
> 
> x86/PCI: Recognize that Interrupt Line 255 means "not connected"
> 
> Per the x86-specific footnote to PCI spec r3.0, sec 6.2.4, the value 255 in
> the Interrupt Line register means "unknown" or "no connection."
> Previously, when we couldn't derive an IRQ from the _PRT, we fell back to
> using the value from Interrupt Line as an IRQ.  It's questionable whether
> we should do that at all, but the spec clearly suggests we shouldn't do it
> for the value 255 on x86.
> 
> Calling request_irq() with IRQ 255 may succeed, but the driver won't
> receive any interrupts.  Or, if IRQ 255 is shared with another device, it
> may succeed, and the driver's ISR will be called at random times when the
> *other* device interrupts.  Or it may fail if another device is using IRQ
> 255 with incompatible flags.  What we *want* is for request_irq() to fail
> predictably so the driver can fall back to polling.
> 
> On x86, assume 255 in the Interrupt Line means the INTx line is not
> connected.  In that case, set dev->irq to IRQ_NOTCONNECTED so request_irq()
> will fail gracefully with -ENOTCONN.
> 
> We found this problem on a system where Secure Boot firmware assigned
> Interrupt Line 255 to an i801_smbus device and another device was already
> using MSI-X IRQ 255.  This was in v3.10, where i801_probe() fails if
> request_irq() fails:
> 
>   i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
>   i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
>   i801_smbus 0000:00:1f.3: PCI INT C: no GSI
>   genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa)
>   CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
>   Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5
>   Call Trace:
>     dump_stack+0x19/0x1b
>     __setup_irq+0x54a/0x570
>     request_threaded_irq+0xcc/0x170
>     i801_probe+0x32f/0x508 [i2c_i801]
>     local_pci_probe+0x45/0xa0
>   i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
>   i801_smbus: probe of 0000:00:1f.3 failed with error -16
> 
> After aeb8a3d16ae0 ("i2c: i801: Check if interrupts are disabled"),
> i801_probe() will fall back to polling if request_irq() fails.  But we
> still need this patch because request_irq() may succeed or fail depending
> on other devices in the system.  If request_irq() fails, i801_smbus will
> work by falling back to polling, but if it succeeds, i801_smbus won't work
> because it expects interrupts that it may not receive.

I like this. :-)

Chen, can you please add the changelog as suggested by Bjorn to the patch
and resend?

Thanks,
Rafael

