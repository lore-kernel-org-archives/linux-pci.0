Return-Path: <SRS0=s+SA=MR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2639DC00449
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D512721473
	for <linux-pci@archiver.kernel.org>; Fri,  5 Oct 2018 20:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKXeFZ2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeJFDr6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeJFDr6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 23:47:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B410720652;
        Fri,  5 Oct 2018 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538772453;
        bh=3LPGNtj4f8IzbWL0fPhnRr1hV0+95eS6kCLc1JnILV0=;
        h=Date:From:To:Cc:Subject:From;
        b=LKXeFZ2vuMRlLlARTQFLQizfo+vqizQ25jHBU55/npBMqhHRNnE1wDn5Zyv6Tz/cA
         7Fx84D39G1u8Iq8l8oHY6Sab3IDas/CxHKXoswrQRWYL284W6X7dFH8xXAAyEQJ4FC
         g2wnf8YvJ+O2nVHENHpT9mrJvoQLpBAvkOIYY3gA=
Date:   Fri, 5 Oct 2018 15:47:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: [GIT PULL] PCI fixes for v4.19
Message-ID: <20181005204730.GA136037@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Reprogram bridge prefetch registers to fix NVIDIA and Radeon issues
    after suspend/resume (Daniel Drake)

  - Fix mvebu I/O mapping creation sequence (Thomas Petazzoni)

  - Fix minor MAINTAINERS file match issue (Bjorn Helgaas)


The following changes since commit f188b99f0b2d33794b4af8a225f95d1e968c0a3f:

  ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge (2018-09-26 15:39:28 -0500)

are available in the Git repository at:
 
  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-fixes-3

for you to fetch changes up to 95375f2ab2960c135484d83ea9f8f357cb1be26a:

  PCI: mvebu: Fix PCI I/O mapping creation sequence (2018-10-01 15:42:09 -0500)

----------------------------------------------------------------
pci-v4.19-fixes-3

----------------------------------------------------------------
Bjorn Helgaas (1):
      MAINTAINERS: Remove obsolete drivers/pci pattern from ACPI section

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Thomas Petazzoni (1):
      PCI: mvebu: Fix PCI I/O mapping creation sequence

 MAINTAINERS                        |  1 -
 drivers/pci/controller/pci-mvebu.c | 52 +++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.c                  | 27 ++++++++++++++------
 3 files changed, 67 insertions(+), 13 deletions(-)
