Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A2390218
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310349; cv=none; b=BmLAg+J9JO2Wzr184ohMtpMFLZErTBJPCpJWF33KSgCbKFnflSgtyZHCI5I9H7gs1HnURDVHKx3S237/Dyy/Q4YhZky6frYV2ZXN2XjQdnjh5XmzQx1IKbi53WMRYf1fMKxahKmcw9RJlySGcr5j5JxPUOBwNv3rDyd9BpF5jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310349; c=relaxed/simple;
	bh=CB98rKqSSxQ2+oJREog3POAWNqPld4A6srfHRMe7lyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TUp1i62zVvlV+cRhIXwH8qcAsqKtks1u9fcGtvnY+cRxfzjqbbgEPbOzFwwFq5rsDEXfpdWurg5+LmPFbkbs/AKl7+jC7zNVnmuzeWcVMOcz6XYrKvDv5wIqRABKKiF+h4Dg7TE35I5kJbLz//klEnGLGxvPHkF4s3RZ1iG+fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBmi4YML; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBmi4YML"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738bebd53fso15791007a12.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310342; x=1774915142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omO2IOfE0pDlFemBHvNO/nr0zzMPm3bDzAx2yMbkgWA=;
        b=lBmi4YMLKGYaM4jQRGbiviDF7S/K5qmjnPT0odqWbfhy0TvJ4zmCEbW7VVpA1AlmZK
         5B+iE3vPJh+tHJ1hh39UXRl9sC8I+4jIz/U534xir8M2JcgUTWl4ONorjZA3iQ5r5cNy
         BsBA5LEDxeDIYlsqyb+8S613rapdS5GGQdCO6DediVVp8PyN750+FPch9FeWEVM6rGwg
         w2MBepqytGuzagTfKgVQmofH6TFDM8FMvZ9CKdn7p5B5UgcZSh6cUtKXKthgbfHqeSJd
         fHROWWQ2nXUYRqeYa3AiGTMtOlksz1I/Qnw91dHugNK3JbBdgmcvKjMzRwlQOml6ILi6
         CmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310342; x=1774915142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omO2IOfE0pDlFemBHvNO/nr0zzMPm3bDzAx2yMbkgWA=;
        b=tH+RO+pUBKjpXfFV5+OUT26NXlS2avU5nw2CAOazkHfS77s30qRtiUWtWV95xoh6ei
         ondrwQVPLes2GISG7v/9HLUhfHkY44REavDrxo99nM0oWx5DSgWPqen6khRZaiSOnWz8
         dCjYA+PSJLyTgJMr8g9InKZZMsopsAM6JkBbapJnwYYMHOh0bq08ePrjVphUIP69KzwM
         3JQme06Epz9Vm5XxyzZgDYhktuLxktxzKQ0bxKRU0IXuk0ekuJYHIsyiQhjq9WoRjzCn
         39Gjcf3iZCkLgDd08u/0ej3btV/Q4wmOt/cf2WWQo0r1yG8nFcmArJDthJw6CjIoi69w
         chLw==
X-Forwarded-Encrypted: i=1; AJvYcCXe6nXdZWbCZRFztde/D5e1I/pmJV8uIqsxGoZl0l8U0ZcO3MBr+5pA+K7r7taL8wAapWO8qIWXx4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx88s8ircqfrtddBkqhycnrqq+otBUk7b7r6XuwvtHOjNL/G2UI
	MfB9lJmKoi8Eq6qwUqHOwnB4zp9st3/CYSrnl7FAjNw5iJKDaNzXuHnmLqNJ16ZB9htQNUyL1zp
	dZvAX9qB7/m9WFg==
X-Received: from pgbci10.prod.google.com ([2002:a05:6a02:200a:b0:c74:12b9:ee05])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a3:b0:39b:e710:e2ec with SMTP id adf61e73a8af0-39be7111013mr9375027637.43.1774310342018;
 Mon, 23 Mar 2026 16:59:02 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:06 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-15-dmatlack@google.com>
