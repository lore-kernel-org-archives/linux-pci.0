Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613C3E2AAF;
	Thu,  4 Jun 2026 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559422; cv=none; b=WsikJgM6C6f6v7+9NpkPSgU9Uv/gg0l9FLCV88Z01vvkqc5eaBSg16WoJFnS7P24wJqybcUBKyNS7kD9Gdw/J8v5nVM/jsV1brJ2fy4TSbuzuI304bWVKhgThfQ91Sk13F8Hz/lJjysX4nbGbJFjQ3CWlkIjF8Zu6Kn2f7e25II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559422; c=relaxed/simple;
	bh=COY0rQh1n/z30TdSnCBlGi7MVXfydWJg2Nu79+etnls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVmkpboE+S7XW1sYaXsYsO+jZS7fi+sdjiexXHYlT51I/RnYIQRkem2tAQpGWQXO8q3Z8pnRvpbHd6YGwqE5/yRyyH9VYxJS2gyr+Pb2H0ggC0ALA9sXHwhmTyWfuTdGdAbp8SEAGveBh2sDpn6f4lc6nnaNbYKhrx6cDhIY3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VZZQkXS0; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VZZQkXS0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ur/yZcP+gQolt10/5ytaDnmV+aVSxeNTztYqMmNoF6s=;
	b=VZZQkXS0QVBcVuvHS46pfizVwh8dj5udvMMPe6TbHWMy+vMtvMUfuOM5uwnh37TWHbgt4JbKs
	76YWDQAbqnatFkn0X16NJO218qnfao5nMHESe14sm5Sr41hvU7kbEQyAGNSdaUX8EV+tCHDbtVQ
	cLa1MNHGCoDjSkob9z9UyEM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gWGkC4v8Lz1cyPc;
	Thu,  4 Jun 2026 15:42:27 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 00DAB40561;
	Thu,  4 Jun 2026 15:50:17 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 15:50:16 +0800
