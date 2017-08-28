Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:12770
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751223AbdH1LKD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:03 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 0/9] PCI: dwc: refactor ls-pcie ->host_init() and fix bug for dw_pcie_setup_rc
Date: Mon, 28 Aug 2017 18:52:52 +0800
Message-ID: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Split PATCHv4 4/9 into 2 patches, one is for moving the declare place
of ls1021 specific host_init function, another one is to make ls1021
host_init call the layerscape platform common host_init function.

Squashed PATCHv4 6/9 and 7/9 together.

Hou Zhiqiang (9):
  PCI: layerscape: Add dw_pcie_setup_rc to ls-pcie common host init
  PCI: layerscape: move STRFMR1 access out from the DBI write-enable
    bracket
  PCI: layerscape: add class code and multifunction fixups for ls1021a
  PCI: layerscape: move ls1021 specific host_init behind the common one
  PCI: layerscape: refactor the host_init function
  PCI: layerscape: Disable the outbound windows configured by bootloader
  PCI: designware: add accessors for write permission of DBI read-only
    registers
  PCI: designware: enable write permission before updating DBI RO
    registers
  PCI: dwc: remove the obsolete fixups

 drivers/pci/dwc/pci-layerscape.c       | 92 ++++++++++++++++++----------------
 drivers/pci/dwc/pcie-artpec6.c         |  6 ---
 drivers/pci/dwc/pcie-designware-host.c |  6 +++
 drivers/pci/dwc/pcie-designware.h      | 25 +++++++++
 4 files changed, 80 insertions(+), 49 deletions(-)

-- 
2.14.1
