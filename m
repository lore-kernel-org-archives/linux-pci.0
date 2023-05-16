Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC9C7EE2C
	for <linux-pci@archiver.kernel.org>; Tue, 16 May 2023 19:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEPTie (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 May 2023 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEPTiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF910A26E;
        Tue, 16 May 2023 12:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E28563E94;
        Tue, 16 May 2023 19:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F0C4339C;
        Tue, 16 May 2023 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265871;
        bh=gSQe4II2iJtS+QQtWHfwrqCvLdxK7Wzo7e0HtFoFV5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j20kxPBBFRIlxqq0mFZaJS7pQ1cCrLadjW3BuMisWulwenHNraGn3QWbXEUvelZB9
         k8AScRxshCwAwrVHCxXAtcvrlQ6DnbnlQVpLaumX7l4EAkHg/GHsGYTQGiOvmWdeHV
         nnvqCAqbFDpb6jdopaiVGQxZ8tQP14F6vLmY6rEGNbIsMSxZRZfWCAbLoJmiLJul9v
         mHgb9qRmHAMRdPNwGH1ZJuxcpbeasYeDWHN2uDuIqWD3/Br6dub6irvZhT2xBqimyR
         5zR/L6TK+jHMgzzDqKoPOtdy3hz/UK9lh7gf7JJ+DhFN6pkHpaPxXMMg+7/fxjhdum
         PLw3akFNr0smA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 17/20] x86: usercopy: include arch_wb_cache_pmem declaration
Date:   Tue, 16 May 2023 21:35:46 +0200
Message-Id: <20230516193549.544673-18-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
References: <20230516193549.544673-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

arch_wb_cache_pmem() is declared in a global header but defined by
the architecture. On x86, the implementation needs to include the header
to avoid this warning:

arch/x86/lib/usercopy_64.c:39:6: error: no previous prototype for 'arch_wb_cache_pmem' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/lib/usercopy_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 003d90138e20..e9251b89a9e9 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/libnvdimm.h>
 
 /*
  * Zero Userspace
-- 
2.39.2

