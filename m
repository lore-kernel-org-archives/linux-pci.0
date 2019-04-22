Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19762C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E52218D3
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfDVVFx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:05:53 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42970 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfDVVFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 17:05:39 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hIg85-0004iY-Rq; Mon, 22 Apr 2019 15:05:36 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hIg82-0003zT-EL; Mon, 22 Apr 2019 15:05:30 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 22 Apr 2019 15:05:18 -0600
Message-Id: <20190422210528.15289-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 00/10]  Support using MSI interrupts in ntb_transport
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is version 4 of the MSI interrupts for ntb_transport patchset.
It's mostly a resend of v3 but with spelling and grammar fixes found by Bjorn.

I've addressed the feedback so far and rebased on the latest kernel
and would like this to be considered for merging this cycle.

The only outstanding issue I know of is that it still will not work
with IDT hardware, but ntb_transport doesn't work with IDT hardware
and there is still no sensible common infrastructure to support
ntb_peer_mw_set_trans(). Thus, I decline to consider that complication
in this patchset. However, I'll be happy to review work that adds this
feature in the future.

Also, as the port number and resource index stuff is a bit complicated,
I made a quick out of tree test fixture to ensure it's correct[1]. As
an excerise I also wrote some test code[2] using the upcomming KUnit
feature.

Logan

[1] https://repl.it/repls/ExcitingPresentFile
[2] https://github.com/sbates130272/linux-p2pmem/commits/ntb_kunit

--

Changes in v4:

* Rebased onto v5.1-rc6 (No changes)

* Numerous grammar and spelling mistakes spotted by Bjorn

--

Changes in v3:

* Rebased onto v5.1-rc1 (Dropped the first two patches as they have
  been merged, and cleaned up some minor conflicts in the PCI tree)

* Added a new patch (#3) to calculate logical port numbers that
  are port numbers from 0 to (number of ports - 1). This is
  then used in ntb_peer_resource_idx() to fix the issues brought
  up by Serge.

* Fixed missing __iomem and iowrite calls (as noticed by Serge)

* Added patch 10 which describes ntb_msi_test in the documentation
  file (as requested by Serge)

* A couple other minor nits and documentation fixes

--

Changes in v2:

* Cleaned up the changes in intel_irq_remapping.c to make them
  less confusing and add a comment. (Per discussion with Jacob and
  Joerg)

* Fixed a nit from Bjorn and collected his Ack

* Added a Kconfig dependancy on CONFIG_PCI_MSI for CONFIG_NTB_MSI
  as the Kbuild robot hit a random config that didn't build
  without it.

* Worked in a callback for when the MSI descriptor changes so that
  the clients can resend the new address and data values to the peer.
  On my test system this was never necessary, but there may be
  other platforms where this can occur. I tested this by hacking
  in a path to rewrite the MSI descriptor when I change the cpu
  affinity of an IRQ. There's a bit of uncertainty over the latency
  of the change, but without hardware this can acctually occur on
  we can't test this. This was the result of a discussion with Dave.

--

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

The series is based off of v5.1-rc6 plus the patches in ntb-next.
A git repo is available here:

https://github.com/sbates130272/linux-p2pmem/ ntb_transport_msi_v4

Thanks,

Logan

--

Logan Gunthorpe (10):
  PCI/MSI: Support allocating virtual MSI interrupts
  PCI/switchtec: Add module parameter to request more interrupts
  NTB: Introduce helper functions to calculate logical port number
  NTB: Introduce functions to calculate multi-port resource index
  NTB: Rename ntb.c to support multiple source files in the module
  NTB: Introduce MSI library
  NTB: Introduce NTB MSI Test Client
  NTB: Add ntb_msi_test support to ntb_test
  NTB: Add MSI interrupt support to ntb_transport
  NTB: Describe the ntb_msi_test client in the documentation.

 Documentation/ntb.txt                   |  27 ++
 drivers/ntb/Kconfig                     |  11 +
 drivers/ntb/Makefile                    |   3 +
 drivers/ntb/{ntb.c => core.c}           |   0
 drivers/ntb/msi.c                       | 415 +++++++++++++++++++++++
 drivers/ntb/ntb_transport.c             | 169 ++++++++-
 drivers/ntb/test/Kconfig                |   9 +
 drivers/ntb/test/Makefile               |   1 +
 drivers/ntb/test/ntb_msi_test.c         | 433 ++++++++++++++++++++++++
 drivers/pci/msi.c                       |  54 ++-
 drivers/pci/switch/switchtec.c          |  12 +-
 include/linux/msi.h                     |   8 +
 include/linux/ntb.h                     | 196 ++++++++++-
 include/linux/pci.h                     |   9 +
 tools/testing/selftests/ntb/ntb_test.sh |  54 ++-
 15 files changed, 1386 insertions(+), 15 deletions(-)
 rename drivers/ntb/{ntb.c => core.c} (100%)
 create mode 100644 drivers/ntb/msi.c
 create mode 100644 drivers/ntb/test/ntb_msi_test.c

--
2.20.1
