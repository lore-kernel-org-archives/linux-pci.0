Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D1C49EA7
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D508D61429
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jun 2021 09:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFYJHd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhFYJHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 05:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7245E6141C;
        Fri, 25 Jun 2021 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624611910;
        bh=otHxBpDBSop9Vu+CWimJLGtUnn6jB/btdPZODo1/bNM=;
        h=From:To:Cc:Subject:Date:From;
        b=hpatg0MeehRMjlBO5brXCCmjs1/Y30GNT56nPMUN8MUKRZmz7GHf5Zocu0Ec6npG8
         JhxGUlhQN4vH5j64vToKa478E08qv2M4qCeV21D7K9RVn8zI2FmldfxX8djzGAQoMN
         LWXEeygdxjOC9+nJncSJCPPNsn0H6QjKykTYmHbXLmRG97XQYl2ylQFErBqkiFHv67
         TPIEjoLEvP8aq0+RzQUvx1MTqsll/V74svDSS06atMv7fZ2hTdjXXQbUfQnCp7bjAn
         Hjm9jopC91aH2zFoK0sxjjZRcgjjPeN58ezrlQjfC1RFYhdaJiA/bvxV6bahzPekJ3
         kv7HcaTDj1mLQ==
Received: by pali.im (Postfix)
        id 446B360E; Fri, 25 Jun 2021 11:05:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] PCI: aardvark: Interrupt fixes
Date:   Fri, 25 Jun 2021 11:03:12 +0200
Message-Id: <20210625090319.10220-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per Lorenzo's request [1] I'm resending [2] some other aardvark patches
which fixes just interrupts.

I addressed review comments from [2], updated patches and added Acked-by
tags.

[1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
[2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/

Pali Rohár (7):
  PCI: aardvark: Do not touch status bits of masked interrupts in
    interrupt handler
  PCI: aardvark: Check for virq mapping when processing INTx IRQ
  PCI: aardvark: Remove irq_mask_ack callback for INTx interrupts
  PCI: aardvark: Don't mask irq when mapping
  PCI: aardvark: Fix support for MSI interrupts
  PCI: aardvark: Correctly clear and unmask all MSI interrupts
  PCI: aardvark: Fix setting MSI address

 drivers/pci/controller/pci-aardvark.c | 82 ++++++++++++++-------------
 1 file changed, 44 insertions(+), 38 deletions(-)

-- 
2.20.1

