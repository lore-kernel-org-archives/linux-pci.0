Return-Path: <SRS0=404H=AN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DEFC433E0
	for <linux-pci@archiver.kernel.org>; Thu,  2 Jul 2020 08:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8093120720
	for <linux-pci@archiver.kernel.org>; Thu,  2 Jul 2020 08:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593678686;
	bh=QGpdAyRMoNsVdtVoCbNXP1VWmICFLyANXqWYO+rUTTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YbgISxFzQjlm0RT/+4sidqZWNxVh+go4X2Pn6JB4m58/lXRBIsaNcAeHtn561Cikp
	 YWf+YYjCAw6VcZyV4uYrLe/X1xWHKhIKIx8J19AzotEiFAs8hTpYVxmRvcanf/GALc
	 fCMWqNNMc0CQRTmripNyEymV0mpaBET3iQRbkIe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgGBIbZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgGBIbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Jul 2020 04:31:25 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08AE8206A1;
        Thu,  2 Jul 2020 08:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593678685;
        bh=QGpdAyRMoNsVdtVoCbNXP1VWmICFLyANXqWYO+rUTTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1epipgTDmBHHxSLs1kheGHs/9TjzD4Pzu+GyUKLJ143corYoaQnOjaV6M4AZG8Cl
         yaZqpViNj9UGoHkMZv/XMoDNCfiECTq00dmdP1Qkv3FUTuZgvkP26Ki5JBNnQbBpYT
         hGB4gfDrBgh7bdE3oezH9cl61u67W2SDkluwi/4g=
Received: by pali.im (Postfix)
        id 2A905E92; Thu,  2 Jul 2020 10:31:23 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: aardvark: Don't touch PCIe registers if no card connected
Date:   Thu,  2 Jul 2020 10:30:36 +0200
Message-Id: <20200702083036.12230-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200528143141.29956-1-pali@kernel.org>
References: <20200528143141.29956-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When there is no PCIe card connected and advk_pcie_rd_conf() or
advk_pcie_wr_conf() is called for PCI bus which doesn't belong to emulated
root bridge, the aardvark driver throws the following error message:

  advk-pcie d0070000.pcie: config read/write timed out

Obviously accessing PCIe registers of disconnected card is not possible.

Extend check in advk_pcie_valid_device() function for validating
availability of PCIe bus. If PCIe link is down, then the device is marked
as Not Found and the driver does not try to access these registers.

This is just an optimization to prevent accessing PCIe registers when card
is disconnected. Trying to access PCIe registers of disconnected card does
not cause any crash, kernel just needs to wait for a timeout. So if card
disappear immediately after checking for PCIe link (before accessing PCIe
registers), it does not cause any problems.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in V3:
* Add comment to the code
Changes in V2:
* Update commit message, mention that this is optimization
---
 drivers/pci/controller/pci-aardvark.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..d18f389b36a1 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -644,6 +644,13 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return false;
 
+	/*
+	 * If the link goes down after we check for link-up, nothing bad
+	 * happens but the config access times out.
+	 */
+	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
+		return false;
+
 	return true;
 }
 
-- 
2.20.1

