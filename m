Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:61261 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbBRRjk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Feb 2015 12:39:40 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so4663529obc.11
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2015 09:39:40 -0800 (PST)
Date: Wed, 18 Feb 2015 11:39:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v3.20
Message-ID: <20150218173928.GA16575@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

This fixes a double kfree in some code we merged for v3.20.

Bjorn


The following changes since commit 872912352c5be930e9568e5f3b6d73107d9f278d:

  Merge tag 'pm+acpi-3.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2015-02-10 15:09:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.20-fixes-1

for you to fetch changes up to feb28979c137ba3f649ad36fc27c85c64c111f78:

  of/pci: Remove duplicate kfree in of_pci_get_host_bridge_resources() (2015-02-11 15:27:15 -0600)

----------------------------------------------------------------
PCI updates for v3.20:

  Resource management
    - Remove duplicate kfree in of_pci_get_host_bridge_resources() (Lorenzo Pieralisi)

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      of/pci: Remove duplicate kfree in of_pci_get_host_bridge_resources()

 drivers/of/of_pci.c | 1 -
 1 file changed, 1 deletion(-)
