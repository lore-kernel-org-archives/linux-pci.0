Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286948;
	b=K2uTbDf2KfM+xjETD63doJE2YqDHOfngP01juBnb0iCy5Q5ufh0yd2ivuG21c52vaRjK
	 W+9zhfykV8uwnLrZ4UqcuPvVW8ZHN8UxEKEWJMtjQu3CrDm2QVE8b+pYmlR2BAmMOXg/Q
	 Z6VmPQW6iwCizrYUgS/Axvsac6rVJBJ08n7rjpwCULPeLrDWbGlpE/sqSlPtI0vpKUsjI
	 Q+HVJmFAm2uKnYPK75Pq0imJmQYkQnCBfxnzPJ6vFWvyFqiwjLtMzfjSSRkV1gkJffNkb
	 d/PZjEOBNbHnar9nzV0fh1PhtQ84Y9L9s3t9caCVpSiEaqhQ3RqXnTJ55zZ35AdDmeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=;
	b=3FraXqVwng7hCImpxJvNLzti1S2WLALvvqvi1bczJET+AZLKE3fjIK+0PABacNyREZXJ
	 S0YePaY0vC55FXoBMYh5JjGZiD9cT/+fhg+ub6U9mtSeygbstI6PXbaSfJbAiGWQQpAuT
	 Sj/gIvMnlWaG2ZnHPYbkNU2dhPyTgMci6McOMHurDMHbP2aBfCD2nZfgV8zygSkyretTm
	 AgevawbjPxP7H9/JowNMyFWUZoT5UbNIbPLsk34DNZJumrrfRKS6zNDTfj5sTW7WCkVPT
	 u4M7HUP4wUIHnU3XQMtKjpQ9ZCHzjOckt17TAQMr/FmRzYuS3g8IZAe707o/+DutQVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n7DrnAkO;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331B606A330
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3331B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n7DrnAkO
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c504bdea834so23669466b.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286946; x=1794891746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=;
        b=n7DrnAkOEYiYuDbFHtVEbxTbhsXXhUyIjyWuA6b4/0RuSysExzjm+K35LNrvLFziMc
         fGfE2n/Z/EP4b5U4EaJsNr1KYqJLipt5plqiq9ZJW6EnFg0zLS3DDO2axvl0eRx7YoF5
         VZiuDoGTga3OPuKoeilyKGWPzZId5t5YIJdHyP2XM6U2TkNfrfcSG+6G0er4NegsupUf
         XyVSaWpQRooSMPTgSStu3lMkjT+sc4Q8uE/vPGIR/Z7mOosgJLoiiU67/YTdp0RB3Atd
         jJIYxP2jJURPpzJ8o6VBsg2bscjY0s/uaJK0czgdOaQOwhFNVILsIcmdoD6mDo+IU55K
         EsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286946; x=1794891746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=;
        b=qnlFSGQlDYZyRI3VCO/PTcuc/4b3Q2l7iOT4ehR/t+4PTzvyA1v7rxmFJVZea9SWh4
         2fZBaqeCDo/YgwsvlZNptmdm2BpVrItuGKKM/fsYGsfpIHe6g+aiLgKMyN2wWELhfVzM
         vW5r87zalUKlXz00cxdq9teBFx6tfl1waFp9/iOLdXwGEr7NybXhR9q3phTOfkcKfHf0
         dqta53xO/0++G3KBvyI3tIoHmRlSPtWoycL+eBt4zSVYjOdFeJHHL3llf2rdp3PjAV33
         8elY+hs7U1q14oAbCjRnjwq6lWlmwPg3UKlQGLaHHPTNRvfliKxYls8Ft5FMcu77ugf3
         spFQ==
X-Forwarded-Encrypted: i=1; AL+hErFXajd6YnestjnzVhsh/KPl6u9QJfaCh1eOtUIEqzadI1/n3zLS4/maGlJkHdb7a6eYuaTXx57Y3fA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f1XnTGUIWxGJ5+QRCMR7O7X+DhuTbF4UuaL8iTLvu7NmifIjv
	HTrMQ8sQI3dP0Od2h+ntSQxuH3o7yS/CWBkX0M8/exsW3gFP/ky/jPwkae5pnDKmc1qpjsnVz0v
	XxPqltjTotMe1ZNXzJQ==
