Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D02C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E62083E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 07:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1s4wtAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDJHpJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:45:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44651 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDJHpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 03:45:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so928854pfm.11
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2019 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gh+Msit8xWwLOKhDqEelaQ2DKbxr4ZEMmqKaQ6Z52Bo=;
        b=T1s4wtAr7nIgGSotbbk9D+Octmd5+lBJS91ChZ6CRe42fn7tyQwWxLqIHmvrpNg6H3
         d/bq8PoWPZ0qbRwrxVmy/hf520DmD9Q5cVLDtU1BJI5FO8ckGfPGbCOEU1hxJfC0x94M
         q2lbyrobVeo39ByBFY08qoGCrf4OhxUwLroOGblPxWWFUZM8Ld2dJRLJJSmP9Dfvpneb
         9HbfTsH01Y/BT3gw6DxbTIZ8LVd5f362d2LFswFPwNCNdN/+MaIuiAdEWz6YIb8Ah7d7
         1MPv8kHnmsGz66ZvjRujD3X1c21kO2Z98/M+2YkeT1ANSICsHS0ZL9URNabARb/VXj1h
         GLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gh+Msit8xWwLOKhDqEelaQ2DKbxr4ZEMmqKaQ6Z52Bo=;
        b=bjoT38EStP6bQvr/uKXdHCZorKzZbCqfThAYBomUVHKfCinUdE5qBz4jc5UxnMOWzt
         TTFt2JdQb+5+DNjeul5E8/ZVRBV4jg7KyFGFgP7w7f11v3lwJkVZ6fcJaWyjRg1S+WkN
         Fl/TMVd4runVBezaXNeLBROuSAnubdzPm2Hjm9aIa1vZwEpE0D4teswEiwPddl+3mXZb
         to1r276opb5siPzF3zOnM3jKlU2+B4EW1HLQtn1IGkCMGAmfx0nUnw2EL9o2ZeYNWXZC
         yMB1d8pFfsY6XUb1oaNiFl/5s4gFwOWqY59mKCarq9Nw2gnqkkFoL0rmzUssR/W4j1v/
         jR+g==
X-Gm-Message-State: APjAAAU3/ch0aycfpI1TCzSbOmwdR3BoOkRdIYZtKEaFFz0sdWe+sNBO
        q0+bDwShZyMxOqFc9KyzpwBNeQHe
X-Google-Smtp-Source: APXvYqwawJvfodIMY7O0B/4K0t42e39JhgGWdERJoM52QYjKsRH8toVbclFHHptBTimnt3YpTErO6Q==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr38751050pgx.69.1554882308301;
        Wed, 10 Apr 2019 00:45:08 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id h4sm45799872pfo.119.2019.04.10.00.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 00:45:07 -0700 (PDT)
From:   Oliver O'Halloran <oohall@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] PCI: Add a comment for the is_physfn field
Date:   Wed, 10 Apr 2019 17:44:55 +1000
Message-Id: <20190410074455.26964-1-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The meaning of is_physfn and how it's different to is_virtfn really
isn't clear unless you do a bit of digging. Add a comment to help out
the unaware.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..88bf71bfa757 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -393,6 +393,10 @@ struct pci_dev {
 	unsigned int	is_managed:1;
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
 	unsigned int	state_saved:1;
+	/*
+	 * is_physfn indicates that the function can be used to host VFs.
+	 * It is only set when both the kernel and the device support IOV.
+	 */
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
-- 
2.20.1

