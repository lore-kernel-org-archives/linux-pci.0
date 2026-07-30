Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77D3AFAFF;
	Thu, 30 Jul 2026 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392852; cv=none; b=BX7AyK6OGnrZ5M8HBaM6bAEmz3JksuDusfirwFV8LDWORfzhVL1qp2VHl5shOLq3VDgftAgK+V8UBfrLaYgy/CU6ZNZY416COeTCLu5Fovmqd25V0pY8hBMrYHxpHimFHM5g0KtnPCLBOG+WpniDd/Th2o5NYtegtcN2JvljjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392852; c=relaxed/simple;
	bh=fnbuJy8YFKAuygbkxtd9cvAOfksj2wKbJfTIJSrEYCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vycoow5sppa7Fszfjyeoyw7eEW1l/kl/U7zbA3uPA1VZEaQLmUHZLDzEisaSxYa7J/KeTzd8nmexNfwTN5tCg6ADHZnTrEaPvllwtf83g/yRrxtq0tMPisdg7Kk7SC37RUVGwLtOzzzf08h+Zp5qYfrdaaFhE/64IbQWzBDSGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a9f9Mgq9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a9f9Mgq9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q1F245qQezDZ5rCXwhEsnhH1Zz5SLu6ydfX/1HeJj9k=;
	b=a9f9Mgq9p5R59tNJ75UG0VcRRwEco/g2Jxjqw5fxsBDvFR8bw5VdD6kRZgbY1qgA+F9qLPvh2
	19prZGB/qhArfmUVCyxQoj2BM94+86lcwJaUw0ctHNXvmc7D400SzikpZQN4Q2MmYonJAwoqUPZ
	xNw67ijbJJDFzDWE6rUnjfI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9fBp2QWvznTvp;
	Thu, 30 Jul 2026 14:17:54 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C01D4058E;
	Thu, 30 Jul 2026 14:27:21 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Jul
 2026 14:27:18 +0800
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
Subject: [PATCH v2 3/3] perf hisi-ptt: Fix spelling and abbreviation errors
Date: Thu, 30 Jul 2026 14:27:09 +0800
Message-ID: <20260730062709.534139-4-liusizhe5@huawei.com>
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

Fix spelling and abbreviation errors in the PTT packet decoder:
- HISI_PTT_FIELD_LENTH -> HISI_PTT_FIELD_LENGTH
- hisi_ptt_8dw_kpt_desc -> hisi_ptt_8dw_pkt_desc
- hisi_ptt_4dw_kpt_desc -> hisi_ptt_4dw_pkt_desc

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 20 +++++++++----------
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  2 +-
 tools/perf/util/hisi-ptt.c                    |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
index 5db44556fc4f..72a877fd7236 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
@@ -85,7 +85,7 @@ static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *de
 	dw = get_unaligned_le32(buf + pos);
 	printf(".");
 	color_fprintf(stdout, color, "  %08x: ", pos);
-	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++) {
+	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
 		byte = (dw >> (24 - i * 8)) & 0xFF;
 		color_fprintf(stdout, color, "%02x ", byte);
 	}
@@ -94,19 +94,19 @@ static void hisi_ptt_print_pkt(const unsigned char *buf, int pos, const char *de
 	color_fprintf(stdout, color, "  %s\n", desc);
 }
 
-static int hisi_ptt_8dw_kpt_desc(const unsigned char *buf, int pos)
+static int hisi_ptt_8dw_pkt_desc(const unsigned char *buf, int pos)
 {
 	int i;
 
 	for (i = 0; i < HISI_PTT_8DW_TYPE_MAX; i++) {
 		/* Do not show 8DW check field and reserved fields */
 		if (i == HISI_PTT_8DW_CHK_AND_RSV0 || i == HISI_PTT_8DW_RSV1) {
-			pos += HISI_PTT_FIELD_LENTH;
+			pos += HISI_PTT_FIELD_LENGTH;
 			continue;
 		}
 
 		hisi_ptt_print_pkt(buf, pos, hisi_ptt_8dw_pkt_field_name[i]);
-		pos += HISI_PTT_FIELD_LENTH;
+		pos += HISI_PTT_FIELD_LENGTH;
 	}
 
 	return hisi_ptt_pkt_size[HISI_PTT_8DW_PKT];
@@ -122,7 +122,7 @@ static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
 	dw = get_unaligned_le32(buf + pos);
 	printf(".");
 	color_fprintf(stdout, color, "  %08x: ", pos);
-	for (i = 0; i < HISI_PTT_FIELD_LENTH; i++) {
+	for (i = 0; i < HISI_PTT_FIELD_LENGTH; i++) {
 		byte = (dw >> (24 - i * 8)) & 0xFF;
 		color_fprintf(stdout, color, "%02x ", byte);
 	}
@@ -141,16 +141,16 @@ static void hisi_ptt_4dw_print_dw0(const unsigned char *buf, int pos)
 		      "Time", FIELD_GET(HISI_PTT_HEAD0_4DW_TIME, dw));
 }
 
-static int hisi_ptt_4dw_kpt_desc(const unsigned char *buf, int pos)
+static int hisi_ptt_4dw_pkt_desc(const unsigned char *buf, int pos)
 {
 	int i;
 
 	hisi_ptt_4dw_print_dw0(buf, pos);
-	pos += HISI_PTT_FIELD_LENTH;
+	pos += HISI_PTT_FIELD_LENGTH;
 
 	for (i = 0; i < HISI_PTT_4DW_TYPE_MAX; i++) {
 		hisi_ptt_print_pkt(buf, pos, hisi_ptt_4dw_pkt_field_name[i]);
-		pos += HISI_PTT_FIELD_LENTH;
+		pos += HISI_PTT_FIELD_LENGTH;
 	}
 
 	return hisi_ptt_pkt_size[HISI_PTT_4DW_PKT];
@@ -159,7 +159,7 @@ static int hisi_ptt_4dw_kpt_desc(const unsigned char *buf, int pos)
 int hisi_ptt_pkt_desc(const unsigned char *buf, int pos, enum hisi_ptt_pkt_type type)
 {
 	if (type == HISI_PTT_8DW_PKT)
-		return hisi_ptt_8dw_kpt_desc(buf, pos);
+		return hisi_ptt_8dw_pkt_desc(buf, pos);
 
-	return hisi_ptt_4dw_kpt_desc(buf, pos);
+	return hisi_ptt_4dw_pkt_desc(buf, pos);
 }
diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
index 333eee02b19d..3b349fcc24ae 100644
--- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
+++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
@@ -15,7 +15,7 @@
 #define HISI_PTT_8DW_CHECK_MASK		GENMASK(31, 11)
 #define HISI_PTT_IS_8DW_PKT		GENMASK(31, 11)
 #define HISI_PTT_MAX_SPACE_LEN		10
-#define HISI_PTT_FIELD_LENTH		4
+#define HISI_PTT_FIELD_LENGTH		4
 
 /* Header DW0 fields for 4DW format */
 #define HISI_PTT_HEAD0_4DW_TIME		GENMASK_U32(10, 0)
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index d6f48993fdd6..e73c57f9e8a4 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -42,7 +42,7 @@ static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf,
 {
 	uint32_t head;
 
-	if (len < HISI_PTT_FIELD_LENTH)
+	if (len < HISI_PTT_FIELD_LENGTH)
 		return HISI_PTT_4DW_PKT;
 
 	head = get_unaligned_le32(buf);
-- 
2.33.0

