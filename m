Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80E472535;
	Thu, 27 Aug 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839512; cv=none; b=rqEuN2xu5w1uh9wubt0hvj8kyK6rtA722AxhwLdqVwZMvAf7sazgN7UpyK6ws9wYkPjLV7+GruPtzh1M3ANYAVMcZ1Dt5TGxnf49/0NnOcowroE/SSr2ZnT1UDEg6vP2v+FSxc3lVeCt0NtyVf9mW33LpJ6vnxrC2rczLdeXxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839512; c=relaxed/simple;
	bh=K6ZHeCb60KJn0PKvx4uNQ2zKEyvrslelFavHYC2mhuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn5KXcyO7Lhmy3z2bGPXVTuJ2fThryNzaYatY1lPe5+iG4GOHUbjSNULXcCRYFw+IWOmGCONO0DbIJ61OWha+wVecrgiu7N544dxSsKGdOqjrMoyaf7LqTxJ4iClQA7722orYhBVaURRNcgm77Dqz39/ECmQsrPyez22XHWEGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=47m8YGoF; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="47m8YGoF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kR7Pr045dncOw5r2g9mgP74tU4Wr0LOiRZU5LwjNSgk=;
	b=47m8YGoFpQk3DVXkbCqiLgXE9NoPpwAuEYRSmOtnkT9s4dbQjQ2hl4JW3PLVwYpUHUTEwvACs
	jImxrvFPLgq/s+r5AsDrH5ORKMGwj1NkMD9hSSjsx9md0Nc726HMuu482VhVKGC6ceusx/AXRFA
	AeD6VF3t1Pl0KB7Lf3vAJUI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hW30W2JbCzcb4c;
	Thu, 27 Aug 2026 21:54:19 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E5D14058C;
	Thu, 27 Aug 2026 22:04:54 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 22:04:51 +0800
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
Subject: [PATCH v2 4/8] perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
Date: Thu, 27 Aug 2026 22:04:38 +0800
Message-ID: <20260827140442.2031128-5-liusizhe5@huawei.com>
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

Merge the printing of HEAD0 for both 4DW and 8DW TLP headers into
hisi_ptt_print_head0(). This unifies the entry point and makes it
easier to add HEAD1/HEAD2/HEAD3 field parsing in subsequent patches.

Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 56 +++++++++++--------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 23ae99f33c9f..00bd9309df68 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -108,6 +108,33 @@ static void hisi_ptt_print_pkt(struct hisi_ptt_pkt_buf *pkt_buf,
 	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
 }
 
+static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
+{
+	const char *color = PERF_COLOR_BLUE;
+	uint32_t dw;
+
+	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
+	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
+
+	if (pkt_buf->pkt_type == HISI_PTT_4DW_PKT)
+		color_fprintf(stdout, color,
+			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
+			      "Format",
+			      FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw),
+			      "Type", FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw),
+			      "T9", FIELD_GET(HISI_PTT_HEAD0_4DW_T9, dw),
+			      "T8", FIELD_GET(HISI_PTT_HEAD0_4DW_T8, dw),
+			      "TH", FIELD_GET(HISI_PTT_HEAD0_4DW_TH, dw),
+			      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
+			      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
+			      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
+	else
+		color_fprintf(stdout, color, "  %s\n",
+			      hisi_ptt_8dw_pkt_field_name[HISI_PTT_8DW_HEAD0]);
+
+	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
+}
+
 static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
@@ -119,39 +146,22 @@ static int hisi_ptt_8dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 			continue;
 		}
 
+		if (i == HISI_PTT_8DW_HEAD0) {
+			hisi_ptt_print_head0(pkt_buf);
+			continue;
+		}
+
 		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_8dw_pkt_field_name[i]);
 	}
 
 	return hisi_ptt_pkt_size[HISI_PTT_8DW_PKT];
 }
 
-static void hisi_ptt_4dw_print_dw0(struct hisi_ptt_pkt_buf *pkt_buf)
-{
-	const char *color = PERF_COLOR_BLUE;
-	uint32_t dw;
-
-	dw = get_unaligned_le32(pkt_buf->buf + pkt_buf->pos);
-	hisi_ptt_print_raw_record(pkt_buf->pos, dw);
-
-	color_fprintf(stdout, color,
-		      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
-		      "Format", FIELD_GET(HISI_PTT_HEAD0_4DW_FORMAT, dw),
-		      "Type", FIELD_GET(HISI_PTT_HEAD0_4DW_TYPE, dw),
-		      "T9", FIELD_GET(HISI_PTT_HEAD0_4DW_T9, dw),
-		      "T8", FIELD_GET(HISI_PTT_HEAD0_4DW_T8, dw),
-		      "TH", FIELD_GET(HISI_PTT_HEAD0_4DW_TH, dw),
-		      "SO", FIELD_GET(HISI_PTT_HEAD0_4DW_SO, dw),
-		      "Length", FIELD_GET(HISI_PTT_HEAD0_4DW_LEN, dw),
-		      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
-
-	pkt_buf->pos += HISI_PTT_FIELD_LENGTH;
-}
-
 static int hisi_ptt_4dw_pkt_desc(struct hisi_ptt_pkt_buf *pkt_buf)
 {
 	int i;
 
-	hisi_ptt_4dw_print_dw0(pkt_buf);
+	hisi_ptt_print_head0(pkt_buf);
 
 	for (i = HISI_PTT_4DW_HEAD1; i < HISI_PTT_4DW_TYPE_MAX; i++)
 		hisi_ptt_print_pkt(pkt_buf, hisi_ptt_4dw_pkt_field_name[i]);
-- 
2.33.0

