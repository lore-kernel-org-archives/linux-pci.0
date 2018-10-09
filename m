Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A6C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3DF214C5
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 11:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="CFOtkKLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3DF214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeJISZg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:25:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43779 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJISZg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 14:25:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so660444pff.10
        for <linux-pci@vger.kernel.org>; Tue, 09 Oct 2018 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iktkOPRJRG/9vk7dBQ/emNVYe1ASjRafz2HXqXPdIy8=;
        b=CFOtkKLBnSWyMkz/7RebblDe2Uvq0rZslwkBaDWMptNNO3YO6DEuKW0Uw45fBqUD+S
         uB1bfDBrFYyRCjtfhX+VtqAShs7f8qdJm3VfttQzrexhyXcjt/k9LfBm5JmGvhqbPBQ/
         aXZUi0TqbltpQPMNouFTn030jsnBnVe811DVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iktkOPRJRG/9vk7dBQ/emNVYe1ASjRafz2HXqXPdIy8=;
        b=pyD9dx95hNWvs/4oKCFp1Gnw0DY5lKJ2WyYPIlDKe/TIEgDyhoHMB2Q1sihQ6rVW+j
         X7VkPEnRrpX0HYZRfj9U8DmxSKT5qBHDPVUdzLcyVzCK0GfJXCARsykr4sbw8Q6jhrWu
         +KIa5m+2hLRkDvonI6i0wX+brc0LABrkZNNmxcgXyMPknStKNZ/aMqOKgaHvl1xcp5BD
         poMXnNasChrUlZO7oKTyOm4QIfDhn568BAfzbzULflVqNENEhIsMOIVuinm6uHbF2vNo
         lXlKaoOHz8IwBCrB+27tFMvgC07Kf0hpIPirTZu0QBKIsKLE1yG5RaFxbmqX+0BD8StO
         oErQ==
X-Gm-Message-State: ABuFfogDbwJWA1okHDx9AHlOAnVwc7nCYEX+LUWwM5k0kqL7+brU5ROR
        GXyGM2tjRyLw/VO3OejU2iNp6Y5ZEC1XXw==
X-Google-Smtp-Source: ACcGV6340r+n3ESv21eCT20SV5nX8CKI1EBBErF5GeZiZ9yksW4z4KCRzZuTvXFU2hhBkyj/Y4iyPg==
X-Received: by 2002:a63:2356:: with SMTP id u22-v6mr16394519pgm.122.1539083350734;
        Tue, 09 Oct 2018 04:09:10 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([106.51.129.105])
        by smtp.gmail.com with ESMTPSA id m15-v6sm47895706pfk.149.2018.10.09.04.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:09:09 -0700 (PDT)
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH] PCI:mobiveil: fix multi function endpoint failures
Date:   Tue,  9 Oct 2018 07:08:45 -0400
Message-Id: <1539083325-7333-1-git-send-email-l.subrahmanya@mobiveil.co.in>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fix enables mobiveil pcie controller to detect more than one
functions per device.

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 drivers/pci/controller/pcie-mobiveil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a939e8d3..9acb81a 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -174,7 +174,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
 		return false;
 
 	return true;
-- 
1.8.3.1

