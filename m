Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB8BC46465
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DC620819
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsT6xS1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DC620819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeKFFjF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46890 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbeKFFjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 00:39:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so4977393plz.13
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2018 12:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4+xrKqcCnzzEGa97yidlIN9VxNjgsG971WTiE2U09o=;
        b=bsT6xS1eF+TBKCO6uMQSYsGzUdElb/830fFPpNBbg7AmPDQuG+IQx6RYS/7zNMnhc0
         6PU61H8Y5I2yOuM/57zJpzo01b6uPnXUWVLkYN7FS4FJvRqJM2l9nxqSxA7beL9/404x
         HdnenMT/l3Mr9JEeltlEipd4ZQvDUXD4s2LGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4+xrKqcCnzzEGa97yidlIN9VxNjgsG971WTiE2U09o=;
        b=iuo4AD0xKTB3BpftrLqhWRQy7+xuldSsdSzxVA5e7Xbdhfrhj7JIBVtFIfh3E5cRQ9
         sf1OPq/ROO29t39vnET/+QGG+mXvaZGEt8bbr+JygMY6i+9FrX2RQxYFEjsJjBW8Tu6q
         gJqe30y7vvckxbTE28Ts1RqoMxOFTpMfPWRQDbEZoeeQldgQ2JU6zkrxLQZv6YgjIh9A
         Fge+/snuHAfxF+/M4vZrke1qUGfq05hcGnsjOOWMI3mvMYQFUE4iY65OHfXS7Ntb9qBe
         kpnDMCpGH6aeitSYAr5ceHDcZP3advKbx9HlsBvNvDVJawf86p9FJNxXYib6JmFQXo3b
         JtJg==
X-Gm-Message-State: AGRZ1gLAP2wwaNeDl9Ffbu437di6QYtOOFBxIF0S12Ly50Xembp1XDIw
        +TOOVfFWjP7IZr7nQ20ay7h7xg==
X-Google-Smtp-Source: AJdET5c1PIeAtrh2vLETbJ81GooRuIiXoW0KGpxq2iOnvvyo40fNVfYKjcRt1GXMSn4fuvUxLDy7Nw==
X-Received: by 2002:a17:902:2:: with SMTP id 2-v6mr23958956pla.178.1541449062980;
        Mon, 05 Nov 2018 12:17:42 -0800 (PST)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id e2-v6sm45972561pgv.25.2018.11.05.12.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:17:42 -0800 (PST)
From:   Zubin Mithra <zsm@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     groeck@chromium.org, keescook@chromium.org, zsm@chromium.org
Subject: [PATCH] x86/pci: Annotate 'pci_root_ops' with __ro_after_init
Date:   Mon,  5 Nov 2018 12:17:35 -0800
Message-Id: <20181105201735.72026-1-zsm@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When CONFIG_X86_INTEL_MID is set pci_root_ops is written to inside
intel_mid_pci_init(which is marked __init) and not modified after. This
makes pci_root_ops a suitable candidate for annotating as
__ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/x86/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..204ee80cfa63 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -67,7 +67,7 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int siz
 				  devfn, where, size, value);
 }
 
-struct pci_ops pci_root_ops = {
+struct pci_ops pci_root_ops __ro_after_init = {
 	.read = pci_read,
 	.write = pci_write,
 };
-- 
2.19.1.930.g4563a0d9d0-goog

