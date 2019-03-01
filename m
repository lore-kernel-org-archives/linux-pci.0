Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9AC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1823E20857
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 16:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxHMdqT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfCAQy0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:54:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54788 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfCAQy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 11:54:26 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so21120020itj.4;
        Fri, 01 Mar 2019 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2KcJGV77RJkPHn6Gh3n3ZC/r1453gshL8IPzbrQv7Y=;
        b=HxHMdqT3u7T5SaJq7CT8b51L2PnORaojHVmNu7lM83xVs75k5RW2aBL0nQ2Mpd5q+Q
         QGKzQX8Eeg8M4v+KwRqgt5aQp77uLlUMVsDYUb8xjtNV8fwFAd990ccpSNcGEcC/BZv/
         1FVjTrkmr9Gol5KPFTJvxhAJUeLKQgifZsgP5pmA07Iw4Sj/yR08yJ/znQQ29sZCQzB9
         ZWnT3+D1Fj/H8ICbAw4MnN3zNzDnGgiWFv21HVLfvWQPIJno+rwgYkTtCZ2tHzzc/PcE
         fqu+qh/I2xILzzSAUNjR+nEJid5Z7xy8XCYfQxNGJO3FonANyI7CD7N9cXZmPsVnGVR8
         Uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2KcJGV77RJkPHn6Gh3n3ZC/r1453gshL8IPzbrQv7Y=;
        b=gAWwA7gRof6f50FK7PKFqTFTnG8PDrcYhMat0gS9nMVSJx7SE9toAzju1fnQsrynZ2
         UFqtdpOmd+d7jmntNgOE7aJuBL5iFF3lLlVQh3FDXevRNz7sKngWCxVuM5HaPjO1bV5S
         2yq4gnjw5utc0jFenivsu56tOVs8KC48vtyjYXV1cw3on1dDHSY/ec0qLMZctxZATGrU
         /t1wl/d1Ir++QoFkZwTOltutOK/oOd3dirizYk9qG+PdiiunWOiDUeaZ0Jn1nD10oDdk
         hGEAX2S0aDB6FEmOGYLran7HPEqfLriHvNLXw/SMcDvLhuE2TdRMAQADtiTgyMWJ3S48
         0lvg==
X-Gm-Message-State: APjAAAWfvcXyUb/JYSl2pTtXMi1rALqX42wg+FvL3Nzldfbb2pMeUr6n
        /W3WpbiX7f6oP0hq2U8ppgU=
X-Google-Smtp-Source: APXvYqwqhgv0+qEIKdTH8qTF2ZR1GFGUvuw2KsajevY79c4kUBa2L2kiK9hNAP9XS0YSnbIJuZoodg==
X-Received: by 2002:a24:6ec1:: with SMTP id w184mr3764480itc.113.1551459265291;
        Fri, 01 Mar 2019 08:54:25 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id k4sm8234822ioj.33.2019.03.01.08.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:54:24 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] PCIE/PME: fix possible use-after-free on remove
Date:   Fri,  1 Mar 2019 11:54:19 -0500
Message-Id: <20190301165419.16493-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In remove(), ensure that the pme work cannot run after kfree()
is called. Otherwise, this could result in a use-after-free.

This issue was detected with the help of Coccinelle.

Cc: Sinan Kaya <okaya@kernel.org>
Cc: Frederick Lawler <fred@fredlawl.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/pci/pcie/pme.c | 1 +
 1 file changed, 1 insertion(+)

v2:
	rebased against Bjorn Helgaas's pcm/pm branch at
	git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index efa5b552914b..54d593d10396 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -437,6 +437,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
 
 	pcie_pme_disable_interrupt(srv->port, data);
 	free_irq(srv->irq, srv);
+	cancel_work_sync(&data->work);
 	kfree(data);
 }
 
-- 
2.17.1