X-Received: from ejpc8.prod.google.com ([2002:a17:906:54c8:b0:c3f:c35a:7704])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d0d:b0:c49:a571:c4f9 with SMTP id a640c23a62f3a-c50494b4c4fmr100815566b.13.1794286946299;
 Mon, 09 Nov 2026 21:02:26 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:02 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-20-tarunsahu@google.com>
Subject: [PATCH v4 19/19] kho: Add KUnit test for the feature header helpers
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a KUnit test suite in lib/tests/kho_feature_kunit.c covering
the Kexec HandOver feature header declared in
include/linux/kho/abi/feature.h.

The suite contains three focused test cases:
- kho_ser_hdr_zero_flags_test: verifies zero-feature header
  initialization, payload sizing, and empty feature queries.
- kho_ser_hdr_set_get_test: verifies DECLARE_KHO_SER structure sizing,
  header initialization, payload pointer resolution, and 1-bit
  feature flag setting and retrieval across flags entry boundaries,
  including out-of-range queries.
- kho_ser_hdr_validate_test: verifies __kho_ser_validate rejecting
  unsupported required feature flags while ignoring optional flags.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                   |   1 +
 lib/Kconfig.debug             |  13 +++
 lib/tests/Makefile            |   1 +
 lib/tests/kho_feature_kunit.c | 184 ++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 lib/tests/kho_feature_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1572f6c905aa..0b50de45140f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14786,6 +14786,7 @@ F:	include/linux/kho/
 F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
+F:	lib/tests/kho_feature_kunit.c
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..3d74d32b181d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2967,6 +2967,19 @@ config DIMLIB_KUNIT_TEST
 	  For more information on KUnit and unit tests in general please refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config KHO_FEATURE_KUNIT_TEST
