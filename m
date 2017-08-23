Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:36736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751988AbdHWG0d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 02:26:33 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 0/9] PCI: dwc: refactor ls-pcie ->host_init() and fix bug for dw_pcie_setup_rc
Date: Wed, 23 Aug 2017 14:08:47 +0800
Message-ID: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Drop the change for qcom pcie driver's fixup from 9/9, it seems qcom
pcie controller did not implement the register MISC_CONTROL_1_OFF.

Hou Zhiqiang (9):
  PCI: layerscape: Add dw_pcie_setup_rc to ls-pcie common host init
  PCI: layerscape: move STRFMR1 access out from the DBI write-enable
    bracket
  PCI: layerscape: add class code and multifunction fixups for ls1021a
  PCI: layerscape: refactor the host_init function
  PCI: layerscape: Disable the outbound windows configured by bootloader
  PCI: designware: add accessors for write permission of DBI read-only
    registers
  PCI: layerscape: use accessors to enable/disable DBI RO registers'
    write permission
  PCI: designware: enable write permission before updating DBI RO
    registers
  PCI: dwc: remove the obsolete fixups

 drivers/pci/dwc/pci-layerscape.c       | 90 ++++++++++++++++++----------------
 drivers/pci/dwc/pcie-artpec6.c         |  6 ---
 drivers/pci/dwc/pcie-designware-host.c |  6 +++
 drivers/pci/dwc/pcie-designware.h      | 25 ++++++++++
 4 files changed, 80 insertions(+), 47 deletions(-)

-- 
2.14.1