Received: from huawei.com (10.50.163.32) by kwepemn200012.china.huawei.com
 (7.202.194.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 15:50:15 +0800
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
	<shenyang39@huawei.com>, <gaozhihao6@h-partners.com>,
	<yuzhichengcheng@h-partners.com>, <liyihang9@h-partners.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <wuyifan50@huawei.com>,
	<liusizhe5@huawei.com>
Subject: [PATCH 10/10] perf hisi-ptt: Add decoder version compatibility
Date: Thu, 4 Jun 2026 15:50:05 +0800
Message-ID: <20260604075005.2219785-11-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260604075005.2219785-1-liusizhe5@huawei.com>
References: <20260604075005.2219785-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200012.china.huawei.com (7.202.194.135)

The hisi_ptt packet decoder now performs detailed field-level parsing
of TLP header DW2 and DW3 based on the message type classified from
DW0 (added in the previous patches). However, trace data recorded
with older versions of the tool does not contain the information
needed for this detailed parsing, and should continue to use the
generic field-name-only output.
Introduce a version field (V1/V2) in the auxtrace info record to
distinguish between the two data formats:
- V1 (legacy): auxtrace priv contains only PMU type. DW2 and DW3
  are printed with generic field names only, no message-type-based
  field decoding.
- V2 (current): auxtrace priv contains PMU type and version. DW2
  and DW3 are decoded according to the TLP message type (MWr, Msg,
  Atomic, IO, CPL, Cfg) with detailed field names.

At recording time, set the version to HISI_PTT_DECODER_V2 in the
auxtrace info. At decoding time, determine the version from the
priv data size and the version field:
- If priv_size >= V2, read the version from priv[1].
- If priv_size < V2, assume V1 for backward compatibility.
- If version is unknown (future), warn and decode auxtrace as v2.

Also add the version to the dump output alongside the PMU type.
Adjust hisi_ptt_pkt_size position to adapt to compilation.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 tools/perf/arch/arm64/util/hisi-ptt.c         |  2 ++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 35 ++++++++++++-------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  8 ++---
 tools/perf/util/hisi-ptt.c                    | 23 ++++++++----
 tools/perf/util/hisi-ptt.h                    |  4 ++-
 5 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index fe457fd58c9e..9a28f96b8e57 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -24,6 +24,7 @@
 #include "../../../util/record.h"
 #include "../../../util/session.h"
 #include "../../../util/tsc.h"
+#include "../../../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -58,6 +59,7 @@ static int hisi_ptt_info_fill(struct auxtrace_record *itr,
 
 	auxtrace_info->type = PERF_AUXTRACE_HISI_PTT;
 	auxtrace_info->priv[0] = hisi_ptt_pmu->type;
+	auxtrace_info->priv[1] = HISI_PTT_DECODER_V2;
 
 	return 0;
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 46f11d5719ac..0611f121431c 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -75,6 +75,11 @@ enum hisi_ptt_4dw_pkt_field_type {
 	HISI_PTT_4DW_TYPE_MAX
 };
 
+static int hisi_ptt_pkt_size[] = {
+	[HISI_PTT_4DW_PKT]	= 16,
+	[HISI_PTT_8DW_PKT]	= 32,
+};
+
 static const char * const hisi_ptt_8dw_pkt_field_name[] = {
 	[HISI_PTT_8DW_CHK_AND_RSV0]	= "CHK & RSV0",
 	[HISI_PTT_8DW_PREFIX]		= "Prefix",
@@ -284,14 +289,19 @@ static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
 	union hisi_ptt_field_data dw;
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2];
 
 	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
 
-	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
-	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
+	if (pkt_buf->version < HISI_PTT_DECODER_V2)
+		color_fprintf(stdout, color, "  %s\n", desc);
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
+		 pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
 		color_fprintf(stdout, color,
 			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
 			      "Reserved", dw.dw2_mixed.reserved,
@@ -300,10 +310,7 @@ static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
 			      "T", dw.dw2_mixed.t, "Tag", dw.dw2_mixed.tag,
 			      "Header DW2", dw.dw2_mixed.header_dw2);
 	else
-		color_fprintf(stdout, color, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2]);
+		color_fprintf(stdout, color, "  %s\n", desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
@@ -312,11 +319,16 @@ static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
 	union hisi_ptt_field_data dw;
+	const char *desc = pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
+			   hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3];
 
 	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
 
-	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
+	if (pkt_buf->version < HISI_PTT_DECODER_V2)
+		color_fprintf(stdout, color, "  %s\n", desc);
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
 		color_fprintf(stdout, color,
 			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
 			      "Destination Segment",
@@ -336,10 +348,7 @@ static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
 			      "T", dw.dw3_cfg.t, "Tag", dw.dw3_cfg.tag,
 			      "Header DW3", dw.dw3_cfg.header_dw3);
 	else
-		color_fprintf(stdout, color, "  %s\n",
-			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
-			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
-			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3]);
+		color_fprintf(stdout, color, "  %s\n", desc);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 3fdad34fe400..d1bffab449d4 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -14,6 +14,8 @@
 #define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
 #define HISI_PTT_MAX_SPACE_LEN		10
 #define HISI_PTT_FIELD_LENGTH		4
+#define HISI_PTT_DECODER_V1		1
+#define HISI_PTT_DECODER_V2		2
 
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
@@ -21,11 +23,6 @@ enum hisi_ptt_pkt_type {
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
@@ -43,6 +40,7 @@ struct hisi_ptt_pkt_buf {
 	size_t len;
 	enum hisi_ptt_pkt_type pkt_type;
 	enum hisi_ptt_pkt_msg_type pkt_msg_type;
+	uint32_t version;
 };
 
 int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf);
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index e321f393601b..4f52cfb4e190 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -33,6 +33,12 @@ struct hisi_ptt {
 	struct perf_session *session;
 	struct machine *machine;
 	u32 pmu_type;
+	u32 version;
+};
+
+static int hisi_ptt_pkt_size[] = {
+	[HISI_PTT_4DW_PKT]	= 16,
+	[HISI_PTT_8DW_PKT]	= 32,
 };
 
 static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
