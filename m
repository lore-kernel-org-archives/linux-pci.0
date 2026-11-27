Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782354;
	b=gE1lFA4iCQk/oou3KAz7FLMhDb3t7bl+8BkRITZUvYv627Vqu+ywShpnHlF5jTVu8A0P
	 ajyS0wJkqTKklct3z31S3tfh8QNWzJLa9kzvh4JQDTuMjrk/GL4TLNCf41iDM/AiGtGMg
	 6ewYhrmCDObblZLp1aBT1S7t99WqnAqZRvFsWCVmUgwh0osWnhcKWmW0kquC7IozaUKqn
	 RKjF+CMjbvaIhnIQUhz7yVtnq6NbZGAYfy+ATEgG7sS6XD4mRE4ad0wk59z8j+c/tc4NG
	 MAz5MuAVQULmMIPybuCExcc5qfD9nWo8/QZBQqndoq4QRcTodQLeTleNIlmRWc7DGbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782354;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W3hHPVqXQnPXwpisRritcflbPwRRd0Bc6Ld600N+Z20=;
	b=T8/7xVkWeLRKnJ8NKy5IMs5xlMNmmQjesmGxeuDkHQ31IVW8AMNWfm7NlatB3XvHWy3L
	 uKJueJu7eryhCgl5teIJhT5vWqFhhhDOmiGNO4bppCw33HRPrqAPxSYZ56RGbKEMw2/wv
	 17ldhQPRqTV7Ylj6tb+y6J4Xv4xW66fRhNC0kV898p5xQpt3VGhgfjIuZTla7mWauF3H4
	 pZRdiQji5gLwrslBXco4x+WkG9870y1KdDqc06RA3+bA3Gl9rCqp8T6BCDiAJ6raPlX4p
	 jAL7W+d7e06p1c0PcmS4yDTN9Pek7KjX0mVqO8HEs6Kp6xHbMrI5KKMrK/swV4G44Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUT5wQXu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32E606A324;
	Fri, 27 Nov 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUT5wQXu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544A81F00893;
	Fri, 27 Nov 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782354;
	bh=W3hHPVqXQnPXwpisRritcflbPwRRd0Bc6Ld600N+Z20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUT5wQXuJLFF/rapm0BbPsLoSB/rzTcBEjV7Z9IrXf3u2vP1cVKN/8V4Dao8lX2cE
	 dQMTnYjaGi9+oBqRna07DX+7a2tcXGuQ5JmcNErlfKJwoBo9xsljPeEqkXzmv42pXB
	 +aSB3MQGp/OZrjDF3uZ/6HUaXMCRx+tHvDHFOmopfsqMGGh953Y4pfC+TKPyGvFSCZ
	 g7h30mPpbZ70DUUhPvtsFkqMQSIA0dltk6fFeDWUZmwjG6g7KnULViokkGykYijrjE
	 GxIX+z4/0Qkbp3hEGcgwj5V0jNVUaQcEtNu53UpU89C3ZEr1rAQhmf44Wnf6q8Rdx5
	 DDFyTbXw4OqUQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/6] kho: use acronym for KHO .c files
Date: Fri, 27 Nov 2026 12:25:28 +0000
Message-ID: <20261127122536.3708770-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127122536.3708770-1-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

KHO started its life in kernel/. At the time, its name matched the
pattern of other kexec files like kexec_core.c or kexec_file.c.

Commit 48a1b2321d76 ("liveupdate: kho: move to kernel/liveupdate") moved
into liveupdate/. Files in liveupdate/ use acronyms like luo_core.c,
mainly because the wider context is already available in the directory
name.

