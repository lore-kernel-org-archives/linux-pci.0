Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782358;
	b=nhS4NJzpXGfT043iLQUb3FsA8x1KZyd0drcaKo7AcAc+90zR+YzQMzcmJEk5SlmgKpk7
	 zfNUK8tnRETjW/TkfNjenBNh9hZLcjw6vkmcdOJu4v3Dv3EsgUwA7xGM5vqdnEqTUqRYR
	 MjSiI1weD3S8XBrf2kvNnvRm67L0ie9IakfO9o2PGS1GOy7iuZA1XhmD2S10p3KAmvVtj
	 NuBCmVEn4u8BrUEgi9yyGESnWPfOb9XwkUB8zPApHB0u1n6u6bdcqPKoab+gAOo60+rNn
	 i+yg1AuBl5Mnghe7q4BY1gg7+WAxOXZKDRo/pQUTqBNLLcd+pz1UwK6LsFMmKO+LX6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lnIqqYjeXqPPSZa+aej0B5CBul0phvtQ8KiVL9/wl4s=;
	b=aDMgifyuzh14uskr2cJC1ZT9AZ0NG0vd953Az1YhHmOD4KsOf7Cwr1io3ZVFCtJokXJk
	 rEdIC2B+geUPWXpctxUxXLgn9CcenMrt42Whx08KUJkeLi8JYIUeXmari8K7OhhlX70hI
	 e47mv9gOBgZqH95w+u7y2tuludQMrdac7ty3O1bCrgDuAIk3jueOm2pneerYKwtnEa/5z
	 MHU2sygwZD4PEr+NfqxyJok9SY/SfvH6AdXxeCQKQFwrGU/LDC1pwYpnsgj9fE5R5I4U7
	 DRaneYJciJsX2Xn59YCkwmXK+apSjb2i4i3j2qQxi7U7zNVdaxhypPJVlpnug6pTEZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcP8S6t8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B36606A682;
	Fri, 27 Nov 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcP8S6t8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2803A1F00893;
	Fri, 27 Nov 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782357;
	bh=lnIqqYjeXqPPSZa+aej0B5CBul0phvtQ8KiVL9/wl4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcP8S6t8a0tp6B00sALT4aIOpWQUglo7wF22WnppBJbF1JOPU0Og4E4JBeBQ+rJzh
	 7S3t8T9X5nLGPtwsHOR0EeziYdCMzlWHDA+b6S8UnlsANAEm+oxm49MyvpEtDx+JI/
	 /baTB10Dj0E3adVrlQNsW99WZ5ucrpy8M5E79pmVCYWfZu1fn6LBr6TR1mqlqIezJJ
	 gUvKF9mkghKAh7lFok0SAnZtPbuZC3V2jYH7Q11YNFN7X+sDjVrINLjUykcrbMzExW
	 F1LAZcVDyonOjZwQkVYNTAl3SlncjPccHD1zMjEF80FiBM/pc0I4JjE4GWIoYGt8os
	 KfHjKaGkeqmtw==
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
Subject: [PATCH 3/6] kho: move kho_{block,radix_tree}.h into include/linux/kho/
Date: Fri, 27 Nov 2026 12:25:29 +0000
Message-ID: <20261127122536.3708770-4-pratyush@kernel.org>
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

Hierarchical file systems have been around for a while now. Let's use
them.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 Documentation/core-api/kho/index.rst                 | 4 ++--
 MAINTAINERS                                          | 1 -
 drivers/pci/liveupdate.c                             | 2 +-
 include/linux/{kho_block.h => kho/block.h}           | 0
 include/linux/{kho_radix_tree.h => kho/radix_tree.h} | 0
 kernel/liveupdate/kho_block.c                        | 2 +-
 kernel/liveupdate/kho_core.c                         | 2 +-
 kernel/liveupdate/luo_internal.h                     | 2 +-
 kernel/liveupdate/luo_session.c                      | 2 +-
 9 files changed, 7 insertions(+), 8 deletions(-)
 rename include/linux/{kho_block.h => kho/block.h} (100%)
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (100%)

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index fc759213ddb9..b09547e10ba2 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -83,7 +83,7 @@ the next KHO, because kexec can overwrite even the original kernel.
 Kexec Handover Radix Tree
 =========================
 
-.. kernel-doc:: include/linux/kho_radix_tree.h
+.. kernel-doc:: include/linux/kho/radix_tree.h
   :doc: Kexec Handover Radix Tree
 
 Public API
@@ -98,7 +98,7 @@ KHO Serialization Blocks API
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :doc: KHO Serialization Blocks
 
-.. kernel-doc:: include/linux/kho_block.h
+.. kernel-doc:: include/linux/kho/block.h
 
 .. kernel-doc:: kernel/liveupdate/kho_block.c
   :internal:
diff --git a/MAINTAINERS b/MAINTAINERS
index fa9ee8051139..4469f9978ecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14784,7 +14784,6 @@ F:	Documentation/core-api/kho/*
 F:	include/asm-generic/kexec_handover.h
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
-F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kho_*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 76e939ea52eb..d99d2eb4e2ad 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -207,7 +207,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/pci.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/liveupdate.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
diff --git a/include/linux/kho_block.h b/include/linux/kho/block.h
similarity index 100%
rename from include/linux/kho_block.h
rename to include/linux/kho/block.h
diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho/radix_tree.h
similarity index 100%
rename from include/linux/kho_radix_tree.h
rename to include/linux/kho/radix_tree.h
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
index 0d2a342ef422..6cedcd36bfd2 100644
--- a/kernel/liveupdate/kho_block.c
+++ b/kernel/liveupdate/kho_block.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/block.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/slab.h>
 
 /*
diff --git a/kernel/liveupdate/kho_core.c b/kernel/liveupdate/kho_core.c
index 7544bc0b99e5..3f9d408b9d29 100644
--- a/kernel/liveupdate/kho_core.c
+++ b/kernel/liveupdate/kho_core.c
@@ -18,7 +18,7 @@
 #include <linux/kasan.h>
 #include <linux/kexec.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_radix_tree.h>
+#include <linux/kho/radix_tree.h>
 #include <linux/utsname.h>
 #include <linux/kho/abi/kexec_handover.h>
 #include <linux/kho/abi/kexec_metadata.h>
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..6c034be2d390 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -10,7 +10,7 @@
 
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 
 struct luo_ucmd {
 	void __user *ubuffer;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f1b86f701238..1ed914db513d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -90,7 +90,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
-#include <linux/kho_block.h>
+#include <linux/kho/block.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
-- 
2.56.1.839.g22a8290db9-goog

