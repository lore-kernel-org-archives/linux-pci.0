Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:39712
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757186AbcCaNoj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 09:44:39 -0400
Message-ID: <1459431869.1998.12.camel@rtd-VirtualBox>
Subject: Re: PCI IRQ issue since 4.2 kernel
From: Rob Groner <rgroner@rtd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Date: Thu, 31 Mar 2016 09:44:29 -0400
In-Reply-To: <20160331134000.GA31995@localhost>
References: <1459430795.1998.11.camel@rtd-VirtualBox>
	 <20160331134000.GA31995@localhost>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-03-31 at 09:40 -0400, Bjorn Helgaas wrote:
> Hi Rob,
> 
> On Thu, Mar 31, 2016 at 09:26:35AM -0400, Rob Groner wrote:
> > We became aware of an issue with our Linux drivers when used with a 4.4
> > kernel.  These drivers had worked previously from 2.6.35 to 4.2 kernels.
> > The symptoms were that, even though the request_irq() call was
> > successful, we did not receive any IRQs.  IRQs did arrive on a different
> > IRQ line, however, and the kernel disabled that line because there was
> > no handler.
> 
> Others have seen similar issues, so we reverted 991de2e59090 ("PCI, x86:
> Implement pcibios_alloc_irq() and pcibios_free_irq()").
> 
> The revert, 6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq()
> and pcibios_free_irq()""), appeared in v4.5-rc6, so if you try that or a
> later kernel (including v4.5), it should work.
> 
> Let us know if you still see problems.
> 
> Bjorn

Thank you!  I will try the 4.5 kernel from kernel.org today.

Rob


> >  -----------------------------------------------------------------------
> >  rtd@kernel-dev:~/git/kernels/linux$ git bisect good
> >  991de2e59090e55c65a7f59a049142e3c480f7bd is the first bad commit
> >  commit 991de2e59090e55c65a7f59a049142e3c480f7bd
> >  Author: Jiang Liu <jiang.liu@linux.intel.com>
> >  Date:   Wed Jun 10 16:54:59 2015 +0800
> >  
> >      PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()
> >      
> >      To support IOAPIC hotplug, we need to allocate PCI IRQ resources on
> >  demand
> >      and free them when not used anymore.
> >      
> >      Implement pcibios_alloc_irq() and pcibios_free_irq() to dynamically
> >      allocate and free PCI IRQs.
> >      
> >      Remove mp_should_keep_irq(), which is no longer used.
> >      
> >      [bhelgaas: changelog]
> >      Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> >      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >      Acked-by: Thomas Gleixner <tglx@linutronix.de>
> >  
> >  :040000 040000 765e2d5232d53247ec260b34b51589c3bccb36ae
> >  f680234a27685e94b1a35ae2a7218f8eafa9071a M    arch
> >  :040000 040000 d55a682bcde72682e883365e88ad1df6186fd54d
> >  f82c470a04a6845fcf5e0aa934512c75628f798d M    drivers
> >  ----------------------------------------------------------------
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  https://na01.safelinks.protection.outlook.com/?url=http%3a%2f%2fvger.kernel.org%2fmajordomo-info.html&data=01%7c01%7crgroner%40rtd.com%7c4e5022d941bc4c056cfe08d35969f836%7c16f82b7977b8423dbafdd6c19032e267%7c1&sdata=4iqUGR6coY75Peouz%2buK6NUAk9pQFAHsGemGwzFXlc0%3d