Subject: [PATCH v3 14/24] selftests/liveupdate: Move luo_test_utils.* into a
 reusable library
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Move luo_test_utils.[ch] into a lib/ directory and pull the rules to
build them out into a separate make script. This will enable these
utilities to be also built by and used within other selftests (such as
VFIO) in subsequent commits.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/liveupdate/.gitignore |  1 +
 tools/testing/selftests/liveupdate/Makefile   | 14 ++++---------
 .../include/libliveupdate.h}                  |  8 ++++----
 .../selftests/liveupdate/lib/libliveupdate.mk | 20 +++++++++++++++++++
 .../{luo_test_utils.c => lib/liveupdate.c}    |  2 +-
 .../selftests/liveupdate/luo_kexec_simple.c   |  2 +-
 .../selftests/liveupdate/luo_multi_session.c  |  2 +-
 7 files changed, 32 insertions(+), 17 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (87%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (99%)

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index 661827083ab6..18a0c7036cf3 100644
--- a/tools/testing/selftests/liveupdate/.gitignore
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -3,6 +3,7 @@
 !/**/
 !*.c
 !*.h
+!*.mk
 !*.sh
 !.gitignore
 !config
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 080754787ede..a060cc21f27f 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-LIB_C += luo_test_utils.c
-
 TEST_GEN_PROGS += liveupdate
 
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
@@ -10,25 +8,21 @@ TEST_GEN_PROGS_EXTENDED += luo_multi_session
 TEST_FILES += do_kexec.sh
 
 include ../lib.mk
+include lib/libliveupdate.mk
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -MD
 
-LIB_O := $(patsubst %.c, $(OUTPUT)/%.o, $(LIB_C))
 TEST_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIB_O))
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(LIBLIVEUPDATE_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(TEST_O))
 -include $(TEST_DEP_FILES)
 
-$(LIB_O): $(OUTPUT)/%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
-
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: %.o $(LIB_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIB_O) $(LDLIBS) -o $@
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: %.o $(LIBLIVEUPDATE_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBLIVEUPDATE_O) $(LDLIBS) -o $@
 
-EXTRA_CLEAN += $(LIB_O)
 EXTRA_CLEAN += $(TEST_O)
 EXTRA_CLEAN += $(TEST_DEP_FILES)
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
similarity index 87%
rename from tools/testing/selftests/liveupdate/luo_test_utils.h
rename to tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 90099bf49577..4390a2737930 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -7,13 +7,13 @@
  * Utility functions for LUO kselftests.
  */
 
-#ifndef LUO_TEST_UTILS_H
-#define LUO_TEST_UTILS_H
+#ifndef SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H
+#define SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H
 
 #include <errno.h>
 #include <string.h>
 #include <linux/liveupdate.h>
-#include "../kselftest.h"
+#include "../../../kselftest.h"
 
 #define LUO_DEVICE "/dev/liveupdate"
 
@@ -41,4 +41,4 @@ typedef void (*luo_test_stage2_fn)(int luo_fd, int state_session_fd);
 int luo_test(int argc, char *argv[], const char *state_session_name,
 	     luo_test_stage1_fn stage1, luo_test_stage2_fn stage2);
 
-#endif /* LUO_TEST_UTILS_H */
+#endif /* SELFTESTS_LIVEUPDATE_LIB_LIVEUPDATE_H */
diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
new file mode 100644
index 000000000000..fffd95b085b6
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
@@ -0,0 +1,20 @@
+include $(top_srcdir)/scripts/subarch.include
+ARCH ?= $(SUBARCH)
+
+LIBLIVEUPDATE_SRCDIR := $(selfdir)/liveupdate/lib
+
+LIBLIVEUPDATE_C := liveupdate.c
+
+LIBLIVEUPDATE_OUTPUT := $(OUTPUT)/libliveupdate
+
+LIBLIVEUPDATE_O := $(patsubst %.c, $(LIBLIVEUPDATE_OUTPUT)/%.o, $(LIBLIVEUPDATE_C))
+
+LIBLIVEUPDATE_O_DIRS := $(shell dirname $(LIBLIVEUPDATE_O) | uniq)
+$(shell mkdir -p $(LIBLIVEUPDATE_O_DIRS))
+
+CFLAGS += -I$(LIBLIVEUPDATE_SRCDIR)/include
+
+$(LIBLIVEUPDATE_O): $(LIBLIVEUPDATE_OUTPUT)/%.o : $(LIBLIVEUPDATE_SRCDIR)/%.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBLIVEUPDATE_OUTPUT)
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
similarity index 99%
rename from tools/testing/selftests/liveupdate/luo_test_utils.c
rename to tools/testing/selftests/liveupdate/lib/liveupdate.c
index 3c8721c505df..60121873f685 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -21,7 +21,7 @@
 #include <errno.h>
 #include <stdarg.h>
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 int luo_open_device(void)
 {
diff --git a/tools/testing/selftests/liveupdate/luo_kexec_simple.c b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
index d7ac1f3dc4cb..786ac93b9ae3 100644
--- a/tools/testing/selftests/liveupdate/luo_kexec_simple.c
+++ b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -8,7 +8,7 @@
  * across a single kexec reboot.
  */
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define TEST_SESSION_NAME "test-session"
 #define TEST_MEMFD_TOKEN 0x1A
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
index 0ee2d795beef..aac24a5f5ce3 100644
--- a/tools/testing/selftests/liveupdate/luo_multi_session.c
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -9,7 +9,7 @@
  * files.
  */
 
-#include "luo_test_utils.h"
+#include <libliveupdate.h>
 
 #define SESSION_EMPTY_1 "multi-test-empty-1"
 #define SESSION_EMPTY_2 "multi-test-empty-2"
-- 
2.53.0.983.g0bb29b3bc5-goog

