Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v4 0/4] PCI : bridge resource reallocation patchset -- followup
Date: Thu, 23 Feb 2012 19:23:28 -0800
Message-Id: <1330053812-10316-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

e084882: PCI: only enable pci realloc when SRIOV bar is not assigned
22f7543: PCI: print out suggestion about using pci=realloc
c81bbda: PCI: Make pci bridge reallocating enabled/disabled
b1b520d: PCI: Retry on type IORESOURCE_IO allocation.

are left over after Jesse pickup more of them.
it will try to auto detect if need to use pci=realloc, and print out suggestion.

could get from

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-next


-v3: Resend according to Jesse. Update ack and etc.
     last one add CONFIG_PCI_REALLOC_ENABLE_DETECT according to Jesse.
-v4: left over that need refreshing against pci/linux-next...
    resending accoring to Jesse.

Thanks

Yinghai

 Documentation/kernel-parameters.txt |    9 +++-
 drivers/pci/Kconfig                 |   10 +++++
 drivers/pci/pci.c                   |    4 +-
 drivers/pci/pci.h                   |    2 +-
 drivers/pci/setup-bus.c             |   75 +++++++++++++++++++++++++++--------
 5 files changed, 79 insertions(+), 21 deletions(-)

