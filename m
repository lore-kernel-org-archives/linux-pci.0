Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC705C43444
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C903220B1F
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 08:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeLaIZC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:25:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:51943 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeLaIZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 03:25:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 00:25:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,421,1539673200"; 
   d="scan'208";a="104473335"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.241])
  by orsmga006.jf.intel.com with SMTP; 31 Dec 2018 00:24:58 -0800
Received: by ubuntu (sSMTP sendmail emulation); Mon, 31 Dec 2018 16:24:54 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2 0/2] Add Stratix10 PCIe Root Port support
Date:   Mon, 31 Dec 2018 16:24:51 +0800
Message-Id: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe Root Port support for Stratix10 device and also update
device tree binding documentation.

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

Ley Foon Tan (2):
  pci: altera: Add Stratix10 PCIe support
  Documentation: dt-bindings: pci: altera: Add altr,pcie-root-port-2.0

 .../devicetree/bindings/pci/altera-pcie.txt        |    4 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 drivers/pci/controller/pcie-altera.c               |  240 ++++++++++++++++++--
 3 files changed, 220 insertions(+), 26 deletions(-)

