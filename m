Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53C2BFC8F;
	Tue,  8 Sep 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876358; cv=none; b=Xq32zLhZOusOScPcDebRUp4lE+taTlPucFtgguhYiVZWQvH1PvHq+WuEEAz95m9aPfq7Ux0Kijkr1AEx6JKEfVHsPFEuScUPd301WNR4Mt9yh7Mj4aucwU+MHZd6IjQEuIGART6Ww1fuw7IsoX3Cy9/lCGtKeZio6uMM9X93LnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876358; c=relaxed/simple;
	bh=A1FRc8WGhF6hii3FFWLLJSWWiRBHYBOUPMnCs/FOESQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI0IuDnihiRqF6JeNbcOJX2kGod3Y4Wm56tplZhSyXDE4f3wAW5SzNot1tknoevbr/GeSjerzMJsi2htgsAAhhc4b3bQGaBRTWny4h6WFX/qyiato2DSfdE/19Ed7SMe6eVsQ8v1hWfWYw7vRlDmaPLSvP2ZHrWqn+Ppf/H8P8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TKCoVZhk; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TKCoVZhk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JiNSKeamnhE8f/a70MV3yVqNUJqh2LyF6XzFZXRiNZc=;
	b=TKCoVZhkWEk0AXX5jqoWpcCHvJx7VLiuQUdjPYDI59P/hMC7fC5g487XtPVXbRsxLTikXd7eI
	21bhFQSZ7kIXqODZMYSYYX4d0jMpialgLRfgKzJUIYJnqLgqND8x1yqDKGByejm6gmBLKJ1LjsF
	Rlaf2DRxQSPOApzJugEkRN8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hfQRJ54VXz1K97G;
	Tue,  8 Sep 2026 21:54:36 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id A8E9A40572;
	Tue,  8 Sep 2026 22:05:30 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:28 +0800
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
Subject: [PATCH v4 8/8] perf hisi-ptt: Pass pattern version to decoder for compatibility
Date: Tue, 8 Sep 2026 22:05:09 +0800
Message-ID: <20260908140509.2485649-9-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260908140509.2485649-1-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 tools/perf/arch/arm64/util/hisi-ptt.c         |  18 +++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 123 ++++++++++++------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   8 +-
 tools/perf/util/hisi-ptt.c                    |  28 ++--
 tools/perf/util/hisi-ptt.h                    |   9 +-
 5 files changed, 133 insertions(+), 53 deletions(-)

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
index 482a50c2e9f5..62b98d98b2e9 100644
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
 static bool hisi_ptt_is_mrd_tlp(uint32_t format, uint32_t type)
 {
@@ -230,21 +235,36 @@ static void hisi_ptt_print_head0_8dw_fields(uint32_t dw)
 		      "Length", FIELD_GET(HISI_PTT_HEAD0_8DW_LEN, dw));
 }
 
+static void hisi_ptt_print_head0_fields_v1(struct hisi_ptt_pkt_buf *pkt_buf,
+					   uint32_t dw, const char *desc)
+{
+	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
+		hisi_ptt_print_head0_4dw_fields(dw);
+	else if (pkt_buf->pkt_type == HISI_PTT_8DW_PKT)
+		hisi_ptt_print_head0_8dw_fields(dw);
+	else
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
+}
+
 static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 {
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD0] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD0];
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	hisi_ptt_parse_pkt_info(pkt_buf, dw);
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
-	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
-		hisi_ptt_print_head0_4dw_fields(dw);
-	else if (pkt_buf->pkt_type == HISI_PTT_8DW_PKT)
-		hisi_ptt_print_head0_8dw_fields(dw);
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1) {
+		if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
+			hisi_ptt_print_head0_4dw_fields(dw);
+		else
+			color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
+	}
 	else
-		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD0]);
+		hisi_ptt_print_head0_fields_v1(pkt_buf, dw, desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -304,13 +324,9 @@ static void hisi_ptt_print_head1_msg_fields(uint32_t dw)
 		      "Message Code", FIELD_GET(HISI_PTT_HEAD1_MSG_CODE, dw));
 }
 
