Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59280366042;
	Thu,  3 Sep 2026 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421990; cv=none; b=iwuH366EwLU6M5SXzOjRraVXBF7eNnsQXu5IPyTypXpnVcAo2O1xW0O+r/2lNzBloj3bTrf2jxJ2XLuTiwTbJ5z+OvZq75cjqoE76QDlSfWC47RIIpGk7q96MzpXYJXjqXxoFp+E4JVnbSmoFhvxLq8e83xsKZPuOZSpumeBypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421990; c=relaxed/simple;
	bh=uB2voWJWWwqcwEfU4mBDv4gB2UDIvsJNQF5p2Fb+13c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENK542OQdEyyHjPrZ+1PmW9aG54mXdD7Uxl05pygLGozUqrr4eBkv3SD7uU5uesqHfIhNH6JE9usIPsrCGVRVcq9F3I19ceWuf/uWdBKCGjCog6xOBnk/i1sKb/qE1AcrOihPTcvq/7AuvUtJpCHYEtYJspBaoYiJzXkMdSFSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y9W2izZZ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y9W2izZZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XltDT7kt/cIBZMrmqOCKCSZiG6zYBIDIlmJb3RAiwnw=;
	b=y9W2izZZRALfN04PVSBoy60UUxghLoFMg274T7qcSPB364qIXa6f6M5CqTjzcMfiQYrKTiDt+
	qKfC9YlBAEj+3GmLMgNIRRrHAYFIvpG3TApCF6lvfZDVgOIYP0XZpTl4uFBoNsz0xPui9fLkj3O
	RLWDqH67JYq6tm1nKzHpe0c=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hbBPD24j6zpT0s;
	Thu,  3 Sep 2026 15:41:36 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id AB03440538;
	Thu,  3 Sep 2026 15:52:58 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 15:52:56 +0800
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
Subject: [PATCH v3 6/8] perf hisi-ptt: Add field-level parsing for header DW2/DW3
Date: Thu, 3 Sep 2026 15:52:39 +0800
Message-ID: <20260903075241.1445338-7-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260903075241.1445338-1-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo200004.china.huawei.com (7.152.184.18)

Add field-level parsing of Header DW2 and DW3 of the TLP, separating
the layout for CFG TLPs and CPL TLPs. The message type parsed in the
previous patch is used to select the correct field layout.

DW2 fields are common to MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr
TLPs, parsed with FIELD_GET() against HISI_PTT_HEAD2_* masks.

DW3 fields have two layouts:
- CfgRd0/CfgWr0/CfgRd1/CfgWr1 use HISI_PTT_HEAD3_CFG_* masks
- Cpl/CplD/CplLk/CplDlk use HISI_PTT_HEAD3_CPL_* masks

HiSilicon PCIe trace device hardware is responsible for packet collection,
parsing, extraction and fills the corresponding fields with the required
positions. The packet decoder software will perform the parsing and
printing of fields filled by hardware.

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 111 ++++++++++++++++--
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  39 ++++++
 2 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index e63fe1534693..de1d4071e209 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -197,6 +197,89 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
+static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	/* Currently, no distinction here for 4DW foramt and 8DW format */
+	hisi_ptt_print_pkt(pkt_buf,
+			   hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD1]);
+}
+
+static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *color = PERF_COLOR_BLUE;
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Reserved",
+			      FIELD_GET(HISI_PTT_HEAD2_RESERVED, dw),
+			      "Request Segment",
+			      FIELD_GET(HISI_PTT_HEAD2_REQ_SEG, dw),
+			      "RSV", FIELD_GET(HISI_PTT_HEAD2_RSV, dw),
+			      "TV", FIELD_GET(HISI_PTT_HEAD2_TV, dw),
+			      "T", FIELD_GET(HISI_PTT_HEAD2_T, dw),
+			      "Tag", FIELD_GET(HISI_PTT_HEAD2_TAG, dw),
+			      "Header DW2",
+			      FIELD_GET(HISI_PTT_HEAD2_HEADER_DW2, dw));
+	else
+		color_fprintf(stdout, color, "  %s\n",
+			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2]);
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
+static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *color = PERF_COLOR_BLUE;
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Destination Segment",
+			      FIELD_GET(HISI_PTT_HEAD3_CPL_DST_SEG, dw),
+			      "Completer Segment",
+			      FIELD_GET(HISI_PTT_HEAD3_CPL_CPL_SEG, dw),
+			      "DSV", FIELD_GET(HISI_PTT_HEAD3_CPL_DSV, dw),
+			      "Reserved",
+			      FIELD_GET(HISI_PTT_HEAD3_CPL_RESERVED, dw),
+			      "TV", FIELD_GET(HISI_PTT_HEAD3_CPL_TV, dw),
+			      "T", FIELD_GET(HISI_PTT_HEAD3_CPL_T, dw),
+			      "Tag", FIELD_GET(HISI_PTT_HEAD3_CPL_TAG, dw));
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CFG)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Reserved",
+			      FIELD_GET(HISI_PTT_HEAD3_CFG_RESERVED, dw),
+			      "Destination Segment",
+			      FIELD_GET(HISI_PTT_HEAD3_CFG_DST_SEG, dw),
+			      "DSV", FIELD_GET(HISI_PTT_HEAD3_CFG_DSV, dw),
+			      "TV", FIELD_GET(HISI_PTT_HEAD3_CFG_TV, dw),
+			      "T", FIELD_GET(HISI_PTT_HEAD3_CFG_T, dw),
+			      "Tag", FIELD_GET(HISI_PTT_HEAD3_CFG_TAG, dw),
+			      "Header DW3",
+			      FIELD_GET(HISI_PTT_HEAD3_CFG_HEADER_DW3, dw));
+	else
+		color_fprintf(stdout, color, "  %s\n",
+			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3]);
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
 static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
