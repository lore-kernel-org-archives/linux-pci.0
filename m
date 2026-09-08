Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0454B1C8;
	Tue,  8 Sep 2026 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876351; cv=none; b=RBhhuAd/gbShfUG9HRPhsuOeFeAG5CvGfCIzZi04W7IS499wjh6viNOGUEJcaQiEYv5Rd7Gq0xZtL3/U80/PimL7/m7yE0olR0fK9NGDW0F90wDrH4Ld4qnagkxEbQWs0JygGlOyjLnHD0imnBd0UW1kwY72YGK/CbTPmzsm/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876351; c=relaxed/simple;
	bh=tSY5lNtVSw6p8ePg7zmHWZJCwiirVE5tq8scnE5IqzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kk0/ZKLFTf3HGw2cueRGOID2ZPQhXts4qglMnXu6wQfkxWnyfs+OOL0HCmzmyO+OIkCTCzirvnHlwwrZbYP1/1pSmeW1XYGLT6W1aNoOSZ3A5mqppC9+SYNQ/uE+YZ46MO2GKIXxt0427+uQAOkv6vFd6ag6XwLpTOLhb+fq7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vyssBvWB; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vyssBvWB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Mj4oUaNTXUKRZc4TY/6jCY6Ial69B+rhkh2dGvFv3xE=;
	b=vyssBvWBAaVrreqCYSQJ9G/JHXv5LyFNd9doaOUO5KWwcYH3rMk2VlDTilUVgt27GRqThHLC+
	wX5RUcYDRw25CWCX1AVxCd4oukXXvX8ZvHawgbRZZjs1u7/QwsO58u45ZTOl0hX//LnyLwb0+AC
	udQfRqRzRzT9PPb42zYDF3I=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hfQRG5BRPzRhVP;
	Tue,  8 Sep 2026 21:54:34 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 4051140561;
	Tue,  8 Sep 2026 22:05:26 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 22:05:23 +0800
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
Subject: [PATCH v4 6/8] perf hisi-ptt: Add field-level parsing for header DW0/DW1/DW2/DW3
Date: Tue, 8 Sep 2026 22:05:07 +0800
Message-ID: <20260908140509.2485649-7-liusizhe5@huawei.com>
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

Add field-level parsing of Header DW0, DW1, DW2 and DW3 of the TLP,
separating the layout for different requests. The message type parsed in
the previous patch is used to select the corresponding field layout.

HiSilicon PCIe trace device hardware is responsible for packet collection,
parsing, extraction and fills the corresponding fields with the required
positions. The packet decoder software will perform the parsing and
printing of fields filled by hardware.

Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 386 +++++++++++++++++-
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 194 ++++++++-
 2 files changed, 545 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index c9515676ba5c..482a50c2e9f5 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -196,9 +196,42 @@ static void hisi_ptt_print_pkt(struct hisi_ptt_pkt_buf *pkt_buf,
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
+static void hisi_ptt_print_head0_4dw_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Format", FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw),
+		      "Type", FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw),
+		      "T9", FIELD_GET(HISI_PTT_HEAD0_4DW_T9, dw),
+		      "T8", FIELD_GET(HISI_PTT_HEAD0_4DW_T8, dw),
+		      "TH", FIELD_GET(HISI_PTT_HEAD0_4DW_TH, dw),
+		      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
+		      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
+		      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
+}
+
+static void hisi_ptt_print_head0_8dw_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Format",
+		      FIELD_GET(HISI_PTT_HEAD0_8DW_FORMAT, dw),
+		      "Type", FIELD_GET(HISI_PTT_HEAD0_8DW_TYPE, dw),
+		      "T9", FIELD_GET(HISI_PTT_HEAD0_8DW_T9, dw),
+		      "TC", FIELD_GET(HISI_PTT_HEAD0_8DW_TC, dw),
+		      "T8", FIELD_GET(HISI_PTT_HEAD0_8DW_T8, dw),
+		      "A2", FIELD_GET(HISI_PTT_HEAD0_8DW_A2, dw),
+		      "LN", FIELD_GET(HISI_PTT_HEAD0_8DW_LN, dw),
+		      "TH", FIELD_GET(HISI_PTT_HEAD0_8DW_TH, dw),
+		      "TD", FIELD_GET(HISI_PTT_HEAD0_8DW_TD, dw),
+		      "EP", FIELD_GET(HISI_PTT_HEAD0_8DW_EP, dw),
+		      "Attr<1:0>", FIELD_GET(HISI_PTT_HEAD0_8DW_ATTR_1_0, dw),
+		      "AT", FIELD_GET(HISI_PTT_HEAD0_8DW_AT, dw),
+		      "Length", FIELD_GET(HISI_PTT_HEAD0_8DW_LEN, dw));
+}
+
 static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 {
-	const char *color = PERF_COLOR_BLUE;
 	uint32_t dw;
 
 	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
@@ -206,24 +239,323 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
 
 	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
-		color_fprintf(stdout, color,
-			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
-			      "Format",
-			      FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw),
-			      "Type", FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw),
-			      "T9", FIELD_GET(HISI_PTT_HEAD0_4DW_T9, dw),
-			      "T8", FIELD_GET(HISI_PTT_HEAD0_4DW_T8, dw),
-			      "TH", FIELD_GET(HISI_PTT_HEAD0_4DW_TH, dw),
-			      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
-			      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
-			      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
+		hisi_ptt_print_head0_4dw_fields(dw);
+	else if (pkt_buf->pkt_type == HISI_PTT_8DW_PKT)
+		hisi_ptt_print_head0_8dw_fields(dw);
 	else