-static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
+static void hisi_ptt_print_head1_fields_v1(struct hisi_ptt_pkt_buf *pkt_buf,
+					   uint32_t dw, const char *desc)
 {
-	uint32_t dw;
-
-	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
-	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
-
 	switch (pkt_buf->pkt_msg_type) {
 	case HISI_PTT_PKT_TYPE_MRD:
 	case HISI_PTT_PKT_TYPE_MWR:
@@ -334,12 +350,25 @@ static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
 	case HISI_PTT_PKT_TYPE_UNKNOWN:
 	case HISI_PTT_PKT_TYPE_MAX:
 	default:
-		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD1] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD1]);
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
 		break;
 	}
+}
+
+static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD1] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD1];
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1)
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
+	else
+		hisi_ptt_print_head1_fields_v1(pkt_buf, dw, desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -403,13 +432,9 @@ static void hisi_ptt_print_head2_cpl_fields(uint32_t dw)
 		      FIELD_GET(HISI_PTT_HEAD2_CPL_LO_ADDR, dw));
 }
 
-static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
+static void hisi_ptt_print_head2_fields_v1(struct hisi_ptt_pkt_buf *pkt_buf,
+					   uint32_t dw, const char *desc)
 {
-	uint32_t dw;
-
-	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
-	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
-
 	switch (pkt_buf->pkt_msg_type) {
 	case HISI_PTT_PKT_TYPE_MRD:
 	case HISI_PTT_PKT_TYPE_MWR:
@@ -433,12 +458,25 @@ static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 	case HISI_PTT_PKT_TYPE_UNKNOWN:
 	case HISI_PTT_PKT_TYPE_MAX:
 	default:
-		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2]);
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
 		break;
 	}
+}
+
+static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2];
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1)
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
+	else
+		hisi_ptt_print_head2_fields_v1(pkt_buf, dw, desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -516,13 +554,9 @@ static void hisi_ptt_print_head3_cpl_fields(uint32_t dw)
 		      FIELD_GET(HISI_PTT_HEAD3_CPL_TAG_13_10, dw));
 }
 
-static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
+static void hisi_ptt_print_head3_fields_v1(struct hisi_ptt_pkt_buf *pkt_buf,
+					   uint32_t dw, const char *desc)
 {
-	uint32_t dw;
-
-	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
-	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
-
 	switch (pkt_buf->pkt_msg_type) {
 	case HISI_PTT_PKT_TYPE_MRD:
 	case HISI_PTT_PKT_TYPE_MWR:
@@ -546,12 +580,25 @@ static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
 	case HISI_PTT_PKT_TYPE_UNKNOWN:
 	case HISI_PTT_PKT_TYPE_MAX:
 	default:
-		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3]);
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
 		break;
 	}
+}
+
+static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3];
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pattern < HISI_PTT_PATTERN_V1)
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n", desc);
+	else
+		hisi_ptt_print_head3_fields_v1(pkt_buf, dw, desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 5f71cfdcb7a7..f17ee6b549ca 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -19,6 +19,8 @@
 #define HISI_PTT_FIELD_LENGTH			4
 #define HISI_PTT_3DW_HEADER_PROTO_LEN		3
 #define HISI_PTT_4DW_HEADER_PROTO_LEN		4
+#define HISI_PTT_PATTERN_LEGACY			0
+#define HISI_PTT_PATTERN_V1			1
 
 /* Hisi PTT Header DW0 fields for 4DW format
  *
@@ -208,11 +210,6 @@ enum hisi_ptt_pkt_type {
 	HISI_PTT_PKT_MAX
 };
 
-static int hisi_ptt_pkt_size[] = {
-	[HISI_PTT_4DW_PKT]	= 16,
-	[HISI_PTT_8DW_PKT]	= 32,
-};
-
 enum hisi_ptt_pkt_msg_type {
 	/* Types do not support analysis */
 	HISI_PTT_PKT_TYPE_UNKNOWN,
@@ -243,6 +240,7 @@ struct hisi_ptt_pkt_buf {
 	enum hisi_ptt_pkt_type pkt_type;
 	enum hisi_ptt_pkt_msg_type pkt_msg_type;
 	size_t proto_len;
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

