Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965C455173;
	Thu, 27 Aug 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839526; cv=none; b=ubESyPCcPkBs2cSqrskOSbJ31PmvK/Bhwa/E4HL5pPtHLhAM8BWCqG/abU66ldkFZB5irxufm6dWtLnul/8sIU1A2q5CK/rWI1POvus1j9eRw2KzCE5bOBq4oBJqPDKqbEI355Z7Si1TmjcckUdVny2V2Ub2hWzHkbmGFemgvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839526; c=relaxed/simple;
	bh=y1LFgkSeeRiTwg3DKbKKCvavT+BjCTCYLW3aIWEXuKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lcph5alvpYc/FsW9s0g7/Gu1bRHGcXFQ6CI5HrHjY+qZTIGF4IqYvWh97+FtOMilU0gprxCyQpYkg9uapw7xaf53pvvJYE1U9qOAwZujDolMQgnlbP+kFQGPgSNzh+2WsfpSxA0aR6Mp7kci+nQbHb7z4ml/Ft0bCTpjhHkig8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JmTYKYKD; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JmTYKYKD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CG8UajRDQwSiy+CM0OEhF9gLmepOI3OCUZOl7n3z20M=;
	b=JmTYKYKD8hFKQZz5PSir9bO0oYAk55ntdljal34PndT+7xRjHa4GXpKac2h9aSO4lzuD/xUhK
	Cr6bz4Y1FFSQQfVVIgzrzFMHQtNr2PSiAYOIW8EQD4U9y9K8GrGYi3Y7QTSUccpRPBzmNLEycb3
	ujDUkZG1Knn8gK4IzWd3lHk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hW30h0nHGzcb3P;
	Thu, 27 Aug 2026 21:54:28 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 173A12025F;
	Thu, 27 Aug 2026 22:05:03 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:05:00 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>,
	<wuzongyu1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <liusizhe5@huawei.com>
Subject: [PATCH v2 8/8] perf hisi-ptt: Pass pattern version to decoder for compatibility
Date: Thu, 27 Aug 2026 22:04:42 +0800
Message-ID: <20260827140442.2031128-9-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260827140442.2031128-1-liusizhe5@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
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

On the recording side, walk the evlist in hisi_ptt_info_fill() to find
the hisi_ptt event, read out the pattern bits from its config, and
forward the pattern version to the decoder through
auxtrace_info->priv[1] as HISI_PTT_PATTERN_LEGACY or HISI_PTT_PATTERN_V1.

On the decoding side, store the pattern version in struct hisi_ptt and
propagate it to struct hisi_ptt_pkt_buf. The printers of Header DW2
and DW3 check the version: HISI_PTT_PATTERN_V1 keeps the field-level
parsing introduced by the previous patches, while HISI_PTT_PATTERN_LEGACY
falls back to printing only the raw "Header DW2/DW3" label so legacy
traces remain decodable with the new tool.

The auxtrace priv size grows from one u64 to two. Use
HISI_PTT_AUXTRACE_PRIV_SIZE_LEGACY for the minimum header size check
and detect the actual priv_size at runtime to pick the pattern version.
For trace data recorded by an older tracer that does not support the
`pattern` parameter (no priv[1] in the header), the decoder defaults
to legacy mode (HISI_PTT_PATTERN_LEGACY) so the new tool keeps parsing
old traces correctly.

The hisi_ptt_pkt_size array is moved out of the shared header into
static definitions in the two .c files that consume it to avoid
multiple definitions.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 tools/perf/arch/arm64/util/hisi-ptt.c         | 18 +++++++++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 39 ++++++++++++-------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  8 ++--
 tools/perf/util/hisi-ptt.c                    | 28 +++++++++----
 tools/perf/util/hisi-ptt.h                    |  9 ++++-
 5 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index 52257715d2b7..ae8c16b5c324 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -6,6 +6,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/zalloc.h>
@@ -20,6 +21,7 @@
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
 #include "../../../util/hisi-ptt.h"
+#include "../../../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h"
 #include "../../../util/pmu.h"
 #include "../../../util/record.h"
 #include "../../../util/session.h"
