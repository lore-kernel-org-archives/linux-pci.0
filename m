Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B5C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002620643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwlfpBPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfDWQg3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:36:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45118 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfDWQg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:36:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id o5so3463572pls.12;
        Tue, 23 Apr 2019 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64xazSolKvbAkmeK33oc5VYzPUgesF2xpW5xUbGcjt0=;
        b=kwlfpBPFGUAMOA3hImN/0Fr1fvXoRwFhICv0Lsn0HuDvPp0B9eYoqyrJPbnCBxyzJz
         skXSdkDtMK0LSKBEtS7cA4Fls6NeXTdb/VHGZeBPVmcCdaY5bWjDtEKYAo+srZ5sYWhO
         57xtC68acrC+6aLOLoWZynxTbf/93Ox7WVGKWSbb7JRZ0eXxHJOoT1YTDa6HB/+6BUDP
         QJD2VpOsawF6WWU3HnGy7nZkhr7lAOHwW9B3Rp+bKkWbhgOWSzmugM5RKK7U0ipwcWay
         MLHp6zpxWJIUEFzCQPZkBE0NWduoPyQYaBF94y5uSdLlNOvBHSOvw4NrH7zs8i0FPPRq
         DlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64xazSolKvbAkmeK33oc5VYzPUgesF2xpW5xUbGcjt0=;
        b=mEjJ5WsEYgpJh21dD+CqyLotpDKHJd77CkhVPRW+u5VVe0AIMp6jFYyZm41dXsW17c
         vSD8999EjPDnrw883D9hsu1w51isLJUvkPEyy14uLacpNJ1PZWE1KvNvwqhetC5/qSpV
         uOcQ7JpXPpMQcuanxmPVHfx1YvGfTloqNgnvHHtKy5XKPg1y+jod2IJT/9H4A2ydAmXR
         S4GUU/1rgICnvbRO3CJv69VKcs5m26c/sh5kApY/4252gJcYHUdMdcAv+e/jfDsN9g2k
         Xf7t9vGlfw6QUodPwc7NevfTY70k5WmZhEqw5xotmRpNP+V+pSHhZPPB51Ogx1plk6yM
         yJzg==
X-Gm-Message-State: APjAAAVUs4GYxehwht+KWQKepMJe8lVDZsumFLAS9+A2Pg6c0XFKn4dN
        70U98u8jGb6paaOwxjbevfUs38w9
X-Google-Smtp-Source: APXvYqwbiOQ4Eh7U2IuTyJKPYYO1VwIcE2waf/RHXY5SnGUuxOhD94nb3bmdijZZMnK9sDeGZdyHyg==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr17769704plp.223.1556037388040;
        Tue, 23 Apr 2019 09:36:28 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:36:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 37/63] Documentation: add Linux x86 docs to Sphinx TOC tree
Date:   Wed, 24 Apr 2019 00:29:06 +0800
Message-Id: <20190423162932.21428-38-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a index.rst for x86 support. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/index.rst     | 1 +
 Documentation/x86/index.rst | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/x86/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index d80138284e0f..f185c8040fa9 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -112,6 +112,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
+   x86/index
    sh/index
 
 Filesystem Documentation
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
new file mode 100644
index 000000000000..7612d3142b2a
--- /dev/null
+++ b/Documentation/x86/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Linux x86 Support
+=================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
-- 
2.20.1

