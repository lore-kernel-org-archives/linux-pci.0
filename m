Return-Path: <SRS0=CoTa=5C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B53C2BB1D
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009D220719
	for <linux-pci@archiver.kernel.org>; Tue, 17 Mar 2020 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EiGdnNTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgCQJ5h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:57:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35322 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQJ5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 05:57:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vLUD102348;
        Tue, 17 Mar 2020 04:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584439041;
        bh=FUgu4tKrX4GkE1eavwEHL7wLF4B3OZ6GXghh7TRo6YI=;
        h=From:To:CC:Subject:Date;
        b=EiGdnNTGQ1jh90sgV3GkdkN0U2FQGQkjJUCiftwO3WAu60R7YfA9isFgyF+bx6nsa
         RHgLrtZoo+bgscMrIIu+tVpxo673M+WFW2Paao5m0JlkiIGB/l5uhVDstjBpo6O1dZ
         V+JSqMP/NWSoka8GKRJgz9qCg5biPjRFSmiB9YkE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02H9vLw2039801
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Mar 2020 04:57:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Mar 2020 04:57:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Mar 2020 04:57:21 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02H9vIKR095155;
        Tue, 17 Mar 2020 04:57:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/5] misc: Improvements to pci_endpoint_test driver
Date:   Tue, 17 Mar 2020 15:31:53 +0530
Message-ID: <20200317100158.4692-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds improvements and fixes to pci_endpoint_test driver
mostly applicable when used with multi-function endpoint (or multiple
endpoint instances using pci_epf_test).

*) Using module parameter to determine irqtype would indicate all the
   pci_endpoint_test device have the same irqtype. Fix it here.
*) Add ioctl to clear irq so that "cat /proc/interrupts" only lists
   the entries for the devices that is actually being used.
*) Creating more than 10 pci-endpoint-test devices results in a kernel
   error.
*) Use full pci-endpoint-test name in request irq so that it's easy to
   profile the interrupt details in "cat /proc/interrupts"

Changes from v1:
*) Removed a patch that references J721E device ID (That patch will
   be added as part of J721E support series)
*) Removed a patch that always enable legacy interrupt. That should
   be handled by pci_alloc_irq_vectors()

Kishon Vijay Abraham I (5):
  misc: pci_endpoint_test: Avoid using module parameter to determine
    irqtype
  misc: pci_endpoint_test: Add ioctl to clear IRQ
  tools: PCI: Add 'e' to clear IRQ
  misc: pci_endpoint_test: Fix to support > 10 pci-endpoint-test devices
  misc: pci_endpoint_test: Use full pci-endpoint-test name in request
    irq

 drivers/misc/pci_endpoint_test.c | 49 +++++++++++++++++++++++++-------
 include/uapi/linux/pcitest.h     |  1 +
 tools/pci/pcitest.c              | 16 ++++++++++-
 3 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.17.1

