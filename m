Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7AFC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53914217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0V8y2S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfDWQhM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:37:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbfDWQhL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:37:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so7892894pgc.3;
        Tue, 23 Apr 2019 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
        b=H0V8y2S9LY/h1oclaqAqBDBVPpIsCwmSZ1eaAydDS9yJAo8ZH7vpapqzuh7pb3kycC
         LArRs6FRsK5zM5OugFN4WIEkkaMZmONSSeVWzGpHYHe2W7/vdKNn1CNtr2dyssuL8VmN
         rZLwb8JL3KYiBZUJA4vrgRC34fv8nK+Qf55zTjPT1Q45QBwZvNLjiI64ekZScAhxVzn+
         lkP7DU/LdaCXzfG6tqMBGsYfzNVih6mlAowHOk1zf6F2AZKkPl7F2z6v5MwAwxyKOy8Y
         LSYlIHdI7CW0UByUVOZ7ED9kBF6mm/1QNMJy3+5SBYrFHE6DSEgMhIaF6jJbu+wYWLbs
         Q0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9lwqiKGdUroDww2WFkm9jYtVCvbzItCk9Ugl1HYVfw=;
        b=krOwkW+NBuGTnq0g5B7gJCXnvzfHO5Bv8KOAtGm90vWzO47giarMN8rLJQpxek6uip
         lA9VgS1Lb3cGQqI+77MlmBPpaKlAeotCA8CNvZSi2M9aO3z9PsuFCXhBW0Q9DAZzQCq+
         l/cLRy9v0WQm/fNUDwzqYg1QkgE0LV1fdEwsQBr0vajxDSwQ5mpwFbmJJpVHvRbPu6v7
         eqCi5BjlLl2z84Hi1v0Qwy3acAI1kOUpmncbzEVBZUQITGAnPSO9mEkmrON1HCtJU+tP
         HpbA4DL4M/wmj1RgfvpWtmwc77mWBMwmtszsrVZedABJNS6KK9b3su4mZPLD1AD/SEpn
         5TIQ==
X-Gm-Message-State: APjAAAW9q1z8G9V+vgUQARHtG1ViF/YHA41uu1/63c/AR8xK6f8jfYZd
        j2qz4Tg8JsOEJ3avIZpfn5U=
X-Google-Smtp-Source: APXvYqxrACQ5i2jIhn4LUrHm3mZQzFOFJ01PPmOWO3KVjgS+E+E3Jf2lRhZP1U+++JzF2DGkbf5Uig==
X-Received: by 2002:a63:5953:: with SMTP id j19mr25403845pgm.260.1556037430791;
        Tue, 23 Apr 2019 09:37:10 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:37:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 41/63] Documentation: x86: convert kernel-stacks to reST
Date:   Wed, 24 Apr 2019 00:29:10 +0800
Message-Id: <20190423162932.21428-42-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                   |  1 +
 .../x86/{kernel-stacks => kernel-stacks.rst}  | 20 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c0bfd0bd6000..489f4f4179c4 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -11,3 +11,4 @@ Linux x86 Support
    boot
    topology
    exception-tables
+   kernel-stacks
diff --git a/Documentation/x86/kernel-stacks b/Documentation/x86/kernel-stacks.rst
similarity index 92%
rename from Documentation/x86/kernel-stacks
rename to Documentation/x86/kernel-stacks.rst
index 9a0aa4d3a866..3e6bf5940db0 100644
--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Kernel Stacks
+=============
+
 Kernel stacks on x86-64 bit
----------------------------
+===========================
 
 Most of the text from Keith Owens, hacked by AK
 
@@ -57,7 +63,7 @@ IST events with the same code to be nested.  However in most cases, the
 stack size allocated to an IST assumes no nesting for the same code.
 If that assumption is ever broken then the stacks will become corrupt.
 
-The currently assigned IST stacks are :-
+The currently assigned IST stacks are :
 
 * DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
 
@@ -98,7 +104,7 @@ For more details see the Intel IA32 or AMD AMD64 architecture manuals.
 
 
 Printing backtraces on x86
---------------------------
+==========================
 
 The question about the '?' preceding function names in an x86 stacktrace
 keeps popping up, here's an indepth explanation. It helps if the reader
@@ -108,7 +114,7 @@ arch/x86/kernel/dumpstack.c.
 Adapted from Ingo's mail, Message-ID: <20150521101614.GA10889@gmail.com>:
 
 We always scan the full kernel stack for return addresses stored on
-the kernel stack(s) [*], from stack top to stack bottom, and print out
+the kernel stack(s) [1]_, from stack top to stack bottom, and print out
 anything that 'looks like' a kernel text address.
 
 If it fits into the frame pointer chain, we print it without a question
@@ -136,6 +142,6 @@ that look like kernel text addresses, so if debug information is wrong,
 we still print out the real call chain as well - just with more question
 marks than ideal.
 
-[*] For things like IRQ and IST stacks, we also scan those stacks, in
-    the right order, and try to cross from one stack into another
-    reconstructing the call chain. This works most of the time.
+.. [1] For things like IRQ and IST stacks, we also scan those stacks, in
+       the right order, and try to cross from one stack into another
+       reconstructing the call chain. This works most of the time.
-- 
2.20.1