Save some keystrokes and rename the kexec_handover_* files to kho_*.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 Documentation/core-api/kho/index.rst                        | 2 +-
 MAINTAINERS                                                 | 2 +-
 kernel/liveupdate/Makefile                                  | 4 ++--
 kernel/liveupdate/{kexec_handover.c => kho_core.c}          | 4 ++--
 .../liveupdate/{kexec_handover_debugfs.c => kho_debugfs.c}  | 4 ++--
 .../{kexec_handover_internal.h => kho_internal.h}           | 6 +++---
 kernel/liveupdate/luo_core.c                                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename kernel/liveupdate/{kexec_handover.c => kho_core.c} (99%)
 rename kernel/liveupdate/{kexec_handover_debugfs.c => kho_debugfs.c} (97%)
 rename kernel/liveupdate/{kexec_handover_internal.h => kho_internal.h} (91%)

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index ce2bf9cf6651..fc759213ddb9 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -89,7 +89,7 @@ Kexec Handover Radix Tree
 Public API
 ==========
 
-.. kernel-doc:: kernel/liveupdate/kexec_handover.c
+.. kernel-doc:: kernel/liveupdate/kho_core.c
   :export:
 
 KHO Serialization Blocks API
diff --git a/MAINTAINERS b/MAINTAINERS
index a946fbbd74f0..fa9ee8051139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14785,7 +14785,7 @@ F:	include/asm-generic/kexec_handover.h
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
 F:	include/linux/kho_block.h
-F:	kernel/liveupdate/kexec_handover*
+F:	kernel/liveupdate/kho_*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
 
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index bc679905ce3f..b73e19587f7f 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 kho-y :=								\
-		kexec_handover.o				\
+		kho_core.o					\
 		kho_block.o
 
-kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kexec_handover_debugfs.o
+kho-$(CONFIG_KEXEC_HANDOVER_DEBUGFS) += kho_debugfs.o
 
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kho_core.c
similarity index 99%
rename from kernel/liveupdate/kexec_handover.c
rename to kernel/liveupdate/kho_core.c
index 38e65d210cb9..7544bc0b99e5 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kho_core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * kexec_handover.c - kexec handover metadata processing
+ * kho_core.c - kexec handover metadata processing
  * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
@@ -39,7 +39,7 @@
 #include "../../mm/mm_init.h"
 #include "../../mm/vmalloc.h"
 #include "../kexec_internal.h"
-#include "kexec_handover_internal.h"
+#include "kho_internal.h"
 
 /*
  * This is the minimal alignment required by deferred struct page init.
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kho_debugfs.c
similarity index 97%
rename from kernel/liveupdate/kexec_handover_debugfs.c
rename to kernel/liveupdate/kho_debugfs.c
index 3a91c47ad7a6..8d04368c1978 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kho_debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * kexec_handover_debugfs.c - kexec handover debugfs interfaces
+ * kho_debugfs.c - kexec handover debugfs interfaces
  * Copyright (C) 2023 Alexander Graf <graf@amazon.com>
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
@@ -13,7 +13,7 @@
 #include <linux/libfdt.h>
 #include <linux/mm.h>
 #include <linux/kho/abi/kexec_handover.h>
-#include "kexec_handover_internal.h"
+#include "kho_internal.h"
 
 static struct dentry *debugfs_root;
 
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kho_internal.h
similarity index 91%
rename from kernel/liveupdate/kexec_handover_internal.h
rename to kernel/liveupdate/kho_internal.h
index e9685e1ef6d7..5b349f451cf6 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kho_internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
-#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+#ifndef LINUX_KHO_INTERNAL_H
+#define LINUX_KHO_INTERNAL_H
 
 #include <linux/kexec_handover.h>
 #include <linux/list.h>
@@ -41,4 +41,4 @@ static inline void kho_debugfs_blob_remove(struct kho_debugfs *dbg,
 					   void *blob) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
 
-#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
+#endif /* LINUX_KHO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..a9215eca9e7e 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -61,7 +61,7 @@
 #include <linux/sizes.h>
 #include <linux/string.h>
 
-#include "kexec_handover_internal.h"
+#include "kho_internal.h"
 #include "luo_internal.h"
 
 static struct {
-- 
2.56.1.839.g22a8290db9-goog

