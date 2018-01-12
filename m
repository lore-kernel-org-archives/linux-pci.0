Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753875AbeALUWa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 15:22:30 -0500
Date: Fri, 12 Jan 2018 14:22:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>
Subject: [GIT PULL] PCI fixes for v4.15
Message-ID: <20180112202223.GA213707@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix AMD boot regression due to 64-bit window conflicting with system
    memory (Christian König)


The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.15-fixes-2

for you to fetch changes up to 03a551734cfc2b93f83950a595974e3c9cbd82fd:

  x86/PCI: Move and shrink AMD 64-bit window to avoid conflict (2018-01-11 12:01:58 -0600)

----------------------------------------------------------------
pci-v4.15-fixes-2

----------------------------------------------------------------
Christian König (2):
      x86/PCI: Add "pci=big_root_window" option for AMD 64-bit windows
      x86/PCI: Move and shrink AMD 64-bit window to avoid conflict

 Documentation/admin-guide/kernel-parameters.txt |  6 +++++
 arch/x86/include/asm/pci_x86.h                  |  1 +
 arch/x86/pci/common.c                           |  5 +++++
 arch/x86/pci/fixup.c                            | 29 +++++++++++++++----------
 4 files changed, 30 insertions(+), 11 deletions(-)
