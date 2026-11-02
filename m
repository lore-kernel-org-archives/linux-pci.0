Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633841;
	b=iZwb95HVOQz88uWhEmKnZabVg6/Mlzy+CIVj2MxiL2KyC0d9NregnsV4pKQ4GsbA2kXW
	 5S7PpRqmmtVqgl6T6yK6abduh9iJ3ZyY484VO++F/j0L0lmKTZNi9O077RZmglwXIn67Z
	 2Avl/fw1WWklRmUggQ/jfwHqHJ4X0K6cq7WJoKO+w/0o6FHbU6iQ2xJTBUpAtMqC10mmc
	 jhAa1UPxGgltJKRsVHKnMdvpk+42WJ78q+8jbpxezFvZP4djlNoZOanYLGkpwkCG106Zr
	 fPOEMJo3FUT3H5aLpZNbuTnvkozSK3upqPnjCcR0020RQOjfiywBJmJGfx4Dtdh8JGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
	b=j3dP3UjlKu3pkEj2K8CyqKtq+irLgK44ikQ6pK1e38feKTpp7XrkzX5rp7ONCRrxMslu
	 FSH6vVpsNjD2vp2pZeitDcnRBiULGTxIiWLDqwA8QSz3BP8pZdm46b7GhdNuEE1+YACam
	 lQFZhl4g8oZXD6lsyCYil6odQIuCSd+cWnfJePhoYuvvC7/znbvkjg4Nko1cwCavJyuaq
	 nq5y9iRLCfkOUjndetx/I8ZsxSRDj8x7P70e9zohPjXQ94YaffrytXKGWjO0YtUNg0bS/
	 6iHZXacuvm2331yCpFBed/BSOa/jgBX22wGrdrMZ2AA/U03y6CQ8Vh9uto9hgpWyJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NSzJydZv;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F260EA5FB
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 15:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0F260EA5FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NSzJydZv
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e601800e58so51290035ad.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633840; x=1794238640; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=NSzJydZvMVXYxTC62CIB6ze6cmzNxnlcYaAgAV5q0w8GPnprJgO1rjDotE1ldsqVF7
         id7VY8rj8sVMHSKlTmzi/PwHWNeII+QwqojnCqdiqX3PxCO2GIn3vjlHmseHkMN5XYqg
         BYPAspktX6r0+V8A2/zX1+AyJq1DpXHLE0LDtoRiJxXMg8DAr6vPt8WXhLgLQF8ebD15
         QcofgRuBHeqjWN5y9E3jlhTLHW98sFut6vpM+lSkpNsQsFyL3sjc0/ACce80N8Qbe8HF
         sfB8sbQFa0HOWibvXSBBCPqGq5tFavtJkOEq49CN4uJoCYR6CeAVMFVKwOily0i0nNoJ
         IFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633840; x=1794238640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tylWbFCUgeCOXBn9trkYSMBYVlhA9mV6Qs1lbXsCOco=;
        b=1TPksjxbttJ1JfOEfRZ0B/ryRm+SksZrQEmWOuWFkEGp556XgxyRNooE4CwAzNTt7z
         1uCYYqYh99XIXga1A5Fe70G/BttIVP8Na3/XtENdmoekTOUKeFQE9ZY5+OKt+Zeczksk
         Q/VY4V1VeVjaM/Zyxry6CPkyiV05pCL2IKQp5kzPXzTO67pdjNutLv5jDjpLXBBRyuYS
         ziaUJul9IqKLJtsZ/nkRrKfnWzBy++knnxxkgQCNlv+IGMzGIWBTiwoVaKXP6lG/6d7F
         KVUgz8DVPaJOQFWdwNA4PdcHylP1axNK+JPC15C2ttwlNDEkuRohrvqxtV8xlSoBwy2w
         2wUA==
X-Forwarded-Encrypted: i=1; AKwUvBzCp4y3sA3v71jR+aEIbbD/LRFV0LmIu+qDrsRs73eWQbrceM8z23wVljJxbP6RBjSIr1jz2q64++Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DDiorBSC5dSHvnVaPYwAse00EZabdspkMqquchA7nHxyF8rzt
	GJJEd9SBE/ML2t0590D2r0TsDXPGrEOe53d6whU/PzP6bczcKNZHIOTfKBXF7hzFdrsH3Srell6
	Mmw22m2q7tg==
X-Received: from plbix15.prod.google.com ([2002:a17:902:f80f:b0:2ea:a5c1:240f])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c7:b0:2e8:b5b2:a9f9
 with SMTP id d9443c01a7336-2eb364e9f75mr92959155ad.37.1793633840266; Mon, 02
 Nov 2026 07:37:20 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:48 -0800
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
Message-ID: <20261102153656.1431701-20-vipinsh@google.com>
Subject: [PATCH v6 19/27] vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
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
 tools/testing/selftests/vfio/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index c2764fcef31d..ece2a3618f2b 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -34,16 +34,18 @@ LDFLAGS += -pthread
 LIBS_O := $(LIBVFIO_O)
 LIBS_O += $(LIBLIVEUPDATE_O)
 
-$(TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/%: $(OUTPUT)/%.o $(LIBS_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBS_O) $(LDLIBS) -o $@
 
-TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-$(TEST_GEN_PROGS_O): $(OUTPUT)/%.o: %.c
+TESTS_O := $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TESTS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+
+$(TESTS_O): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TESTS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
-EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
+EXTRA_CLEAN += $(TESTS_O) $(TEST_DEP_FILES)
 
 endif
-- 
2.56.0.317.g454f8302e1-goog

