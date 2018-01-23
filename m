Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 23 Jan 2018 13:56:44 -0600
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
Message-ID: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix AMD regression due to not re-enabling the big window on resume
    (Christian König)


The following changes since commit 03a551734cfc2b93f83950a595974e3c9cbd82fd:

  x86/PCI: Move and shrink AMD 64-bit window to avoid conflict (2018-01-11 12:01:58 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.15-fixes-3

for you to fetch changes up to 838cda3697073982acd276ac43387b2a0aed04b4:

  x86/PCI: Enable AMD 64-bit window on resume (2018-01-16 11:45:50 -0600)

----------------------------------------------------------------
pci-v4.15-fixes-3

----------------------------------------------------------------
=?UTF-8?q?Christian=20K=C3=B6nig?= (1):
      x86/PCI: Enable AMD 64-bit window on resume

 arch/x86/pci/fixup.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)
