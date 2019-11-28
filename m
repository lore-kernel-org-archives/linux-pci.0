Return-Path: <SRS0=N5mx=ZU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F43C43215
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 08:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA752176D
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 08:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfK1Ibl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:31:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:62975 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfK1Ibk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 03:31:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 00:31:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="409288003"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2019 00:31:35 -0800
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v1 0/1]Fix build warning and errors
Date:   Thu, 28 Nov 2019 16:31:12 +0800
Message-Id: <cover.1574929426.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mark Intel PCIe driver depends on MSI IRQ Domain to fix
the below warnings and respective build errors.

WARNING: unmet direct dependencies detected for PCIE_DW_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])

Dilip Kota (1):
  PCI: dwc: Kconfig: Mark intel PCIe driver depends on MSI IRQ Domain

 drivers/pci/controller/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
2.11.0

