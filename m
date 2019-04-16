Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5020C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914A6206B6
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9v02rf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDPQnz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:43:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfDPQny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 12:43:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so19724781ljg.6;
        Tue, 16 Apr 2019 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kxhZI72O2uEheaMFBC4WTcf0MuEBIJIBz8pHbTuLBN0=;
        b=O9v02rf3JXwhjdt+FYB8UV1cqhGKGnLVZYvcSLjSVv/jYovYQE0A+StvSkUOoKi/P5
         THLEpJ2csktQ9qWXNGfXvUaExG+A+5JA45UkTS3ym2lMn2ho+CN30f64S0rFcZNF0Ex1
         d6Ff0qb40Fffxg8iWpqTJiTxUAo4+JXj2bDmj1v60E6grfVMJ4K4FqLtmk+Fin7lGc5a
         P6K3ikfq9vMriYtsciaRC4EqmzhmEVklj/vmvcF/864/fP88w9NTqPs1wlwzlgks4sqI
         ImOx9+YuRzB7v3oXTRrS7htOHAA7VMyZIXf25YbMcsIsNJLgxmbwmPqNf/+wSRwSIM/i
         f0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kxhZI72O2uEheaMFBC4WTcf0MuEBIJIBz8pHbTuLBN0=;
        b=tG0OhBVJcZjOnqMQDRlmnqF1ir1k8cWd8IiGrdBH9v1tOTMEw4feV3rnU5DegOrvjt
         +4e/pSC6hv8u9usxry9RJJbHMxSG83Os1ugKnP18b8cVdxi0c7pKMT1d17ZA15ZKp3bz
         i17yv8/Og6rHTvwi9pAMvY2dYYeM1Pnu9ZXMIvvYVcQztemGyLd3Y6d7hki2YvvXa3e2
         t0P41sxY3FQjv9FsUF7Bu7g0p1hXOygxWyCZkKgydLWh0s6894WYYmyL9OlrX7nYX9YQ
         nUovZMQ2WgOuTFWs+lOLFwdRDyFloO9V/g1InyIEKFtpPgp7jIiMWXIXsOjN+HNe/D1Y
         S32g==
X-Gm-Message-State: APjAAAXrtKgjpL6Kc0qY6JEULctYmMjhrwNnR9gmQSXaJDiY/fOXlcrs
        yKAgosUkGx2pGXofOASyJZv7dt8seTY=
X-Google-Smtp-Source: APXvYqygJvWXESMy43UKmYTGOYh5ih/RmsKByJTaLWh8+V6WTsXeW/IA+oKpLMpZrG+LQOGIU9NSIQ==
X-Received: by 2002:a2e:3204:: with SMTP id y4mr12703989ljy.90.1555433032512;
        Tue, 16 Apr 2019 09:43:52 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id d22sm4058450lfm.57.2019.04.16.09.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 09:43:51 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pci: This patch fix the following checkpatch warning.
Date:   Tue, 16 Apr 2019 19:43:40 +0300
Message-Id: <1555433020-3830-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pr_err instead of printk

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2..2179a8b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -23,7 +23,7 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 
 	entry = resource_list_create_entry(res, 0);
 	if (!entry) {
-		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
+		pr_err("PCI: can't add host bridge window %pR\n", res);
 		return;
 	}
 
-- 
2.7.4

