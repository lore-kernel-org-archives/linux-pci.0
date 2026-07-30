Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D003B14CF;
	Thu, 30 Jul 2026 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392851; cv=none; b=mzMOYaK4PID1sg6meml9PiV69QObhYwcjt94qDZKEtY9OH7IWQxWa6RlI4fA499ArvzCPbKgiHZbPsy7ymSng/o5AfcMMmO8nOOMnkO0+jjkEYUhy5HNUyfF/MDvXgV4Gp6tygWi+LVVSmQZuXV2ioqQSzPxntRpmB5BR9wesT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392851; c=relaxed/simple;
	bh=MpCsvgkYhwFx6l2DhURbnygFMACIWupHqPdDA8k03EM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLeIBQ5ZV8iQUWd0vOTh6z2PzFkd1Kc/JmB7DhN46fiOrJG7S4WmjfYEfPclVxdqYtHobVIgKjIb+UMIOiPExNZNthPg+Bqc7rXHSrgj068L4arPR9Q7PLr/e5BpdHN+KlPn2n5WDG4wSPRORN1H9ODqpXZ4YXOjRMEVE72bUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=055UI0bV; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="055UI0bV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hv9meH3muY4YNpc/o5G5Z0mz4xLH9mH8JWicFsfnQ9Q=;
	b=055UI0bV6k3nICpxZu212wVaxX7sTogkZiYOhja2WePOVFagZYRGAqn11JBAvMB1Nd/tmawTM
	FAUjvcq+7fabsiGXh8ZDREDWNT8aChS31e8FKfDIU71Za9iDam0/UtJs09zkBuHSumCR5iSJ0Ds
	qb3R1Fr3aU57oZRxrSo+174=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h9fBP3pqWzcbN0;
	Thu, 30 Jul 2026 14:17:33 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id B03D54057F;
	Thu, 30 Jul 2026 14:27:16 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Jul
 2026 14:27:12 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <wuyifan50@huawei.com>, <liusizhe5@huawei.com>
Subject: [PATCH v2 1/3] perf hisi-ptt: Fix PTT trace TLP header parsing
Date: Thu, 30 Jul 2026 14:27:07 +0800
Message-ID: <20260730062709.534139-2-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260730062709.534139-1-liusizhe5@huawei.com>
References: <20260730062709.534139-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200004.china.huawei.com (7.152.184.18)

TLP Headers traced by HiSilicon PCIe tune and trace device (PTT) in
4DW format are shown in the document as below:
bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
     |-----|---------|---|---|---|---|-------------|-------------|
