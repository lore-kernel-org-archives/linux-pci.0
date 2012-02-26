Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from isilmar-3.linta.de ([188.40.101.200]:43133 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752368Ab2BZSce (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 26 Feb 2012 13:32:34 -0500
Date: Sun, 26 Feb 2012 19:32:26 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: d i <navilein@hotmail.com>, linux-pci@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
Subject: Re: [yenta_cardbus: no PCI interrupts][>=linux-3.1.6][Bug?]
Message-ID: <20120226183226.GA24698@comet.dominikbrodowski.net>
References: <BLU144-W67A6260D2B364094239E8D16A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLU144-W67A6260D2B364094239E8D16A0@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CC'ing linuc-pci for the IRQ stuff -- there were no changes in the PCMCIA
code in this period (at least none I'm aware of)

Could you send the dmesg and lspci output of the following runs, please:

- linux-2.6.37-r4 -> dmesg-1, lspci-1
- reboot into a new kernel (which should work now, if I understand you
  correctly) -> dmesg-2, lspci-2
- shut down, boot new kernel -> dmesg-3, lspci-3

>From the differences between these three outputs, we should be able to track
the problem down further.

Best,
	Dominik


On Fri, Feb 24, 2012 at 12:42:59PM +0000, d i wrote:
> 
> Hello, I can't get my cardbus yenta_socket working any longer, for linux-3.1.6 and linux-3.2.1-r2. Apparently yenta_cardbus doesn't get a PCI interrupt (the boot log says: PCI irq 0)
> 
> It works without a problem in linux-2.6.37-r4. Also, if I reboot from linux-2.6.37-r4 and boot in linux-3.1.6 or linux-3.2.1-r2, it does work (as long as I don't shut down the laptop).
> 
> Initially I didn't have any pci parameters for the kernel. I've also tried with  "irqpoll pci=biosirq,noacpi" --- It still doesn't work.
> Any help would be appreciated! (my network card is through this, and it's painful to be "disconnected" :)) -- please CC to my email address navilein@hotmail.com
> 
> May find attached/bellow my dmesg log and config for linux-3.2.1-r2 run.  
> Thanks!
