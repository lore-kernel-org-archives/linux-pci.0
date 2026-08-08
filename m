Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E63932E9;
	Sat,  8 Aug 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209807; cv=none; b=shZo0F7i6yCs0uj9xrd2m9b62AzgHq9pnXUd43eMlUiLFqFjhMQWV75SXOtEuPQw5+6dE9UbO/QxQ7q1HOCof0ScvOeRUsnoC/SUYQu4uTVMkE2aCT+mITzHNIoXnnV7WPCLb1lEf5slcsv70hgkxgaix82Pp+ZdTrsw2IZQlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209807; c=relaxed/simple;
	bh=CX5XRKbAZjYc1jyK0tQnRaJDeiwcvDb7zn2MIqat44w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfnnO4jRm+FtOy1XIvBDpiolaLQ7+flGHyRuke//UFlbUQxyMqozs5NoXARoSAIVbdgq/P7oqhqvE4QFIYZcBhdLbH91AXQRuZf8idmtrM+nIednTmyt7KQdFzRmw1ZbXJlG8alaVxEVBSSIrv3T5728JZTdru0wxmGz6PKegUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHLQAhv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHLQAhv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25591F00A3A;
	Sat,  8 Aug 2026 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209806;
	bh=xufkNp1CDQZpQeRj9PlItChnbosE5797ESelEugb/rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cHLQAhv9mEdH04cRRL2pBJhrCTM+VmNAYobRq/ARKy30vLipKOLQHXA4cTSC3vWxA
	 IMsJBJyy30GTIW4C9eFBqP8qh4TGOpuY1xIPdnHIQMNNmxw40Ut+rHi4RIFeoLMHeY
	 7RKtNUPh0l6fmA6iZE5L9vDVLdqKHaeMH3Autq5AXMCbeViyXb9jY+iCqZyJc17ZtP
	 YmreYdOzaoIrtHOhw16+DIFjtr3C9eE/KVmZ1cgAtG3VOQdwy6JoF9l9ZREXU1UdF8
	 011K0P+kR2ds0fydAigokcdjaD1aQtHM2V/A2w81FjGWBrg9p6Ue30kFjqR23gmlc3
	 dary/HZ/YeKLw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/2] vsprintf: Add %pR human-readable size
Date: Sat,  8 Aug 2026 12:23:07 -0500
Message-ID: <20260808172308.282591-2-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808172308.282591-1-bhelgaas@google.com>
References: <20260808172308.282591-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include human-readable size when printing struct resource memory ranges
(not including DMA, bus number, or I/O port ranges) with the %pR format to
make it easier to read, e.g.,

  - pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff]
  + pci 0000:00:02.0: BAR 0 [mem 0xfea80000-0xfea9ffff (128 KiB)]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 lib/vsprintf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2bc6ef483576..c49044b6dbee 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1094,15 +1094,17 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	/* 32-bit res (sizeof==4): 10 chars in dec, 10 in hex ("0x" + 8)
 	 * 64-bit res (sizeof==8): 20 chars in dec, 18 in hex ("0x" + 16) */
 #define RSRC_BUF_SIZE		((2 * sizeof(resource_size_t)) + 4)
+#define RSRC_STR_SIZE		sizeof(" (xxxx.xxx MiB)")
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
-#define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
-#define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+#define DECODED_BUF_SIZE	sizeof("[mem - () 64bit pref window disabled]")
+#define RAW_BUF_SIZE		sizeof("[mem - () flags 0x]")
+	char sym[MAX(2*RSRC_BUF_SIZE + RSRC_STR_SIZE + DECODED_BUF_SIZE,
+		     2*RSRC_BUF_SIZE + RSRC_STR_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	bool decode = fmt[0] == 'R';
 	const struct printf_spec *specp;
+	char size_buf[32];
 
 	if (check_pointer(&buf, end, res, spec))
 		return buf;
@@ -1134,6 +1136,14 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	} else {
 		p = hex_range(p, pend, res->start, res->end, *specp);
 	}
+	if (res->flags & IORESOURCE_MEM) {
+		*p++ = ' ';
+		*p++ = '(';
+		string_get_size(resource_size(res), 1, STRING_UNITS_2,
+				size_buf, sizeof(size_buf));
+		p = string_nocheck(p, pend, size_buf, str_spec);
+		*p++ = ')';
+	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
 			p = string_nocheck(p, pend, " 64bit", str_spec);
-- 
2.53.0

