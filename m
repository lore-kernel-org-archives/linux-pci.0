Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BB470428;
	Thu, 27 Aug 2026 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839508; cv=none; b=FVzIgt3nT2/if37dT8F+lz+iB5x7fuRUfQbu9/EDJnV/1VXtz26bn9zSEsLpl5ag1QSZxu8Ix6lgtEiQgarQ+DNzkHnEenjYZLQ1SS9CsC4HtESA1s4uLo2am36X2gv2QoQj8PUTT1PWRNZpRqMMHMSVyZ0bup6091utKn0IrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839508; c=relaxed/simple;
	bh=x9FZNjE7BK0FM5fHzk/ozdzgy/O26/2/l/qXJTILNJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJPaf/KoRcP/urt2YRXjygtadX42wd5HiESrnmRuwl72UU9qRuhK3ZQBdS5i4OKM8TUbcA3ypwnb+cxHkNKr4PW03TSiX+U2EPgUTNrGbFzRYgYM6ZLU2Xjn+7BgeJdC7wd33vdzKAckyOLrEQf/+iFYYt71azuC7wjJuXt3Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v0A8fK6v; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v0A8fK6v"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cALhk2fAo3M+cttMMDY+eJtrD8Y4RiB0LPwzsD3+JJM=;
	b=v0A8fK6vjKS7Tk4qOlSfQtq+Cn70IcL+0VqtyZPevHjVxsPUQCgmNNEtu5kImS9NopZ+XGtWN
	9d6I8RqY6oQBSeO4gk1eX408k7EBZ4+ydorJamDzmy1KaTPFq36q6x5ILdSrrN5AU5HHt2KXowi
	EDckLEMWGXLGDHq7c6/yBiQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hW2zf3bHFz1T4Fq;
	Thu, 27 Aug 2026 21:53:34 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id C13B040537;
	Thu, 27 Aug 2026 22:04:47 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:04:45 +0800
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
Subject: [PATCH v2 1/8] perf hisi-ptt: Abstract trace data buf and offset
Date: Thu, 27 Aug 2026 22:04:35 +0800
Message-ID: <20260827140442.2031128-2-liusizhe5@huawei.com>
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

Abstract the base address, current offset, length and packet type of
analysing trace data into structure hisi_ptt_pkt_buf and move the step
of current offset into the corresponding functions.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 42 +++++++++----------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  9 +++-
 tools/perf/util/hisi-ptt.c                    | 20 ++++-----
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 72a877fd7236..ef72223d3854 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -75,16 +75,17 @@ static const char * const hisi_ptt_4dw_pkt_field_name[] = {
 	[HISI_PTT_4DW_HEAD3]	= "Header DW3",
 };
 
-static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *desc)
+static void hisi_ptt_print_pkt(struct hisi_ptt_pkt_buf *pkt_buf,
+			       const char *desc)
 {
 	const char *color = PERF_COLOR_BLUE;
 	uint8_t byte;
 	uint32_t dw;
 	int i;
 
-	dw = get_unaligned_le32(buf + pos);
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	printf(".");
-	color_fprintf(stdout, color, "  %08x: ", pos);
+	color_fprintf(stdout, color, "  %08zx: ", pkt_buf->pos);
 	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
 		byte = (dw >> (24 - i * 8)) & 0xFF;
 		color_fprintf(stdout, color, "%02x ", byte);
@@ -92,36 +93,36 @@ static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *de
 	for (i = 0; i < HISI_PTT_MAX_SPACE_LEN; i++)
 		color_fprintf(stdout, color, "   ");
 	color_fprintf(stdout, color, "  %s\n", desc);
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
-static int hisi_ptt_8dw_pkt_desc(const unsigned char *buf, int pos)
+static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
 
 	for (i = 0; i < HISI_PTT_8DW_TYPE_MAX; i++) {
 		/* Do not show 8DW check field and reserved fields */
 		if (i == HISI_PTT_8DW_CHK_AND_RSV0 || i == HISI_PTT_8DW_RSV1) {
-			pos += HISI_PTT_FIELD_LENGTH;
+			pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 			continue;
 		}
 
-		hisi_ptt_print_pkt(buf, pos, hisi_ptt_8dw_pkt_field_name[i]);
-		pos += HISI_PTT_FIELD_LENGTH;
+		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_8dw_pkt_field_name[i]);
 	}
 
 	return hisi_ptt_pkt_size[HISI_PTT_8DW_PKT];
 }
 
