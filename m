Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 16 Oct 2015 08:23:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Tyler Baker <tyler.baker@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Olof Johansson <olof@lixom.net>,
	Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH v2] PCI: iproc: fix 32-bit build error
Message-ID: <20151016132344.GA21346@localhost>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
 <5754881.OPA6La0Zg0@wuerfel>
 <20151015210113.GA13636@localhost>
 <5482493.6eNiKO1I30@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5482493.6eNiKO1I30@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 11:47:42AM +0200, Arnd Bergmann wrote:
> On Thursday 15 October 2015 16:01:13 Bjorn Helgaas wrote:
> > On Thu, Oct 15, 2015 at 09:40:45PM +0200, Arnd Bergmann wrote:
> > > The iproc PCI driver tries to figure out whether the MMIO window has
> > > a valid size, but does this using a 64-bit modulo operation, which
> > > is not allowed on 32-bit kernels and leads to a link error:
> > > 
> > > drivers/built-in.o: In function `iproc_pcie_setup':
> > > :(.text+0x4b798): undefined reference to `__aeabi_uldivmod'
> > > 
> > > This works around that error by using the div64_u64() function
> > > provided by the kernel. While this is an expensive operation,
> > > it is harmless because we only call it during the probing
> > > of the driver.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Ray Jui <rjui@broadcom.com>
> > > Fixes: 0ab99ca8eb6c ("PCI: iproc: Fix compile warnings")
> > 
> > This *looks* like it should be fixing 90e4032eeaf2 ("PCI: iproc: Add
> > outbound mapping support"), not 0ab99ca8eb6c.
> > 
> > 90e4032eeaf2 added the "if (size % ob->window_size)".
> > 
> > Is this more subtle than that?
> 
> You are absolutely right, I must have copy-pasted the wrong entry.
> Do you want me to resend this? I guess you can just remove the
> line as this commit has not appeared in any release anyway.

I squashed this fix and Jon's %pap fix into Ray's original "Add outbound
mapping support" patch and re-did the merge.  Thanks!

Bjorn
