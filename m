Return-Path: <SRS0=ntsD=6I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CBC54FD0
	for <linux-pci@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E9F20767
	for <linux-pci@archiver.kernel.org>; Fri, 24 Apr 2020 15:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587742754;
	bh=V8q8kLIP2B/pafVqkA/cfPT1u5uaVS3BoZnKqWw/goY=;
	h=From:To:Subject:Date:List-ID:From;
	b=zxdG+W0NKYp+Xr82mAMWi7hfnOjYtif+Dlrq5JdlHnysq3BTRkNQAi4Jzs6T1ooLF
	 pmOz8Wdd9DntGopalcI07Fo5sjznJAnD4hUedlX2zDfdk5DjM4GoC3synS8hU8C2UT
	 /SGkLlHrgGkZx+LyDFiOaGz8rCHM0MxBoDx7Fzqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgDXPjN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgDXPjM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:39:12 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98EDC21569;
        Fri, 24 Apr 2020 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587742751;
        bh=V8q8kLIP2B/pafVqkA/cfPT1u5uaVS3BoZnKqWw/goY=;
        h=From:To:Subject:Date:From;
        b=NDxA9Z846qIWlFGjgOn7osCykUZ7BvtKAR96qKPsJlIGzSQyviATg0f6GG4wRGyR3
         hXaMCYRVjxD6e4TElfaRkpnlETCjcv5UQu7uMkhtN2DbvwD/C8RS3Sq0r9D3mSWpAR
         oJ1WMDbmDLWvWAfcuAlW672UEaaZFxCEUDAuepek=
Received: by pali.im (Postfix)
        id 16EAA82E; Fri, 24 Apr 2020 17:39:09 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 00/12] PCI: aardvark: Fix support for Turris MOX and Compex wifi cards
Date:   Fri, 24 Apr 2020 17:38:46 +0200
Message-Id: <20200424153858.29744-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

this is the third version of the patch series for Armada 3720 PCIe
controller (aardvark). It's main purpose is to fix some bugs regarding
buggy ath10k cards, but we also found out some suspicious stuff about
the driver and the SOC itself, which we try to address.

Changes since v2:
- move PCIe max-link-speed property to armada-37xx.dtsi
- replace custom macros by standard linux/pci_regs.h macros
- increase PERST delay to 10ms (needed for initialized Compex WLE900VX)
- disable link training before PERST (needed for Compex WLE900VX)
- change of_pci_get_max_link_speed() function to signal -ENOENT
- handle errors from of_pci_get_max_link_speed() function
- updated comments, commit titles and messages

Changes since v1:
- commit titles and messages were reviewed and some of them were rewritten
- patches 1 and 5 from v1 which touch PCIe speed configuration were
  reworked into one patch
- patch 2 from v1 was removed, it is not needed anymore
- patch 7 from v1 now touches the device tree of armada-3720-db
- a patch was added that tries to enable PCIe PHY via generic-phy API
  (if a phandle to the PHY is found in the device tree)
- a patch describing the new PCIe node DT properties was added
- a patch was added that moves the PHY phandle from board device trees
  to armada-37xx.dtsi

Marek and Pali

Marek Behún (5):
  PCI: aardvark: Improve link training
  PCI: aardvark: Add PHY support
  dt-bindings: PCI: aardvark: Describe new properties
  arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
  arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property

Pali Rohár (7):
  PCI: aardvark: Train link immediately after enabling training
  PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
    read-only register
  PCI: of: Return -ENOENT if max-link-speed property is not found
  PCI: aardvark: Issue PERST via GPIO
  PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
  PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
    macros
  arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property

 .../devicetree/bindings/pci/aardvark-pci.txt  |   4 +
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   3 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +-
 .../dts/marvell/armada-3720-turris-mox.dts    |   6 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |   6 +-
 drivers/pci/controller/pci-aardvark.c         | 262 +++++++++++++++---
 drivers/pci/of.c                              |  15 +-
 8 files changed, 243 insertions(+), 59 deletions(-)

-- 
2.20.1