-static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
+static void hisi_ptt_4dw_print_dw0(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	const char *color = PERF_COLOR_BLUE;
 	uint8_t byte;
 	uint32_t dw;
 	int i;
 
-	dw = get_unaligned_le32(buf + pos);
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
 	printf(".");
-	color_fprintf(stdout, color, "  %08x: ", pos);
+	color_fprintf(stdout, color, "  %08zx: ", pkt_buf->pos);
 	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
 		byte = (dw >> (24 - i * 8)) & 0xFF;
 		color_fprintf(stdout, color, "%02x ", byte);
@@ -139,27 +140,26 @@ static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
 		      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
 		      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
 		      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
-static int hisi_ptt_4dw_pkt_desc(const unsigned char *buf, int pos)
+static int hisi_ptt_4dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
 
-	hisi_ptt_4dw_print_dw0(buf, pos);
-	pos += HISI_PTT_FIELD_LENGTH;
+	hisi_ptt_4dw_print_dw0(pkt_buf);
 
-	for (i = 0; i < HISI_PTT_4DW_TYPE_MAX; i++) {
-		hisi_ptt_print_pkt(buf, pos, hisi_ptt_4dw_pkt_field_name[i]);
-		pos += HISI_PTT_FIELD_LENGTH;
-	}
+	for (i = 0; i < HISI_PTT_4DW_TYPE_MAX; i++)
+		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_4dw_pkt_field_name[i]);
 
 	return hisi_ptt_pkt_size[HISI_PTT_4DW_PKT];
 }
 
-int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type)
+int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
-	if (type == HISI_PTT_8DW_PKT)
-		return hisi_ptt_8dw_pkt_desc(buf, pos);
+	if (pkt_buf->pkt_type == HISI_PTT_8DW_PKT)
+		return hisi_ptt_8dw_pkt_desc(pkt_buf);
 
-	return hisi_ptt_4dw_pkt_desc(buf, pos);
+	return hisi_ptt_4dw_pkt_desc(pkt_buf);
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 3b349fcc24ae..6747878b030e 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -38,6 +38,13 @@ static int hisi_ptt_pkt_size[] = {
 	[HISI_PTT_8DW_PKT]	= 32,
 };
 
-int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type);
+struct hisi_ptt_pkt_buf {
+	const unsigned char *buf;
+	size_t pos;
+	size_t len;
+	enum hisi_ptt_pkt_type pkt_type;
+};
+
+int hisi_ptt_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf);
 
 #endif
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index e73c57f9e8a4..ea659947c27f 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -57,22 +57,18 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 			  unsigned char *buf, size_t len)
 {
 	const char *color = PERF_COLOR_BLUE;
-	enum hisi_ptt_pkt_type type;
-	size_t pos = 0;
-	int pkt_len;
+	struct hisi_ptt_pkt_buf pkt_buf;
 
-	type = hisi_ptt_check_packet_type(buf, len);
-	len = round_down(len, hisi_ptt_pkt_size[type]);
+	pkt_buf.buf = buf;
+	pkt_buf.pos = 0;
+	pkt_buf.pkt_type = hisi_ptt_check_packet_type(buf, len);
+	pkt_buf.len = round_down(len, hisi_ptt_pkt_size[pkt_buf.pkt_type]);
 	color_fprintf(stdout, color, ". ... HISI PTT data: size %zu bytes\n",
-		      len);
+		      pkt_buf.len);
 
-	while (len > 0) {
-		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
-		if (!pkt_len)
+	while (pkt_buf.pos < pkt_buf.len) {
+		if (!hisi_ptt_pkt_desc(&pkt_buf))
 			color_fprintf(stdout, color, " Bad packet!\n");
-
-		pos += pkt_len;
-		len -= pkt_len;
 	}
 }
 
-- 
2.33.0

