Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB17CC432BE
	for <linux-pci@archiver.kernel.org>; Mon, 30 Aug 2021 02:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD38760F57
	for <linux-pci@archiver.kernel.org>; Mon, 30 Aug 2021 02:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhH3CXr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 29 Aug 2021 22:23:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:30603 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhH3CXr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 22:23:47 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Aug 2021 11:22:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 797E22059036;
        Mon, 30 Aug 2021 11:22:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 30 Aug 2021 11:22:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7B6E9C1E08;
        Mon, 30 Aug 2021 11:22:52 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 0/2] PCI: uniphier: Fix INTx masking/unmasking
Date:   Mon, 30 Aug 2021 11:22:36 +0900
Message-Id: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series includes some fixes to INTx masking/unmasking for UniPhier PCIe
host controller driver.

- Remove unnecessary bit clears to INTX mask field
- Remove unnecessary irq_ack() function because write access to status field
  doesn't work
- Add lock into callback functions to avoid race condition

Kunihiko Hayashi (2):
  PCI: uniphier: Fix INTx mask/unmask bit operation and remove ack
    function
  PCI: uniphier: Serialize INTx masking/unmasking

 drivers/pci/controller/dwc/pcie-uniphier.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

-- 
2.7.4

