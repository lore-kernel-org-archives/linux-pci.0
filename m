Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304CC00140
	for <linux-pci@archiver.kernel.org>; Thu, 18 Aug 2022 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiHRNvr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiHRNvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A49A6170B
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5E4616F1
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550ECC433D6;
        Thu, 18 Aug 2022 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830705;
        bh=GIHcqeJ0SsJILvnZL+TFzAFHGWUGW+LEaDwYNlCmDPM=;
        h=From:To:Cc:Subject:Date:From;
        b=mpqLl2hafvwgev2yGjJy4KZ/FqytPrNkDPZQ9EWfj6gKm01wDiAWhZu6tomO2WQLr
         HWKZJwvU4Wzt4O5uKbtbV5RRAHq74roheg2XfEPj1lvcscihvCZN/ZbxkA2XaTriEv
         vEFMIdvYS4YrMO/9WAtJBYvQrWw52Nz8Q9bjjGYkjwGBIQWJz1E2Ck+v8xQbNpjU4E
         363do+oO7sQiL9bm/HPpgCF80hZZYGayFZD2Ri/ZtXeHp6DSVMKTnyWGPn44fUxxh4
         WSUCQSdYD/qgvmXpeBqS4cH4icpitEAXrMrElOg7zaJYyUsyT2gy0zZQEw3ViEoGEn
         8wTh0uE4KaJUg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/11] PCI: aardvark controller changes BATCH 6
Date:   Thu, 18 Aug 2022 15:51:29 +0200
Message-Id: <20220818135140.5996-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,

here is continuation of Aardvark patches.

Some patches come from those not applied in batch 5, and were rebased.

Patches 1 and 2 touch the pciehp driver. We have changed commit
messages, since originally we thought the patches are also needed
to fix a bug, but this turns out not to be true [1].

Patch 3 was changed to also select the hotplug support in Kconfig.

Patch 7 (suspend support) was changed to use new macro
NOIRQ_SYSTEM_SLEEP_PM_OPS, and also changed commit message.

Patches 8-11 are new.

[1] https://lore.kernel.org/linux-pci/20220818142243.4c046c59@dellmb/T/#u

Marek Behún (2):
  PCI: aardvark: Don't write read-only bits explicitly in PCI_ERR_CAP
    register
  PCI: aardvark: Explicitly disable Marvell strict ordering

Miquel Raynal (2):
  PCI: aardvark: Add clock support
  PCI: aardvark: Add suspend to RAM support

Pali Rohár (7):
  PCI: pciehp: Enable DLLSC interrupt only if supported
  PCI: pciehp: Enable Command Completed Interrupt only if supported
  PCI: aardvark: Add support for DLLSC and hotplug interrupt
  PCI: aardvark: Send Set_Slot_Power_Limit message
  arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliwatt
    for PCIe
  PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by
    linux/pci_regs.h macros
  PCI: aardvark: Cleanup some register macros

 .../dts/marvell/armada-3720-turris-mox.dts    |   1 +
 drivers/pci/controller/pci-aardvark.c         | 258 +++++++++++++++---
 drivers/pci/hotplug/pciehp_hpc.c              |  34 ++-
 drivers/pci/hotplug/pnv_php.c                 |  13 +-
 4 files changed, 261 insertions(+), 45 deletions(-)

-- 
2.35.1

