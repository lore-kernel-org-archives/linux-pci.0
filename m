Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C77C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 06:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3045A218B0
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 06:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfABGRC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:17:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:32951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfABGRC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 01:17:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 22:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="122580311"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.90])
  by orsmga002.jf.intel.com with SMTP; 01 Jan 2019 22:16:55 -0800
Received: by ubuntu (sSMTP sendmail emulation); Wed, 02 Jan 2019 14:16:51 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v3 0/2] Add Stratix 10 PCIe Root Port support
Date:   Wed,  2 Jan 2019 14:16:47 +0800
Message-Id: <1546409810-37630-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe Root Port support for Stratix 10 device and also update
device tree binding documentation.

v2 -> v3:
---------
- Rename Stratix10 to Stratix 10.
- Change bool s10_flag to enum version.

v1 -> v2:
---------
- Add define S10_TLP_FMTTYPE_* macros.
- Remove initialize structure members to NULL/zero.
- Rename *_funcs to *_data.
- Update comment and fix coding style warning from checkpatch.pl.
- Rename StratixXX to stratix10.

History:
--------
[v1]: https://lkml.org/lkml/2018/12/26/68
[v2]: https://lkml.org/lkml/2018/12/31/46

Ley Foon Tan (2):
  PCI: altera: Add Stratix 10 PCIe support
  dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0

 .../devicetree/bindings/pci/altera-pcie.txt        |    4 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 drivers/pci/controller/pcie-altera.c               |  246 ++++++++++++++++++--
 3 files changed, 226 insertions(+), 26 deletions(-)

