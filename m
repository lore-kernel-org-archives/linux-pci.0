Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782366;
	b=y9P8AgrZtvq0gU0cvZmiAyGt96Xl7xNo8fbEU9iSj09f7gXBBfbg7N/UVG9VdjOBL/Jc
	 Zf0klpiYgS3ydF1m73u3JBZinNvGWfoZVObLZcwzuPRKZQ1H9Tm8CCFCqoQlUW1BHMIkx
	 X9rqRTpCgaFXCpTjWscDjWBV79LmwjWmyavV7eCn+vJgQs/+6fTOjW9ANBTMf0PKIPfOJ
	 2BbVPpQfWgY0S7jSz8vyHk9/xvLUkQDNwpayw8kp1VI65tHgdKHyJYiu/ejy2UkbCr0mD
	 Tq7uE5TihgArVcolEgUilA8hLDlacK8QjpiH08/0Vy4wreDDuclOP9fcm4bayLU7sXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bg93s8E2qpiOXI1yg+RWP0SFq8cNRtNnpPDwdNib6R8=;
	b=Hzep4rZaSo5pFxqbNCJWHdbTD1gvh33tAXGR3NnF0k6SFzv5pN0wBiJ41/5vbzAJyeRv
	 l60BPvEUcfEKsBoCpvB1RpYDrLeCv2oVHDqFm95KY8RN6EASzFvD73sX/pyu7xLI4iVS6
	 BwjEp8YpdiuzPQ9j+UgVtrsIIPemsrJPBl3Bd0lXda2LinHMy9BBngXpLjpXwp/Oc+jt7
	 pfLUt8Obidhdkd00uL6uxrO2o+meGsNwaDCVjkS4tbZnEkYmcQdd2lMpVI3CbJAuUB66f
	 gRR3LN8qnyd766qS1vNWvhYnwPSzqAC2XFTCeuYeGJkFdv+W6y0KME59oJv5vUSMXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0IIX6t+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D71606A338;
	Fri, 27 Nov 2026 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0IIX6t+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1371F00893;
	Fri, 27 Nov 2026 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782365;
	bh=bg93s8E2qpiOXI1yg+RWP0SFq8cNRtNnpPDwdNib6R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0IIX6t+zutMiF55Susal3PFvq6aiLSRkmxkwqPipXuMFrZ93zliUC5V2CKvPwfdQ
	 krRhxyZjzHgjMJXE6FWBLzxTw73NHDgXMGmglqeselfTCPTNx30Xv6xv59vp2KWumb
	 eM9M6RX5iSa+q1vc1gt8I7WY71fPqlxMbqOTJ/J8WRgvaoRzE/tlkNOEj9+3vZFA36
	 KhmaJZedzie2/kNbRDe7B+NTJheXmcpOqX6JOTPLBUoafGU8IErF1ucWcpBjtArpiz
	 Roq3DD1iyJaiquku45grPzzBTugp3kwhQ6cgusx6rE/XoMzx54PyZBvaOvBRuNXMvi
	 ePpFfD2N+Q1BA==
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
Subject: [PATCH 5/6] kho: fix kernel-doc return for kho_alloc_preserve()
Date: Fri, 27 Nov 2026 12:25:31 +0000
Message-ID: <20261127122536.3708770-6-pratyush@kernel.org>
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

kernel-doc complains:

  No description found for return value of 'kho_alloc_preserve'

It does not recognize '@return'. Use 'Return' instead.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kho_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kho_core.c b/kernel/liveupdate/kho_core.c
index 3f9d408b9d29..580cdb3ea070 100644
--- a/kernel/liveupdate/kho_core.c
+++ b/kernel/liveupdate/kho_core.c
@@ -1584,7 +1584,7 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
  * Note: The actual allocated size will be rounded up to the nearest
  * power-of-two page boundary.
  *
- * @return A virtual pointer to the allocated and preserved memory on success,
+ * Return: A virtual pointer to the allocated and preserved memory on success,
  * or an ERR_PTR() encoded error on failure.
  */
 void *kho_alloc_preserve(size_t size)
-- 
2.56.1.839.g22a8290db9-goog

