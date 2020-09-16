Return-Path: <SRS0=XVho=CZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B919CC2BB84
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 18:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AF820936
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 18:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgIPSbQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:31:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgIPSaR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 14:30:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1341C142F;
        Wed, 16 Sep 2020 04:07:06 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.6.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0053F68F;
        Wed, 16 Sep 2020 04:07:03 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
Date:   Wed, 16 Sep 2020 12:06:55 +0100
Message-Id: <cover.1600254147.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v2 of a previous posting.

v1->v2:
	- Added additional patch to remove sparc32 useless __KERNEL__
	  guard

v1: https://lore.kernel.org/lkml/20200915093203.16934-1-lorenzo.pieralisi@arm.com

Original cover letter
---

Fix the empty pci_iounmap() implementation that is causing memory leaks on
!CONFIG_GENERIC_IOMAP configs relying on asm-generic/io.h.

A small tweak is required on sparc32 to pull in some declarations,
hopefully nothing problematic, subject to changes as requested.

Previous tentatives:
https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: George Cherian <george.cherian@marvell.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>

Lorenzo Pieralisi (3):
  sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
  sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
    include
  asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
    implementation

 arch/sparc/include/asm/io_32.h | 17 ++++++---------
 include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.26.1

