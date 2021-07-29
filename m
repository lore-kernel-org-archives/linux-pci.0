Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3585CC4320A
	for <linux-pci@archiver.kernel.org>; Thu, 29 Jul 2021 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1205961019
	for <linux-pci@archiver.kernel.org>; Thu, 29 Jul 2021 18:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhG2Smv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Jul 2021 14:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhG2Smv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B091860FE7;
        Thu, 29 Jul 2021 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584168;
        bh=wgMnDar7z06DT1D6H2XVzvIVMOM4sIg6YdnekTrArWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVUCzByFOF/La8Y95HYMTqkFXqpdkv6fkPkcVUfrpZFl5PJtWgiTozXJGH5t5QHqr
         +7utPzpHsPa6AqyXOH19LUbFl+5avFwMboLtgPEC6VwaonBcO1WFtvlQgX4vY8N59m
         TDiThUFJJfXFWiZOcXwm81loyycdN3uniPj0kPJEKeN0t1sRJk7liVWreLSt+vJiXh
         Cd2T7jvZOxWw0sNy1OxaxNY7cPJmOdwWQDvZDfpDazcInLQ7UAOjXMJfu+4TNMowgR
         C+r/603peCWoVwR4dwGu11EkLvnMXsHvfGPrCXhdp5RHB7fzoXXCSd42UAKOb3r4ig
         wv9IvgYjOLqAg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 5/6] PCI/VPD: Don't check Large Resource Item Names for validity
Date:   Thu, 29 Jul 2021 13:42:33 -0500
Message-Id: <20210729184234.976924-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

VPD consists of a series of Small and Large Resources.  Computing the size
of VPD requires only the length of each, which is specified in the generic
tag of each resource.  We only expect to see ID_STRING, RO_DATA, and
RW_DATA in VPD, but it's not a problem if it contains other resource types
because all we care about is the size.

Drop the validity checking of Large Resource items.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/pci/vpd.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index e52382050e3e..6fa09e969d6e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -85,26 +85,11 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			tag = pci_vpd_lrdt_tag(header);
-			/* Only read length from known tag items */
-			if ((tag == PCI_VPD_LTIN_ID_STRING) ||
-			    (tag == PCI_VPD_LTIN_RO_DATA) ||
-			    (tag == PCI_VPD_LTIN_RW_DATA)) {
-				if (pci_read_vpd(dev, off+1, 2,
-						 &header[1]) != 2) {
-					pci_warn(dev, "failed VPD read at offset %zu",
-						 off + 1);
-					return 0;
-				}
-				size = pci_vpd_lrdt_size(header);
-				if (off + size > PCI_VPD_MAX_SIZE)
-					goto error;
+			size = pci_vpd_lrdt_size(header);
+			if (off + size > PCI_VPD_MAX_SIZE)
+				goto error;
 
-				off += PCI_VPD_LRDT_TAG_SIZE + size;
-			} else {
-				pci_warn(dev, "invalid large VPD tag %02x at offset %zu",
-					 tag, off);
-				return 0;
-			}
+			off += PCI_VPD_LRDT_TAG_SIZE + size;
 		} else {
 			/* Short Resource Data Type Tag */
 			tag = pci_vpd_srdt_tag(header);
-- 
2.25.1