@@ -49,6 +51,8 @@ static int hisi_ptt_info_fill(struct auxtrace_record *itr,
 	struct hisi_ptt_recording *pttr =
 			container_of(itr, struct hisi_ptt_recording, itr);
 	struct perf_pmu *hisi_ptt_pmu = pttr->hisi_ptt_pmu;
+	struct evsel *evsel;
+	u32 pattern = 0;
 
 	if (priv_size != HISI_PTT_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
@@ -56,8 +60,22 @@ static int hisi_ptt_info_fill(struct auxtrace_record *itr,
 	if (!evlist__core(session->evlist)->nr_mmaps)
 		return -EINVAL;
 
+	/*
+	 * Walk the evlist to find the hisi_ptt event and read out the pattern
+	 * bits from its config, which decides the decoder version used to
+	 * parse the trace data.
+	 */
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel->core.attr.type == hisi_ptt_pmu->type) {
+			pattern = FIELD_GET(HISI_PTT_PMU_PATTERN_MASK,
+					    evsel->core.attr.config);
+			break;
+		}
+	}
+
 	auxtrace_info->type = PERF_AUXTRACE_HISI_PTT;
 	auxtrace_info->priv[0] = hisi_ptt_pmu->type;
+	auxtrace_info->priv[1] = pattern;
 
 	return 0;
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index de1d4071e209..63700380bf91 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -20,7 +20,7 @@
 /*
  * For 8DW format, the bit[31:11] of DW0 is always 0x1fffff, which can be
  * used to distinguish the data format.
- * 8DW format is like:
+ * 8DW format legacy pattern is like:
  *   bits [                 31:11                 ][       10:0       ]
  *        |---------------------------------------|-------------------|
  *    DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
@@ -32,7 +32,7 @@
  *    DW6 [                   Reserved (0x0)                          ]
  *    DW7 [                        Time                               ]
  *
- * 4DW format is like:
+ * 4DW format legacy pattern is like:
  *   bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
  *        |-----|---------|---|---|---|---|-------------|-------------|
  *    DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
@@ -79,6 +79,11 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
+static int hisi_ptt_pkt_size[] = {
+	[HISI_PTT_4DW_PKT]	= 16,
+	[HISI_PTT_8DW_PKT]	= 32,
+};
+
 /* TLP message parsers below according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2 */
 static bool hisi_ptt_is_mwr_tlp(uint32_t format, uint32_t type)
 {
@@ -207,15 +212,20 @@ static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
 static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2];
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
-	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1)
+		color_fprintf(stdout, color, "  %s\n", desc);
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
 		color_fprintf(stdout, color,
 			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
 			      "Reserved",
@@ -229,10 +239,7 @@ static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 			      "Header DW2",
 			      FIELD_GET(HISI_PTT_HEAD2_HEADER_DW2, dw));
 	else
-		color_fprintf(stdout, color, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2]);
+		color_fprintf(stdout, color, "  %s\n", desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -240,12 +247,17 @@ static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3];
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
-	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1)
+		color_fprintf(stdout, color, "  %s\n", desc);
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
 		color_fprintf(stdout, color,
 			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
 			      "Destination Segment",
@@ -272,10 +284,7 @@ static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
 			      "Header DW3",
 			      FIELD_GET(HISI_PTT_HEAD3_CFG_HEADER_DW3, dw));
 	else
-		color_fprintf(stdout, color, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3]);
+		color_fprintf(stdout, color, "  %s\n", desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 9663615ea3b5..5aaba79ef055 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -16,6 +16,8 @@
 #define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
 #define HISI_PTT_MAX_SPACE_LEN		10
 #define HISI_PTT_FIELD_LENGTH		4
+#define HISI_PTT_PATTERN_LEGACY		0
+#define HISI_PTT_PATTERN_V1		1
 
 /* Header DW0 fields for 4DW format */
 #define HISI_PTT_HEAD0_4DW_TIME		GENMASK_U32(10, 0)
@@ -76,11 +78,6 @@ enum hisi_ptt_pkt_type {
 	HISI_PTT_PKT_MAX
 };
 
-static int hisi_ptt_pkt_size[] = {
-	[HISI_PTT_4DW_PKT]	= 16,
-	[HISI_PTT_8DW_PKT]	= 32,
-};
-
 enum hisi_ptt_pkt_msg_type {
 	HISI_PTT_PKT_TYPE_UNKNOWN,       /* Types do not support analysis */
 	HISI_PTT_PKT_TYPE_MWR,           /* P-(MemWr) */
@@ -98,6 +95,7 @@ struct hisi_ptt_pkt_buf {
 	size_t len;
 	enum hisi_ptt_pkt_type pkt_type;
 	enum hisi_ptt_pkt_msg_type pkt_msg_type;
+	size_t pattern;
 };
 
 int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf);
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 78817ae7a8ea..7cf778837337 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -35,6 +35,12 @@ struct hisi_ptt {
 	struct perf_session *session;
 	struct machine *machine;
 	u32 pmu_type;
+	u32 pattern;
+};
+
+static int hisi_ptt_pkt_size[] = {
+	[HISI_PTT_4DW_PKT]	= 16,
+	[HISI_PTT_8DW_PKT]	= 32,
 };
 
 static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf,
@@ -53,8 +59,7 @@ static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf,
 	return HISI_PTT_4DW_PKT;
 }
 
