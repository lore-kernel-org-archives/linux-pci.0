Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91345C282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61552217D9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkJq64AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfDWQjN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:39:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfDWQjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:39:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so7747634pfi.12;
        Tue, 23 Apr 2019 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yFOemuN+eolbcMH+/FkuAihsixlocXPgjBOPtuP6bo=;
        b=SkJq64AJRj6L/JcconR1RzVxUNwJaE89UyLSCrjykYgm7VHed/1sbOtWWVRdlN8niw
         +nS3i5yl0ZH25GUu9DKrpYujqNabEnuDfZdg8N5pxdkLXCbB3DShZBR1ytrKAiS+ppzy
         RoPxBTK6zcETwFyC1cXvKGmL+1VsMJi3qt6ny4MWT7jWMEIGnPNhuKnCSg7b5zfbcw/1
         SVz53xsAnmOhCU7hII/u/ATPEQ+7gKaT+0LWaDisMPg6Rl1N8fBFOIapvUfQnVL36Scw
         b/zH3Kv1YUz/k9t35DB6/mDhqL4nfvVz8XKYIgtm2DY1ACYvbFSZ5kSZYBClu0TjzObG
         1YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yFOemuN+eolbcMH+/FkuAihsixlocXPgjBOPtuP6bo=;
        b=Zj7mfXZ6PC0WHCx0UYn1IzoezWtyWvTJp2AdVM4CzPkJ5LtmZLbOGH3f3xs2smhfQl
         W6tdKkT6FSnXmMgFm/TdtjIeSdk/TOQB+dP19npWEuwMPZ7H5+E5NEWyJ6D0JY608h6u
         o3r1Tv4AqInpu7vVb0nl5uzfXfdVMiMiuPNNaI3SxJZBOQ3zAnYPZCvLIdmdOn2XvySS
         WkEG1dbZwZV01bZMMp2f1HDrjL4bJbR5vMebLuq7gda4bQv30Ea7jR5jGQkAmVKY031X
         jVe0ZDgSDedXApJ5Kkb+PO6GOjgYNwhIgpJLXXvaz6fuMs4MYeG18fOtsm2X/QdnVo7s
         e3Lw==
X-Gm-Message-State: APjAAAUgoFBBXlpCTa+EB1Dvx7PipRNmC8cvOcJW65GUL0WVYUmn31Fq
        noQ2hbNkNO5XaE9egiMD6j4=
X-Google-Smtp-Source: APXvYqyt0eJT3NkmhT2J6r3iHijPGVxGT07haTkb6FEPB0c4A+sKOygu+96OyFnqj/Mw0nYRxCYdsw==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr26241568pga.37.1556037551867;
        Tue, 23 Apr 2019 09:39:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:39:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 61/63] Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
Date:   Wed, 24 Apr 2019 00:29:30 +0800
Message-Id: <20190423162932.21428-62-changbin.du@gmail.com>
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
 ...a-for-cpusets => fake-numa-for-cpusets.rst} | 18 +++++++++++++-----
 Documentation/x86/x86_64/index.rst             |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (90%)

diff --git a/Documentation/x86/x86_64/fake-numa-for-cpusets b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
similarity index 90%
rename from Documentation/x86/x86_64/fake-numa-for-cpusets
rename to Documentation/x86/x86_64/fake-numa-for-cpusets.rst
index 4b09f18831f8..3c23f45d38f6 100644
--- a/Documentation/x86/x86_64/fake-numa-for-cpusets
+++ b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Fake NUMA For CPUSets
+=====================
+
+:Author: David Rientjes <rientjes@cs.washington.edu>
+
 Using numa=fake and CPUSets for Resource Management
-Written by David Rientjes <rientjes@cs.washington.edu>
 
 This document describes how the numa=fake x86_64 command-line option can be used
 in conjunction with cpusets for coarse memory management.  Using this feature,
@@ -20,7 +27,7 @@ you become more familiar with using this combination for resource control,
 you'll determine a better setup to minimize the number of nodes you have to deal
 with.
 
-A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
+A machine may be split as follows with "numa=fake=4*512," as reported by dmesg::
 
 	Faking node 0 at 0000000000000000-0000000020000000 (512MB)
 	Faking node 1 at 0000000020000000-0000000040000000 (512MB)
@@ -34,7 +41,7 @@ A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
 
 Now following the instructions for mounting the cpusets filesystem from
 Documentation/cgroup-v1/cpusets.txt, you can assign fake nodes (i.e. contiguous memory
-address spaces) to individual cpusets:
+address spaces) to individual cpusets::
 
 	[root@xroads /]# mkdir exampleset
 	[root@xroads /]# mount -t cpuset none exampleset
@@ -47,7 +54,7 @@ Now this cpuset, 'ddset', will only allowed access to fake nodes 0 and 1 for
 memory allocations (1G).
 
 You can now assign tasks to these cpusets to limit the memory resources
-available to them according to the fake nodes assigned as mems:
+available to them according to the fake nodes assigned as mems::
 
 	[root@xroads /exampleset/ddset]# echo $$ > tasks
 	[root@xroads /exampleset/ddset]# dd if=/dev/zero of=tmp bs=1024 count=1G
@@ -56,7 +63,8 @@ available to them according to the fake nodes assigned as mems:
 Notice the difference between the system memory usage as reported by
 /proc/meminfo between the restricted cpuset case above and the unrestricted
 case (i.e. running the same 'dd' command without assigning it to a fake NUMA
-cpuset):
+cpuset)::
+
 				Unrestricted	Restricted
 	MemTotal:		3091900 kB	3091900 kB
 	MemFree:		  42113 kB	1513236 kB
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 7b8c82151358..e2a324cde671 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -11,3 +11,4 @@ x86_64 Support
    uefi
    mm
    5level-paging
+   fake-numa-for-cpusets
-- 
2.20.1

