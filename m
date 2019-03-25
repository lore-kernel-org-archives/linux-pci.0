Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C852C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E496206DF
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553537731;
	bh=Enz1JgZV5W6fDExbbT6le7LUEvI70Q08RrXGHVKJlDg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lIeWNQTgn3p4gk5kQMgI/4flntigvN/N2rDxqD7/EnZmbResOzIZNhioonG5DAFko
	 PHmxzLPlCQfOnCYhDC4SrJ7W7CqTPKCbK/gQKK5apGbKgB4B82MTtzTAK9upxdO0YP
	 62M5UzOyES6LltQuzoZgWzzR35gHoFv7rdLBk+sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCYSPa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCYSPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 14:15:30 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DBB2087E;
        Mon, 25 Mar 2019 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553537729;
        bh=Enz1JgZV5W6fDExbbT6le7LUEvI70Q08RrXGHVKJlDg=;
        h=From:To:Cc:Subject:Date:From;
        b=Vy273XSaKqqH0e5/91waitmJTTqz92FJFKG/NCy+1rwAZxgg5id2Xbny8OdElfMZD
         2o5SEgpt/SW2kNJ1Q2kNMjGxBjElKAHNx6+OebKhy1w9K0h1rCxhcElui1JNF2TciP
         T9AtrDP4i3RGcs8QNLmd4rfHM+3Ng20ZkMBSbxeE=
From:   helgaas@kernel.org
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI, CPER: Trivial cleanups
Date:   Mon, 25 Mar 2019 13:14:21 -0500
Message-Id: <20190325181425.247227-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Clean up whitespace, fix some typos, add some spec references, and convert
unnecessary __u32 usage to u32.

Bjorn Helgaas (4):
  PCI: Cleanup register definition width and whitespace
  PCI: Fix comment typos
  CPER: Add UEFI spec references
  CPER: Remove unnecessary use of user-space types

 drivers/pci/controller/dwc/pci-keystone.c |   2 +-
 drivers/pci/controller/pci-host-generic.c |   2 +-
 drivers/pci/controller/pcie-iproc-msi.c   |   2 +-
 drivers/pci/pci.c                         | 328 +++++++++++----------
 include/linux/cper.h                      | 336 +++++++++++-----------
 include/uapi/linux/pci_regs.h             | 132 +++++----
 6 files changed, 405 insertions(+), 397 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

