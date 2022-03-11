Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C427C433F5
	for <linux-pci@archiver.kernel.org>; Fri, 11 Mar 2022 23:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiCKXu4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiCKXuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 18:50:54 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C2E039;
        Fri, 11 Mar 2022 15:49:46 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DCAE1A0FDC;
        Sat, 12 Mar 2022 00:49:44 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FDB61A00A6;
        Sat, 12 Mar 2022 00:49:44 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DE0374043C;
        Fri, 11 Mar 2022 16:49:42 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 0/4] layerscape-pci binding updates
Date:   Fri, 11 Mar 2022 17:49:34 -0600
Message-Id: <20220311234938.8706-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes two binding changes from Zhiqiang's previous
submission ("[PATCHv5 0/6] PCI: layerscape: Add power management
support") and rebased to latest 5.17-rc1:

They describe the hardware and are not necessarily connected with the PM
driver changes.  The series also includes two other binding updates to
better describe the pcie hardware.

Updates in v3:
- Change the example to ls1088a as recommended by Hou Zhiqiang
- Change leading tabs in schema example to spaces
- Added reviewed by from Rob.  Now all the patches in the series are
  reviewed by DT maintainer.

Updates in v2:
- Refined the description of AER/PME in binding and updated commit
  message
- Changed AER/PME to upper case
- Added Ack from Rob

Hou Zhiqiang (2):
  dt-bindings: pci: layerscape-pci: Add a optional property big-endian
  dt-bindings: pci: layerscape-pci: Update the description of SCFG
    property

Li Yang (1):
  dt-bindings: pci: layerscape-pci: define AER/PME interrupts

Xiaowei Bao (1):
  dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for
    ls1028a

 .../bindings/pci/layerscape-pci.txt           | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

-- 
2.25.1

