Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0051.outbound.protection.outlook.com ([104.47.40.51]:53472
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750902AbdHPFNw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:13:52 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 0/9] PCI: dwc: refactor ls-pcie ->host_init() and fix bug for dw_pcie_setup_rc
Date: Wed, 16 Aug 2017 12:56:50 +0800
Message-ID: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reordered and reformed the version 2 patch set:
The first 5 patches are used to refactor the ls-pcie host init function
and make it robust. And make ls1021a pcie reuse the ls-pcie common host
init function. Disable the bootloader configured outbound windows to avoid
conflict to outbound windows configured by dw_pcie_setup_rc().

The rest 4 patches are aim to fix the designware Class code and interrupt
Pin code fixup doesn't work issue, because they are DBI read-only registers,
so must enable the write permission before updating this register. And removed
the obsolete fixups from layerscape, qcom and artpec6 pcie drivers.

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
 drivers/pci/dwc/pcie-qcom.c            | 17 -------
 5 files changed, 80 insertions(+), 64 deletions(-)

-- 
2.1.0.27.g96db324
