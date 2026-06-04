Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5D3E0741;
	Thu,  4 Jun 2026 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559420; cv=none; b=XuUHv22GGNzqzzW+TlNbe0b4UzuanPbDLBqco9jhsoMIF0v/iEWJQAUz/OeBQiSovPFbWDw+wBA1McGVbm+/qnarz9cLo0tnu52mBGvUgoEgB15WlZsfHQe7cJPGFFVYYcjK2cGjKz7H1aEPAESERA8Tjh7ypUP29isJpg6DjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559420; c=relaxed/simple;
	bh=Pp2eFYuTRLDaoFJUVc4jhuqX0sBsanw7CwsKccjiS14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPC9mxVHOzduoaH4PvqOcdJTWUm1tgRnJCk9UoVAJZ/IROpi6QJkzbDCqkFU5x4EvH68CULjWC2nuH1CucmnS1BSEt7/PEucZPaOjR3fV1yeeyvXjE7rBs6xStuWU20rKWrROgXjA0dAmnRUUYw0vU5Ot9uhZmFMH8d3+9esWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=o38pD0R3; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="o38pD0R3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UzphR8+an8ofSoVAEbaiJxbsv0Yp/2ccL+dSFmI1ONo=;
	b=o38pD0R30nKR6wN4Qoi76TNS9KE4m17u/NmM94Y4Noo23/L6JCyPeA4UBGM/0nIoQa0g7/eXd
	xkZILvwvAYSLGeJ2XaUy1Llf5rhX/kJNQcCJk5lnFbu9Mr/r5sfEXK+bj3bFHSUkjvF3wlgJdaz
	2kg1gYf7in1uuhmlzWHI3dA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gWGk70HsRzKmZk;
	Thu,  4 Jun 2026 15:42:23 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0882340572;
	Thu,  4 Jun 2026 15:50:16 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 15:50:15 +0800