DW0  [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
DW1  [                     Header DW1                            ]
DW2  [                     Header DW2                            ]
DW3  [                     Header DW3                            ]

Problem:
The DW0 bit field layout of the hisi_ptt_4dw union does not match the
actual bit ordering in little-endian memory, causing incorrect field
decoding.

Test on Kunpeng 930 SOC, generating data flow with `iperf` commands:
- server side:
    iperf -s
- client side:
    iperf -c $ip_addr -t 30

Trace the TLP headers with hisi_ptt on server side at the same time:
  perf record -e hisi_ptt12_0/type=4,filter=0x05101,direction=2,format=0/ \
  --max-size 50M -o perf.data &
The trace aims to capture completion TLPs, learn more in the document:
  https://docs.kernel.org/trace/hisi-ptt.html

Decode perf.data with hisi_ptt decoder:
  perf report -D

The hisi_ptt decoder produces the following result:
[...perf headers and other information]
. ... HISI PTT data: size 8388608 bytes
.  00000000: 68 87 20 94                                 Format 3 Type 1a T9 0 T8 1 TH 1 SO 1 Length 10 Time 4a1
.  00000004: 40 00 00 00                                 Header DW1
.  00000008: 40 00 01 51                                 Header DW2
.  0000000c: 00 00 00 00                                 Header DW3
[...other hisi_ptt TLP headers]

According to PCIe r5.0 sec 2.2.1, the Fmt & Type of Cpl/CplD is supposed
to be 8b'00001010' / 8b'01001010'
However, the Format & Type decoder analyzing result is 8b'01111010'.
It does not match field encodings of any TLP.

Correct decoder result should be:
[...perf headers and other information]
. ... HISI PTT data: size 8388608 bytes
.  00000000: 94 20 87 68                                 Format 2 Type a T9 0 T8 0 TH 0 SO 1 Length 10 Time 768
.  00000004: 00 00 00 40                                 Header DW1
.  00000008: 51 01 00 40                                 Header DW2
.  0000000c: 00 00 00 00                                 Header DW3
[...other hisi_ptt TLP headers]

To solve the problem:
1. Drop the union and C bitfield struct, store the raw DW value in
a plain uint32_t, and extract the fields with FIELD_GET() against
GENMASK/BIT masks declared in the header so they can be reused by
other translation units. The masks are portable across endianness and
compilers.

2. Print all DW hex values in big-endian byte order for readability,
matching the bit field layout shown in the 4DW format diagram.

3. Read the DW value with get_unaligned_le32() instead of an unaligned
pointer cast, avoiding both strict-aliasing violations and
alignment hazards on hosts that do not support unaligned access.

Cc: stable@vger.kernel.org
Fixes: 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing HiSilicon PCIe Trace packet")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 Documentation/trace/hisi-ptt.rst              | 28 +++++------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 47 ++++++++++---------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 12 +++++
 3 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
index 6eef28ebb0c7..f6a2655f99e5 100644
--- a/Documentation/trace/hisi-ptt.rst
+++ b/Documentation/trace/hisi-ptt.rst
@@ -285,20 +285,20 @@ according to the format described previously (take 8DW as an example):
     [...perf headers and other information]
     . ... HISI PTT data: size 4194304 bytes
     .  00000000: 00 00 00 00                                 Prefix
-    .  00000004: 01 00 00 60                                 Header DW0
-    .  00000008: 0f 1e 00 01                                 Header DW1
-    .  0000000c: 04 00 00 00                                 Header DW2
-    .  00000010: 40 00 81 02                                 Header DW3
-    .  00000014: 33 c0 04 00                                 Time
+    .  00000004: 60 00 00 01                                 Header DW0
+    .  00000008: 01 00 1e 0f                                 Header DW1
+    .  0000000c: 00 00 00 04                                 Header DW2
+    .  00000010: 02 81 00 40                                 Header DW3
+    .  00000014: 00 04 c0 33                                 Time
     .  00000020: 00 00 00 00                                 Prefix
-    .  00000024: 01 00 00 60                                 Header DW0
-    .  00000028: 0f 1e 00 01                                 Header DW1
-    .  0000002c: 04 00 00 00                                 Header DW2
-    .  00000030: 40 00 81 02                                 Header DW3
-    .  00000034: 02 00 00 00                                 Time
+    .  00000024: 60 00 00 01                                 Header DW0
+    .  00000028: 01 00 1e 0f                                 Header DW1
+    .  0000002c: 00 00 00 04                                 Header DW2
+    .  00000030: 02 81 00 40                                 Header DW3
+    .  00000034: 00 00 00 02                                 Time
     .  00000040: 00 00 00 00                                 Prefix
-    .  00000044: 01 00 00 60                                 Header DW0
-    .  00000048: 0f 1e 00 01                                 Header DW1
-    .  0000004c: 04 00 00 00                                 Header DW2
-    .  00000050: 40 00 81 02                                 Header DW3
+    .  00000044: 60 00 00 01                                 Header DW0
+    .  00000048: 01 00 1e 0f                                 Header DW1
+    .  0000004c: 00 00 00 04                                 Header DW2
+    .  00000050: 02 81 00 40                                 Header DW3
     [...]
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index a17c423a526d..5db44556fc4f 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -10,6 +10,8 @@
 #include <endian.h>
 #include <byteswap.h>
 #include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
 #include <stdarg.h>
 
 #include "../color.h"
@@ -73,29 +75,20 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
-union hisi_ptt_4dw {
-	struct {
-		uint32_t format : 2;
-		uint32_t type : 5;
-		uint32_t t9 : 1;
-		uint32_t t8 : 1;
-		uint32_t th : 1;
-		uint32_t so : 1;
-		uint32_t len : 10;
-		uint32_t time : 11;
-	};
-	uint32_t value;
-};
-
 static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *desc)
 {
 	const char *color = PERF_COLOR_BLUE;
+	uint8_t byte;
+	uint32_t dw;
 	int i;
 
+	dw = get_unaligned_le32(buf + pos);
 	printf(".");
 	color_fprintf(stdout, color, "  %08x: ", pos);
-	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++)
-		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
+	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++) {
+		byte = (dw >> (24 - i * 8)) & 0xFF;
+		color_fprintf(stdout, color, "%02x ", byte);
+	}
 	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
 		color_fprintf(stdout, color, "   ");
 	color_fprintf(stdout, color, "  %s\n", desc);
