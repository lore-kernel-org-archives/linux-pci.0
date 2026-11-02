Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633838;
	b=Btv94pKodgfS6U996JFXmFXbfxt92P1FRe7j7AENYTPoHL4sgNYomezMmaKwMbp32mUg
	 5ba+fBT8bW0OBFU2d86hSxHe3KVuBOvoRxaiv5kfMyo/VL8wS3w+e0jQ84OaNQ+OuJ5ct
	 ktuyqRXKsi55csiA0FIy26UQdLZcg/6CvKzu6r+xDZ2dRqhGNb/Js3n4PaM8IoQ8bDxyB
	 Y69Dvwf7SL+raQxlAElCfG6R23Bm1EHx+wtcYEGmVJI4MxTF496Iugq+2jXYDisBKwW49
	 bnpe4rqTlMJK7rDjyBKH4LpXfcBliCn0jJZ5mv4iIi+YHFWLsGOxI8Hp1WIUfa9Y3fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ms8itCh4PfqJV6uxhFhSbZGdhGd+gOvwo6FEHxIUACI=;
	b=rYWHUycfs4fu6NGS4jZ7koxOs0Q0QNbkfc/xoZUyAzoJsC69Ye7AD4aoK/IdSPi0hJ5u
	 hL14A5Bqz586xnkD/F1I6yZFHbMWHbPLqaM2engSWW4dfomVzi0Dnsr0IzHNzt6s72XKR
	 G7qkoZ70Kbkq60yHPKmXk8M0sChFnXNFVpcM0yejlZS8e207KqVr7LO+d5WBOQPSqAQAP
	 5HDrLte9Yn9f0O9qAP1hGu3uM/dh5n9mr5f4kUYCfgoA0HzJ8le30Dtbe64/NEETqd9jD
	 FPPj0NViZaJKfKFyalUqnI/2qCtsmITK6BwwtIP6ZrS04YEWoH6oc4M7RsTKrsgcXJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldmIxEXD;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5B60A7F2E
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA5B60A7F2E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldmIxEXD
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e93e2f72bfso53692915ad.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633837; x=1794238637; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ms8itCh4PfqJV6uxhFhSbZGdhGd+gOvwo6FEHxIUACI=;
        b=ldmIxEXD39zl4nBLfBA+4rAPOuHPhzzCv8bFjZBy6+XbPfYx4KLkY3ZU2wjDon5s+y
         niIiQ9IQm1w/Ilca+JlCoAy3hAXaDazpIOx3PPjC59/CzetAivWxfiHjkJx4mt9TCekG
         c+4ZdKaNMqTaXnCTL8k7Rrl7u2Wype1jgmXrs3vQTja/vWfLH7fn4ii2bNkjUjNhOCxV
         IsVYc8FWgiYai326JH9uRsrCg4jS9JUSDC7XCFPMzrEC5UOYE04Z2aSDYRCL+FzuZJZd
         SQjCUC9T4o0BHYtyKRmOZyw/dxcB0sqBFKb6NNqIRdYjOf2p9Ut6wbWM0Adpzk638EPj
         w5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633837; x=1794238637;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ms8itCh4PfqJV6uxhFhSbZGdhGd+gOvwo6FEHxIUACI=;
        b=OuI/dn0nhez7YpaUyt8DcdXhMPy2N040uFhG7tZDex+ieymeqzf9yE+WBKtbjhY8hC
         t9eSC7InoiU0Ep2gDa5MB37BnTjHpUErN7Q3z0ItewICs3UJeVow2DNhquCFTjYGqi6t
         SEHqHa+c3Pq6uIhUeDZPywddr0x0ylwR6N0LkFZJ9Dt7DMgviGgSsNz9JiVHcXh1YW0C
         uZ7UfXPnkN1acD9iDw16s3OGfCeDMFZvW16QdGTfjLlIL6zNA0hd9liRypk5TvbdYSNR
         sOQzQt3Ot2XTjAFp5DHEM/1wZO+aUx5xaKV+uJruC8iBC361sbaO90ayhrHwaTNoQcon
         CnzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3+zWl2HO6Y35rbcMDqi9+45nOk4fc5wQS9dbH41X9uv6yvzYwiXJhrUziA5swTAIR1592cf7QB6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dbqnkkW3Ws/lfRKuYsGGS3bIU2jz/fMubE2iWVDfLIS7tNaq+
	Aj9NPD2INZfl/fnUX12IB0z5Xj+n7WJmgiXTzCsalQJr5BaasJN0LZibaR8NVmCIMAABdv9R53s
	Gba8oqPuOXA==
X-Received: from plhs10.prod.google.com ([2002:a17:903:320a:b0:2e9:6b18:1067])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b23:b0:2e5:db61:e5d4
 with SMTP id d9443c01a7336-2eb3653906emr104135025ad.62.1793633836956; Mon, 02
 Nov 2026 07:37:16 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:45 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-17-vipinsh@google.com>
Subject: [PATCH v6 16/27] vfio: selftests: Build liveupdate library in VFIO selftests
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Import and build liveupdate selftest library in VFIO selftests.

It allows using liveupdate ioctls in VFIO selftests

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..55e1e1843090 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -21,6 +21,7 @@ TEST_FILES += scripts/setup.sh
 
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
@@ -29,14 +30,17 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 $(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.56.0.317.g454f8302e1-goog

