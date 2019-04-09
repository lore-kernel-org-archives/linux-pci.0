Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13C6C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB32133D
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvL+IWN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDIP4n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:56:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34585 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIP4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:56:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so9966842pfd.1;
        Tue, 09 Apr 2019 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN5Ve0jp7sji5sCR6t6eLqTPC+Xc3/VkwxlLdQQoICg=;
        b=hvL+IWN06oVplsQ0bvp4xZO3huBpo8mFz9WWxHbAqHGU3z+DfV04qSgM4RlNtlnAcP
         YH0YUWgG7JJ7RvNbgkGktGwlOzoEPPOu+lQ+IUMprmyns8trQreL9j6+V66zlrEKgaQs
         m9nUc+LnY57QwnUVhnauUNMzGrE8CcUKD4glgpQPcy5ZsReZ1osGExjmGLylAJV8woOs
         cjFrLvHxVZ57tu17GNJYB0b/g9yMu2g/G7AHF9vt0fArGkVGB3ckYKF8CNk/15nWAHCC
         ldic6ANIt/zDNkZHtzVobNEEY/xymZzwYMIRp7qApv1Dq+F4j549715/TVcusegGXVCP
         ligQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN5Ve0jp7sji5sCR6t6eLqTPC+Xc3/VkwxlLdQQoICg=;
        b=mzTj8HTiH9dJYQnCYuX8uFlvE5bL920Ylk3NZedkDa4a1yWx/IBJK70TRUrRj1p1MP
         0QCh8+patFA79Kexaht8HAf9ZkM9XD9vgJhIyj1TEp1ebdGm0ajsE+625LM8z9klXn8k
         JWUGZB6wWJjnokdGE17vWKIVXdTHas5wCfP1XmQ/8NUM6tc5xETSrrcFqLxcj1EQd8z6
         nxu3uJT7O7r+6GXnoLXE9zgQTFdz2wMrmxRfaShIjGiz2YrAAzXmZdb2jj/U7xjpSgwn
         geT+hc/geb9b9MI9TcTBhJMguH7h9NwC1CjfOXup/mIDOfaAk2ZfbnIYBERRQukdKZBv
         qT0w==
X-Gm-Message-State: APjAAAWXTBECEAMN2loOmikjoRX5A2pEc+tnCbcEtPjOGhhws3WfYagr
        uOSlz6rSWmw9J9fHvDyeuEA=
X-Google-Smtp-Source: APXvYqy+4P27Jy5Dq6m03oxwFTA9zJmmmCxmG7OmwRmPj/BdYf1Q+xHPk0EKPt2HWldb52CZ4Ru7yw==
X-Received: by 2002:a63:4241:: with SMTP id p62mr35484471pga.379.1554825401803;
        Tue, 09 Apr 2019 08:56:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:56:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Tue,  9 Apr 2019 23:56:15 +0800
Message-Id: <20190409155626.6049-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409155626.6049-1-changbin.du@gmail.com>
References: <20190409155626.6049-1-changbin.du@gmail.com>
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
index 80a421cb935e..392a2262507f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -90,6 +90,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

