Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A638C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFD3218A3
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBnKKotu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfC2QEg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33342 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC2QEf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:04:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id bg8so1257262plb.0;
        Fri, 29 Mar 2019 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMtEZflRa9d+z2xHyjCAY3n9epzn7D8PsIg+fh278+M=;
        b=sBnKKotuQI+nCXR9xA4LGqm1N3GExGbSZRlYy3zwQg+dHKs4uO+ipCIBrZLmTXIibu
         jxVkF6zyiafHMxwjEdfG4gawq3sjBBvw6SxA6+rAmJgY48nd1wh0MlOMvWf/GNa0RIx3
         qZDiCta2p44KqITauTqkzFxAfguy06ZTwcgMcCQ9AX6MViFplAm2NZOnHwyRqNLI7W61
         gt3j8Xwjv81fLAEJKQnVIYc0euKNdrks+sZTlSc89rFai4MY/DSbPalvj4+o9GxyPAJo
         /Iqu/3WPyLHCMtKYHmrfXDpEIj11ySH0TxBmx4tkmePhKHPc1FigvXAxw09NQtbGk5vR
         RLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMtEZflRa9d+z2xHyjCAY3n9epzn7D8PsIg+fh278+M=;
        b=cf5CftZrh+/ww1p6s5ss5lrfpqC3rB8BEGXz4Msgs9cy4hM46wRduJg68yjSoZQC77
         oE+Mfdudm7/67Z3z/AO8vqTuvP/PWfyoQNFzTIdiorfJWYy0UwW8I3ThLjPKfYE9pGGY
         vo/SH+gQYodmSa9aOXQ0jxOh5WFHisfNjqjefq99XzGRNsIK+TCs8MDzK2yAN8G1gfjT
         +sZHtJjDRwNBhiY9GHkwMSz+cN8hrvHrxFtj3b8JgvgXXpGmNkbcmlk8QsEPzmTaWv27
         aKgd9zoLQRK70DO/M9qtD5Mp91/VQCYd6GW/LYpdud+8TWZvuqjH3qhaEdJ/ryNHC0U7
         Z2Ig==
X-Gm-Message-State: APjAAAU7ZHgc26jViY4II1O7XY6F2gPYH9H+pfF9H9XcWCZ+SbdYLDX1
        bIH5dC6V5TFhT4FFYo0gkxc=
X-Google-Smtp-Source: APXvYqxwQoG2SYqhiuctKvgaKHt1xBfoSiwL+dPMcdiyiE8bSGfesizQNttT/t0xJM0Lbe+CQcH7bA==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr49508100plz.101.1553875475019;
        Fri, 29 Mar 2019 09:04:35 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:04:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Sat, 30 Mar 2019 00:04:02 +0800
Message-Id: <20190329160413.4293-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329160413.4293-1-changbin.du@gmail.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/PCI/index.rst | 8 ++++++++
 Documentation/index.rst     | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 Documentation/PCI/index.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
new file mode 100644
index 000000000000..11096447f535
--- /dev/null
+++ b/Documentation/PCI/index.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux PCI Bus Subsystem
+=======================
+
+.. toctree::
+   :maxdepth: 2
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

