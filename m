Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BB1C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC65F21873
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCTLNC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:13:02 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:55115 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfCTLNC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 07:13:02 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 07:13:01 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id D54AA101E6952;
        Wed, 20 Mar 2019 12:05:35 +0100 (CET)
Received: from localhost (p5491779F.dip0.t-ipconnect.de [84.145.119.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 71BD96233613;
        Wed, 20 Mar 2019 12:05:35 +0100 (CET)
X-Mailbox-Line: From 70cb1754e3f0da3b84712460b1017ac707cd2616 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1553078908.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 20 Mar 2019 12:05:30 +0100
Subject: [PATCH 0/2] Link bandwidth notification fixes
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@Dell.com>, Sinan Kaya <okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These two small patches fix issues that showed up on my laptop when
testing the new bandwidth notification port service.  It may be worth
applying them to 5.1 still.

They're intended to be applied on top of Alexandru's patch "Do not leave
interrupt handler NULL" (or an updated version thereof which moves the
call to pcie_update_link_speed() to pcie_bw_notification_irq() per my
suggestion).

Thanks,

Lukas

Lukas Wunner (2):
  PCI/LINK: bw_notification: Clear interrupt before enabling it
  PCI/LINK: bw_notification: Deduplicate reports for multi-function
    devices

 drivers/pci/pci.h                  | 1 +
 drivers/pci/pcie/bw_notification.c | 4 +++-
 drivers/pci/probe.c                | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.20.1

