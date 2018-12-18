Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE07C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AF9217D8
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 07:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeLRH47 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:56:59 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:34324 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeLRH46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 02:56:58 -0500
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 18 Dec 2018
 15:57:13 +0800
From:   Hanjie Lin <hanjie.lin@amlogic.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 0/2] add the Amlogic Meson PCIe controller driver
Date:   Tue, 18 Dec 2018 15:56:48 +0800
Message-ID: <1545119811-26911-1-git-send-email-hanjie.lin@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.213]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
PCI core. This patchset add the driver and dt-bindings of the controller.
Changes since v7: [6]
 - include files in alphabetical order
 - get rid of unused MACROs and variables
 - optimize meson_pcie_link_up() while loop
 
Changes since v6: [5]
 - fix bad usage of ERR_PTR(ENXIO)
 - fix meson_pcie_rd_own_conf() when read PCI_CLASS_DEVICE reg 

Changes since v5: [4]
 - update MAINTAINER file in alphabetical order
 - remove meaningless comment
 - use ERR_PTR function instead of (void *) cast
 - use is_power_of_2(size) instead of size & (size - 1)
 - add comment for PCI_CLASS_REVISION register operation
 
Changes since v4: [3]
 - fix kbuild test robot and compile warnings

Changes since v3: [2]
 - modify subject format
 - update Kconfig
 - update MAINTAINER file
 - add comment and error handle for meson_pcie_get_mem_shared()
 - drop useless initialization code
 - add comment for meson_size_to_payload()
 - optimize meson_pcie_establish_link() return code
 - optimize meson_pcie_enable_interrupts() redundant function
 - drop device_attch related code
 - drop dw_pcie_ops read_dbi and write_dbi function
 - add error handle for meson_add_pcie_port() when probe

Changes since v2: [1]
 - abandon phy driver, move reset to the controller
 - use devm_add_action_or_reset() to use clock res
 - format correcting

Changes since v1: [0]
 - use gpio lib instead open code
 - move 'apb' and 'port' reset from phy driver
 - format correcting

[0] : https://lkml.kernel.org/r/1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com
[1] : https://lkml.kernel.org/r/1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com
[2] : https://lkml.kernel.org/r/1537509820-52040-1-git-send-email-hanjie.lin@amlogic.com 
[3] : https://lkml.kernel.org/r/1538999834-156423-3-git-send-email-hanjie.lin@amlogic.com
[4] : https://lkml.kernel.org/r/1539049990-30810-1-git-send-email-hanjie.lin@amlogic.com
[5] : https://lkml.kernel.org/r/1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe
    controller
  PCI: amlogic: Add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 595 +++++++++++++++++++++
 5 files changed, 683 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c

-- 
2.7.4