+	tristate "KUnit test for the Kexec HandOver feature header helpers" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the Kexec HandOver
+	  feature header helpers defined in include/linux/kho/abi/feature.h.
+	  It checks the feature flag encoding, the flags array sizing, the
+	  feature bit helpers, and header validation rules.
+
+	  The helpers are self-contained, so the test does not depend on
+	  CONFIG_KEXEC_HANDOVER and can also run under UML.
+
 	  If unsure, say N.
 
 config CMDLINE_KUNIT_TEST
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b91f..f22a4552f755 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
+obj-$(CONFIG_KHO_FEATURE_KUNIT_TEST) += kho_feature_kunit.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/kho_feature_kunit.c b/lib/tests/kho_feature_kunit.c
new file mode 100644
index 000000000000..db36895d53f5
--- /dev/null
+++ b/lib/tests/kho_feature_kunit.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Kexec HandOver feature header helpers
+ * in include/linux/kho/abi/feature.h.
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Tarun Sahu <tarunsahu@google.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/kho/abi/feature.h>
+#include <linux/module.h>
+
+struct test_kho_payload {
+	u64 val;
+};
+
+enum test_kho_req_feat {
+	TEST_KHO_REQ_0 = 0,
+	TEST_KHO_REQ_63 = 63,
+	TEST_KHO_REQ_64 = 64,
+	TEST_KHO_REQ_69 = 69,
+	TEST_KHO_NR_REQUIRED = 70,
+};
+
+enum test_kho_opt_feat {
+	TEST_KHO_OPT_0 = 0,
+	TEST_KHO_OPT_63 = 63,
+	TEST_KHO_OPT_64 = 64,
+	TEST_KHO_OPT_69 = 69,
+	TEST_KHO_NR_OPTIONAL = 70,
+};
+
+DECLARE_KHO_SER(test_kho_payload, 8, TEST_KHO_NR_REQUIRED, TEST_KHO_NR_OPTIONAL);
+
+struct test_kho_zero {
+	u64 val;
+};
+
+DECLARE_KHO_SER(test_kho_zero, 8, 0, 0);
+
+static void kho_ser_hdr_zero_flags_test(struct kunit *test)
+{
+	DECLARE_KHO_SER_HDR(test_kho_zero, *fhdr);
+	const DECLARE_KHO_SER_HDR(test_kho_zero, *const_fhdr);
+	u8 buf[kho_ser_size(test_kho_zero)] __aligned(8);
+	struct test_kho_zero *p;
+
+	KUNIT_EXPECT_EQ(test, sizeof(struct kho_ser_hdr), 8UL);
+	KUNIT_EXPECT_EQ(test, sizeof(*fhdr), sizeof(struct kho_ser_hdr));
+	KUNIT_EXPECT_EQ(test, kho_ser_size(test_kho_zero), 16UL);
+
+	fhdr = (void *)buf;
+	kho_ser_init(fhdr, test_kho_zero);
+	KUNIT_EXPECT_EQ(test, fhdr->size, 16U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_required, 0U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_optional, 0U);
+	KUNIT_EXPECT_EQ(test, kho_ser_hdr_size(fhdr), 8UL);
+
+	const_fhdr = fhdr;
+	KUNIT_EXPECT_EQ(test, const_fhdr->size, 16U);
+
+	p = kho_ser_payload(fhdr, test_kho_zero);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 8));
+
+	p = kho_ser_payload(const_fhdr, test_kho_zero);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 8));
+
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 0));
+	KUNIT_EXPECT_EQ(test, kho_ser_validate(fhdr, test_kho_zero), 0);
+	KUNIT_EXPECT_EQ(test, kho_ser_validate(const_fhdr, test_kho_zero), 0);
+}
+
+static void kho_ser_hdr_set_get_test(struct kunit *test)
+{
+	DECLARE_KHO_SER_HDR(test_kho_payload, *fhdr);
+	const DECLARE_KHO_SER_HDR(test_kho_payload, *const_fhdr);
+	u8 buf[kho_ser_size(test_kho_payload)] __aligned(8);
+	struct test_kho_payload *p;
+
+	KUNIT_EXPECT_EQ(test, kho_ser_size(test_kho_payload), 40UL);
+
+	fhdr = (void *)buf;
+	kho_ser_init(fhdr, test_kho_payload);
+	KUNIT_EXPECT_EQ(test, fhdr->size, 40U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_required, 70U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_optional, 70U);
+	KUNIT_EXPECT_EQ(test, kho_ser_hdr_size(fhdr), 32UL);
+
+	const_fhdr = fhdr;
+	KUNIT_EXPECT_EQ(test, const_fhdr->size, 40U);
+	KUNIT_EXPECT_EQ(test, const_fhdr->nr_required, 70U);
+	KUNIT_EXPECT_EQ(test, const_fhdr->nr_optional, 70U);
+
+	p = kho_ser_payload(fhdr, test_kho_payload);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 32));
+
+	p = kho_ser_payload(const_fhdr, test_kho_payload);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 32));
+
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_0);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_63);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_64);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_69);
+
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 1));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_63));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_64));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 65));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_69));
+
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[0] & (1ULL << 0)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[0] & (1ULL << 63)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 0)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 5)));
+
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_0);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_63);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_64);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_69);
+
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 1));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_63));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_64));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 65));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_69));
+
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 6)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 5)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 6)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 11)));
+
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 70));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 100));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 70));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 100));
+}
+
+static void kho_ser_hdr_validate_test(struct kunit *test)
+{
+	u8 buf[sizeof(struct kho_ser_hdr) + sizeof(u64) * 2] __aligned(8);
+	struct kho_ser_hdr *fhdr = (void *)buf;
+
+	__kho_ser_init(fhdr, 0, 4, 10);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 4), 0);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_optional(fhdr, 0);
+	kho_ser_set_optional(fhdr, 9);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 0);
+	kho_ser_set_required(fhdr, 1);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 2);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), -EOPNOTSUPP);
+
+	kho_ser_clear_required(fhdr, 2);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 3);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), -EOPNOTSUPP);
+}
+
+static struct kunit_case kho_feature_test_cases[] = {
+	KUNIT_CASE(kho_ser_hdr_zero_flags_test),
+	KUNIT_CASE(kho_ser_hdr_set_get_test),
+	KUNIT_CASE(kho_ser_hdr_validate_test),
+	{}
+};
+
+static struct kunit_suite kho_feature_test_suite = {
+	.name = "kho_feature",
+	.test_cases = kho_feature_test_cases,
+};
+
+kunit_test_suite(kho_feature_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the Kexec HandOver feature header helpers");
+MODULE_LICENSE("GPL");
-- 
2.56.0.506.g506a7eabc5-goog

