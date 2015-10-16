Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63191 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbJPJsZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 05:48:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kevin Hilman <khilman@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] PCI: iproc: fix 32-bit build error
Date: Fri, 16 Oct 2015 11:47:42 +0200
Message-ID: <5482493.6eNiKO1I30@wuerfel>
In-Reply-To: <20151015210113.GA13636@localhost>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com> <5754881.OPA6La0Zg0@wuerfel> <20151015210113.GA13636@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 October 2015 16:01:13 Bjorn Helgaas wrote:
> On Thu, Oct 15, 2015 at 09:40:45PM +0200, Arnd Bergmann wrote:
> > The iproc PCI driver tries to figure out whether the MMIO window has
> > a valid size, but does this using a 64-bit modulo operation, which
> > is not allowed on 32-bit kernels and leads to a link error:
> > 
> > drivers/built-in.o: In function `iproc_pcie_setup':
> > :(.text+0x4b798): undefined reference to `__aeabi_uldivmod'
> > 
> > This works around that error by using the div64_u64() function
> > provided by the kernel. While this is an expensive operation,
> > it is harmless because we only call it during the probing
> > of the driver.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Ray Jui <rjui@broadcom.com>
> > Fixes: 0ab99ca8eb6c ("PCI: iproc: Fix compile warnings")
> 
> This *looks* like it should be fixing 90e4032eeaf2 ("PCI: iproc: Add
> outbound mapping support"), not 0ab99ca8eb6c.
> 
> 90e4032eeaf2 added the "if (size % ob->window_size)".
> 
> Is this more subtle than that?
> 
> 

You are absolutely right, I must have copy-pasted the wrong entry.
Do you want me to resend this? I guess you can just remove the
line as this commit has not appeared in any release anyway.

	Arnd
