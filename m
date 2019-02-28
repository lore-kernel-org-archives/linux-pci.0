Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0FC00319
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088D2186A
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 02:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB1Cw5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:52:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:52790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfB1Cw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 21:52:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 18:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,421,1544515200"; 
   d="scan'208";a="147197747"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.176])
  by fmsmga002.fm.intel.com with SMTP; 27 Feb 2019 18:52:53 -0800
Received: by ubuntu (sSMTP sendmail emulation); Thu, 28 Feb 2019 18:52:53 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v6 0/3] Add Stratix 10 PCIe Root Port support
Date:   Thu, 28 Feb 2019 18:52:49 +0800
Message-Id: <1551351172-25424-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe Root Port support for Stratix 10 device and also update
device tree binding documentation.

v5 -> v6:
---------
- Move udelay to SOP polling
- Move count checking to for loop condition
- Change dw[count++] to dw[0] for first DW

v4 -> v5:
---------
- Add struct altera_pcie_ops
- Add count checking in s10_tlp_read_packet()

v3 -> v4:
---------
- Separate Kconfig change to a patch
- Change cast to mask

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
[v3]: https://lkml.org/lkml/2019/1/2/16
[v4]: https://lkml.org/lkml/2019/2/14/58
[v5]: https://lkml.org/lkml/2019/2/26/200

Ley Foon Tan (3):
  PCI: altera: Add Stratix 10 PCIe support
  PCI: altera: Enable driver on ARM64
  dt-bindings: PCI: altera: Add altr,pcie-root-port-2.0

 .../devicetree/bindings/pci/altera-pcie.txt   |   4 +-
 drivers/pci/controller/Kconfig                |   2 +-
 drivers/pci/controller/pcie-altera.c          | 264 ++++++++++++++++--
 3 files changed, 244 insertions(+), 26 deletions(-)

-- 
2.19.0

