Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF5C2BC61
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2F52081B
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 16:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2F52081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeJaBaU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeJaBaU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Oct 2018 21:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D3A4308421A;
        Tue, 30 Oct 2018 16:36:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D810F2AAA9;
        Tue, 30 Oct 2018 16:36:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w9UGa87E023939;
        Tue, 30 Oct 2018 12:36:08 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w9UGa8Tx023935;
        Tue, 30 Oct 2018 12:36:08 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 Oct 2018 12:36:08 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tal Gilboa <talgi@mellanox.com>
cc:     Tariq Toukan <tariqt@mellanox.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
Message-ID: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Oct 2018 16:36:09 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
the register and compare it against them.

This patch fixes errors "amdgpu: [powerplay] failed to send message 261
ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
the slot is being incorrectly reported as PCIe-v3 capable.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
Cc: stable@vger.kernel.org	# v4.17+

---
 drivers/pci/pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-4.19/drivers/pci/pci.c
===================================================================
--- linux-4.19.orig/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
+++ linux-4.19/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
@@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
 
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 	if (lnkcap) {
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
+		if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
 			return PCIE_SPEED_16_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
+		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
 			return PCIE_SPEED_8_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
 			return PCIE_SPEED_5_0GT;
-		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
 			return PCIE_SPEED_2_5GT;
 	}
 
