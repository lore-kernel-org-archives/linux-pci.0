Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BABC636C9
	for <linux-pci@archiver.kernel.org>; Thu, 15 Jul 2021 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C64F61289
	for <linux-pci@archiver.kernel.org>; Thu, 15 Jul 2021 22:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhGOWDN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Jul 2021 18:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhGOWDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8C706117A;
        Thu, 15 Jul 2021 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386415;
        bh=VUyVyFpC1GhZ1oTojiMVCfJ51v4Scqb1UgexiQO2eqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo+O7sF/JuPIvfZZr6FZigvTFJ20HZCid/8TkyIdk03wkOo/A4ZARV9H67FicBJg/
         W3B6JvOr1UJF0OaYJifXCQFDoTLpmbg0npQbuZa7VJiSXf4Ly3Wfa2oOgnyKYsxham
         z6CURXh72qCm4BnBwKbiPyxEGbgdzeKy9DBh6C8ESNqL2nXV0UA4dm4A1pvJo/unI7
         natCIzZ8DaCuILm2axUo0FLFrFXihM/O92lPXTfucqb2NJTYDC8MYmwsetES++r/dH
         v9JyNwqUffvCq7xMkbtaV4/3YdhTyh+oGN2/zrXO1o0bAyUvys4E3b8n44/O2SIygT
         a2jrdH4cM+jSQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] PCI/VPD: Correct diagnostic for VPD read failure
Date:   Thu, 15 Jul 2021 16:59:55 -0500
Message-Id: <20210715215959.2014576-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715215959.2014576-1-helgaas@kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
 <20210715215959.2014576-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously, when a VPD read failed, we warned about an "invalid large
VPD tag".  Warn about the VPD read failure instead.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 26bf7c877de5..7bfb8fc4251b 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -92,8 +92,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 			    (tag == PCI_VPD_LTIN_RW_DATA)) {
 				if (pci_read_vpd(dev, off+1, 2,
 						 &header[1]) != 2) {
-					pci_warn(dev, "invalid large VPD tag %02x size at offset %zu",
-						 tag, off + 1);
+					pci_warn(dev, "failed VPD read at offset %zu",
+						 off + 1);
 					return 0;
 				}
 				off += PCI_VPD_LRDT_TAG_SIZE +
-- 
2.25.1

