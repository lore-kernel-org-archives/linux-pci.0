Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B268C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADAD218A2
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIxpW6DV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfC2QEz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37355 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfC2QEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:04:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id q6so1248822pll.4;
        Fri, 29 Mar 2019 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zItPjJCgoGsWCOicwGPeRJfUVsCyFQ4HUTCvf4qZuY=;
        b=MIxpW6DVi9i0JIPZBLj8K292PIRgavWa2hBZZicu4bYT8vWYhbiV0ygaSwrQgKhSR0
         G3jh28rrnakwGUp4kiWzJL9q28R6AB704WtGRUfn9pjx5mwf7X9q2F8Mk3zB41muZNe6
         uu77Jl4+vWH/hRvt+vuPK5h9jZfAwKU2Hr+usqtQo6EvXQkqDo7/ClZtXx3sE/bvXLvS
         uEpZ5T+90I3Swegm5Z4i51lOHat5cjL0gob/cXUTrutYsCnA1w5J+5g9G9PqobQh0IWK
         1/orJr23vMeBYJruUrBPYwytbB+L3ueqw1zlvQHuyfyuzDJuURL3bjRsRtdSiYdCpwPw
         rItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zItPjJCgoGsWCOicwGPeRJfUVsCyFQ4HUTCvf4qZuY=;
        b=QtrsrmEXWwdsR6V7wkxMz9DiyaOn7vhLD90d7wwjaJWgAUHXlqON8ILOVJGjhCj6G9
         TmPdsB6IM69OERRvyvNhDUhCokNR95Y4oc11+zmh8Jyvhj36b3Ia2Ju1R3UxV74s0/2M
         hyya7tRxJJBpI9dvr1Dj4OEwQpBdYX6F74Y86PGdfmfteQGR+eIrb76PvKClHnD7oiJo
         azWXk1hJ4+Z5relEtuIyeegkIN45K3YLrfc3Ap0EOfwaGjiXkRO9HwdFPVqpwkKijiNT
         2NUdwPzWsjORrTZtOroN/VH6uWMqoPQjBXVJvnMZaIeX3soZpEpciYculFB/RKLzOPFV
         JdEg==
X-Gm-Message-State: APjAAAVYwAX2ljC7tCo03uAV+DYjqxxe/BLy8f6TFEb2cGNWW+gS7tmK
        Pspe+5UpHDFLTIhjsCvldbNTcYkD1eg=
X-Google-Smtp-Source: APXvYqz4tYMDSTuC1ZLT44TwFR6oAOzkfzZYZ+vkUfy1H+EwmPOsvKMVBVI2x39VOGtK0OFjuRgH7w==
X-Received: by 2002:a17:902:8a84:: with SMTP id p4mr48650080plo.2.1553875494703;
        Fri, 29 Mar 2019 09:04:54 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:04:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/12] pci doc: convert PCI/acpi-info.txt to rst format
Date:   Sat, 30 Mar 2019 00:04:07 +0800
Message-Id: <20190329160413.4293-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329160413.4293-1-changbin.du@gmail.com>
References: <20190329160413.4293-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/PCI/{acpi-info.txt => acpi-info.rst} | 11 ++++++++---
 Documentation/PCI/index.rst                        |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)

diff --git a/Documentation/PCI/acpi-info.txt b/Documentation/PCI/acpi-info.rst
similarity index 97%
rename from Documentation/PCI/acpi-info.txt
rename to Documentation/PCI/acpi-info.rst
index 3ffa3b03970e..f7dabb7ca255 100644
--- a/Documentation/PCI/acpi-info.txt
+++ b/Documentation/PCI/acpi-info.rst
@@ -1,4 +1,8 @@
-		ACPI considerations for PCI host bridges
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+ACPI considerations for PCI host bridges
+========================================
 
 The general rule is that the ACPI namespace should describe everything the
 OS might use unless there's another way for the OS to find it [1, 2].
@@ -135,8 +139,9 @@ address always corresponds to bus 0, even if the bus range below the bridge
 
     Extended Address Space Descriptor (.4)
     General Flags: Bit [0] Consumer/Producer:
-	1–This device consumes this resource
-	0–This device produces and consumes this resource
+
+        * 1 – This device consumes this resource
+        * 0 – This device produces and consumes this resource
 
 [5] ACPI 6.2, sec 19.6.43:
     ResourceUsage specifies whether the Memory range is consumed by
diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 8ed57b9ecfe4..6e608afa55c1 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -11,3 +11,4 @@ Linux PCI Bus Subsystem
    PCIEBUS-HOWTO
    pci-iov-howto
    MSI-HOWTO
+   acpi-info
-- 
2.20.1

