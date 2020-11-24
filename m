Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D709EC2D0E4
	for <linux-pci@archiver.kernel.org>; Tue, 24 Nov 2020 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B422076C
	for <linux-pci@archiver.kernel.org>; Tue, 24 Nov 2020 05:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKXFyG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 24 Nov 2020 00:54:06 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:12396 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727193AbgKXFyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 00:54:06 -0500
X-IronPort-AV: E=Sophos;i="5.78,365,1599490800"; 
   d="scan'208";a="63678522"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Nov 2020 14:49:03 +0900
Received: from localhost.localdomain (unknown [10.166.15.86])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 38D6A4201A27;
        Tue, 24 Nov 2020 14:49:03 +0900 (JST)
From:   Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
To:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH 0/2] Add PCIe EP to R-Car H3
Date:   Tue, 24 Nov 2020 14:42:16 +0900
Message-Id: <20201124054218.3005-1-yuya.hamamachi.sx@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset adds support for PCIe EP nodes to Renesas r8a77951 SoC.
This is based on patch series "Add PCIe EP to RZ/G2H [1]".

[1] https://lkml.org/lkml/2020/9/4/400

Yuya Hamamachi (2):
  dt-bindings: pci: rcar-pci-ep: Document r8a7795
  arm64: dts: renesas: r8a77951: Add PCIe EP nodes

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  1 +
 arch/arm64/boot/dts/renesas/r8a77951.dtsi     | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.25.1

