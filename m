Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757286AbcKDUks (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Nov 2016 16:40:48 -0400
Date: Fri, 4 Nov 2016 15:40:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@axis.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Olof Johansson <olof@lixom.net>,
        James Le Cuirot <chewi@gentoo.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [GIT PULL] PCI fixes for v4.9
Message-ID: <20161104204042.GA32722@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This includes:

  - Fix for a Qualcomm driver issue that causes a use-before-set crash
  - Fix for DesignWare iATU unroll support that causes external aborts when
    enabling the host bridge

The following changes since commit 02a1b8f4167eac709d269341f7c3c340984c28a6:

  PCI: designware-plat: Update author email address (2016-10-21 09:54:46 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.9-fixes-2

for you to fetch changes up to 353bcdfda96306d855c825a2218683e4c1c04e49:

  PCI: designware: Check for iATU unroll support after initializing host (2016-11-02 11:24:28 -0500)

----------------------------------------------------------------
pci-v4.9-fixes-2

----------------------------------------------------------------
Niklas Cassel (1):
      PCI: designware: Check for iATU unroll support after initializing host

Srinivas Kandagatla (1):
      PCI: qcom: Fix pp->dev usage before assignment

 drivers/pci/host/pcie-designware.c | 7 +++++--
 drivers/pci/host/pcie-qcom.c       | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)
