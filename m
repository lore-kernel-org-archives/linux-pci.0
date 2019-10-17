Return-Path: <SRS0=EFs6=YK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8353ECE58D
	for <linux-pci@archiver.kernel.org>; Thu, 17 Oct 2019 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6E4222C5
	for <linux-pci@archiver.kernel.org>; Thu, 17 Oct 2019 21:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571347739;
	bh=TO0yNu9Whn6Lp8lLVIfxOgVAK9V/+ggxJbbaHAZ3ENE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=whT9ukC8YnbH0/dzjtNvJqSIR6YXJprw9SGP+hF1Kk3SSibk/vAOqgTnF2Mp0x2xp
	 r4vSgLGNi2ERTpmcCWnsDJufUnrB34RCFdSDTXBcDCLKUXzsaLaAw9jKlzqiEO1qyH
	 X9yPn88rs92vQRNNS+SmNGYGaBxo/4tX1wIYQQ20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfJQV26 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfJQV26 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 17:28:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE1C21D7A;
        Thu, 17 Oct 2019 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347738;
        bh=TO0yNu9Whn6Lp8lLVIfxOgVAK9V/+ggxJbbaHAZ3ENE=;
        h=From:To:Cc:Subject:Date:From;
        b=PMyU3Vw2ibjEVLh14210kOjWBIQ4PLI0jBxBiqk2UwvqbP5AD43BzGwlKS85cCEY9
         f3Z6lOSU87RETH+/PwRj1Ui46HjllNBw+H8JX4xq5GwsROToZ1GUDX+wR48gZYr4CZ
         fEUnYgAYGzGZCTTstE6TWfFf/ms7/YoszPGvOf8Y=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/PM: Use dev_printk() when possible
Date:   Thu, 17 Oct 2019 16:28:49 -0500
Message-Id: <20191017212851.54237-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Some PM messages, e.g., "PCI PM: Device state not saved by %pS\n", had no
indication of what device was affected.  Add pci_WARN() and use it.

Bjorn Helgaas (2):
  PCI/PM: Use PCI dev_printk() wrappers for consistency
  PCI/PM: Use pci_WARN() to include device information

 drivers/pci/pci-driver.c | 45 ++++++++++++++++++++--------------------
 include/linux/pci.h      |  8 +++++++
 2 files changed, 31 insertions(+), 22 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

