Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0123.outbound.protection.outlook.com ([65.55.169.123]:33007
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756317AbcCaPGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 11:06:05 -0400
Message-ID: <1459436757.1998.14.camel@rtd-VirtualBox>
Subject: Re: PCI IRQ issue since 4.2 kernel
From: Rob Groner <rgroner@rtd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Date: Thu, 31 Mar 2016 11:05:57 -0400
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

I installed the 4.5 kernel from kernel.org and my issue has been
resolved.  Thank you very much!

Will this revert possibly make it into 4.3 and 4.4, or will I have to
tell people to avoid those versions?

Thanks!

Rob


