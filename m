Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBEC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361AB2087E
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 08:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361AB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeKVTcD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:32:03 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:35030 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeKVTcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 14:32:03 -0500
Received: from droid10.amlogic.com (10.18.11.213) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 22 Nov 2018
 16:53:40 +0800
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
Subject: [PATCH v6 0/2] add the Amlogic Meson PCIe controller driver
Date:   Thu, 22 Nov 2018 16:53:52 +0800
Message-ID: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
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

Yue Wang (2):
  dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe
    controller
  PCI: amlogic: Add the Amlogic Meson PCIe controller driver

 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 +++
 MAINTAINERS                                        |   7 +
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-meson.c             | 597 +++++++++++++++++++++
 5 files changed, 685 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pci-meson.c

-- 
2.7.4