-static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
-			  unsigned char *buf, size_t len)
+static void hisi_ptt_dump(struct hisi_ptt *ptt, unsigned char *buf, size_t len)
 {
 	const char *color = PERF_COLOR_BLUE;
 	struct hisi_ptt_pkt_buf pkt_buf;
@@ -64,8 +69,9 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 	pkt_buf.pkt_type = hisi_ptt_check_packet_type(buf, len);
 	pkt_buf.len = round_down(len, hisi_ptt_pkt_size[pkt_buf.pkt_type]);
 	pkt_buf.pkt_msg_type = HISI_PTT_PKT_TYPE_UNKNOWN;
-	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
-		      pkt_buf.len);
+	pkt_buf.pattern = (size_t)ptt->pattern;
+	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes, pattern %zu\n",
+		      pkt_buf.len, pkt_buf.pattern);
 
 	while (pkt_buf.pos < pkt_buf.len) {
 		if (!hisi_ptt_pkt_desc(&pkt_buf))
@@ -158,12 +164,13 @@ static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
 	return evsel->core.attr.type == ptt->pmu_type;
 }
 
-static void hisi_ptt_print_info(__u64 type)
+static void hisi_ptt_print_info(u32 type, u32 pattern)
 {
 	if (!dump_trace)
 		return;
 
-	fprintf(stdout, "  PMU Type           %" PRId64 "\n", (s64) type);
+	fprintf(stdout, "  PMU Type           %" PRIu32 "\n", type);
+	fprintf(stdout, "  Data Pattern       %" PRIu32 "\n", pattern);
 }
 
 int hisi_ptt_process_auxtrace_info(union perf_event *event,
@@ -171,10 +178,13 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct hisi_ptt *ptt;
+	size_t priv_size;
 
-	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE +
+	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE_LEGACY +
 				sizeof(struct perf_record_auxtrace_info))
 		return -EINVAL;
+	priv_size = auxtrace_info->header.size -
+		    sizeof(struct perf_record_auxtrace_info);
 
 	ptt = zalloc(sizeof(*ptt));
 	if (!ptt)
@@ -184,6 +194,8 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->machine = &session->machines.host; /* No kvm support */
 	ptt->auxtrace_type = auxtrace_info->type;
 	ptt->pmu_type = auxtrace_info->priv[0];
+	ptt->pattern = priv_size >= HISI_PTT_AUXTRACE_PRIV_SIZE_V1 ?
+		       (u32)auxtrace_info->priv[1] : HISI_PTT_PATTERN_LEGACY;
 
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
@@ -193,7 +205,7 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
 	session->auxtrace = &ptt->auxtrace;
 
-	hisi_ptt_print_info(auxtrace_info->priv[0]);
+	hisi_ptt_print_info(ptt->pmu_type, ptt->pattern);
 
 	return 0;
 }
diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
index 2db9b4056214..912453b06e62 100644
--- a/tools/perf/util/hisi-ptt.h
+++ b/tools/perf/util/hisi-ptt.h
@@ -7,8 +7,13 @@
 #ifndef INCLUDE__PERF_HISI_PTT_H__
 #define INCLUDE__PERF_HISI_PTT_H__
 
-#define HISI_PTT_PMU_NAME		"hisi_ptt"
-#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
+#include <linux/bits.h>
+
+#define HISI_PTT_PMU_NAME			"hisi_ptt"
+#define HISI_PTT_AUXTRACE_PRIV_SIZE_LEGACY	sizeof(u64)
+#define HISI_PTT_AUXTRACE_PRIV_SIZE_V1		(2 * sizeof(u64))
+#define HISI_PTT_AUXTRACE_PRIV_SIZE		HISI_PTT_AUXTRACE_PRIV_SIZE_V1
+#define HISI_PTT_PMU_PATTERN_MASK		GENMASK_ULL(39, 36)
 
 struct auxtrace_record *hisi_ptt_recording_init(int *err,
 						struct perf_pmu *hisi_ptt_pmu);
-- 
2.33.0

