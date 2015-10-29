Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42492 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbbJ2Xyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 19:54:49 -0400
Date: Thu, 29 Oct 2015 18:54:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sasha Levin <sasha.levin@oracle.com>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.3
Message-ID: <20151029235444.GC11994@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Sorry for this last-minute update; it's been in -next for quite a while,
but I forgot about it until I started getting ready for the merge window.

It's small and fixes a way a user could cause a panic via sysfs, so I think
it's worth getting it in v4.3.

Bjorn


The following changes since commit de24c18c0faca5ebd618e1cb87f5489745e40475:

  PCI: rcar: Add R8A7794 support (2015-09-24 17:06:32 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.3-fixes-2

for you to fetch changes up to 1266963170f576d4d08e6310b6963e26d3ff9d1e:

  PCI: Prevent out of bounds access in numa_node override (2015-10-07 11:03:28 -0500)

----------------------------------------------------------------
PCI update for v4.3:

  NUMA
    - Prevent out of bounds access in sysfs numa_node override (Sasha Levin)

----------------------------------------------------------------
Sasha Levin (1):
      PCI: Prevent out of bounds access in numa_node override

 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
