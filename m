Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CBCC4338F
	for <linux-pci@archiver.kernel.org>; Sat, 31 Jul 2021 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864FC6044F
	for <linux-pci@archiver.kernel.org>; Sat, 31 Jul 2021 12:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhGaMrH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 31 Jul 2021 08:47:07 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46947 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhGaMrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jul 2021 08:47:02 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 08:47:02 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id BBE4F3003F489;
        Sat, 31 Jul 2021 14:40:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AE59158E37; Sat, 31 Jul 2021 14:40:08 +0200 (CEST)
Message-Id: <cover.1627638184.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Jul 2021 14:39:00 +0200
Subject: [PATCH 0/4] pciehp error recovery fix + cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        "Oliver OHalloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One fix for a pciehp error recovery issue spotted by Stuart
plus three cleanups.  Please review and test.  Thanks!

Lukas Wunner (4):
  PCI: pciehp: Ignore Link Down/Up caused by error-induced Hot Reset
  PCI/portdrv: Remove unused resume err_handler
  PCI/portdrv: Remove unused pcie_port_bus_{,un}register() declarations
  PCI/ERR: Reduce compile time for CONFIG_PCIEAER=n

 drivers/pci/Kconfig               |  3 +++
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c |  4 ++++
 drivers/pci/hotplug/pciehp_hpc.c  | 28 ++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c          |  2 +-
 drivers/pci/pci.c                 |  2 ++
 drivers/pci/pcie/Makefile         |  4 ++--
 drivers/pci/pcie/portdrv.h        |  6 ++----
 drivers/pci/pcie/portdrv_core.c   | 20 ++++++++++----------
 drivers/pci/pcie/portdrv_pci.c    | 27 +++------------------------
 10 files changed, 57 insertions(+), 41 deletions(-)

-- 
2.31.1

