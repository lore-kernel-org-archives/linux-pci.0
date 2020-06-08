Return-Path: <SRS0=HJ7y=7V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E53C433DF
	for <linux-pci@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED7D20659
	for <linux-pci@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660397;
	bh=6ZTilro9TUJ7Kc4+PNa3OIDDZnDEfHbZlo9JY75x6is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H25ZirFtKz6rPjNkKTWOGy8CsU76vyH0H5Bmh7np6pIS4hYuYsohWj08Vuo10pbeb
	 vjJoe3LxPEcdxrKetrgo0IvX7dnuRrHVOeW1wUz+15dKMXdXsxF5XAJEBObtUkHeCB
	 Wgxwxp1ZMbMcOXU0DB9Q7Wz/nNbhmUVsOHrit4vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgFHXxD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387521AbgFHXYi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1AB20C09;
        Mon,  8 Jun 2020 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658678;
        bh=6ZTilro9TUJ7Kc4+PNa3OIDDZnDEfHbZlo9JY75x6is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIBbToXDfejv5qy2GADz734o5pZZDY9p/u+qovXNd9nNw84vced7t0OVVppELUvtm
         CD4ljXkWKouEdCLyjaCJFz7h17i4Ajj10DQq6wkyPjKFtFrtVPMHP9ESSw2CCRcg9Y
         kCDKNWpAuN1+gOTcnAhBsZzTHRRHzhpC3yPnTZB8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 089/106] PCI: Don't disable decoding when mmio_always_on is set
Date:   Mon,  8 Jun 2020 19:22:21 -0400
Message-Id: <20200608232238.3368589-89-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit b6caa1d8c80cb71b6162cb1f1ec13aa655026c9f ]

Don't disable MEM/IO decoding when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fa4c386c8cd8..a21c04d8a40b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1634,7 +1634,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.25.1

