Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39614 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcDSAGw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Apr 2016 20:06:52 -0400
Date: Mon, 18 Apr 2016 19:06:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hariprasad Shenai <hariprasad@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Casey Leedom <leedom@chelsio.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Tim Harvey <tharvey@gateworks.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [GIT PULL] PCI fixes for v4.6
Message-ID: <20160419000647.GA10952@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These are fixes for two issues:

  - The VPD parsing code we added for v4.6 keeps some devices from crashing,
    but also keeps cxgb4 from reading non-standard extra VPD data that is
    relies on.  Hariprasad added a way for the driver to specify how much
    VPD is valid.

  - The i.MX6 active-low reset GPIO support we added in v4.5 caused
    regressions on some boards, so we're reverting that.

Bjorn


The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.6-fixes-2

for you to fetch changes up to 67e658794ca191b3221b143f2a1c10d002c40bc8:

  cxgb4: Set VPD size so we can read both VPD structures (2016-04-15 13:00:18 -0500)

----------------------------------------------------------------
PCI updates for v4.6:

  VPD
    Add pci_set_vpd_size() (Hariprasad Shenai)
    cxgb4: Set VPD size so we can read both VPD structures (Hariprasad Shenai)

  Freescale i.MX6 host bridge driver
    Revert "PCI: imx6: Add support for active-low reset GPIO" (Fabio Estevam)

----------------------------------------------------------------
Fabio Estevam (1):
      Revert "PCI: imx6: Add support for active-low reset GPIO"

Hariprasad Shenai (2):
      PCI: Add pci_set_vpd_size() to set VPD size
      cxgb4: Set VPD size so we can read both VPD structures

 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 10 +++++++
 drivers/pci/access.c                       | 42 ++++++++++++++++++++++++++++++
 drivers/pci/host/pci-imx6.c                | 20 +++++++++-----
 drivers/pci/pci.h                          |  1 +
 include/linux/pci.h                        |  1 +
 5 files changed, 68 insertions(+), 6 deletions(-)
