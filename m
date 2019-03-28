Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37192C43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02187217F5
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553799823;
	bh=DV0h3zhxBidGHTj8gWNf5gymDcadT/NRY6d741kJI0A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G5IkCq+ikUNmZR7Q/34wRCUiX8m7T5gcbT+A4/t5crhDK+Ul2dLHSXb20OzyiIw+5
	 nhhPJNQzMdTln5STOMGT7ez0T30silhFQH2dOmFg2Ssm9kgxbS3vdNOgSCbfSVHyTR
	 kuFY3MOInF6qoGmkCF287z9wvJVD8mYSBFsDUxuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfC1TDm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfC1TDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 15:03:42 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6881C2173C;
        Thu, 28 Mar 2019 19:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553799821;
        bh=DV0h3zhxBidGHTj8gWNf5gymDcadT/NRY6d741kJI0A=;
        h=Date:From:To:Cc:Subject:From;
        b=KsgiMQlsiQqqSWvIfs9swv/QNoPFrCEfX9DASCcIJ6L/jRiQh6/heU/TEyjv9QvGN
         KiFnM6vN26eE7+3Z40hqiIOPDlUJLf9O/UbY5lFkIolB2ajS0OIJLAeOD+QrJbTO7/
         BXgzIZ54Ed/j2lShlTQ5stF5TOFL5ceUjAIvbKGU=
Date:   Thu, 28 Mar 2019 14:03:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Borislav Petkov <bp@suse.de>
Subject: [GIT PULL] PCI fixes for v5.1
Message-ID: <20190328190340.GD24180@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Clear level-triggered interrupts for the bandwidth notification
    supported added for v5.1 (Alexandru Gagniuc)

  - Clear bandwidth notification interrupts before enabling them (Lukas
    Wunner)

  - Report post-enumeration bandwidth changes only once for multi-function
    devices (Lukas Wunner)


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-1

for you to fetch changes up to 0fa635aec9abd718bd18c0bda2261351a0811efc:

  PCI/LINK: Deduplicate bandwidth reports for multi-function devices (2019-03-25 17:59:07 -0500)

----------------------------------------------------------------
pci-v5.1-fixes-1

----------------------------------------------------------------
Alexandru Gagniuc (1):
      PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked

Lukas Wunner (2):
      PCI/LINK: Clear bandwidth notification interrupt before enabling it
      PCI/LINK: Deduplicate bandwidth reports for multi-function devices

 drivers/pci/pci.h                  |  1 +
 drivers/pci/pcie/bw_notification.c | 23 +++++++++++++++++------
 drivers/pci/probe.c                |  2 +-
 3 files changed, 19 insertions(+), 7 deletions(-)