@@ -208,12 +291,24 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 			continue;
 		}
 
-		if (i == HISI_PTT_8DW_HEAD0) {
+		switch (i) {
+		case HISI_PTT_8DW_HEAD0:
 			hisi_ptt_print_head0(pkt_buf);
-			continue;
+			break;
+		case HISI_PTT_8DW_HEAD1:
+			hisi_ptt_print_head1(pkt_buf);
+			break;
+		case HISI_PTT_8DW_HEAD2:
+			hisi_ptt_print_head2(pkt_buf);
+			break;
+		case HISI_PTT_8DW_HEAD3:
+			hisi_ptt_print_head3(pkt_buf);
+			break;
+		default:
+			hisi_ptt_print_pkt(pkt_buf,
+					   hisi_ptt_8dw_pkt_field_name[i]);
+			break;
 		}
-
-		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_8dw_pkt_field_name[i]);
 	}
 
 	return hisi_ptt_pkt_size[HISI_PTT_8DW_PKT];
@@ -221,12 +316,10 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 
 static int hisi_ptt_4dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
-	int i;
-
 	hisi_ptt_print_head0(pkt_buf);
-
-	for (i = HISI_PTT_4DW_HEAD1; i < HISI_PTT_4DW_TYPE_MAX; i++)
-		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_4dw_pkt_field_name[i]);
+	hisi_ptt_print_head1(pkt_buf);
+	hisi_ptt_print_head2(pkt_buf);
+	hisi_ptt_print_head3(pkt_buf);
 
 	return hisi_ptt_pkt_size[HISI_PTT_4DW_PKT];
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 436712e67a6f..61bf3b11a467 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -32,6 +32,45 @@
 #define HISI_PTT_HEAD0_8DW_TYPE		GENMASK_U32(28, 24)
 #define HISI_PTT_HEAD0_8DW_FORMAT	GENMASK_U32(31, 29)
 
+/* Header DW2 fields for MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr TLPs
+ *   bits   [   31   ][     30:23      ][22][21][20][  19:16  ][   15:0   ]
+ *          |---------|----------------|----|---|--|-----------|----------|
+ *   fields [Reserved][Request Segment][RSV][TV][T][Tag<13:10>][Header DW2]
+ */
+#define HISI_PTT_HEAD2_HEADER_DW2	GENMASK_U32(15, 0)
+#define HISI_PTT_HEAD2_TAG		GENMASK_U32(19, 16)
+#define HISI_PTT_HEAD2_T		BIT_U32(20)
+#define HISI_PTT_HEAD2_TV		BIT_U32(21)
+#define HISI_PTT_HEAD2_RSV		BIT_U32(22)
+#define HISI_PTT_HEAD2_REQ_SEG		GENMASK_U32(30, 23)
+#define HISI_PTT_HEAD2_RESERVED		BIT_U32(31)
+
+/* Header DW3 fields for CfgRd0/CfgWr0/CfgRd1/CfgWr1 TLPs
+ *   bits   [   31   ][       30:23        ][22][21][20][  19:16  ][   15:0   ]
+ *          |---------|--------------------|----|---|--|-----------|----------|
+ *   fields [Reserved][Destination Segment][DSV][TV][T][Tag<13:10>][Header DW3]
+ */
+#define HISI_PTT_HEAD3_CFG_HEADER_DW3	GENMASK_U32(15, 0)
+#define HISI_PTT_HEAD3_CFG_TAG		GENMASK_U32(19, 16)
+#define HISI_PTT_HEAD3_CFG_T		BIT_U32(20)
+#define HISI_PTT_HEAD3_CFG_TV		BIT_U32(21)
+#define HISI_PTT_HEAD3_CFG_DSV		BIT_U32(22)
+#define HISI_PTT_HEAD3_CFG_DST_SEG	GENMASK_U32(30, 23)
+#define HISI_PTT_HEAD3_CFG_RESERVED	BIT_U32(31)
+
+/* Header DW3 fields for Cpl/CplD/CplLk/CplDlk TLPs
+ *   bits   [       31:24       ][       23:16      ][15][  14:6   ][5][4][   3:0    ]
+ *          |--------------------|------------------|----|---------|--|---|----------|
+ *   fields [Destination Segment][Completer Segment][DSV][Reserved][TV][T][Tag<13:10>]
+ */
+#define HISI_PTT_HEAD3_CPL_TAG		GENMASK_U32(3, 0)
+#define HISI_PTT_HEAD3_CPL_T		BIT_U32(4)
+#define HISI_PTT_HEAD3_CPL_TV		BIT_U32(5)
+#define HISI_PTT_HEAD3_CPL_RESERVED	GENMASK_U32(14, 6)
+#define HISI_PTT_HEAD3_CPL_DSV		BIT_U32(15)
+#define HISI_PTT_HEAD3_CPL_CPL_SEG	GENMASK_U32(23, 16)
+#define HISI_PTT_HEAD3_CPL_DST_SEG	GENMASK_U32(31, 24)
+
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
 	HISI_PTT_8DW_PKT,
-- 
2.33.0

