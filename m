Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>, rjw@rjwysocki.net,
	linux-pci@vger.kernel.org, catalin.marinas@arm.com, x86@kernel.org,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
	wangyijing@huawei.com, Liviu.Dudau@arm.com, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Linaro-acpi] [PATCH 2/6] x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/ directory
Date: Fri, 12 Dec 2014 15:55:23 +0100
Message-ID: <67564550.9h6b3Ng1Fi@wuerfel>
In-Reply-To: <20141210235500.GA22886@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org> <1416413091-13452-3-git-send-email-tomasz.nowicki@linaro.org> <20141210235500.GA22886@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 10 December 2014 16:55:00 Bjorn Helgaas wrote:
> On Wed, Nov 19, 2014 at 05:04:47PM +0100, Tomasz Nowicki wrote:
> > MMCFG table seems to be architecture independent and it makes sense
> > to share common code across all architectures. The ones that may need
> > architectural specific actions have default prototype (__weak).
> > 
> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> > Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  arch/x86/include/asm/pci_x86.h |  29 -----
> >  arch/x86/pci/acpi.c            |   1 +
> >  arch/x86/pci/init.c            |   1 +
> >  arch/x86/pci/mmconfig-shared.c | 200 +---------------------------------
> >  arch/x86/pci/mmconfig_32.c     |   1 +
> >  arch/x86/pci/mmconfig_64.c     |   1 +
> >  drivers/acpi/Makefile          |   1 +
> >  drivers/acpi/bus.c             |   1 +
> >  drivers/acpi/mmconfig.c        | 242 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmconfig.h       |  58 ++++++++++
> >  include/linux/pci.h            |   8 --
> >  11 files changed, 308 insertions(+), 235 deletions(-)
> >  create mode 100644 drivers/acpi/mmconfig.c
> >  create mode 100644 include/linux/mmconfig.h
> > ... 
> 
> Much of the code you're moving to drivers/acpi/mmconfig.c is not actually
> ACPI-specific and would have to be duplicated for a non-ACPI architecture
> that supports ECAM.  Could that code be moved somewhere like
> drivers/pci/ecam.c, where it could be shared?

We have an implementation of ECAM in drivers/pci/host/pci-host-generic.c,
which today is ARM32 specific but should be migrated to the new generic
infrastructure we are adding for ARM64, after which that driver becomes
very simple.

I suppose we could either make it use drivers/pci/ecam.c then, or have
the config space code from pci-host-generic be shared between ACPI and
DT based platforms. The former approach is probably nicer in the long
run, and it allows sharing with other drivers that use ECAM but are not
completely generic otherwise.

	Arnd
