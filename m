Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B694C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21A520643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4pAnp44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfDWQeX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:34:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38498 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfDWQeW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:34:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so7874470pgl.5;
        Tue, 23 Apr 2019 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLehLOE1ABgy8jWFXPTFYcRWdLlFEjSaDVUOmHPoCTo=;
        b=U4pAnp44P0PSsqJ98jbweSjiy67o17Pd9PsGiJzfQCnzcNqMnueTSBofSe3eHuJU9b
         TCzZEp1720OAfACQnAfygosHxbzrQT/XrNS5CP/gIEwNq7Q+8kSigXvYCvre1DgFlGub
         ehGR8zmyYp2r+BStZbVGvWicy5PaLfRexCF0xJqOpuxxYJjlCUv+0znoY4VHUIrEMfZa
         xsBVpsYsTS7Vhta5FqBjgc7O+4W3GDsGJhpPpXSBpH7m1SXeAiFtOoWcyscTnL5AB7vC
         l1RST2gQTU/CZyk97kB6T1Q1dxugH7NTA5WkvHQq2gcezxvwAyCKN+OeSbMNhGV1Z5f4
         dqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLehLOE1ABgy8jWFXPTFYcRWdLlFEjSaDVUOmHPoCTo=;
        b=SD9PMBRwnrGe+hf/bpjDIIh2knS5M7iFxpF763Uncl91qnnja4WlH49mdOzNUlE+vd
         hvQqjxVaiaz37Jstd727eASDhV/KmmvIbIdTM1arxIrRL6fc7zM4XNHDDaxyAVKv0pkP
         2x7lEcvgJUo/gDTnLGEo21WzDSEGXmkoOuLDiB6TnW0tTVeZfigt6UvKADq7rgJkkAUe
         ewK441qM20B0VDwszlnwE851SRtc4v/w+YVeAcI3DVrLKHYR9+5n5SKtEuTlecDmu4zU
         LT5ekINX/PGcsb7vHg7t80eQOAd6ZcQYC0nBP9F15/7QFVL4IcATXOJR2xY7Ed3vuNRV
         M/fw==
X-Gm-Message-State: APjAAAXjjgxaLR1ACj3ylN+p0MbRsygzEBonbO/s7u9/mphqAK1DbEF3
        W80P9Vh0s+8z2/z4FvJxjRo=
X-Google-Smtp-Source: APXvYqwOnaUZCTkR7Hrbrv1qaIAVW1d7EU8d1K7h/wsG99DVbwKx3P6IvbLyZuV/vvVQ9mgc8M/mJg==
X-Received: by 2002:a62:7089:: with SMTP id l131mr28640994pfc.158.1556037261922;
        Tue, 23 Apr 2019 09:34:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:34:21 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 25/63] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Wed, 24 Apr 2019 00:28:54 +0800
Message-Id: <20190423162932.21428-26-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
index fdfa85c56a50..d80138284e0f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -100,6 +100,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

