Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59553 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbcEJR2J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 May 2016 13:28:09 -0400
Date: Tue, 10 May 2016 12:28:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [GIT PULL] PCI fixes for v4.6
Message-ID: <20160510172803.GA4325@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Since v4.5, we've WARNed during resume if a PCI device, including a
Thunderbolt device, was added while we were suspended.  A change we merged
for v4.6-rc1 turned that warning into a system hang.  These patches from
Lukas fix this issue.

Bjorn


The following changes since commit 67e658794ca191b3221b143f2a1c10d002c40bc8:

  cxgb4: Set VPD size so we can read both VPD structures (2016-04-15 13:00:18 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.6-fixes-3

for you to fetch changes up to 9a2a5a638f8eb9c612a7a9af0afab93f506f6ba4:

  PCI: Do not treat EPROBE_DEFER as device attach failure (2016-05-02 13:49:11 -0500)

----------------------------------------------------------------
PCI updates for v4.6:

  Enumeration
    Fix BUG on device attach failure (Lukas Wunner)
    Do not treat EPROBE_DEFER as device attach failure (Lukas Wunner)

----------------------------------------------------------------
Lukas Wunner (2):
      PCI: Fix BUG on device attach failure
      PCI: Do not treat EPROBE_DEFER as device attach failure

 drivers/pci/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
