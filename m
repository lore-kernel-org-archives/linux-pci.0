Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782362;
	b=kkNWLxKTwYUfRrxBPH+8/HiZPSUS3CfRXKgqxBcX9DhcdKxRui3TFaP/spBKiSjgxC8T
	 zLg+CeS0h/GfOGIUTX8LkTm/3uFtY47lvQ8B4tLqK+kc+xpmg7FJP0dTOJRWSD1yJiWkt
	 jmL83ZHsnB7eGSkdO6Nghb/36Wb2unK8zVnO6fB9z9zt7XX/CtPVTOF17pXu98XP0ZprK
	 fN5M5rrZ23jMpGqasNYV8jNW9rfD5u/os3IIQYVi/VSW7ruNU+vRhFJH5GP7rx0sW52qf
	 Uyh2es4eZHbm8UoUfPfgCEt1gYa/eP3qY/ED1Sq0CZf5FKdEfmzgpY6XQno9j1X/AuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wO/IOEvgfeJp88G3JhgG/noxUD2JKBD20IHHFxKJYuc=;
	b=KEWdusu+n4xCDqJU6SDdiviAghbihhw/sFeNQzT+mGnXFP6fJTC7MrqYTeHhWPXPr3UJ
	 66ZSM1qMEkLWKaDRunoKei8pDJ+AoWpCOVxWTypVZCSfm0jMNbxa/ZSwFsPHp1ezau7Pz
	 qPRqboJh3txXc1qDVdZ0cnQAuCG89wfP0CBS0rc1R02kOI7jl5SdJFWBoxb6y4PUtUOsh
	 qRzyZin5aIfHAqH7siPMEq4uYlVfrJngpF5xRap+wIpdRMwnc4/HJNon6L85tWgatLvHF
	 yPmnCnzGvo3JXSSoN11meMzrzMAZheqJLf2kGNYryFUkBzkZHxUwAZPLu9FXuD6iK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW6u8bF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00936606A690;
	Fri, 27 Nov 2026 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW6u8bF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49071F00A02;
	Fri, 27 Nov 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782361;
	bh=wO/IOEvgfeJp88G3JhgG/noxUD2JKBD20IHHFxKJYuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LW6u8bF2kVNmuWmelsSivsj/jA5wffvdi1FVsMa7rCrDRU+cLnvmXnjGR0S3F8lPO
	 LOrTRj6a/JAKn+Gq3xSuQO7JUVjDJwaouUu7nd4dAS8GKHcBKYF930PNt8ZwwHF0AW
	 nKqXWh71uaU/BVIfWWajGCudQT9HMdSkeb3oFplARqAvV1SonkUm65FWTfaYQWbFjS
	 5jIZ98K93cxNnS4JzZKAv6rChjYiqXdfsDEquIKozcQgejaSHF6uCRo3emRX8gTPdO
	 lVwAZkwlLtUOft+qQqhQ+wchhSggb3UE+b3EVp3rL98D4TXA4i3uupInAHV3TaDw6M
	 bNy8IM7TEipew==
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
Subject: [PATCH 4/6] kho: use unsigned long for kho_preserve_pages() and co when KHO=n
Date: Fri, 27 Nov 2026 12:25:30 +0000
Message-ID: <20261127122536.3708770-5-pratyush@kernel.org>
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

Commit 840fe43d371f ("kho: use unsigned long for nr_pages") changed
nr_pages to unsigned long, but it forgot to update the KEXEC_HANDOVER=n
stubs.

Fixes: 840fe43d371f ("kho: use unsigned long for nr_pages")
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

---

I don't think this is stable material since there is no problem in
practice.
---
 include/linux/kexec_handover.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index ef2b188c8ed0..a20456b8da20 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -66,12 +66,12 @@ static inline int kho_preserve_folio(struct folio *folio)
 
 static inline void kho_unpreserve_folio(struct folio *folio) { }
 
-static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
+static inline int kho_preserve_pages(struct page *page, unsigned long nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_unpreserve_pages(struct page *page, unsigned int nr_pages) { }
+static inline void kho_unpreserve_pages(struct page *page, unsigned long nr_pages) { }
 
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
@@ -95,7 +95,7 @@ static inline struct folio *kho_restore_folio(phys_addr_t phys)
 }
 
 static inline struct page *kho_restore_pages(phys_addr_t phys,
-					     unsigned int nr_pages)
+					     unsigned long nr_pages)
 {
 	return NULL;
 }
-- 
2.56.1.839.g22a8290db9-goog

