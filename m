Return-Path: <SRS0=eyn2=TY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=AC_FROM_MANY_DOTS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C3C072B5
	for <linux-pci@archiver.kernel.org>; Fri, 24 May 2019 06:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2E2175B
	for <linux-pci@archiver.kernel.org>; Fri, 24 May 2019 06:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfEXGHd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 24 May 2019 02:07:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:28549 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387622AbfEXGHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 02:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 23:07:32 -0700
X-ExtLoop1: 1
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.59])
  by orsmga002.jf.intel.com with SMTP; 23 May 2019 23:07:29 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 24 May 2019 14:07:27 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 0/2] Fix Altera PCIe configuration type handling
Date:   Fri, 24 May 2019 14:07:24 +0800
Message-Id: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This fix issue when access config from PCIe switch.

Stratix 10 PCIe controller does not support Type 1 to Type 0 conversion
as previous version (V1) does.

The PCIe controller need to send Type 0 config TLP if the targeting bus
matches with the secondary bus number, which is when the TLP is targeting
the immediate device on the link.

The PCIe controller send Type 1 config TLP if the targeting bus is
larger than the secondary bus, which is when the TLP is targeting the
device not immediate on the link.

Ley Foon Tan (2):
  PCI: altera: Fix configuration type based on secondary number
  PCI: altera: Remove cfgrdX and cfgwrX

 drivers/pci/controller/pcie-altera.c | 47 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 23 deletions(-)

-- 
2.19.0

