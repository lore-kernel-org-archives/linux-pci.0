Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587081;
	b=mEygAU7NR0QYISPccvXHPo5I4sg/u3jEoUFrLRMXmTIecN2kNO1fWq/p0jVYlAwHuu9z
	 +b7fP7oVEdt66bbp8UnuZtNT21bXjbiDQb2+lpFoEe8sqNQD0wLERJJa6c+zz/koRfW+/
	 Miw45jV4segr6FQDs4G4Mj0CcUb1X2ZcDrnZGozyNB71pOShzgH+i+MxYToyo6g36wBHd
	 Gga8ihGT9MIKBQAtkqCRGCBk83KVivG7gMnkkwUGVwjC0ivrmKKEOA6tK6HZsS/FR+O6O
	 DaO/ybfKHrxfyICi4yk3Hup46rEKKw0+1GSEVXHhkQ9eyAXtDVYFHuDTgnLKWZf9AoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587081;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=aTH0PmxbbxC55ROBWOOZo8z909XjE3QcvaLlFOsDK4U=;
	b=uaesHmkrWq9BQ5cTr45IlZQKVkLnOCV9ohDHVSSmxVCD7lBmqSbotEOO8EHIY2T+JyQp
	 fpavHy8ofXx0HqEK4e0AiTrY7WLI6VOFFH88yVIsWNk0VAjZAhZO1BwTpLtIL5y9zZfXv
	 OrosPbuiPtWdOCjrxWNeqtNSib+wX2lD648Mak7Kz1krI1ycENot8ihOUFQLQ8Hq3P+9Q
	 in44HLtRVmuRzD4c7bL4BIsu71yXuwQnMD4Hcz/Yqgh3Kt07BK7zcJwLGu7pEnxqbG3nF
	 C5XMFsiIVL73/ZOQhq7FJ7dcslL+2fE+oXrK3gJex/AjPw417lBGa9hqSHqlz2u7N1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJKugwND;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6C606A322;
	Wed, 21 Oct 2026 12:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A6C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJKugwND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587081; x=1824123081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c/QEOOLyncZHREMfGdMjnu+W3S4VLUTYWjMAqrSAl8s=;
  b=JJKugwNDAI9ikJKPgtQIDYFTPd43NeelXdMWifyECZZlF/LluYbppv0o
   TjlhlE8ihortraMHkf7OBL/fUDHM2/P+f9w7/PpcfTVIo033bOj6HgeWc
   e+RoepmCY9RgYuKCWpzguDnFVA2ilskKeQCuVyQRUAGrFr3JB7PlITxI4
   +WcmpEWPnpKwwoL9P2D6LaVVp2DAEFZ0M+6EFNDo9LN8wvAGxv+KdeBMy
   FSTkMo3avtmeSdvl01XSA7U/cJ3VgaZ7NkOPrc82OrNkWia9VywuWbBNJ
   zerLcM6ko4M58xFymCy3fQWm8dLcudgMuDLMNJebYiZxiMN/Mm0t5kaOX
   w==;
X-CSE-ConnectionGUID: 8RWUd9t5Qaqj6Ob/s+/zPQ==
X-CSE-MsgGUID: Y672gsOXTG+XRkuDzQhWEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1319920"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1319920"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:51:21 -0700
X-CSE-ConnectionGUID: n8pjYNxITUu4b8AwqNaEsg==
X-CSE-MsgGUID: Mz28nd1fRAyVp1H9/8Y7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3423036"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:51:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/7] linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants
Date: Wed, 21 Oct 2026 15:49:50 +0300
Message-ID: <20261021124956.4250-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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
internally based on fls() that limits types to unsigned long. The type
limitation is unexpected and undocumented.

Worse yet, the typing seems also inconsistent between
__builtin_constant_p() and __roundup/down_pow_of_two() branches, the
former using full 64-bit size and the latter truncating type.

The most sensible way seems to be eventually changing types such that
the return type for roundup/down_pow_of_two() is same as input but it
requires auditing all the existing callers that have mixed input/output
types.

As a stop gap solution, add roundup/down_pow_of_two64() that do not
unexpectedly truncate 64-bit input.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/log2.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index e17ceb32e0c9..180e5702f677 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -57,6 +57,16 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 	return 1UL << fls_long(n - 1);
 }
 
+/**
+ * __roundup_pow_of_two64() - round up to nearest power of two
+ * @n: value to round up
+ */
+static inline __attribute__((const))
+u64 __roundup_pow_of_two64(u64 n)
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
+ * __rounddown_pow_of_two64() - round down to nearest power of two
+ * @n: value to round down
+ */
+static inline __attribute__((const))
+u64 __rounddown_pow_of_two64(u64 n)
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
+ * roundup_pow_of_two64 - round the given value up to nearest power of two
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two64(n)			\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 1) ? 1 :		\
+		(1UL << (ilog2((n) - 1) + 1))	\
+				   ) :		\
+	__roundup_pow_of_two64(n)		\
+ )
+
 /**
  * roundup_pow_of_two - round the given value up to nearest power of two
  * @n: parameter
@@ -180,6 +217,21 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 	__roundup_pow_of_two(n)			\
  )
 
+/**
+ * rounddown_pow_of_two64 - round the given value down to nearest power of two
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - the result is undefined when n == 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two64(n)		\
+(						\
+	__builtin_constant_p(n) ? (		\
+		(1UL << ilog2(n))) :		\
+	__rounddown_pow_of_two64(n)		\
+ )
+
 /**
  * rounddown_pow_of_two - round the given value down to nearest power of two
  * @n: parameter
-- 
2.47.3

