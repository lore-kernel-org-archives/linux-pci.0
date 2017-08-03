Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:45201
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751200AbdHCIkT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 04:40:19 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 0/6] PCI: fix the designware Class code fixup doesn't work issue and refactor ls-pcie host init
Date: Thu, 3 Aug 2017 16:23:34 +0800
Message-ID: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The first two patches are aim to fix the designware Class code fixup
doesn't work issue, because the Class Code register of DBI is read-only,
so must enable the write permission before updating this register.

The rest 4 patches are used to refactor the ls-pcie host init function.
Make ls1021a pcie reuse the ls-pcie common host init function.
Disable the bootloader configured outbound windows to avoid conflict
to outbound windows configured by dw_pcie_setup_rc().
And remove the duplicate Class Code fixup from ls-pcie driver.

Hou Zhiqiang (6):
  PCI: designware: add accessors for write permission of DBI read-only
    registers
  PCI: designware: enable write permission before updating class code
  PCI: layerscape: use accessors to enable/disable DBI RO registers'
    write permission
  PCI: layerscape: refactor the host_init function
  PCI: layerscape: Disable the outbound windows configured by bootloader
  PCI: layerscape: remove the duplicate Class field fix code

 drivers/pci/dwc/pci-layerscape.c       | 86 +++++++++++++++++++---------------
 drivers/pci/dwc/pcie-designware-host.c |  4 ++
 drivers/pci/dwc/pcie-designware.h      | 25 ++++++++++
 3 files changed, 76 insertions(+), 39 deletions(-)

-- 
2.1.0.27.g96db324
