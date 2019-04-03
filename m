Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC465C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB040206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHrfwUpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDCPuV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45089 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDCPuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id bf11so8227230plb.12;
        Wed, 03 Apr 2019 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syOA+zPZTwlboRIIrIDQhbaPrDpvvVM2MWdFiG8P1ds=;
        b=HHrfwUpc5CDEM3eN0X6ACB0dNBvhflchzajME6SiEe7SW/61twlnNGyFFKE4/VayED
         F5w7v3RaONBh3/i1JRLmzKg1oDYUeQw8KzSC3ExBZG3g9Uu6dvmrHqCxEmTO3fsjteqN
         epcIbPAtX8HEh71B6LaQXQ6P5/QvjduQtttyLFt47nLcWcldoO1F5SFP/1jWuh6deSpP
         7gjZoJyLrNj8hen9FJJf2M1Sv6HfJKF9sFmTiY9veAgQdo6B1AwfChUU14Qb0OzShFCy
         Ravd66phP7uqfCBf/xuy1MAo/1KlMyfkMjkhfEH6xs2puPXspKQ/oRRrhoZBFdFQF6R9
         TaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syOA+zPZTwlboRIIrIDQhbaPrDpvvVM2MWdFiG8P1ds=;
        b=CW1o/nCyJXWQShoFJUh36a+zIyawmxjPQUWuKhWgZhscHsRDgIYooRXcl5c25HCoEf
         xbCEIZmomrTeVsksE8++v6OMa5KC9OJSxWLK6kGpjQo0d5VoSfbyUEV/sjWZ5DKFsjtE
         0NXt/wruS1dYlF5PXd5r3HIbd79Gjn2usmhHIdshXvDoQYG/Xml8euMYtw+szIrF853j
         pNnkLvJQRjU95j0xQt2eqPvwmvjmrOv+0IhRd8uz5w0IlrlKi1vB1SOhXudFUApaOupr
         Rms2aBTxG2LEjfLqj1u9quZkQDUKuUqgvuIUXd2/dWDoPgSrgBRTH33HA0VPxQdZaJvU
         R0Fg==
X-Gm-Message-State: APjAAAW3kqx7kPUDjxXdyEhGZwrYMm5kHmbHqRdNit/uBjASwHxhtU7S
        bJSmZSRE6jnO5lzlyPHjekE=
X-Google-Smtp-Source: APXvYqwo8tUgEdGNNSxIijLzKETuit6MD/p/+7hQ+lWuuWjunifSck5EGAGBLG3q9UNvozkM6u+UJQ==
X-Received: by 2002:a17:902:1002:: with SMTP id b2mr681943pla.248.1554306619835;
        Wed, 03 Apr 2019 08:50:19 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Wed,  3 Apr 2019 23:49:44 +0800
Message-Id: <20190403154955.12096-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403154955.12096-1-changbin.du@gmail.com>
References: <20190403154955.12096-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/PCI/index.rst | 9 +++++++++
 Documentation/index.rst     | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/PCI/index.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
new file mode 100644
index 000000000000..c2f8728d11cf
--- /dev/null
+++ b/Documentation/PCI/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux PCI Bus Subsystem
+=======================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
diff --git a/Documentation/index.rst b/Documentation/index.rst
index e3aa28275894..35fc03526b3b 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -91,6 +91,7 @@ needed).
    vm/index
    bpf/index
    acpi/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

