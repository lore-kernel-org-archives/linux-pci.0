Return-Path: <SRS0=MTzy=AO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2086C433DF
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jul 2020 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8527A20885
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jul 2020 21:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lQLHxfj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCVWF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jul 2020 17:22:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796FAC061794;
        Fri,  3 Jul 2020 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3N7+rEsvhZ0/1slbtG/J0cqn2Iy82zxYxLJ7OUqBr8I=; b=lQLHxfj/scwEk8R5WwanTZaQch
        NG8ISCU/y1iv6bx0Xj4Kyx/+cypN5CZJBHzCc/q+l9AIK7WzBu6Zs811Mp6X4DE5JOLAaq8IW0BJe
        14IhYjJZrw+h4TuxRsHdbQTe6TBS0ffE2N1HcL2njI8cLYH2O4pgNtTmfXjD4utFWS5muaXx4hpTd
        hrxH9vcudFYVhd6hfxEl8rGFvJgclLu5/bneWTyNdd/Te1KNTZHLStODY6LFYWCG2JNw7/1PvRwIK
        J/AgmOYcsKwy+5u79rYgyvHRgJbUOwY3m9akIady4G34ihiq2cDqDuG/hWg1l+vVBwuKF/WY4n39w
        /kmp5mew==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrT8D-0005tj-I7; Fri, 03 Jul 2020 21:22:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 0/4] Documentation: PCI: eliminate doubled words
Date:   Fri,  3 Jul 2020 14:21:52 -0700
Message-Id: <20200703212156.30453-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix doubled (duplicated) words in Documentation/PCI/.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org
Cc: Linas Vepstas <linasvepstas@gmail.com>

 Documentation/PCI/endpoint/pci-endpoint-cfs.rst |    2 +-
 Documentation/PCI/endpoint/pci-endpoint.rst     |    2 +-
 Documentation/PCI/pci-error-recovery.rst        |    2 +-
 Documentation/PCI/pci.rst                       |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
