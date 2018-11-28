Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A87C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D1A2081C
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 22:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix8j8D8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D1A2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeK2Jb3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:31:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44476 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeK2Jb3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 04:31:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so12399507oig.11;
        Wed, 28 Nov 2018 14:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CA5R2uOTiCP82fw7b7krqe/pA+fj/N+hG4Zg4SgyYns=;
        b=ix8j8D8UssozGlxl/9SIy2rDa43Kaiut/c+xm9qELu+Y2OCJcBLu+606VvsKVZsPtx
         RW5iwn2uQks+h2x2iB9HdsgFM99HAiZVSegNQ0A3PDMYsG0gA1/qqwCNMg1BxSfTE71X
         i4O7oUVWnhMRo0FvjufLy4WhenozOZ3L4JLlQX9PxLj1kjtxK5eIoizm1/dzlVWsyz7z
         kNCQ3ikqnlwEQ0ochx+3b51fv3bvhTG41cZdr43t4Y9hgI2MjJ7+tYDc1IMGVwKHUY96
         jok1yKRLbFvYfGYUvyWoENAqgsPMwCFOAbD/smxihIcB92i0L+oWWT/4DmKukiYJGhV8
         vPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CA5R2uOTiCP82fw7b7krqe/pA+fj/N+hG4Zg4SgyYns=;
        b=fRwzwti7VSqRucDh0lXAxHSfcDdAwCBmPqrsatteFxZZ5R4Ab/gb+Zc8RgiE2vopO0
         MwK3v03TPCUJXRwfnuPYJcsSLFCERejvEj9DPfkr2ezMeT8KZWGH38Lp3oulLkhwNaG1
         b743uIOOAzaLEigCfSOonFcdBZ3wK53JMK6qppwJ1YDaBnDzO38kZmkLWPW1xf/QUVsb
         DaR5GYYR8Fhe+hI88mhixAxvcPMRx60u19ynXHvzznEWDUT7/VhnY7RBUz/KOAv8ckpX
         vIDGfKEryZrz9yKP7ENEBnVofQOFDS18HwElGNrQ2cA1dhWxrKhMnoRTjxzVTxi0xYXM
         U2qw==
X-Gm-Message-State: AA+aEWbTq+jqksOk7az2XW/eqCu8Tn4H6/pHfyBvBwVs6iP9ucGT3Hs6
        8lhCpHfgWestf2tLkLfQgk4=
X-Google-Smtp-Source: AFSGD/XTQfYhKijlKZHtKYCFb/t2K4gBD8StCfYnWo4PUt5j+OXo/19jz3zdqfbQyfebqbcc0zt+OQ==
X-Received: by 2002:aca:df02:: with SMTP id w2mr11859475oig.77.1543444099198;
        Wed, 28 Nov 2018 14:28:19 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id 18sm3012302otf.59.2018.11.28.14.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 14:28:18 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add missing include to drivers/pci.h
Date:   Wed, 28 Nov 2018 16:28:04 -0600
Message-Id: <20181128222805.12637-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This files makes use of definitions provided in <linux/pci.h>. This
only compiles when <linux/pci.h> is included beforehand, and creates
a nasty include dependency. Instead, just include the correct file.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 662b7457db23..224d88634115 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -2,6 +2,8 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
+#include <linux/pci.h>
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
-- 
2.17.1

