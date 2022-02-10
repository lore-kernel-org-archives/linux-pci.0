Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A958C433F5
	for <linux-pci@archiver.kernel.org>; Thu, 10 Feb 2022 08:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiBJIKC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Feb 2022 03:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiBJIKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 03:10:02 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46D41A6;
        Thu, 10 Feb 2022 00:10:02 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Feb 2022 17:10:01 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2E7C0205D901;
        Thu, 10 Feb 2022 17:10:01 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 10 Feb 2022 17:10:01 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D1162C1E23;
        Thu, 10 Feb 2022 17:10:00 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/3] PCI: Introduce UniPhier NX1 PCI endpoint controller support
Date:   Thu, 10 Feb 2022 17:09:53 +0900
Message-Id: <1644480596-20037-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes the patches to add basic support for the PCI endpoint
controller implemented in NX1 SoC.

This defines SoC-dependent data to distinguish existing functions and flags
for Pro5 and NX1 SoCs.

Changes since v2:
- Add .init(), .wait(), and has_gio to SoC-dependent data instead of
  "is_legacy" flag
- Rename uniphier_pcie_init_ep_legacy() with uniphier_pcie_pro5_init_ep()
- Rename uniphier_pcie_init_ep() and uniphier_pcie_wait_ep() with
  uniphier_pcie_nx1_init_ep() and uniphier_pcie_nx1_wait_ep()
- Add Reviewed-by: lines

Changes since v1:
- Fix dt-bindings warnings

Kunihiko Hayashi (3):
  dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
  PCI: uniphier-ep: Add SoC data structure
  PCI: uniphier-ep: Add NX1 support

 .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  22 +++-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 142 ++++++++++++++++++---
 2 files changed, 138 insertions(+), 26 deletions(-)

-- 
2.7.4

