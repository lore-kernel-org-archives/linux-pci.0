Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD0C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C282084F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mzxnaLLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbfCKLwq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:52:46 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:46800 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfCKLwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 07:52:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id CBD68419DA;
        Mon, 11 Mar 2019 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1552305161; x=
        1554119562; bh=RBTt53yuCds8nwoB5wC7xfiR4F3PRY1w7pnv6OZB+k8=; b=m
        zxnaLLrRk/i/VrQxYxvQsAt1fi4vFl2oDz3fav3F+B4RnQOeAebC8oxL/9oPabTx
        66YvL6/JrV00e6LIc+BmrE+KMwERaJ8rGAhyWuPDhJ1u8UN0OgYWTq/E3WYq8jKw
        alUbpCfulinuKJynVhbjhNdTw428E2iW2VGAyALpoU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AGNBNbt_2TEh; Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A2E8E41200;
        Mon, 11 Mar 2019 14:52:40 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:40 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
CC:     Oliver O'Halloran <oohall@gmail.com>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell Currey <ruscur@russell.cc>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 0/8] powerpc/powernv/pci: Make hotplug self-sufficient, independent of FW and DT
Date:   Mon, 11 Mar 2019 14:52:25 +0300
Message-ID: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
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

This patchset allows switching from the pnv_php module to the standard
pciehp driver for PCIe hotplug functionality, if the platform supports it:
PowerNV working on on top of the skiboot with the "core/pci: Sync VFs and
the changes of bdfns between the firmware and the OS" [1] patch serie
applied.

The feature is activated by the "pci=realloc" command line argument.

The goal is ability to hotplug bridges full of devices in the future. The
"Movable BARs" [2] is a platform-independent part of our work in this. The
final part will be movable bus numbers to support inserting a bridge in the
middle of an existing PCIe tree.

Tested on POWER8 PowerNV+PHB3 ppc64le (our Vesnin server) with:
 - the pciehp driver active;
 - the pnv_php driver disabled;
 - The "pci=realloc" argument is passed;
 - surprise hotplug of an NVME disk works;
 - controlled hotplug of a network card with SR-IOV works;
 - activating of SR-IOV on a network card works;
 - [with extra patches] manually initiated (via sysfs) rescan has found
   and turned on a hotplugged bridge;
 - Without "pci=realloc" works just as before.

Changes since v4:
 - Fixed failing build when EEH is disabled in a kernel config;
 - Unfreeze the bus on EEH_IO_ERROR_VALUE(size), not only 0xffffffff;
 - Replaced the 0xff magic constant with phb->ioda.reserved_pe_idx;
 - Renamed create_pdn() -> pci_create_pdn_from_dev();
 - Renamed add_one_dev_pci_data(..., vf_index, ...) -> pci_alloc_pdn();
 - Renamed add_dev_pci_data() -> pci_create_vf_pdns();
 - Renamed remove_dev_pci_data() -> pci_destroy_vf_pdns();
 - Removed the patch fixing uninitialized IOMMU group - now it is fixed in
   commit 8f5b27347e88 ("powerpc/powernv/sriov: Register IOMMU groups for
   VFs")

Changes since v3 [3]:
 - Subject changed;
 - Don't disable EEH during rescan anymore - instead just unfreeze the
   target buses deliberately;
 - Add synchronization with the firmware when changing the PCIe topology;
 - Fixed for VFs;
 - Code cleanup.

Changes since v2:
 - Don't reassign bus numbers on PowerNV by default (to retain the default
   behavior), but only when pci=realloc is passed;
 - Less code affected;
 - pci_add_device_node_info is refactored with add_one_dev_pci_data;
 - Minor code cleanup.

Changes since v1:
 - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
 - Fixed build for ppc64e when CONFIG_EEH is disabled;
 - Fixed code style warnings.

[1] https://lists.ozlabs.org/pipermail/skiboot/2019-March/013571.html
[2] https://www.spinics.net/lists/linux-pci/msg79995.html
[3] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-September/178053.html

Sergey Miroshnichenko (8):
  powerpc/pci: Access PCI config space directly w/o pci_dn
  powerpc/powernv/pci: Suppress an EEH error when reading an empty slot
  powerpc/pci: Create pci_dn on demand
  powerpc/pci: Reduce code duplication in pci_add_device_node_info
  powerpc/pci/IOV: Add support for runtime enabling the VFs
  powerpc/pci: Don't rely on DT is the PCI_REASSIGN_ALL_BUS is set
  powerpc/powernv/pci: Hook up the writes to PCI_SECONDARY_BUS register
  powerpc/powernv/pci: Enable reassigning the bus numbers

 arch/powerpc/include/asm/pci-bridge.h        |   4 +-
 arch/powerpc/include/asm/ppc-pci.h           |   1 +
 arch/powerpc/kernel/pci_dn.c                 | 170 ++++++++++-----
 arch/powerpc/kernel/rtas_pci.c               |  97 ++++++---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   4 +-
 arch/powerpc/platforms/powernv/pci.c         | 205 +++++++++++++++++--
 arch/powerpc/platforms/pseries/pci.c         |   4 +-
 8 files changed, 379 insertions(+), 108 deletions(-)

-- 
2.20.1

