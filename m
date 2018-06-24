Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 24 Jun 2018 11:49:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] genirq: Synchronize only with single thread on
 free_irq()
In-Reply-To: <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
Message-ID: <alpine.DEB.2.21.1806241148030.8650@nanos.tec.linutronix.de>
References: <32fc25aa35ecef4b2692f57687bb7fc2a57230e2.1529828292.git.lukas@wunner.de> <d72b41309f077c8d3bee6cc08ad3662d50b5d22a.1529828292.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 24 Jun 2018, Lukas Wunner wrote:

> When pciehp is converted to threaded IRQ handling, removal of unplugged
> devices below a PCIe hotplug port happens synchronously in the IRQ
> thread.  Removal of devices typically entails a call to free_irq() by
> their drivers.

Is this an actual mainline problem or did you discover that in course of
upcoming work?

Thanks,

	tglx
