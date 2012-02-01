Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	"Cc: Dominik Brodowski" <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/7] PCI : bridge resource reallocation patchset -- followup
Date: Wed,  1 Feb 2012 14:42:43 -0800
Message-Id: <1328136170-17613-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

e4afda7: PCI: only enable pci realloc when SRIOV bar is not assigned
fee4a1e: PCI: print out suggestion about using pci=realloc
83f0fb3: PCI: Make pci bridge reallocating enabled/disabled
3ede49c: PCI: Retry on type IORESOURCE_IO allocation.
6becd43: PCI: Skip reset cardbus assigned resource during pci bus rescan
51f1186: PCI: Fix cardbus bridge resources as optional size handling
aa85d79: PCI: Disable cardbus bridge MEM1 pref CTL

are left over after Jesse pickup more of them.
it will try to auto detect if need to use pci=realloc, and print out suggestion.

including fixing some pci carbus handling.

could get from

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci3

Thanks

Yinghai

 Documentation/kernel-parameters.txt |    8 ++-
 drivers/pci/pci.c                   |    4 +-
 drivers/pci/pci.h                   |    2 +-
 drivers/pci/setup-bus.c             |  159 +++++++++++++++++++++++++----------
 4 files changed, 125 insertions(+), 48 deletions(-)




