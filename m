Return-Path: <SRS0=zpRJ=PD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D50C43612
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F5218AD
	for <linux-pci@archiver.kernel.org>; Wed, 26 Dec 2018 09:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLZJJv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:09:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:53943 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeLZJJv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Dec 2018 04:09:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 01:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="121722934"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.249.94])
  by orsmga001.jf.intel.com with SMTP; 26 Dec 2018 01:09:48 -0800
Received: by ubuntu (sSMTP sendmail emulation); Thu, 27 Dec 2018 01:09:47 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 0/2] Add StratixXX PCIe Rootport support
Date:   Thu, 27 Dec 2018 01:09:44 +0800
Message-Id: <1545844186-25305-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe rootport support for StratixXX device family and also update
device tree binding documentation.

Ley Foon Tan (2):
  pci: altera: Add StratixXX PCIe support
  Documentation: dt-bindings: pci: altera: Add altr,pcie-root-port-2.0

 .../devicetree/bindings/pci/altera-pcie.txt        |    4 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 drivers/pci/controller/pcie-altera.c               |  228 ++++++++++++++++++--
 3 files changed, 212 insertions(+), 22 deletions(-)
 mode change 100644 => 100755 Documentation/devicetree/bindings/pci/altera-pcie.txt
 mode change 100644 => 100755 drivers/pci/controller/Kconfig

