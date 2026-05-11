Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633F3CCFBD
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543323; cv=none; b=G0tN6a+ee8XoEqTcagt01WDbf93uTcIXMPiAzLpKChwBzl7NhbZCos89QbWsJvbGS92snOQWRMPgxRtjYRJf6TBjtlRBLu9sdnYW48sALdMKN9KnCG/Oc7Jasglttrlabq1bw1Gka1RppEVHGhFwfb2yhzW2Qn8O/7KV7gF2+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543323; c=relaxed/simple;
	bh=nkhAcR/a501eLQKC6FcCHdjPYtswgNMRUI2YsbdltG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=exBZi5qmA3TZbPKPB+6+X9iOkzP2a6Nipv5hv8Poq9lCMWYlOF360c1kUbm2xN/ERpuZdloCU5qZ+Ju1G9JI0LpL5SXh3zDkOaM4sTXtIFWlzQgDq7yvN8yWhWK5RKMwLuYweCjIlhLTYXxuD1tbrKHfZ7NjTaSFd+VwcdMjeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdK1nWgw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdK1nWgw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba3245a43dso37820945ad.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543320; x=1779148120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlR7sP3TmIVuCVXTiNbI5bhyf9pBSqUWeLZMdRUzyiQ=;
        b=mdK1nWgwsfEfJWdHHftnr/w4TxqPPnnZXTjLi6bEQv1p1xKQMu/adtbyOdHuFFgfvf
         MEdzxt/EQ9IWRU4Nuw8YS4AfoeGJkduuLa0XJfFUZRIMC8K08y3qtr0ipQVbM1JIGCsd
         JSw4Sopsd8PyxTZVxAquO8eK/Um2GVGzWPDKLMg1r7cTo4/lC4gPio7HZ2f3qeM6Tf+U
         EyaOztW3Bs/b2svYVn/XKT/2WZodl0Gj9H8yBaCBucYLYjGte8BcwJugmqn60yngrxY5
         8cOr7toZ8O6QJVh9DrfOTD72g0/OAke4CRJZgOvprBF3GRL5o86IFKSBw5ndd4l6Dp5b
         BidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543320; x=1779148120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlR7sP3TmIVuCVXTiNbI5bhyf9pBSqUWeLZMdRUzyiQ=;
        b=DrecIL3thVxtg8/3iJXv3WpYhPPRyWidNOjcYNdrtxQFXJw1H7jGd2eeCWorlQU01w
         71/2dsxILolp4MbKqHS7oDFEsMuk2OxsYiUTlCB/u2IutRxYUciDC4WJStw3XerypSJp
         a1xDaHW6ZJMyPibMdYJowFDpIz63ynALkvLt7Ky6Uv6XyFxa8/SGgQ7f1qyM3FAw/JC3
         kxRjiWr3m2XLvg0HN6j2PUOJC3CZ6JKaqMrhuPfJ+0D/Und+CfIlwhV8y1UWD9r39L4r
         QIFGHECn51YB04z985xxhxOEoKM1StSzu5woUO7oPSWEG+1BCrM1K80coWj3zUzhp7x6
         R2TA==
X-Forwarded-Encrypted: i=1; AFNElJ94WNdxRaCdHAFl6AQt6eC0MSmsGOvkwU2XzDPcOg8u8W0hOD6Of6hSsteQTsXwk8Z6u3Osj0wGtys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxQzAUKwAp4SsUEcSJbpGOy6/L/y/HYyQZRnuEpTxY3zMA4TU
	cEZ9O+SwFYrdzqLD+nx+tm/FYiuCIk14SwlhrMbeSVqYR99r7xm9B+426DRCwLpcT7CWE50J3ic
	eEJvd7LCQDg==
X-Received: from pgwb24.prod.google.com ([2002:a65:6698:0:b0:c74:42:899a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c5:b0:2ae:cb0e:fd59
 with SMTP id d9443c01a7336-2bd010f3972mr6895335ad.8.1778543320035; Mon, 11
 May 2026 16:48:40 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:57 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-12-vipinsh@google.com>
Subject: [PATCH v4 11/16] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add Makefile support for TEST_GEN_PROGS_EXTENDED targets. These tests
are not run by default.

TEST_GEN_PROGS_EXTENDED will be used for Live Update selftests in
subsequent commits. These selftests must be run manually because they
require the user/runner to perform additional actions, such as kexec,
during the test.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index df3e44660bd0..ad081ec31fb2 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -32,14 +32,17 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES := $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O))
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+TEST_DEP_FILES := $(patsubst %.o, %.d, $(TESTS_O))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O)
+EXTRA_CLEAN += $(TEST_DEP_FILES)
 
 endif
-- 
2.54.0.563.g4f69b47b94-goog

