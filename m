Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F965C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203F2230D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="PbxoqApc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfCKNbe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:34 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:50900 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfCKNbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 09:31:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C19A8419AF;
        Mon, 11 Mar 2019 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1552311090; x=
        1554125491; bh=/fCqUXUtlIpMCjUSaQdt+jN6rR1X7hwT5J0Fqh49LqE=; b=P
        bxoqApc5eSTg5Ps5tta0WD1X83urSJmaQfqHfKlehwyEuWfCBRj3xC72vQga/j7M
        DGnAVqZ9LdUWUPYfUMGA+hZElBSgAFku1Q2jJZUl4Lnd1ewEaaa40AF7S97KEW+x
        +cdcs6mzF18KvHTIBlvzuY7Iu0DXqqGhyoPI++CHeI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O3cm3hlSwBz3; Mon, 11 Mar 2019 16:31:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DCEB641860;
        Mon, 11 Mar 2019 16:31:29 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 16:31:29 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH RFC v4 00/21] PCI: Allow BAR movement during hotplug
Date:   Mon, 11 Mar 2019 16:31:01 +0300
Message-ID: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the firmware or kernel has arranged memory for PCIe devices in a way
that doesn't provide enough space for BARs of a new hotplugged device, the
kernel can pause the drivers of the "obstructing" devices and move their
BARs, so new BARs can fit into the freed spaces.

When a driver is un-paused by the kernel after the PCIe rescan, it should
check if its BARs had moved, and ioremap() them if needed.

Drivers indicate their support of the feature by implementing the new
rescan_prepare() and rescan_done() hooks in the struct pci_driver. If a
driver doesn't yet support the feature, BARs of its devices will be marked
as immovable by the IORESOURCE_PCI_FIXED flag.

To re-arrange the BARs and bridge windows this patch releases all of them
after a rescan and re-assigns in the same way as during the initial PCIe
topology scan at system boot.

Tested on:
 - x86_64 with "pci=realloc,assign-busses,use_crs pcie_movable_bars=force"
 - POWER8 PowerNV+PHB3 ppc64le with [1] and [2] applied and the following:
   "pci=realloc pcie_movable_bars=force"

Not so many platforms and test cases were covered, so all who are
interested are highly welcome to test on your setups - the more exotic the
better!

This patchset is a part of our work on adding support for hotplugging
bridges full of NVME and GPU devices without special requirements such as
Hot-Plug Controller, reservation of bus numbers or memory regions by
firmware, etc. Future work will be devoted to implementing the movable bus
numbers.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/186618.html
[2] https://lists.ozlabs.org/pipermail/skiboot/2019-March/013571.html

Changes since v3:
 - Rebased to the upstream, so the patches apply cleanly again.

Changes since v2:
 - Fixed double-assignment of bridge windows;
 - Fixed assignment of fixed prefetched resources;
 - Fixed releasing of fixed resources;
 - Fixed a debug message;
 - Removed auto-enabling the movable BARs for x86 - let's rely on the
   "pcie_movable_bars=force" option for now;
 - Reordered the patches - bugfixes first.

Changes since v1:
 - Add a "pcie_movable_bars={ off | force }" command line argument;
 - Handle the IORESOURCE_PCI_FIXED flag properly;
 - Don't move BARs of devices which don't support the feature;
 - Guarantee that new hotplugged devices will not steal memory from working
   devices by ignoring the failing new devices with the new PCI_DEV_IGNORE
   flag;
 - Add rescan_prepare()+rescan_done() to the struct pci_driver instead of
   using the reset_prepare()+reset_done() from struct pci_error_handlers;
 - Add a bugfix of a race condition;
 - Fixed hotplug in a non-pre-enabled (by BIOS/firmware) bridge;
 - Fix the compatibility of the feature with pm_runtime and D3-state;
 - Hotplug events from pciehp also can move BARs;
 - Add support of the feature to the NVME driver.

Sergey Miroshnichenko (21):
  PCI: Fix writing invalid BARs during pci_restore_state()
  PCI: Fix race condition in pci_enable/disable_device()
  PCI: Enable bridge's I/O and MEM access for hotplugged devices
  PCI: Define PCI-specific version of the release_child_resources()
  PCI: hotplug: Add a flag for the movable BARs feature
  PCI: Pause the devices with movable BARs during rescan
  PCI: Wake up bridges during rescan when movable BARs enabled
  nvme-pci: Handle movable BARs
  PCI: Mark immovable BARs with PCI_FIXED
  PCI: Fix assigning of fixed prefetchable resources
  PCI: Release and reassign the root bridge resources during rescan
  PCI: Don't allow hotplugged devices to steal resources
  PCI: Include fixed BARs into the bus size calculating
  PCI: Don't reserve memory for hotplug when enabled movable BARs
  PCI: Allow the failed resources to be reassigned later
  PCI: Calculate fixed areas of bridge windows based on fixed BARs
  PCI: Calculate boundaries for bridge windows
  PCI: Make sure bridge windows include their fixed BARs
  PCI: Prioritize fixed BAR assigning over the movable ones
  PCI: pciehp: Add support for the movable BARs feature
  powerpc/pci: Fix crash with enabled movable BARs

 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/powerpc/platforms/powernv/pci-ioda.c     |   3 +-
 drivers/nvme/host/pci.c                       |  29 +-
 drivers/pci/bus.c                             |   7 +-
 drivers/pci/hotplug/pciehp_pci.c              |  14 +-
 drivers/pci/pci.c                             |  60 +++-
 drivers/pci/pci.h                             |  26 ++
 drivers/pci/probe.c                           | 271 +++++++++++++++++-
 drivers/pci/setup-bus.c                       | 245 ++++++++++++++--
 drivers/pci/setup-res.c                       |  43 ++-
 include/linux/pci.h                           |  14 +
 11 files changed, 678 insertions(+), 41 deletions(-)

-- 
2.20.1