-		color_fprintf(stdout, color, "  %s\n",
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
 			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD0]);
 
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
+static void hisi_ptt_print_head1_ar64_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x\n",
+		      "Requester ID", FIELD_GET(HISI_PTT_HEAD1_AR64_REQ_ID, dw),
+		      "Tag<7:0>", FIELD_GET(HISI_PTT_HEAD1_AR64_TAG_7_0, dw),
+		      "Last DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_AR64_LAST_DW_BE, dw),
+		      "First DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_AR64_FIRST_DW_BE, dw));
+}
+
+static void hisi_ptt_print_head1_ar32_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x\n",
+		      "Requester ID", FIELD_GET(HISI_PTT_HEAD1_AR32_REQ_ID, dw),
+		      "Tag<7:0>", FIELD_GET(HISI_PTT_HEAD1_AR32_TAG_7_0, dw),
+		      "Last DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_AR32_LAST_DW_BE, dw),
+		      "First DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_AR32_FIRST_DW_BE, dw));
+}
+
+static void hisi_ptt_print_head1_cfg_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x\n",
+		      "Requester ID", FIELD_GET(HISI_PTT_HEAD1_CFG_REQ_ID, dw),
+		      "Tag<7:0>", FIELD_GET(HISI_PTT_HEAD1_CFG_TAG_7_0, dw),
+		      "Last DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_CFG_LAST_DW_BE, dw),
+		      "First DW BE",
+		      FIELD_GET(HISI_PTT_HEAD1_CFG_FIRST_DW_BE, dw));
+}
+
+static void hisi_ptt_print_head1_cpl_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x\n",
+		      "Completer ID", FIELD_GET(HISI_PTT_HEAD1_CPL_COM_ID, dw),
+		      "Cpl Status", FIELD_GET(HISI_PTT_HEAD1_CPL_STA, dw),
+		      "BCM", FIELD_GET(HISI_PTT_HEAD1_CPL_BCM, dw),
+		      "Byte Count", FIELD_GET(HISI_PTT_HEAD1_CPL_BYTE_CNT, dw));
+}
+
+static void hisi_ptt_print_head1_msg_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x\n",
+		      "Requester ID", FIELD_GET(HISI_PTT_HEAD1_MSG_REQ_ID, dw),
+		      "Tag<7:0>", FIELD_GET(HISI_PTT_HEAD1_MSG_TAG_7_0, dw),
+		      "Message Code", FIELD_GET(HISI_PTT_HEAD1_MSG_CODE, dw));
+}
+
+static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	switch (pkt_buf->pkt_msg_type) {
+	case HISI_PTT_PKT_TYPE_MRD:
+	case HISI_PTT_PKT_TYPE_MWR:
+	case HISI_PTT_PKT_TYPE_DMWR:
+	case HISI_PTT_PKT_TYPE_ATOM:
+	case HISI_PTT_PKT_TYPE_IO:
+		if (pkt_buf->proto_len == HISI_PTT_4DW_HEADER_PROTO_LEN)
+			hisi_ptt_print_head1_ar64_fields(dw);
+		else
+			hisi_ptt_print_head1_ar32_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CFG:
+		hisi_ptt_print_head1_cfg_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CPL:
+		hisi_ptt_print_head1_cpl_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_MSG:
+		hisi_ptt_print_head1_msg_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_UNKNOWN:
+	case HISI_PTT_PKT_TYPE_MAX:
+	default:
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
+			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD1] :
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD1]);
+		break;
+	}
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
+static void hisi_ptt_print_head2_ar64_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "RSV2", FIELD_GET(HISI_PTT_HEAD2_AR64_RSV2, dw),
+		      "Request Segment",
+		      FIELD_GET(HISI_PTT_HEAD2_AR64_REQ_SEG, dw),
+		      "RSV1", FIELD_GET(HISI_PTT_HEAD2_AR64_RSV1, dw),
+		      "TV", FIELD_GET(HISI_PTT_HEAD2_AR64_TV, dw),
+		      "T", FIELD_GET(HISI_PTT_HEAD2_AR64_T, dw),
+		      "Tag<13:10>",
+		      FIELD_GET(HISI_PTT_HEAD2_AR64_TAG_13_10, dw),
+		      "Addr<47:32>",
+		      FIELD_GET(HISI_PTT_HEAD2_AR64_ADDR_47_32, dw));
+}
+
+static void hisi_ptt_print_head2_ar32_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x\n",
+		      "Addr<31:2>",
+		      FIELD_GET(HISI_PTT_HEAD2_AR32_ADDR_31_2, dw),
+		      "PH<1:0>", FIELD_GET(HISI_PTT_HEAD2_AR32_PH_1_0, dw));
+}
+
+static void hisi_ptt_print_head2_io_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x\n",
+		      "Addr<31:2>",
+		      FIELD_GET(HISI_PTT_HEAD2_AR32_ADDR_31_2, dw),
+		      "Reserved", FIELD_GET(HISI_PTT_HEAD2_AR32_IO_RSV, dw));
+}
+
+static void hisi_ptt_print_head2_cfg_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x\n",
+		      "Destination ID",
+		      FIELD_GET(HISI_PTT_HEAD2_CFG_DST_ID, dw),
+		      "RSV2", FIELD_GET(HISI_PTT_HEAD2_CFG_RSV2, dw),
+		      "Ext Reg Num",
+		      FIELD_GET(HISI_PTT_HEAD2_CFG_REG_NUM_EXT, dw),
+		      "Register Number",
+		      FIELD_GET(HISI_PTT_HEAD2_CFG_REG_NUM, dw),
+		      "RSV1", FIELD_GET(HISI_PTT_HEAD2_CFG_RSV1, dw));
+}
+
+static void hisi_ptt_print_head2_cpl_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x\n",
+		      "Requester ID", FIELD_GET(HISI_PTT_HEAD2_CPL_REQ_ID, dw),
+		      "Tag<7:0>", FIELD_GET(HISI_PTT_HEAD2_CPL_TAG_7_0, dw),
+		      "Reserved", FIELD_GET(HISI_PTT_HEAD2_CPL_RSV, dw),
+		      "Lower Address",
+		      FIELD_GET(HISI_PTT_HEAD2_CPL_LO_ADDR, dw));
+}
+
+static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	switch (pkt_buf->pkt_msg_type) {
+	case HISI_PTT_PKT_TYPE_MRD:
+	case HISI_PTT_PKT_TYPE_MWR:
+	case HISI_PTT_PKT_TYPE_DMWR:
+	case HISI_PTT_PKT_TYPE_ATOM:
+		if (pkt_buf->proto_len == HISI_PTT_4DW_HEADER_PROTO_LEN)
+			hisi_ptt_print_head2_ar64_fields(dw);
+		else
+			hisi_ptt_print_head2_ar32_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_IO:
+		hisi_ptt_print_head2_io_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CFG:
+		hisi_ptt_print_head2_cfg_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CPL:
+		hisi_ptt_print_head2_cpl_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_MSG:
+	case HISI_PTT_PKT_TYPE_UNKNOWN:
+	case HISI_PTT_PKT_TYPE_MAX:
+	default:
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
+			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD2] :
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD2]);
+		break;
+	}
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
+static void hisi_ptt_print_head3_ar64_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x\n",
+		      "Addr<31:2>",
+		      FIELD_GET(HISI_PTT_HEAD3_AR64_ADDR_31_2, dw),
+		      "PH<1:0>", FIELD_GET(HISI_PTT_HEAD3_AR64_PH_1_0, dw));
+}
+
+static void hisi_ptt_print_head3_ar32_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Request Segment",
+		      FIELD_GET(HISI_PTT_HEAD3_AR32_REQ_SEG, dw),
+		      "ST<15:8>", FIELD_GET(HISI_PTT_HEAD3_AR32_ST_15_8, dw),
+		      "RSV2", FIELD_GET(HISI_PTT_HEAD3_AR32_RSV2, dw),
+		      "HV", FIELD_GET(HISI_PTT_HEAD3_AR32_HV, dw),
+		      "AMA", FIELD_GET(HISI_PTT_HEAD3_AR32_AMA, dw),
+		      "AV", FIELD_GET(HISI_PTT_HEAD3_AR32_AV, dw),
+		      "FM", FIELD_GET(HISI_PTT_HEAD3_AR32_FM, dw),
+		      "RSV1", FIELD_GET(HISI_PTT_HEAD3_AR32_RSV1, dw),
+		      "TV", FIELD_GET(HISI_PTT_HEAD3_AR32_TV, dw),
+		      "T", FIELD_GET(HISI_PTT_HEAD3_AR32_T, dw),
+		      "Tag<13:10>",
+		      FIELD_GET(HISI_PTT_HEAD3_AR32_TAG_13_10, dw));
+}
+
+static void hisi_ptt_print_head3_io_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Request Segment",
+		      FIELD_GET(HISI_PTT_HEAD3_AR32_REQ_SEG, dw),
+		      "RSV2", FIELD_GET(HISI_PTT_HEAD3_AR32_IO_RSV2, dw),
+		      "FM", FIELD_GET(HISI_PTT_HEAD3_AR32_FM, dw),
+		      "RSV1", FIELD_GET(HISI_PTT_HEAD3_AR32_RSV1, dw),
+		      "TV", FIELD_GET(HISI_PTT_HEAD3_AR32_TV, dw),
+		      "T", FIELD_GET(HISI_PTT_HEAD3_AR32_T, dw),
+		      "Tag<13:10>",
+		      FIELD_GET(HISI_PTT_HEAD3_AR32_TAG_13_10, dw));
+}
+
+static void hisi_ptt_print_head3_cfg_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "RSV2", FIELD_GET(HISI_PTT_HEAD3_CFG_RSV2, dw),
+		      "Destination Segment",
+		      FIELD_GET(HISI_PTT_HEAD3_CFG_DST_SEG, dw),
+		      "DSV", FIELD_GET(HISI_PTT_HEAD3_CFG_DSV, dw),
+		      "TV", FIELD_GET(HISI_PTT_HEAD3_CFG_TV, dw),
+		      "T", FIELD_GET(HISI_PTT_HEAD3_CFG_T, dw),
+		      "Tag<13:10>", FIELD_GET(HISI_PTT_HEAD3_CFG_TAG_13_10, dw),
+		      "RSV1", FIELD_GET(HISI_PTT_HEAD3_CFG_RSV1, dw));
+}
+
+static void hisi_ptt_print_head3_cpl_fields(uint32_t dw)
+{
+	color_fprintf(stdout, PERF_COLOR_BLUE,
+		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+		      "Destination Segment",
+		      FIELD_GET(HISI_PTT_HEAD3_CPL_DST_SEG, dw),
+		      "Completer Segment",
+		      FIELD_GET(HISI_PTT_HEAD3_CPL_COM_SEG, dw),
+		      "DSV", FIELD_GET(HISI_PTT_HEAD3_CPL_DSV, dw),
+		      "Reserved", FIELD_GET(HISI_PTT_HEAD3_CPL_RSV, dw),
+		      "TV", FIELD_GET(HISI_PTT_HEAD3_CPL_TV, dw),
+		      "T", FIELD_GET(HISI_PTT_HEAD3_CPL_T, dw),
+		      "Tag<13:10>",
+		      FIELD_GET(HISI_PTT_HEAD3_CPL_TAG_13_10, dw));
+}
+
+static void hisi_ptt_print_head3(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	switch (pkt_buf->pkt_msg_type) {
+	case HISI_PTT_PKT_TYPE_MRD:
+	case HISI_PTT_PKT_TYPE_MWR:
+	case HISI_PTT_PKT_TYPE_DMWR:
+	case HISI_PTT_PKT_TYPE_ATOM:
+		if (pkt_buf->proto_len == HISI_PTT_4DW_HEADER_PROTO_LEN)
+			hisi_ptt_print_head3_ar64_fields(dw);
+		else
+			hisi_ptt_print_head3_ar32_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_IO:
+		hisi_ptt_print_head3_io_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CFG:
+		hisi_ptt_print_head3_cfg_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_CPL:
+		hisi_ptt_print_head3_cpl_fields(dw);
+		break;
+	case HISI_PTT_PKT_TYPE_MSG:
+	case HISI_PTT_PKT_TYPE_UNKNOWN:
+	case HISI_PTT_PKT_TYPE_MAX:
+	default:
+		color_fprintf(stdout, PERF_COLOR_BLUE, "  %s\n",
+			      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+			      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD3] :
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD3]);
+		break;
+	}
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
 static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
