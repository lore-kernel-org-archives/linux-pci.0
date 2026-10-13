Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C3C1A7264;
	Tue, 13 Oct 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897064; cv=none; b=Joi73GFNBMgVx7NVcUXxN3g8GbqgcPD4sd8dmB0nHEdcF8XQfEzreMmdPsN10q0/gFXWpl4rWIF93DRNe3nSyv/VmhQTw9UDe/jn6xEB6Iu9B2gOmqLNdGKX2zs6SY8/oeEmUt5m+eqYrR1FpoqcXArKVf+fzJHAkRirY+9aAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897064; c=relaxed/simple;
	bh=Ur/g/teufR3/Mt8OOOf3yUeB+T34vUXjDKjhhXwPFls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjytXTmKkW/I67HHcPOkM1TQe4Y/RYWUUY1Rnqw0NBvJ9aozSJmwVswQ39NE+QAjb1G2eXbytCTTfOAjqIpSlBKl3nW5nRi9NawSGSmqTAUdmcSvYhF+UscdHX+shJSigAJvlSmsl2801DbDtQYyw76cVcwKQnDCJgRP5BRiFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EafDCwry; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EafDCwry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897064; x=1823433064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ur/g/teufR3/Mt8OOOf3yUeB+T34vUXjDKjhhXwPFls=;
  b=EafDCwryCwQyazWUW/I8yIaLKWcLDm4+8IDVocPGt5OWNbMxpMtPg1jt
   5J0tCKXkyq/wux2fH+VdwId2r01qv7SCDt9FMpvVudwWzswnk/nUVYEsb
   uAZRlk1SVeEjDAcINuH6wKskjPUKiMMONYQgzV8J6975tdVdmkCh7scmQ
   TGxuiFlpM5RqSUEsSM8P5ZGNEPS/f2vWmXXJ0pi9AUwBnbjpeIMK2z+4G
   AAvrxbYFgYZTRrePlPgWqsZWQJSRPMlv93rdV5jtYYWAyDDzBHbxlQI9q
   Dzpc4OzXHZTe5cVcdlFzZszOTRZompf1vGzm93v22FLJRk5W+U001st78
   Q==;
X-CSE-ConnectionGUID: ddsBIKhpR+KnqVVXV7BA2w==
X-CSE-MsgGUID: J01R5obwQk+U5nwdT7r4eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="630383"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="630383"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:11:03 -0700
X-CSE-ConnectionGUID: n6UnDdtnRSWYPBOA7IkJug==
X-CSE-MsgGUID: ohrzBwgAQ6u6M8xKydlE7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="3006272"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:59 -0700
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
Subject: [PATCH v3 5/8] linux/log2.h: Add 64-bit roundup/down_pow_of_two64() variants
Date: Tue, 13 Oct 2026 16:09:39 +0300
Message-ID: <20261013130948.6231-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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
index e17ceb32e0c9..a5c8416d0382 100644
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
+	return 1UL << fls64(n - 1);
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
+	return 1UL << (fls64(n) - 1);
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

