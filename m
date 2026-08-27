Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFA4746D4;
	Thu, 27 Aug 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839530; cv=none; b=lQ3JT4cOQo5UVyM4EuLOaegQt8tr+I6xRrKB7SzNKhkuwqBElvy7efuCcUVVvQmfO8OImBSnQGz93T/XN7KO3Lbj/fAhCWlOGfh7gCAfZ3qL/5zF5RsyJhEm8OA35qsg007uIRarySA/31kdKoHhxvFkOWrFBPIdoAVohSUIhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839530; c=relaxed/simple;
	bh=2Bll0pXG/BKD5FWU3/FFzzWy5NiBAgA4gUtOI+s2mIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrlKfWgqPhqhFpsB626RQyNcJZe2CElQ6ZKrjofD1EWgZYLb5QIVcAGt6J8kYO2rVw/YKxl0Zb7O9NA2MSzlX2YaECIMYV65gDlIL7RHNWIMMxNpJPJ3N3ugHOtKwG8o8nuR2L8Uguo/RhC3nX9YbiUNnthQK+is4lqeh2/wnbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2SOPh4ov; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2SOPh4ov"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AnNsN8WiTpazO5Y4fsGAdj78/MqWIMSSlR+ih3NQDV8=;
	b=2SOPh4ovij9EtkiNGiQgfF1B2//Opvj0WBrMKW4+1mby1nFg2LK9h6LLRCNs/tIyHvv+oN3F4
	QB8PvGM0pzkDQa4KH9uTLuw7Ih9xtXptGA/joWNd8xc5OMxN4rXSgM2HV1cIBLVpeRwkv8j7Dbg
	jy7UqblR2BO3Uio1b/R8Z2M=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hW30L5psXz1cyTS;
	Thu, 27 Aug 2026 21:54:10 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D01640572;
	Thu, 27 Aug 2026 22:04:56 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:04:54 +0800
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
Subject: [PATCH v2 5/8] perf hisi-ptt: Add parsing of supported message types
Date: Thu, 27 Aug 2026 22:04:39 +0800
Message-ID: <20260827140442.2031128-6-liusizhe5@huawei.com>
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

Classify TLP messages by Header DW0 Format field and Type field for
both 4DW and 8DW formats, according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2.

Parsing packets into:
- MWr  (Posted Memory Write request)
- Msg  (Posted Message request)
- Atom (Non-Posted Atomic request)
- IO   (Non-Posted IO request)
- CFG  (Non-Posted Configuration request)
- CPL  (Completion request)

The parsed message type is stored in pkt_buf->pkt_msg_type and will
be used by subsequent patches to select the correct field layout for
DW2 and DW3 printing.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 62 +++++++++++++++++++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 16 +++++
 tools/perf/util/hisi-ptt.c                    |  1 +
 3 files changed, 79 insertions(+)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 00bd9309df68..e63fe1534693 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -79,6 +79,66 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
+/* TLP message parsers below according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2 */
+static bool hisi_ptt_is_mwr_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x2 || format == 0x3) && (type == 0);
+}
+
+static bool hisi_ptt_is_msg_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x1 || format == 0x3) && ((type & 0x18) == 0x10);
+}
+
+static bool hisi_ptt_is_io_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0 || format == 0x2) && (type == 0x2);
+}
+
+static bool hisi_ptt_is_atomic_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0x2 || format == 0x3) &&
+	       (type == 0xc || type == 0xd || type == 0xe);
+}
+
+static bool hisi_ptt_is_cfg_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0 || format == 0x2) && (type == 0x4 || type == 0x5);
+}
+
+static bool hisi_ptt_is_cpl_tlp(uint32_t format, uint32_t type)
+{
+	return (format == 0  || format == 0x2) && (type == 0xa || type == 0xb);
+}
+
+static int hisi_ptt_parse_pkt_msg_type(uint32_t dw,
+				       enum hisi_ptt_pkt_type pkt_type)
+{
+	uint32_t format, type;
+
+	format = (pkt_type == HISI_PTT_4DW_PKT) ?
+		  FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw) :
+		  FIELD_GET(HISI_PTT_HEAD0_8DW_FORMAT, dw);
+	type = (pkt_type == HISI_PTT_4DW_PKT) ?
+		FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw) :
+		FIELD_GET(HISI_PTT_HEAD0_8DW_TYPE, dw);
+
+	if (hisi_ptt_is_mwr_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_MWR;
+	else if (hisi_ptt_is_msg_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_MSG;
+	else if (hisi_ptt_is_atomic_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_ATOM;
+	else if (hisi_ptt_is_io_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_IO;
+	else if (hisi_ptt_is_cfg_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_CFG;
+	else if (hisi_ptt_is_cpl_tlp(format, type))
+		return HISI_PTT_PKT_TYPE_CPL;
+
+	return HISI_PTT_PKT_TYPE_UNKNOWN;
+}
+
 static void hisi_ptt_print_raw_record(size_t offset, uint32_t value)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -114,6 +174,8 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	pkt_buf->pkt_msg_type = hisi_ptt_parse_pkt_msg_type(dw,
+							    pkt_buf->pkt_type);
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
 	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 6747878b030e..9d98362d76b1 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -27,6 +27,10 @@
 #define HISI_PTT_HEAD0_4DW_TYPE		GENMASK_U32(29, 25)
 #define HISI_PTT_HEAD0_4DW_FORMAT	GENMASK_U32(31, 30)
 
+/* Header DW0 fields for 8DW format */
+#define HISI_PTT_HEAD0_8DW_TYPE		GENMASK_U32(28, 24)
+#define HISI_PTT_HEAD0_8DW_FORMAT	GENMASK_U32(31, 29)
+
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
 	HISI_PTT_8DW_PKT,
@@ -38,11 +42,23 @@ static int hisi_ptt_pkt_size[] = {
 	[HISI_PTT_8DW_PKT]	= 32,
 };
 
+enum hisi_ptt_pkt_msg_type {
+	HISI_PTT_PKT_TYPE_UNKNOWN,       /* Types do not support analysis */
+	HISI_PTT_PKT_TYPE_MWR,           /* P-(MemWr) */
+	HISI_PTT_PKT_TYPE_MSG,           /* P-(Message) */
+	HISI_PTT_PKT_TYPE_ATOM,          /* NP-(Atomic) */
+	HISI_PTT_PKT_TYPE_IO,            /* NP-(IO) */
+	HISI_PTT_PKT_TYPE_CFG,           /* NP-(CFG) */
+	HISI_PTT_PKT_TYPE_CPL,           /* CPL-(CPL) */
+	HISI_PTT_PKT_TYPE_MAX
+};
+
 struct hisi_ptt_pkt_buf {
 	const unsigned char *buf;
 	size_t pos;
 	size_t len;
 	enum hisi_ptt_pkt_type pkt_type;
+	enum hisi_ptt_pkt_msg_type pkt_msg_type;
 };
 
 int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf);
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index ea659947c27f..78817ae7a8ea 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -63,6 +63,7 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 	pkt_buf.pos = 0;
 	pkt_buf.pkt_type = hisi_ptt_check_packet_type(buf, len);
 	pkt_buf.len = round_down(len, hisi_ptt_pkt_size[pkt_buf.pkt_type]);
+	pkt_buf.pkt_msg_type = HISI_PTT_PKT_TYPE_UNKNOWN;
 	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
 		      pkt_buf.len);
 
-- 
2.33.0

