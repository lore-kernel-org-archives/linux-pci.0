Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35156 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbbCLQU5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 12:20:57 -0400
Received: by oigh136 with SMTP id h136so4030321oig.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 09:20:56 -0700 (PDT)
Date: Thu, 12 Mar 2015 11:20:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Feng Kan <fkan@apm.com>, Sasha Levin <sasha.levin@oracle.com>
Subject: [GIT PULL] PCI fixes for v4.0
Message-ID: <20150312162053.GA20700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are a couple updates for v4.0.  One fixes a config accessor problem on
APM X-Gene that we introduced when switching to generic config accessors,
and the other fixes an older read-past-end-of-buffer problem in sysfs.

Bjorn


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.0-fixes-2

for you to fetch changes up to 085a68d0010ffa57603b93c2b09fdf98bf74218c:

  PCI: xgene: Add register offset to config space base address (2015-03-05 22:14:21 -0600)

----------------------------------------------------------------
PCI updates for v4.0:

  APM X-Gene host bridge driver
    - Add register offset to config space base address (Feng Kan)

  Miscellaneous
    - Don't read past the end of sysfs "driver_override" buffer (Sasha Levin)

----------------------------------------------------------------
Feng Kan (1):
      PCI: xgene: Add register offset to config space base address

Sasha Levin (1):
      PCI: Don't read past the end of sysfs "driver_override" buffer

 drivers/pci/host/pci-xgene.c | 4 ++--
 drivers/pci/pci-sysfs.c      | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
