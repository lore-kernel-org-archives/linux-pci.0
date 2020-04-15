Return-Path: <SRS0=Fxx+=57=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45486C2BB1D
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBDC20784
	for <linux-pci@archiver.kernel.org>; Wed, 15 Apr 2020 00:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586909588;
	bh=Uy34z7wNWCDG+KW1g5dBujLdhx7TVAVPtvpyIcZ8Bsg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AzYaZvMkVuxfoIpv1L+mkZau9R+sZn8t8hOl0fyn6YApD6Ov865lQum9ZVBRV2H1X
	 jLj5wurLkI9zSYE7xV6AKJ2tv+SLFDYr+/syrrmj0zEIw7JWOtQHhrlB4n5UgeYVP2
	 MWWyU+2xFCSbYyIOfZ6UFJRoCj6cN0lpoTxu/7SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392301AbgDOANH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392299AbgDOAND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:13:03 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113A020784;
        Wed, 15 Apr 2020 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909583;
        bh=Uy34z7wNWCDG+KW1g5dBujLdhx7TVAVPtvpyIcZ8Bsg=;
        h=From:To:Cc:Subject:Date:From;
        b=MqNkjBjPE/BhBsP4fHKARN231nhcJ5f0o2xl49ghBYccnQxblfGjBw6OvUfS3T76a
         dLIRsmAC1c5O9Dc0WeQ1NdGxD+OrAbnnr1jmK2MVRVSNAruhiKChyIAIN50TG14ljH
         eWAq6JwSqgHQlTwpIkfc1f3qcjx+EotH7D3/m/yc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI: Don't select Kconfig symbols by default
Date:   Tue, 14 Apr 2020 19:12:40 -0500
Message-Id: <20200415001244.144623-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

A few Kconfig symbols snuck in with "default y".  In general we don't want
that because we don't want to bloat the kernel with unnecessary drivers.

Remove the ones that are optional.

There are a few left, but they depend on something else that seems like the
real choice, e.g., XEN_PCIDEV_FRONTEND depends on XEN and PCI_XGENE_MSI
depends on PCI_XGENE.

Bjorn Helgaas (4):
  PCI: dra7xx: Don't select CONFIG_PCI_DRA7XX_HOST by default
  PCI: keystone: Don't select CONFIG_PCI_KEYSTONE_HOST by default
  PCI/AER: Don't select CONFIG_PCIEAER by default
  PCI/ASPM: Don't select CONFIG_PCIEASPM by default

 drivers/pci/controller/dwc/Kconfig | 2 --
 drivers/pci/pcie/Kconfig           | 2 --
 2 files changed, 4 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog

