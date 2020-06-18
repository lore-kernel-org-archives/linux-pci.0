Return-Path: <SRS0=agHd=77=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186ADC433DF
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2ADA221ED
	for <linux-pci@archiver.kernel.org>; Thu, 18 Jun 2020 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443162;
	bh=COgDednjpZf6sWQLysDO7YXN00Jr1Nsdc0UeTybDPpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybmHxUyj/ARUv5lgCKLA3EA68eCVc5DsouuI9VYOOmn4iaQV7uTchsCi/N7sAir/I
	 tm3+24j8L9RHlbeG/2pHqb5biy+Y3W2DdhbnVPengHfk9gPd2Whcfmk0VNTQKKI2eF
	 zRNWNKNmH+Vda+G8N4e8C2RaBC5QWld9JzIUtWTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgFRBTU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbgFRBTT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E569321D94;
        Thu, 18 Jun 2020 01:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443158;
        bh=COgDednjpZf6sWQLysDO7YXN00Jr1Nsdc0UeTybDPpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zc2pwAGP/aVaUx5TWjPqShfOb9JZHdHQYKoSerFsGC754tnCyxoK1xIyTuNzqZw+X
         V1iJ7Ni2e7+fYPmxEXXmjLdQmp0sZ4ennYhITeE4cOeHphzT0aw5Qn9i1pBIam+bSR
         2fme7Svm2Grpr+1msvbDF0o0MyfI7v/GDP3lmQus=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 125/266] PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
Date:   Wed, 17 Jun 2020 21:14:10 -0400
Message-Id: <20200618011631.604574-125-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 66ff14e59e8a30690755b08bc3042359703fb07a ]

7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
Linux to enable ASPM, but for some undocumented reason, it didn't enable
ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.

Remove this exclusion so we can enable ASPM on these links.

The Dell OptiPlex 7080 mentioned in the bugzilla has a TI XIO2001
PCIe-to-PCI Bridge.  Enabling ASPM on the link leading to it allows the
Intel SoC to enter deeper Package C-states, which is a significant power
savings.

[bhelgaas: commit log]
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
Link: https://lore.kernel.org/r/20200505173423.26968-1-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5a1bbf2cb7e9..4a0ec34062d6 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -628,16 +628,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
-	/*
-	 * If the downstream component has pci bridge function, don't
-	 * do ASPM for now.
-	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
-			link->aspm_disable = ASPM_STATE_ALL;
-			break;
-		}
-	}
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-- 
2.25.1

