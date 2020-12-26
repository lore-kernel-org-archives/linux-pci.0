Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280D3C433DB
	for <linux-pci@archiver.kernel.org>; Sat, 26 Dec 2020 04:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA606221EA
	for <linux-pci@archiver.kernel.org>; Sat, 26 Dec 2020 04:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLZELq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Dec 2020 23:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgLZELq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Dec 2020 23:11:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EF9C20731;
        Sat, 26 Dec 2020 04:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608955865;
        bh=UjAEsej29uKjCMP2ttbvgpHXBp6G5qKH/cHn9U38o6s=;
        h=Date:From:To:Cc:Subject:From;
        b=YqVosQ45SwGYIRDnDO0RmClCZy/UnyJfGR/zdqoOElHJYBTECInTl1f464hAmGJnt
         UMbUbIva0NzTQTkza3c+SBnfZC236+3hGK6Gox3Oc1gI9QJg0auyQS7YSzELBhJgC2
         K6OBUggQjnA9Mt3PfGIpvFwe0TgR7lVmVFBD55vIG801AcBhDZXKzmXFO6lmd7pVyw
         TBgRyduxiCxdqwIKUZiflNi0j4/AcDEIojydGzukk/dB8rV4OOSvf+SkE+6iukBYZm
         hTwbaGQm8VYNoqS8TZgG7NMk5xOyoA2zDww3l6db/FhmtQH4ZOfvwPahHUrr//KqkO
         CoqH70tYcltnw==
Date:   Fri, 25 Dec 2020 22:11:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [GIT PULL] PCI fixes for v5.11
Message-ID: <20201226041103.GA469463@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 255b2d524884e4ec60333131aa0ca0ef19826dc2:

  Merge branch 'remotes/lorenzo/pci/misc' (2020-12-15 15:11:14 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.11-fixes-1

for you to fetch changes up to 99e629f14b471d852d28ecf554093c4730ed0927:

  PCI: dwc: Fix inverted condition of DMA mask setup warning (2020-12-25 21:58:42 -0600)

----------------------------------------------------------------
PCI fixes:

  - Fix a tegra enumeration regression (Rob Herring)

  - Fix a designware-host check that warned on *success*, not failure
    (Alexander Lobakin)

----------------------------------------------------------------
Alexander Lobakin (1):
      PCI: dwc: Fix inverted condition of DMA mask setup warning

Rob Herring (1):
      PCI: tegra: Fix host link initialization

 drivers/pci/controller/dwc/pcie-designware-host.c |  8 +---
 drivers/pci/controller/dwc/pcie-tegra194.c        | 55 ++++++++++++-----------
 2 files changed, 31 insertions(+), 32 deletions(-)
