Return-Path: <SRS0=mHad=7K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B77C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD832084C
	for <linux-pci@archiver.kernel.org>; Thu, 28 May 2020 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590676329;
	bh=akyLuHeiAlZIZHfR0soky+wL6Do/cboTPXXRrmLbVcM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EvIMubEcBvYVdtq9z6GwB2ATOxViamLHZjVUQalQZOWq8PaAL9g7h6HJ4gqiUk4m+
	 a6jUpGusC0QLzKFMB0oXQkO5q4cJAYK2zuJRg77qKWSOIqzx85MxV/JG5z0lERIQ8N
	 Db5CPm1/hAW+MrMbdlZJt2lOcfzYFpqaWMCImzIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbgE1OcJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 May 2020 10:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391060AbgE1OcI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 10:32:08 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F098207D3;
        Thu, 28 May 2020 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590676328;
        bh=akyLuHeiAlZIZHfR0soky+wL6Do/cboTPXXRrmLbVcM=;
        h=From:To:Cc:Subject:Date:From;
        b=d2K+pAeTDZ5RpezmH6ZH/G46972OO1eS9ejtgl4eRc+z7CDanFwXHD1jvVuStpsI5
         fwr7nmGoeDP3rq4Ie9BtO8Gr19T8OYE3cDJ41T8Iz8Mgrg0s9egdszpU5+1TEu6Rgk
         rRysRM5YScuyL1XYDRPU9YQDjqjugHwQLtkIgmaI=
Received: by pali.im (Postfix)
        id 8BC2B865; Thu, 28 May 2020 16:32:05 +0200 (CEST)
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
Subject: [PATCH] PCI: aardvark: Don't touch PCIe registers if no card connected
Date:   Thu, 28 May 2020 16:31:41 +0200
Message-Id: <20200528143141.29956-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..53a4cfd7d377 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -644,6 +644,9 @@ static bool advk_pcie_valid_device(struct advk_pcie *pcie, struct pci_bus *bus,
 	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return false;
 
+	if (bus->number != pcie->root_bus_nr && !advk_pcie_link_up(pcie))
+		return false;
+
 	return true;
 }
 
-- 
2.20.1

