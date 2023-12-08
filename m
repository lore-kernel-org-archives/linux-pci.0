Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgiO9oMh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7E1AD
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702030400; x=1733566400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ayQBlaxTnDlCzbGQQHY4dehfaQxu0BkRszhJ5YsbzBY=;
  b=jgiO9oMhfeVz/QaVfBrvkapPlHvRWtWXloC3w4UKxSKd9sQp6t7pNORg
   ONLzDuRC1kAEF/rEwjFCGlgRym/MZYNA0uUgiqUYJSPwX6qsS8qYRU82O
   Iw8vKcVyrkGb6izAUvTD/I/mcChv5XE8w1SXqwgbRNwqumTIjLJjBF/lX
   ejhYPkCRmBA+quEW+gmu+MCXi7/c11VlcbR9qVYFGvGr1dN3zOI2A+OyW
   LWudnZSuqIYAU23bV/FH8hOIIEePkpfes79c2w6ZlNo9e3+Yt4R4CBfkI
   Q2EYkxsKGlwTO1izGnnhPrnZMmZLYCGhgsPkTDY0mtp5mHb/dYv8A+v0X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7745953"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="7745953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="801066488"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="801066488"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:13:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Martin Mares <mj@ucw.cz>,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] lspci: Add PCIe 6.0 data rate (64 GT/s) also to LnkCap2
Date: Fri,  8 Dec 2023 12:13:07 +0200
Message-Id: <20231208101307.2566-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While commit 5bdf63b6b1bc ("lspci: Add PCIe 6.0 data rate (64 GT/s)
support") added 64 GT/s support to some registers, LnkCap2 Supported
Link Speeds Vector was not included.

Add PCIe 6.0 data rate bit check also into
cap_express_link2_speed_cap().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Corrected the commit hash in the changelog

 ls-caps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ls-caps.c b/ls-caps.c
index fce9502bd29a..2c99812c4ed2 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1191,8 +1191,10 @@ static const char *cap_express_link2_speed_cap(int vector)
    * permitted to skip support for any data rates between 2.5GT/s and the
    * highest supported rate.
    */
-  if (vector & 0x60)
+  if (vector & 0x40)
     return "RsvdP";
+  if (vector & 0x20)
+    return "2.5-64GT/s";
   if (vector & 0x10)
     return "2.5-32GT/s";
   if (vector & 0x08)
-- 
2.30.2

