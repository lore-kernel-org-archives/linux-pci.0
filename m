Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:45199 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbaKFSy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Nov 2014 13:54:58 -0500
Received: by mail-ig0-f169.google.com with SMTP id hn18so10734812igb.4
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2014 10:54:57 -0800 (PST)
Date: Thu, 6 Nov 2014 11:54:53 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chao Zhou <chao.zhou@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Yinghai Lu <yinghai@kernel.org>
Subject: [GIT PULL] PCI fixes for v3.18
Message-ID: <20141106185453.GA17929@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

This fixes an oops when enabling SR-IOV VF devices.  The oops is a
regression I added by configuring all devices during enumeration.

Bjorn


The following changes since commit d8e7d53a2fc14e0830ab728cb84ee19933d3ac8d:

  PCI: Rename sysfs 'enabled' file back to 'enable' (2014-10-30 11:17:10 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.18-fixes-2

for you to fetch changes up to 32f638fc11db0526c706454d9ab4339d55ac89f3:

  PCI: Don't oops on virtual buses in acpi_pci_get_bridge_handle() (2014-11-05 13:06:16 -0700)

----------------------------------------------------------------
PCI update for v3.18:

  Enumeration
    - Don't oops on virtual buses in acpi_pci_get_bridge_handle() (Yinghai Lu)

----------------------------------------------------------------
Yinghai Lu (1):
      PCI: Don't oops on virtual buses in acpi_pci_get_bridge_handle()

 include/linux/pci-acpi.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