Received: from huawei.com (10.50.163.32) by kwepemn200012.china.huawei.com
 (7.202.194.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 15:50:14 +0800
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
Subject: [PATCH 09/10] perf hisi-ptt: Add field-level parsing for header DW2/DW3
Date: Thu, 4 Jun 2026 15:50:04 +0800
Message-ID: <20260604075005.2219785-10-liusizhe5@huawei.com>
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

Add detailed field parsing for TLP header DW2 and DW3 based on the
message type parsed from header DW0:

- HEADER DW0: fields printed in 4DW format, printed as generic label
  in 8DW format for compatibility.
- HEADER DW1: printed with the field name for both 4DW and 8DW formats.
- HEADER DW2: fields printed for MWr/Msg/Atomic/IO TLPs, generic label
  for others.
- HEADER DW3: fields printed for Completion and Configuration TLPs,
  generic label for others.

This gives users more structured information when analysing PTT
trace data.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 161 +++++++++++++++++-
 1 file changed, 152 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 59ab8ec3a03d..46f11d5719ac 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -38,6 +38,21 @@
  *    DW1 [                     Header DW1                            ]
  *    DW2 [                     Header DW2                            ]
  *    DW3 [                     Header DW3                            ]
+ *
+ * Header DW2 for MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr is like:
+ *   bits   [   31   ][     30:23      ][22][21][20][  19:16  ][   15:0   ]
+ *          |---------|----------------|----|---|--|-----------|----------|
+ *   fields [Reserved][Request Segment][RSV][TV][T][Tag<13:10>][Header DW2]
+ *
+ * Header DW3 for CfgRd0/CfgWr0/CfgRd1/CfgWr1 is like:
+ *   bits   [   31   ][       30:23        ][22][21][20][  19:16  ][   15:0   ]
+ *          |---------|--------------------|----|---|--|-----------|----------|
+ *   fields [Reserved][Destination Segment][DSV][TV][T][Tag<13:10>][Header DW3]
+ *
+ * Header DW3 for Cpl/CplD/CplLk/CplDlk is like:
+ *   bits   [       31:24       ][       23:16      ][15][  14:6   ][5][4][   3:0    ]
+ *          |--------------------|------------------|----|---------|--|---|----------|
+ *   fields [Destination Segment][Completer Segment][DSV][Reserved][TV][T][Tag<13:10>]
  */
 
 enum hisi_ptt_8dw_pkt_field_type {
@@ -127,6 +142,45 @@ union hisi_ptt_field_data {
 		uint32_t type : 5;
 		uint32_t format : 3;
 	} dw0_8dw;
+	/*
+	 * Header DW2 for MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr TLPs.
+	 * Affects both 4DW and 8DW format.
+	 */
+	struct {
+		uint32_t header_dw2 : 16;
+		uint32_t tag : 4;
+		uint32_t t : 1;
+		uint32_t tv : 1;
+		uint32_t rsv : 1;
+		uint32_t request_segment : 8;
+		uint32_t reserved : 1;
+	} dw2_mixed;
+	/*
+	 * Header DW3 for CfgRd0/CfgWr0/CfgRd1/CfgWr1 TLPs.
+	 * Affects both 4DW and 8DW format.
+	 */
+	struct {
+		uint32_t header_dw3 : 16;
+		uint32_t tag : 4;
+		uint32_t t : 1;
+		uint32_t tv : 1;
+		uint32_t dsv : 1;
+		uint32_t destination_segment : 8;
+		uint32_t reserved : 1;
+	} dw3_cfg;
+	/*
+	 * Header DW3 for Cpl/CplD/CplLk/CplDlk TLPs.
+	 * Affects both 4DW and 8DW format.
+	 */
+	struct {
+		uint32_t tag : 4;
+		uint32_t t : 1;
+		uint32_t tv : 1;
+		uint32_t reserved : 9;
+		uint32_t dsv : 1;
+		uint32_t completer_segment : 8;
+		uint32_t destination_segment : 8;
+	} dw3_cpl;
 	uint32_t value;
 };
 
@@ -211,6 +265,85 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
+static void hisi_ptt_print_head1(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *color = PERF_COLOR_BLUE;
+	union hisi_ptt_field_data dw;
+
+	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
+	color_fprintf(stdout, color, "  %s\n",
+		      pkt_buf->pkt_type == HISI_PTT_4DW_PKT ?
+		      hisi_ptt_4dw_pkt_field_name[HISI_PTT_4DW_HEAD1] :
+		      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD1]);
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
+static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *color = PERF_COLOR_BLUE;
+	union hisi_ptt_field_data dw;
+
+	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
+
+	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
+	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Reserved", dw.dw2_mixed.reserved,
+			      "Request Segment", dw.dw2_mixed.request_segment,
+			      "RSV", dw.dw2_mixed.rsv, "TV", dw.dw2_mixed.tv,
+			      "T", dw.dw2_mixed.t, "Tag", dw.dw2_mixed.tag,
+			      "Header DW2", dw.dw2_mixed.header_dw2);
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
+	union hisi_ptt_field_data dw;
+
+	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
+
+	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CPL)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Destination Segment",
+			      dw.dw3_cpl.destination_segment,
+			      "Completer Segment", dw.dw3_cpl.completer_segment,
+			      "DSV", dw.dw3_cpl.dsv,
+			      "Reserved", dw.dw3_cpl.reserved,
+			      "TV", dw.dw3_cpl.tv, "T", dw.dw3_cpl.t,
+			      "Tag", dw.dw3_cpl.tag);
+	else if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_CFG)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Reserved", dw.dw3_cfg.reserved,
+			      "Destination Segment",
+			      dw.dw3_cfg.destination_segment,
+			      "DSV", dw.dw3_cfg.dsv, "TV", dw.dw3_cfg.tv,
+			      "T", dw.dw3_cfg.t, "Tag", dw.dw3_cfg.tag,
+			      "Header DW3", dw.dw3_cfg.header_dw3);
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
@@ -222,12 +355,24 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
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
@@ -235,12 +380,10 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 
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
-- 
2.33.0

