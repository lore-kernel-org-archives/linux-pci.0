Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972692;
	b=rBaZy68UBvUymS95lLLRTrgHhDGhClCvYoUPucqKjMHNlu7F70wlwPg7vz+gQMYtRqum
	 USl4/6fKaTP4Kwms+rDL6TgXFQobDlWg4vt6qM8WHVaXOsAPF0nBHp5ajdW0HKlNgscbn
	 22oQQaazHXSbUzpPyGcSz8yXbd4LlCCu1kEhTe+vPKPx0gtWiEQlgjtuojl+r46KR2Tni
	 WvdjUlKJ9us6bVRYlyqgTJDXe3iPfpJJyP4vfv/7YnMbpa5yq6CtgfOwjiwNpY9pD54bK
	 +1jUtiFY6RaXC7UFQk9sSKIB+ojN8Z6sdSIwZxZBgZawo04tpBax0v5SFQPX2BgLC6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972692;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9gheLm+VrTCNAQ4UGXyx+paCO9Wy4x6FjdUJiEV/0ok=;
	b=Kt/ivJk/YFFQFA+xsdzbTVn9RoeUT7WqJ4AK9iKmic9ZQMa43DXI0yDb9+F/+DCF0gOU
	 FyRM6HVjvGjCMfy1rD24V3HkAIPX5FnR0DEBvcZC+ni/5koSU4ek7iy1GEn7O7hGMl/23
	 eH7/dpY8/JI8sDyg+mo8QKCMyvTiu9t89fZ0RxElGSkQh1aew3nDBTYK7IpLXd/Mp4JWc
	 pEftAlYNFdz9qe5FnlyCRaZe7DjpFyLI5Scp6veu+UmTpS+Ob5IXnjcPZ2xYC4glaQshj
	 5xgJTcAsItptKG7+uNLeli/RW4LKqHsudt44mLzN0zUY5WbavvlmtbwoKxcBq/DapBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrDJ6y23;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B796082BDA;
	Fri,  6 Nov 2026 13:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B796082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrDJ6y23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972691; x=1825508691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHgZ5n+nW4s1dR5oYDFTayexC/qFFLbAZBEfXhXqasY=;
  b=WrDJ6y23p3WOX743NsY72wsuP9ZlueTV1Frzsk8i3mKeD06dqI16P/wB
   kQDS2WyJ2SSVeb3x791CqY3qMlQo50aiappwJ5+7gYrHRGIOCPCMcEiv+
   EFBvZ8Niq6ryYU5CUyMJrj6KLiAoPP5FLkbdS1HQAverBiNwbfizUYmtg
   XRav9pT0cNgdeBA+SeBVqpW6+CyDY2xXLxC/1hr8xz4IGjGymO8NLPo78
   G0PMBpaYSkUo5W2qMLHLMdpsRYmbHkTCxVuI/VQUHDwAbKFzZ7vU2romq
   AO/LlFQwPKMUkj6tBoU9dLFU6D15djKo30mcIXpFouqMTdA6WILhzt6zz
   Q==;
X-CSE-ConnectionGUID: MAirx4cBQcmDZKBWnAVkpQ==
X-CSE-MsgGUID: yCNcYQOeRguG1RzRtmveOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2686101"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2686101"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:51 -0800
X-CSE-ConnectionGUID: 9mfABZk4RF6M1osGH5gH6w==
X-CSE-MsgGUID: ID03V2v2StCsauG0W7IEDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7327664"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 06/14] linux/log2.h: Add 64-bit roundup/down_pow_of_two_u64() variants
Date: Fri,  6 Nov 2026 15:43:27 +0200
Message-ID: <20261106134341.39493-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generic sounding roundup_pow_of_two() and rounddown_pow_of_two() are
internally based on fls_long() that limits types to unsigned long. The
type limitation is unexpected and undocumented.

Worse yet, the typing seems also inconsistent between
__builtin_constant_p() and __roundup/down_pow_of_two() branches, the
former using full 64-bit size and the latter truncating type.

The most sensible way seems to be eventually changing types such that
the return type for roundup/down_pow_of_two() is the same as the input
but it requires auditing all the existing callers that have mixed
input/output types.

As a stopgap solution, add roundup/down_pow_of_two_u64() that do not
unexpectedly truncate 64-bit input.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/log2.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index e17ceb32e0c9..87fd91be2075 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -57,6 +57,16 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 	return 1UL << fls_long(n - 1);
 }
 
+/**
+ * __roundup_pow_of_two_u64() - round up to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute__((const))
+u64 __roundup_pow_of_two_u64(u64 n)
+{
+	return 1ULL << fls64(n - 1);
+}
+
 /**
  * __rounddown_pow_of_two() - round down to nearest power of two
  * @n: value to round down
@@ -67,6 +77,16 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	return 1UL << (fls_long(n) - 1);
 }
 
+/**
+ * __rounddown_pow_of_two_u64() - round down to nearest power of two
+ * @n: value to round down
+ */
+static inline __attribute__((const))
+u64 __rounddown_pow_of_two_u64(u64 n)
+{
+	return 1ULL << (fls64(n) - 1);
+}
+
 /**
  * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
  * @n: parameter
@@ -163,6 +183,23 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	__ilog2_u64(n)			\
  )
 
+/**
+ * roundup_pow_of_two_u64 - round the given value up to nearest power of two
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two_u64(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 1) ? 1 :		\
+		(1ULL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two_u64(n)		\
+ )
+
 /**
  * roundup_pow_of_two - round the given value up to nearest power of two
  * @n: parameter
@@ -180,6 +217,21 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	__roundup_pow_of_two(n)			\
  )
 
+/**
+ * rounddown_pow_of_two_u64 - round the given value down to nearest power of two
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two_u64(n)		\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(1ULL << ilog2(n))) :		\
+	__rounddown_pow_of_two_u64(n)		\
+ )
+
 /**
  * rounddown_pow_of_two - round the given value down to nearest power of two
  * @n: parameter
-- 
2.47.3