@@ -122,22 +115,30 @@ static int hisi_ptt_8dw_kpt_desc(const unsigned char *buf, int pos)
 static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
 {
 	const char *color = PERF_COLOR_BLUE;
-	union hisi_ptt_4dw dw0;
+	uint8_t byte;
+	uint32_t dw;
 	int i;
 
-	dw0.value = *(uint32_t *)(buf + pos);
+	dw = get_unaligned_le32(buf + pos);
 	printf(".");
 	color_fprintf(stdout, color, "  %08x: ", pos);
-	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++)
-		color_fprintf(stdout, color, "%02x ", buf[pos + i]);
+	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++) {
+		byte = (dw >> (24 - i * 8)) & 0xFF;
+		color_fprintf(stdout, color, "%02x ", byte);
+	}
 	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
 		color_fprintf(stdout, color, "   ");
 
 	color_fprintf(stdout, color,
 		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
-		      "Format", dw0.format, "Type", dw0.type, "T9", dw0.t9,
-		      "T8", dw0.t8, "TH", dw0.th, "SO", dw0.so, "Length",
-		      dw0.len, "Time", dw0.time);
+		      "Format", FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw),
+		      "Type", FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw),
+		      "T9", FIELD_GET(HISI_PTT_HEAD0_4DW_T9, dw),
+		      "T8", FIELD_GET(HISI_PTT_HEAD0_4DW_T8, dw),
+		      "TH", FIELD_GET(HISI_PTT_HEAD0_4DW_TH, dw),
+		      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
+		      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
+		      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
 }
 
 static int hisi_ptt_4dw_kpt_desc(const unsigned char *buf, int pos)
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index e78f1b5bc836..333eee02b19d 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -9,12 +9,24 @@
 
 #include <stddef.h>
 #include <stdint.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
 
 #define HISI_PTT_8DW_CHECK_MASK		GENMASK(31, 11)
 #define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
 #define HISI_PTT_MAX_SPACE_LEN		10
 #define HISI_PTT_FIELD_LENTH		4
 
+/* Header DW0 fields for 4DW format */
+#define HISI_PTT_HEAD0_4DW_TIME		GENMASK_U32(10, 0)
+#define HISI_PTT_HEAD0_4DW_LEN		GENMASK_U32(20, 11)
+#define HISI_PTT_HEAD0_4DW_SO		BIT_U32(21)
+#define HISI_PTT_HEAD0_4DW_TH		BIT_U32(22)
+#define HISI_PTT_HEAD0_4DW_T8		BIT_U32(23)
+#define HISI_PTT_HEAD0_4DW_T9		BIT_U32(24)
+#define HISI_PTT_HEAD0_4DW_TYPE		GENMASK_U32(29, 25)
+#define HISI_PTT_HEAD0_4DW_FORMAT	GENMASK_U32(31, 30)
+
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
 	HISI_PTT_8DW_PKT,
-- 
2.33.0

