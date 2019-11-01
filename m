Return-Path: <SRS0=mg7z=YZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0024BCA9ECF
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8321906
	for <linux-pci@archiver.kernel.org>; Fri,  1 Nov 2019 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572641205;
	bh=R7go2cekJOh0q8Qziha8jZKepmAyBufTxO3bA4KzDBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jIBSsX1Cp17xJltIbGQEckhuSlwy5kjVVUExGqREacGMZ/UJEN8aJhTlms2DMXbxP
	 03LpClv8UmnJUnqtsToftorMwibfRAAmdi8LomGoyRvv6icPGRgr5jXHVKWURp7gPl
	 tVT4OAxGDqNZPp+zwRGadBdxf74P5t8s3DYvbBzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKAUqp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfKAUqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 16:46:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04D48217D9;
        Fri,  1 Nov 2019 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572641204;
        bh=R7go2cekJOh0q8Qziha8jZKepmAyBufTxO3bA4KzDBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTjQcIJm4BZf9SrqjFqlgY6f3rfgm/eMIyQkURGUWR+0YjoZwAPb7VCYFsTV4OqgF
         aBpcAKxgigcSSr5eVKyRF93tONOrjR+HuzLjGu336YGCuo4FQJg2jbFzYd+agNkBAA
         xtLWRJB/V+NqGkse2arjLppp2A3hJfK1DkpFB+Cc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/6] PCI/PM: Simplify pci_set_power_state()
Date:   Fri,  1 Nov 2019 15:45:55 -0500
Message-Id: <20191101204558.210235-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191101204558.210235-1-helgaas@kernel.org>
References: <20191101204558.210235-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Check for the PCI_DEV_FLAGS_NO_D3 quirk early, before calling
__pci_start_power_transition().  This way all the cases where we don't need
to do anything at all are checked up front.

This doesn't fix anything because if the caller requested D3hot or D3cold,
__pci_start_power_transition() is a no-op.  But calling it is pointless and
makes the code harder to analyze.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a9d3653ef960..281bc8fc51b3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1130,8 +1130,6 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (dev->current_state == state)
 		return 0;
 
-	__pci_start_power_transition(dev, state);
-
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
 	 * D3
@@ -1139,6 +1137,8 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
 		return 0;
 
+	__pci_start_power_transition(dev, state);
+
 	/*
 	 * To put device in D3cold, we put device into D3hot in native
 	 * way, then put device into D3cold with platform ops
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

