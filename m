Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC06C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955A218AF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfAaS5T (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:57:19 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49882 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfAaS5S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 13:57:18 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gpHWR-0001uq-Fg; Thu, 31 Jan 2019 11:57:17 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gpHWO-0004gj-P7; Thu, 31 Jan 2019 11:57:08 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 31 Jan 2019 11:56:47 -0700
Message-Id: <20190131185656.17972-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/9] Support using MSI interrupts in ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This patch series adds optional support for using MSI interrupts instead
of NTB doorbells in ntb_transport. This is desirable seeing doorbells on
current hardware are quite slow and therefore switching to MSI interrupts
provides a significant performance gain. On switchtec hardware, a simple
apples-to-apples comparison shows ntb_netdev/iperf numbers going from
3.88Gb/s to 14.1Gb/s when switching to MSI interrupts.

To do this, a couple changes are required outside of the NTB tree:

1) The IOMMU must know to accept MSI requests from aliased bused numbers
seeing NTB hardware typically sends proxied request IDs through
additional requester IDs. The first patch in this series adds support
for the Intel IOMMU. A quirk to add these aliases for switchtec hardware
was already accepted. See commit ad281ecf1c7d ("PCI: Add DMA alias quirk
for Microsemi Switchtec NTB") for a description of NTB proxy IDs and why
this is necessary.

2) NTB transport (and other clients) may often need more MSI interrupts
than the NTB hardware actually advertises support for. However, seeing
these interrupts will not be triggered by the hardware but through an
NTB memory window, the hardware does not actually need support or need
to know about them. Therefore we add the concept of Virtual MSI
interrupts which are allocated just like any other MSI interrupt but
are not programmed into the hardware's MSI table. This is done in
Patch 2 and then made use of in Patch 3.

The remaining patches in this series add a library for dealing with MSI
interrupts, a test client and finally support in ntb_transport.

The series is based off of v5.0-rc4 and I've tested it on top of a
of the patches I've already sent to the NTB tree (though they are
independent changes). A git repo is available here:

https://github.com/sbates130272/linux-p2pmem/ ntb_transport_msi_v1

Thanks,

Logan

--

Logan Gunthorpe (9):
  iommu/vt-d: Allow interrupts from the entire bus for aliased devices
  PCI/MSI: Support allocating virtual MSI interrupts
  PCI/switchtec: Add module parameter to request more interrupts
  NTB: Introduce functions to calculate multi-port resource index
  NTB: Rename ntb.c to support multiple source files in the module
  NTB: Introduce MSI library
  NTB: Introduce NTB MSI Test Client
  NTB: Add ntb_msi_test support to ntb_test
  NTB: Add MSI interrupt support to ntb_transport

 drivers/iommu/intel_irq_remapping.c     |  12 +
 drivers/ntb/Kconfig                     |  10 +
 drivers/ntb/Makefile                    |   3 +
 drivers/ntb/{ntb.c => core.c}           |   0
 drivers/ntb/msi.c                       | 313 ++++++++++++++++++
 drivers/ntb/ntb_transport.c             | 134 +++++++-
 drivers/ntb/test/Kconfig                |   9 +
 drivers/ntb/test/Makefile               |   1 +
 drivers/ntb/test/ntb_msi_test.c         | 416 ++++++++++++++++++++++++
 drivers/pci/msi.c                       |  51 ++-
 drivers/pci/switch/switchtec.c          |  12 +-
 include/linux/msi.h                     |   1 +
 include/linux/ntb.h                     | 139 ++++++++
 include/linux/pci.h                     |   9 +
 tools/testing/selftests/ntb/ntb_test.sh |  54 ++-
 15 files changed, 1150 insertions(+), 14 deletions(-)
 rename drivers/ntb/{ntb.c => core.c} (100%)
 create mode 100644 drivers/ntb/msi.c
 create mode 100644 drivers/ntb/test/ntb_msi_test.c

--
2.19.0
