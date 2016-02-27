Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55141 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756711AbcB0UT3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 27 Feb 2016 15:19:29 -0500
Date: Sat, 27 Feb 2016 14:19:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jake Oshins <jakeo@microsoft.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	=?utf-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>,
	Sunjin Yang <fan4326@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] PCI fixes for v4.5
Message-ID: <20160227201921.GB30280@localhost>
References: <20160227151457.GA30280@localhost>
 <CA+55aFwd3zJNyy=7n945GfKYv0RhMuX6HUfDAqvZWrQyL=4GUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFwd3zJNyy=7n945GfKYv0RhMuX6HUfDAqvZWrQyL=4GUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 27, 2016 at 10:22:04AM -0800, Linus Torvalds wrote:
> On Sat, Feb 27, 2016 at 7:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > The big chunk here is the paravirtual front-end for Linux guests of a
> > Microsoft Hyper-V VM.  It's new, so no risk of regressions to pci-hyperv
> > itself.  It does include minor changes to common code, but they are
> > low-risk.
> 
> I really don't want to take new features like this that change
> existing code when I'm about to do a rc6.
> 
> I've done late hardware-enabling pulls before with new drivers etc,
> but then they are meant to enable consumer hardware that people would
> have trouble getting Linux installed on etc. A paravirt Hyper-V VM
> install doesn't really count as that kind of "we need to get this in
> quickly out of the normal development model".
> 
> I didn't check, but can you peel off that part if it's at the top and
> just send me the actual bugfixes?

Of course!  The Hyper-V stuff was the top-most merge, so I dropped
that and added a new tag, pci-v4.5-fixes-3, with just the fixes.  Here
it is:


The following changes since commit 0cf1337e0b83c16de4e7e98dad3a6afce6043fea:

  PCI: rcar: Add device tree support for r8a7793 (2016-02-05 14:13:53 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-fixes-3

for you to fetch changes up to 61d9e854dfb91b46b99ffd3d31fc7d45d2b95f31:

  PCI: mvebu: Restrict build to 32-bit ARM (2016-02-27 08:52:20 -0600)

----------------------------------------------------------------
PCI updates for v4.5:

  Enumeration
    Revert x86 pcibios_alloc_irq() to fix regression (Bjorn Helgaas)

  Marvell MVEBU host bridge driver
    Restrict build to 32-bit ARM (Thierry Reding)

----------------------------------------------------------------
Bjorn Helgaas (3):
      Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
      Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"
      Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"

Thierry Reding (1):
      PCI: mvebu: Restrict build to 32-bit ARM

 arch/x86/include/asm/pci_x86.h |  2 ++
 arch/x86/pci/common.c          | 26 ++++++++++----------------
 arch/x86/pci/intel_mid_pci.c   |  9 +++------
 arch/x86/pci/irq.c             | 23 +++++++++++++++++++----
 drivers/acpi/pci_irq.c         | 17 +++++++++++++----
 drivers/pci/host/Kconfig       |  1 +
 include/linux/pci.h            | 17 -----------------
 7 files changed, 48 insertions(+), 47 deletions(-)
