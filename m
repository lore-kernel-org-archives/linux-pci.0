Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C48C4338F
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 08:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07746113C
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 08:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhHEI3X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Aug 2021 04:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhHEI3W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 04:29:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19371610A0;
        Thu,  5 Aug 2021 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628152149;
        bh=Xg0egegKAE3+y3A+acHFXR93G2BYuupBkGB74QQ+zRM=;
        h=From:To:Cc:Subject:Date:From;
        b=PEelsw/28D9DPhzFZY0q0agg1OYvad8oXCvZq6IB7mEQpkvcvv5itECn+flypwzB9
         /KdSav5U0A/+3pML0562aJmFIQ9/M+LBoLvENhDj4j9FJRabckE/+HMKPOCT6TLDeK
         /hF5r6LjhGUbMdtg8AS6YmjjOqPFVI9HA4sCrfYsAS2JWTILoSFMvKrVPT08JYLJqz
         m7+L1st2mQDMK6iEwMlrO9YUhx1u/WsDH1akvkQzIPybkujnyZ2zHnXG23K1ULRv/y
         9jCqtI3r8d0/gsv2052xuQeMe4JypG7jN5xIeRga6mH116VkbITCu1NZVY4sIUiLJa
         5DNu9f3pgPyWQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mBYkP-001DuS-Qf; Thu, 05 Aug 2021 10:29:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] Fix handling of multi-level OF nodes
Date:   Thu,  5 Aug 2021 10:28:57 +0200
Message-Id: <cover.1628151760.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

This series address the issues related to not add all of_node data at sysfs.

Patch 1 is the real fix.
Patch 2 just changes the order of init, in order to allow printing what's
happening when registering a device;
Patch 3 is just debug.

With patch 1 applied, the sysfs nodes seem to match the PCI configuration:

$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
/sys/devices/platform/soc/f4000000.pcie/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:07.0/pci_bus/0000:06/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:05.0/pci_bus/0000:05/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/pci_bus/0000:03/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node

Mauro Carvalho Chehab (3):
  PCI: of: Fix handling of multi-level PCI devices
  PCI: of: Setup PCI before setting the OF node
  PCI: of: Add some debug printks to track problems with of_node setup

 drivers/pci/of.c    | 9 +++++++++
 drivers/pci/probe.c | 5 ++---
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.31.1