@@ -45,8 +51,7 @@ static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
 	return HISI_PTT_4DW_PKT;
 }
 
-static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
-			  unsigned char *buf, size_t len)
+static void hisi_ptt_dump(struct hisi_ptt *ptt, unsigned char *buf, size_t len)
 {
 	const char *color = PERF_COLOR_BLUE;
 	struct hisi_ptt_pkt_buf pkt_buf;
@@ -56,6 +61,7 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 	pkt_buf.pkt_type = hisi_ptt_check_packet_type(buf);
 	pkt_buf.len = round_down(len, hisi_ptt_pkt_size[pkt_buf.pkt_type]);
 	pkt_buf.pkt_msg_type = HISI_PTT_PKT_TYPE_UNKNOWN;
+	pkt_buf.version = ptt->version;
 	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
 		      pkt_buf.len);
 
@@ -146,12 +152,13 @@ static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
 	return evsel->core.attr.type == ptt->pmu_type;
 }
 
-static void hisi_ptt_print_info(__u64 type)
+static void hisi_ptt_print_info(__u64 type, u32 version)
 {
 	if (!dump_trace)
 		return;
 
 	fprintf(stdout, "  PMU Type           %" PRId64 "\n", (s64) type);
+	fprintf(stdout, "  Tracer Version     %" PRIu32 "\n", version);
 }
 
 int hisi_ptt_process_auxtrace_info(union perf_event *event,
@@ -159,10 +166,13 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct hisi_ptt *ptt;
+	size_t priv_size;
 
-	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE +
+	if (auxtrace_info->header.size < HISI_PTT_AUXTRACE_PRIV_SIZE_V1 +
 				sizeof(struct perf_record_auxtrace_info))
 		return -EINVAL;
+	priv_size = auxtrace_info->header.size -
+		    sizeof(struct perf_record_auxtrace_info);
 
 	ptt = zalloc(sizeof(*ptt));
 	if (!ptt)
@@ -172,7 +182,8 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->machine = &session->machines.host; /* No kvm support */
 	ptt->auxtrace_type = auxtrace_info->type;
 	ptt->pmu_type = auxtrace_info->priv[0];
-
+	ptt->version = priv_size >= HISI_PTT_AUXTRACE_PRIV_SIZE_V2 ?
+		       (u32)auxtrace_info->priv[1] : HISI_PTT_DECODER_V1;
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
 	ptt->auxtrace.flush_events = hisi_ptt_flush;
@@ -181,7 +192,7 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
 	session->auxtrace = &ptt->auxtrace;
 
-	hisi_ptt_print_info(auxtrace_info->priv[0]);
+	hisi_ptt_print_info(auxtrace_info->priv[0], ptt->version);
 
 	return 0;
 }
diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
index 2db9b4056214..67b051980113 100644
--- a/tools/perf/util/hisi-ptt.h
+++ b/tools/perf/util/hisi-ptt.h
@@ -8,7 +8,9 @@
 #define INCLUDE__PERF_HISI_PTT_H__
 
 #define HISI_PTT_PMU_NAME		"hisi_ptt"
-#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
+#define HISI_PTT_AUXTRACE_PRIV_SIZE_V1	sizeof(u64)
+#define HISI_PTT_AUXTRACE_PRIV_SIZE_V2	(2 * sizeof(u64))
+#define HISI_PTT_AUXTRACE_PRIV_SIZE	HISI_PTT_AUXTRACE_PRIV_SIZE_V2
 
 struct auxtrace_record *hisi_ptt_recording_init(int *err,
 						struct perf_pmu *hisi_ptt_pmu);
-- 
2.33.0