@@ -235,12 +567,24 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
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
@@ -248,12 +592,10 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 
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
index f02ba29dfe00..5f71cfdcb7a7 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -20,19 +20,187 @@
 #define HISI_PTT_3DW_HEADER_PROTO_LEN		3
 #define HISI_PTT_4DW_HEADER_PROTO_LEN		4
 
-/* Header DW0 fields for 4DW format */
-#define HISI_PTT_HEAD0_4DW_TIME		GENMASK_U32(10, 0)
-#define HISI_PTT_HEAD0_4DW_LEN		GENMASK_U32(20, 11)
-#define HISI_PTT_HEAD0_4DW_SO		BIT_U32(21)
-#define HISI_PTT_HEAD0_4DW_TH		BIT_U32(22)
-#define HISI_PTT_HEAD0_4DW_T8		BIT_U32(23)
-#define HISI_PTT_HEAD0_4DW_T9		BIT_U32(24)
-#define HISI_PTT_HEAD0_4DW_TYPE		GENMASK_U32(29, 25)
-#define HISI_PTT_HEAD0_4DW_FORMAT	GENMASK_U32(31, 30)
-
-/* Header DW0 fields for 8DW format */
-#define HISI_PTT_HEAD0_8DW_TYPE		GENMASK_U32(28, 24)
-#define HISI_PTT_HEAD0_8DW_FORMAT	GENMASK_U32(31, 29)
+/* Hisi PTT Header DW0 fields for 4DW format
+ *
+ * bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
+ *      |-----|---------|---|---|---|---|-------------|-------------|
+ * DW0  [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
+ */
+#define HISI_PTT_HEAD0_4DW_TIME			GENMASK_U32(10, 0)
+#define HISI_PTT_HEAD0_4DW_LEN			GENMASK_U32(20, 11)
+#define HISI_PTT_HEAD0_4DW_SO			BIT_U32(21)
+#define HISI_PTT_HEAD0_4DW_TH			BIT_U32(22)
+#define HISI_PTT_HEAD0_4DW_T8			BIT_U32(23)
+#define HISI_PTT_HEAD0_4DW_T9			BIT_U32(24)
+#define HISI_PTT_HEAD0_4DW_TYPE			GENMASK_U32(29, 25)
+#define HISI_PTT_HEAD0_4DW_FORMAT		GENMASK_U32(31, 30)
+
+/* Hisi PTT Header DW0 fields for 8DW format
+ *
+ * bits [31:29][28:24][23][22:20][19][18][17][16][15][14][  13:12  ][11:10][    9:0    ]
+ *      |------|------|---|------|---|---|---|---|---|---|----------|------|-----------|
+ * DW0  [ Fmt ][Type] [T9][ TC ] [T8][A2][LN][TH][TD][EP][ATTR<1:0>][ AT ] [  Length   ]
+ */
+#define HISI_PTT_HEAD0_8DW_LEN			GENMASK_U32(9, 0)
+#define HISI_PTT_HEAD0_8DW_AT			GENMASK_U32(11, 10)
+#define HISI_PTT_HEAD0_8DW_ATTR_1_0		GENMASK_U32(13, 12)
+#define HISI_PTT_HEAD0_8DW_EP			BIT_U32(14)
+#define HISI_PTT_HEAD0_8DW_TD			BIT_U32(15)
+#define HISI_PTT_HEAD0_8DW_TH			BIT_U32(16)
+#define HISI_PTT_HEAD0_8DW_LN			BIT_U32(17)
+#define HISI_PTT_HEAD0_8DW_A2			BIT_U32(18)
+#define HISI_PTT_HEAD0_8DW_T8			BIT_U32(19)
+#define HISI_PTT_HEAD0_8DW_TC			GENMASK_U32(22, 20)
+#define HISI_PTT_HEAD0_8DW_T9			BIT_U32(23)
+#define HISI_PTT_HEAD0_8DW_TYPE			GENMASK_U32(28, 24)
+#define HISI_PTT_HEAD0_8DW_FORMAT		GENMASK_U32(31, 29)
+
+/* Hisi PTT Header DW1/DW2/DW3 fields for 64-bit Address-Based Routing TLPs
+ * Used with Memory rd/wr DMWr and AtomicOp Requests.
+ *
+ * bits [   31:16    ][  15:8  ][    7:4   ][    3:0    ]
+ *      |-------------|---------|-----------|-----------|
+ * DW1  [Requester ID][Tag<7:0>][Last DW BE][First DW BE]
+ *
+ * bits [   31   ][     30:23     ][ 22 ][21][20][  19:16  ][     15:0     ]
+ *      |---------|----------------|-----|---|--|-----------|--------------|
+ * DW2  [  RSV2   ][Request Segment][RSV1][TV][T][Tag<13:10>][Address<47:32>]
+ *
+ * bits [     31:2    ][  1:0  ]
+ *      |--------------|-------|
+ * DW3  [Address<31:2>][PH<1:0>]
+ */
+#define HISI_PTT_HEAD1_AR64_REQ_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD1_AR64_TAG_7_0		GENMASK_U32(15, 8)
+#define HISI_PTT_HEAD1_AR64_LAST_DW_BE		GENMASK_U32(7, 4)
+#define HISI_PTT_HEAD1_AR64_FIRST_DW_BE		GENMASK_U32(3, 0)
+#define HISI_PTT_HEAD2_AR64_RSV2		BIT_U32(31)
+#define HISI_PTT_HEAD2_AR64_REQ_SEG		GENMASK_U32(30, 23)
+#define HISI_PTT_HEAD2_AR64_RSV1		BIT_U32(22)
+#define HISI_PTT_HEAD2_AR64_TV			BIT_U32(21)
+#define HISI_PTT_HEAD2_AR64_T			BIT_U32(20)
+#define HISI_PTT_HEAD2_AR64_TAG_13_10		GENMASK_U32(19, 16)
+#define HISI_PTT_HEAD2_AR64_ADDR_47_32		GENMASK_U32(15, 0)
+#define HISI_PTT_HEAD3_AR64_ADDR_31_2		GENMASK_U32(31, 2)
+#define HISI_PTT_HEAD3_AR64_PH_1_0		GENMASK_U32(1, 0)
+
+/* Hisi PTT Header DW1/DW2/DW3 fields for 32-bit Address-Based Routing TLPs
+ * Used with Memory rd/wr DMWr, AtomicOp and I/O Requests.
+ *
+ * bits [   31:16    ][  15:8  ][    7:4   ][    3:0    ]
+ *      |-------------|---------|-----------|-----------|
+ * DW1  [Requester ID][Tag<7:0>][Last DW BE][First DW BE]
+ *
+ * For Memory rd/wr DMWr and AtomicOp Requests
+ * bits [     31:2    ][  1:0  ]
+ *      |--------------|-------|
+ * DW2  [Address<31:2>][PH<1:0>]
+ *
+ * For I/O Transactions
+ * bits [     31:2    ][   1:0  ]
+ *      |--------------|--------|
+ * DW2  [Address<31:2>][Reserved]
+ *
+ * For Memory rd/wr DMWr and AtomicOp Requests
+ * bits [     31:24      ][  23:16 ][ 15:14 ][13:12][11:9] [8 ][7 ][ 6  ][5 ][4][    3:0   ]
+ *      |-----------------|---------|--------|------|------|---|---|-----|---|--|----------|
+ * DW3  [Request Segments][ST<15:8>][ RSV2  ][  HV ][ AMA ][AV][FM][RSV1][TV][T][Tag<13:10>]
+ *
+ * For I/O Transactions
+ * bits [     31:24      ][  23:8  ][7 ][ 6  ][5 ][4][    3:0   ]
+ *      |-----------------|---------|---|-----|---|--|----------|
+ * DW3  [Request Segments][  RSV2  ][FM][RSV1][TV][T][Tag<13:10>]
+ */
+#define HISI_PTT_HEAD1_AR32_REQ_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD1_AR32_TAG_7_0		GENMASK_U32(15, 8)
+#define HISI_PTT_HEAD1_AR32_LAST_DW_BE		GENMASK_U32(7, 4)
+#define HISI_PTT_HEAD1_AR32_FIRST_DW_BE		GENMASK_U32(3, 0)
+#define HISI_PTT_HEAD2_AR32_ADDR_31_2		GENMASK_U32(31, 2)
+#define HISI_PTT_HEAD2_AR32_PH_1_0		GENMASK_U32(1, 0)
+#define HISI_PTT_HEAD2_AR32_IO_RSV		GENMASK_U32(1, 0)
+#define HISI_PTT_HEAD3_AR32_REQ_SEG		GENMASK_U32(31, 24)
+#define HISI_PTT_HEAD3_AR32_ST_15_8		GENMASK_U32(23, 16)
+#define HISI_PTT_HEAD3_AR32_RSV2		GENMASK_U32(15, 14)
+#define HISI_PTT_HEAD3_AR32_HV			GENMASK_U32(13, 12)
+#define HISI_PTT_HEAD3_AR32_AMA			GENMASK_U32(11, 9)
+#define HISI_PTT_HEAD3_AR32_AV			BIT_U32(8)
+#define HISI_PTT_HEAD3_AR32_FM			BIT_U32(7)
+#define HISI_PTT_HEAD3_AR32_RSV1		BIT_U32(6)
+#define HISI_PTT_HEAD3_AR32_TV			BIT_U32(5)
+#define HISI_PTT_HEAD3_AR32_T			BIT_U32(4)
+#define HISI_PTT_HEAD3_AR32_TAG_13_10		GENMASK_U32(3, 0)
+#define HISI_PTT_HEAD3_AR32_IO_RSV2		GENMASK_U32(23, 8)
+
+/* Hisi PTT Header DW1/DW2/DW3 fields for Configuration Requests
+ *
+ * bits [   31:16    ][  15:8  ][    7:4   ][    3:0    ]
+ *      |-------------|---------|-----------|-----------|
+ * DW1  [Requester ID][Tag<7:0>][Last DW BE][First DW BE]
+ *
+ * bits [     31:16    ][ 15:12 ][    11:8   ][      7:2      ][ 1:0]
+ *      |--------------|---------|------------|----------------|----|
+ * DW2  [Destination ID][ RSV2  ][Ext Reg Num][Register Number][RSV1]
+ *
+ * bits [   31   ][       30:23        ][22][21][20][  19:16  ][   15:0   ]
+ *      |---------|--------------------|----|---|--|-----------|----------|
+ * DW3  [  RSV2  ][Destination Segment][DSV][TV][T][Tag<13:10>][   RSV1   ]
+ */
+#define HISI_PTT_HEAD1_CFG_REQ_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD1_CFG_TAG_7_0		GENMASK_U32(15, 8)
+#define HISI_PTT_HEAD1_CFG_LAST_DW_BE		GENMASK_U32(7, 4)
+#define HISI_PTT_HEAD1_CFG_FIRST_DW_BE		GENMASK_U32(3, 0)
+#define HISI_PTT_HEAD2_CFG_DST_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD2_CFG_RSV2			GENMASK_U32(15, 12)
+#define HISI_PTT_HEAD2_CFG_REG_NUM_EXT		GENMASK_U32(11, 8)
+#define HISI_PTT_HEAD2_CFG_REG_NUM		GENMASK_U32(7, 2)
+#define HISI_PTT_HEAD2_CFG_RSV1			GENMASK_U32(1, 0)
+#define HISI_PTT_HEAD3_CFG_RSV2			BIT_U32(31)
+#define HISI_PTT_HEAD3_CFG_DST_SEG		GENMASK_U32(30, 23)
+#define HISI_PTT_HEAD3_CFG_DSV			BIT_U32(22)
+#define HISI_PTT_HEAD3_CFG_TV			BIT_U32(21)
+#define HISI_PTT_HEAD3_CFG_T			BIT_U32(20)
+#define HISI_PTT_HEAD3_CFG_TAG_13_10		GENMASK_U32(19, 16)
+#define HISI_PTT_HEAD3_CFG_RSV1			GENMASK_U32(15, 0)
+
+/* Hisi PTT Header DW1/DW2/DW3 fields for Completion TLPs
+ *
+ * bits [    31:16   ][  15:13   ][12 ][   11:0   ]
+ *      |-------------|-----------|----|----------|
+ * DW1  [Completer ID][Cpl Status][BCM][Byte Count]
+ *
+ * bits [    31:16   ][  15:8  ][ 7 ][     6:0     ]
+ *      |-------------|---------|----|-------------|
+ * DW2  [Requester ID][Tag<7:0>][RSV][Lower Address]
+ *
+ * bits [       31:24       ][       23:16     ][15 ][ 14:6][5][4 ][   3:0    ]
+ *      |--------------------|------------------|----|------|--|---|----------|
+ * DW3  [Destination Segment][Completer Segment][DSV][ RSV ][TV][T][Tag<13:10>]
+ */
+#define HISI_PTT_HEAD1_CPL_COM_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD1_CPL_STA			GENMASK_U32(15, 13)
+#define HISI_PTT_HEAD1_CPL_BCM			BIT_U32(12)
+#define HISI_PTT_HEAD1_CPL_BYTE_CNT		GENMASK_U32(11, 0)
+#define HISI_PTT_HEAD2_CPL_REQ_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD2_CPL_TAG_7_0		GENMASK_U32(15, 8)
+#define HISI_PTT_HEAD2_CPL_RSV			BIT_U32(7)
+#define HISI_PTT_HEAD2_CPL_LO_ADDR		GENMASK_U32(6, 0)
+#define HISI_PTT_HEAD3_CPL_DST_SEG		GENMASK_U32(31, 24)
+#define HISI_PTT_HEAD3_CPL_COM_SEG		GENMASK_U32(23, 16)
+#define HISI_PTT_HEAD3_CPL_DSV			BIT_U32(15)
+#define HISI_PTT_HEAD3_CPL_RSV			GENMASK_U32(14, 6)
+#define HISI_PTT_HEAD3_CPL_TV			BIT_U32(5)
+#define HISI_PTT_HEAD3_CPL_T			BIT_U32(4)
+#define HISI_PTT_HEAD3_CPL_TAG_13_10		GENMASK_U32(3, 0)
+
+/* Hisi PTT Header DW1 fields for Message Requests
+ *
+ * bits [   31:16    ][  15:8  ][     7:0    ]
+ *      |-------------|---------|------------|
+ * DW1  [Requester ID][Tag<7:0>][Message Code]
+ */
+#define HISI_PTT_HEAD1_MSG_REQ_ID		GENMASK_U32(31, 16)
+#define HISI_PTT_HEAD1_MSG_TAG_7_0		GENMASK_U32(15, 8)
+#define HISI_PTT_HEAD1_MSG_CODE			GENMASK_U32(7, 0)
 
 enum hisi_ptt_pkt_type {
 	HISI_PTT_4DW_PKT,
-- 
2.33.0

