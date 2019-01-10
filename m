Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53583C43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 21:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B821213F2
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547155894;
	bh=UosNmrR5QIxWfpcE8QQUXjOOm8vPR5a0dT3ricU7TvE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OE9VdMTZUD0ZnasnqCuDL8WNj9/LaQDlSOm7c87Enf6naq1bT7ZtiD3WteNuX9oBo
	 MwhRgnTQF0fMGkEp2Lqb+amkS9vFAVPfNtpwoT3Xcwm0QIZAsyCjuTMp2xP+ORTa2m
	 Tb+e4UzRmB+gXgqrYvdb1iINHu7urn+xtDiXTyEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfAJVbd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfAJVbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 16:31:33 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B7A920652;
        Thu, 10 Jan 2019 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547155892;
        bh=UosNmrR5QIxWfpcE8QQUXjOOm8vPR5a0dT3ricU7TvE=;
        h=Date:From:To:Cc:Subject:From;
        b=MREBCYflO32gjAqS+4aqbS/DMDlJDhsw2E+aJENDhKbIhDixRHrFj1KScGiK7d2Pe
         gzn9aPqRlxN2vXT9piGIGMUWA8YRoPc7QRkHP24hVA5xVtcr0E6jvC9wU0bVx9GaTp
         hN4OxRtnqhN7Z3q37UvmwPm3POdNNJcw+IWFz5+Q=
Date:   Thu, 10 Jan 2019 15:31:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [GIT PULL] PCI fixes for v5.0
Message-ID: <20190110213131.GA86782@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix Amlogic Meson host controller driver build failure (Corentin Labbe)


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-1

for you to fetch changes up to a3869d43c9800cf39496615361c83635fa3e7c82:

  PCI: amlogic: Fix build failure due to missing gpio header (2019-01-08 09:01:44 -0600)

----------------------------------------------------------------
pci-v5.0-fixes-1

----------------------------------------------------------------
Corentin Labbe (1):
      PCI: amlogic: Fix build failure due to missing gpio header

 drivers/pci/controller/dwc/pci-meson.c | 1 +
 1 file changed, 1 insertion(+)
